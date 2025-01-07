Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CE1E0B7C;
	Tue,  7 Jan 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250972; cv=none; b=ZPRQ1GNhu4AXSrt1c24hvOByK8+T6lVu/kKJL/sH98FmOCjln/Qw33H4+LG9Or/SHJjgCB3ISFRqQjs0SZ1HHVee4Yw3uhclAb/EeOeUqKDf5SofIR0n18PXev3jarjwe2pc8wxawU7DLhVT9jtZOA76drw22hMWjSSv+ZyzWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250972; c=relaxed/simple;
	bh=vSp+fhNJx7hcAWw5M6HPzbQqsL3TPjKtX9nO1km2Fs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5j+nM2RDbwbzXNUnfaaXGgRbp5+cRNoVzKMyecEMhScYjq1XFGbmdTfz+jOpcoRSh6lVZwTi0fygrPxuG4nDTcft34TBhVxIfKKVFWTlzK9IgLWX6ZgSfFMqtulvsPPkq0qubyalTxpD10I7XrImtfOJu6K9XpxGafgq6FkO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9ikX6Jw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jM9IXPU6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9ikX6Jw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jM9IXPU6"
Date: Tue, 7 Jan 2025 12:56:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736250967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24gVf7tG/7zFXxMSeeWEt175mRZT2bbtN+ldqrE2Be8=;
	b=M9ikX6Jw0SAd6j6flhMcgyKR1487gztDffuAkIyZk4pBf0peAJKBK/3XfiyK+FVOEr3M/O
	Uic0yCFsZb9qAqGql5LRxqzVxb/8xLB7F3quA5JhVLVQm0YHqh/ScBA0LUu/tE1h5eTOr9
	dcrA35Zj/0nXXOh/GDHMWezLlD+e94r1gRlekT66o8HbFd9X8ZqHSIbI/BHxQ2jEV94y30
	fiKa3zmXIO48ZS1dE49jQXRehtbzUgp13DQnxtW7i5KQ6aIRYSg/dn7CvnzUk5QG2EWH4h
	vHvNgrz7prGbcaQoDdhV5v0VKGjf5tZ5RFq0+Dz+T87U3Nbyh5s5qALh/AJRBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736250967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24gVf7tG/7zFXxMSeeWEt175mRZT2bbtN+ldqrE2Be8=;
	b=jM9IXPU68JkcdgaRhlA6nHJEUlXxpuZiXLB7a7FT3zk4OokcHe3dQ4Pwqw0PuwFDL4s7C7
	La7hHj8BUpuXQDAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Robert Joslyn <robert_joslyn@selinc.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
Message-ID: <20250107115606.q67--i0f@linutronix.de>
References: <20241226191238.2559880-1-robert_joslyn@selinc.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241226191238.2559880-1-robert_joslyn@selinc.com>

On 2024-12-26 11:12:38 [-0800], Robert Joslyn wrote:
> This branch is needed to allow preemptible IRQs to be scheduled,
> otherwise the kernel hangs during boot on my e300 based platforms.
> This branch is needed for both CONFIG_PREEMPT and CONFIG_PREEMPT_RT,
> so broaden the check to CONFIG_PREEMPTION, which is selected by both.
> 
> This was previously set to CONFIG_PREEMPTION, but was reverted as part
> of removing LAZY_PREEMPT support.

I remember I pointed this out while Shrikanth posted the preempt-lazy
patches but didn't realize that I need this in RT tree, too.

The lazy-preempt patches for powerpc were merged upstream, I am going to
pull them into the v6.6-series.
I am going to Cc you, hopefully you can confirm that it is working.

> Fixes: b33022a48c79
> Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>
> ---
>  arch/powerpc/kernel/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index af62ec974b97..970039af8e92 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -396,7 +396,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>  		/* Returning to a kernel context with local irqs enabled. */
>  		WARN_ON_ONCE(!(regs->msr & MSR_EE));
>  again:
> -		if (IS_ENABLED(CONFIG_PREEMPT)) {
> +		if (IS_ENABLED(CONFIG_PREEMPTION)) {
>  			/* Return to preemptible kernel context */
>  			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>  				if (preempt_count() == 0)

Sebastian
