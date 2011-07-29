From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 3/3] cpupri: Add atomic vector count to speed up loop
Date: Fri, 29 Jul 2011 11:13:43 -0400
Message-ID: <20110729151955.158931181@goodmis.org>
References: <20110729151340.419467771@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:32807 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab1G2PT5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 11:19:57 -0400
Content-Disposition: inline; filename=sched-cpupri-atomic.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Index: linux-rt.git/kernel/sched_cpupri.h
===================================================================
--- linux-rt.git.orig/kernel/sched_cpupri.h
+++ linux-rt.git/kernel/sched_cpupri.h
@@ -12,8 +12,8 @@
 /* values 2-101 are RT priorities 0-99 */
 
 struct cpupri_vec {
-	int        count;
-	cpumask_var_t mask;
+	atomic_t	count;
+	cpumask_var_t	mask;
 };
 
 struct cpupri {
Index: linux-rt.git/kernel/sched_cpupri.c
===================================================================
--- linux-rt.git.orig/kernel/sched_cpupri.c
+++ linux-rt.git/kernel/sched_cpupri.c
@@ -122,9 +122,6 @@ static int convert_prio(int prio)
 	return cpupri;
 }
 
-#define for_each_cpupri_active(array, idx)		\
-	for(idx = 0; (idx) < MAX_RT_PRIO; (idx)++)
-
 /**
  * cpupri_find - find the best (lowest-pri) CPU in the system
  * @cp: The cpupri context
@@ -147,16 +144,31 @@ int cpupri_find(struct cpupri *cp, struc
 	int                  task_pri = convert_prio(p->prio);
 
 	cpupri_start_loop();
-	for_each_cpupri_active(cp->pri_active, idx) {
-		struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
+	if (task_pri >= MAX_RT_PRIO)
+		return 0;
 
-		if (idx >= task_pri)
-			break;
+	for (idx = 0; idx < task_pri; idx++) {
+		struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
 
+		if (!atomic_read(&(vec)->count))
+			continue;
 		/*
-		 * When a mask is updated, the new prio is set before
-		 * the old prio is cleared. This makes sure that we
-		 * don't miss this run queue.
+		 * When looking at the vector, we need to read the counter,
+		 * do a memory barrier, then read the mask.
+		 *
+		 * Note: This is still all racey, but we can deal with it.
+		 *  Ideally, we only want to look at masks that are set.
+		 *
+		 *  If a mask is not set, then the only thing wrong is that we
+		 *  did a little more work than necessary.
+		 *
+		 *  If we read a zero count but the mask is set, because of the
+		 *  memory barriers, that can only happen when the highest prio
+		 *  task for a run queue has left the run queue, in which case,
+		 *  it will be followed by a pull. If the task we are processing
+		 *  fails to find a proper place to go, that pull request will
+		 *  pull this task if the run queue is running at a lower
+		 *  priority.
 		 */
 		smp_rmb();
 
@@ -220,15 +232,23 @@ void cpupri_set(struct cpupri *cp, int c
 		struct cpupri_vec *vec = &cp->pri_to_cpu[newpri];
 
 		cpumask_set_cpu(cpu, vec->mask);
+		/*
+		 * When adding a new vector, we update the mask first,
+		 * do a write memory barrier, and then update the count, to
+		 * make sure the vector is visible when count is set.
+		 */
+		smp_wmb();
+		atomic_inc(&(vec)->count);
 	}
-	/*
-	 * Set the new prio before clearing the old prio so we
-	 * don't miss this run queue during the loop.
-	 */
-	smp_wmb();
 	if (likely(oldpri != CPUPRI_INVALID)) {
 		struct cpupri_vec *vec  = &cp->pri_to_cpu[oldpri];
 
+		/*
+		 * When removing from the vector, we decrement the counter first
+		 * do a memory barrier and then clear the mask.
+		 */
+		atomic_dec(&(vec)->count);
+		smp_wmb();
 		cpumask_clear_cpu(cpu, vec->mask);
 	}
 	cpupri_stop_vec();
@@ -252,7 +272,7 @@ int cpupri_init(struct cpupri *cp)
 	for (i = 0; i < CPUPRI_NR_PRIORITIES; i++) {
 		struct cpupri_vec *vec = &cp->pri_to_cpu[i];
 
-		vec->count = 0;
+		atomic_set(&vec->count, 0);
 		if (!zalloc_cpumask_var(&vec->mask, GFP_KERNEL))
 			goto cleanup;
 	}

