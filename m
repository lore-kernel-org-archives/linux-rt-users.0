From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [PATCH] cleanup sched_yield (sys)call nesting.
Date: Thu, 19 Nov 2009 04:20:24 +0100
Message-ID: <20091119032024.GA13378@elte.hu>
References: <20091107210147.3e754278@hyperion.delvare>
 <4AF7148C.9090706@thebigcorporation.com>
 <20091112211255.09cd884a@hyperion.delvare>
 <alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
 <20091116155606.GC29479@sirena.org.uk>
 <c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>
 <20091118010520.4cd397d4@lxorguk.ukuu.org.uk>
 <c384c5ea0911180828x7c857189w3316c93bb78100ab@mail.gmail.com>
 <20091118175202.490989d8@hyperion.delvare>
 <1258577194.12429.86.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Leon Woestenberg <leon.woestenberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sven-Thorsten Dietrich <sven-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org>,
	Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1258577194.12429.86.camel-ZUMNgey8dAdBci4yedNfAfz91O0DMRRp0E9HWUfgJXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org


* Sven-Thorsten Dietrich <sven-IsH+rWyeNGyzjR9+/8zPv5owlv4uC7bZ@public.gmane.org> wrote:

> Subject: clean up chaining in sched_yield()
> From: Sven-Thorsten Dietrich <sdietrich-l3A5Bk7waGM@public.gmane.org>
> 
> The call to sys_sched_yield for in-Kernel is messy.
> and the return code from sys_sched_yield is ignored when called from
> in-kernel.
> 
> Signed-off-by: Sven-Thorsten Dietrich <sdietrich-l3A5Bk7waGM@public.gmane.org>
> 
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 3c11ae0..db2c0f9 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -6647,12 +6647,12 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
>  }
>  
>  /**
> - * sys_sched_yield - yield the current processor to other threads.
> + * do_sched_yield - yield the current processor to other threads.
>   *
>   * This function yields the current CPU to other tasks. If there are no
>   * other threads running on this CPU then this function will return.
>   */
> -SYSCALL_DEFINE0(sched_yield)
> +static inline void do_sched_yield(void) 
>  {
>  	struct rq *rq = this_rq_lock();
>  
> @@ -6669,6 +6669,11 @@ SYSCALL_DEFINE0(sched_yield)
>  	preempt_enable_no_resched();
>  
>  	schedule();
> +}
> +
> +SYSCALL_DEFINE0(sched_yield)
> +{
> +	do_sched_yield();
>  
>  	return 0;
>  }
> @@ -6746,7 +6751,7 @@ EXPORT_SYMBOL(__cond_resched_softirq);
>  void __sched yield(void)
>  {
>  	set_current_state(TASK_RUNNING);
> -	sys_sched_yield();
> +	do_sched_yield();
>  }
>  EXPORT_SYMBOL(yield);

Why do you consider an in-kernel call to sys_*() 'messy'? It is not - 
and we rely on being able to do it with various syscalls.

Also, your patch bloats the scheduler a bit, for no good reason.

Thanks,

	Ingo
