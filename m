From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/rt: Do not do push/pull when there is only one CPU
Date: Sat, 2 Dec 2017 14:55:55 +0100
Message-ID: <20171202135555.GW3326@worktop>
References: <20171201133222.66d41219@gandalf.local.home>
 <20171202125330.xrxspjeedbpr4hk5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171202125330.xrxspjeedbpr4hk5@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, Dec 02, 2017 at 01:53:31PM +0100, Sebastian Andrzej Siewior wrote:
> On 2017-12-01 13:32:22 [-0500], Steven Rostedt wrote:
> > 
> > Daniel Wagner reported a crash on the beaglebone black. This is a
> > single CPU architecture, and does not have a functional:
> > arch_send_call_function_single_ipi() and can crash if that is called.
> > 
> > As it only has one CPU, it shouldn't be called, but if the kernel is
> > compiled for SMP, the push/pull RT scheduling logic now calls it for
> > irq_work if the one CPU is overloaded, it can use that function to call
> > itself and crash the kernel.
> > 
> > There's no reason for the push/pull logic to even be called if there's
> > only one CPU online. Have it bail if it sees that's the case.
> > 
> > Link: http://lkml.kernel.org/r/8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org
> > Fixes: 4bdced5c9 ("sched/rt: Simplify the IPI based RT balancing logic")
> > Cc: stable@vger.kernel.org
> > Reported-by: Daniel Wagner <wagi@monom.org>
> > ---
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 4056c19ca3f0..50d2f8179f70 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1784,6 +1784,10 @@ static int push_rt_task(struct rq *rq)
> >  	if (!rq->rt.overloaded)
> >  		return 0;
> >  
> > +	/* If we are the only CPU, don't bother */
> > +	if (num_online_cpus() == 1)
> > +		return 0;
> > +
> 
> what about a check next to sched_feat(RT_PUSH_IPI)? I don't know if this
> is a hot path or not (due to bitmap_weight). If it is, then I would
> suggest something like a jump-label which is enabled if more than one
> CPU has been enabled on boot.

Yeah good point; bitmap_weight can be quite expensive.
