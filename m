From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Thu, 26 Feb 2015 08:49:07 +0100
Message-ID: <20150226074907.GQ21418@twins.programming.kicks-ass.net>
References: <20150224133946.3948c4b7@gandalf.local.home>
 <20150225103535.GJ5029@twins.programming.kicks-ass.net>
 <20150225105116.7fa03cc9@gandalf.local.home>
 <20150225171110.GO21418@twins.programming.kicks-ass.net>
 <20150225125015.6c5110ca@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59336 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbBZHtX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Feb 2015 02:49:23 -0500
Content-Disposition: inline
In-Reply-To: <20150225125015.6c5110ca@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 25, 2015 at 12:50:15PM -0500, Steven Rostedt wrote:
> > Well, the problem with it is one of collisions. So the 'easy' solution I
> > proposed would be something like:
> > 
> > int ips_next(struct ipi_pull_struct *ips)
> > {
> > 	int cpu = ips->src_cpu;
> > 	cpu = cpumask_next(cpu, rto_mask);
> > 	if (cpu >= nr_cpu_ids) {
> 
> Do we really need to loop? Just start with the first one, and go to the
> end.
> 
> > 		cpu = 0;
> > 		ips->flags |= IPS_LOOPED;
> > 		cpu = cpumask_next(cpu, rto_mask);
> > 		if (cpu >= nr_cpu_ids) /* empty mask *;
> > 			return cpu;
> > 	}
> > 	if (ips->flags & IPS_LOOPED && cpu >= ips->stop_cpu)
> > 		return nr_cpu_ids;
> > 	return cpu;
> > }

Yes, notice that we don't start iterating at the beginning; this in on
purpose. If we start iterating at the beginning, _every_ cpu will again
pile up on the first one.

By starting at the current cpu, each cpu will start iteration some place
else and hopefully, with a big enough system, different CPUs end up on a
different rto cpu.

> > 
> > 
> > 	struct ipi_pull_struct *ips = __this_cpu_ptr(ips);
> > 
> > 	raw_spin_lock(&ips->lock);
> > 	if (ips->flags & IPS_BUSY) {
> > 		/* there is an IPI active; update state */
> > 		ips->dst_prio = current->prio;
> > 		ips->stop_cpu = ips->src_cpu;
> > 		ips->flags &= ~IPS_LOOPED;
> 
> I guess the loop is needed for continuing the work, in case the
> scheduling changed?

That too.

> > 	} else {
> > 		/* no IPI active, make one go */
> > 		ips->dst_cpu = smp_processor_id();
> > 		ips->dst_prio = current->prio;
> > 		ips->src_cpu = ips->dst_cpu;
> > 		ips->stop_cpu = ips->dst_cpu;
> > 		ips->flags = IPS_BUSY;
> > 
> > 		cpu = ips_next(ips);
> > 		ips->src_cpu = cpu;
> > 		if (cpu < nr_cpu_ids)
> > 			irq_work_queue_on(&ips->work, cpu);
> > 	}
> > 	raw_spin_unlock(&ips->lock);
> 
> I'll have to spend some time comprehending this.

:-)

> > Where you would simply start walking the RTO mask from the current
> > position -- it also includes some restart logic, and you'd only take
> > ips->lock when your ipi handler starts and when it needs to migrate to
> > another cpu.
> > 
> > This way, on big systems, there's at least some chance different CPUs
> > find different targets to pull from.
> 
> OK, makes sense. I can try that.
