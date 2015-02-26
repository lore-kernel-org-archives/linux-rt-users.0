From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v3] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Thu, 26 Feb 2015 10:58:13 -0500
Message-ID: <20150226105813.2659c8ea@gandalf.local.home>
References: <20150225222644.042841cc@gandalf.local.home>
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
In-Reply-To: <20150225222644.042841cc@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 25 Feb 2015 22:26:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +static int find_next_push_cpu(struct rq *rq)
> +{
> +	struct rq *next_rq;
> +	int cpu;
> +
> +	while (1) {
> +		cpu = rto_next_cpu(rq);
> +		if (cpu >= nr_cpu_ids)
> +			break;
> +		next_rq = cpu_rq(cpu);
> +
> +		/* Make sure the next rq can push to this rq */
> +		if (next_rq->rt.highest_prio.next <
> +		    rq->rt.highest_prio.curr &&

> +		    next_rq->rt.highest_prio.next <
> +		    rq->rt.highest_prio.next)

OK, this second comparison is not needed. I was looking at the code in
more detail, and see that the .curr is updated when a new task is
enqueued, and it does not represent the task currently running, but the
highest priority task that is on the rq.

I'll be sending a v4 soon with this update.

-- Steve

> +			break;
> +	}
> +
> +	return cpu;
> +}
