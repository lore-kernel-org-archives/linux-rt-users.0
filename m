Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810CE18E20
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415442; cv=none; b=vFVYFxW6GlyT5KJCiQv2bdrWuSyfEdiT8oATpUjzgrxSgVlZ4VyEN0dOr0GGNvIzUGEzZFPeo32Fy5PZFvMPhkoU3wiuS2QXYThLJrEu74tooV1AdV31dAkH5e2tsfXULLmzSb5Clo8/Gjen9BKqhUtKJWG4n9R/y+HWNyANWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415442; c=relaxed/simple;
	bh=R4FzRLpHM7YxZ2t9eJxKGQP44uyBtnDDoTcCAV8wIR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXGmIqLUEsidlqMmdX2fU6VzMWkVeFPI7hxHjFefoKuVfDUL5q0yGGL+H6yrI961umNNxXZtJ16KyGRpe8G4QdLkqNO+5sI1m+5r3qsFJCtJJzRgxrpjlMUhh6R1DbV0LEuxMSs9CrbeIicfTdr4Kcl+7t1Un0x/Mthh4ROGNj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GLtspdbN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GLtspdbN"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d44550adb7so660340a12.2
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Dec 2024 22:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734415439; x=1735020239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o4NR0+WElJKju+9BlVtYiLLVwaHTSK0lbhWJBReR1E=;
        b=GLtspdbNgRzNCMhMhnuLQ0MFmR8BR6XK/1Szvf3Yy+6Q/ZNpLijfn87g+s/NR8itUd
         c3r11Mi8vU2Dn6+c0oji2o9CsRKVNQ7eoGxkkzOcMHcic4B8OgaInPHik1QIu0sHtcr+
         CHejLwxfezp8kpMyMrii5Kwd8MgBJI1Yv8NAxwEz2xqnmA7r52yROd1Z6btuChXg7ndk
         5A8MQYB6Q65qoxsYw+ofefG0qw7bjVpJAQJZ7H1aSDXdk/7wjBsPdss4xhew843UKqfX
         bVFvGlO9LqM+IyZaWZAZrLMcZdtPu2T7TeuDm/aoUvz2ka8ZwWWSxe8ieCwrpg5WTaPA
         DMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734415439; x=1735020239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o4NR0+WElJKju+9BlVtYiLLVwaHTSK0lbhWJBReR1E=;
        b=ZO+CtpA/DY+deq/b4n4drd8faJBHJEUFXD6u3h0xyT+FpQjGEKarI92swcs+GVgrS/
         +972glN2iCLfkGLlbdQriKqYIK+XYVUtDRbv1i9pxoCfW3xK8pIdxOhsgOGIrM96KYne
         ce1RMdXMQIWqffmF2/vut9SJjGN4QldznXImdKuleQqt1j5MXlo6CBjdN4vEGTnyKrAU
         fjR+ZJnKEqCNu19JZC47+TriUz7JfqQeE7douIRhg+SSI9rTmsNm1lD2+76DUv1mOhml
         fq4qrkJ9p6RUcXBK+S9S8iXnmaj8JLocSXSY41O2MalzQeD76VMVxxOqU8inGblLsKl5
         c23g==
X-Gm-Message-State: AOJu0Yxbrg5p2WPUwankIb6Jm8z9T1x7gX20vs6ggUmjzoQ1IzVK2KgM
	+qWKOhKRgDA4cmA1SzS6jMsmPYRMJ/geCQti0dLi4X1L4/wXXD4IRa+uhJZmTE2lQFW1/+lziFp
	f
X-Gm-Gg: ASbGncvJIBR95IiE4PKJrlePIrskyozDMzOHjb1dJSmUxBLC3iWHKgnMCUsxC+VE85N
	vQATpYgzF/XzLOIMcrCQeuWG50HBqQzrm4Ns5wrqo52CYGtZTKfbWDcgtZF9HECBTsnzrqFygVs
	JEKQDKcxANzY+r6ujQshvJqRzFKcIfwHUA/XRMmXNkc1NBmzvG3sCeCBxV//e9Xi5sMhYaOCsuO
	NYIUpKMpz6djIJI+HdNg3EvLxHU1RQ6H43RhlY9
X-Google-Smtp-Source: AGHT+IG8cf9hLiSuhkFnZZaNSGtdagvgFkgGRfo0tIRBexPFUJwYLvxn1j6rBjdRAM3K66yipIkm8g==
X-Received: by 2002:a05:6402:50cc:b0:5cf:f1fd:c688 with SMTP id 4fb4d7f45d1cf-5d63c2e81f5mr5299391a12.1.1734415438718;
        Mon, 16 Dec 2024 22:03:58 -0800 (PST)
Received: from mordecai.tesarici.cz ([213.235.133.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab525fsm3907001a12.14.2024.12.16.22.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:03:58 -0800 (PST)
Date: Tue, 17 Dec 2024 07:03:53 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Lazy preemption on arm64
Message-ID: <20241217070353.352d9a02@mordecai.tesarici.cz>
In-Reply-To: <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
	<Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 19:04:43 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Dec 16, 2024 at 07:04:51PM +0100, Petr Tesarik wrote:
> > Hi all,
> > 
> > what is the plan for implementing PREEMPT_LAZY on arm64?
> > 
> > There used to be RT patch series which enabled lazy preemption on
> > arm64, but this architecture was "sacrificed" in v6.6-rc6-rt10, as
> > collateral damage of switching to PREEMPT_AUTO.
> > 
> > IIUC lazy preemption is currently implemented only for architectures
> > with CONFIG_GENERIC_ENTRY, but there is no inherent dependency on it.
> > So, is the plan to convert arm64 to GENERIC_ENTRY (and then get
> > PREEMPT_LAZY for free), or is somebody working on CONFIG_PREEMPT_LAZY
> > for arm64 without that conversion?  
> 
> I don't think there's an agreed upon plan either way.

Thanks for confirmation. Being a newcomer to RT, I wasn't sure.

> Jinjie Ruan has been looking to move arm64 over to GENERIC_ENTRY:
> 
>   https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@huawei.com/

Thank you for the link.

> AFAICT, the only bits that we get "for free" from GENERIC_ENTRY would be
> the logic in raw_irqentry_exit_cond_resched() and
> exit_to_user_mode_loop(), and all we'd need to enable this on arm64
> as-is would be as below.

Yes, that's also my understanding.

> ... so how important is this?

For whom? For my work, this is very important. ;-)

We have decided to upgrade RT to v6.12 for the next SUSE product (so we
can finally get rid of many out-of-tree patches), but we are now facing
a regression on arm64. Since we generally follow an upstream-first
policy, adding an out-of-tree patch like below is undesirable (but not
impossible if there is no better alternative).

It seems to me that the conversion to generic entry is going to happen,
but the current patch series (v5) may still have issues (many changes
from v4 and no review yet), so we'll have to accept some divergence
from mainline...

Thank you for sharing your insight!

Petr T

> Mark.
> 
> ---->8----  
> From 16ae3c84d8e1691fe670dbfb4c643cab4fa2065f Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 16 Dec 2024 18:32:44 +0000
> Subject: [PATCH] HACK: arm64: enable PREEMPT_LAZY
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/thread_info.h | 12 +++++++-----
>  arch/arm64/kernel/entry-common.c     |  2 +-
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 100570a048c5e..7926bc78a1c46 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -39,6 +39,7 @@ config ARM64
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> +	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PTE_DEVMAP
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_HW_PTE_YOUNG
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 1114c1c3300a1..a2125407901ed 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -59,11 +59,12 @@ void arch_setup_new_exec(void);
>  
>  #define TIF_SIGPENDING		0	/* signal pending */
>  #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
> -#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
> -#define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
> -#define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
> -#define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
> -#define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
> +#define TIF_NEED_RESCHED_LAZY	2	/* Lazy rescheduling needed */
> +#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
> +#define TIF_FOREIGN_FPSTATE	4	/* CPU's FP state is not current's */
> +#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
> +#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
> +#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>  #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
>  #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>  #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> @@ -85,6 +86,7 @@ void arch_setup_new_exec(void);
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
>  #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index b260ddc4d3e9a..7993fab0cab4c 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
>  	do {
>  		local_irq_enable();
>  
> -		if (thread_flags & _TIF_NEED_RESCHED)
> +		if (thread_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>  			schedule();
>  
>  		if (thread_flags & _TIF_UPROBE)

