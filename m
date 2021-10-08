Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CEC433FE
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 21:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450A260FC2
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Oct 2021 21:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhJHVbk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:31:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46578 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhJHVbj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Oct 2021 17:31:39 -0400
Date:   Fri, 8 Oct 2021 23:29:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633728581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=086ZcQfRwsEJpFql8lSaaTVHPmtBkvHW42d0PEYs0/8=;
        b=VJvIfIClV29JIAjuKxOSRtNjwpXyEtJGsNO5AFRGm8d16K4Fq2pv5k8v6XYRt9NrMMgsnM
        laUx7b7MR8TAGMhAF9ePVT7cKhtPh3lvI/iv+HF9K8WJq/pOd1WYxzTjMHzNmAmKpum6G3
        BMAOSJmakobRIVFt00A5fXkpO9bTsUn7S7pq+NMMqveEDAtqXP1XJq8nacgSha2RAzmX3d
        5aoTlbKzCgejRbWGb9up2QS7ce/UWNOqdo6L0ebVWC9ShfeN/r/bEjAKFgxh2RKLzqfFy+
        zI7wUyewnUfbzJM24Iyb1Pmeq8a3NZ5AZO6i7NfUtnlEcPULwlChOItSELXGHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633728581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=086ZcQfRwsEJpFql8lSaaTVHPmtBkvHW42d0PEYs0/8=;
        b=rrI6lIXL97WklMDxb0xgI8WvtsjETogMaJ4KMAsSxsaXr/HQDbymG6Lr5/I+51bkLodTdR
        rp27/z1KHghKdcCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc4-rt8
Message-ID: <20211008212940.nld3dkzclr3jc4tk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc4-rt8 patch set. 

Changes since v5.15-rc4-rt7:

  - Redo the i915 patches. Everyone with a i915 may help testing. The
    upstream thread is at
       https://lore.kernel.org/all/20211005150046.1000285-1-bigeasy@linutronix.de/
    I'm also curious to find out if the uncore.lock lock can be made a
    raw_spinlock_t or if doing so pushes the latency through the roof.
    See
       https://lore.kernel.org/all/20211006164628.s2mtsdd2jdbfyf7g@linutronix.de/
    Any help is welcome.

  - During the i915 rework, a preempt_disable_rt() section in the radeon
    driver has been dropped because there is a spinlock_t within this
    section.

  - The irq_work patch(es) have been reworked based on upstream's
    feedback. The irq_work is now no longer processed in softirq but by
    a per-CPU thread at the lowest RT priority.

  - The statistics accounting in networking has been reworked in order
    to decouple the seqcount_t "try lock" usage from statistics update
    and qdisc's running state. Patches by Ahmed S. Darwish.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.15-rc4-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rc4-rt7-rt8.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc4-rt8

The RT patch against v5.15-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc4-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc4-rt8.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/i915/gt/intel_context.c b/drivers/gpu/drm/i915/gt/intel_context.c
index e866105dd1746..17ca4dc4d0cb3 100644
--- a/drivers/gpu/drm/i915/gt/intel_context.c
+++ b/drivers/gpu/drm/i915/gt/intel_context.c
@@ -421,6 +421,7 @@ void intel_context_fini(struct intel_context *ce)
 
 	mutex_destroy(&ce->pin_mutex);
 	i915_active_fini(&ce->active);
+	i915_sw_fence_fini(&ce->guc_blocked);
 }
 
 void i915_context_module_exit(void)
diff --git a/drivers/gpu/drm/i915/gt/intel_context.h b/drivers/gpu/drm/i915/gt/intel_context.h
index c410989507466..bed60dff93eff 100644
--- a/drivers/gpu/drm/i915/gt/intel_context.h
+++ b/drivers/gpu/drm/i915/gt/intel_context.h
@@ -161,9 +161,11 @@ static inline void intel_context_enter(struct intel_context *ce)
 		ce->ops->enter(ce);
 }
 
-static inline void intel_context_mark_active(struct intel_context *ce)
+static inline void intel_context_mark_active(struct intel_context *ce,
+					     bool timeline_mutex_needed)
 {
-	lockdep_assert_held(&ce->timeline->mutex);
+	if (timeline_mutex_needed)
+		lockdep_assert_held(&ce->timeline->mutex);
 	++ce->active_count;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
index 74775ae961b2b..02c0ab9fbb4b8 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
@@ -42,7 +42,7 @@ heartbeat_create(struct intel_context *ce, gfp_t gfp)
 	struct i915_request *rq;
 
 	intel_context_enter(ce);
-	rq = __i915_request_create(ce, gfp);
+	rq = __i915_request_create(ce, gfp, true);
 	intel_context_exit(ce);
 
 	return rq;
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
index 3927b1673799e..d75638d1d561e 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -80,41 +80,6 @@ static int __engine_unpark(struct intel_wakeref *wf)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_LOCKDEP)
-
-static unsigned long __timeline_mark_lock(struct intel_context *ce)
-{
-	unsigned long flags = 0;
-
-	if (!force_irqthreads())
-		local_irq_save(flags);
-	mutex_acquire(&ce->timeline->mutex.dep_map, 2, 0, _THIS_IP_);
-
-	return flags;
-}
-
-static void __timeline_mark_unlock(struct intel_context *ce,
-				   unsigned long flags)
-{
-	mutex_release(&ce->timeline->mutex.dep_map, _THIS_IP_);
-	if (!force_irqthreads())
-		local_irq_restore(flags);
-}
-
-#else
-
-static unsigned long __timeline_mark_lock(struct intel_context *ce)
-{
-	return 0;
-}
-
-static void __timeline_mark_unlock(struct intel_context *ce,
-				   unsigned long flags)
-{
-}
-
-#endif /* !IS_ENABLED(CONFIG_LOCKDEP) */
-
 static void duration(struct dma_fence *fence, struct dma_fence_cb *cb)
 {
 	struct i915_request *rq = to_request(fence);
@@ -161,7 +126,6 @@ static bool switch_to_kernel_context(struct intel_engine_cs *engine)
 {
 	struct intel_context *ce = engine->kernel_context;
 	struct i915_request *rq;
-	unsigned long flags;
 	bool result = true;
 
 	/* GPU is pointing to the void, as good as in the kernel context. */
@@ -203,10 +167,9 @@ static bool switch_to_kernel_context(struct intel_engine_cs *engine)
 	 * engine->wakeref.count, we may see the request completion and retire
 	 * it causing an underflow of the engine->wakeref.
 	 */
-	flags = __timeline_mark_lock(ce);
 	GEM_BUG_ON(atomic_read(&ce->timeline->active_count) < 0);
 
-	rq = __i915_request_create(ce, GFP_NOWAIT);
+	rq = __i915_request_create(ce, GFP_NOWAIT, false);
 	if (IS_ERR(rq))
 		/* Context switch failed, hope for the best! Maybe reset? */
 		goto out_unlock;
@@ -235,7 +198,6 @@ static bool switch_to_kernel_context(struct intel_engine_cs *engine)
 
 	result = false;
 out_unlock:
-	__timeline_mark_unlock(ce, flags);
 	return result;
 }
 
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index c86286827186f..547347241a47c 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -886,8 +886,8 @@ static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
 	 */
 	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
-	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
-	preempt_disable_rt();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -951,8 +951,8 @@ static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
 	if (etime)
 		*etime = ktime_get();
 
-	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
-	preempt_enable_rt();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 79da5eca60af5..3bab8f651b4e7 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -559,7 +559,6 @@ bool __i915_request_submit(struct i915_request *request)
 
 	RQ_TRACE(request, "\n");
 
-	GEM_BUG_ON(!irqs_disabled());
 	lockdep_assert_held(&engine->sched_engine->lock);
 
 	/*
@@ -668,7 +667,6 @@ void __i915_request_unsubmit(struct i915_request *request)
 	 */
 	RQ_TRACE(request, "\n");
 
-	GEM_BUG_ON(!irqs_disabled());
 	lockdep_assert_held(&engine->sched_engine->lock);
 
 	/*
@@ -835,7 +833,8 @@ static void __i915_request_ctor(void *arg)
 }
 
 struct i915_request *
-__i915_request_create(struct intel_context *ce, gfp_t gfp)
+__i915_request_create(struct intel_context *ce, gfp_t gfp,
+		      bool timeline_mutex_needed)
 {
 	struct intel_timeline *tl = ce->timeline;
 	struct i915_request *rq;
@@ -959,7 +958,7 @@ __i915_request_create(struct intel_context *ce, gfp_t gfp)
 
 	rq->infix = rq->ring->emit; /* end of header; start of user payload */
 
-	intel_context_mark_active(ce);
+	intel_context_mark_active(ce, timeline_mutex_needed);
 	list_add_tail_rcu(&rq->link, &tl->requests);
 
 	return rq;
@@ -995,7 +994,7 @@ i915_request_create(struct intel_context *ce)
 		i915_request_retire(rq);
 
 	intel_context_enter(ce);
-	rq = __i915_request_create(ce, GFP_KERNEL);
+	rq = __i915_request_create(ce, GFP_KERNEL, true);
 	intel_context_exit(ce); /* active reference transferred to request */
 	if (IS_ERR(rq))
 		goto err_unlock;
diff --git a/drivers/gpu/drm/i915/i915_request.h b/drivers/gpu/drm/i915/i915_request.h
index 1bc1349ba3c25..ba1ced79c8d2c 100644
--- a/drivers/gpu/drm/i915/i915_request.h
+++ b/drivers/gpu/drm/i915/i915_request.h
@@ -320,7 +320,8 @@ static inline bool dma_fence_is_i915(const struct dma_fence *fence)
 struct kmem_cache *i915_request_slab_cache(void);
 
 struct i915_request * __must_check
-__i915_request_create(struct intel_context *ce, gfp_t gfp);
+__i915_request_create(struct intel_context *ce, gfp_t gfp,
+		      bool timeline_mutex_needed);
 struct i915_request * __must_check
 i915_request_create(struct intel_context *ce);
 
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 9a08bc8e1f123..573154268d43a 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1814,7 +1814,6 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 	struct radeon_device *rdev = dev->dev_private;
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
-	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -1907,7 +1906,6 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
-	preempt_enable_rt();
 
 	/* Decode into vertical and horizontal scanout position. */
 	*vpos = position & 0x1fff;
diff --git a/drivers/net/ethernet/netronome/nfp/abm/qdisc.c b/drivers/net/ethernet/netronome/nfp/abm/qdisc.c
index 2473fb5f75e5e..2a5cc64227e9f 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/qdisc.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/qdisc.c
@@ -458,7 +458,7 @@ nfp_abm_qdisc_graft(struct nfp_abm_link *alink, u32 handle, u32 child_handle,
 static void
 nfp_abm_stats_calculate(struct nfp_alink_stats *new,
 			struct nfp_alink_stats *old,
-			struct gnet_stats_basic_packed *bstats,
+			struct gnet_stats_basic_sync *bstats,
 			struct gnet_stats_queue *qstats)
 {
 	_bstats_update(bstats, new->tx_bytes - old->tx_bytes,
diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index c34a3e8030e12..1e5399e47c3a5 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -60,7 +60,7 @@ struct drm_mode_object {
 	void (*free_cb)(struct kref *kref);
 };
 
-#define DRM_OBJECT_MAX_PROPERTY 24
+#define DRM_OBJECT_MAX_PROPERTY 42
 /**
  * struct drm_object_properties - property tracking for &drm_mode_object
  */
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 3ae8ba3fad3af..8cd11a2232605 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -72,10 +72,4 @@ static inline void irq_work_run(void) { }
 static inline void irq_work_single(void *arg) { }
 #endif
 
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT)
-void irq_work_tick_soft(void);
-#else
-static inline void irq_work_tick_soft(void) { }
-#endif
-
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d79163208dfdb..1e15a5ebed3f7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1916,7 +1916,6 @@ enum netdev_ml_priv_type {
  *	@sfp_bus:	attached &struct sfp_bus structure.
  *
  *	@qdisc_tx_busylock: lockdep class annotating Qdisc->busylock spinlock
- *	@qdisc_running_key: lockdep class annotating Qdisc->running seqcount
  *
  *	@proto_down:	protocol port state information can be sent to the
  *			switch driver and used to set the phys state of the
@@ -2250,7 +2249,6 @@ struct net_device {
 	struct phy_device	*phydev;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
-	struct lock_class_key	*qdisc_running_key;
 	bool			proto_down;
 	unsigned		wol_enabled:1;
 	unsigned		threaded:1;
@@ -2360,13 +2358,11 @@ static inline void netdev_for_each_tx_queue(struct net_device *dev,
 #define netdev_lockdep_set_classes(dev)				\
 {								\
 	static struct lock_class_key qdisc_tx_busylock_key;	\
-	static struct lock_class_key qdisc_running_key;		\
 	static struct lock_class_key qdisc_xmit_lock_key;	\
 	static struct lock_class_key dev_addr_list_lock_key;	\
 	unsigned int i;						\
 								\
 	(dev)->qdisc_tx_busylock = &qdisc_tx_busylock_key;	\
-	(dev)->qdisc_running_key = &qdisc_running_key;		\
 	lockdep_set_class(&(dev)->addr_list_lock,		\
 			  &dev_addr_list_lock_key);		\
 	for (i = 0; i < (dev)->num_tx_queues; i++)		\
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 66eb968a09d49..81dc1f5e181ac 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -83,6 +83,11 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return local64_read(&p->v);
 }
 
+static inline void u64_stats_set(u64_stats_t *p, u64 val)
+{
+	local64_set(&p->v, val);
+}
+
 static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 {
 	local64_add(val, &p->v);
@@ -104,6 +109,11 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return p->v;
 }
 
+static inline void u64_stats_set(u64_stats_t *p, u64 val)
+{
+	p->v = val;
+}
+
 static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 {
 	p->v += val;
diff --git a/include/net/act_api.h b/include/net/act_api.h
index f19f7f4a463cd..b5b624c7e4888 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -30,13 +30,13 @@ struct tc_action {
 	atomic_t			tcfa_bindcnt;
 	int				tcfa_action;
 	struct tcf_t			tcfa_tm;
-	struct gnet_stats_basic_packed	tcfa_bstats;
-	struct gnet_stats_basic_packed	tcfa_bstats_hw;
+	struct gnet_stats_basic_sync	tcfa_bstats;
+	struct gnet_stats_basic_sync	tcfa_bstats_hw;
 	struct gnet_stats_queue		tcfa_qstats;
 	struct net_rate_estimator __rcu *tcfa_rate_est;
 	spinlock_t			tcfa_lock;
-	struct gnet_stats_basic_cpu __percpu *cpu_bstats;
-	struct gnet_stats_basic_cpu __percpu *cpu_bstats_hw;
+	struct gnet_stats_basic_sync __percpu *cpu_bstats;
+	struct gnet_stats_basic_sync __percpu *cpu_bstats_hw;
 	struct gnet_stats_queue __percpu *cpu_qstats;
 	struct tc_cookie	__rcu *act_cookie;
 	struct tcf_chain	__rcu *goto_chain;
@@ -206,7 +206,7 @@ static inline void tcf_action_update_bstats(struct tc_action *a,
 					    struct sk_buff *skb)
 {
 	if (likely(a->cpu_bstats)) {
-		bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), skb);
+		bstats_update(this_cpu_ptr(a->cpu_bstats), skb);
 		return;
 	}
 	spin_lock(&a->tcfa_lock);
diff --git a/include/net/gen_stats.h b/include/net/gen_stats.h
index 163f8415e5db5..4578bbf3fc1f5 100644
--- a/include/net/gen_stats.h
+++ b/include/net/gen_stats.h
@@ -6,19 +6,34 @@
 #include <linux/socket.h>
 #include <linux/rtnetlink.h>
 #include <linux/pkt_sched.h>
-#include <net/net_seq_lock.h>
 
-/* Note: this used to be in include/uapi/linux/gen_stats.h */
-struct gnet_stats_basic_packed {
-	__u64	bytes;
-	__u64	packets;
-};
-
-struct gnet_stats_basic_cpu {
-	struct gnet_stats_basic_packed bstats;
+/* Throughput stats.
+ * Must be initialized beforehand with gnet_stats_basic_sync_init().
+ *
+ * If no reads can ever occur parallel to writes (e.g. stack-allocated
+ * bstats), then the internal stat values can be written to and read
+ * from directly. Otherwise, use _bstats_set/update() for writes and
+ * __gnet_stats_copy_basic() for reads.
+ */
+struct gnet_stats_basic_sync {
+	u64_stats_t bytes;
+	u64_stats_t packets;
 	struct u64_stats_sync syncp;
 } __aligned(2 * sizeof(u64));
 
+#ifdef CONFIG_LOCKDEP
+void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b);
+
+#else
+
+static inline void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
+{
+	u64_stats_set(&b->bytes, 0);
+	u64_stats_set(&b->packets, 0);
+	u64_stats_init(&b->syncp);
+}
+#endif
+
 struct net_rate_estimator;
 
 struct gnet_dump {
@@ -43,18 +58,18 @@ int gnet_stats_start_copy_compat(struct sk_buff *skb, int type,
 				 spinlock_t *lock, struct gnet_dump *d,
 				 int padattr);
 
-int gnet_stats_copy_basic(net_seqlock_t *running,
-			  struct gnet_dump *d,
-			  struct gnet_stats_basic_cpu __percpu *cpu,
-			  struct gnet_stats_basic_packed *b);
-void __gnet_stats_copy_basic(net_seqlock_t *running,
-			     struct gnet_stats_basic_packed *bstats,
-			     struct gnet_stats_basic_cpu __percpu *cpu,
-			     struct gnet_stats_basic_packed *b);
-int gnet_stats_copy_basic_hw(net_seqlock_t *running,
-			     struct gnet_dump *d,
-			     struct gnet_stats_basic_cpu __percpu *cpu,
-			     struct gnet_stats_basic_packed *b);
+int gnet_stats_copy_basic(struct gnet_dump *d,
+			  struct gnet_stats_basic_sync __percpu *cpu,
+			  struct gnet_stats_basic_sync *b,
+			  bool running);
+void __gnet_stats_copy_basic(struct gnet_stats_basic_sync *bstats,
+			     struct gnet_stats_basic_sync __percpu *cpu,
+			     struct gnet_stats_basic_sync *b,
+			     bool running);
+int gnet_stats_copy_basic_hw(struct gnet_dump *d,
+			     struct gnet_stats_basic_sync __percpu *cpu,
+			     struct gnet_stats_basic_sync *b,
+			     bool unning);
 int gnet_stats_copy_rate_est(struct gnet_dump *d,
 			     struct net_rate_estimator __rcu **ptr);
 int gnet_stats_copy_queue(struct gnet_dump *d,
@@ -67,17 +82,17 @@ int gnet_stats_copy_app(struct gnet_dump *d, void *st, int len);
 
 int gnet_stats_finish_copy(struct gnet_dump *d);
 
-int gen_new_estimator(struct gnet_stats_basic_packed *bstats,
-		      struct gnet_stats_basic_cpu __percpu *cpu_bstats,
+int gen_new_estimator(struct gnet_stats_basic_sync *bstats,
+		      struct gnet_stats_basic_sync __percpu *cpu_bstats,
 		      struct net_rate_estimator __rcu **rate_est,
 		      spinlock_t *lock,
-		      net_seqlock_t *running, struct nlattr *opt);
+		      bool running, struct nlattr *opt);
 void gen_kill_estimator(struct net_rate_estimator __rcu **ptr);
-int gen_replace_estimator(struct gnet_stats_basic_packed *bstats,
-			  struct gnet_stats_basic_cpu __percpu *cpu_bstats,
+int gen_replace_estimator(struct gnet_stats_basic_sync *bstats,
+			  struct gnet_stats_basic_sync __percpu *cpu_bstats,
 			  struct net_rate_estimator __rcu **ptr,
 			  spinlock_t *lock,
-			  net_seqlock_t *running, struct nlattr *opt);
+			  bool running, struct nlattr *opt);
 bool gen_estimator_active(struct net_rate_estimator __rcu **ptr);
 bool gen_estimator_read(struct net_rate_estimator __rcu **ptr,
 			struct gnet_stats_rate_est64 *sample);
diff --git a/include/net/net_seq_lock.h b/include/net/net_seq_lock.h
deleted file mode 100644
index 67710bace7418..0000000000000
--- a/include/net/net_seq_lock.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __NET_NET_SEQ_LOCK_H__
-#define __NET_NET_SEQ_LOCK_H__
-
-#ifdef CONFIG_PREEMPT_RT
-# define net_seqlock_t			seqlock_t
-# define net_seq_begin(__r)		read_seqbegin(__r)
-# define net_seq_retry(__r, __s)	read_seqretry(__r, __s)
-
-#else
-# define net_seqlock_t			seqcount_t
-# define net_seq_begin(__r)		read_seqcount_begin(__r)
-# define net_seq_retry(__r, __s)	read_seqcount_retry(__r, __s)
-#endif
-
-#endif
diff --git a/include/net/netfilter/xt_rateest.h b/include/net/netfilter/xt_rateest.h
index 832ab69efda57..4c3809e141f4f 100644
--- a/include/net/netfilter/xt_rateest.h
+++ b/include/net/netfilter/xt_rateest.h
@@ -6,7 +6,7 @@
 
 struct xt_rateest {
 	/* keep lock and bstats on same cache line to speedup xt_rateest_tg() */
-	struct gnet_stats_basic_packed	bstats;
+	struct gnet_stats_basic_sync	bstats;
 	spinlock_t			lock;
 
 
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 83a6d07921806..4a5833108083f 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -765,7 +765,7 @@ struct tc_cookie {
 };
 
 struct tc_qopt_offload_stats {
-	struct gnet_stats_basic_packed *bstats;
+	struct gnet_stats_basic_sync *bstats;
 	struct gnet_stats_queue *qstats;
 };
 
@@ -885,7 +885,7 @@ struct tc_gred_qopt_offload_params {
 };
 
 struct tc_gred_qopt_offload_stats {
-	struct gnet_stats_basic_packed bstats[MAX_DPs];
+	struct gnet_stats_basic_sync bstats[MAX_DPs];
 	struct gnet_stats_queue qstats[MAX_DPs];
 	struct red_stats *xstats[MAX_DPs];
 };
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 5ab89e53bc20f..023322c8d7c0e 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -10,7 +10,6 @@
 #include <linux/percpu.h>
 #include <linux/dynamic_queue_limits.h>
 #include <linux/list.h>
-#include <net/net_seq_lock.h>
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
@@ -39,6 +38,10 @@ enum qdisc_state_t {
 	__QDISC_STATE_DEACTIVATED,
 	__QDISC_STATE_MISSED,
 	__QDISC_STATE_DRAINING,
+	/* Only for !TCQ_F_NOLOCK qdisc. Never access it directly.
+	 * Use qdisc_run_begin/end() or qdisc_is_running() instead.
+	 */
+	__QDISC_STATE_RUNNING,
 };
 
 #define QDISC_STATE_MISSED	BIT(__QDISC_STATE_MISSED)
@@ -98,7 +101,7 @@ struct Qdisc {
 	struct netdev_queue	*dev_queue;
 
 	struct net_rate_estimator __rcu *rate_est;
-	struct gnet_stats_basic_cpu __percpu *cpu_bstats;
+	struct gnet_stats_basic_sync __percpu *cpu_bstats;
 	struct gnet_stats_queue	__percpu *cpu_qstats;
 	int			pad;
 	refcount_t		refcnt;
@@ -108,8 +111,7 @@ struct Qdisc {
 	 */
 	struct sk_buff_head	gso_skb ____cacheline_aligned_in_smp;
 	struct qdisc_skb_head	q;
-	struct gnet_stats_basic_packed bstats;
-	net_seqlock_t		running;
+	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue	qstats;
 	unsigned long		state;
 	struct Qdisc            *next_sched;
@@ -144,15 +146,15 @@ static inline struct Qdisc *qdisc_refcount_inc_nz(struct Qdisc *qdisc)
 	return NULL;
 }
 
+/* For !TCQ_F_NOLOCK qdisc: callers must either call this within a qdisc
+ * root_lock section, or provide their own memory barriers -- ordering
+ * against qdisc_run_begin/end() atomic bit operations.
+ */
 static inline bool qdisc_is_running(struct Qdisc *qdisc)
 {
 	if (qdisc->flags & TCQ_F_NOLOCK)
 		return spin_is_locked(&qdisc->seqlock);
-#ifdef CONFIG_PREEMPT_RT
-	return spin_is_locked(&qdisc->running.lock);
-#else
-	return (raw_read_seqcount(&qdisc->running) & 1) ? true : false;
-#endif
+	return test_bit(__QDISC_STATE_RUNNING, &qdisc->state);
 }
 
 static inline bool nolock_qdisc_is_empty(const struct Qdisc *qdisc)
@@ -172,6 +174,9 @@ static inline bool qdisc_is_empty(const struct Qdisc *qdisc)
 	return !READ_ONCE(qdisc->q.qlen);
 }
 
+/* For !TCQ_F_NOLOCK qdisc, qdisc_run_begin/end() must be invoked with
+ * the qdisc root lock acquired.
+ */
 static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 {
 	if (qdisc->flags & TCQ_F_NOLOCK) {
@@ -211,31 +216,8 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		 * after it releases the lock at the end of qdisc_run_end().
 		 */
 		return spin_trylock(&qdisc->seqlock);
-	} else if (qdisc_is_running(qdisc)) {
-		return false;
 	}
-
-#ifdef CONFIG_PREEMPT_RT
-	if (spin_trylock(&qdisc->running.lock)) {
-		seqcount_t *s = &qdisc->running.seqcount.seqcount;
-
-		/*
-		 * Variant of write_seqcount_t_begin() telling lockdep that
-		 * a trylock was attempted.
-		 */
-		do_raw_write_seqcount_begin(s);
-		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
-		return true;
-	}
-	return false;
-#else
-	/* Variant of write_seqcount_begin() telling lockdep a trylock
-	 * was attempted.
-	 */
-	raw_write_seqcount_begin(&qdisc->running);
-	seqcount_acquire(&qdisc->running.dep_map, 0, 1, _RET_IP_);
-	return true;
-#endif
+	return test_and_set_bit(__QDISC_STATE_RUNNING, &qdisc->state);
 }
 
 static inline void qdisc_run_end(struct Qdisc *qdisc)
@@ -247,11 +229,7 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
 				      &qdisc->state)))
 			__netif_schedule(qdisc);
 	} else {
-#ifdef CONFIG_PREEMPT_RT
-		write_sequnlock(&qdisc->running);
-#else
-		write_seqcount_end(&qdisc->running);
-#endif
+		clear_bit(__QDISC_STATE_RUNNING, &qdisc->state);
 	}
 }
 
@@ -615,14 +593,6 @@ static inline spinlock_t *qdisc_root_sleeping_lock(const struct Qdisc *qdisc)
 	return qdisc_lock(root);
 }
 
-static inline net_seqlock_t *qdisc_root_sleeping_running(const struct Qdisc *qdisc)
-{
-	struct Qdisc *root = qdisc_root_sleeping(qdisc);
-
-	ASSERT_RTNL();
-	return &root->running;
-}
-
 static inline struct net_device *qdisc_dev(const struct Qdisc *qdisc)
 {
 	return qdisc->dev_queue->dev;
@@ -870,14 +840,32 @@ static inline int qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return sch->enqueue(skb, sch, to_free);
 }
 
-static inline void _bstats_update(struct gnet_stats_basic_packed *bstats,
+static inline void _bstats_update(struct gnet_stats_basic_sync *bstats,
 				  __u64 bytes, __u32 packets)
 {
-	bstats->bytes += bytes;
-	bstats->packets += packets;
+	u64_stats_update_begin(&bstats->syncp);
+	u64_stats_add(&bstats->bytes, bytes);
+	u64_stats_add(&bstats->packets, packets);
+	u64_stats_update_end(&bstats->syncp);
 }
 
-static inline void bstats_update(struct gnet_stats_basic_packed *bstats,
+static inline void bstats_read_add(struct gnet_stats_basic_sync *bstats,
+				   __u64 *bytes, __u64 *packets)
+{
+	u64 t_bytes, t_packets;
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin_irq(&bstats->syncp);
+		t_bytes = u64_stats_read(&bstats->bytes);
+		t_packets = u64_stats_read(&bstats->packets);
+	} while (u64_stats_fetch_retry_irq(&bstats->syncp, start));
+
+	*bytes = t_bytes;
+	*packets = t_packets;
+}
+
+static inline void bstats_update(struct gnet_stats_basic_sync *bstats,
 				 const struct sk_buff *skb)
 {
 	_bstats_update(bstats,
@@ -885,26 +873,10 @@ static inline void bstats_update(struct gnet_stats_basic_packed *bstats,
 		       skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1);
 }
 
-static inline void _bstats_cpu_update(struct gnet_stats_basic_cpu *bstats,
-				      __u64 bytes, __u32 packets)
-{
-	u64_stats_update_begin(&bstats->syncp);
-	_bstats_update(&bstats->bstats, bytes, packets);
-	u64_stats_update_end(&bstats->syncp);
-}
-
-static inline void bstats_cpu_update(struct gnet_stats_basic_cpu *bstats,
-				     const struct sk_buff *skb)
-{
-	u64_stats_update_begin(&bstats->syncp);
-	bstats_update(&bstats->bstats, skb);
-	u64_stats_update_end(&bstats->syncp);
-}
-
 static inline void qdisc_bstats_cpu_update(struct Qdisc *sch,
 					   const struct sk_buff *skb)
 {
-	bstats_cpu_update(this_cpu_ptr(sch->cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(sch->cpu_bstats), skb);
 }
 
 static inline void qdisc_bstats_update(struct Qdisc *sch,
@@ -1337,7 +1309,7 @@ void psched_ppscfg_precompute(struct psched_pktrate *r, u64 pktrate64);
 struct mini_Qdisc {
 	struct tcf_proto *filter_list;
 	struct tcf_block *block;
-	struct gnet_stats_basic_cpu __percpu *cpu_bstats;
+	struct gnet_stats_basic_sync __percpu *cpu_bstats;
 	struct gnet_stats_queue	__percpu *cpu_qstats;
 	struct rcu_head rcu;
 };
@@ -1345,7 +1317,7 @@ struct mini_Qdisc {
 static inline void mini_qdisc_bstats_cpu_update(struct mini_Qdisc *miniq,
 						const struct sk_buff *skb)
 {
-	bstats_cpu_update(this_cpu_ptr(miniq->cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(miniq->cpu_bstats), skb);
 }
 
 static inline void mini_qdisc_qstats_cpu_drop(struct mini_Qdisc *miniq)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ac072b1d1a2d2..894e4db1fffcc 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -26,7 +26,6 @@
 
 #if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
 DEFINE_STATIC_KEY_FALSE(force_irqthreads_key);
-EXPORT_SYMBOL_GPL(force_irqthreads_key);
 
 static int __init setup_forced_irqthreads(char *arg)
 {
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index ee27f56381ee2..f7df715ec28e6 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -18,12 +18,36 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
-#include <linux/interrupt.h>
+#include <linux/smpboot.h>
 #include <asm/processor.h>
 #include <linux/kasan.h>
 
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
+static DEFINE_PER_CPU(struct task_struct *, irq_workd);
+
+static void wake_irq_workd(void)
+{
+	struct task_struct *tsk = __this_cpu_read(irq_workd);
+
+	if (!llist_empty(this_cpu_ptr(&lazy_list)) && tsk)
+		wake_up_process(tsk);
+}
+
+#ifdef CONFIG_SMP
+static void irq_work_wake(struct irq_work *entry)
+{
+	wake_irq_workd();
+}
+
+static DEFINE_PER_CPU(struct irq_work, irq_work_wakeup) =
+	IRQ_WORK_INIT_HARD(irq_work_wake);
+#endif
+
+static int irq_workd_should_run(unsigned int cpu)
+{
+	return !llist_empty(this_cpu_ptr(&lazy_list));
+}
 
 /*
  * Claim the entry so that no one else will poke at it.
@@ -54,7 +78,8 @@ void __weak arch_irq_work_raise(void)
 static void __irq_work_queue_local(struct irq_work *work)
 {
 	struct llist_head *list;
-	bool lazy_work;
+	bool rt_lazy_work = false;
+	bool lazy_work = false;
 	int work_flags;
 
 	work_flags = atomic_read(&work->node.a_flags);
@@ -62,20 +87,19 @@ static void __irq_work_queue_local(struct irq_work *work)
 		lazy_work = true;
 	else if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
 		 !(work_flags & IRQ_WORK_HARD_IRQ))
-		lazy_work = true;
-	else
-		lazy_work = false;
+		rt_lazy_work = true;
 
-	if (lazy_work)
+	if (lazy_work || rt_lazy_work)
 		list = this_cpu_ptr(&lazy_list);
 	else
 		list = this_cpu_ptr(&raised_list);
 
-	if (llist_add(&work->node.llist, list)) {
-		/* If the work is "lazy", handle it from next tick if any */
-		if (!lazy_work || tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	}
+	if (!llist_add(&work->node.llist, list))
+		return;
+
+	/* If the work is "lazy", handle it from next tick if any */
+	if (!lazy_work || tick_nohz_tick_stopped())
+		arch_irq_work_raise();
 }
 
 /* Enqueue the irq work @work on the current CPU */
@@ -120,28 +144,40 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
 
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ)) {
-			if (llist_add(&work->node.llist, &per_cpu(lazy_list, cpu)))
-				arch_send_call_function_single_ipi(cpu);
-		} else {
-			__smp_call_single_queue(cpu, &work->node.llist);
+		/*
+		 * On PREEMPT_RT the items which are not marked as
+		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
+		 * item is used on the remote CPU to wake the thread.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		    !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ)) {
+
+			if (!llist_add(&work->node.llist, &per_cpu(lazy_list, cpu)))
+				goto out;
+
+			work = &per_cpu(irq_work_wakeup, cpu);
+			if (!irq_work_claim(work))
+				goto out;
 		}
+
+		__smp_call_single_queue(cpu, &work->node.llist);
 	} else {
 		__irq_work_queue_local(work);
 	}
+out:
 	preempt_enable();
 
 	return true;
 #endif /* CONFIG_SMP */
 }
 
-
 bool irq_work_needs_cpu(void)
 {
 	struct llist_head *raised, *lazy;
 
 	raised = this_cpu_ptr(&raised_list);
 	lazy = this_cpu_ptr(&lazy_list);
+
 	if (llist_empty(raised) || arch_irq_work_has_interrupt())
 		if (llist_empty(lazy))
 			return false;
@@ -192,10 +228,11 @@ static void irq_work_run_list(struct llist_head *list)
 	struct llist_node *llnode;
 
 	/*
-	 * On PREEMPT_RT IRQ-work may run in SOFTIRQ context if it is not marked
-	 * explicitly that it needs to run in hardirq context.
+	 * On PREEMPT_RT IRQ-work which is not marked as HARD will be processed
+	 * in a per-CPU thread in preemptible context. Only the items which are
+	 * marked as IRQ_WORK_HARD_IRQ will be processed in hardirq context.
 	 */
-	BUG_ON(!in_hardirq() && !IS_ENABLED(CONFIG_PREEMPT_RT));
+	BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
 
 	if (llist_empty(list))
 		return;
@@ -214,8 +251,8 @@ void irq_work_run(void)
 	irq_work_run_list(this_cpu_ptr(&raised_list));
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		irq_work_run_list(this_cpu_ptr(&lazy_list));
-	else if (!llist_empty(this_cpu_ptr(&lazy_list)))
-		raise_softirq(TIMER_SOFTIRQ);
+	else
+		wake_irq_workd();
 }
 EXPORT_SYMBOL_GPL(irq_work_run);
 
@@ -228,15 +265,10 @@ void irq_work_tick(void)
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		irq_work_run_list(this_cpu_ptr(&lazy_list));
+	else
+		wake_irq_workd();
 }
 
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT)
-void irq_work_tick_soft(void)
-{
-	irq_work_run_list(this_cpu_ptr(&lazy_list));
-}
-#endif
-
 /*
  * Synchronize against the irq_work @entry, ensures the entry is not
  * currently in use.
@@ -257,3 +289,29 @@ void irq_work_sync(struct irq_work *work)
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+static void run_irq_workd(unsigned int cpu)
+{
+	irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+static void irq_workd_setup(unsigned int cpu)
+{
+	sched_set_fifo_low(current);
+}
+
+static struct smp_hotplug_thread irqwork_threads = {
+	.store                  = &irq_workd,
+	.setup			= irq_workd_setup,
+	.thread_should_run      = irq_workd_should_run,
+	.thread_fn              = run_irq_workd,
+	.thread_comm            = "irq_work/%u",
+};
+
+static __init int irq_work_init_threads(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		BUG_ON(smpboot_register_percpu_thread(&irqwork_threads));
+	return 0;
+}
+early_initcall(irq_work_init_threads);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index fb235b3e91b3e..e3d2c23c413d4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1744,8 +1744,6 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
-	irq_work_tick_soft();
-
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index e51f4854d8b2f..db5f0a77f4b38 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -40,10 +40,10 @@
  */
 
 struct net_rate_estimator {
-	struct gnet_stats_basic_packed	*bstats;
+	struct gnet_stats_basic_sync	*bstats;
 	spinlock_t		*stats_lock;
-	net_seqlock_t		*running;
-	struct gnet_stats_basic_cpu __percpu *cpu_bstats;
+	bool			running;
+	struct gnet_stats_basic_sync __percpu *cpu_bstats;
 	u8			ewma_log;
 	u8			intvl_log; /* period : (250ms << intvl_log) */
 
@@ -60,13 +60,13 @@ struct net_rate_estimator {
 };
 
 static void est_fetch_counters(struct net_rate_estimator *e,
-			       struct gnet_stats_basic_packed *b)
+			       struct gnet_stats_basic_sync *b)
 {
-	memset(b, 0, sizeof(*b));
+	gnet_stats_basic_sync_init(b);
 	if (e->stats_lock)
 		spin_lock(e->stats_lock);
 
-	__gnet_stats_copy_basic(e->running, b, e->cpu_bstats, e->bstats);
+	__gnet_stats_copy_basic(b, e->cpu_bstats, e->bstats, e->running);
 
 	if (e->stats_lock)
 		spin_unlock(e->stats_lock);
@@ -76,14 +76,18 @@ static void est_fetch_counters(struct net_rate_estimator *e,
 static void est_timer(struct timer_list *t)
 {
 	struct net_rate_estimator *est = from_timer(est, t, timer);
-	struct gnet_stats_basic_packed b;
+	struct gnet_stats_basic_sync b;
+	u64 b_bytes, b_packets;
 	u64 rate, brate;
 
 	est_fetch_counters(est, &b);
-	brate = (b.bytes - est->last_bytes) << (10 - est->intvl_log);
+	b_bytes = u64_stats_read(&b.bytes);
+	b_packets = u64_stats_read(&b.packets);
+
+	brate = (b_bytes - est->last_bytes) << (10 - est->intvl_log);
 	brate = (brate >> est->ewma_log) - (est->avbps >> est->ewma_log);
 
-	rate = (b.packets - est->last_packets) << (10 - est->intvl_log);
+	rate = (b_packets - est->last_packets) << (10 - est->intvl_log);
 	rate = (rate >> est->ewma_log) - (est->avpps >> est->ewma_log);
 
 	write_seqcount_begin(&est->seq);
@@ -91,8 +95,8 @@ static void est_timer(struct timer_list *t)
 	est->avpps += rate;
 	write_seqcount_end(&est->seq);
 
-	est->last_bytes = b.bytes;
-	est->last_packets = b.packets;
+	est->last_bytes = b_bytes;
+	est->last_packets = b_packets;
 
 	est->next_jiffies += ((HZ/4) << est->intvl_log);
 
@@ -109,7 +113,9 @@ static void est_timer(struct timer_list *t)
  * @cpu_bstats: bstats per cpu
  * @rate_est: rate estimator statistics
  * @lock: lock for statistics and control path
- * @running: qdisc running seqcount
+ * @running: true if @bstats represents a running qdisc, thus @bstats'
+ *           internal values might change during basic reads. Only used
+ *           if @bstats_cpu is NULL
  * @opt: rate estimator configuration TLV
  *
  * Creates a new rate estimator with &bstats as source and &rate_est
@@ -121,16 +127,16 @@ static void est_timer(struct timer_list *t)
  * Returns 0 on success or a negative error code.
  *
  */
-int gen_new_estimator(struct gnet_stats_basic_packed *bstats,
-		      struct gnet_stats_basic_cpu __percpu *cpu_bstats,
+int gen_new_estimator(struct gnet_stats_basic_sync *bstats,
+		      struct gnet_stats_basic_sync __percpu *cpu_bstats,
 		      struct net_rate_estimator __rcu **rate_est,
 		      spinlock_t *lock,
-		      net_seqlock_t *running,
+		      bool running,
 		      struct nlattr *opt)
 {
 	struct gnet_estimator *parm = nla_data(opt);
 	struct net_rate_estimator *old, *est;
-	struct gnet_stats_basic_packed b;
+	struct gnet_stats_basic_sync b;
 	int intvl_log;
 
 	if (nla_len(opt) < sizeof(*parm))
@@ -164,8 +170,8 @@ int gen_new_estimator(struct gnet_stats_basic_packed *bstats,
 	est_fetch_counters(est, &b);
 	if (lock)
 		local_bh_enable();
-	est->last_bytes = b.bytes;
-	est->last_packets = b.packets;
+	est->last_bytes = u64_stats_read(&b.bytes);
+	est->last_packets = u64_stats_read(&b.packets);
 
 	if (lock)
 		spin_lock_bh(lock);
@@ -214,7 +220,9 @@ EXPORT_SYMBOL(gen_kill_estimator);
  * @cpu_bstats: bstats per cpu
  * @rate_est: rate estimator statistics
  * @lock: lock for statistics and control path
- * @running: qdisc running seqcount (might be NULL)
+ * @running: true if @bstats represents a running qdisc, thus @bstats'
+ *           internal values might change during basic reads. Only used
+ *           if @cpu_bstats is NULL
  * @opt: rate estimator configuration TLV
  *
  * Replaces the configuration of a rate estimator by calling
@@ -222,11 +230,11 @@ EXPORT_SYMBOL(gen_kill_estimator);
  *
  * Returns 0 on success or a negative error code.
  */
-int gen_replace_estimator(struct gnet_stats_basic_packed *bstats,
-			  struct gnet_stats_basic_cpu __percpu *cpu_bstats,
+int gen_replace_estimator(struct gnet_stats_basic_sync *bstats,
+			  struct gnet_stats_basic_sync __percpu *cpu_bstats,
 			  struct net_rate_estimator __rcu **rate_est,
 			  spinlock_t *lock,
-			  net_seqlock_t *running, struct nlattr *opt)
+			  bool running, struct nlattr *opt)
 {
 	return gen_new_estimator(bstats, cpu_bstats, rate_est,
 				 lock, running, opt);
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index ef432cea2e105..b7d8e477897e1 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -18,7 +18,7 @@
 #include <linux/gen_stats.h>
 #include <net/netlink.h>
 #include <net/gen_stats.h>
-
+#include <net/sch_generic.h>
 
 static inline int
 gnet_stats_copy(struct gnet_dump *d, int type, void *buf, int size, int padattr)
@@ -114,35 +114,52 @@ gnet_stats_start_copy(struct sk_buff *skb, int type, spinlock_t *lock,
 }
 EXPORT_SYMBOL(gnet_stats_start_copy);
 
-static void
-__gnet_stats_copy_basic_cpu(struct gnet_stats_basic_packed *bstats,
-			    struct gnet_stats_basic_cpu __percpu *cpu)
+#ifdef CONFIG_LOCKDEP
+/* Must not be inlined, due to u64_stats seqcount_t lockdep key */
+void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
 {
+	u64_stats_set(&b->bytes, 0);
+	u64_stats_set(&b->packets, 0);
+	u64_stats_init(&b->syncp);
+}
+EXPORT_SYMBOL(gnet_stats_basic_sync_init);
+#endif
+
+static void
+__gnet_stats_copy_basic_cpu(struct gnet_stats_basic_sync *bstats,
+			    struct gnet_stats_basic_sync __percpu *cpu)
+{
+	u64 t_bytes = 0, t_packets = 0;
 	int i;
 
 	for_each_possible_cpu(i) {
-		struct gnet_stats_basic_cpu *bcpu = per_cpu_ptr(cpu, i);
+		struct gnet_stats_basic_sync *bcpu = per_cpu_ptr(cpu, i);
 		unsigned int start;
 		u64 bytes, packets;
 
 		do {
 			start = u64_stats_fetch_begin_irq(&bcpu->syncp);
-			bytes = bcpu->bstats.bytes;
-			packets = bcpu->bstats.packets;
+			bytes = u64_stats_read(&bcpu->bytes);
+			packets = u64_stats_read(&bcpu->packets);
 		} while (u64_stats_fetch_retry_irq(&bcpu->syncp, start));
 
-		bstats->bytes += bytes;
-		bstats->packets += packets;
+		t_bytes += bytes;
+		t_packets += packets;
 	}
+	_bstats_update(bstats, t_bytes, t_packets);
 }
 
 void
-__gnet_stats_copy_basic(net_seqlock_t *running,
-			struct gnet_stats_basic_packed *bstats,
-			struct gnet_stats_basic_cpu __percpu *cpu,
-			struct gnet_stats_basic_packed *b)
+__gnet_stats_copy_basic(struct gnet_stats_basic_sync *bstats,
+			struct gnet_stats_basic_sync __percpu *cpu,
+			struct gnet_stats_basic_sync *b,
+			bool running)
 {
-	unsigned int seq;
+	unsigned int start;
+	__u64 bytes = 0;
+	__u64 packets = 0;
+
+	WARN_ON_ONCE((cpu || running) && !in_task());
 
 	if (cpu) {
 		__gnet_stats_copy_basic_cpu(bstats, cpu);
@@ -150,27 +167,33 @@ __gnet_stats_copy_basic(net_seqlock_t *running,
 	}
 	do {
 		if (running)
-			seq = net_seq_begin(running);
-		bstats->bytes = b->bytes;
-		bstats->packets = b->packets;
-	} while (running && net_seq_retry(running, seq));
+			start = u64_stats_fetch_begin_irq(&b->syncp);
+		bytes = u64_stats_read(&b->bytes);
+		packets = u64_stats_read(&b->packets);
+	} while (running && u64_stats_fetch_retry_irq(&b->syncp, start));
+
+	_bstats_update(bstats, bytes, packets);
 }
 EXPORT_SYMBOL(__gnet_stats_copy_basic);
 
 static int
-___gnet_stats_copy_basic(net_seqlock_t *running,
-			 struct gnet_dump *d,
-			 struct gnet_stats_basic_cpu __percpu *cpu,
-			 struct gnet_stats_basic_packed *b,
-			 int type)
+___gnet_stats_copy_basic(struct gnet_dump *d,
+			 struct gnet_stats_basic_sync __percpu *cpu,
+			 struct gnet_stats_basic_sync *b,
+			 int type, bool running)
 {
-	struct gnet_stats_basic_packed bstats = {0};
+	struct gnet_stats_basic_sync bstats;
+	u64 bstats_bytes, bstats_packets;
 
-	__gnet_stats_copy_basic(running, &bstats, cpu, b);
+	gnet_stats_basic_sync_init(&bstats);
+	__gnet_stats_copy_basic(&bstats, cpu, b, running);
+
+	bstats_bytes = u64_stats_read(&bstats.bytes);
+	bstats_packets = u64_stats_read(&bstats.packets);
 
 	if (d->compat_tc_stats && type == TCA_STATS_BASIC) {
-		d->tc_stats.bytes = bstats.bytes;
-		d->tc_stats.packets = bstats.packets;
+		d->tc_stats.bytes = bstats_bytes;
+		d->tc_stats.packets = bstats_packets;
 	}
 
 	if (d->tail) {
@@ -178,24 +201,28 @@ ___gnet_stats_copy_basic(net_seqlock_t *running,
 		int res;
 
 		memset(&sb, 0, sizeof(sb));
-		sb.bytes = bstats.bytes;
-		sb.packets = bstats.packets;
+		sb.bytes = bstats_bytes;
+		sb.packets = bstats_packets;
 		res = gnet_stats_copy(d, type, &sb, sizeof(sb), TCA_STATS_PAD);
-		if (res < 0 || sb.packets == bstats.packets)
+		if (res < 0 || sb.packets == bstats_packets)
 			return res;
 		/* emit 64bit stats only if needed */
-		return gnet_stats_copy(d, TCA_STATS_PKT64, &bstats.packets,
-				       sizeof(bstats.packets), TCA_STATS_PAD);
+		return gnet_stats_copy(d, TCA_STATS_PKT64, &bstats_packets,
+				       sizeof(bstats_packets), TCA_STATS_PAD);
 	}
 	return 0;
 }
 
 /**
  * gnet_stats_copy_basic - copy basic statistics into statistic TLV
- * @running: seqcount_t pointer
  * @d: dumping handle
  * @cpu: copy statistic per cpu
  * @b: basic statistics
+ * @running: true if @b represents a running qdisc, thus @b's
+ *           internal values might change during basic reads.
+ *           Only used if @cpu is NULL
+ *
+ * Context: task; must not be run from IRQ or BH contexts
  *
  * Appends the basic statistics to the top level TLV created by
  * gnet_stats_start_copy().
@@ -204,22 +231,25 @@ ___gnet_stats_copy_basic(net_seqlock_t *running,
  * if the room in the socket buffer was not sufficient.
  */
 int
-gnet_stats_copy_basic(net_seqlock_t *running,
-		      struct gnet_dump *d,
-		      struct gnet_stats_basic_cpu __percpu *cpu,
-		      struct gnet_stats_basic_packed *b)
+gnet_stats_copy_basic(struct gnet_dump *d,
+		      struct gnet_stats_basic_sync __percpu *cpu,
+		      struct gnet_stats_basic_sync *b,
+		      bool running)
 {
-	return ___gnet_stats_copy_basic(running, d, cpu, b,
-					TCA_STATS_BASIC);
+	return ___gnet_stats_copy_basic(d, cpu, b, TCA_STATS_BASIC, running);
 }
 EXPORT_SYMBOL(gnet_stats_copy_basic);
 
 /**
  * gnet_stats_copy_basic_hw - copy basic hw statistics into statistic TLV
- * @running: seqcount_t pointer
  * @d: dumping handle
  * @cpu: copy statistic per cpu
  * @b: basic statistics
+ * @running: true if @b represents a running qdisc, thus @b's
+ *           internal values might change during basic reads.
+ *           Only used if @cpu is NULL
+ *
+ * Context: task; must not be run from IRQ or BH contexts
  *
  * Appends the basic statistics to the top level TLV created by
  * gnet_stats_start_copy().
@@ -228,13 +258,12 @@ EXPORT_SYMBOL(gnet_stats_copy_basic);
  * if the room in the socket buffer was not sufficient.
  */
 int
-gnet_stats_copy_basic_hw(net_seqlock_t *running,
-			 struct gnet_dump *d,
-			 struct gnet_stats_basic_cpu __percpu *cpu,
-			 struct gnet_stats_basic_packed *b)
+gnet_stats_copy_basic_hw(struct gnet_dump *d,
+			 struct gnet_stats_basic_sync __percpu *cpu,
+			 struct gnet_stats_basic_sync *b,
+			 bool running)
 {
-	return ___gnet_stats_copy_basic(running, d, cpu, b,
-					TCA_STATS_BASIC_HW);
+	return ___gnet_stats_copy_basic(d, cpu, b, TCA_STATS_BASIC_HW, running);
 }
 EXPORT_SYMBOL(gnet_stats_copy_basic_hw);
 
@@ -307,14 +336,14 @@ void __gnet_stats_copy_queue(struct gnet_stats_queue *qstats,
 	if (cpu) {
 		__gnet_stats_copy_queue_cpu(qstats, cpu);
 	} else {
-		qstats->qlen = q->qlen;
-		qstats->backlog = q->backlog;
-		qstats->drops = q->drops;
-		qstats->requeues = q->requeues;
-		qstats->overlimits = q->overlimits;
+		qstats->qlen += q->qlen;
+		qstats->backlog += q->backlog;
+		qstats->drops += q->drops;
+		qstats->requeues += q->requeues;
+		qstats->overlimits += q->overlimits;
 	}
 
-	qstats->qlen = qlen;
+	qstats->qlen += qlen;
 }
 EXPORT_SYMBOL(__gnet_stats_copy_queue);
 
diff --git a/net/netfilter/xt_RATEEST.c b/net/netfilter/xt_RATEEST.c
index 0d5c422f87452..8aec1b529364a 100644
--- a/net/netfilter/xt_RATEEST.c
+++ b/net/netfilter/xt_RATEEST.c
@@ -94,11 +94,11 @@ static unsigned int
 xt_rateest_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct xt_rateest_target_info *info = par->targinfo;
-	struct gnet_stats_basic_packed *stats = &info->est->bstats;
+	struct gnet_stats_basic_sync *stats = &info->est->bstats;
 
 	spin_lock_bh(&info->est->lock);
-	stats->bytes += skb->len;
-	stats->packets++;
+	u64_stats_add(&stats->bytes, skb->len);
+	u64_stats_inc(&stats->packets);
 	spin_unlock_bh(&info->est->lock);
 
 	return XT_CONTINUE;
@@ -143,6 +143,7 @@ static int xt_rateest_tg_checkentry(const struct xt_tgchk_param *par)
 	if (!est)
 		goto err1;
 
+	gnet_stats_basic_sync_init(&est->bstats);
 	strlcpy(est->name, info->name, sizeof(est->name));
 	spin_lock_init(&est->lock);
 	est->refcnt		= 1;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 7dd3a2dc5fa40..4133b8ea5a57a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -480,16 +480,18 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 		atomic_set(&p->tcfa_bindcnt, 1);
 
 	if (cpustats) {
-		p->cpu_bstats = netdev_alloc_pcpu_stats(struct gnet_stats_basic_cpu);
+		p->cpu_bstats = netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
 		if (!p->cpu_bstats)
 			goto err1;
-		p->cpu_bstats_hw = netdev_alloc_pcpu_stats(struct gnet_stats_basic_cpu);
+		p->cpu_bstats_hw = netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
 		if (!p->cpu_bstats_hw)
 			goto err2;
 		p->cpu_qstats = alloc_percpu(struct gnet_stats_queue);
 		if (!p->cpu_qstats)
 			goto err3;
 	}
+	gnet_stats_basic_sync_init(&p->tcfa_bstats);
+	gnet_stats_basic_sync_init(&p->tcfa_bstats_hw);
 	spin_lock_init(&p->tcfa_lock);
 	p->tcfa_index = index;
 	p->tcfa_tm.install = jiffies;
@@ -499,7 +501,7 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 	if (est) {
 		err = gen_new_estimator(&p->tcfa_bstats, p->cpu_bstats,
 					&p->tcfa_rate_est,
-					&p->tcfa_lock, NULL, est);
+					&p->tcfa_lock, false, est);
 		if (err)
 			goto err4;
 	}
@@ -1126,13 +1128,13 @@ void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
 			     u64 drops, bool hw)
 {
 	if (a->cpu_bstats) {
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
+		_bstats_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
 
 		this_cpu_ptr(a->cpu_qstats)->drops += drops;
 
 		if (hw)
-			_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-					   bytes, packets);
+			_bstats_update(this_cpu_ptr(a->cpu_bstats_hw),
+				       bytes, packets);
 		return;
 	}
 
@@ -1171,9 +1173,10 @@ int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
 	if (err < 0)
 		goto errout;
 
-	if (gnet_stats_copy_basic(NULL, &d, p->cpu_bstats, &p->tcfa_bstats) < 0 ||
-	    gnet_stats_copy_basic_hw(NULL, &d, p->cpu_bstats_hw,
-				     &p->tcfa_bstats_hw) < 0 ||
+	if (gnet_stats_copy_basic(&d, p->cpu_bstats,
+				  &p->tcfa_bstats, false ) < 0 ||
+	    gnet_stats_copy_basic_hw(&d, p->cpu_bstats_hw,
+				     &p->tcfa_bstats_hw, false) < 0 ||
 	    gnet_stats_copy_rate_est(&d, &p->tcfa_rate_est) < 0 ||
 	    gnet_stats_copy_queue(&d, p->cpu_qstats,
 				  &p->tcfa_qstats,
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 5c36013339e11..f2bf896331a59 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -41,7 +41,7 @@ static int tcf_bpf_act(struct sk_buff *skb, const struct tc_action *act,
 	int action, filter_res;
 
 	tcf_lastuse_update(&prog->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(prog->common.cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(prog->common.cpu_bstats), skb);
 
 	filter = rcu_dereference(prog->filter);
 	if (at_ingress) {
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 7064a365a1a98..b757f90a2d589 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -718,7 +718,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 	u8 *tlv_data;
 	u16 metalen;
 
-	bstats_cpu_update(this_cpu_ptr(ife->common.cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(ife->common.cpu_bstats), skb);
 	tcf_lastuse_update(&ife->tcf_tm);
 
 	if (skb_at_tc_ingress(skb))
@@ -806,7 +806,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 			exceed_mtu = true;
 	}
 
-	bstats_cpu_update(this_cpu_ptr(ife->common.cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(ife->common.cpu_bstats), skb);
 	tcf_lastuse_update(&ife->tcf_tm);
 
 	if (!metalen) {		/* no metadata to send */
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index e4529b428cf44..8faa4c58305e3 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -59,7 +59,7 @@ static int tcf_mpls_act(struct sk_buff *skb, const struct tc_action *a,
 	int ret, mac_len;
 
 	tcf_lastuse_update(&m->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(m->common.cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(m->common.cpu_bstats), skb);
 
 	/* Ensure 'data' points at mac_header prior calling mpls manipulating
 	 * functions.
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 832157a840fc3..9e77ba8401e53 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -125,7 +125,7 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 					    police->common.cpu_bstats,
 					    &police->tcf_rate_est,
 					    &police->tcf_lock,
-					    NULL, est);
+					    false, est);
 		if (err)
 			goto failure;
 	} else if (tb[TCA_POLICE_AVRATE] &&
@@ -248,7 +248,7 @@ static int tcf_police_act(struct sk_buff *skb, const struct tc_action *a,
 	int ret;
 
 	tcf_lastuse_update(&police->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(police->common.cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(police->common.cpu_bstats), skb);
 
 	ret = READ_ONCE(police->tcf_action);
 	p = rcu_dereference_bh(police->params);
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 230501eb9e069..ce859b0e0deb9 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -163,7 +163,7 @@ static int tcf_sample_act(struct sk_buff *skb, const struct tc_action *a,
 	int retval;
 
 	tcf_lastuse_update(&s->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(s->common.cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(s->common.cpu_bstats), skb);
 	retval = READ_ONCE(s->tcf_action);
 
 	psample_group = rcu_dereference_bh(s->psample_group);
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index cbbe1861d3a20..e617ab4505ca4 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -36,7 +36,8 @@ static int tcf_simp_act(struct sk_buff *skb, const struct tc_action *a,
 	 * then it would look like "hello_3" (without quotes)
 	 */
 	pr_info("simple: %s_%llu\n",
-	       (char *)d->tcfd_defdata, d->tcf_bstats.packets);
+		(char *)d->tcfd_defdata,
+		u64_stats_read(&d->tcf_bstats.packets));
 	spin_unlock(&d->tcf_lock);
 	return d->tcf_action;
 }
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 6054185383474..d30ecbfc8f846 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -31,7 +31,7 @@ static int tcf_skbedit_act(struct sk_buff *skb, const struct tc_action *a,
 	int action;
 
 	tcf_lastuse_update(&d->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(d->common.cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(d->common.cpu_bstats), skb);
 
 	params = rcu_dereference_bh(d->params);
 	action = READ_ONCE(d->tcf_action);
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index ecb9ee6660954..9b6b52c5e24ec 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -31,7 +31,7 @@ static int tcf_skbmod_act(struct sk_buff *skb, const struct tc_action *a,
 	u64 flags;
 
 	tcf_lastuse_update(&d->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(d->common.cpu_bstats), skb);
+	bstats_update(this_cpu_ptr(d->common.cpu_bstats), skb);
 
 	action = READ_ONCE(d->tcf_action);
 	if (unlikely(action == TC_ACT_SHOT))
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 487b2b905a812..ad0bdefb32056 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -884,7 +884,7 @@ static void qdisc_offload_graft_root(struct net_device *dev,
 static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 			 u32 portid, u32 seq, u16 flags, int event)
 {
-	struct gnet_stats_basic_cpu __percpu *cpu_bstats = NULL;
+	struct gnet_stats_basic_sync __percpu *cpu_bstats = NULL;
 	struct gnet_stats_queue __percpu *cpu_qstats = NULL;
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
@@ -942,8 +942,7 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 		cpu_qstats = q->cpu_qstats;
 	}
 
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(q),
-				  &d, cpu_bstats, &q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(&d, cpu_bstats, &q->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(&d, &q->rate_est) < 0 ||
 	    gnet_stats_copy_queue(&d, cpu_qstats, &q->qstats, qlen) < 0)
 		goto nla_put_failure;
@@ -1264,26 +1263,17 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		rcu_assign_pointer(sch->stab, stab);
 	}
 	if (tca[TCA_RATE]) {
-		net_seqlock_t *running;
-
 		err = -EOPNOTSUPP;
 		if (sch->flags & TCQ_F_MQROOT) {
 			NL_SET_ERR_MSG(extack, "Cannot attach rate estimator to a multi-queue root qdisc");
 			goto err_out4;
 		}
 
-		if (sch->parent != TC_H_ROOT &&
-		    !(sch->flags & TCQ_F_INGRESS) &&
-		    (!p || !(p->flags & TCQ_F_MQROOT)))
-			running = qdisc_root_sleeping_running(sch);
-		else
-			running = &sch->running;
-
 		err = gen_new_estimator(&sch->bstats,
 					sch->cpu_bstats,
 					&sch->rate_est,
 					NULL,
-					running,
+					true,
 					tca[TCA_RATE]);
 		if (err) {
 			NL_SET_ERR_MSG(extack, "Failed to generate new estimator");
@@ -1359,7 +1349,7 @@ static int qdisc_change(struct Qdisc *sch, struct nlattr **tca,
 				      sch->cpu_bstats,
 				      &sch->rate_est,
 				      NULL,
-				      qdisc_root_sleeping_running(sch),
+				      true,
 				      tca[TCA_RATE]);
 	}
 out:
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
index 7d8518176b45a..4c8e994cf0a53 100644
--- a/net/sched/sch_atm.c
+++ b/net/sched/sch_atm.c
@@ -52,7 +52,7 @@ struct atm_flow_data {
 	struct atm_qdisc_data	*parent;	/* parent qdisc */
 	struct socket		*sock;		/* for closing */
 	int			ref;		/* reference count */
-	struct gnet_stats_basic_packed	bstats;
+	struct gnet_stats_basic_sync	bstats;
 	struct gnet_stats_queue	qstats;
 	struct list_head	list;
 	struct atm_flow_data	*excess;	/* flow for excess traffic;
@@ -548,6 +548,7 @@ static int atm_tc_init(struct Qdisc *sch, struct nlattr *opt,
 	pr_debug("atm_tc_init(sch %p,[qdisc %p],opt %p)\n", sch, p, opt);
 	INIT_LIST_HEAD(&p->flows);
 	INIT_LIST_HEAD(&p->link.list);
+	gnet_stats_basic_sync_init(&p->link.bstats);
 	list_add(&p->link.list, &p->flows);
 	p->link.q = qdisc_create_dflt(sch->dev_queue,
 				      &pfifo_qdisc_ops, sch->handle, extack);
@@ -652,8 +653,7 @@ atm_tc_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 {
 	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
 
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &flow->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &flow->bstats, true) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &flow->qstats, flow->q->q.qlen) < 0)
 		return -1;
 
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
index e0da15530f0e9..02d9f0dfe3564 100644
--- a/net/sched/sch_cbq.c
+++ b/net/sched/sch_cbq.c
@@ -116,7 +116,7 @@ struct cbq_class {
 	long			avgidle;
 	long			deficit;	/* Saved deficit for WRR */
 	psched_time_t		penalized;
-	struct gnet_stats_basic_packed bstats;
+	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
 	struct net_rate_estimator __rcu *rate_est;
 	struct tc_cbq_xstats	xstats;
@@ -565,8 +565,7 @@ cbq_update(struct cbq_sched_data *q)
 		long avgidle = cl->avgidle;
 		long idle;
 
-		cl->bstats.packets++;
-		cl->bstats.bytes += len;
+		_bstats_update(&cl->bstats, len, 1);
 
 		/*
 		 * (now - last) is total time between packet right edges.
@@ -1384,8 +1383,7 @@ cbq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 	if (cl->undertime != PSCHED_PASTPERFECT)
 		cl->xstats.undertime = cl->undertime - q->now;
 
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &cl->qstats, qlen) < 0)
 		return -1;
@@ -1519,7 +1517,7 @@ cbq_change_class(struct Qdisc *sch, u32 classid, u32 parentid, struct nlattr **t
 			err = gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
 						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    true,
 						    tca[TCA_RATE]);
 			if (err) {
 				NL_SET_ERR_MSG(extack, "Failed to replace specified rate estimator");
@@ -1611,6 +1609,7 @@ cbq_change_class(struct Qdisc *sch, u32 classid, u32 parentid, struct nlattr **t
 	if (cl == NULL)
 		goto failure;
 
+	gnet_stats_basic_sync_init(&cl->bstats);
 	err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
 	if (err) {
 		kfree(cl);
@@ -1619,9 +1618,7 @@ cbq_change_class(struct Qdisc *sch, u32 classid, u32 parentid, struct nlattr **t
 
 	if (tca[TCA_RATE]) {
 		err = gen_new_estimator(&cl->bstats, NULL, &cl->rate_est,
-					NULL,
-					qdisc_root_sleeping_running(sch),
-					tca[TCA_RATE]);
+					NULL, true, tca[TCA_RATE]);
 		if (err) {
 			NL_SET_ERR_MSG(extack, "Couldn't create new estimator");
 			tcf_block_put(cl->block);
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 642cd179b7a75..18e4f7a0b2912 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -19,7 +19,7 @@ struct drr_class {
 	struct Qdisc_class_common	common;
 	unsigned int			filter_cnt;
 
-	struct gnet_stats_basic_packed		bstats;
+	struct gnet_stats_basic_sync		bstats;
 	struct gnet_stats_queue		qstats;
 	struct net_rate_estimator __rcu *rate_est;
 	struct list_head		alist;
@@ -85,8 +85,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (tca[TCA_RATE]) {
 			err = gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
-						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    NULL, true,
 						    tca[TCA_RATE]);
 			if (err) {
 				NL_SET_ERR_MSG(extack, "Failed to replace estimator");
@@ -106,6 +105,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (cl == NULL)
 		return -ENOBUFS;
 
+	gnet_stats_basic_sync_init(&cl->bstats);
 	cl->common.classid = classid;
 	cl->quantum	   = quantum;
 	cl->qdisc	   = qdisc_create_dflt(sch->dev_queue,
@@ -118,9 +118,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (tca[TCA_RATE]) {
 		err = gen_replace_estimator(&cl->bstats, NULL, &cl->rate_est,
-					    NULL,
-					    qdisc_root_sleeping_running(sch),
-					    tca[TCA_RATE]);
+					    NULL, true, tca[TCA_RATE]);
 		if (err) {
 			NL_SET_ERR_MSG(extack, "Failed to replace estimator");
 			qdisc_put(cl->qdisc);
@@ -267,8 +265,7 @@ static int drr_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 	if (qlen)
 		xstats.deficit = cl->deficit;
 
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    gnet_stats_copy_queue(d, cl_q->cpu_qstats, &cl_q->qstats, qlen) < 0)
 		return -1;
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 1f857ffd1ac23..52b9b0dcf88c6 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -41,7 +41,7 @@ struct ets_class {
 	struct Qdisc *qdisc;
 	u32 quantum;
 	u32 deficit;
-	struct gnet_stats_basic_packed bstats;
+	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
 };
 
@@ -325,8 +325,7 @@ static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg,
 	struct ets_class *cl = ets_class_from_arg(sch, arg);
 	struct Qdisc *cl_q = cl->qdisc;
 
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl_q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl_q->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, cl_q) < 0)
 		return -1;
 
@@ -662,6 +661,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	q->nbands = nbands;
 	for (i = nstrict; i < q->nstrict; i++) {
 		INIT_LIST_HEAD(&q->classes[i].alist);
+		gnet_stats_basic_sync_init(&q->classes[i].bstats);
 		if (q->classes[i].qdisc->q.qlen) {
 			list_add_tail(&q->classes[i].alist, &q->active);
 			q->classes[i].deficit = quanta[i];
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 155786c376205..f4cf675943bb1 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -304,8 +304,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 
 /*
  * Transmit possibly several skbs, and handle the return status as
- * required. Owning running seqcount bit guarantees that
- * only one CPU can execute this function.
+ * required. Owning qdisc running bit guarantees that only one CPU
+ * can execute this function.
  *
  * Returns to the caller:
  *				false  - hardware queue frozen backoff
@@ -606,11 +606,6 @@ struct Qdisc noop_qdisc = {
 	.ops		=	&noop_qdisc_ops,
 	.q.lock		=	__SPIN_LOCK_UNLOCKED(noop_qdisc.q.lock),
 	.dev_queue	=	&noop_netdev_queue,
-#ifdef CONFIG_PREEMPT_RT
-	.running	=	__SEQLOCK_UNLOCKED(noop_qdisc.running),
-#else
-	.running	=	SEQCNT_ZERO(noop_qdisc.running),
-#endif
 	.busylock	=	__SPIN_LOCK_UNLOCKED(noop_qdisc.busylock),
 	.gso_skb = {
 		.next = (struct sk_buff *)&noop_qdisc.gso_skb,
@@ -871,7 +866,6 @@ struct Qdisc_ops pfifo_fast_ops __read_mostly = {
 EXPORT_SYMBOL(pfifo_fast_ops);
 
 static struct lock_class_key qdisc_tx_busylock;
-static struct lock_class_key qdisc_running_key;
 
 struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 			  const struct Qdisc_ops *ops,
@@ -896,11 +890,12 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	__skb_queue_head_init(&sch->gso_skb);
 	__skb_queue_head_init(&sch->skb_bad_txq);
 	qdisc_skb_head_init(&sch->q);
+	gnet_stats_basic_sync_init(&sch->bstats);
 	spin_lock_init(&sch->q.lock);
 
 	if (ops->static_flags & TCQ_F_CPUSTATS) {
 		sch->cpu_bstats =
-			netdev_alloc_pcpu_stats(struct gnet_stats_basic_cpu);
+			netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
 		if (!sch->cpu_bstats)
 			goto errout1;
 
@@ -920,16 +915,6 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	lockdep_set_class(&sch->seqlock,
 			  dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
 
-#ifdef CONFIG_PREEMPT_RT
-	seqlock_init(&sch->running);
-	lockdep_set_class(&sch->running.lock,
-			  dev->qdisc_running_key ?: &qdisc_running_key);
-#else
-	seqcount_init(&sch->running);
-	lockdep_set_class(&sch->running,
-			  dev->qdisc_running_key ?: &qdisc_running_key);
-#endif
-
 	sch->ops = ops;
 	sch->flags = ops->static_flags;
 	sch->enqueue = ops->enqueue;
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 621dc6afde8f3..72de08ef8335e 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -353,6 +353,7 @@ static int gred_offload_dump_stats(struct Qdisc *sch)
 {
 	struct gred_sched *table = qdisc_priv(sch);
 	struct tc_gred_qopt_offload *hw_stats;
+	u64 bytes = 0, packets = 0;
 	unsigned int i;
 	int ret;
 
@@ -364,9 +365,11 @@ static int gred_offload_dump_stats(struct Qdisc *sch)
 	hw_stats->handle = sch->handle;
 	hw_stats->parent = sch->parent;
 
-	for (i = 0; i < MAX_DPs; i++)
+	for (i = 0; i < MAX_DPs; i++) {
+		gnet_stats_basic_sync_init(&hw_stats->stats.bstats[i]);
 		if (table->tab[i])
 			hw_stats->stats.xstats[i] = &table->tab[i]->stats;
+	}
 
 	ret = qdisc_offload_dump_helper(sch, TC_SETUP_QDISC_GRED, hw_stats);
 	/* Even if driver returns failure adjust the stats - in case offload
@@ -375,19 +378,19 @@ static int gred_offload_dump_stats(struct Qdisc *sch)
 	for (i = 0; i < MAX_DPs; i++) {
 		if (!table->tab[i])
 			continue;
-		table->tab[i]->packetsin += hw_stats->stats.bstats[i].packets;
-		table->tab[i]->bytesin += hw_stats->stats.bstats[i].bytes;
+		table->tab[i]->packetsin += u64_stats_read(&hw_stats->stats.bstats[i].packets);
+		table->tab[i]->bytesin += u64_stats_read(&hw_stats->stats.bstats[i].bytes);
 		table->tab[i]->backlog += hw_stats->stats.qstats[i].backlog;
 
-		_bstats_update(&sch->bstats,
-			       hw_stats->stats.bstats[i].bytes,
-			       hw_stats->stats.bstats[i].packets);
+		bytes += u64_stats_read(&hw_stats->stats.bstats[i].bytes);
+		packets += u64_stats_read(&hw_stats->stats.bstats[i].packets);
 		sch->qstats.qlen += hw_stats->stats.qstats[i].qlen;
 		sch->qstats.backlog += hw_stats->stats.qstats[i].backlog;
 		sch->qstats.drops += hw_stats->stats.qstats[i].drops;
 		sch->qstats.requeues += hw_stats->stats.qstats[i].requeues;
 		sch->qstats.overlimits += hw_stats->stats.qstats[i].overlimits;
 	}
+	_bstats_update(&sch->bstats, bytes, packets);
 
 	kfree(hw_stats);
 	return ret;
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index b7ac30cca035d..d3979a6000e7d 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -111,7 +111,7 @@ enum hfsc_class_flags {
 struct hfsc_class {
 	struct Qdisc_class_common cl_common;
 
-	struct gnet_stats_basic_packed bstats;
+	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
 	struct net_rate_estimator __rcu *rate_est;
 	struct tcf_proto __rcu *filter_list; /* filter list */
@@ -965,7 +965,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			err = gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
 						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    true,
 						    tca[TCA_RATE]);
 			if (err)
 				return err;
@@ -1033,9 +1033,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (tca[TCA_RATE]) {
 		err = gen_new_estimator(&cl->bstats, NULL, &cl->rate_est,
-					NULL,
-					qdisc_root_sleeping_running(sch),
-					tca[TCA_RATE]);
+					NULL, true, tca[TCA_RATE]);
 		if (err) {
 			tcf_block_put(cl->block);
 			kfree(cl);
@@ -1328,7 +1326,7 @@ hfsc_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 	xstats.work    = cl->cl_total;
 	xstats.rtwork  = cl->cl_cumul;
 
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch), d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &cl->qstats, qlen) < 0)
 		return -1;
@@ -1406,6 +1404,7 @@ hfsc_init_qdisc(struct Qdisc *sch, struct nlattr *opt,
 	if (err)
 		return err;
 
+	gnet_stats_basic_sync_init(&q->root.bstats);
 	q->root.cl_common.classid = sch->handle;
 	q->root.sched   = q;
 	q->root.qdisc = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 5067a6e5d4fde..661d5f7faea8d 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -113,8 +113,8 @@ struct htb_class {
 	/*
 	 * Written often fields
 	 */
-	struct gnet_stats_basic_packed bstats;
-	struct gnet_stats_basic_packed bstats_bias;
+	struct gnet_stats_basic_sync bstats;
+	struct gnet_stats_basic_sync bstats_bias;
 	struct tc_htb_xstats	xstats;	/* our special stats */
 
 	/* token bucket parameters */
@@ -1308,10 +1308,11 @@ static int htb_dump_class(struct Qdisc *sch, unsigned long arg,
 static void htb_offload_aggregate_stats(struct htb_sched *q,
 					struct htb_class *cl)
 {
+	u64 bytes = 0, packets = 0;
 	struct htb_class *c;
 	unsigned int i;
 
-	memset(&cl->bstats, 0, sizeof(cl->bstats));
+	gnet_stats_basic_sync_init(&cl->bstats);
 
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(c, &q->clhash.hash[i], common.hnode) {
@@ -1323,14 +1324,13 @@ static void htb_offload_aggregate_stats(struct htb_sched *q,
 			if (p != cl)
 				continue;
 
-			cl->bstats.bytes += c->bstats_bias.bytes;
-			cl->bstats.packets += c->bstats_bias.packets;
-			if (c->level == 0) {
-				cl->bstats.bytes += c->leaf.q->bstats.bytes;
-				cl->bstats.packets += c->leaf.q->bstats.packets;
-			}
+			bstats_read_add(&c->bstats_bias, &bytes, &packets);
+			if (c->level == 0)
+				bstats_read_add(&c->leaf.q->bstats,
+						&bytes, &packets);
 		}
 	}
+	_bstats_update(&cl->bstats, bytes, packets);
 }
 
 static int
@@ -1354,19 +1354,21 @@ htb_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
 
 	if (q->offload) {
 		if (!cl->level) {
+			u64 bytes = 0, packets = 0;
+
 			if (cl->leaf.q)
 				cl->bstats = cl->leaf.q->bstats;
 			else
-				memset(&cl->bstats, 0, sizeof(cl->bstats));
-			cl->bstats.bytes += cl->bstats_bias.bytes;
-			cl->bstats.packets += cl->bstats_bias.packets;
+				gnet_stats_basic_sync_init(&cl->bstats);
+
+			bstats_read_add(&cl->bstats_bias, &bytes, &packets);
+			_bstats_update(&cl->bstats, bytes, packets);
 		} else {
 			htb_offload_aggregate_stats(q, cl);
 		}
 	}
 
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &qs, qlen) < 0)
 		return -1;
@@ -1578,8 +1580,9 @@ static int htb_destroy_class_offload(struct Qdisc *sch, struct htb_class *cl,
 		WARN_ON(old != q);
 
 	if (cl->parent) {
-		cl->parent->bstats_bias.bytes += q->bstats.bytes;
-		cl->parent->bstats_bias.packets += q->bstats.packets;
+		_bstats_update(&cl->parent->bstats_bias,
+			       u64_stats_read(&q->bstats.bytes),
+			       u64_stats_read(&q->bstats.packets));
 	}
 
 	offload_opt = (struct tc_htb_qopt_offload) {
@@ -1849,6 +1852,9 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 		if (!cl)
 			goto failure;
 
+		gnet_stats_basic_sync_init(&cl->bstats);
+		gnet_stats_basic_sync_init(&cl->bstats_bias);
+
 		err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
 		if (err) {
 			kfree(cl);
@@ -1858,7 +1864,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 			err = gen_new_estimator(&cl->bstats, NULL,
 						&cl->rate_est,
 						NULL,
-						qdisc_root_sleeping_running(sch),
+						true,
 						tca[TCA_RATE] ? : &est.nla);
 			if (err)
 				goto err_block_put;
@@ -1922,8 +1928,9 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 				htb_graft_helper(dev_queue, old_q);
 				goto err_kill_estimator;
 			}
-			parent->bstats_bias.bytes += old_q->bstats.bytes;
-			parent->bstats_bias.packets += old_q->bstats.packets;
+			_bstats_update(&parent->bstats_bias,
+				       u64_stats_read(&old_q->bstats.bytes),
+				       u64_stats_read(&old_q->bstats.packets));
 			qdisc_put(old_q);
 		}
 		new_q = qdisc_create_dflt(dev_queue, &pfifo_qdisc_ops,
@@ -1983,7 +1990,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 			err = gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
 						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    true,
 						    tca[TCA_RATE]);
 			if (err)
 				return err;
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index e79f1afe0cfd6..94bc53475a0b6 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -133,7 +133,7 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	__u32 qlen = 0;
 
 	sch->q.qlen = 0;
-	memset(&sch->bstats, 0, sizeof(sch->bstats));
+	gnet_stats_basic_sync_init(&sch->bstats);
 	memset(&sch->qstats, 0, sizeof(sch->qstats));
 
 	/* MQ supports lockless qdiscs. However, statistics accounting needs
@@ -145,26 +145,14 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 		qdisc = netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
 		spin_lock_bh(qdisc_lock(qdisc));
 
-		if (qdisc_is_percpu_stats(qdisc)) {
-			qlen = qdisc_qlen_sum(qdisc);
-			__gnet_stats_copy_basic(NULL, &sch->bstats,
-						qdisc->cpu_bstats,
-						&qdisc->bstats);
-			__gnet_stats_copy_queue(&sch->qstats,
-						qdisc->cpu_qstats,
-						&qdisc->qstats, qlen);
-			sch->q.qlen		+= qlen;
-		} else {
-			sch->q.qlen		+= qdisc->q.qlen;
-			sch->bstats.bytes	+= qdisc->bstats.bytes;
-			sch->bstats.packets	+= qdisc->bstats.packets;
-			sch->qstats.qlen	+= qdisc->qstats.qlen;
-			sch->qstats.backlog	+= qdisc->qstats.backlog;
-			sch->qstats.drops	+= qdisc->qstats.drops;
-			sch->qstats.requeues	+= qdisc->qstats.requeues;
-			sch->qstats.overlimits	+= qdisc->qstats.overlimits;
-		}
+		qlen = qdisc_qlen_sum(qdisc);
 
+		__gnet_stats_copy_basic(&sch->bstats, qdisc->cpu_bstats,
+					&qdisc->bstats, false);
+		__gnet_stats_copy_queue(&sch->qstats,
+					qdisc->cpu_qstats,
+					&qdisc->qstats, qlen);
+		sch->q.qlen		+= qlen;
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
 
@@ -246,8 +234,7 @@ static int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
 	sch = dev_queue->qdisc_sleeping;
-	if (gnet_stats_copy_basic(&sch->running, d, sch->cpu_bstats,
-				  &sch->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, sch->cpu_bstats, &sch->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, sch) < 0)
 		return -1;
 	return 0;
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 8766ab5b87880..c9dc0cec12b95 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -390,7 +390,7 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	unsigned int ntx, tc;
 
 	sch->q.qlen = 0;
-	memset(&sch->bstats, 0, sizeof(sch->bstats));
+	gnet_stats_basic_sync_init(&sch->bstats);
 	memset(&sch->qstats, 0, sizeof(sch->qstats));
 
 	/* MQ supports lockless qdiscs. However, statistics accounting needs
@@ -399,28 +399,17 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	 * qdisc totals are added at end.
 	 */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
+		u32 qlen = qdisc_qlen_sum(qdisc);
+
 		qdisc = netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
 		spin_lock_bh(qdisc_lock(qdisc));
 
-		if (qdisc_is_percpu_stats(qdisc)) {
-			__u32 qlen = qdisc_qlen_sum(qdisc);
-
-			__gnet_stats_copy_basic(NULL, &sch->bstats,
-						qdisc->cpu_bstats,
-						&qdisc->bstats);
-			__gnet_stats_copy_queue(&sch->qstats,
-						qdisc->cpu_qstats,
-						&qdisc->qstats, qlen);
-			sch->q.qlen		+= qlen;
-		} else {
-			sch->q.qlen		+= qdisc->q.qlen;
-			sch->bstats.bytes	+= qdisc->bstats.bytes;
-			sch->bstats.packets	+= qdisc->bstats.packets;
-			sch->qstats.backlog	+= qdisc->qstats.backlog;
-			sch->qstats.drops	+= qdisc->qstats.drops;
-			sch->qstats.requeues	+= qdisc->qstats.requeues;
-			sch->qstats.overlimits	+= qdisc->qstats.overlimits;
-		}
+		__gnet_stats_copy_basic(&sch->bstats, qdisc->cpu_bstats,
+					&qdisc->bstats, false);
+		__gnet_stats_copy_queue(&sch->qstats,
+					qdisc->cpu_qstats,
+					&qdisc->qstats, qlen);
+		sch->q.qlen		+= qlen;
 
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
@@ -514,10 +503,11 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 		int i;
 		__u32 qlen = 0;
 		struct gnet_stats_queue qstats = {0};
-		struct gnet_stats_basic_packed bstats = {0};
+		struct gnet_stats_basic_sync bstats;
 		struct net_device *dev = qdisc_dev(sch);
 		struct netdev_tc_txq tc = dev->tc_to_txq[cl & TC_BITMASK];
 
+		gnet_stats_basic_sync_init(&bstats);
 		/* Drop lock here it will be reclaimed before touching
 		 * statistics this is required because the d->lock we
 		 * hold here is the look on dev_queue->qdisc_sleeping
@@ -529,20 +519,14 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 		for (i = tc.offset; i < tc.offset + tc.count; i++) {
 			struct netdev_queue *q = netdev_get_tx_queue(dev, i);
 			struct Qdisc *qdisc = rtnl_dereference(q->qdisc);
-			struct gnet_stats_basic_cpu __percpu *cpu_bstats = NULL;
-			struct gnet_stats_queue __percpu *cpu_qstats = NULL;
 
 			spin_lock_bh(qdisc_lock(qdisc));
-			if (qdisc_is_percpu_stats(qdisc)) {
-				cpu_bstats = qdisc->cpu_bstats;
-				cpu_qstats = qdisc->cpu_qstats;
-			}
 
 			qlen = qdisc_qlen_sum(qdisc);
-			__gnet_stats_copy_basic(NULL, &sch->bstats,
-						cpu_bstats, &qdisc->bstats);
-			__gnet_stats_copy_queue(&sch->qstats,
-						cpu_qstats,
+			__gnet_stats_copy_basic(&bstats, qdisc->cpu_bstats,
+						&qdisc->bstats, false);
+			__gnet_stats_copy_queue(&qstats,
+						qdisc->cpu_qstats,
 						&qdisc->qstats,
 						qlen);
 			spin_unlock_bh(qdisc_lock(qdisc));
@@ -551,15 +535,15 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 		/* Reclaim root sleeping lock before completing stats */
 		if (d->lock)
 			spin_lock_bh(d->lock);
-		if (gnet_stats_copy_basic(NULL, d, NULL, &bstats) < 0 ||
+		if (gnet_stats_copy_basic(d, NULL, &bstats, false) < 0 ||
 		    gnet_stats_copy_queue(d, NULL, &qstats, qlen) < 0)
 			return -1;
 	} else {
 		struct netdev_queue *dev_queue = mqprio_queue_get(sch, cl);
 
 		sch = dev_queue->qdisc_sleeping;
-		if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch), d,
-					  sch->cpu_bstats, &sch->bstats) < 0 ||
+		if (gnet_stats_copy_basic(d, sch->cpu_bstats,
+					  &sch->bstats, true) < 0 ||
 		    qdisc_qstats_copy(d, sch) < 0)
 			return -1;
 	}
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index e282e7382117a..cd8ab90c4765d 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -338,8 +338,7 @@ static int multiq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	struct Qdisc *cl_q;
 
 	cl_q = q->queues[cl - 1];
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, cl_q->cpu_bstats, &cl_q->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, cl_q) < 0)
 		return -1;
 
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 03fdf31ccb6af..3b8d7197c06bf 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -361,8 +361,8 @@ static int prio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	struct Qdisc *cl_q;
 
 	cl_q = q->queues[cl - 1];
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, cl_q->cpu_bstats,
+				  &cl_q->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, cl_q) < 0)
 		return -1;
 
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 58a9d42b52b8f..0b7f9ba28deb0 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -131,7 +131,7 @@ struct qfq_class {
 
 	unsigned int filter_cnt;
 
-	struct gnet_stats_basic_packed bstats;
+	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
 	struct net_rate_estimator __rcu *rate_est;
 	struct Qdisc *qdisc;
@@ -451,7 +451,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			err = gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
 						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    true,
 						    tca[TCA_RATE]);
 			if (err)
 				return err;
@@ -465,6 +465,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (cl == NULL)
 		return -ENOBUFS;
 
+	gnet_stats_basic_sync_init(&cl->bstats);
 	cl->common.classid = classid;
 	cl->deficit = lmax;
 
@@ -477,7 +478,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		err = gen_new_estimator(&cl->bstats, NULL,
 					&cl->rate_est,
 					NULL,
-					qdisc_root_sleeping_running(sch),
+					true,
 					tca[TCA_RATE]);
 		if (err)
 			goto destroy_class;
@@ -639,8 +640,7 @@ static int qfq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 	xstats.weight = cl->agg->class_weight;
 	xstats.lmax = cl->agg->lmax;
 
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    qdisc_qstats_copy(d, cl->qdisc) < 0)
 		return -1;
@@ -1234,8 +1234,7 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	cl->bstats.bytes += len;
-	cl->bstats.packets += gso_segs;
+	_bstats_update(&cl->bstats, len, gso_segs);
 	sch->qstats.backlog += len;
 	++sch->q.qlen;
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1ab2fc933a214..aa08ea701cb7a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1973,7 +1973,7 @@ static int taprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
 
 	sch = dev_queue->qdisc_sleeping;
-	if (gnet_stats_copy_basic(&sch->running, d, NULL, &sch->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &sch->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, sch) < 0)
 		return -1;
 	return 0;
