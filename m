Return-Path: <SRS0=9Pks=WM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8E7C3A59D
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BDA206C2
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 15:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfHPPgY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:36:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42626 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfHPPgX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Aug 2019 11:36:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyeH2-0003uf-N5; Fri, 16 Aug 2019 17:36:16 +0200
Date:   Fri, 16 Aug 2019 17:36:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2.9-rt3 patch set. 

Changes since v5.2.9-rt2:

  - The exynos5 i2c controller disabled IRQ threading as reported by
    Benjamin Rouxel. The hix5hd2 i2c controller did the same.

  - A timer related to the deadline scheduler now fires in hard-irq
    context. Patch by Juri Lelli.

  - A lock used the x86's thermal exception uses a raw_spinlock_t. Patch
    by Clark Williams.

  - The DMA-reservation code is using now a sequence lock instead a
    sequence counter. Yann Collette reported warnings from that area
    with an AMD GPU.

  - Two kvm related timer on arm64 expire now hard-irq context. Reported
    by Julien Grall, patched by Thomas Gleixner.

  - Lazy preemption was broken in a case on arm64, reported by Paul
    Thomas. While investigating another lazy-preempt bug was fixed on
    arm64 and x86.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.2.9-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2.9-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2.9-rt3

The RT patch against v5.2.9 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.9-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2.9-rt3.tar.xz

Sebastian

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 3bfad251203b5..ca1c6fe8dd347 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -73,6 +73,8 @@ static inline bool __preempt_count_dec_and_test(void)
 	if (!pc || !READ_ONCE(ti->preempt_count))
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if ((pc & ~PREEMPT_NEED_RESCHED))
+		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index aa16cb43a779e..5d651c560bba6 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -680,7 +680,8 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	orr	x24, x24, x0
 alternative_else_nop_endif
 
-	cbnz	x24, 2f					// preempt count != 0
+	cbz	x24, 1f					// (need_resched + count) == 0
+	cbnz	w24, 2f					// count != 0
 
 	ldr	w24, [tsk, #TSK_TI_PREEMPT_LAZY]	// get preempt lazy count
 	cbnz	w24, 2f					// preempt lazy count != 0
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index f8e42abd874a4..9496299d23fc3 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -99,6 +99,8 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	if (____preempt_count_dec_and_test())
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if (preempt_count())
+		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a6fee5a6e9fb2..27fffd65abe6b 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -168,7 +168,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 		return 0;
 
 retry:
-	seq = read_seqcount_begin(&resv->seq);
+	seq = read_seqbegin(&resv->seq);
 	rcu_read_lock();
 
 	fobj = rcu_dereference(resv->fence);
@@ -177,7 +177,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 	else
 		shared_count = 0;
 	fence_excl = rcu_dereference(resv->fence_excl);
-	if (read_seqcount_retry(&resv->seq, seq)) {
+	if (read_seqretry(&resv->seq, seq)) {
 		rcu_read_unlock();
 		goto retry;
 	}
@@ -1034,12 +1034,12 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 
 		robj = buf_obj->resv;
 		while (true) {
-			seq = read_seqcount_begin(&robj->seq);
+			seq = read_seqbegin(&robj->seq);
 			rcu_read_lock();
 			fobj = rcu_dereference(robj->fence);
 			shared_count = fobj ? fobj->shared_count : 0;
 			fence = rcu_dereference(robj->fence_excl);
-			if (!read_seqcount_retry(&robj->seq, seq))
+			if (!read_seqretry(&robj->seq, seq))
 				break;
 			rcu_read_unlock();
 		}
diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
index 4447e13d1e891..030c45ad3e56a 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -110,15 +110,13 @@ int reservation_object_reserve_shared(struct reservation_object *obj,
 	new->shared_count = j;
 	new->shared_max = max;
 
-	preempt_disable();
-	write_seqcount_begin(&obj->seq);
+	write_seqlock(&obj->seq);
 	/*
 	 * RCU_INIT_POINTER can be used here,
 	 * seqcount provides the necessary barriers
 	 */
 	RCU_INIT_POINTER(obj->fence, new);
-	write_seqcount_end(&obj->seq);
-	preempt_enable();
+	write_sequnlock(&obj->seq);
 
 	if (!old)
 		return 0;
@@ -158,8 +156,7 @@ void reservation_object_add_shared_fence(struct reservation_object *obj,
 	fobj = reservation_object_get_list(obj);
 	count = fobj->shared_count;
 
-	preempt_disable();
-	write_seqcount_begin(&obj->seq);
+	write_seqlock(&obj->seq);
 
 	for (i = 0; i < count; ++i) {
 		struct dma_fence *old_fence;
@@ -181,8 +178,7 @@ void reservation_object_add_shared_fence(struct reservation_object *obj,
 	/* pointer update must be visible before we extend the shared_count */
 	smp_store_mb(fobj->shared_count, count);
 
-	write_seqcount_end(&obj->seq);
-	preempt_enable();
+	write_sequnlock(&obj->seq);
 }
 EXPORT_SYMBOL(reservation_object_add_shared_fence);
 
@@ -209,14 +205,11 @@ void reservation_object_add_excl_fence(struct reservation_object *obj,
 	if (fence)
 		dma_fence_get(fence);
 
-	preempt_disable();
-	write_seqcount_begin(&obj->seq);
-	/* write_seqcount_begin provides the necessary memory barrier */
+	write_seqlock(&obj->seq);
 	RCU_INIT_POINTER(obj->fence_excl, fence);
 	if (old)
 		old->shared_count = 0;
-	write_seqcount_end(&obj->seq);
-	preempt_enable();
+	write_sequnlock(&obj->seq);
 
 	/* inplace update, no shared fences */
 	while (i--)
@@ -298,13 +291,10 @@ int reservation_object_copy_fences(struct reservation_object *dst,
 	src_list = reservation_object_get_list(dst);
 	old = reservation_object_get_excl(dst);
 
-	preempt_disable();
-	write_seqcount_begin(&dst->seq);
-	/* write_seqcount_begin provides the necessary memory barrier */
+	write_seqlock(&dst->seq);
 	RCU_INIT_POINTER(dst->fence_excl, new);
 	RCU_INIT_POINTER(dst->fence, dst_list);
-	write_seqcount_end(&dst->seq);
-	preempt_enable();
+	write_sequnlock(&dst->seq);
 
 	if (src_list)
 		kfree_rcu(src_list, rcu);
@@ -345,7 +335,7 @@ int reservation_object_get_fences_rcu(struct reservation_object *obj,
 		shared_count = i = 0;
 
 		rcu_read_lock();
-		seq = read_seqcount_begin(&obj->seq);
+		seq = read_seqbegin(&obj->seq);
 
 		fence_excl = rcu_dereference(obj->fence_excl);
 		if (fence_excl && !dma_fence_get_rcu(fence_excl))
@@ -394,7 +384,7 @@ int reservation_object_get_fences_rcu(struct reservation_object *obj,
 			}
 		}
 
-		if (i != shared_count || read_seqcount_retry(&obj->seq, seq)) {
+		if (i != shared_count || read_seqretry(&obj->seq, seq)) {
 			while (i--)
 				dma_fence_put(shared[i]);
 			dma_fence_put(fence_excl);
@@ -443,7 +433,7 @@ long reservation_object_wait_timeout_rcu(struct reservation_object *obj,
 
 retry:
 	shared_count = 0;
-	seq = read_seqcount_begin(&obj->seq);
+	seq = read_seqbegin(&obj->seq);
 	rcu_read_lock();
 	i = -1;
 
@@ -490,7 +480,7 @@ long reservation_object_wait_timeout_rcu(struct reservation_object *obj,
 
 	rcu_read_unlock();
 	if (fence) {
-		if (read_seqcount_retry(&obj->seq, seq)) {
+		if (read_seqretry(&obj->seq, seq)) {
 			dma_fence_put(fence);
 			goto retry;
 		}
@@ -546,7 +536,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
 retry:
 	ret = true;
 	shared_count = 0;
-	seq = read_seqcount_begin(&obj->seq);
+	seq = read_seqbegin(&obj->seq);
 
 	if (test_all) {
 		unsigned i;
@@ -567,7 +557,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
 				break;
 		}
 
-		if (read_seqcount_retry(&obj->seq, seq))
+		if (read_seqretry(&obj->seq, seq))
 			goto retry;
 	}
 
@@ -580,7 +570,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
 			if (ret < 0)
 				goto retry;
 
-			if (read_seqcount_retry(&obj->seq, seq))
+			if (read_seqretry(&obj->seq, seq))
 				goto retry;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4b192e0ce92f4..be625817e5d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -250,11 +250,9 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	new->shared_count = k;
 
 	/* Install the new fence list, seqcount provides the barriers */
-	preempt_disable();
-	write_seqcount_begin(&resv->seq);
+	write_seqlock(&resv->seq);
 	RCU_INIT_POINTER(resv->fence, new);
-	write_seqcount_end(&resv->seq);
-	preempt_enable();
+	write_sequnlock(&resv->seq);
 
 	/* Drop the references to the removed fences or move them to ef_list */
 	for (i = j, k = 0; i < old->shared_count; ++i) {
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index ad01c92aaf748..2910a133077a3 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -449,7 +449,7 @@ i915_gem_object_wait_reservation(struct reservation_object *resv,
 				 unsigned int flags,
 				 long timeout)
 {
-	unsigned int seq = __read_seqcount_begin(&resv->seq);
+	unsigned int seq = read_seqbegin(&resv->seq);
 	struct dma_fence *excl;
 	bool prune_fences = false;
 
@@ -500,9 +500,9 @@ i915_gem_object_wait_reservation(struct reservation_object *resv,
 	 * signaled and that the reservation object has not been changed (i.e.
 	 * no new fences have been added).
 	 */
-	if (prune_fences && !__read_seqcount_retry(&resv->seq, seq)) {
+	if (prune_fences && !read_seqretry(&resv->seq, seq)) {
 		if (reservation_object_trylock(resv)) {
-			if (!__read_seqcount_retry(&resv->seq, seq))
+			if (!read_seqretry(&resv->seq, seq))
 				reservation_object_add_excl_fence(resv, NULL);
 			reservation_object_unlock(resv);
 		}
@@ -3943,7 +3943,7 @@ i915_gem_busy_ioctl(struct drm_device *dev, void *data,
 	 *
 	 */
 retry:
-	seq = raw_read_seqcount(&obj->resv->seq);
+	seq = read_seqbegin(&obj->resv->seq);
 
 	/* Translate the exclusive fence to the READ *and* WRITE engine */
 	args->busy = busy_check_writer(rcu_dereference(obj->resv->fence_excl));
@@ -3961,7 +3961,7 @@ i915_gem_busy_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	if (args->busy && read_seqcount_retry(&obj->resv->seq, seq))
+	if (args->busy && read_seqretry(&obj->resv->seq, seq))
 		goto retry;
 
 	err = 0;
diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index e4e7932f78000..e7514c16b756c 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -791,9 +791,7 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, i2c->irq, exynos5_i2c_irq,
-				IRQF_NO_SUSPEND | IRQF_ONESHOT,
-				dev_name(&pdev->dev), i2c);
-
+			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), i2c);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot request HS-I2C IRQ %d\n", i2c->irq);
 		goto err_clk;
diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 4df1434b3597d..8497c7a95dd44 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -445,8 +445,7 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 	hix5hd2_i2c_init(priv);
 
 	ret = devm_request_irq(&pdev->dev, irq, hix5hd2_i2c_irq,
-			       IRQF_NO_SUSPEND | IRQF_ONESHOT,
-			       dev_name(&pdev->dev), priv);
+			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), priv);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot request HS-I2C IRQ %d\n", irq);
 		goto err_clk;
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 319b771261686..92ceed3de6f39 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -63,7 +63,7 @@ static int max_packages __read_mostly;
 /* Array of package pointers */
 static struct pkg_device **packages;
 /* Serializes interrupt notification, work and hotplug */
-static DEFINE_SPINLOCK(pkg_temp_lock);
+static DEFINE_RAW_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
 static DEFINE_MUTEX(thermal_zone_mutex);
 
@@ -279,12 +279,12 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	u64 msr_val, wr_val;
 
 	mutex_lock(&thermal_zone_mutex);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	++pkg_work_cnt;
 
 	pkgdev = pkg_temp_thermal_get_dev(cpu);
 	if (!pkgdev) {
-		spin_unlock_irq(&pkg_temp_lock);
+		raw_spin_unlock_irq(&pkg_temp_lock);
 		mutex_unlock(&thermal_zone_mutex);
 		return;
 	}
@@ -298,7 +298,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 
 	enable_pkg_thres_interrupt();
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/*
 	 * If tzone is not NULL, then thermal_zone_mutex will prevent the
@@ -323,7 +323,7 @@ static int pkg_thermal_notify(u64 msr_val)
 	struct pkg_device *pkgdev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pkg_temp_lock, flags);
+	raw_spin_lock_irqsave(&pkg_temp_lock, flags);
 	++pkg_interrupt_cnt;
 
 	disable_pkg_thres_interrupt();
@@ -335,7 +335,7 @@ static int pkg_thermal_notify(u64 msr_val)
 		pkg_thermal_schedule_work(pkgdev->cpu, &pkgdev->work);
 	}
 
-	spin_unlock_irqrestore(&pkg_temp_lock, flags);
+	raw_spin_unlock_irqrestore(&pkg_temp_lock, flags);
 	return 0;
 }
 
@@ -381,9 +381,9 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	      pkgdev->msr_pkg_therm_high);
 
 	cpumask_set_cpu(cpu, &pkgdev->cpumask);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	packages[pkgid] = pkgdev;
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 	return 0;
 }
 
@@ -420,7 +420,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	}
 
 	/* Protect against work and interrupts */
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 
 	/*
 	 * Check whether this cpu was the current target and store the new
@@ -452,9 +452,9 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 		 * To cancel the work we need to drop the lock, otherwise
 		 * we might deadlock if the work needs to be flushed.
 		 */
-		spin_unlock_irq(&pkg_temp_lock);
+		raw_spin_unlock_irq(&pkg_temp_lock);
 		cancel_delayed_work_sync(&pkgdev->work);
-		spin_lock_irq(&pkg_temp_lock);
+		raw_spin_lock_irq(&pkg_temp_lock);
 		/*
 		 * If this is not the last cpu in the package and the work
 		 * did not run after we dropped the lock above, then we
@@ -465,7 +465,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 			pkg_thermal_schedule_work(target, &pkgdev->work);
 	}
 
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
 	if (lastcpu)
diff --git a/include/linux/reservation.h b/include/linux/reservation.h
index ee750765cc941..11cc05f489365 100644
--- a/include/linux/reservation.h
+++ b/include/linux/reservation.h
@@ -71,7 +71,7 @@ struct reservation_object_list {
  */
 struct reservation_object {
 	struct ww_mutex lock;
-	seqcount_t seq;
+	seqlock_t seq;
 
 	struct dma_fence __rcu *fence_excl;
 	struct reservation_object_list __rcu *fence;
@@ -90,7 +90,7 @@ reservation_object_init(struct reservation_object *obj)
 {
 	ww_mutex_init(&obj->lock, &reservation_ww_class);
 
-	__seqcount_init(&obj->seq, reservation_seqcount_string, &reservation_seqcount_class);
+	seqlock_init(&obj->seq);
 	RCU_INIT_POINTER(obj->fence, NULL);
 	RCU_INIT_POINTER(obj->fence_excl, NULL);
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c18be51f76088..1758f2a2d775a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -287,7 +287,7 @@ static void task_non_contending(struct task_struct *p)
 
 	dl_se->dl_non_contending = 1;
 	get_task_struct(p);
-	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL);
+	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
 }
 
 static void task_contending(struct sched_dl_entity *dl_se, int flags)
@@ -1292,7 +1292,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = inactive_task_timer;
 }
 
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 1be486d5d7cb4..0bfa7c5b5c890 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -80,7 +80,7 @@ static inline bool userspace_irqchip(struct kvm *kvm)
 static void soft_timer_start(struct hrtimer *hrt, u64 ns)
 {
 	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
-		      HRTIMER_MODE_ABS);
+		      HRTIMER_MODE_ABS_HARD);
 }
 
 static void soft_timer_cancel(struct hrtimer *hrt)
@@ -697,11 +697,11 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 	update_vtimer_cntvoff(vcpu, kvm_phys_timer_read());
 	ptimer->cntvoff = 0;
 
-	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	timer->bg_timer.function = kvm_bg_timer_expire;
 
-	hrtimer_init(&vtimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&vtimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	vtimer->hrtimer.function = kvm_hrtimer_expire;
 	ptimer->hrtimer.function = kvm_hrtimer_expire;
 
