From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 2/3] cpupri: Remove vector locks and read entire loop
Date: Fri, 29 Jul 2011 11:13:42 -0400
Message-ID: <20110729151954.908564429@goodmis.org>
References: <20110729151340.419467771@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:32807 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab1G2PT5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 11:19:57 -0400
Content-Disposition: inline; filename=sched-cpupri-nolock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Index: linux-rt.git/kernel/sched_cpupri.c
===================================================================
--- linux-rt.git.orig/kernel/sched_cpupri.c
+++ linux-rt.git/kernel/sched_cpupri.c
@@ -122,8 +122,8 @@ static int convert_prio(int prio)
 	return cpupri;
 }
 
-#define for_each_cpupri_active(array, idx)                    \
-	for_each_set_bit(idx, array, CPUPRI_NR_PRIORITIES)
+#define for_each_cpupri_active(array, idx)		\
+	for(idx = 0; (idx) < MAX_RT_PRIO; (idx)++)
 
 /**
  * cpupri_find - find the best (lowest-pri) CPU in the system
@@ -153,6 +153,13 @@ int cpupri_find(struct cpupri *cp, struc
 		if (idx >= task_pri)
 			break;
 
+		/*
+		 * When a mask is updated, the new prio is set before
+		 * the old prio is cleared. This makes sure that we
+		 * don't miss this run queue.
+		 */
+		smp_rmb();
+
 		if (cpumask_any_and(&p->cpus_allowed, vec->mask) >= nr_cpu_ids)
 			continue;
 
@@ -193,7 +200,6 @@ void cpupri_set(struct cpupri *cp, int c
 {
 	int                 *currpri = &cp->cpu_to_pri[cpu];
 	int                  oldpri  = *currpri;
-	unsigned long        flags;
 
 	newpri = convert_prio(newpri);
 
@@ -213,26 +219,17 @@ void cpupri_set(struct cpupri *cp, int c
 	if (likely(newpri != CPUPRI_INVALID)) {
 		struct cpupri_vec *vec = &cp->pri_to_cpu[newpri];
 
-		raw_spin_lock_irqsave(&vec->lock, flags);
-
 		cpumask_set_cpu(cpu, vec->mask);
-		vec->count++;
-		if (vec->count == 1)
-			set_bit(newpri, cp->pri_active);
-
-		raw_spin_unlock_irqrestore(&vec->lock, flags);
 	}
+	/*
+	 * Set the new prio before clearing the old prio so we
+	 * don't miss this run queue during the loop.
+	 */
+	smp_wmb();
 	if (likely(oldpri != CPUPRI_INVALID)) {
 		struct cpupri_vec *vec  = &cp->pri_to_cpu[oldpri];
 
-		raw_spin_lock_irqsave(&vec->lock, flags);
-
-		vec->count--;
-		if (!vec->count)
-			clear_bit(oldpri, cp->pri_active);
 		cpumask_clear_cpu(cpu, vec->mask);
-
-		raw_spin_unlock_irqrestore(&vec->lock, flags);
 	}
 	cpupri_stop_vec();
 
@@ -255,7 +252,6 @@ int cpupri_init(struct cpupri *cp)
 	for (i = 0; i < CPUPRI_NR_PRIORITIES; i++) {
 		struct cpupri_vec *vec = &cp->pri_to_cpu[i];
 
-		raw_spin_lock_init(&vec->lock);
 		vec->count = 0;
 		if (!zalloc_cpumask_var(&vec->mask, GFP_KERNEL))
 			goto cleanup;
Index: linux-rt.git/kernel/sched_cpupri.h
===================================================================
--- linux-rt.git.orig/kernel/sched_cpupri.h
+++ linux-rt.git/kernel/sched_cpupri.h
@@ -12,7 +12,6 @@
 /* values 2-101 are RT priorities 0-99 */
 
 struct cpupri_vec {
-	raw_spinlock_t lock;
 	int        count;
 	cpumask_var_t mask;
 };

