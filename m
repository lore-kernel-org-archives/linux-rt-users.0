From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Fri, 20 Mar 2015 11:25:42 +0100
Message-ID: <20150320102542.GY23123@twins.programming.kicks-ass.net>
References: <20150318144946.2f3cc982@gandalf.local.home>
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
In-Reply-To: <20150318144946.2f3cc982@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Mar 18, 2015 at 02:49:46PM -0400, Steven Rostedt wrote:
> +static int find_next_push_cpu(struct rq *rq)
> +{
> +	struct rq *next_rq;
> +	int cpu;
> +
> +	while (1) {

We typically tend to write: for (;;), instead, however would a do { }
while () loop not make more sense here?

	do {
		cpu = rto_next_cpu(rq);
		if (cpu >= nr_cpu_ids)
			break;

		next_rq = cpu_rq(cpu);
	} while (next_rq->rt.highest_prio.next >= rq->rt.highest_prio.curr);

> +	return cpu;
> +}
