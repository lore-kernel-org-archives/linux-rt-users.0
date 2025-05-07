Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1B2046B3;
	Wed,  7 May 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746658272; cv=none; b=ury1PYuB9A1R6XBBKMctyZyp4NQ6Idnifji0s8byssD00khVDCLHHUU8NUmKbW4Ti8snVn5k0fdoLnIZU81Vre8FmrB+seeNV1cuKAGV6HeSmWaaKX7mcs6NKh+9A73PCe6lz1sckem0nSXM3HuhQ/3r+J2ShxqSV+Sz6RNvUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746658272; c=relaxed/simple;
	bh=E9+eGHJrbeS9i2f/rzKsy3HqYqEgW0ZpMWLReHSEssM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+6TZv07bf6NVLq2S8Zov8rHR5lwQwagNmCsL/+MoLNFEK5s7NOXAV1LTkU11mYDviw0eItjUIIW5RCwZGec92HlYmno004lVwCQHDv/4tuMj0V4JK0Cwa6OgYs56S2jMvJrf/wAuXoQSxSME7PlcVX5n62quwrW4UmJe/grImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhVu/JAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhVu/JAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523C8C4CEE2;
	Wed,  7 May 2025 22:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746658271;
	bh=E9+eGHJrbeS9i2f/rzKsy3HqYqEgW0ZpMWLReHSEssM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YhVu/JARipX+n+imQm/DwgdiRF9OrLw8xZSMF+SoP8751mZO6/oKhl1ladE4sVZCf
	 HpThYUAOmu3iRP4JTlA+KmFOe3FEs0fSbSWAGUbf6USriLi5iMoRS1zuw1dls5g/1q
	 ervkaCbeJs0jTmsjg4EXHES3r9DJIYfeJFor0BfzRJ43iH/6nrkgS5uHuuB4C4XcsT
	 ehwpVxWm49eqwSk/XxtJInB7SRF3jpv7LX8QoXmLvNGBjUs104G23M+6pjdi0o0EWF
	 bCAp3lzpFaHK4q95XyhEudRBiw6YDnHzeLzueC2ZAIcEShTVcoyxfK97/7nqhDkmrw
	 yif6jJHkFSlsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E9FEDCE0D1D; Wed,  7 May 2025 15:51:10 -0700 (PDT)
Date: Wed, 7 May 2025 15:51:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Mike Galbraith <efault@gmx.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 1/1] arm64: enable PREEMPT_LAZY
Message-ID: <b67d07d2-21d6-45ab-b069-c71b90f8bcba@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250305104925.189198-1-vschneid@redhat.com>
 <20250305104925.189198-2-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305104925.189198-2-vschneid@redhat.com>

On Wed, Mar 05, 2025 at 11:49:25AM +0100, Valentin Schneider wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> For an architecture to enable CONFIG_ARCH_HAS_RESCHED_LAZY, two things are
> required:
> 1) Adding a TIF_NEED_RESCHED_LAZY flag definition
> 2) Checking for TIF_NEED_RESCHED_LAZY in the appropriate locations
> 
> 2) is handled in a generic manner by CONFIG_GENERIC_ENTRY, which isn't
> (yet) implemented for arm64. However, outside of core scheduler code,
> TIF_NEED_RESCHED_LAZY only needs to be checked on a kernel exit, meaning:
> o return/entry to userspace.
> o return/entry to guest.
> 
> The return/entry to a guest is all handled by xfer_to_guest_mode_handle_work()
> which already does the right thing, so it can be left as-is.
> 
> arm64 doesn't use common entry's exit_to_user_mode_prepare(), so update its
> return to user path to check for TIF_NEED_RESCHED_LAZY and call into
> schedule() accordingly.
> 
> Link: https://lore.kernel.org/linux-rt-users/20241216190451.1c61977c@mordecai.tesarici.cz/
> Link: https://lore.kernel.org/all/xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb/
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [testdrive, _TIF_WORK_MASK fixlet and changelog.]
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> [Another round of testing; changelog faff]
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Nice!  This gets rid of the .config complaints that you otherwise get
when running the rcutorture TREE07 scenario on arm64:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/thread_info.h | 16 +++++++++-------
>  arch/arm64/kernel/entry-common.c     |  2 +-
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fcdd0ed3eca89..7789d7fb6f191 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -41,6 +41,7 @@ config ARM64
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> +	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PTE_DEVMAP
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_HW_PTE_YOUNG
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 1114c1c3300a1..4443ef2789758 100644
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
> @@ -100,10 +102,10 @@ void arch_setup_new_exec(void);
>  #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
>  
> -#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
> +#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
>  				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
>  				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
> -				 _TIF_NOTIFY_SIGNAL)
> +				 _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING)
>  
>  #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
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
