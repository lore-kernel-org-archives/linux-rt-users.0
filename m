From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH RT] sched/core: Avoid__schedule() being called twice, the second in vain
Date: Mon, 30 Jul 2018 15:00:00 +0200
Message-ID: <ad2b29b5715f970bffc1a7026cabd6ff0b24076a.1532952814.git.bristot@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Romulo da Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Before calling __schedule() to cause a context switch, the schedule()
function runs sched_submit_work() to dispatch deferred work that was
postponed to the point that the thread is leaving the processor.
The function sched_submit_work() checks for the need to wake up a
kworker; if needed, a kworker thread is awakened. In this context,
the following behavior takes place.

A kworker (let's call it kworker_1) is running and enqueue a postponed
work (this is possible). kworker_1 then set its state as "sleepable" and
calls schedule() to leave the processor.

At this point, the kworker_1 is in line 1 of the pseudo-code like
bellow.

----------------------------- %< ----------------------------------------
  1 void schedule(void)
  2 {
  3	sched_submit_work(){
  4		wq_worker_sleeping() {
  5			preempt_disable();
  6			wakeup(kworker_2);
  7			preempt_enable() {
  8				should_resched() {
  9					__schedule() {
 10						context_switch
 11					}
 12				}
 13			}
 14		}
 15	}
 16	do {
 17		preempt_disable();
 18		__schedule();
 19		sched_preempt_enable_no_resched();
 20	} while (need_resched());
 21	sched_update_worker();
 22 }
----------------------------- >% ----------------------------------------

Then sched_subimit_work() is called. During the execution of
sched_subimit_work(), the preemption is disabled, a second kworker is
awakened (let's call it kworker_2) and then preemption is enabled again.

While in the preempt_enable(), after enabling the preemption, the system
checks if it needs to resched. As a kthread_1 is in sleepable and the
kthread_2 was just awakenedi, this is the case of re-scheduling.
Then the __schedule() is called  at line 9, and a context switch happens
at line 10.

While other threads run, kthread_1 is awakened, is scheduled and return
to the execution at line 11. Continuing the execution, the code return to
the schedule() execution at line 15. Preemption is then disabled and
__schedule() called again at line 18. As the __schedule() just returned
at line 11, there is nothing to schedule, and so the __schedule() at
line 18 is called in vain.

A trace with details of this execution can be found here:
  http://bristot.me/__schedule-being-called-twice-the-second-in-vain/

Knowing that sched_submit_work() is called only inside schedule(), and
that it does not suspend or block, one way to avoid the first schedule is
to disable the preemption before calling wq_worker_sleeping(), and
then use sched_preempt_enable_no_resched() to enable the preemption again
after the return of wq_worker_sleeping().

This patch is RT specific because wq_worker_sleeping() is called with
preemption disabled on non-rt, see -rt patch:
  sched: Distangle worker accounting from rqlock

Note: A "similar" behavior can happen in the blk_schedule_flush_plug(),
but that is different. There, the problem can occur because of
rt_spin_lock(), but we cannot convert them to raw_spin_lock because it
will potentially cause latency spikes.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Cc: Romulo da Silva de Oliveira <romulo.deoliveira@ufsc.br>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
---
 kernel/sched/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 70641e8f3c89..7a48619af3e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3545,9 +3545,16 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	/*
 	 * If a worker went to sleep, notify and ask workqueue whether
 	 * it wants to wake up a task to maintain concurrency.
+	 *
+	 * As this function is called inside the schedule() context,
+	 * we disable preemption to avoid it calling schedule() again
+	 * in the possible wakeup of a kworker.
 	 */
-	if (tsk->flags & PF_WQ_WORKER)
+	if (tsk->flags & PF_WQ_WORKER) {
+		preempt_disable();
 		wq_worker_sleeping(tsk);
+		preempt_enable_no_resched();
+	}
 
 
 	if (tsk_is_pi_blocked(tsk))
-- 
2.17.1
