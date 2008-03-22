From: Ankita Garg <ankita@in.ibm.com>
Subject: [RT] [PATCH] Make scheduler root_domain modular (sched_class
	specific)
Date: Sat, 22 Mar 2008 19:59:15 +0530
Message-ID: <20080322142915.GA9478@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
	Gregory Haskins <ghaskins@novell.com>,
	LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([59.145.155.5]:38163 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbYCVO3T (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 22 Mar 2008 10:29:19 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Thanks Gregory for clarifying my question on root_domains infrastructure. What
I was effectively mentioning on irc the other day was to make the root_domain
infrastructure modular, ie sched_class specific. Currently, only rt is making
use of this infrasture. Making it modular would enable ease of extension to
other sched_classes if required. Trivial patch to that effect.

Patch compile and boot tested.


Signed-off-by: Ankita Garg <ankita@in.ibm.com> 

Index: linux-2.6.24.3-rt3/kernel/sched.c
===================================================================
--- linux-2.6.24.3-rt3.orig/kernel/sched.c	2008-03-21 22:57:04.000000000 +0530
+++ linux-2.6.24.3-rt3/kernel/sched.c	2008-03-21 23:04:56.000000000 +0530
@@ -337,11 +337,8 @@
  * object.
  *
  */
-struct root_domain {
-	atomic_t refcount;
-	cpumask_t span;
-	cpumask_t online;
 
+struct rt_root_domain {
 	/*
 	 * The "RT overload" flag: it gets set if a CPU has more than
 	 * one runnable RT task.
@@ -353,6 +350,14 @@
 #endif
 };
 
+struct root_domain {
+	atomic_t refcount;
+	cpumask_t span;
+	cpumask_t online;
+
+	struct rt_root_domain rt_dom;
+};
+
 /*
  * By default the system creates a single root-domain with all cpus as
  * members (mimicking the global state we have today).
@@ -6332,7 +6337,7 @@
 	cpus_clear(rd->span);
 	cpus_clear(rd->online);
 
-	cpupri_init(&rd->cpupri);
+	cpupri_init(&rd->rt_dom.cpupri);
 
 }
 
Index: linux-2.6.24.3-rt3/kernel/sched_rt.c
===================================================================
--- linux-2.6.24.3-rt3.orig/kernel/sched_rt.c	2008-03-21 22:57:04.000000000 +0530
+++ linux-2.6.24.3-rt3/kernel/sched_rt.c	2008-03-21 23:04:39.000000000 +0530
@@ -7,12 +7,12 @@
 
 static inline int rt_overloaded(struct rq *rq)
 {
-	return atomic_read(&rq->rd->rto_count);
+	return atomic_read(&rq->rd->rt_dom.rto_count);
 }
 
 static inline void rt_set_overload(struct rq *rq)
 {
-	cpu_set(rq->cpu, rq->rd->rto_mask);
+	cpu_set(rq->cpu, rq->rd->rt_dom.rto_mask);
 	/*
 	 * Make sure the mask is visible before we set
 	 * the overload count. That is checked to determine
@@ -21,14 +21,14 @@
 	 * updated yet.
 	 */
 	wmb();
-	atomic_inc(&rq->rd->rto_count);
+	atomic_inc(&rq->rd->rt_dom.rto_count);
 }
 
 static inline void rt_clear_overload(struct rq *rq)
 {
 	/* the order here really doesn't matter */
-	atomic_dec(&rq->rd->rto_count);
-	cpu_clear(rq->cpu, rq->rd->rto_mask);
+	atomic_dec(&rq->rd->rt_dom.rto_count);
+	cpu_clear(rq->cpu, rq->rd->rt_dom.rto_mask);
 }
 
 static void update_rt_migration(struct rq *rq)
@@ -78,7 +78,7 @@
 #ifdef CONFIG_SMP
 	if (p->prio < rq->rt.highest_prio) {
 		rq->rt.highest_prio = p->prio;
-		cpupri_set(&rq->rd->cpupri, rq->cpu, p->prio);
+		cpupri_set(&rq->rd->rt_dom.cpupri, rq->cpu, p->prio);
 	}
 	if (p->nr_cpus_allowed > 1)
 		rq->rt.rt_nr_migratory++;
@@ -114,7 +114,7 @@
 	}
 
 	if (rq->rt.highest_prio != highest_prio)
-		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio);
+		cpupri_set(&rq->rd->rt_dom.cpupri, rq->cpu, rq->rt.highest_prio);
 
 	update_rt_migration(rq);
 #endif /* CONFIG_SMP */
@@ -363,7 +363,7 @@
 {
 	int count;
 
-	count = cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask);
+	count = cpupri_find(&task_rq(task)->rd->rt_dom.cpupri, task, lowest_mask);
 
 	/*
 	 * cpupri cannot efficiently tell us how many bits are set, so it only
@@ -599,7 +599,7 @@
 
 	next = pick_next_task_rt(this_rq);
 
-	for_each_cpu_mask(cpu, this_rq->rd->rto_mask) {
+	for_each_cpu_mask(cpu, this_rq->rd->rt_dom.rto_mask) {
 		if (this_cpu == cpu)
 			continue;
 
@@ -763,7 +763,7 @@
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
 
-	cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio);
+	cpupri_set(&rq->rd->rt_dom.cpupri, rq->cpu, rq->rt.highest_prio);
 }
 
 /* Assumes rq->lock is held */
@@ -772,7 +772,7 @@
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
 
-	cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_INVALID);
+	cpupri_set(&rq->rd->rt_dom.cpupri, rq->cpu, CPUPRI_INVALID);
 }
 
 /*

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
