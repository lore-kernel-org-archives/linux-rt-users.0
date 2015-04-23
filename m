From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 3.18] irq_work: Provide a soft-irq based queue
Date: Thu, 23 Apr 2015 09:01:22 +0200
Message-ID: <1429772482.3419.40.camel@gmail.com>
References: <552FC1FE.4020406@siemens.com>	<552FC6B1.1040000@linutronix.de>
	 <552FC72A.8060709@siemens.com> <20150416111041.66043164@gandalf.local.home>
	 <552FD55F.8000105@siemens.com> <552FE320.6050601@siemens.com>
	 <1429517036.3226.9.camel@gmail.com> <1429769505.3419.9.camel@gmail.com>
	 <55389632.50308@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55389632.50308@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2015-04-23 at 08:50 +0200, Jan Kiszka wrote:
> On 2015-04-23 08:11, Mike Galbraith wrote:
> > @@ -103,6 +98,9 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
> >  /* Enqueue the irq work @work on the current CPU */
> >  bool irq_work_queue(struct irq_work *work)
> >  {
> > +       bool realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
> > +       bool raise = false;
> > +
> >         /* Only queue if not already pending */
> >         if (!irq_work_claim(work))
> >                 return false;
> > @@ -110,25 +108,22 @@ bool irq_work_queue(struct irq_work *wor
> >         /* Queue the entry and raise the IPI if needed. */
> >         preempt_disable();
> >  
> > -#ifdef CONFIG_PREEMPT_RT_FULL
> > -       if (work->flags & IRQ_WORK_HARD_IRQ) {
> > +       if (realtime && (work->flags & IRQ_WORK_HARD_IRQ)) {
> >                 if (llist_add(&work->llnode, 
> > this_cpu_ptr(&hirq_work_list)))
> 
> This boils down to
> 
> #ifdef CONFIG_X
> some_type x;
> #endif
> ...
> 
> if (IS_ENABLED(CONFIG_X) && ...)
>       use(x);
> 
> And here we even have an indirection for IS_ENABLED via that local 
> bool
> variable. Is that pattern OK for Linux? Does it compile in all 
> supported
> optimization levels of all supported compilers?

I hope it all goes away, that being what IS_ENABLED() is there for.

        -Mike
