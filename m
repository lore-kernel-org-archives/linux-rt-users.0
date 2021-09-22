Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB526C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B919C610D1
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 21:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbhIVVBn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbhIVVBl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 17:01:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA0C061574;
        Wed, 22 Sep 2021 14:00:11 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:00:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632344408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hMcDV1dn146x/areT+mo0HQOdfO8q1KqSoF33b2WliI=;
        b=JYfAXtKgJ3l5alY0UhxOBpBR/SmjQ7ae9eaamGyNzpa52vUgMIHMC85kBIlIoVaSsXdGgZ
        D9gjmGwzCGJWuUtXeTWJ00bm0t0+uSrWETjEQdhsPWJBVoFt2XZMqMD/uja8K+b3fMMICl
        BQ6x7qn1E7unRuh22wzJiBQueo7StQq+M85xFQvrmsMQ0Qp45UhlAeZIeXC+F13qnJsrW5
        GQDcXbYwnE7Z1Xq5pO1Ww5+g6uJFtf2Fay5Srf4iJyg+QREWhUg9k+ZXdI27y1fnzXdQhB
        Nen6zwwmIovGe4BRBAaXNtYDvytmZL+DguDSle5LU2SZw1donGrhGB+ihzXgdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632344408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hMcDV1dn146x/areT+mo0HQOdfO8q1KqSoF33b2WliI=;
        b=tvywRcQdOvH+b+dt5qvl0Wop59fuvnLWwuXkWEQE7I0mC2k30RMxOGajUppDJwRcWlqlha
        UZaQfi5i1AodzaDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc2-rt3
Message-ID: <20210922210006.rmfpkps6hguyo5ll@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc2-rt3 patch set. 

Changes since v5.15-rc2-rt2:

  - Remove kernel_fpu_resched(). A few ciphers were restructured and
    this function has no users and can be removed.

  - The cpuset code is using spinlock_t again. Since the mm/slub rework
    there is need to use raw_spinlock_t.

  - Allow to enable CONFIG_RT_GROUP_SCHED on RT again. The original
    issue can not be reproduced. Please test and report any issue.

  - The RCU warning, that has been fixed Valentin Schneider, has been
    replaced with a patch by Thomas Gleixner. There is another issue
    open in that area an Frederick Weisbecker is looking into it.

  - RCU lock accounting and checking has been reworked by Thomas
    Gleixner. A direct effect is that might_sleep() produces a warning
    if invoked in a RCU read section. Previously it would only trigger a
    warning in schedule() in such a situation.

  - The preempt_*_nort() macros have been removed.

  - The preempt_enable_no_resched() macro should behave like
    preempt_enable() on PREEMPT_RT but was was misplaced in v3.14-rt1
    and has has been corrected now.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.15-rc2-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rc2-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc2-rt3

The RT patch against v5.15-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc2-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc2-rt3.tar.xz

Sebastian

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 62cf3e4c06fb1..23bef08a83880 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -28,7 +28,6 @@ extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
 extern void fpregs_mark_activate(void);
-extern void kernel_fpu_resched(void);
 
 /* Code that is unaware of kernel_fpu_begin_mask() can use this */
 static inline void kernel_fpu_begin(void)
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e17fe40ee51e1..7ada7bd03a327 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -185,18 +185,6 @@ void kernel_fpu_end(void)
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
-void kernel_fpu_resched(void)
-{
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
-
-	if (should_resched(PREEMPT_OFFSET)) {
-		kernel_fpu_end();
-		cond_resched();
-		kernel_fpu_begin();
-	}
-}
-EXPORT_SYMBOL_GPL(kernel_fpu_resched);
-
 /*
  * Sync the FPU register state to current's memory register state when the
  * current task owns the FPU. The hardware register state is preserved.
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index af39859f02ee1..cf665d25838cf 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -122,9 +122,17 @@
  * The preempt_count offset after spin_lock()
  */
 #if !defined(CONFIG_PREEMPT_RT)
-#define PREEMPT_LOCK_OFFSET	PREEMPT_DISABLE_OFFSET
+#define PREEMPT_LOCK_OFFSET		PREEMPT_DISABLE_OFFSET
+#define PREEMPT_LOCK_RESCHED_OFFSET	PREEMPT_LOCK_OFFSET
 #else
-#define PREEMPT_LOCK_OFFSET	0
+/* Locks on RT do not disable preemption */
+#define PREEMPT_LOCK_OFFSET		0
+/*
+ * spin/rw_lock() on RT implies rcu_read_lock(). The might_sleep() check in
+ * cond_resched*lock() has to take that into account because it checks for
+ * preempt_count() + rcu_preempt_depth().
+ */
+#define PREEMPT_LOCK_RESCHED_OFFSET	1
 #endif
 
 /*
@@ -208,12 +216,12 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#ifdef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT
 # define preempt_enable_no_resched() sched_preempt_enable_no_resched()
-# define preempt_check_resched_rt() preempt_check_resched()
+# define preempt_check_resched_rt() barrier();
 #else
 # define preempt_enable_no_resched() preempt_enable()
-# define preempt_check_resched_rt() barrier();
+# define preempt_check_resched_rt() preempt_check_resched()
 #endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
@@ -333,13 +341,9 @@ do { \
 #ifdef CONFIG_PREEMPT_RT
 # define preempt_disable_rt()		preempt_disable()
 # define preempt_enable_rt()		preempt_enable()
-# define preempt_disable_nort()		barrier()
-# define preempt_enable_nort()		barrier()
 #else
 # define preempt_disable_rt()		barrier()
 # define preempt_enable_rt()		barrier()
-# define preempt_disable_nort()		preempt_disable()
-# define preempt_enable_nort()		preempt_enable()
 #endif
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48d00a4cf7de7..de6d1a21f113b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -54,11 +54,6 @@ void __rcu_read_unlock(void);
  * types of kernel builds, the rcu_read_lock() nesting depth is unknowable.
  */
 #define rcu_preempt_depth() READ_ONCE(current->rcu_read_lock_nesting)
-#ifndef CONFIG_PREEMPT_RT
-#define sched_rcu_preempt_depth()	rcu_preempt_depth()
-#else
-static inline int sched_rcu_preempt_depth(void) { return 0; }
-#endif
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
@@ -84,8 +79,6 @@ static inline int rcu_preempt_depth(void)
 	return 0;
 }
 
-#define sched_rcu_preempt_depth()	rcu_preempt_depth()
-
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /* Internal to kernel */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a47a4969b7676..992a1e07a27e8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2169,19 +2169,19 @@ extern int __cond_resched_lock(spinlock_t *lock);
 extern int __cond_resched_rwlock_read(rwlock_t *lock);
 extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
-#define cond_resched_lock(lock) ({				\
-	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
-	__cond_resched_lock(lock);				\
+#define cond_resched_lock(lock) ({					\
+	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSET);	\
+	__cond_resched_lock(lock);					\
 })
 
-#define cond_resched_rwlock_read(lock) ({			\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_read(lock);			\
+#define cond_resched_rwlock_read(lock) ({				\
+	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSET);	\
+	__cond_resched_rwlock_read(lock);				\
 })
 
-#define cond_resched_rwlock_write(lock) ({			\
-	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_write(lock);			\
+#define cond_resched_rwlock_write(lock) (	{			\
+	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSET);	\
+	__cond_resched_rwlock_write(lock);				\
 })
 
 static inline void cond_resched_rcu(void)
diff --git a/init/Kconfig b/init/Kconfig
index a42f126ea89e2..28fd7b8e8c7d6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1009,7 +1009,6 @@ config CFS_BANDWIDTH
 config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
 	depends on CGROUP_SCHED
-	depends on !PREEMPT_RT
 	default n
 	help
 	  This feature lets you explicitly allocate real CPU bandwidth
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 38530791e91e6..df1ccf4558f82 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -358,7 +358,7 @@ void cpuset_read_unlock(void)
 	percpu_up_read(&cpuset_rwsem);
 }
 
-static DEFINE_RAW_SPINLOCK(callback_lock);
+static DEFINE_SPINLOCK(callback_lock);
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
 
@@ -1308,7 +1308,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	 * Newly added CPUs will be removed from effective_cpus and
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 	if (adding) {
 		cpumask_or(parent->subparts_cpus,
 			   parent->subparts_cpus, tmp->addmask);
@@ -1331,7 +1331,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	if (old_prs != new_prs)
 		cpuset->partition_root_state = new_prs;
 
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 	notify_partition_change(cpuset, old_prs, new_prs);
 
 	return cmd == partcmd_update;
@@ -1435,7 +1435,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			continue;
 		rcu_read_unlock();
 
-		raw_spin_lock_irq(&callback_lock);
+		spin_lock_irq(&callback_lock);
 
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		if (cp->nr_subparts_cpus && (new_prs != PRS_ENABLED)) {
@@ -1469,7 +1469,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		if (new_prs != old_prs)
 			cp->partition_root_state = new_prs;
 
-		raw_spin_unlock_irq(&callback_lock);
+		spin_unlock_irq(&callback_lock);
 		notify_partition_change(cp, old_prs, new_prs);
 
 		WARN_ON(!is_in_v2_mode() &&
@@ -1588,7 +1588,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			return -EINVAL;
 	}
 
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
 
 	/*
@@ -1599,7 +1599,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			       cs->cpus_allowed);
 		cs->nr_subparts_cpus = cpumask_weight(cs->subparts_cpus);
 	}
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 
 	update_cpumasks_hier(cs, &tmp);
 
@@ -1798,9 +1798,9 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 			continue;
 		rcu_read_unlock();
 
-		raw_spin_lock_irq(&callback_lock);
+		spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
-		raw_spin_unlock_irq(&callback_lock);
+		spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
@@ -1868,9 +1868,9 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto done;
 
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 
 	/* use trialcs->mems_allowed as a temp variable */
 	update_nodemasks_hier(cs, &trialcs->mems_allowed);
@@ -1961,9 +1961,9 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
 		rebuild_sched_domains_locked();
@@ -2054,9 +2054,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	rebuild_sched_domains_locked();
 out:
 	if (!err) {
-		raw_spin_lock_irq(&callback_lock);
+		spin_lock_irq(&callback_lock);
 		cs->partition_root_state = new_prs;
-		raw_spin_unlock_irq(&callback_lock);
+		spin_unlock_irq(&callback_lock);
 		notify_partition_change(cs, old_prs, new_prs);
 	}
 
@@ -2471,7 +2471,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	cpuset_filetype_t type = seq_cft(sf)->private;
 	int ret = 0;
 
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 
 	switch (type) {
 	case FILE_CPULIST:
@@ -2493,7 +2493,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 		ret = -EINVAL;
 	}
 
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 	return ret;
 }
 
@@ -2811,14 +2811,14 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 
 	cpuset_inc();
 
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 	if (is_in_v2_mode()) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
 	}
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 
 	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
 		goto out_unlock;
@@ -2845,12 +2845,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	}
 	rcu_read_unlock();
 
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 	cs->mems_allowed = parent->mems_allowed;
 	cs->effective_mems = parent->mems_allowed;
 	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
 	cpus_read_unlock();
@@ -2906,7 +2906,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
 	percpu_down_write(&cpuset_rwsem);
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
 		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
@@ -2917,7 +2917,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 		top_cpuset.mems_allowed = top_cpuset.effective_mems;
 	}
 
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 	percpu_up_write(&cpuset_rwsem);
 }
 
@@ -3014,12 +3014,12 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 {
 	bool is_empty;
 
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, new_cpus);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->mems_allowed = *new_mems;
 	cs->effective_mems = *new_mems;
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 
 	/*
 	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
@@ -3056,10 +3056,10 @@ hotplug_update_tasks(struct cpuset *cs,
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
 
-	raw_spin_lock_irq(&callback_lock);
+	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->effective_mems = *new_mems;
-	raw_spin_unlock_irq(&callback_lock);
+	spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
 		update_tasks_cpumask(cs);
@@ -3126,10 +3126,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (is_partition_root(cs) && (cpumask_empty(&new_cpus) ||
 	   (parent->partition_root_state == PRS_ERROR))) {
 		if (cs->nr_subparts_cpus) {
-			raw_spin_lock_irq(&callback_lock);
+			spin_lock_irq(&callback_lock);
 			cs->nr_subparts_cpus = 0;
 			cpumask_clear(cs->subparts_cpus);
-			raw_spin_unlock_irq(&callback_lock);
+			spin_unlock_irq(&callback_lock);
 			compute_effective_cpumask(&new_cpus, cs, parent);
 		}
 
@@ -3147,9 +3147,9 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 						       NULL, tmp);
 			old_prs = cs->partition_root_state;
 			if (old_prs != PRS_ERROR) {
-				raw_spin_lock_irq(&callback_lock);
+				spin_lock_irq(&callback_lock);
 				cs->partition_root_state = PRS_ERROR;
-				raw_spin_unlock_irq(&callback_lock);
+				spin_unlock_irq(&callback_lock);
 				notify_partition_change(cs, old_prs, PRS_ERROR);
 			}
 		}
@@ -3231,7 +3231,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 
 	/* synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
-		raw_spin_lock_irq(&callback_lock);
+		spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
 		/*
@@ -3251,17 +3251,17 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 			}
 		}
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
-		raw_spin_unlock_irq(&callback_lock);
+		spin_unlock_irq(&callback_lock);
 		/* we don't mess with cpumasks of tasks in top_cpuset */
 	}
 
 	/* synchronize mems_allowed to N_MEMORY */
 	if (mems_updated) {
-		raw_spin_lock_irq(&callback_lock);
+		spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
-		raw_spin_unlock_irq(&callback_lock);
+		spin_unlock_irq(&callback_lock);
 		update_tasks_nodemask(&top_cpuset);
 	}
 
@@ -3362,9 +3362,9 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 {
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&callback_lock, flags);
+	spin_lock_irqsave(&callback_lock, flags);
 	guarantee_online_cpus(tsk, pmask);
-	raw_spin_unlock_irqrestore(&callback_lock, flags);
+	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
 /**
@@ -3435,11 +3435,11 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	nodemask_t mask;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&callback_lock, flags);
+	spin_lock_irqsave(&callback_lock, flags);
 	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &mask);
 	rcu_read_unlock();
-	raw_spin_unlock_irqrestore(&callback_lock, flags);
+	spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
 }
@@ -3531,14 +3531,14 @@ bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
 		return true;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	raw_spin_lock_irqsave(&callback_lock, flags);
+	spin_lock_irqsave(&callback_lock, flags);
 
 	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
 	rcu_read_unlock();
 
-	raw_spin_unlock_irqrestore(&callback_lock, flags);
+	spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
 }
 
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index ca4bdc53d6c74..02b2daf074414 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -447,10 +447,10 @@ MODULE_PARM_DESC(noirqdebug, "Disable irq lockup detection when true");
 
 static int __init irqfixup_setup(char *str)
 {
-#ifdef CONFIG_PREEMPT_RT
-	pr_warn("irqfixup boot option not supported w/ CONFIG_PREEMPT_RT\n");
-	return 1;
-#endif
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		pr_warn("irqfixup boot option not supported with PREEMPT_RT\n");
+		return 1;
+	}
 	irqfixup = 1;
 	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
 	printk(KERN_WARNING "This may impact system performance.\n");
@@ -463,10 +463,10 @@ module_param(irqfixup, int, 0644);
 
 static int __init irqpoll_setup(char *str)
 {
-#ifdef CONFIG_PREEMPT_RT
-	pr_warn("irqpoll boot option not supported w/ CONFIG_PREEMPT_RT\n");
-	return 1;
-#endif
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		pr_warn("irqpoll boot option not supported with PREEMPT_RT\n");
+		return 1;
+	}
 	irqfixup = 2;
 	printk(KERN_WARNING "Misrouted IRQ fixup and polling support "
 				"enabled\n");
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 839041f8460f9..1d1e85e317385 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -24,6 +24,14 @@
 #define RT_MUTEX_BUILD_SPINLOCKS
 #include "rtmutex.c"
 
+/*
+ * Use ___might_sleep() which skips the state check and take RCU nesting
+ * into account as spin/read/write_lock() can legitimately nest into an RCU
+ * read side critical section:
+ */
+#define rtlock_might_sleep()					\
+	___might_sleep(__FILE__, __LINE__, rcu_preempt_depth())
+
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
 	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
@@ -32,7 +40,7 @@ static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 
 static __always_inline void __rt_spin_lock(spinlock_t *lock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	rtlock_might_sleep();
 	rtlock_lock(&lock->lock);
 	rcu_read_lock();
 	migrate_disable();
@@ -210,7 +218,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	rtlock_might_sleep();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -220,7 +228,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	rtlock_might_sleep();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c13f63aa12e83..937b96ce1510a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -80,7 +80,6 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks = ATOMIC_INIT(1),
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
-	.nocb_local_lock =  INIT_LOCAL_LOCK(nocb_local_lock),
 #endif
 };
 static struct rcu_state rcu_state = {
@@ -2279,13 +2278,13 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
+	bool offloaded, needwake = false;
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
 	    rdp->gpwrap) {
 
@@ -2447,7 +2446,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
+	bool offloaded;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -2473,6 +2472,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
@@ -2812,12 +2812,10 @@ static void rcu_cpu_kthread(unsigned int cpu)
 {
 	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
 	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int spincnt;
 
 	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
 	for (spincnt = 0; spincnt < 10; spincnt++) {
-		rcu_nocb_local_lock(rdp);
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
@@ -2827,7 +2825,6 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		if (work)
 			rcu_core();
 		local_bh_enable();
-		rcu_nocb_local_unlock(rdp);
 		if (*workp == 0) {
 			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
 			*statusp = RCU_KTHREAD_WAITING;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index aa6831255fec6..305cf6aeb4086 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -210,8 +210,6 @@ struct rcu_data {
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
 
-	local_lock_t nocb_local_lock;
-
 	/* The following fields are used by call_rcu, hence own cacheline. */
 	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
 	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
@@ -447,8 +445,6 @@ static void rcu_nocb_unlock(struct rcu_data *rdp);
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
-static void rcu_nocb_local_lock(struct rcu_data *rdp);
-static void rcu_nocb_local_unlock(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
 #define rcu_nocb_lock_irqsave(rdp, flags)				\
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 42481a3ce4913..8fdf44f8523f2 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -21,11 +21,6 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
 	return lockdep_is_held(&rdp->nocb_lock);
 }
 
-static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
-{
-	return lockdep_is_held(&rdp->nocb_local_lock);
-}
-
 static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 {
 	/* Race on early boot between thread creation and assignment */
@@ -186,22 +181,6 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 	}
 }
 
-/*
- * The invocation of rcu_core() within the RCU core kthreads remains preemptible
- * under PREEMPT_RT, thus the offload state of a CPU could change while
- * said kthreads are preempted. Prevent this from happening by protecting the
- * offload state with a local_lock().
- */
-static void rcu_nocb_local_lock(struct rcu_data *rdp)
-{
-	local_lock(&rcu_data.nocb_local_lock);
-}
-
-static void rcu_nocb_local_unlock(struct rcu_data *rdp)
-{
-	local_unlock(&rcu_data.nocb_local_lock);
-}
-
 /* Lockdep check that ->cblist may be safely accessed. */
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
@@ -969,7 +948,6 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	if (rdp->nocb_cb_sleep)
 		rdp->nocb_cb_sleep = false;
 	rcu_nocb_unlock_irqrestore(rdp, flags);
-	rcu_nocb_local_unlock(rdp);
 
 	/*
 	 * Ignore former value of nocb_cb_sleep and force wake up as it could
@@ -1001,7 +979,6 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 
 	pr_info("De-offloading %d\n", rdp->cpu);
 
-	rcu_nocb_local_lock(rdp);
 	rcu_nocb_lock_irqsave(rdp, flags);
 	/*
 	 * Flush once and for all now. This suffices because we are
@@ -1084,7 +1061,6 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 * Can't use rcu_nocb_lock_irqsave() while we are in
 	 * SEGCBLIST_SOFTIRQ_ONLY mode.
 	 */
-	rcu_nocb_local_lock(rdp);
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 
 	/*
@@ -1432,11 +1408,6 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
 	return 0;
 }
 
-static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
-{
-	return 0;
-}
-
 static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 {
 	return false;
@@ -1459,16 +1430,6 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 	local_irq_restore(flags);
 }
 
-/* No ->nocb_local_lock to acquire. */
-static void rcu_nocb_local_lock(struct rcu_data *rdp)
-{
-}
-
-/* No ->nocb_local_lock to release. */
-static void rcu_nocb_local_unlock(struct rcu_data *rdp)
-{
-}
-
 /* Lockdep check that ->cblist may be safely accessed. */
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 265cb799d340c..d070059163d70 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -13,45 +13,23 @@
 
 #include "../locking/rtmutex_common.h"
 
-/*
- * Is a local read of the rdp's offloaded state safe and stable?
- * See rcu_nocb_local_lock() & family.
- */
-static inline bool rcu_local_offload_access_safe(struct rcu_data *rdp)
-{
-	if (!preemptible())
-		return true;
-
-	if (!is_migratable()) {
-		if (!IS_ENABLED(CONFIG_RCU_NOCB))
-			return true;
-
-		return rcu_lockdep_is_held_nocb_local(rdp);
-	}
-
-	return false;
-}
-
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 {
 	/*
-	 * In order to read the offloaded state of an rdp is a safe and stable
-	 * way and prevent from its value to be changed under us, we must
-         * either...
+	 * In order to read the offloaded state of an rdp is a safe
+	 * and stable way and prevent from its value to be changed
+	 * under us, we must either hold the barrier mutex, the cpu
+	 * hotplug lock (read or write) or the nocb lock. Local
+	 * non-preemptible reads are also safe. NOCB kthreads and
+	 * timers have their own means of synchronization against the
+	 * offloaded state updaters.
 	 */
 	RCU_LOCKDEP_WARN(
-		// ...hold the barrier mutex...
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
-		// ... the cpu hotplug lock (read or write)...
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
-		  // ... or the NOCB lock.
 		  rcu_lockdep_is_held_nocb(rdp) ||
-		  // Local reads still require the local state to remain stable
-		  // (preemption disabled / local lock held)
 		  (rdp == this_cpu_ptr(&rcu_data) &&
-		   rcu_local_offload_access_safe(rdp)) ||
-		  // NOCB kthreads and timers have their own means of
-		  // synchronization against the offloaded state updaters.
+		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 74260746865d8..261508bac047d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9547,7 +9547,7 @@ void __init sched_init(void)
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 static inline int preempt_count_equals(int preempt_offset)
 {
-	int nested = preempt_count() + sched_rcu_preempt_depth();
+	int nested = preempt_count() + rcu_preempt_depth();
 
 	return (nested == preempt_offset);
 }
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
