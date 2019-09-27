Return-Path: <SRS0=wj13=XW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA7FC4360C
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 11:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF0420872
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 11:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfI0Luk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:50:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45735 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0Luj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Sep 2019 07:50:39 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iDolc-0000Ip-0E; Fri, 27 Sep 2019 13:50:32 +0200
Date:   Fri, 27 Sep 2019 13:50:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2.17-rt9
Message-ID: <20190927115031.6rew5g2kqfwjaaff@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2.17-rt9 patch set. 

Changes since v5.2.17-rt8:

  - A missing unlock in the posix-CPU-timer code was found by Dan
    Carpenter.

  - Asking for the first recorded message in the printk buffer returns
    the first available message if it has been overwritten. This is not
    how it is documented and wrong since the printk rework. Patch by He
    Zhe.

  - Move RCU processing to the rcuc thread. This behaviour was enabled
    by default in previous releases and accidentally dropped while
    switching to the upstream code which offers the same functionality.
    Patch by Scott Wood.

  - local_bh_disable() did not serve as a rcu read section. Patch by
    Scott Wood.

  - Various migrate_disable() related patches by Scott Wood. They
    optimized existing code, cleaned up and avoided a few false positive
    warnings.

  - The rcutorture module was broken because it tried to test for
    scenarios which were not possible/invalid on RT. Reported by Juri
    Lelli and patched by Scott Wood.

  - Clark Williams reported locking problems and lockdep warnings in the
    i915 driver.

Known issues
     - None.

The delta patch against v5.2.17-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2.17-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2.17-rt9

The RT patch against v5.2.17 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.17-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2.17-rt9.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/i915/i915_reset.c b/drivers/gpu/drm/i915/i915_reset.c
index 677d59304e782..e6fcdfed2b00e 100644
--- a/drivers/gpu/drm/i915/i915_reset.c
+++ b/drivers/gpu/drm/i915/i915_reset.c
@@ -804,7 +804,7 @@ static void reset_finish(struct drm_i915_private *i915)
 
 	for_each_engine(engine, i915, id) {
 		reset_finish_engine(engine);
-		intel_engine_signal_breadcrumbs(engine);
+		intel_engine_breadcrumbs_irq(engine);
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/intel_breadcrumbs.c b/drivers/gpu/drm/i915/intel_breadcrumbs.c
index 832cb6b1e9bd4..3e813d86f51ed 100644
--- a/drivers/gpu/drm/i915/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/intel_breadcrumbs.c
@@ -101,7 +101,6 @@ __dma_fence_signal__notify(struct dma_fence *fence)
 	struct dma_fence_cb *cur, *tmp;
 
 	lockdep_assert_held(fence->lock);
-	lockdep_assert_irqs_disabled();
 
 	list_for_each_entry_safe(cur, tmp, &fence->cb_list, node) {
 		INIT_LIST_HEAD(&cur->node);
@@ -116,9 +115,10 @@ void intel_engine_breadcrumbs_irq(struct intel_engine_cs *engine)
 	const ktime_t timestamp = ktime_get();
 	struct intel_context *ce, *cn;
 	struct list_head *pos, *next;
+	unsigned long flags;
 	LIST_HEAD(signal);
 
-	spin_lock(&b->irq_lock);
+	spin_lock_irqsave(&b->irq_lock, flags);
 
 	if (b->irq_armed && list_empty(&b->signalers))
 		__intel_breadcrumbs_disarm_irq(b);
@@ -162,7 +162,7 @@ void intel_engine_breadcrumbs_irq(struct intel_engine_cs *engine)
 		}
 	}
 
-	spin_unlock(&b->irq_lock);
+	spin_unlock_irqrestore(&b->irq_lock, flags);
 
 	list_for_each_safe(pos, next, &signal) {
 		struct i915_request *rq =
@@ -170,21 +170,14 @@ void intel_engine_breadcrumbs_irq(struct intel_engine_cs *engine)
 
 		__dma_fence_signal__timestamp(&rq->fence, timestamp);
 
-		spin_lock(&rq->lock);
+		spin_lock_irqsave(&rq->lock, flags);
 		__dma_fence_signal__notify(&rq->fence);
-		spin_unlock(&rq->lock);
+		spin_unlock_irqrestore(&rq->lock, flags);
 
 		i915_request_put(rq);
 	}
 }
 
-void intel_engine_signal_breadcrumbs(struct intel_engine_cs *engine)
-{
-	local_irq_disable();
-	intel_engine_breadcrumbs_irq(engine);
-	local_irq_enable();
-}
-
 static void signal_irq_work(struct irq_work *work)
 {
 	struct intel_engine_cs *engine =
@@ -276,7 +269,6 @@ void intel_engine_fini_breadcrumbs(struct intel_engine_cs *engine)
 bool i915_request_enable_breadcrumb(struct i915_request *rq)
 {
 	lockdep_assert_held(&rq->lock);
-	lockdep_assert_irqs_disabled();
 
 	if (test_bit(I915_FENCE_FLAG_ACTIVE, &rq->fence.flags)) {
 		struct intel_breadcrumbs *b = &rq->engine->breadcrumbs;
@@ -325,7 +317,6 @@ void i915_request_cancel_breadcrumb(struct i915_request *rq)
 	struct intel_breadcrumbs *b = &rq->engine->breadcrumbs;
 
 	lockdep_assert_held(&rq->lock);
-	lockdep_assert_irqs_disabled();
 
 	/*
 	 * We must wait for b->irq_lock so that we know the interrupt handler
diff --git a/drivers/gpu/drm/i915/intel_hangcheck.c b/drivers/gpu/drm/i915/intel_hangcheck.c
index 3d51ed1428d4e..c7022bd93d24c 100644
--- a/drivers/gpu/drm/i915/intel_hangcheck.c
+++ b/drivers/gpu/drm/i915/intel_hangcheck.c
@@ -275,7 +275,7 @@ static void i915_hangcheck_elapsed(struct work_struct *work)
 	for_each_engine(engine, dev_priv, id) {
 		struct hangcheck hc;
 
-		intel_engine_signal_breadcrumbs(engine);
+		intel_engine_breadcrumbs_irq(engine);
 
 		hangcheck_load_sample(engine, &hc);
 		hangcheck_accumulate_sample(engine, &hc);
diff --git a/drivers/gpu/drm/i915/intel_ringbuffer.h b/drivers/gpu/drm/i915/intel_ringbuffer.h
index 72c7c337ace95..e3857cc5ad185 100644
--- a/drivers/gpu/drm/i915/intel_ringbuffer.h
+++ b/drivers/gpu/drm/i915/intel_ringbuffer.h
@@ -388,7 +388,6 @@ void intel_engine_fini_breadcrumbs(struct intel_engine_cs *engine);
 void intel_engine_pin_breadcrumbs_irq(struct intel_engine_cs *engine);
 void intel_engine_unpin_breadcrumbs_irq(struct intel_engine_cs *engine);
 
-void intel_engine_signal_breadcrumbs(struct intel_engine_cs *engine);
 void intel_engine_disarm_breadcrumbs(struct intel_engine_cs *engine);
 
 static inline void
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 885a195dfbe02..25afa2bb1a2cf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -308,7 +308,9 @@ void pin_current_cpu(void)
 	preempt_lazy_enable();
 	preempt_enable();
 
+	sleeping_lock_inc();
 	__read_rt_lock(cpuhp_pin);
+	sleeping_lock_dec();
 
 	preempt_disable();
 	preempt_lazy_disable();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e3fa33f2e23c2..58c545a528b3b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -703,14 +703,10 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		goto out;
 	}
 
-	if (user->seq == 0) {
-		user->seq = seq;
-	} else {
-		user->seq++;
-		if (user->seq < seq) {
-			ret = -EPIPE;
-			goto restore_out;
-		}
+	user->seq++;
+	if (user->seq < seq) {
+		ret = -EPIPE;
+		goto restore_out;
 	}
 
 	msg = (struct printk_log *)&user->msgbuf[0];
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index efaa5b3f4d3f0..ecb82cc432afe 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -60,10 +60,13 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
 #define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
 #define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
 #define RCUTORTURE_RDR_RCU	 0x20	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_NBITS	 6	/* Number of bits defined above. */
+#define RCUTORTURE_RDR_ATOM_BH	 0x40	/*  ... disabling bh while atomic */
+#define RCUTORTURE_RDR_ATOM_RBH	 0x80	/*  ... RBH while atomic */
+#define RCUTORTURE_RDR_NBITS	 8	/* Number of bits defined above. */
 #define RCUTORTURE_MAX_EXTEND	 \
 	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
-	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
+	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED | \
+	 RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH)
 #define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
 					/* Must be power of two minus one. */
 #define RCUTORTURE_RDR_MAX_SEGS (RCUTORTURE_RDR_MAX_LOOPS + 3)
@@ -1092,31 +1095,52 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	WARN_ON_ONCE((idxold >> RCUTORTURE_RDR_SHIFT) > 1);
 	rtrsp->rt_readstate = newstate;
 
-	/* First, put new protection in place to avoid critical-section gap. */
+	/*
+	 * First, put new protection in place to avoid critical-section gap.
+	 * Disable preemption around the ATOM disables to ensure that
+	 * in_atomic() is true.
+	 */
 	if (statesnew & RCUTORTURE_RDR_BH)
 		local_bh_disable();
+	if (statesnew & RCUTORTURE_RDR_RBH)
+		rcu_read_lock_bh();
 	if (statesnew & RCUTORTURE_RDR_IRQ)
 		local_irq_disable();
 	if (statesnew & RCUTORTURE_RDR_PREEMPT)
 		preempt_disable();
-	if (statesnew & RCUTORTURE_RDR_RBH)
-		rcu_read_lock_bh();
 	if (statesnew & RCUTORTURE_RDR_SCHED)
 		rcu_read_lock_sched();
+	preempt_disable();
+	if (statesnew & RCUTORTURE_RDR_ATOM_BH)
+		local_bh_disable();
+	if (statesnew & RCUTORTURE_RDR_ATOM_RBH)
+		rcu_read_lock_bh();
+	preempt_enable();
 	if (statesnew & RCUTORTURE_RDR_RCU)
 		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
 
-	/* Next, remove old protection, irq first due to bh conflict. */
+	/*
+	 * Next, remove old protection, in decreasing order of strength
+	 * to avoid unlock paths that aren't safe in the stronger
+	 * context.  Disable preemption around the ATOM enables in
+	 * case the context was only atomic due to IRQ disabling.
+	 */
+	preempt_disable();
 	if (statesold & RCUTORTURE_RDR_IRQ)
 		local_irq_enable();
-	if (statesold & RCUTORTURE_RDR_BH)
+	if (statesold & RCUTORTURE_RDR_ATOM_BH)
 		local_bh_enable();
+	if (statesold & RCUTORTURE_RDR_ATOM_RBH)
+		rcu_read_unlock_bh();
+	preempt_enable();
 	if (statesold & RCUTORTURE_RDR_PREEMPT)
 		preempt_enable();
-	if (statesold & RCUTORTURE_RDR_RBH)
-		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_SCHED)
 		rcu_read_unlock_sched();
+	if (statesold & RCUTORTURE_RDR_BH)
+		local_bh_enable();
+	if (statesold & RCUTORTURE_RDR_RBH)
+		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_RCU)
 		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
 
@@ -1152,6 +1176,12 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	int mask = rcutorture_extend_mask_max();
 	unsigned long randmask1 = torture_random(trsp) >> 8;
 	unsigned long randmask2 = randmask1 >> 3;
+	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
+	unsigned long nonatomic_bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
+	unsigned long atomic_bhs = RCUTORTURE_RDR_ATOM_BH |
+				   RCUTORTURE_RDR_ATOM_RBH;
+	unsigned long tmp;
 
 	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
 	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
@@ -1159,11 +1189,49 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 		mask = mask & randmask2;
 	else
 		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
-	/* Can't enable bh w/irq disabled. */
-	if ((mask & RCUTORTURE_RDR_IRQ) &&
-	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
-	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
-		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
+
+	/*
+	 * Can't enable bh w/irq disabled.
+	 */
+	tmp = atomic_bhs | nonatomic_bhs;
+	if (mask & RCUTORTURE_RDR_IRQ)
+		mask |= oldmask & tmp;
+
+	/*
+	 * Ideally these sequences would be detected in debug builds
+	 * (regardless of RT), but until then don't stop testing
+	 * them on non-RT.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
+		/*
+		 * Can't release the outermost rcu lock in an irq disabled
+		 * section without preemption also being disabled, if irqs
+		 * had ever been enabled during this RCU critical section
+		 * (could leak a special flag and delay reporting the qs).
+		 */
+		if ((oldmask & RCUTORTURE_RDR_RCU) &&
+		    (mask & RCUTORTURE_RDR_IRQ) &&
+		    !(mask & preempts))
+			mask |= RCUTORTURE_RDR_RCU;
+
+		/* Can't modify atomic bh in non-atomic context */
+		if ((oldmask & atomic_bhs) && (mask & atomic_bhs) &&
+		    !(mask & preempts_irq)) {
+			mask |= oldmask & preempts_irq;
+			if (mask & RCUTORTURE_RDR_IRQ)
+				mask |= oldmask & tmp;
+		}
+		if ((mask & atomic_bhs) && !(mask & preempts_irq))
+			mask |= RCUTORTURE_RDR_PREEMPT;
+
+		/* Can't modify non-atomic bh in atomic context */
+		tmp = nonatomic_bhs;
+		if (oldmask & preempts_irq)
+			mask &= ~tmp;
+		if ((oldmask | mask) & preempts_irq)
+			mask |= oldmask & tmp;
+	}
+
 	return mask ?: RCUTORTURE_RDR_RCU;
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fc8b00c61b328..2e999917c5937 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -99,8 +99,10 @@ struct rcu_state rcu_state = {
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
 /* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
-static bool use_softirq = 1;
+static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+#ifndef CONFIG_PREEMPT_RT_FULL
 module_param(use_softirq, bool, 0444);
+#endif
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
 module_param(rcu_fanout_exact, bool, 0444);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1bdd7f9be054..43f016d87f26a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1218,7 +1218,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(p->cpus_ptr, new_mask))
+	if (cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
@@ -1242,13 +1242,6 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
 		goto out;
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	if (__migrate_disabled(p)) {
-		p->migrate_disable_update = 1;
-		goto out;
-	}
-#endif
-
 	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
@@ -7290,9 +7283,8 @@ migrate_disable_update_cpus_allowed(struct task_struct *p)
 	struct rq *rq;
 	struct rq_flags rf;
 
-	p->cpus_ptr = cpumask_of(smp_processor_id());
-
 	rq = task_rq_lock(p, &rf);
+	p->cpus_ptr = cpumask_of(smp_processor_id());
 	update_nr_migratory(p, -1);
 	p->nr_cpus_allowed = 1;
 	task_rq_unlock(rq, p, &rf);
@@ -7304,9 +7296,8 @@ migrate_enable_update_cpus_allowed(struct task_struct *p)
 	struct rq *rq;
 	struct rq_flags rf;
 
-	p->cpus_ptr = &p->cpus_mask;
-
 	rq = task_rq_lock(p, &rf);
+	p->cpus_ptr = &p->cpus_mask;
 	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
 	update_nr_migratory(p, 1);
 	task_rq_unlock(rq, p, &rf);
@@ -7405,7 +7396,10 @@ void migrate_enable(void)
 			unpin_current_cpu();
 			preempt_lazy_enable();
 			preempt_enable();
+
+			sleeping_lock_inc();
 			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+			sleeping_lock_dec();
 			return;
 		}
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d16d080a74f70..6080c9328df10 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -115,8 +115,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	long soft_cnt;
 
 	WARN_ON_ONCE(in_irq());
-	if (!in_atomic())
+	if (!in_atomic()) {
 		local_lock(bh_lock);
+		rcu_read_lock();
+	}
 	soft_cnt = this_cpu_inc_return(softirq_counter);
 	WARN_ON_ONCE(soft_cnt == 0);
 	current->softirq_count += SOFTIRQ_DISABLE_OFFSET;
@@ -151,8 +153,10 @@ void _local_bh_enable(void)
 #endif
 
 	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
-	if (!in_atomic())
+	if (!in_atomic()) {
+		rcu_read_unlock();
 		local_unlock(bh_lock);
+	}
 }
 
 void _local_bh_enable_rt(void)
@@ -185,8 +189,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(count < 0);
 	local_irq_enable();
 
-	if (!in_atomic())
+	if (!in_atomic()) {
+		rcu_read_unlock();
 		local_unlock(bh_lock);
+	}
 
 	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
 	preempt_check_resched();
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 20cd92a8b9785..a045813c37021 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1167,8 +1167,10 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	expiry_lock = this_cpu_ptr(&cpu_timer_expiry_lock);
 	spin_lock(expiry_lock);
 
-	if (!lock_task_sighand(tsk, &flags))
+	if (!lock_task_sighand(tsk, &flags)) {
+		spin_unlock(expiry_lock);
 		return;
+	}
 	/*
 	 * Here we take off tsk->signal->cpu_timers[N] and
 	 * tsk->cpu_timers[N] all the timers that are firing, and
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
