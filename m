From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 13:10:34 -0300
Message-ID: <56FAA8FA.5060407@redhat.com>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329151649.GA12845@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 03/29/2016 12:16 PM, Peter Zijlstra wrote:
>> +		trace_sched_deadline_yield(&rq->curr->dl);

ouch, it should be trace_sched_deadline_yield(dl_se). It works
as is, but it is really very sad, my bad, sorry.

>> >  		dl_se->dl_throttled = 1;
>> > +		trace_sched_deadline_throttle(dl_se);
> This is just really very sad.

Am I missing any other really very sad thing here?

>> >  		__dequeue_task_dl(rq, curr, 0);
>> >  		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
>> >  			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
>> > @@ -910,6 +917,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
>> >  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
>> >  {
>> >  	__dequeue_dl_entity(dl_se);
>> > +	trace_sched_deadline_block(dl_se);
>> >  }
> And that's just not going to happen.

It will, if a task goes to sleep during the activation,
e.g., when blocking on a system call. For example:

          <idle>-0     [007] d..3 78377.688969: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=b next_pid=18973 next_prio=-1
               b-18973 [007] d..3 78377.688979: sched_deadline_block: now=78377.688976271 deadline=78377.718945137 remaining_runtime=9968866
               b-18973 [007] d..3 78377.688981: sched_switch: prev_comm=b prev_pid=18973 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
