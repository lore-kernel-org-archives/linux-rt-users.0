Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466A8F5C;
	Wed, 26 Jun 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413450; cv=none; b=TaVajqeUsi0QWA74EuUTY005iRCEQjeOvfmlYX14zmUecnbz3/2ugA4IqfZLUrEvMSdS/ZNENixeScOCj5YQKWRSIZlvHntxbXMdg84fSGv/uPlEE2nSCjc87Aox536spIm+Pe8jYi1aGjEY2wDVyVx3fBTQRjiNy2dxbaqPUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413450; c=relaxed/simple;
	bh=ADCRnSIW8Y2Q8+ZZVRqQZbbkuphzK59nx6Z6uoam+ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oh+LE+vhV/QpdoZzYsbF1KyYZme03rZEbOY54ViL5qeB+jnjF/hPou342FeQzTu4D/pdh4z6eXlkJafkIAnMWPzuWUXbNghwL4LJW2oanAAZV3F504QqGIwlSDzGMOMQzn/1jn5SSg/zkq/psQ+x8H8/uR5RU1SiiJK6RSedYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CB0C116B1;
	Wed, 26 Jun 2024 14:50:48 +0000 (UTC)
Date: Wed, 26 Jun 2024 10:50:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Chen <chensong_2000@189.cn>
Cc: John Ogness <john.ogness@linutronix.de>, Andrew Halaney
 <ahalaney@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
 pmladek@suse.com, senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, williams@redhat.com, jlelli@redhat.com
Subject: Re: a question about how to debug this case in ftrace
Message-ID: <20240626105046.7ad9299e@rorschach.local.home>
In-Reply-To: <7252f93a-ef60-49f8-ae93-73d269cc62f8@189.cn>
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
	<6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
	<xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
	<4d198032-d4e1-4a84-8f56-1b31157e9323@189.cn>
	<e6b0ba9e-e8f6-4c42-9f63-e3b67d7edbf0@189.cn>
	<8734p0jhdc.fsf@jogness.linutronix.de>
	<7252f93a-ef60-49f8-ae93-73d269cc62f8@189.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 16:26:05 +0800
Song Chen <chensong_2000@189.cn> wrote:

> not really, sounds like it meets my expectation of merging logs either 
> way, "printk:console ftrace event" in cmdline? I searched it in code or 
> google, no luck.

Try adding:

  trace_event=console

-- Steve
