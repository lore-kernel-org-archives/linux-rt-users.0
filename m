From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Wed, 4 Feb 2015 14:39:06 -0500
Message-ID: <20150204143906.742287b4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



I posted this patch a while back ago here:

 https://lkml.org/lkml/2012/12/12/354

It solved an issue that is very prevalent on large count CPUs. Tracing
showed it nicely. When we have more than 16 CPUs, the lock contention
on the run queue lock made a very noticeable delay. So much so, that
Mike Galbraith showed the results of how much this patch made things
run nicely:

  https://lkml.org/lkml/2012/12/21/220

We're talking about 1ms latencies dropped down to 50us or less. That is
a HUGE impact.

But Thomas Gleixner shot down this approach comparing it to TTWU_QUEUE,
and never commented on it again :-(

  https://lkml.org/lkml/2012/12/11/172

TTWU_QUEUE is when a task is woken on another CPU, instead of migrating
it over, an IPI is sent to that CPU and the CPU will push off the
tasks. Now if you have 100 tasks waking up, there could be 100 tasks
needing to be migrated, and this, as Thomas pointed out, is extremely
non-deterministic.


Now how is my patch different? For one thing, unlike TTWU_QUEUE, it
only deals with RT tasks, and has nothing to do with SCHED_OTHER.
Another thing that is different is that it has nothing to do with a
task waking up, but instead, a task scheduling out on another CPU. In
fact, the current approach is the non deterministic one, because as
running cyclictest -d0 -t -i100 will show, is that you can have n CPUs
all trying to grab the same lock at the same time.

This patch deals with pull_rt_tasks() which is called when a CPU lowers
its priority and sees that there's an rq somewhere that has two or more
RT task scheduled on it where one of those RT tasks can migrate over to
the newly lowered CPU rq.

The problem is that if you have 100 CPUs having an RT task schedule out
(just like cyclictest -d0 -t -i100 does a lot), and if there's one rq
that has more than one RT task scheduled on it (overloaded), each
of those 100 CPUs are going to try to get that second RT task on that
lonely rq, and each of those 100 CPUs are going to take that lonely
rq's lock! Then what happens if the task running on that rq wants to
schedule? Well, it needs to wait behind 100 CPUs contending for its rq
lock, and we see a HUGE latency (1ms or more).

What does this patch do instead? Instead of trying to fight for the rq,
if it sees that there's an overloaded rq, it simply sends an IPI to
that CPU to have it push the overloaded RT task off to another CPU.

Yes, it interrupts the currently running RT task to push off a lower RT
task (which wasn't able to migrate anywhere when it was scheduled in
the first place, because all the other CPUs had higher priority tasks
waiting).

Can this be wildly non-deterministic? If the one queue had a 100 RT
tasks, and there were a 100 CPUs that had RT tasks that were higher
priority than those other 100 RT tasks, and they all just scheduled
out, then sure. But really, if you had such a system, it's totally
broken to begin with.

This issue has popped up several times already, and that's why I'm
posting this patch again. This time, I'm actually posting it to
mainline and not just for the RT kernel because it affects mainline as
well. It probably hasn't been reported as much because RT tasks can
easily suffer 1ms latencies on mainline for other reasons. But I bet
this will help a lot for large CPUs anyway.

>From my tests, the rq contention starts to show itself after you reach
16 CPUs, which is why I added this as a sched_feature (RT_PUSH_IPI),
which does not get set by default unless you have more than 16 CPUs.
Otherwise, you can turn it on or off with the sched_feature interface.

I'll let Clark Williams post the results that he's seen (on
RT_PREEMPT), but I feel this is better for mainline.

Below is the original patch change log, but the patch itself was
forward ported to 3.19-rc7.

Comments?

-- Steve


--------
sched/rt: Use IPI to trigger RT task push migration instead of pulling

When debugging the latencies on a 40 core box, where we hit 300 to
500 microsecond latencies, I found there was a huge contention on the
runqueue locks.

Investigating it further, running ftrace, I found that it was due to
the pulling of RT tasks.

The test that was run was the following:

 cyclictest --numa -p95 -m -d0 -i100

This created a thread on each CPU, that would set its wakeup in interations
of 100 microseconds. The -d0 means that all the threads had the same
interval (100us). Each thread sleeps for 100us and wakes up and measures
its latencies.

What happened was another RT task would be scheduled on one of the CPUs
that was running our test, when the other CPUS test went to sleep and
scheduled idle. This cause the "pull" operation to execute on all
these CPUs. Each one of these saw the RT task that was overloaded on
the CPU of the test that was still running, and each one tried
to grab that task in a thundering herd way.

To grab the task, each thread would do a double rq lock grab, grabbing
its own lock as well as the rq of the overloaded CPU. As the sched
domains on this box was rather flat for its size, I saw up to 12 CPUs
block on this lock at once. This caused a ripple affect with the
rq locks. As these locks were blocked, any wakeups or load balanceing
on these CPUs would also block on these locks, and the wait time escalated.

I've tried various methods to lesson the load, but things like an
atomic counter to only let one CPU grab the task wont work, because
the task may have a limited affinity, and we may pick the wrong
CPU to take that lock and do the pull, to only find out that the
CPU we picked isn't in the task's affinity.

Instead of doing the PULL, I now have the CPUs that want the pull to
send over an IPI to the overloaded CPU, and let that CPU pick what
CPU to push the task to. No more need to grab the rq lock, and the
push/pull algorithm still works fine.

With this patch, the latency dropped to just 150us over a 20 hour run.
Without the patch, the huge latencies would trigger in seconds.

Now, this issue only seems to apply to boxes with greater than 16 CPUs.
We noticed this on a 24 CPU box, and things got much worse on 40 (and
presumably more CPUs would get even worse yet). But running with 16
CPUs and below, the lock contention caused by the pulling of RT tasks
is not noticable.

I've created a new sched feature called RT_PUSH_IPI, which by default
on 16 and less core CPUs is disabled, and on 17 or more CPUs it is
enabled. That seems to be heuristic limit where the pulling logic
causes higher latencies than IPIs. Of course with all heuristics, things
could be different with different architectures.

When RT_PUSH_IPI is not enabled, the old method of grabbing the rq locks
and having the pulling CPU do the work is implemented. When RT_PUSH_IPI
is enabled, the IPI is sent to the overloaded CPU to do a push.

To enabled or disable this at run time:

 # mount -t debugfs nodev /sys/kernel/debug
 # echo RT_PUSH_IPI > /sys/kernel/debug/sched_features
or
 # echo NO_RT_PUSH_IPI > /sys/kernel/debug/sched_features

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

---
 kernel/sched/core.c     |   18 ++++++++++++++++++
 kernel/sched/features.h |   14 ++++++++++++++
 kernel/sched/rt.c       |   37 +++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |    5 +++++
 4 files changed, 74 insertions(+)

Index: linux-rt.git/kernel/sched/core.c
===================================================================
--- linux-rt.git.orig/kernel/sched/core.c	2015-02-04 14:08:15.688111069 -0500
+++ linux-rt.git/kernel/sched/core.c	2015-02-04 14:08:17.382088074 -0500
@@ -1582,6 +1582,9 @@
 	 */
 	preempt_fold_need_resched();
 
+	if (sched_feat(RT_PUSH_IPI))
+		sched_rt_push_check();
+
 	if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
 		return;
 
@@ -7271,6 +7274,21 @@
 		zalloc_cpumask_var(&cpu_isolated_map, GFP_NOWAIT);
 	idle_thread_set_boot_cpu();
 	set_cpu_rq_start_time();
+
+	/*
+	 * To avoid heavy contention on large CPU boxes,
+	 * when there is an RT overloaded CPU (two or more RT tasks
+	 * queued to run on a CPU and one of the waiting RT tasks
+	 * can migrate) and another CPU lowers its priority, instead
+	 * of grabbing both rq locks of the CPUS (as many CPUs lowering
+	 * their priority at the same time may create large latencies)
+	 * send an IPI to the CPU that is overloaded so that it can
+	 * do an efficent push.
+	 */
+	if (num_possible_cpus() > 16) {
+		sched_feat_enable(__SCHED_FEAT_RT_PUSH_IPI);
+		sysctl_sched_features |= (1UL << __SCHED_FEAT_RT_PUSH_IPI);
+	}
 #endif
 	init_sched_fair_class();
 
Index: linux-rt.git/kernel/sched/rt.c
===================================================================
--- linux-rt.git.orig/kernel/sched/rt.c	2015-02-04 14:08:15.688111069 -0500
+++ linux-rt.git/kernel/sched/rt.c	2015-02-04 14:08:17.383088061 -0500
@@ -1760,6 +1760,31 @@
 		;
 }
 
+/**
+ * sched_rt_push_check - check if we can push waiting RT tasks
+ *
+ * Called from sched IPI when sched feature RT_PUSH_IPI is enabled.
+ *
+ * Checks if there is an RT task that can migrate and there exists
+ * a CPU in its affinity that only has tasks lower in priority than
+ * the waiting RT task. If so, then it will push the task off to that
+ * CPU.
+ */
+void sched_rt_push_check(void)
+{
+	struct rq *rq = cpu_rq(smp_processor_id());
+
+	if (WARN_ON_ONCE(!irqs_disabled()))
+		return;
+
+	if (!has_pushable_tasks(rq))
+		return;
+
+	raw_spin_lock(&rq->lock);
+	push_rt_tasks(rq);
+	raw_spin_unlock(&rq->lock);
+}
+
 static int pull_rt_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, ret = 0, cpu;
@@ -1793,6 +1818,18 @@
 			continue;
 
 		/*
+		 * When the RT_PUSH_IPI sched feature is enabled, instead
+		 * of trying to grab the rq lock of the RT overloaded CPU
+		 * send an IPI to that CPU instead. This prevents heavy
+		 * contention from several CPUs lowering its priority
+		 * and all trying to grab the rq lock of that overloaded CPU.
+		 */
+		if (sched_feat(RT_PUSH_IPI)) {
+			smp_send_reschedule(cpu);
+			continue;
+		}
+
+		/*
 		 * We can potentially drop this_rq's lock in
 		 * double_lock_balance, and another CPU could
 		 * alter this_rq
Index: linux-rt.git/kernel/sched/sched.h
===================================================================
--- linux-rt.git.orig/kernel/sched/sched.h	2015-02-04 14:08:15.688111069 -0500
+++ linux-rt.git/kernel/sched/sched.h	2015-02-04 14:08:17.392087939 -0500
@@ -1507,6 +1507,8 @@
 		__release(rq2->lock);
 }
 
+void sched_rt_push_check(void);
+
 #else /* CONFIG_SMP */
 
 /*
@@ -1540,6 +1542,9 @@
 	__release(rq2->lock);
 }
 
+void sched_rt_push_check(void)
+{
+}
 #endif
 
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
Index: linux-rt.git/kernel/sched/features.h
===================================================================
--- linux-rt.git.orig/kernel/sched/features.h	2015-02-04 14:08:15.688111069 -0500
+++ linux-rt.git/kernel/sched/features.h	2015-02-04 14:08:17.392087939 -0500
@@ -56,6 +56,20 @@
  */
 SCHED_FEAT(TTWU_QUEUE, true)
 
+/*
+ * In order to avoid a thundering herd attack of CPUS that are
+ * lowering their priorities at the same time, and there being
+ * a single CPU that has an RT task that can migrate and is waiting
+ * to run, where the other CPUs will try to take that CPUs
+ * rq lock and possibly create a large contention, sending an
+ * IPI to that CPU and let that CPU push the RT task to where
+ * it should go may be a better scenario.
+ *
+ * This is default off for machines with <= 16 CPUs, and will
+ * be turned on at boot up for machines with > 16 CPUs.
+ */
+SCHED_FEAT(RT_PUSH_IPI, false)
+
 SCHED_FEAT(FORCE_SD_OVERLAP, false)
 SCHED_FEAT(RT_RUNTIME_SHARE, true)
 SCHED_FEAT(LB_MIN, false)
