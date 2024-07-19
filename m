Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B12C80
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375736; cv=none; b=QPAx5DxuulFzqx4Zk76xaMRcPYrP299Cc+bY0+q51/twjNNs16ddQ7gdnEv6Wa93SwW2Nqs5JRsUat9ytULmuzlH3AMh3rgKpE6lFdcUbZ2xT64gEqePvWmWzknEytN/2fjNDz00SGabmwuFMNIrO3U8X4bBC+vLOrS0qiTqTYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375736; c=relaxed/simple;
	bh=ZF4/DlqSLJKXsctb7kGKEjrkGNfbqaIAWjZa+bePnFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sWe/b26Dw50qR2FngdDSZKUnXUePBgfMv8AWEsY6aicuM0o3B3vqp++YLg3M8LpJdgEJjHm7F5x6Bd/dr75hgQBgqb1y1LR5jPIoiom8ETrVh8fuTvKCJ3WrGVRQ/d+6GnUMPEn2NnqR5BmO9HvLGfdgAhLUqV4tgZNS/TpjXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T8jzuTJI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=crbYPDAf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T8jzuTJI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="crbYPDAf"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721375725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF4/DlqSLJKXsctb7kGKEjrkGNfbqaIAWjZa+bePnFs=;
	b=T8jzuTJIBehmDd5bUQ+/X8N6IlP86DXRnjtWn9t+dedhfODKeiITxsxIBYyZSdi10XG7/M
	FM4QZIgZGNsHlFmP9Ag6fRFM9qwySd0YyLwBnBWKRa08H9N2MzjT+OH1xcd82bw94Vqjor
	qbB4iT0m+y2UFNZmP8qkSy6vGhmlpgFTmypeuAP4sNjjSByVuC9cGsOjxd0/R/5ajNtfCW
	O+XLDriokzLsbNRmSmrcbbaqRlNOOeDTIn+E96ahIu4dwWX9RymfuR0Ln9m2E9WDJhtENH
	jox1fpjirCcwRkJ8VLoXhVFkyoITAgML9/w3rDFS9twiit1fgG7HN7R2BQZFXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721375725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF4/DlqSLJKXsctb7kGKEjrkGNfbqaIAWjZa+bePnFs=;
	b=crbYPDAfsEBm6zOXTT3jUuf8gOqgNpy5qNC7Wv3310QD5RtVXV2UHhN4nABo/XKiSwYdge
	E+VACRZEc/KCCoAg==
To: Andrew Halaney <ahalaney@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: pmladek@suse.com, senozhatsky@chromium.org, debarbos@redhat.com,
 williams@redhat.com, jlelli@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
In-Reply-To: <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
 <20240718115704.0cd768bc@rorschach.local.home>
 <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
Date: Fri, 19 Jul 2024 10:01:25 +0206
Message-ID: <87cyn9lssy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-18, Andrew Halaney <ahalaney@redhat.com> wrote:
> I'll be honest, I only considered this from a printk() point of view
> so far and pretty much ignored the original splat (as someone else is
> looking at that). Here's the original splat from a centos kernel, I
> have yet to look into it other than "we took an exception prior to RCU
> coming online for this CPU"

Thanks for posting the splat. This is indeed a printk()
issue. vprintk_emit() or nbcon_wake_threads() need to be aware of the
RCU state and act appropriately. I will look into this.

> and me naively thinking that printk() should work everywhere.

Your thinking is not naive. It is correct (for PREEMPT_RT). printk()
stores messages locklessly into its ringbuffer and must work in all
cases (including NMI and scheduler). And AFAIK it does.

However, printk() is also responsible for reliably triggering or
performing console printing. This separate responsibility is tricky. For
PREEMPT_RT the problem is supposed to be solved. Obviously it still has
some issues, so thank you for the report.

For PREEMPT_RT, if you can put a printk() anywhere after the Linux
banner and cause a problem, the printk-folks need to know about it.

John Ogness
