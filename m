From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 8/8] sched: Fixup task CPUs for potential proxies.
Date: Tue,  9 Oct 2018 11:24:34 +0200
Message-ID: <20181009092434.26221-9-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

When a mutex owner with potential proxies wakes up those proxies are
activated as well, on the same CPU of the owner. They might have been
sleeping on a different CPU however.

Fixup potential proxies CPU at wakeup time before activating them (or
they get woken up with a wrong CPU reference).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 54003515fd29..0314afe4ba80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1664,6 +1664,14 @@ static inline void ttwu_activate(struct rq *rq, struct task_struct *p, int en_fl
 					 blocked_entry);
 
 		list_del_init(&pp->blocked_entry);
+		/* XXX can't call set_task_cpu() because we are not holding
+		 * neither pp->pi_lock nor task's rq lock. This should however
+		 * be fine as this task can't be woken up as it is blocked on
+		 * this mutex atm.
+		 * A problem however might be that __set_task_cpu() calls
+		 * set_task_rq() which deals with groups and such...
+		 */
+		__set_task_cpu(pp, cpu_of(rq));
 		activate_task(rq, pp, en_flags);
 		pp->on_rq = TASK_ON_RQ_QUEUED;
 		resched_curr(rq);
@@ -3847,7 +3855,8 @@ static void __sched notrace __schedule(bool preempt)
 			 * whether it wants to wake up a task to maintain
 			 * concurrency.
 			 */
-			if (prev->flags & PF_WQ_WORKER) {
+			if ((prev->flags & PF_WQ_WORKER) &&
+			    !task_is_blocked(prev)) {
 				struct task_struct *to_wakeup;
 
 				to_wakeup = wq_worker_sleeping(prev);
-- 
2.17.1
