From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Wed, 25 Feb 2015 18:41:57 +0100
Message-ID: <20150225174157.GX24151@twins.programming.kicks-ass.net>
References: <20150224133946.3948c4b7@gandalf.local.home>
 <20150225103535.GJ5029@twins.programming.kicks-ass.net>
 <20150225105116.7fa03cc9@gandalf.local.home>
 <20150225171110.GO21418@twins.programming.kicks-ass.net>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150225171110.GO21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 25, 2015 at 06:11:10PM +0100, Peter Zijlstra wrote:
> 
> #define IPS_BUSY	0x01
> #define IPS_LOOPED	0x02
> 
> struct ipi_pull_struct {
> 	struct irq_work work;
> 	raw_spinlock_t	lock;
> 	int flags;
> 	int dst_cpu;	/* CPU that issued this search */
> 	int dst_prio;	/* Prio of the originating CPU */
> 	int src_cpu;	/* CPU where the IPI is running */
> 	int stop_cpu;	/* cpu where we can stop iterating */
> 	...
> };
> 
> Where you can increase seq every time you change it and the IPI will
> continue at least one more rto mask round for every change?

seq got lost.. ignore that bit, look at the code.

> int ips_next(struct ipi_pull_struct *ips)
> {
> 	int cpu = ips->src_cpu;
> 	cpu = cpumask_next(cpu, rto_mask);
> 	if (cpu >= nr_cpu_ids) {
> 		cpu = 0;

should be -1

> 		ips->flags |= IPS_LOOPED;
> 		cpu = cpumask_next(cpu, rto_mask);
> 		if (cpu >= nr_cpu_ids) /* empty mask *;
> 			return cpu;
> 	}
> 	if (ips->flags & IPS_LOOPED && cpu >= ips->stop_cpu)
> 		return nr_cpu_ids;
> 	return cpu;
> }
> 
> 
> 
> 	struct ipi_pull_struct *ips = __this_cpu_ptr(ips);
> 
> 	raw_spin_lock(&ips->lock);
> 	if (ips->flags & IPS_BUSY) {
> 		/* there is an IPI active; update state */
> 		ips->dst_prio = current->prio;
> 		ips->stop_cpu = ips->src_cpu;
> 		ips->flags &= ~IPS_LOOPED;
> 	} else {
> 		/* no IPI active, make one go */
> 		ips->dst_cpu = smp_processor_id();
> 		ips->dst_prio = current->prio;
> 		ips->src_cpu = ips->dst_cpu;
> 		ips->stop_cpu = ips->dst_cpu;
> 		ips->flags = IPS_BUSY;
> 
> 		cpu = ips_next(ips);
> 		ips->src_cpu = cpu;
> 		if (cpu < nr_cpu_ids)
> 			irq_work_queue_on(&ips->work, cpu);
> 	}
> 	raw_spin_unlock(&ips->lock);

There might be a wee race vs the busy looping, seeing how src_cpu might
be checking against the old dst_prio, so we could check one too few rto
mask.

No real problem I think.
