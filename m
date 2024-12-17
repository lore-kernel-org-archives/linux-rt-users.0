Received: from mwweb08oc.mail2world.com (mwweb08oc.mail2world.com [74.202.142.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C4158DAC
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.202.142.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396079; cv=none; b=f1/W8Eg9ivn/MuNB7MMg3rw1/ndFiGtLmPKV09qg6nkSymcw0km2XJwh265R2tpj++1rsZcmDQA24Rugje+sC5uhWSmVzit/EXzBbFhvvOb9VOAw1VTSHtrlBHPfnnum5mOJuuUqmgKenIotJYad/yBvL2ci7rlMLF7GbQtH0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396079; c=relaxed/simple;
	bh=3NK4oaq3H/9FFSXsNRJKXbCl96q+sw3na65CT+2TpWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/2rB0HwKVpCIkRM6M/tZom6uBzItMwtXlH43Lb/boCdGR3F9hIst59efU0nRqhhpCGwSFa0Qa7y9H43ntVdKsQ7nQeZ8lgDDRE3Yev+3E1nkn/ezoZYifnVOt0n0d4AwbES3ibQ7UaElObBVxlDumNzPZP/bI/S6Sf20Uh+dwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shentel.net; spf=pass smtp.mailfrom=shentel.net; arc=none smtp.client-ip=74.202.142.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shentel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shentel.net
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
	 Mon, 16 Dec 2024 16:40:11 -0800
auth-sender:gheskett@shentel.net
Received: from 204.111.66.52 unverified ([204.111.66.52]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
	Mon, 16 Dec 2024 16:40:11 -0800
Message-ID: <d576739d-afbf-4198-b1e1-791ea210910d@shentel.net>
Date: Mon, 16 Dec 2024 19:40:10 -0500
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Lazy preemption on arm64
To: Mark Rutland <mark.rutland@arm.com>, Petr Tesarik <ptesarik@suse.com>
Cc: linux-rt-users@vger.kernel.org
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
 <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
Content-Language: en-US
From: gene heskett <gheskett@shentel.net>
In-Reply-To: <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A006373.6760C86B.002B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 17 Dec 2024 00:40:11.0711 (UTC) FILETIME=[3B05E4F0:01DB501C]


On 12/16/24 14:05, Mark Rutland wrote:
> On Mon, Dec 16, 2024 at 07:04:51PM +0100, Petr Tesarik wrote:
>> Hi all,
>>
>> what is the plan for implementing PREEMPT_LAZY on arm64?
>>
>> There used to be RT patch series which enabled lazy preemption on
>> arm64, but this architecture was "sacrificed" in v6.6-rc6-rt10, as
>> collateral damage of switching to PREEMPT_AUTO.
>>
>> IIUC lazy preemption is currently implemented only for architectures
>> with CONFIG_GENERIC_ENTRY, but there is no inherent dependency on it.
>> So, is the plan to convert arm64 to GENERIC_ENTRY (and then get
>> PREEMPT_LAZY for free), or is somebody working on CONFIG_PREEMPT_LAZY
>> for arm64 without that conversion?
> I don't think there's an agreed upon plan either way.
>
> Jinjie Ruan has been looking to move arm64 over to GENERIC_ENTRY:
>
>    https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@huawei.com/
>
> AFAICT, the only bits that we get "for free" from GENERIC_ENTRY would be
> the logic in raw_irqentry_exit_cond_resched() and
> exit_to_user_mode_loop(), and all we'd need to enable this on arm64
> as-is would be as below.
>
> ... so how important is this?
For running machine tools with LinuxCNC, very.  I have an rpi4b running 
a medium sized Sheldon lathe thats all of 80 yo  and its still using a 
4.19-rt kernel with quite low for a pi, latency.  But its 10x slower 
than wintel stuff.
>
> Mark.
>
> ---->8----
>  From 16ae3c84d8e1691fe670dbfb4c643cab4fa2065f Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 16 Dec 2024 18:32:44 +0000
> Subject: [PATCH] HACK: arm64: enable PREEMPT_LAZY
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>   arch/arm64/Kconfig                   |  1 +
>   arch/arm64/include/asm/thread_info.h | 12 +++++++-----
>   arch/arm64/kernel/entry-common.c     |  2 +-
>   3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 100570a048c5e..7926bc78a1c46 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -39,6 +39,7 @@ config ARM64
>   	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> +	select ARCH_HAS_PREEMPT_LAZY
>   	select ARCH_HAS_PTE_DEVMAP
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_HW_PTE_YOUNG
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 1114c1c3300a1..a2125407901ed 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -59,11 +59,12 @@ void arch_setup_new_exec(void);
>   
>   #define TIF_SIGPENDING		0	/* signal pending */
>   #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
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
>   #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
>   #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>   #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> @@ -85,6 +86,7 @@ void arch_setup_new_exec(void);
>   
>   #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>   #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>   #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>   #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
>   #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index b260ddc4d3e9a..7993fab0cab4c 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
>   	do {
>   		local_irq_enable();
>   
> -		if (thread_flags & _TIF_NEED_RESCHED)
> +		if (thread_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>   			schedule();
>   
>   		if (thread_flags & _TIF_UPROBE)

Cheers, Gene Heskett, CET.
-- 
"There are four boxes to be used in defense of liberty:
  soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
  - Louis D. Brandeis

