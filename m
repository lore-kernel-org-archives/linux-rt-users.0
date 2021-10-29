Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8565AC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F93E61167
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhJ2Igp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Oct 2021 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhJ2Igp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Oct 2021 04:36:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C04C061570;
        Fri, 29 Oct 2021 01:34:16 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:34:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635496455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KrDZ+Aps+xKHo4ErpsPNgTu4aBSQbYROD4aTTmD6L3Y=;
        b=u4h5Nc6wM/YVwMHWvvr7kLmwTWI0jI7wKT2Ug8SMFKNCOBMOkMsr3Y9CGeRCTeSStlvM3Z
        uMbnCxg8bCpeNxIlFFiKWqtt3qdu2pG19EPzNiOS4/RfJkcFQ/bXBs6jNsRNdEnFTif/uv
        iaKL8/2JD9lbpSGtAWbze4jU7xSiFcrUUs2AIvqaSZk+U7Y0CgG+P06DC6isWJDoYNcHhd
        D0EeOgzmYV3I/D4zIu7qw9FRpC09jALaSKqU5y3ki+4QonfHdTDBZITr/7+ZmTwKJGanTP
        wBFkeR4NrXG0EoxXkw5KTBGW9dyEmLW2sh/4TbTEJOBZqdyu0fbB4uh7Bij0lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635496455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KrDZ+Aps+xKHo4ErpsPNgTu4aBSQbYROD4aTTmD6L3Y=;
        b=U6eAfQS/XFRvZ/RgtIDM+vevdX2Xm4Kj8NVHlVkphEnVdBFfAdy7gO3JXcFcPmYuRhzfAc
        3mOeYCGJ4mse2CAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rc7-rt15
Message-ID: <20211029083414.x5ap5jrwfexfgo7c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rc7-rt15 patch set. 

Changes since v5.15-rc7-rt14:

  - Avoid a sleeping-while-atomic warning in fscache. Reported by Gregor
    Beck.

  - Redo the synchronisation in fs/namespace and then remove cpu_chill()
    since it has finally no users.

  - Disable NUMA_BALANCING. It is problematic since it may block a task
    while moving memory from one NUMA node to another. This has been
    brought round by Mel Gorman while discussion a different issue.

  - Update the i915 patches to v2 which has been posted upstream.
    Testing on hardware is appreciated.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.15-rc7-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rc7-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rc7-rt15

The RT patch against v5.15-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rc7-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rc7-rt15.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/i915/gt/intel_context.h b/drivers/gpu/drm/i915/gt/intel_context.h
index bed60dff93eff..601274ba86e46 100644
--- a/drivers/gpu/drm/i915/gt/intel_context.h
+++ b/drivers/gpu/drm/i915/gt/intel_context.h
@@ -161,11 +161,10 @@ static inline void intel_context_enter(struct intel_context *ce)
 		ce->ops->enter(ce);
 }
 
-static inline void intel_context_mark_active(struct intel_context *ce,
-					     bool timeline_mutex_needed)
+static inline void intel_context_mark_active(struct intel_context *ce)
 {
-	if (timeline_mutex_needed)
-		lockdep_assert_held(&ce->timeline->mutex);
+	lockdep_assert(lockdep_is_held(&ce->timeline->mutex) ||
+		       test_bit(CONTEXT_IS_PARKED, &ce->flags));
 	++ce->active_count;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_context_types.h b/drivers/gpu/drm/i915/gt/intel_context_types.h
index e54351a170e2c..1022be795e682 100644
--- a/drivers/gpu/drm/i915/gt/intel_context_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_context_types.h
@@ -112,6 +112,7 @@ struct intel_context {
 #define CONTEXT_FORCE_SINGLE_SUBMISSION	7
 #define CONTEXT_NOPREEMPT		8
 #define CONTEXT_LRCA_DIRTY		9
+#define CONTEXT_IS_PARKED		10
 
 	struct {
 		u64 timeout_us;
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
index 02c0ab9fbb4b8..74775ae961b2b 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
@@ -42,7 +42,7 @@ heartbeat_create(struct intel_context *ce, gfp_t gfp)
 	struct i915_request *rq;
 
 	intel_context_enter(ce);
-	rq = __i915_request_create(ce, gfp, true);
+	rq = __i915_request_create(ce, gfp);
 	intel_context_exit(ce);
 
 	return rq;
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
index d75638d1d561e..e84f03a276d18 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -167,9 +167,10 @@ static bool switch_to_kernel_context(struct intel_engine_cs *engine)
 	 * engine->wakeref.count, we may see the request completion and retire
 	 * it causing an underflow of the engine->wakeref.
 	 */
+	set_bit(CONTEXT_IS_PARKED, &ce->flags);
 	GEM_BUG_ON(atomic_read(&ce->timeline->active_count) < 0);
 
-	rq = __i915_request_create(ce, GFP_NOWAIT, false);
+	rq = __i915_request_create(ce, GFP_NOWAIT);
 	if (IS_ERR(rq))
 		/* Context switch failed, hope for the best! Maybe reset? */
 		goto out_unlock;
@@ -198,6 +199,7 @@ static bool switch_to_kernel_context(struct intel_engine_cs *engine)
 
 	result = false;
 out_unlock:
+	clear_bit(CONTEXT_IS_PARKED, &ce->flags);
 	return result;
 }
 
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 3bab8f651b4e7..b9dd6100c6d17 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -833,8 +833,7 @@ static void __i915_request_ctor(void *arg)
 }
 
 struct i915_request *
-__i915_request_create(struct intel_context *ce, gfp_t gfp,
-		      bool timeline_mutex_needed)
+__i915_request_create(struct intel_context *ce, gfp_t gfp)
 {
 	struct intel_timeline *tl = ce->timeline;
 	struct i915_request *rq;
@@ -958,7 +957,7 @@ __i915_request_create(struct intel_context *ce, gfp_t gfp,
 
 	rq->infix = rq->ring->emit; /* end of header; start of user payload */
 
-	intel_context_mark_active(ce, timeline_mutex_needed);
+	intel_context_mark_active(ce);
 	list_add_tail_rcu(&rq->link, &tl->requests);
 
 	return rq;
@@ -994,7 +993,7 @@ i915_request_create(struct intel_context *ce)
 		i915_request_retire(rq);
 
 	intel_context_enter(ce);
-	rq = __i915_request_create(ce, GFP_KERNEL, true);
+	rq = __i915_request_create(ce, GFP_KERNEL);
 	intel_context_exit(ce); /* active reference transferred to request */
 	if (IS_ERR(rq))
 		goto err_unlock;
diff --git a/drivers/gpu/drm/i915/i915_request.h b/drivers/gpu/drm/i915/i915_request.h
index ba1ced79c8d2c..a2f713b4ac2f9 100644
--- a/drivers/gpu/drm/i915/i915_request.h
+++ b/drivers/gpu/drm/i915/i915_request.h
@@ -320,8 +320,7 @@ static inline bool dma_fence_is_i915(const struct dma_fence *fence)
 struct kmem_cache *i915_request_slab_cache(void);
 
 struct i915_request * __must_check
-__i915_request_create(struct intel_context *ce, gfp_t gfp,
-		      bool timeline_mutex_needed);
+__i915_request_create(struct intel_context *ce, gfp_t gfp);
 struct i915_request * __must_check
 i915_request_create(struct intel_context *ce);
 
@@ -610,7 +609,8 @@ i915_request_timeline(const struct i915_request *rq)
 {
 	/* Valid only while the request is being constructed (or retired). */
 	return rcu_dereference_protected(rq->timeline,
-					 lockdep_is_held(&rcu_access_pointer(rq->timeline)->mutex));
+					 lockdep_is_held(&rcu_access_pointer(rq->timeline)->mutex) ||
+					 test_bit(CONTEXT_IS_PARKED, &rq->context->flags));
 }
 
 static inline struct i915_gem_context *
diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 5259edacde380..b36b27c090496 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -343,7 +343,7 @@ wait_remaining_ms_from_jiffies(unsigned long timestamp_jiffies, int to_wait_ms)
 #define wait_for(COND, MS)		_wait_for((COND), (MS) * 1000, 10, 1000)
 
 /* If CONFIG_PREEMPT_COUNT is disabled, in_atomic() always reports false. */
-#if defined(CONFIG_DRM_I915_DEBUG) && defined(CONFIG_PREEMPT_COUNT)
+#if defined(CONFIG_DRM_I915_DEBUG) && defined(CONFIG_PREEMPT_COUNT) && !defined(CONFIG_PREEMPT_RT)
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) WARN_ON_ONCE((ATOMIC) && !in_atomic())
 #else
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) do { } while (0)
diff --git a/drivers/gpu/drm/selftests/test-drm_damage_helper.c b/drivers/gpu/drm/selftests/test-drm_damage_helper.c
index 1c19a5d3eefbf..8d8d8e214c283 100644
--- a/drivers/gpu/drm/selftests/test-drm_damage_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_damage_helper.c
@@ -30,6 +30,7 @@ static void mock_setup(struct drm_plane_state *state)
 	mock_device.driver = &mock_driver;
 	mock_device.mode_config.prop_fb_damage_clips = &mock_prop;
 	mock_plane.dev = &mock_device;
+	mock_obj_props.count = 0;
 	mock_plane.base.properties = &mock_obj_props;
 	mock_prop.base.id = 1; /* 0 is an invalid id */
 	mock_prop.dev = &mock_device;
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index c3e4804b8fcbf..9edb87e11680b 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -81,7 +81,6 @@ extern unsigned fscache_debug;
 extern struct kobject *fscache_root;
 extern struct workqueue_struct *fscache_object_wq;
 extern struct workqueue_struct *fscache_op_wq;
-DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
 
 extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
 
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 4207f98e405fd..85f8cf3a323d5 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -41,8 +41,6 @@ struct kobject *fscache_root;
 struct workqueue_struct *fscache_object_wq;
 struct workqueue_struct *fscache_op_wq;
 
-DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
-
 /* these values serve as lower bounds, will be adjusted in fscache_init() */
 static unsigned fscache_object_max_active = 4;
 static unsigned fscache_op_max_active = 2;
@@ -138,7 +136,6 @@ unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n)
 static int __init fscache_init(void)
 {
 	unsigned int nr_cpus = num_possible_cpus();
-	unsigned int cpu;
 	int ret;
 
 	fscache_object_max_active =
@@ -161,9 +158,6 @@ static int __init fscache_init(void)
 	if (!fscache_op_wq)
 		goto error_op_wq;
 
-	for_each_possible_cpu(cpu)
-		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
-
 	ret = fscache_proc_init();
 	if (ret < 0)
 		goto error_proc;
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 6a675652129b2..78f332f2e98c8 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -798,6 +798,8 @@ void fscache_object_destroy(struct fscache_object *object)
 }
 EXPORT_SYMBOL(fscache_object_destroy);
 
+static DECLARE_WAIT_QUEUE_HEAD(fscache_object_cong_wait);
+
 /*
  * enqueue an object for metadata-type processing
  */
@@ -806,12 +808,10 @@ void fscache_enqueue_object(struct fscache_object *object)
 	_enter("{OBJ%x}", object->debug_id);
 
 	if (fscache_get_object(object, fscache_obj_get_queue) >= 0) {
-		wait_queue_head_t *cong_wq =
-			&get_cpu_var(fscache_object_cong_wait);
 
 		if (queue_work(fscache_object_wq, &object->work)) {
 			if (fscache_object_congested())
-				wake_up(cong_wq);
+				wake_up(&fscache_object_cong_wait);
 		} else
 			fscache_put_object(object, fscache_obj_put_queue);
 
@@ -833,16 +833,15 @@ void fscache_enqueue_object(struct fscache_object *object)
  */
 bool fscache_object_sleep_till_congested(signed long *timeoutp)
 {
-	wait_queue_head_t *cong_wq = this_cpu_ptr(&fscache_object_cong_wait);
 	DEFINE_WAIT(wait);
 
 	if (fscache_object_congested())
 		return true;
 
-	add_wait_queue_exclusive(cong_wq, &wait);
+	add_wait_queue_exclusive(&fscache_object_cong_wait, &wait);
 	if (!fscache_object_congested())
 		*timeoutp = schedule_timeout(*timeoutp);
-	finish_wait(cong_wq, &wait);
+	finish_wait(&fscache_object_cong_wait, &wait);
 
 	return fscache_object_congested();
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index c6e1e24be9408..3ab45b47b2860 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -14,7 +14,6 @@
 #include <linux/mnt_namespace.h>
 #include <linux/user_namespace.h>
 #include <linux/namei.h>
-#include <linux/hrtimer.h>
 #include <linux/security.h>
 #include <linux/cred.h>
 #include <linux/idr.h>
@@ -344,10 +343,23 @@ int __mnt_want_write(struct vfsmount *m)
 	 * incremented count after it has set MNT_WRITE_HOLD.
 	 */
 	smp_mb();
+	might_lock(&mount_lock.lock);
 	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
-		preempt_enable();
-		cpu_chill();
-		preempt_disable();
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			cpu_relax();
+		} else {
+			/*
+			 * This prevents priority inversion, if the task
+			 * setting MNT_WRITE_HOLD got preempted on a remote
+			 * CPU, and it prevents life lock if the task setting
+			 * MNT_WRITE_HOLD has a lower priority and is bound to
+			 * the same CPU as the task that is spinning here.
+			 */
+			preempt_enable();
+			lock_mount_hash();
+			unlock_mount_hash();
+			preempt_disable();
+		}
 	}
 	/*
 	 * After the slowpath clears MNT_WRITE_HOLD, mnt_is_readonly will
diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index 1e5399e47c3a5..c34a3e8030e12 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -60,7 +60,7 @@ struct drm_mode_object {
 	void (*free_cb)(struct kref *kref);
 };
 
-#define DRM_OBJECT_MAX_PROPERTY 42
+#define DRM_OBJECT_MAX_PROPERTY 24
 /**
  * struct drm_object_properties - property tracking for &drm_mode_object
  */
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4a2230e409d2a..0ee140176f102 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -42,7 +42,6 @@ enum hrtimer_mode {
 	HRTIMER_MODE_PINNED	= 0x02,
 	HRTIMER_MODE_SOFT	= 0x04,
 	HRTIMER_MODE_HARD	= 0x08,
-	HRTIMER_MODE_CHILL	= 0x10,
 
 	HRTIMER_MODE_ABS_PINNED = HRTIMER_MODE_ABS | HRTIMER_MODE_PINNED,
 	HRTIMER_MODE_REL_PINNED = HRTIMER_MODE_REL | HRTIMER_MODE_PINNED,
@@ -125,7 +124,6 @@ struct hrtimer {
 	u8				is_rel;
 	u8				is_soft;
 	u8				is_hard;
-	u8				is_chill;
 };
 
 /**
@@ -538,10 +536,4 @@ int hrtimers_dead_cpu(unsigned int cpu);
 #define hrtimers_dead_cpu	NULL
 #endif
 
-#ifdef CONFIG_PREEMPT_RT
-extern void cpu_chill(void);
-#else
-# define cpu_chill()	cpu_relax()
-#endif
-
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index 28fd7b8e8c7d6..0b8a65ae1d72f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -901,7 +901,7 @@ config NUMA_BALANCING
 	bool "Memory placement aware NUMA scheduler"
 	depends on ARCH_SUPPORTS_NUMA_BALANCING
 	depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
-	depends on SMP && NUMA && MIGRATION
+	depends on SMP && NUMA && MIGRATION && !PREEMPT_RT
 	help
 	  This option adds support for automatic NUMA aware memory/task placement.
 	  The mechanism is quite primitive and is based on migrating memory when
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 295e065d27905..0ea8702eb5163 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1570,7 +1570,6 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
 	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
-	timer->is_chill = !!(mode & HRTIMER_MODE_CHILL);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 }
@@ -1937,7 +1936,7 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 
 	t->task = NULL;
 	if (task)
-		wake_up_state(task, timer->is_chill ? TASK_RTLOCK_WAIT : TASK_NORMAL);
+		wake_up_process(task);
 
 	return HRTIMER_NORESTART;
 }
@@ -2155,34 +2154,6 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 }
 #endif
 
-#ifdef CONFIG_PREEMPT_RT
-/*
- * Sleep for 1 ms in hope whoever holds what we want will let it go.
- */
-void cpu_chill(void)
-{
-	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
-	ktime_t chill_time;
-
-	local_irq_disable();
-	current_save_and_set_rtlock_wait_state();
-	local_irq_enable();
-
-	chill_time = ktime_set(0, NSEC_PER_MSEC);
-
-	current->flags |= PF_NOFREEZE;
-	schedule_hrtimeout(&chill_time,
-			   HRTIMER_MODE_REL_HARD| HRTIMER_MODE_CHILL);
-	if (!freeze_flag)
-		current->flags &= ~PF_NOFREEZE;
-
-	local_irq_disable();
-	current_restore_rtlock_saved_state();
-	local_irq_enable();
-}
-EXPORT_SYMBOL(cpu_chill);
-#endif
-
 /*
  * Functions related to boot-time initialization:
  */
diff --git a/localversion-rt b/localversion-rt
index 08b3e75841adc..18777ec0c27d4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
