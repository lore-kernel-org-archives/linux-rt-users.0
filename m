Return-Path: <SRS0=dTXG=3J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55D2C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Jan 2020 11:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826A520882
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Jan 2020 11:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgATLa4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:30:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33087 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATLa4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Jan 2020 06:30:56 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1itVGd-0006hg-Ag; Mon, 20 Jan 2020 12:30:51 +0100
Date:   Mon, 20 Jan 2020 12:30:51 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.13-rt7
Message-ID: <20200120113051.6z6xumnybaloe4l7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.13-rt7 patch set. 

Changes since v5.4.13-rt6:

  - Remove early state change to STATE_RUNNING in do_nanosleep(), it is no
    longer needed.

  - Remove memory allocation in on_each_cpu_cond_mask() which may lead
    to a "sleeping-while-atomic" warning. Reported by Scott Wood.

Known issues
     - None

The delta patch against v5.4.13-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.13-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.13-rt7

The RT patch against v5.4.13 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.13-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.13-rt7.tar.xz

Sebastian

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e6a9edc5baaf0..66f96f21a7b60 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -708,7 +708,7 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 			       (void *)info, 1);
 	else
 		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
-				(void *)info, 1, GFP_ATOMIC, cpumask);
+				(void *)info, 1, cpumask);
 }
 
 /*
diff --git a/fs/buffer.c b/fs/buffer.c
index 0c3cd9b250a62..0d374ff8ff69b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1387,7 +1387,7 @@ static bool has_bh_in_lru(int cpu, void *dummy)
 
 void invalidate_bh_lrus(void)
 {
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1, GFP_KERNEL);
+	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 3b9b782e59088..01ff6ed61591f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -15,6 +15,7 @@
 #include <linux/llist.h>
 
 typedef void (*smp_call_func_t)(void *info);
+typedef bool (*smp_cond_func_t)(int cpu, void *info);
 struct __call_single_data {
 	struct llist_node llist;
 	smp_call_func_t func;
@@ -49,13 +50,11 @@ void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
  * cond_func returns a positive value. This may include the local
  * processor.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags);
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait);
 
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags, const struct cpumask *mask);
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask);
 
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc0..d0ada39eb4d41 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -395,22 +395,9 @@ int smp_call_function_any(const struct cpumask *mask,
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
-/**
- * smp_call_function_many(): Run a function on a set of other CPUs.
- * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * If @wait is true, then returns once @func has returned.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler. Preemption
- * must be disabled when calling this function.
- */
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait)
+static void smp_call_function_many_cond(const struct cpumask *mask,
+					smp_call_func_t func, void *info,
+					bool wait, smp_cond_func_t cond_func)
 {
 	struct call_function_data *cfd;
 	int cpu, next_cpu, this_cpu = smp_processor_id();
@@ -448,7 +435,8 @@ void smp_call_function_many(const struct cpumask *mask,
 
 	/* Fastpath: do that cpu by itself. */
 	if (next_cpu >= nr_cpu_ids) {
-		smp_call_function_single(cpu, func, info, wait);
+		if (!cond_func || cond_func(cpu, info))
+			smp_call_function_single(cpu, func, info, wait);
 		return;
 	}
 
@@ -465,6 +453,9 @@ void smp_call_function_many(const struct cpumask *mask,
 	for_each_cpu(cpu, cfd->cpumask) {
 		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
+		if (cond_func && !cond_func(cpu, info))
+			continue;
+
 		csd_lock(csd);
 		if (wait)
 			csd->flags |= CSD_FLAG_SYNCHRONOUS;
@@ -486,6 +477,26 @@ void smp_call_function_many(const struct cpumask *mask,
 		}
 	}
 }
+
+/**
+ * smp_call_function_many(): Run a function on a set of other CPUs.
+ * @mask: The set of cpus to run on (only runs on online subset).
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
+ *
+ * If @wait is true, then returns once @func has returned.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler. Preemption
+ * must be disabled when calling this function.
+ */
+void smp_call_function_many(const struct cpumask *mask,
+			    smp_call_func_t func, void *info, bool wait)
+{
+	smp_call_function_many_cond(mask, func, info, wait, NULL);
+}
 EXPORT_SYMBOL(smp_call_function_many);
 
 /**
@@ -668,11 +679,6 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * @info:	An arbitrary pointer to pass to both functions.
  * @wait:	If true, wait (atomically) until function has
  *		completed on other CPUs.
- * @gfp_flags:	GFP flags to use when allocating the cpumask
- *		used internally by the function.
- *
- * The function might sleep if the GFP flags indicates a non
- * atomic allocation is allowed.
  *
  * Preemption is disabled to protect against CPUs going offline but not online.
  * CPUs going online during the call will not be seen or sent an IPI.
@@ -680,46 +686,27 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * You must not call this function with disabled interrupts or
  * from a hardware interrupt handler or from a bottom half handler.
  */
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags, const struct cpumask *mask)
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask)
 {
-	cpumask_var_t cpus;
-	int cpu, ret;
+	int cpu = get_cpu();
 
-	might_sleep_if(gfpflags_allow_blocking(gfp_flags));
+	smp_call_function_many_cond(mask, func, info, wait, cond_func);
+	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
+		unsigned long flags;
 
-	if (likely(zalloc_cpumask_var(&cpus, (gfp_flags|__GFP_NOWARN)))) {
-		preempt_disable();
-		for_each_cpu(cpu, mask)
-			if (cond_func(cpu, info))
-				__cpumask_set_cpu(cpu, cpus);
-		on_each_cpu_mask(cpus, func, info, wait);
-		preempt_enable();
-		free_cpumask_var(cpus);
-	} else {
-		/*
-		 * No free cpumask, bother. No matter, we'll
-		 * just have to IPI them one by one.
-		 */
-		preempt_disable();
-		for_each_cpu(cpu, mask)
-			if (cond_func(cpu, info)) {
-				ret = smp_call_function_single(cpu, func,
-								info, wait);
-				WARN_ON_ONCE(ret);
-			}
-		preempt_enable();
+		local_irq_save(flags);
+		func(info);
+		local_irq_restore(flags);
 	}
+	put_cpu();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait)
 {
-	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
-				cpu_online_mask);
+	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f583000140c9f..41cc1c8530d88 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1873,12 +1873,12 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 		if (likely(t->task))
 			freezable_schedule();
 
-		__set_current_state(TASK_RUNNING);
 		hrtimer_cancel(&t->timer);
 		mode = HRTIMER_MODE_ABS;
 
 	} while (t->task && !signal_pending(current));
 
+	__set_current_state(TASK_RUNNING);
 
 	if (!t->task)
 		return 0;
diff --git a/kernel/up.c b/kernel/up.c
index 862b460ab97a8..53144d0562522 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -68,9 +68,8 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * Preemption is disabled here to make sure the cond_func is called under the
  * same condtions in UP and SMP.
  */
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-			   smp_call_func_t func, void *info, bool wait,
-			   gfp_t gfp_flags, const struct cpumask *mask)
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask)
 {
 	unsigned long flags;
 
@@ -84,11 +83,10 @@ void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		      smp_call_func_t func, void *info, bool wait,
-		      gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait)
 {
-	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags, NULL);
+	on_each_cpu_cond_mask(cond_func, func, info, wait, NULL);
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
 
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/mm/slub.c b/mm/slub.c
index 77020de62fc6a..ff4ee1e3a4e6d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2380,7 +2380,7 @@ static void flush_all(struct kmem_cache *s)
 	LIST_HEAD(tofree);
 	int cpu;
 
-	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1, GFP_ATOMIC);
+	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
 	for_each_online_cpu(cpu) {
 		struct slub_free_list *f;
 
