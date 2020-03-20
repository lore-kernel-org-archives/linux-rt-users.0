Return-Path: <SRS0=7Euv=5F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049CC4332E
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 19:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0193920739
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 19:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCTT2f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:28:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36959 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgCTT2f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Mar 2020 15:28:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jFNJm-0002e2-5Z; Fri, 20 Mar 2020 20:28:30 +0100
Date:   Fri, 20 Mar 2020 20:28:30 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.26-rt17
Message-ID: <20200320192830.zeci3rhh5bgbareg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.26-rt17 patch set. 

Changes since v5.4.26-rt16:

  - Revert the "cross CPU pagevec" access with a static key switch. The
    old behaviour has been almost fully restored: There is no cross CPU
    access of the local_lock. Instead the workqueue is scheduled on
    remote CPU like in the !RT case.

  - Make the `sched_clock_timer' timer expire in hardirq. Patch by Ahmed
    S. Darwish.

  - The preempt-lazy code on 32-bit PowerPC used the wrong mask and
    eventually crashed. Patch by Thomas Graziadei.

  - Remove the warning with more than two waiters on completion which
    was woken up via complete_all().

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.4.26-rt16 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.26-rt16-rt17.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.26-rt17

The RT patch against v5.4.26 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.26-rt17.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.26-rt17.tar.xz

Sebastian

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 172dfb567c25c..ab609d63d6443 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -533,12 +533,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 
 1:	stw	r6,RESULT(r1)	/* Save result */
 	stw	r3,GPR3(r1)	/* Update return value */
-2:	andi.	r0,r9,(_TIF_PERSYSCALL_MASK)@h
+2:	andis.	r0,r9,(_TIF_PERSYSCALL_MASK)@h
 	beq	4f
 
 	/* Clear per-syscall TIF flags if any are set.  */
 
-	li	r11,_TIF_PERSYSCALL_MASK@h
+	lis	r11,(_TIF_PERSYSCALL_MASK)@h
 	addi	r12,r2,TI_FLAGS
 3:	lwarx	r8,0,r12
 	andc	r8,r8,r11
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6ce61770ef343..61f2f6ff94673 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -580,7 +580,6 @@ extern void page_frag_free(void *addr);
 void page_alloc_init(void);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_all_pages(struct zone *zone);
-void drain_cpu_pages(unsigned int cpu, struct zone *zone);
 void drain_local_pages(struct zone *zone);
 
 void page_alloc_init_late(void);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5030ab13db060..cd97d2c8840cc 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -197,12 +197,6 @@ struct platform_s2idle_ops {
 	void (*end)(void);
 };
 
-#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
-extern bool pm_in_action;
-#else
-# define pm_in_action false
-#endif
-
 #ifdef CONFIG_SUSPEND
 extern suspend_state_t mem_sleep_current;
 extern suspend_state_t mem_sleep_default;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 063c0c1e112bd..1ddf6a825468e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
+#include <linux/locallock.h>
 #include <asm/page.h>
 
 struct notifier_block;
@@ -328,6 +329,7 @@ extern unsigned long nr_free_pagecache_pages(void);
 
 
 /* linux/mm/swap.c */
+DECLARE_LOCAL_IRQ_LOCK(swapvec_lock);
 extern void lru_cache_add(struct page *);
 extern void lru_cache_add_anon(struct page *page);
 extern void lru_cache_add_file(struct page *page);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index c8713bbc44810..3c0a5a8170b02 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -689,10 +689,6 @@ static int load_image_and_restore(void)
 	return error;
 }
 
-#ifndef CONFIG_SUSPEND
-bool pm_in_action;
-#endif
-
 /**
  * hibernate - Carry out system hibernation, including saving the image.
  */
@@ -706,8 +702,6 @@ int hibernate(void)
 		return -EPERM;
 	}
 
-	pm_in_action = true;
-
 	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
@@ -784,7 +778,6 @@ int hibernate(void)
 	atomic_inc(&snapshot_device_available);
  Unlock:
 	unlock_system_sleep();
-	pm_in_action = false;
 	pr_info("hibernation exit\n");
 
 	return error;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index a9a6ada0c8e47..27f149f5d4a9f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -595,8 +595,6 @@ static int enter_state(suspend_state_t state)
 	return error;
 }
 
-bool pm_in_action;
-
 /**
  * pm_suspend - Externally visible function for suspending the system.
  * @state: System sleep state to enter.
@@ -611,7 +609,6 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
-	pm_in_action = true;
 	pr_info("suspend entry (%s)\n", mem_sleep_labels[state]);
 	error = enter_state(state);
 	if (error) {
@@ -621,7 +618,6 @@ int pm_suspend(suspend_state_t state)
 		suspend_stats.success++;
 	}
 	pr_info("suspend exit\n");
-	pm_in_action = false;
 	return error;
 }
 EXPORT_SYMBOL(pm_suspend);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a1f9c3f66304c..9fcb2a695a412 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,7 +8,6 @@
  *
  */
 #include "sched.h"
-#include "../../mm/internal.h"
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
@@ -140,21 +139,10 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned int flags;
-	int ret;
 
 	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC;
 
-	ret = housekeeping_setup(str, flags);
-
-	/*
-	 * Protect struct pagevec with a lock instead using preemption disable;
-	 * with lock protection, remote handling of events instead of queue
-	 * work on remote cpu is default behavior.
-	 */
-	if (ret)
-		static_branch_enable(&use_pvec_lock);
-
-	return ret;
+	return housekeeping_setup(str, flags);
 }
 __setup("nohz_full=", housekeeping_nohz_full_setup);
 
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index c58068d2ee06c..c56c315524ae6 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -35,7 +35,6 @@ EXPORT_SYMBOL(swake_up_locked);
 void swake_up_all_locked(struct swait_queue_head *q)
 {
 	struct swait_queue *curr;
-	int wakes = 0;
 
 	while (!list_empty(&q->task_list)) {
 
@@ -43,11 +42,7 @@ void swake_up_all_locked(struct swait_queue_head *q)
 					task_list);
 		wake_up_process(curr->task);
 		list_del_init(&curr->task_list);
-		wakes++;
 	}
-	if (pm_in_action)
-		return;
-	WARN(wakes > 2, "complete_all() with %d waiters\n", wakes);
 }
 EXPORT_SYMBOL(swake_up_all_locked);
 
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index dbd69052eaa66..a5538dd76a819 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -207,7 +207,8 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 
 	if (sched_clock_timer.function != NULL) {
 		/* update timeout for clock wrap */
-		hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+		hrtimer_start(&sched_clock_timer, cd.wrap_kt,
+			      HRTIMER_MODE_REL_HARD);
 	}
 
 	r = rate;
@@ -251,9 +252,9 @@ void __init generic_sched_clock_init(void)
 	 * Start the timer to keep sched_clock() properly updated and
 	 * sets the initial epoch.
 	 */
-	hrtimer_init(&sched_clock_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&sched_clock_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	sched_clock_timer.function = sched_clock_poll;
-	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
 }
 
 /*
@@ -290,7 +291,7 @@ void sched_clock_resume(void)
 	struct clock_read_data *rd = &cd.read_data[0];
 
 	rd->epoch_cyc = cd.actual_read_sched_clock();
-	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
 	rd->read_sched_clock = cd.actual_read_sched_clock;
 }
 
diff --git a/localversion-rt b/localversion-rt
index 1199ebade17b4..1e584b47c987e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt16
+-rt17
diff --git a/mm/compaction.c b/mm/compaction.c
index 03c9e335fa8b0..83cc3d1e5df7b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2244,16 +2244,12 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 				block_start_pfn(cc->migrate_pfn, cc->order);
 
 			if (last_migrated_pfn < current_block_start) {
-				if (static_branch_likely(&use_pvec_lock)) {
-					cpu = raw_smp_processor_id();
-					lru_add_drain_cpu(cpu);
-					drain_cpu_pages(cpu, cc->zone);
-				} else {
-					cpu = get_cpu();
-					lru_add_drain_cpu(cpu);
-					drain_local_pages(cc->zone);
-					put_cpu();
-				}
+				cpu = get_cpu_light();
+				local_lock_irq(swapvec_lock);
+				lru_add_drain_cpu(cpu);
+				local_unlock_irq(swapvec_lock);
+				drain_local_pages(cc->zone);
+				put_cpu_light();
 				/* No more flushing until we migrate again */
 				last_migrated_pfn = 0;
 			}
diff --git a/mm/internal.h b/mm/internal.h
index 874741f333cf8..7dd7fbb577a9a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -32,12 +32,6 @@
 /* Do not use these with a slab allocator */
 #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
 
-#ifdef CONFIG_PREEMPT_RT
-extern struct static_key_true use_pvec_lock;
-#else
-extern struct static_key_false use_pvec_lock;
-#endif
-
 void page_writeback_init(void);
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b9bbc72c073e1..7df9930628c2b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2883,14 +2883,6 @@ static void drain_pages(unsigned int cpu)
 	}
 }
 
-void drain_cpu_pages(unsigned int cpu, struct zone *zone)
-{
-	if (zone)
-		drain_pages_zone(cpu, zone);
-	else
-		drain_pages(cpu);
-}
-
 /*
  * Spill all of this CPU's per-cpu pages back into the buddy allocator.
  *
@@ -2901,7 +2893,10 @@ void drain_local_pages(struct zone *zone)
 {
 	int cpu = smp_processor_id();
 
-	drain_cpu_pages(cpu, zone);
+	if (zone)
+		drain_pages_zone(cpu, zone);
+	else
+		drain_pages(cpu);
 }
 
 static void drain_local_pages_wq(struct work_struct *work)
@@ -2917,9 +2912,9 @@ static void drain_local_pages_wq(struct work_struct *work)
 	 * cpu which is allright but we also have to make sure to not move to
 	 * a different one.
 	 */
-	preempt_disable();
+	migrate_disable();
 	drain_local_pages(drain->zone);
-	preempt_enable();
+	migrate_enable();
 }
 
 /*
@@ -2988,20 +2983,15 @@ void drain_all_pages(struct zone *zone)
 			cpumask_clear_cpu(cpu, &cpus_with_pcps);
 	}
 
-	if (static_branch_likely(&use_pvec_lock)) {
-		for_each_cpu(cpu, &cpus_with_pcps)
-			drain_cpu_pages(cpu, zone);
-	} else {
-		for_each_cpu(cpu, &cpus_with_pcps) {
-			struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
+	for_each_cpu(cpu, &cpus_with_pcps) {
+		struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
 
-			drain->zone = zone;
-			INIT_WORK(&drain->work, drain_local_pages_wq);
-			queue_work_on(cpu, mm_percpu_wq, &drain->work);
-		}
-		for_each_cpu(cpu, &cpus_with_pcps)
-			flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
+		drain->zone = zone;
+		INIT_WORK(&drain->work, drain_local_pages_wq);
+		queue_work_on(cpu, mm_percpu_wq, &drain->work);
 	}
+	for_each_cpu(cpu, &cpus_with_pcps)
+		flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
 
 	mutex_unlock(&pcpu_drain_mutex);
 }
@@ -7686,8 +7676,9 @@ void __init free_area_init(unsigned long *zones_size)
 
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
-
+	local_lock_irq_on(swapvec_lock, cpu);
 	lru_add_drain_cpu(cpu);
+	local_unlock_irq_on(swapvec_lock, cpu);
 	drain_pages(cpu);
 
 	/*
diff --git a/mm/swap.c b/mm/swap.c
index 98accaf51fce8..cdb4f1fa3a483 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -33,6 +33,7 @@
 #include <linux/memcontrol.h>
 #include <linux/gfp.h>
 #include <linux/uio.h>
+#include <linux/locallock.h>
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
 
@@ -44,111 +45,16 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
-#ifdef CONFIG_PREEMPT_RT
-DEFINE_STATIC_KEY_TRUE(use_pvec_lock);
-#else
-DEFINE_STATIC_KEY_FALSE(use_pvec_lock);
-#endif
-
-struct swap_pagevec {
-	spinlock_t	lock;
-	struct pagevec	pvec;
-};
-
-#define DEFINE_PER_CPU_PAGEVEC(lvar)				\
-	DEFINE_PER_CPU(struct swap_pagevec, lvar) = {		\
-		.lock = __SPIN_LOCK_UNLOCKED((lvar).lock) }
-
-static DEFINE_PER_CPU_PAGEVEC(lru_add_pvec);
-static DEFINE_PER_CPU_PAGEVEC(lru_rotate_pvecs);
-static DEFINE_PER_CPU_PAGEVEC(lru_deactivate_file_pvecs);
-static DEFINE_PER_CPU_PAGEVEC(lru_deactivate_pvecs);
-static DEFINE_PER_CPU_PAGEVEC(lru_lazyfree_pvecs);
+static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
+static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
+static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
+static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
+static DEFINE_PER_CPU(struct pagevec, lru_lazyfree_pvecs);
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU_PAGEVEC(activate_page_pvecs);
+static DEFINE_PER_CPU(struct pagevec, activate_page_pvecs);
 #endif
-
-static inline
-struct swap_pagevec *lock_swap_pvec(struct swap_pagevec __percpu *p)
-{
-	struct swap_pagevec *swpvec;
-
-	if (static_branch_likely(&use_pvec_lock)) {
-		swpvec = raw_cpu_ptr(p);
-
-		spin_lock(&swpvec->lock);
-	} else {
-		swpvec = &get_cpu_var(*p);
-	}
-	return swpvec;
-}
-
-static inline struct swap_pagevec *
-lock_swap_pvec_cpu(struct swap_pagevec __percpu *p, int cpu)
-{
-	struct swap_pagevec *swpvec = per_cpu_ptr(p, cpu);
-
-	if (static_branch_likely(&use_pvec_lock))
-		spin_lock(&swpvec->lock);
-
-	return swpvec;
-}
-
-static inline struct swap_pagevec *
-lock_swap_pvec_irqsave(struct swap_pagevec __percpu *p, unsigned long *flags)
-{
-	struct swap_pagevec *swpvec;
-
-	if (static_branch_likely(&use_pvec_lock)) {
-		swpvec = raw_cpu_ptr(p);
-
-		spin_lock_irqsave(&swpvec->lock, (*flags));
-	} else {
-		local_irq_save(*flags);
-
-		swpvec = this_cpu_ptr(p);
-	}
-	return swpvec;
-}
-
-static inline struct swap_pagevec *
-lock_swap_pvec_cpu_irqsave(struct swap_pagevec __percpu *p, int cpu,
-			   unsigned long *flags)
-{
-	struct swap_pagevec *swpvec = per_cpu_ptr(p, cpu);
-
-	if (static_branch_likely(&use_pvec_lock))
-		spin_lock_irqsave(&swpvec->lock, *flags);
-	else
-		local_irq_save(*flags);
-
-	return swpvec;
-}
-
-static inline void unlock_swap_pvec(struct swap_pagevec *swpvec,
-				    struct swap_pagevec __percpu *p)
-{
-	if (static_branch_likely(&use_pvec_lock))
-		spin_unlock(&swpvec->lock);
-	else
-		put_cpu_var(*p);
-
-}
-
-static inline void unlock_swap_pvec_cpu(struct swap_pagevec *swpvec)
-{
-	if (static_branch_likely(&use_pvec_lock))
-		spin_unlock(&swpvec->lock);
-}
-
-static inline void
-unlock_swap_pvec_irqrestore(struct swap_pagevec *swpvec, unsigned long flags)
-{
-	if (static_branch_likely(&use_pvec_lock))
-		spin_unlock_irqrestore(&swpvec->lock, flags);
-	else
-		local_irq_restore(flags);
-}
+static DEFINE_LOCAL_IRQ_LOCK(rotate_lock);
+DEFINE_LOCAL_IRQ_LOCK(swapvec_lock);
 
 /*
  * This path almost never happens for VM activity - pages are normally
@@ -347,17 +253,15 @@ void rotate_reclaimable_page(struct page *page)
 {
 	if (!PageLocked(page) && !PageDirty(page) &&
 	    !PageUnevictable(page) && PageLRU(page)) {
-		struct swap_pagevec *swpvec;
 		struct pagevec *pvec;
 		unsigned long flags;
 
 		get_page(page);
-
-		swpvec = lock_swap_pvec_irqsave(&lru_rotate_pvecs, &flags);
-		pvec = &swpvec->pvec;
+		local_lock_irqsave(rotate_lock, flags);
+		pvec = this_cpu_ptr(&lru_rotate_pvecs);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_move_tail(pvec);
-		unlock_swap_pvec_irqrestore(swpvec, flags);
+		local_unlock_irqrestore(rotate_lock, flags);
 	}
 }
 
@@ -392,32 +296,28 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 #ifdef CONFIG_SMP
 static void activate_page_drain(int cpu)
 {
-	struct swap_pagevec *swpvec = lock_swap_pvec_cpu(&activate_page_pvecs, cpu);
-	struct pagevec *pvec = &swpvec->pvec;
+	struct pagevec *pvec = &per_cpu(activate_page_pvecs, cpu);
 
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, __activate_page, NULL);
-	unlock_swap_pvec_cpu(swpvec);
 }
 
 static bool need_activate_page_drain(int cpu)
 {
-	return pagevec_count(per_cpu_ptr(&activate_page_pvecs.pvec, cpu)) != 0;
+	return pagevec_count(&per_cpu(activate_page_pvecs, cpu)) != 0;
 }
 
 void activate_page(struct page *page)
 {
 	page = compound_head(page);
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
-		struct swap_pagevec *swpvec;
-		struct pagevec *pvec;
+		struct pagevec *pvec = &get_locked_var(swapvec_lock,
+						       activate_page_pvecs);
 
 		get_page(page);
-		swpvec = lock_swap_pvec(&activate_page_pvecs);
-		pvec = &swpvec->pvec;
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, __activate_page, NULL);
-		unlock_swap_pvec(swpvec, &activate_page_pvecs);
+		put_locked_var(swapvec_lock, activate_page_pvecs);
 	}
 }
 
@@ -439,8 +339,7 @@ void activate_page(struct page *page)
 
 static void __lru_cache_activate_page(struct page *page)
 {
-	struct swap_pagevec *swpvec = lock_swap_pvec(&lru_add_pvec);
-	struct pagevec *pvec = &swpvec->pvec;
+	struct pagevec *pvec = &get_locked_var(swapvec_lock, lru_add_pvec);
 	int i;
 
 	/*
@@ -462,7 +361,7 @@ static void __lru_cache_activate_page(struct page *page)
 		}
 	}
 
-	unlock_swap_pvec(swpvec, &lru_add_pvec);
+	put_locked_var(swapvec_lock, lru_add_pvec);
 }
 
 /*
@@ -504,13 +403,12 @@ EXPORT_SYMBOL(mark_page_accessed);
 
 static void __lru_cache_add(struct page *page)
 {
-	struct swap_pagevec *swpvec = lock_swap_pvec(&lru_add_pvec);
-	struct pagevec *pvec = &swpvec->pvec;
+	struct pagevec *pvec = &get_locked_var(swapvec_lock, lru_add_pvec);
 
 	get_page(page);
 	if (!pagevec_add(pvec, page) || PageCompound(page))
 		__pagevec_lru_add(pvec);
-	unlock_swap_pvec(swpvec, &lru_add_pvec);
+	put_locked_var(swapvec_lock, lru_add_pvec);
 }
 
 /**
@@ -694,40 +592,38 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
  */
 void lru_add_drain_cpu(int cpu)
 {
-	struct swap_pagevec *swpvec = lock_swap_pvec_cpu(&lru_add_pvec, cpu);
-	struct pagevec *pvec = &swpvec->pvec;
-	unsigned long flags;
+	struct pagevec *pvec = &per_cpu(lru_add_pvec, cpu);
 
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
-	unlock_swap_pvec_cpu(swpvec);
 
-	swpvec = lock_swap_pvec_cpu_irqsave(&lru_rotate_pvecs, cpu, &flags);
-	pvec = &swpvec->pvec;
+	pvec = &per_cpu(lru_rotate_pvecs, cpu);
 	if (pagevec_count(pvec)) {
+		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
+#ifdef CONFIG_PREEMPT_RT
+		local_lock_irqsave_on(rotate_lock, flags, cpu);
 		pagevec_move_tail(pvec);
+		local_unlock_irqrestore_on(rotate_lock, flags, cpu);
+#else
+		local_lock_irqsave(rotate_lock, flags);
+		pagevec_move_tail(pvec);
+		local_unlock_irqrestore(rotate_lock, flags);
+#endif
 	}
-	unlock_swap_pvec_irqrestore(swpvec, flags);
 
-	swpvec = lock_swap_pvec_cpu(&lru_deactivate_file_pvecs, cpu);
-	pvec = &swpvec->pvec;
+	pvec = &per_cpu(lru_deactivate_file_pvecs, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
-	unlock_swap_pvec_cpu(swpvec);
 
-	swpvec = lock_swap_pvec_cpu(&lru_deactivate_pvecs, cpu);
-	pvec = &swpvec->pvec;
+	pvec = &per_cpu(lru_deactivate_pvecs, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
-	unlock_swap_pvec_cpu(swpvec);
 
-	swpvec = lock_swap_pvec_cpu(&lru_lazyfree_pvecs, cpu);
-	pvec = &swpvec->pvec;
+	pvec = &per_cpu(lru_lazyfree_pvecs, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
-	unlock_swap_pvec_cpu(swpvec);
 
 	activate_page_drain(cpu);
 }
@@ -742,9 +638,6 @@ void lru_add_drain_cpu(int cpu)
  */
 void deactivate_file_page(struct page *page)
 {
-	struct swap_pagevec *swpvec;
-	struct pagevec *pvec;
-
 	/*
 	 * In a workload with many unevictable page such as mprotect,
 	 * unevictable page deactivation for accelerating reclaim is pointless.
@@ -753,12 +646,12 @@ void deactivate_file_page(struct page *page)
 		return;
 
 	if (likely(get_page_unless_zero(page))) {
-		swpvec = lock_swap_pvec(&lru_deactivate_file_pvecs);
-		pvec = &swpvec->pvec;
+		struct pagevec *pvec = &get_locked_var(swapvec_lock,
+						       lru_deactivate_file_pvecs);
 
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
-		unlock_swap_pvec(swpvec, &lru_deactivate_file_pvecs);
+		put_locked_var(swapvec_lock, lru_deactivate_file_pvecs);
 	}
 }
 
@@ -773,16 +666,12 @@ void deactivate_file_page(struct page *page)
 void deactivate_page(struct page *page)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
-		struct swap_pagevec *swpvec;
-		struct pagevec *pvec;
-
-		swpvec = lock_swap_pvec(&lru_deactivate_pvecs);
-		pvec = &swpvec->pvec;
+		struct pagevec *pvec = &get_cpu_var(lru_deactivate_pvecs);
 
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
-		unlock_swap_pvec(swpvec, &lru_deactivate_pvecs);
+		put_cpu_var(lru_deactivate_pvecs);
 	}
 }
 
@@ -795,33 +684,36 @@ void deactivate_page(struct page *page)
  */
 void mark_page_lazyfree(struct page *page)
 {
-	struct swap_pagevec *swpvec;
-	struct pagevec *pvec;
-
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
-		swpvec = lock_swap_pvec(&lru_lazyfree_pvecs);
-		pvec = &swpvec->pvec;
+		struct pagevec *pvec = &get_locked_var(swapvec_lock,
+						       lru_lazyfree_pvecs);
 
 		get_page(page);
 		if (!pagevec_add(pvec, page) || PageCompound(page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
-		unlock_swap_pvec(swpvec, &lru_lazyfree_pvecs);
+		put_locked_var(swapvec_lock, lru_lazyfree_pvecs);
 	}
 }
 
 void lru_add_drain(void)
 {
-	if (static_branch_likely(&use_pvec_lock)) {
-		lru_add_drain_cpu(raw_smp_processor_id());
-	} else {
-		lru_add_drain_cpu(get_cpu());
-		put_cpu();
-	}
+	lru_add_drain_cpu(local_lock_cpu(swapvec_lock));
+	local_unlock_cpu(swapvec_lock);
 }
 
 #ifdef CONFIG_SMP
 
+#ifdef CONFIG_PREEMPT_RT
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	local_lock_on(swapvec_lock, cpu);
+	lru_add_drain_cpu(cpu);
+	local_unlock_on(swapvec_lock, cpu);
+}
+
+#else
+
 static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
 
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
@@ -829,6 +721,16 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
 	lru_add_drain();
 }
 
+static inline void remote_lru_add_drain(int cpu, struct cpumask *has_work)
+{
+	struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+
+	INIT_WORK(work, lru_add_drain_per_cpu);
+	queue_work_on(cpu, mm_percpu_wq, work);
+	cpumask_set_cpu(cpu, has_work);
+}
+#endif
+
 /*
  * Doesn't need any cpu hotplug locking because we do rely on per-cpu
  * kworkers being shut down before our page_alloc_cpu_dead callback is
@@ -838,54 +740,37 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
  */
 void lru_add_drain_all(void)
 {
-	if (static_branch_likely(&use_pvec_lock)) {
-		int cpu;
+	static DEFINE_MUTEX(lock);
+	static struct cpumask has_work;
+	int cpu;
 
-		for_each_online_cpu(cpu) {
-			if (pagevec_count(&per_cpu(lru_add_pvec.pvec, cpu)) ||
-			    pagevec_count(&per_cpu(lru_rotate_pvecs.pvec, cpu)) ||
-			    pagevec_count(&per_cpu(lru_deactivate_file_pvecs.pvec, cpu)) ||
-			    pagevec_count(&per_cpu(lru_deactivate_pvecs.pvec, cpu)) ||
-			    pagevec_count(&per_cpu(lru_lazyfree_pvecs.pvec, cpu)) ||
-			    need_activate_page_drain(cpu)) {
-				lru_add_drain_cpu(cpu);
-			}
-		}
-	} else {
-		static DEFINE_MUTEX(lock);
-		static struct cpumask has_work;
-		int cpu;
+	/*
+	 * Make sure nobody triggers this path before mm_percpu_wq is fully
+	 * initialized.
+	 */
+	if (WARN_ON(!mm_percpu_wq))
+		return;
 
-		/*
-		 * Make sure nobody triggers this path before mm_percpu_wq
-		 * is fully initialized.
-		 */
-		if (WARN_ON(!mm_percpu_wq))
-			return;
+	mutex_lock(&lock);
+	cpumask_clear(&has_work);
 
-		mutex_lock(&lock);
-		cpumask_clear(&has_work);
+	for_each_online_cpu(cpu) {
 
-		for_each_online_cpu(cpu) {
-			struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
-
-			if (pagevec_count(&per_cpu(lru_add_pvec.pvec, cpu)) ||
-			    pagevec_count(&per_cpu(lru_rotate_pvecs.pvec, cpu)) ||
-			    pagevec_count(&per_cpu(lru_deactivate_file_pvecs.pvec, cpu)) ||
-			    pagevec_count(&per_cpu(lru_deactivate_pvecs.pvec, cpu)) ||
-			    pagevec_count(&per_cpu(lru_lazyfree_pvecs.pvec, cpu)) ||
-			    need_activate_page_drain(cpu)) {
-				INIT_WORK(work, lru_add_drain_per_cpu);
-				queue_work_on(cpu, mm_percpu_wq, work);
-				cpumask_set_cpu(cpu, &has_work);
-			}
-		}
-
-		for_each_cpu(cpu, &has_work)
-			flush_work(&per_cpu(lru_add_drain_work, cpu));
-
-		mutex_unlock(&lock);
+		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
+		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
+		    pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
+		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
+		    pagevec_count(&per_cpu(lru_lazyfree_pvecs, cpu)) ||
+		    need_activate_page_drain(cpu))
+			remote_lru_add_drain(cpu, &has_work);
 	}
+
+#ifndef CONFIG_PREEMPT_RT
+	for_each_cpu(cpu, &has_work)
+		flush_work(&per_cpu(lru_add_drain_work, cpu));
+#endif
+
+	mutex_unlock(&lock);
 }
 #else
 void lru_add_drain_all(void)
