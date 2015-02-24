From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Tue, 24 Feb 2015 16:23:39 -0500
Message-ID: <20150224162339.36670d94@gandalf.local.home>
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

> @@ -1775,6 +1946,15 @@ static int pull_rt_task(struct rq *this_
>  	 */
>  	smp_rmb();
>  
> +	/* Use local just in case a feature is switched in the middle of this */
> +	if ((use_ipi = sched_feat(RT_PUSH_IPI))) {
> +		/* Make sure the update to pending is visible here. */
> +		smp_rmb();

While porting this to the -rt kernel, I noticed that this rmb is
unneeded. It's already called above for a different reason :-p

-- Steve

> +
> +		/* If a push ipi is out, then we must do the old method */
> +		push_pending = READ_ONCE(this_rq->rt.push_csd_pending);
> +	}
> +
>  	for_each_cpu(cpu, this_rq->rd->rto_mask) {
>  		if (this_cpu == cpu)
>  			continue;
