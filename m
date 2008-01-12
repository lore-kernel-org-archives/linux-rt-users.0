From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 2.6.24-rc7-rt1-pre1] per_cpu__ppc64_tlb_batch is only
 for 64 bit
Date: Fri, 11 Jan 2008 20:58:35 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801112053300.9717@gandalf.stny.rr.com>
References: <20080111230122.GO3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:42580 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbYALB6y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jan 2008 20:58:54 -0500
In-Reply-To: <20080111230122.GO3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Hmm, I think this was caused by Paul's patch:

http://lkml.org/lkml/2007/12/13/5

I'll apply this too, unless Paul sees any reason not to.

-- Steve


On Sat, 12 Jan 2008, Robert Schwebel wrote:

> Fix the following compile error for powerpc32:
>
> arch/powerpc/kernel/process.c: In function '__switch_to':
> arch/powerpc/kernel/process.c:355: error: 'per_cpu__ppc64_tlb_batch' undeclared (first use in this function)
>
> Not sure what the code actually does, but as it was not there in -rc5,
> somebody else might find something ...
>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
>
> ---
>  arch/powerpc/kernel/process.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Index: linux-2.6.24-rc7/arch/powerpc/kernel/process.c
> ===================================================================
> --- linux-2.6.24-rc7.orig/arch/powerpc/kernel/process.c
> +++ linux-2.6.24-rc7/arch/powerpc/kernel/process.c
> @@ -267,10 +267,10 @@ struct task_struct *__switch_to(struct t
>  	struct thread_struct *new_thread, *old_thread;
>  	unsigned long flags;
>  	struct task_struct *last;
> -#ifdef CONFIG_PREEMPT_RT
> +#if defined(CONFIG_PPC64) && defined (CONFIG_PREEMPT_RT)
>  	struct ppc64_tlb_batch *batch;
>  	int hadbatch;
> -#endif /* #ifdef CONFIG_PREEMPT_RT */
> +#endif
>
>  #ifdef CONFIG_SMP
>  	/* avoid complexity of lazy save/restore of fpu
> @@ -349,7 +349,6 @@ struct task_struct *__switch_to(struct t
>  		old_thread->accum_tb += (current_tb - start_tb);
>  		new_thread->start_tb = current_tb;
>  	}
> -#endif
>
>  #ifdef CONFIG_PREEMPT_RT
>  	batch = &__get_cpu_var(ppc64_tlb_batch);
> @@ -361,6 +360,7 @@ struct task_struct *__switch_to(struct t
>  		batch->active = 0;
>  	}
>  #endif /* #ifdef CONFIG_PREEMPT_RT */
> +#endif
>
>  	local_irq_save(flags);
>
> @@ -372,12 +372,12 @@ struct task_struct *__switch_to(struct t
>
>  	local_irq_restore(flags);
>
> -#ifdef CONFIG_PREEMPT_RT
> +#if defined(CONFIG_PPC64) && defined(CONFIG_PREEMPT_RT)
>  	if (hadbatch) {
>  		batch = &__get_cpu_var(ppc64_tlb_batch);
>  		batch->active = 1;
>  	}
> -#endif /* #ifdef CONFIG_PREEMPT_RT */
> +#endif
>
>  	return last;
>  }
>
