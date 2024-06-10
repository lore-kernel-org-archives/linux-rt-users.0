Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06ED13F458;
	Mon, 10 Jun 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035020; cv=none; b=skx72BHklSJvIcuKBhFky+uEjNjLt3OajTDIMMJy8YhMVIjbtmWuiPcop0C/kDWVIipAPEpUJyaE42/kdr5iOsrbfg0oix71NZtUQQvGnvFGDBizQ7ubr8ErqKgifJne3ILHI1mwB6zvRJol9S0+kmXXFj9gHudOYF3hT0dVWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035020; c=relaxed/simple;
	bh=BIUzr0ZExg6jPnSE74d71eTmn3fIa3SvQfQ4xEceAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ov4HMEcX7Q3NSzgNXEBf5k0d1S11FdbECPOzW32Sp06CmMLAaykLD8sIb95E6rSvxTxrRZOssW6ku+zTUz3bjf20mSGy3t5RnODFKqoam0r6Lo32kccskuRJ0pvDb9tO0IZdoF/YCJoHrLbRBayrVM0gAxqhE2PJfY3dRk75qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67034C2BBFC;
	Mon, 10 Jun 2024 15:56:59 +0000 (UTC)
Date: Mon, 10 Jun 2024 11:56:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users
 <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] ring-buffer: Fix a race between readers and resize
 checks
Message-ID: <20240610115658.27623de4@rorschach.local.home>
In-Reply-To: <8f5dca5a-330d-4258-8e01-0734ffda361d@suse.com>
References: <20240517134008.24529-1-petr.pavlu@suse.com>
	<20240517134008.24529-3-petr.pavlu@suse.com>
	<20240520095037.33a7fde6@gandalf.local.home>
	<2b920bab-23a2-4a8d-95c2-b69472d38373@suse.com>
	<20240527194356.5078b56f@rorschach.local.home>
	<8f5dca5a-330d-4258-8e01-0734ffda361d@suse.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 10:29:03 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> Another option could be to try traversing the whole list in smaller
> parts and give up the reader_lock in between them. This would need some
> care to make sure that the operation completes, e.g. the code would need
> to bail out if it detects a change on cpu_buffer->pages_read.

I think I like this approach the most. Perhaps even have a counter that
gets incremented everything a new reader page is taken. And if it
detects that, it restarts the check?

To prevent a DOS, we restart 3 times at most, and then just say "the
list is OK" and exit.

So basically, we release the lock within the loop per each sub-buffer,
and then check if the reader touch it when reacquiring the lock.

-- Steve
