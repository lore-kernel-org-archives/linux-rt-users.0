From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Mon, 25 Jan 2016 19:14:05 +0200
Message-ID: <56A657DD.8080602@ti.com>
References: <1453108103.4123.4.camel@gmail.com>
 <20160118201828.GE12309@linutronix.de> <56A2196E.1020101@ti.com>
 <56A22693.4020304@linutronix.de> <20160122204018.GA3883@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57564 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627AbcAYROU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2016 12:14:20 -0500
In-Reply-To: <20160122204018.GA3883@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/22/2016 10:40 PM, Sebastian Andrzej Siewior wrote:
> * Sebastian Andrzej Siewior | 2016-01-22 13:54:43 [+0100]:
>
>>> Should _TIF_WORK_MASK also contain _TIF_NEED_RESCHED_LAZY?
>>
>> Yes, and arm64 lacks the same bits.
>
> That would be this. If a compiler is reading here and knows how to
> improve the following, please let me know :)
>
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index 46cc07b5cae6..1f36a4eccc72 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -143,8 +143,8 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
>   #define TIF_SYSCALL_TRACE	4	/* syscall trace active */
>   #define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
>   #define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
> -#define TIF_SECCOMP		7	/* seccomp syscall filtering active */
> -#define TIF_NEED_RESCHED_LAZY	8
> +#define TIF_SECCOMP		8	/* seccomp syscall filtering active */
> +#define TIF_NEED_RESCHED_LAZY	7
>
>   #define TIF_NOHZ		12	/* in adaptive nohz mode */
>   #define TIF_USING_IWMMXT	17
> @@ -170,7 +170,8 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
>    * Change these and you break ASM code in entry-common.S
>    */
>   #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
> -				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
> +				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
> +				 _TIF_NEED_RESCHED_LAZY)
>
>   #endif /* __KERNEL__ */
>   #endif /* __ASM_ARM_THREAD_INFO_H */
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 30a7228eaceb..c3bd6cbfce4b 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -36,7 +36,9 @@
>    UNWIND(.cantunwind	)
>   	disable_irq_notrace			@ disable interrupts
>   	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
> -	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
> +	tst	r1, #((_TIF_SYSCALL_WORK | _TIF_WORK_MASK) & ~_TIF_SECCOMP)
> +	bne	fast_work_pending
		^^^^^^^^^^^^^^^^

> +	tst	r1, #_TIF_SECCOMP
>   	bne	fast_work_pending
		^^^^^^^^^^^^^^^^^

Should it be "fast_work_pending" in both cases?

>
>   	/* perform architecture specific actions before user return */
> @@ -62,8 +64,11 @@ ENDPROC(ret_fast_syscall)
>   	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
>   	disable_irq_notrace			@ disable interrupts
>   	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
> -	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
> +	tst	r1, #((_TIF_SYSCALL_WORK | _TIF_WORK_MASK) & ~_TIF_SECCOMP)
> +	bne 	do_slower_path
> +	tst	r1, #_TIF_SECCOMP
>   	beq	no_work_pending
> +do_slower_path:
>    UNWIND(.fnend		)
>   ENDPROC(ret_fast_syscall)
>
[...]

-- 
regards,
-grygorii
