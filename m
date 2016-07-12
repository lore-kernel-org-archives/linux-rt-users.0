From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/11] mm: perform lru_add_drain_all() remotely
Date: Tue, 12 Jul 2016 12:49:58 -0400
Message-ID: <20160712165021.808877102@goodmis.org>
References: <20160712164950.490572026@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Rik van Riel <riel@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0008-mm-perform-lru_add_drain_all-remotely.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.61-rt82-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Luiz Capitulino <lcapitulino@redhat.com>

lru_add_drain_all() works by scheduling lru_add_drain_cpu() to run
on all CPUs that have non-empty LRU pagevecs and then waiting for
the scheduled work to complete. However, workqueue threads may never
have the chance to run on a CPU that's running a SCHED_FIFO task.
This causes lru_add_drain_all() to block forever.

This commit solves this problem by changing lru_add_drain_all()
to drain the LRU pagevecs of remote CPUs. This is done by grabbing
swapvec_lock and calling lru_add_drain_cpu().

PS: This is based on an idea and initial implementation by
    Rik van Riel.

Signed-off-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/swap.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 8ab73ba62a68..05e75d61c707 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -718,9 +718,15 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
+#ifdef CONFIG_PREEMPT_RT_BASE
+		local_lock_irqsave_on(rotate_lock, flags, cpu);
+		pagevec_move_tail(pvec);
+		local_unlock_irqrestore_on(rotate_lock, flags, cpu);
+#else
 		local_lock_irqsave(rotate_lock, flags);
 		pagevec_move_tail(pvec);
 		local_unlock_irqrestore(rotate_lock, flags);
+#endif
 	}
 
 	pvec = &per_cpu(lru_deactivate_pvecs, cpu);
@@ -763,12 +769,32 @@ void lru_add_drain(void)
 	local_unlock_cpu(swapvec_lock);
 }
 
+
+#ifdef CONFIG_PREEMPT_RT_BASE
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	local_lock_on(swapvec_lock, cpu);
+	lru_add_drain_cpu(cpu);
+	local_unlock_on(swapvec_lock, cpu);
+}
+
+#else
+
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
 	lru_add_drain();
 }
 
 static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+
+	INIT_WORK(work, lru_add_drain_per_cpu);
+	schedule_work_on(cpu, work);
+	cpumask_set_cpu(cpu, has_work);
+}
+#endif
 
 void lru_add_drain_all(void)
 {
@@ -781,20 +807,17 @@ void lru_add_drain_all(void)
 	cpumask_clear(&has_work);
 
 	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
-
 		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
 		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
-		    need_activate_page_drain(cpu)) {
-			INIT_WORK(work, lru_add_drain_per_cpu);
-			schedule_work_on(cpu, work);
-			cpumask_set_cpu(cpu, &has_work);
-		}
+		    need_activate_page_drain(cpu))
+			remote_lru_add_drain(cpu, &has_work);
 	}
 
+#ifndef CONFIG_PREEMPT_RT_BASE
 	for_each_cpu(cpu, &has_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
+#endif
 
 	put_online_cpus();
 	mutex_unlock(&lock);
-- 
2.8.1
