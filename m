From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Tue, 24 Feb 2015 13:45:32 -0500
Message-ID: <20150224134532.1c7c5060@gandalf.local.home>
References: <20150224133946.3948c4b7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?UTF-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224133946.3948c4b7@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 24 Feb 2015 13:39:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
  
> +static void tell_cpu_to_push(int cpu, struct rq *rq, int prio)
> +{
> +	/* We should never be here if the IPI is already out. */
> +	BUG_ON(rq->rt.push_csd_pending);
> +
> +	rq->rt.push_csd_pending = 1;
> +	rq->rt.push_csd_cpu = cpu;
> +	/* Save the prio that we used to find this CPU */
> +	rq->rt.push_csd_prio = prio;
> +
> +	/* Make sure csd_cpu is visible before we send the ipi */
> +	smp_mb();
> +
> +	smp_call_function_single_async(cpu, &rq->rt.push_csd);
> +}



> +	rt_rq->push_csd_cpu = next_cpu;
> +	rt_rq->push_csd_prio = next_prio;
> +
> +	/* Make sure the next cpu is seen on remote CPU */
> +	smp_mb();

BTW, would a smp_wmb() be enough here. I was a little paranoid about
the irq work and smp_call_functon above some how leaking before the
barrier. I'm probably just being too paranoid, and these can be
switched to smp_wmb(). But for now I'll just keep being a freak.

-- Steve


> +
> +	irq_work_queue_on(&rt_rq->push_csd_work, next_cpu);
> +
> +	return;
> +
