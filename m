From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.18.9-rt5
Date: Mon, 16 Mar 2015 22:01:46 +0100
Message-ID: <20150316210146.GG28130@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37865 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbbCPVBt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 17:01:49 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v3.18.9-rt5 patch set.

Changes since v3.18.9-rt4

- fix non-rt builds. Reported by Neil Bradley, fixed by Steven Rostedt

- backport a patch from Lai Jiangshan which was suggested by Paul E.
  McKenney to avoid a RCU related race

- a bunch of stable marked patches for the radeon driver to avoid a
  freeze of the machine during heavy GPU usage. It was reported by
  Carsten Emde and he says that the machine does no longer lockup with
  them but X seems still to hang.

- a patch from Mike Galbraith to get FULL_NOHZ to work again. The patch
  ("rt-nohz_full-fix-nohz_full-for-PREEMPT_RT_FULL.patch") is included
  in the split out queue but is currently not enabled.

- lazy preempt on x86_64 is enabled again. It seems that it fixed
  itself.

Known issues:

      - bcache is disabled.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the next
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        measuring the performance of the individual implementation.


The delta patch against 3.18.9-rt4 is appended below and can be found here: 

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.9-rt4-rt5.patch.xz

The RT patch against 3.18.9 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.9-rt5.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patches-3.18.9-rt5.tar.xz

Sebastian

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c4f25b843d9..25d692ddae4e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -21,7 +21,7 @@ config X86_64
 ### Arch settings
 config X86
 	def_bool y
-	select HAVE_PREEMPT_LAZY if X86_32
+	select HAVE_PREEMPT_LAZY
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_FAST_MULTIPLIER
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 9328fb3dcfce..36a6bce74230 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -7295,7 +7295,6 @@ int cik_irq_set(struct radeon_device *rdev)
 	u32 hpd1, hpd2, hpd3, hpd4, hpd5, hpd6;
 	u32 grbm_int_cntl = 0;
 	u32 dma_cntl, dma_cntl1;
-	u32 thermal_int;
 
 	if (!rdev->irq.installed) {
 		WARN(1, "Can't enable IRQ/MSI because no handler is installed\n");
@@ -7332,13 +7331,6 @@ int cik_irq_set(struct radeon_device *rdev)
 	cp_m2p2 = RREG32(CP_ME2_PIPE2_INT_CNTL) & ~TIME_STAMP_INT_ENABLE;
 	cp_m2p3 = RREG32(CP_ME2_PIPE3_INT_CNTL) & ~TIME_STAMP_INT_ENABLE;
 
-	if (rdev->flags & RADEON_IS_IGP)
-		thermal_int = RREG32_SMC(CG_THERMAL_INT_CTRL) &
-			~(THERM_INTH_MASK | THERM_INTL_MASK);
-	else
-		thermal_int = RREG32_SMC(CG_THERMAL_INT) &
-			~(THERM_INT_MASK_HIGH | THERM_INT_MASK_LOW);
-
 	/* enable CP interrupts on all rings */
 	if (atomic_read(&rdev->irq.ring_int[RADEON_RING_TYPE_GFX_INDEX])) {
 		DRM_DEBUG("cik_irq_set: sw int gfx\n");
@@ -7496,14 +7488,6 @@ int cik_irq_set(struct radeon_device *rdev)
 		hpd6 |= DC_HPDx_INT_EN;
 	}
 
-	if (rdev->irq.dpm_thermal) {
-		DRM_DEBUG("dpm thermal\n");
-		if (rdev->flags & RADEON_IS_IGP)
-			thermal_int |= THERM_INTH_MASK | THERM_INTL_MASK;
-		else
-			thermal_int |= THERM_INT_MASK_HIGH | THERM_INT_MASK_LOW;
-	}
-
 	WREG32(CP_INT_CNTL_RING0, cp_int_cntl);
 
 	WREG32(SDMA0_CNTL + SDMA0_REGISTER_OFFSET, dma_cntl);
@@ -7557,10 +7541,8 @@ int cik_irq_set(struct radeon_device *rdev)
 	WREG32(DC_HPD5_INT_CONTROL, hpd5);
 	WREG32(DC_HPD6_INT_CONTROL, hpd6);
 
-	if (rdev->flags & RADEON_IS_IGP)
-		WREG32_SMC(CG_THERMAL_INT_CTRL, thermal_int);
-	else
-		WREG32_SMC(CG_THERMAL_INT, thermal_int);
+	/* posting read */
+	RREG32(SRBM_STATUS);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 85995b4e3338..c674f63d7f14 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -4589,6 +4589,9 @@ int evergreen_irq_set(struct radeon_device *rdev)
 	WREG32(AFMT_AUDIO_PACKET_CONTROL + EVERGREEN_CRTC4_REGISTER_OFFSET, afmt5);
 	WREG32(AFMT_AUDIO_PACKET_CONTROL + EVERGREEN_CRTC5_REGISTER_OFFSET, afmt6);
 
+	/* posting read */
+	RREG32(SRBM_STATUS);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/radeon/kv_dpm.c b/drivers/gpu/drm/radeon/kv_dpm.c
index e3e9c10cfba9..85a109e1e56b 100644
--- a/drivers/gpu/drm/radeon/kv_dpm.c
+++ b/drivers/gpu/drm/radeon/kv_dpm.c
@@ -1169,6 +1169,19 @@ void kv_dpm_enable_bapm(struct radeon_device *rdev, bool enable)
 	}
 }
 
+static void kv_enable_thermal_int(struct radeon_device *rdev, bool enable)
+{
+	u32 thermal_int;
+
+	thermal_int = RREG32_SMC(CG_THERMAL_INT_CTRL);
+	if (enable)
+		thermal_int |= THERM_INTH_MASK | THERM_INTL_MASK;
+	else
+		thermal_int &= ~(THERM_INTH_MASK | THERM_INTL_MASK);
+	WREG32_SMC(CG_THERMAL_INT_CTRL, thermal_int);
+
+}
+
 int kv_dpm_enable(struct radeon_device *rdev)
 {
 	struct kv_power_info *pi = kv_get_pi(rdev);
@@ -1280,8 +1293,7 @@ int kv_dpm_late_enable(struct radeon_device *rdev)
 			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
 			return ret;
 		}
-		rdev->irq.dpm_thermal = true;
-		radeon_irq_set(rdev);
+		kv_enable_thermal_int(rdev, true);
 	}
 
 	/* powerdown unused blocks for now */
@@ -1312,6 +1324,7 @@ void kv_dpm_disable(struct radeon_device *rdev)
 	kv_stop_dpm(rdev);
 	kv_enable_ulv(rdev, false);
 	kv_reset_am(rdev);
+	kv_enable_thermal_int(rdev, false);
 
 	kv_update_current_ps(rdev, rdev->pm.dpm.boot_ps);
 }
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 56b02927cd3d..ee0868dec2f4 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -3787,6 +3787,9 @@ int r600_irq_set(struct radeon_device *rdev)
 		WREG32(RV770_CG_THERMAL_INT, thermal_int);
 	}
 
+	/* posting read */
+	RREG32(R_000E50_SRBM_STATUS);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 995167025282..8569afaba688 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -1029,37 +1029,59 @@ static inline bool radeon_test_signaled(struct radeon_fence *fence)
 	return test_bit(FENCE_FLAG_SIGNALED_BIT, &fence->base.flags);
 }
 
+struct radeon_wait_cb {
+	struct fence_cb base;
+	struct task_struct *task;
+};
+
+static void
+radeon_fence_wait_cb(struct fence *fence, struct fence_cb *cb)
+{
+	struct radeon_wait_cb *wait =
+		container_of(cb, struct radeon_wait_cb, base);
+
+	wake_up_process(wait->task);
+}
+
 static signed long radeon_fence_default_wait(struct fence *f, bool intr,
 					     signed long t)
 {
 	struct radeon_fence *fence = to_radeon_fence(f);
 	struct radeon_device *rdev = fence->rdev;
-	bool signaled;
+	struct radeon_wait_cb cb;
 
-	fence_enable_sw_signaling(&fence->base);
+	cb.task = current;
 
-	/*
-	 * This function has to return -EDEADLK, but cannot hold
-	 * exclusive_lock during the wait because some callers
-	 * may already hold it. This means checking needs_reset without
-	 * lock, and not fiddling with any gpu internals.
-	 *
-	 * The callback installed with fence_enable_sw_signaling will
-	 * run before our wait_event_*timeout call, so we will see
-	 * both the signaled fence and the changes to needs_reset.
-	 */
+	if (fence_add_callback(f, &cb.base, radeon_fence_wait_cb))
+		return t;
+
+	while (t > 0) {
+		if (intr)
+			set_current_state(TASK_INTERRUPTIBLE);
+		else
+			set_current_state(TASK_UNINTERRUPTIBLE);
+
+		/*
+		 * radeon_test_signaled must be called after
+		 * set_current_state to prevent a race with wake_up_process
+		 */
+		if (radeon_test_signaled(fence))
+			break;
+
+		if (rdev->needs_reset) {
+			t = -EDEADLK;
+			break;
+		}
+
+		t = schedule_timeout(t);
+
+		if (t > 0 && intr && signal_pending(current))
+			t = -ERESTARTSYS;
+	}
+
+	__set_current_state(TASK_RUNNING);
+	fence_remove_callback(f, &cb.base);
 
-	if (intr)
-		t = wait_event_interruptible_timeout(rdev->fence_queue,
-			((signaled = radeon_test_signaled(fence)) ||
-			 rdev->needs_reset), t);
-	else
-		t = wait_event_timeout(rdev->fence_queue,
-			((signaled = radeon_test_signaled(fence)) ||
-			 rdev->needs_reset), t);
-
-	if (t > 0 && !signaled)
-		return -EDEADLK;
 	return t;
 }
 
diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs600.c
index 74bce91aecc1..039660662ee8 100644
--- a/drivers/gpu/drm/radeon/rs600.c
+++ b/drivers/gpu/drm/radeon/rs600.c
@@ -693,6 +693,10 @@ int rs600_irq_set(struct radeon_device *rdev)
 	WREG32(R_007D18_DC_HOT_PLUG_DETECT2_INT_CONTROL, hpd2);
 	if (ASIC_IS_DCE2(rdev))
 		WREG32(R_007408_HDMI0_AUDIO_PACKET_CONTROL, hdmi0);
+
+	/* posting read */
+	RREG32(R_000040_GEN_INT_CNTL);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 7d5083dc4acb..35ce05c78c4d 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -6192,6 +6192,9 @@ int si_irq_set(struct radeon_device *rdev)
 
 	WREG32(CG_THERMAL_INT, thermal_int);
 
+	/* posting read */
+	RREG32(SRBM_STATUS);
+
 	return 0;
 }
 
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 0c6491228b17..4b53470bf97b 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -147,7 +147,9 @@ bool irq_work_needs_cpu(void)
 
 	if (llist_empty(raised))
 		if (llist_empty(lazy))
+#ifdef CONFIG_PREEMPT_RT_FULL
 			if (llist_empty(this_cpu_ptr(&hirq_work_list)))
+#endif
 				return false;
 
 	/* All work should have been flushed before going offline */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4245a2dc1911..e8508b4febc5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -173,11 +173,6 @@ struct rcu_node {
 				/*  queued on this rcu_node structure that */
 				/*  are blocking the current grace period, */
 				/*  there can be no such task. */
-	struct completion boost_completion;
-				/* Used to ensure that the rt_mutex used */
-				/*  to carry out the boosting is fully */
-				/*  released with no future boostee accesses */
-				/*  before that rt_mutex is re-initialized. */
 	struct rt_mutex boost_mtx;
 				/* Used only for the priority-boosting */
 				/*  side effect, not as a lock. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e19cfc0a881a..ecd967ecc7ce 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -392,10 +392,8 @@ void rcu_read_unlock_special(struct task_struct *t)
 
 #ifdef CONFIG_RCU_BOOST
 		/* Unboost if we were boosted. */
-		if (drop_boost_mutex) {
+		if (drop_boost_mutex)
 			rt_mutex_unlock(&rnp->boost_mtx);
-			complete(&rnp->boost_completion);
-		}
 #endif /* #ifdef CONFIG_RCU_BOOST */
 
 		/*
@@ -1163,15 +1161,11 @@ static int rcu_boost(struct rcu_node *rnp)
 	 */
 	t = container_of(tb, struct task_struct, rcu_node_entry);
 	rt_mutex_init_proxy_locked(&rnp->boost_mtx, t);
-	init_completion(&rnp->boost_completion);
 	raw_spin_unlock_irqrestore(&rnp->lock, flags);
 	/* Lock only for side effect: boosts task t's priority. */
 	rt_mutex_lock(&rnp->boost_mtx);
 	rt_mutex_unlock(&rnp->boost_mtx);  /* Then keep lockdep happy. */
 
-	/* Wait for boostee to be done w/boost_mtx before reinitializing. */
-	wait_for_completion(&rnp->boost_completion);
