From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [patch 2.6.24-rc7-rt1-pre1] per_cpu__ppc64_tlb_batch is only for 64 bit
Date: Fri, 11 Jan 2008 21:35:30 -0800
Message-ID: <20080112053530.GB16899@linux.vnet.ibm.com>
References: <20080111230122.GO3177@pengutronix.de> <Pine.LNX.4.58.0801112053300.9717@gandalf.stny.rr.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:37904 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759232AbYALFfc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Jan 2008 00:35:32 -0500
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0C5ZWND012778
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jan 2008 00:35:32 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m0C5ZWCd091880
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jan 2008 22:35:32 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m0C5ZVue011432
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jan 2008 22:35:32 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0801112053300.9717@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 11, 2008 at 08:58:35PM -0500, Steven Rostedt wrote:
> 
> 
> Hmm, I think this was caused by Paul's patch:
> 
> http://lkml.org/lkml/2007/12/13/5
> 
> I'll apply this too, unless Paul sees any reason not to.

They look good to me -- apologies for the hassle, Robert!

						Thanx, Paul

> -- Steve
> 
> 
> On Sat, 12 Jan 2008, Robert Schwebel wrote:
> 
> > Fix the following compile error for powerpc32:
> >
> > arch/powerpc/kernel/process.c: In function '__switch_to':
> > arch/powerpc/kernel/process.c:355: error: 'per_cpu__ppc64_tlb_batch' undeclared (first use in this function)
> >
> > Not sure what the code actually does, but as it was not there in -rc5,
> > somebody else might find something ...
> >
> > Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
> >
> > ---
> >  arch/powerpc/kernel/process.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Index: linux-2.6.24-rc7/arch/powerpc/kernel/process.c
> > ===================================================================
> > --- linux-2.6.24-rc7.orig/arch/powerpc/kernel/process.c
> > +++ linux-2.6.24-rc7/arch/powerpc/kernel/process.c
> > @@ -267,10 +267,10 @@ struct task_struct *__switch_to(struct t
> >  	struct thread_struct *new_thread, *old_thread;
> >  	unsigned long flags;
> >  	struct task_struct *last;
> > -#ifdef CONFIG_PREEMPT_RT
> > +#if defined(CONFIG_PPC64) && defined (CONFIG_PREEMPT_RT)
> >  	struct ppc64_tlb_batch *batch;
> >  	int hadbatch;
> > -#endif /* #ifdef CONFIG_PREEMPT_RT */
> > +#endif
> >
> >  #ifdef CONFIG_SMP
> >  	/* avoid complexity of lazy save/restore of fpu
> > @@ -349,7 +349,6 @@ struct task_struct *__switch_to(struct t
> >  		old_thread->accum_tb += (current_tb - start_tb);
> >  		new_thread->start_tb = current_tb;
> >  	}
> > -#endif
> >
> >  #ifdef CONFIG_PREEMPT_RT
> >  	batch = &__get_cpu_var(ppc64_tlb_batch);
> > @@ -361,6 +360,7 @@ struct task_struct *__switch_to(struct t
> >  		batch->active = 0;
> >  	}
> >  #endif /* #ifdef CONFIG_PREEMPT_RT */
> > +#endif
> >
> >  	local_irq_save(flags);
> >
> > @@ -372,12 +372,12 @@ struct task_struct *__switch_to(struct t
> >
> >  	local_irq_restore(flags);
> >
> > -#ifdef CONFIG_PREEMPT_RT
> > +#if defined(CONFIG_PPC64) && defined(CONFIG_PREEMPT_RT)
> >  	if (hadbatch) {
> >  		batch = &__get_cpu_var(ppc64_tlb_batch);
> >  		batch->active = 1;
> >  	}
> > -#endif /* #ifdef CONFIG_PREEMPT_RT */
> > +#endif
> >
> >  	return last;
> >  }
> >
