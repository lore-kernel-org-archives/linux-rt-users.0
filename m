From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 17:16:49 +0200
Message-ID: <20160329151649.GA12845@twins.programming.kicks-ass.net>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51219 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338AbcC2PQx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 11:16:53 -0400
Content-Disposition: inline
In-Reply-To: <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 28, 2016 at 01:50:51PM -0300, Daniel Bristot de Oliveira wrote:
> @@ -733,7 +738,9 @@ static void update_curr_dl(struct rq *rq)
>  
>  throttle:
>  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> +		trace_sched_deadline_yield(&rq->curr->dl);
>  		dl_se->dl_throttled = 1;
> +		trace_sched_deadline_throttle(dl_se);

This is just really very sad.

>  		__dequeue_task_dl(rq, curr, 0);
>  		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
>  			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
> @@ -910,6 +917,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
>  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
>  {
>  	__dequeue_dl_entity(dl_se);
> +	trace_sched_deadline_block(dl_se);
>  }

And that's just not going to happen.
