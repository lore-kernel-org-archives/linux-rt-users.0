Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D51B86D2
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333857; cv=none; b=gdRK8Yz59dbNReiQxP48e6ylwHI2gkW2V7xyU3389ETDuOHsPtClSuDBFTdK17bi8C1GoCl0DlRxdUI5NobqAtS8q6ZqLggJrR4Ykvxkl0P+Cfn8b3HlDnAK2J7pi5gNoXfI8/BROGkX/SABNDWhCDE/K6a0AzrGcQow0w3QmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333857; c=relaxed/simple;
	bh=trDNnO25g1OaW9xSC98yAoyESIGZXWjCYDg+ybYdn8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyhrqDuTHZx0E+JleU6oQ4oVdE61cOYxqcqphEeDJMxUih9I/Y0keI5XmG1UWBJJmzRPuW2lHzV5fwxJcmxiKhFl0U84ein7oAzsAs1wdlp538Ge4Uuw6NjJG33CsWmL8TCdg3G7G91D0MMgtWoqPC9omACycnZmHEdngvb9Xjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A7FC116B1;
	Thu, 18 Jul 2024 20:17:35 +0000 (UTC)
Date: Thu, 18 Jul 2024 16:17:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org,
 debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com,
 linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <20240718161734.3c2d3850@rorschach.local.home>
In-Reply-To: <qhv54n4limuh335borcwdnailiuecez3jlie35zoo7vgerix4q@cqtetxuc6a3b>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
	<20240718115704.0cd768bc@rorschach.local.home>
	<436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
	<20240718152447.42244f98@rorschach.local.home>
	<qhv54n4limuh335borcwdnailiuecez3jlie35zoo7vgerix4q@cqtetxuc6a3b>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 14:34:41 -0500
Andrew Halaney <ahalaney@redhat.com> wrote:


> Heh, exactly why I made a "reproducer" for the printk/RCU side of the
> splat with linux-rt-devel before reporting.
> 
> So my takeaway is that printk is not considered safe to use in all
> contexts, including during SMP bringup (because RCU's at play and not
> yet ready to be used on those CPUs). So if we do printk for reasons we
> can't control (say some firmware problem causing an exception) and try
> to print you could get the RCU warning about printk/nbcon usage in
> addition to the actual error, and that's just something to accept.

Well, in most cases people don't run a debug kernel in production and
if this printk was triggered in production, that warning would not show
up (it's only there when lockdep is enabled).

> 
> Ideally though we don't printk() in those situations... so if its badly
> behaving code calling printk() that's a different story.

Right. printk() does get called in locations it shouldn't simply due to
a bug happening. But then, it's just a best effort to get information
to the user.

> 
> Let me know if you think that recap is bogus.

I think you summarized it well.

-- Steve
