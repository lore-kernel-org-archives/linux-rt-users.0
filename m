From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 23 Feb 2016 11:44:08 +0100
Message-ID: <20160223104408.GO6357@twins.programming.kicks-ass.net>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
 <20160222173259.GM6357@twins.programming.kicks-ass.net>
 <20160222124854.3816fec4@gandalf.local.home>
 <20160222213017.GN6357@twins.programming.kicks-ass.net>
 <20160222173043.24873ae8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50051 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbcBWKoO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Feb 2016 05:44:14 -0500
Content-Disposition: inline
In-Reply-To: <20160222173043.24873ae8@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 22, 2016 at 05:30:43PM -0500, Steven Rostedt wrote:
> On Mon, 22 Feb 2016 22:30:17 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Feb 22, 2016 at 12:48:54PM -0500, Steven Rostedt wrote:
> > 
> > > > As it stands, the existing tracepoint have already been an ABI
> > > > trainwreck, why would I want to add more?  
> > > 
> > > Yes, this may become a type of ABI, but even the sched switch
> > > tracepoints haven't been that bad. Has it really prevented us from
> > > changing anything?  
> > 
> > The whole wakeup thing where we _still_ have a dummy argument, and have
> > been lying about the value for a long time really stinks.
> 
> Having a dummy argument is not that bad. Yes, it's inconvenient, and
> I'm not sure who even uses it (can we delete it without breaking
> anything?) But it doesn't prevent us from going forward with
> development.

No it very much illustrates the problem and is a very clear indication
that tracepoints are an ABI.

Yes, we more or less got away with it this time, but it does prohibit us
from doing sane things, see below.

> > > But let me ask, what would you recommend to finding out if the kernel
> > > has really given your tasks the recommended runtime within a given
> > > period? We can't expect users of SCHED_DEADLINE to be modifying the
> > > kernel themselves.  
> > 
> > So why are these deadline specific tracepoint? Why not extend the ones
> > we already have?
> 
> I'm not sure how to do that and be able to report when a period has
> elapsed, and when the next period is coming.

Seriously? Sit still for a minute and think perhaps?

> > Also, will these tracepoints still work if we implement SCHED_DEADLINE
> > using Least-Laxity-First or Pfair or some other exotic algorithm? Or
> > will be forever be bound to EDF just because tracepoint ABI shite?
> 
> Can we come up with generic numbers? I mean, the user that asks for
> their task to have a specific runtime within a specific
> period/deadline, these seem to be generic already. I'll have to read up
> on those that you mention, but do that not have a "replenish" for when
> the period starts again? And then a yield, showing the task has given
> up its remaining time, or a block, where a task is scheduled out
> because it blocked on a lock?

You tell me; why do you expect me to think for you? These should all
have been questions you asked yourself before you even considered
posting tracepoints.

ABI remember? We're careful with that.

> > Worse, the proposed tracepoints are atrocious, look at crap like this:
> > 
> > > +		if (trace_sched_deadline_yield_enabled()) {
> > > +			u64 delta_exec = rq_clock_task(rq) - p->se.exec_start;
> > > +			/* Subtract the last run till now */
> > > +			if (likely((s64)delta_exec > 0))
> > > +				p->dl.runtime -= delta_exec;
> > > +			trace_sched_deadline_yield(&p->dl);
> > > +		}  
> > 
> > tracepoints should _NEVER_ change state, ever.
> 
> Heh, it's not really changing state. The code directly after this is:
> 
> 	p->dl.runtime = 0;

Yes, it more or less 'works', but its still atrocious shite. Its the
worst kind of anti pattern possible.

Suppose someone comes and removes that line, and ignores the tracepoint
stuff, because, hell its a tracepoint, those don't modify stuff.

Its just really, utterly bad practice.

You've done this tracing code long enough, you really should _KNOW_
this.

> > So tell me why these specific tracepoints and why the existing ones
> > could not be extended to include this information. For example, why a
> > trace_sched_dealine_yield, and not a generic trace_sched_yield() that
> > works for all classes.
> 
> But what about reporting actual runtime, and when the next period will
> come. That only matters for deadline.

How is that an answer to the question? Are you implying a generic
trace_sched_yield() call could not do this?

> > But do not present me with a bunch of random arse, hacked together
> > tracepoints and tell me they might be useful, maybe.
> 
> 
> They ARE useful. These are the tracepoints I'm currently using to
> debug the deadline scheduler with. They have been indispensable for my
> current work.

They are, most obviously, a hacked together debug session for sure. This
is _NOT_ what you commit.

Now ideally we'd do something like the below, but because trainwreck, we
cannot actually do this I think :-(

It gets you about half of what your patch does, but shows how to also
do a generic sched_yield(). The replenish might have to remain special,
although both CFS and RT also have replenishes, albeit significantly
different.

I really dislike tracepoints, and I'm >.< close to proposing a patch
removing them all from the scheduler.

---
 include/trace/events/sched.h | 97 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9b90c57517a9..b902eb71830b 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -103,9 +103,15 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
 	     TP_PROTO(struct task_struct *p),
 	     TP_ARGS(p));
 
+#define TASK_STATE_PREEMPT	(TASK_STATE_MAX << 0)
+#define TASK_STATE_THROTTLED	(TASK_STATE_MAX << 1)
+#define TASK_STATE_YIELDED	(TASK_STATE_MAX << 2)
+
 #ifdef CREATE_TRACE_POINTS
 static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
 {
+	long state = p->state;
+
 #ifdef CONFIG_SCHED_DEBUG
 	BUG_ON(p != current);
 #endif /* CONFIG_SCHED_DEBUG */
@@ -114,10 +120,49 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 	 * Preemption ignores task state, therefore preempted tasks are always
 	 * RUNNING (we will not have dequeued if state != RUNNING).
 	 */
-	return preempt ? TASK_RUNNING | TASK_STATE_MAX : p->state;
+	if (preempt) {
+		state = TASK_RUNNING | TASK_STATE_MAX;
+	} else if (dl_task(p)) {
+		if (p->dl.dl_throttled)
+			state |= TASK_STATE_THROTTLED;
+		else if (p->dl.dl_yielded)
+			state |= TASK_STATE_YIELDED;
+	}
+
+	return state;
 }
 #endif /* CREATE_TRACE_POINTS */
 
+#define __trace_sched_switch_fields(name)	do {			\
+	__entry->name##_policy = name->policy;				\
+	switch (name->policy) {						\
+	case SCHED_IDLE:						\
+	case SCHED_BATCH:						\
+	case SCHED_NORMAL:						\
+		__entry->name##_f1 = PRIO_TO_NICE(name->static_prio);	\
+		__entry->name##_f2 = 0;					\
+		__entry->name##_f3 = 0;					\
+		break;							\
+	case SCHED_RR:							\
+	case SCHED_FIFO:						\
+		__entry->name##_f1 = USER_PRIO(name->normal_prio);	\
+		__entry->name##_f2 = 0;					\
+		__entry->name##_f3 = 0;					\
+		break;							\
+	case SCHED_DEADLINE:						\
+		__entry->name##_f1 = name->dl.runtime;			\
+		__entry->name##_f2 = name->dl.deadline;			\
+		__entry->name##_f3 = name->dl.dl_period;		\
+		break;							\
+	default:							\
+		__entry->name##_f1 = 0;					\
+		__entry->name##_f2 = 0;					\
+		__entry->name##_f3 = 0;					\
+		break;							\
+	}								\
+} while (0)
+
+
 /*
  * Tracepoint for task switches, performed by the scheduler:
  */
@@ -132,33 +177,63 @@ TRACE_EVENT(sched_switch,
 	TP_STRUCT__entry(
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	prev_pid			)
-		__field(	int,	prev_prio			)
+		__field(	int,	prev_policy			)
+		__field(	s64,	prev_f1				)
+		__field(	u64,	prev_f2				)
+		__field(	u64,	prev_f3				)
 		__field(	long,	prev_state			)
+
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
-		__field(	int,	next_prio			)
+		__field(	int,	next_policy			)
+		__field(	s64,	next_f1				)
+		__field(	u64,	next_f2				)
+		__field(	u64,	next_f3				)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->prev_pid	= prev->pid;
-		__entry->prev_prio	= prev->prio;
+		__trace_sched_switch_fields(prev);
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev);
-		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
-		__entry->next_prio	= next->prio;
+		__trace_sched_switch_fields(next);
 	),
 
-	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
-		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
+	TP_printk("prev_comm=%s prev_pid=%d prev=%s:{%Ld,%Lu,%Lu} prev_state=%s%s ==> next_comm=%s next_pid=%d next=%s:{%Ld,%Lu,%Lu}",
+		__entry->prev_comm, __entry->prev_pid,
+		__print_symbolic(__entry->prev_policy,
+				{SCHED_IDLE,	"IDLE"},
+				{SCHED_BATCH,	"BATCH"},
+				{SCHED_NORMAL,	"NORMAL"},
+				{SCHED_RR,	"RR"},
+				{SCHED_FIFO,	"FIFO"},
+				{SCHED_DEADLINE,"DEADLINE"}),
+		__entry->prev_f1, __entry->prev_f2, __entry->prev_f3,
+
 		__entry->prev_state & (TASK_STATE_MAX-1) ?
 		  __print_flags(__entry->prev_state & (TASK_STATE_MAX-1), "|",
 				{ 1, "S"} , { 2, "D" }, { 4, "T" }, { 8, "t" },
 				{ 16, "Z" }, { 32, "X" }, { 64, "x" },
 				{ 128, "K" }, { 256, "W" }, { 512, "P" },
 				{ 1024, "N" }) : "R",
-		__entry->prev_state & TASK_STATE_MAX ? "+" : "",
-		__entry->next_comm, __entry->next_pid, __entry->next_prio)
+		__print_flags(__entry->prev_state & ~(TASK_STATE_MAX-1), "|",
+				{ TASK_STATE_PREEMPT,   "+" },
+				{ TASK_STATE_THROTTLED, "t" },
+				{ TASK_STATE_YIELDED,	"y" }),
+
+		__entry->next_comm, __entry->next_pid,
+		__print_symbolic(__entry->next_policy,
+				{SCHED_IDLE,	"IDLE"},
+				{SCHED_BATCH,	"BATCH"},
+				{SCHED_NORMAL,	"NORMAL"},
+				{SCHED_RR,	"RR"},
+				{SCHED_FIFO,	"FIFO"},
+				{SCHED_DEADLINE,"DEADLINE"}),
+		__entry->next_f1, __entry->next_f2, __entry->next_f3,
+		)
 );
 
 /*
