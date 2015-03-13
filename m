From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch] rt,nohz_full: fix nohz_full for PREEMPT_RT_FULL
Date: Fri, 13 Mar 2015 03:13:15 +0100
Message-ID: <1426212795.3328.21.camel@gmail.com>
References: <20150216111822.GA21649@linutronix.de>
	 <1424258514.3819.39.camel@gmail.com> <20150309134535.GA13768@linutronix.de>
	 <1425911771.30469.8.camel@gmail.com> <1425980136.3507.17.camel@gmail.com>
	 <1426153093.4190.2.camel@gmail.com>
	 <20150312110911.1a93c8e8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:44448 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbbCMCNS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 22:13:18 -0400
In-Reply-To: <20150312110911.1a93c8e8@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2015-03-12 at 11:09 -0400, Steven Rostedt wrote:
> On Thu, 12 Mar 2015 10:38:13 +0100
> Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> 

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -783,12 +783,16 @@ static inline bool got_nohz_idle_kick(vo
> >  #ifdef CONFIG_NO_HZ_FULL
> >  bool sched_can_stop_tick(void)
> >  {
> > +	int softirqd = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
> > +
> > +	softirqd &= current == this_cpu_ksoftirqd();
> 
> Ug, binary and logical ANDs should not be combined. Just looks nasty.
> What about:
> 
> 	softirqd = !!(IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
> 			current == this_cpu_ksoftirqd());

My way looks prettier to me, but I seem to be the only who thinks so
(this is not the first time it got a gripe), so I'll change it ;-)

> > +
> >  	/*
> >  	 * More than one running task need preemption.
> >  	 * nr_running update is assumed to be visible
> >  	 * after IPI is sent from wakers.
> >  	 */
> > -	if (this_rq()->nr_running > 1)
> > +	if (this_rq()->nr_running - softirqd > 1)
> 
> There should also be a comment explaining this hack.

Yeah.
  
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -222,7 +222,14 @@ void __tick_nohz_full_check(void)
> >  
> >  static void nohz_full_kick_work_func(struct irq_work *work)
> >  {
> > +	unsigned long flags;
> > +
> > +	local_save_flags(flags);
> > +	/* ksoftirqd processes softirqs with interrupts enabled */
> > +	if (current == this_cpu_ksoftirqd())
> > +		local_irq_disable();
> 
> Why the funkiness above? Why not just call local_irq_save()?

Gone.  It would be good to make the rest gone too, it's ain't pretty it
just works.

	-Mike

