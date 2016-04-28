From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH RFC -rt] mm: perform lru_add_drain_all() remotely
Date: Thu, 28 Apr 2016 16:31:55 -0400
Message-ID: <20160428163155.350b54ab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: riel@redhat.com, bigeasy@linutronix.de, tglx@linutronix.de,
	srostedt@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbcD1UcA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Apr 2016 16:32:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 include/linux/locallock.h | 27 +++++++++++++++++++++++++++
 mm/swap.c                 | 35 +++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 6fe5928..2de478b 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -104,6 +104,17 @@ static inline void __local_unlock(struct local_irq_lock *lv)
 		put_local_var(lvar);				\
 	} while (0)
 
+#define local_lock_other_cpu(lvar, cpu)                         \
+	do {                                                    \
+		__local_lock(&per_cpu(lvar, cpu));              \
+	} while (0)
+
+#define local_unlock_other_cpu(lvar, cpu)                       \
+	do {                                                    \
+		__local_unlock(&per_cpu(lvar, cpu));            \
+	} while (0)
+
+
 static inline void __local_lock_irq(struct local_irq_lock *lv)
 {
 	spin_lock_irqsave(&lv->lock, lv->flags);
@@ -163,6 +174,22 @@ static inline int __local_lock_irqsave(struct local_irq_lock *lv)
 		_flags = per_cpu(lvar, cpu).flags;			\
 	} while (0)
 
+#define local_lock_irqsave_other_cpu(lvar, _flags, cpu)			\
+	do {								\
+		if (cpu == smp_processor_id())				\
+			local_lock_irqsave(lvar, _flags);		\
+		else							\
+			local_lock_other_cpu(lvar, cpu);		\
+	} while (0)
+
+#define local_unlock_irqrestore_other_cpu(lvar, _flags, cpu)	        \
+	do {								\
+		if (cpu == smp_processor_id())				\
+			local_unlock_irqrestore(lvar, _flags);		\
+		else							\
+			local_unlock_other_cpu(lvar, cpu);		\
+	} while (0)
+
 static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 					    unsigned long flags)
 {
diff --git a/mm/swap.c b/mm/swap.c
index ca194ae..9dc6956 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -821,9 +821,9 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
-		local_lock_irqsave(rotate_lock, flags);
+		local_lock_irqsave_other_cpu(rotate_lock, flags, cpu);
 		pagevec_move_tail(pvec);
-		local_unlock_irqrestore(rotate_lock, flags);
+		local_unlock_irqrestore_other_cpu(rotate_lock, flags, cpu);
 	}
 
 	pvec = &per_cpu(lru_deactivate_file_pvecs, cpu);
@@ -866,12 +866,32 @@ void lru_add_drain(void)
 	local_unlock_cpu(swapvec_lock);
 }
 
+static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+
+#ifdef CONFIG_PREEMPT_RT_BASE
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	local_lock_other_cpu(swapvec_lock, cpu);
+	lru_add_drain_cpu(cpu);
+	local_unlock_other_cpu(swapvec_lock, cpu);
+}
+#else
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
 	lru_add_drain();
 }
 
-static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+
+		INIT_WORK(work, lru_add_drain_per_cpu);
+		schedule_work_on(cpu, work);
+		cpumask_set_cpu(cpu, &has_work);
+
+}
+#endif
+
 
 void lru_add_drain_all(void)
 {
@@ -884,16 +904,11 @@ void lru_add_drain_all(void)
 	cpumask_clear(&has_work);
 
 	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
