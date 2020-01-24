Return-Path: <SRS0=keAW=3N=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DFC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0472075D
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jan 2020 16:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbgAXQT3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbgAXQT2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jan 2020 11:19:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D9620704;
        Fri, 24 Jan 2020 16:19:23 +0000 (UTC)
Date:   Fri, 24 Jan 2020 11:19:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [ANNOUNCE] 4.19.94-rt39
Message-ID: <20200124111922.773869e6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.19.94-rt39 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: efdcdf156f9d306e247ef57c71dce0858435208c


Or to build 4.19.94-rt39 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.94.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.94-rt39.patch.xz



You can also build from 4.19.94-rt38 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.94-rt38-rt39.patch.xz



Enjoy,

-- Steve


Changes from v4.19.94-rt38:

---

Clark Williams (1):
      thermal/x86_pkg_temp: make pkg_temp_lock a raw spinlock

Daniel Wagner (1):
      lib/smp_processor_id: Adjust check_preemption_disabled()

Julien Grall (4):
      hrtimer: Use READ_ONCE to access timer->base in hrimer_grab_expiry_lock()
      hrtimer: Don't grab the expiry lock for non-soft hrtimer
      hrtimer: Prevent using hrtimer_grab_expiry_lock() on migration_base
      lib/ubsan: Don't seralize UBSAN report

Juri Lelli (1):
      sched/deadline: Ensure inactive_timer runs in hardirq context

Liu Haitao (1):
      kmemleak: Change the lock of kmemleak_object to raw_spinlock_t

Peter Zijlstra (1):
      locking/rtmutex: Clean ->pi_blocked_on in the error case

Scott Wood (7):
      sched: migrate_dis/enable: Use sleeping_lock…() to annotate sleeping points
      sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_ptr
      sched: Remove dead __migrate_disabled() check
      sched: migrate disable: Protect cpus_ptr with lock
      sched: migrate_enable: Use select_fallback_rq()
      sched: Lazy migrate_disable processing
      sched: migrate_enable: Use stop_one_cpu_nowait()

Sebastian Andrzej Siewior (11):
      i2c: exynos5: Remove IRQF_ONESHOT
      i2c: hix5hd2: Remove IRQF_ONESHOT
      dma-buf: Use seqlock_t instread disabling preemption
      x86: preempt: Check preemption level before looking at lazy-preempt
      hrtimer: Add a missing bracket and hide `migration_base' on !SMP
      posix-timers: Unlock expiry lock in the early return
      futex: Make the futex_hash_bucket spinlock_t again and bring back its old state
      Revert "ARM: Initialize split page table locks for vector page"
      locking: Make spinlock_t and rwlock_t a RCU section on RT
      sched/core: migrate_enable() must access takedown_cpu_task on !HOTPLUG_CPU
      sched: migrate_enable: Busy loop until the migration request is completed

Steven Rostedt (VMware) (1):
      Linux 4.19.94-rt39

Thomas Gleixner (1):
      KVM: arm/arm64: Let the timer expire in hardirq context on RT

Waiman Long (1):
      lib/smp_processor_id: Don't use cpumask_equal()

----
 arch/arm/kernel/process.c                        |  24 ---
 arch/x86/include/asm/preempt.h                   |   2 +
 drivers/dma-buf/dma-buf.c                        |   8 +-
 drivers/dma-buf/reservation.c                    |  43 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |   6 +-
 drivers/gpu/drm/i915/i915_gem.c                  |  10 +-
 drivers/i2c/busses/i2c-exynos5.c                 |   4 +-
 drivers/i2c/busses/i2c-hix5hd2.c                 |   3 +-
 drivers/thermal/x86_pkg_temp_thermal.c           |  24 +--
 include/linux/cpu.h                              |   4 -
 include/linux/reservation.h                      |   4 +-
 include/linux/sched.h                            |  11 +-
 include/linux/stop_machine.h                     |   2 +
 init/init_task.c                                 |   4 +
 kernel/cpu.c                                     | 103 ++++------
 kernel/futex.c                                   | 230 +++++++++++++----------
 kernel/locking/rtmutex.c                         | 114 ++++++++---
 kernel/locking/rtmutex_common.h                  |   3 +
 kernel/locking/rwlock-rt.c                       |   6 +
 kernel/sched/core.c                              | 211 +++++++++------------
 kernel/sched/deadline.c                          |   4 +-
 kernel/sched/sched.h                             |   4 +
 kernel/stop_machine.c                            |   7 +-
 kernel/time/hrtimer.c                            |  14 +-
 kernel/time/posix-cpu-timers.c                   |   4 +-
 lib/smp_processor_id.c                           |   7 +-
 lib/ubsan.c                                      |  64 +++----
 localversion-rt                                  |   2 +-
 mm/kmemleak.c                                    |  72 +++----
 virt/kvm/arm/arch_timer.c                        |   6 +-
 30 files changed, 510 insertions(+), 490 deletions(-)
---------------------------
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 8d3c7ce34c24..82ab015bf42b 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -324,30 +324,6 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_MMU
-/*
- * CONFIG_SPLIT_PTLOCK_CPUS results in a page->ptl lock.  If the lock is not
- * initialized by pgtable_page_ctor() then a coredump of the vector page will
- * fail.
- */
-static int __init vectors_user_mapping_init_page(void)
-{
-	struct page *page;
-	unsigned long addr = 0xffff0000;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	pgd = pgd_offset_k(addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
-	page = pmd_page(*(pmd));
-
-	pgtable_page_ctor(page);
-
-	return 0;
-}
-late_initcall(vectors_user_mapping_init_page);
-
 #ifdef CONFIG_KUSER_HELPERS
 /*
  * The vectors page is always readable from user space for the
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index f66708779274..afa0e42ccdd1 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -96,6 +96,8 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	if (____preempt_count_dec_and_test())
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if (preempt_count())
+		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 69842145c223..4c3ef46e7149 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -179,7 +179,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 		return 0;
 
 retry:
-	seq = read_seqcount_begin(&resv->seq);
+	seq = read_seqbegin(&resv->seq);
 	rcu_read_lock();
 
 	fobj = rcu_dereference(resv->fence);
@@ -188,7 +188,7 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 	else
 		shared_count = 0;
 	fence_excl = rcu_dereference(resv->fence_excl);
-	if (read_seqcount_retry(&resv->seq, seq)) {
+	if (read_seqretry(&resv->seq, seq)) {
 		rcu_read_unlock();
 		goto retry;
 	}
@@ -1046,12 +1046,12 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 
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
index 49ab09468ba1..f11d58492216 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -109,8 +109,7 @@ reservation_object_add_shared_inplace(struct reservation_object *obj,
 
 	dma_fence_get(fence);
 
-	preempt_disable();
-	write_seqcount_begin(&obj->seq);
+	write_seqlock(&obj->seq);
 
 	for (i = 0; i < fobj->shared_count; ++i) {
 		struct dma_fence *old_fence;
@@ -121,8 +120,7 @@ reservation_object_add_shared_inplace(struct reservation_object *obj,
 		if (old_fence->context == fence->context) {
 			/* memory barrier is added by write_seqcount_begin */
 			RCU_INIT_POINTER(fobj->shared[i], fence);
-			write_seqcount_end(&obj->seq);
-			preempt_enable();
+			write_sequnlock(&obj->seq);
 
 			dma_fence_put(old_fence);
 			return;
@@ -146,8 +144,7 @@ reservation_object_add_shared_inplace(struct reservation_object *obj,
 		fobj->shared_count++;
 	}
 
-	write_seqcount_end(&obj->seq);
-	preempt_enable();
+	write_sequnlock(&obj->seq);
 
 	dma_fence_put(signaled);
 }
@@ -191,15 +188,13 @@ reservation_object_add_shared_replace(struct reservation_object *obj,
 	fobj->shared_count++;
 
 done:
-	preempt_disable();
-	write_seqcount_begin(&obj->seq);
+	write_seqlock(&obj->seq);
 	/*
 	 * RCU_INIT_POINTER can be used here,
 	 * seqcount provides the necessary barriers
 	 */
 	RCU_INIT_POINTER(obj->fence, fobj);
-	write_seqcount_end(&obj->seq);
-	preempt_enable();
+	write_sequnlock(&obj->seq);
 
 	if (!old)
 		return;
@@ -259,14 +254,11 @@ void reservation_object_add_excl_fence(struct reservation_object *obj,
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
@@ -349,13 +341,10 @@ int reservation_object_copy_fences(struct reservation_object *dst,
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
@@ -396,7 +385,7 @@ int reservation_object_get_fences_rcu(struct reservation_object *obj,
 		shared_count = i = 0;
 
 		rcu_read_lock();
-		seq = read_seqcount_begin(&obj->seq);
+		seq = read_seqbegin(&obj->seq);
 
 		fence_excl = rcu_dereference(obj->fence_excl);
 		if (fence_excl && !dma_fence_get_rcu(fence_excl))
@@ -445,7 +434,7 @@ int reservation_object_get_fences_rcu(struct reservation_object *obj,
 			}
 		}
 
-		if (i != shared_count || read_seqcount_retry(&obj->seq, seq)) {
+		if (i != shared_count || read_seqretry(&obj->seq, seq)) {
 			while (i--)
 				dma_fence_put(shared[i]);
 			dma_fence_put(fence_excl);
@@ -494,7 +483,7 @@ long reservation_object_wait_timeout_rcu(struct reservation_object *obj,
 
 retry:
 	shared_count = 0;
-	seq = read_seqcount_begin(&obj->seq);
+	seq = read_seqbegin(&obj->seq);
 	rcu_read_lock();
 	i = -1;
 
@@ -541,7 +530,7 @@ long reservation_object_wait_timeout_rcu(struct reservation_object *obj,
 
 	rcu_read_unlock();
 	if (fence) {
-		if (read_seqcount_retry(&obj->seq, seq)) {
+		if (read_seqretry(&obj->seq, seq)) {
 			dma_fence_put(fence);
 			goto retry;
 		}
@@ -597,7 +586,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
 retry:
 	ret = true;
 	shared_count = 0;
-	seq = read_seqcount_begin(&obj->seq);
+	seq = read_seqbegin(&obj->seq);
 
 	if (test_all) {
 		unsigned i;
@@ -618,7 +607,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
 				break;
 		}
 
-		if (read_seqcount_retry(&obj->seq, seq))
+		if (read_seqretry(&obj->seq, seq))
 			goto retry;
 	}
 
@@ -631,7 +620,7 @@ bool reservation_object_test_signaled_rcu(struct reservation_object *obj,
 			if (ret < 0)
 				goto retry;
 
-			if (read_seqcount_retry(&obj->seq, seq))
+			if (read_seqretry(&obj->seq, seq))
 				goto retry;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f92597c292fe..10c675850aac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -261,11 +261,9 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	}
 
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
index c7d05ac7af3c..d484e79316bf 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -516,7 +516,7 @@ i915_gem_object_wait_reservation(struct reservation_object *resv,
 				 long timeout,
 				 struct intel_rps_client *rps_client)
 {
-	unsigned int seq = __read_seqcount_begin(&resv->seq);
+	unsigned int seq = read_seqbegin(&resv->seq);
 	struct dma_fence *excl;
 	bool prune_fences = false;
 
@@ -569,9 +569,9 @@ i915_gem_object_wait_reservation(struct reservation_object *resv,
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
@@ -4615,7 +4615,7 @@ i915_gem_busy_ioctl(struct drm_device *dev, void *data,
 	 *
 	 */
 retry:
-	seq = raw_read_seqcount(&obj->resv->seq);
+	seq = read_seqbegin(&obj->resv->seq);
 
 	/* Translate the exclusive fence to the READ *and* WRITE engine */
 	args->busy = busy_check_writer(rcu_dereference(obj->resv->fence_excl));
@@ -4633,7 +4633,7 @@ i915_gem_busy_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	if (args->busy && read_seqcount_retry(&obj->resv->seq, seq))
+	if (args->busy && read_seqretry(&obj->resv->seq, seq))
 		goto retry;
 
 	err = 0;
diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index c1ce2299a76e..5c57ecf4b79e 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -800,9 +800,7 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
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
index 061a4bfb03f4..575aff50b19a 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -449,8 +449,7 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 	hix5hd2_i2c_init(priv);
 
 	ret = devm_request_irq(&pdev->dev, irq, hix5hd2_i2c_irq,
-			       IRQF_NO_SUSPEND | IRQF_ONESHOT,
-			       dev_name(&pdev->dev), priv);
+			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), priv);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot request HS-I2C IRQ %d\n", irq);
 		goto err_clk;
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 1ef937d799e4..540becb78a0f 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -75,7 +75,7 @@ static int max_packages __read_mostly;
 /* Array of package pointers */
 static struct pkg_device **packages;
 /* Serializes interrupt notification, work and hotplug */
-static DEFINE_SPINLOCK(pkg_temp_lock);
+static DEFINE_RAW_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
 static DEFINE_MUTEX(thermal_zone_mutex);
 
@@ -291,12 +291,12 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
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
@@ -310,7 +310,7 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 
 	enable_pkg_thres_interrupt();
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/*
 	 * If tzone is not NULL, then thermal_zone_mutex will prevent the
@@ -335,7 +335,7 @@ static int pkg_thermal_notify(u64 msr_val)
 	struct pkg_device *pkgdev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&pkg_temp_lock, flags);
+	raw_spin_lock_irqsave(&pkg_temp_lock, flags);
 	++pkg_interrupt_cnt;
 
 	disable_pkg_thres_interrupt();
@@ -347,7 +347,7 @@ static int pkg_thermal_notify(u64 msr_val)
 		pkg_thermal_schedule_work(pkgdev->cpu, &pkgdev->work);
 	}
 
-	spin_unlock_irqrestore(&pkg_temp_lock, flags);
+	raw_spin_unlock_irqrestore(&pkg_temp_lock, flags);
 	return 0;
 }
 
@@ -393,9 +393,9 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	      pkgdev->msr_pkg_therm_high);
 
 	cpumask_set_cpu(cpu, &pkgdev->cpumask);
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 	packages[pkgid] = pkgdev;
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 	return 0;
 }
 
@@ -432,7 +432,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	}
 
 	/* Protect against work and interrupts */
-	spin_lock_irq(&pkg_temp_lock);
+	raw_spin_lock_irq(&pkg_temp_lock);
 
 	/*
 	 * Check whether this cpu was the current target and store the new
@@ -464,9 +464,9 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
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
@@ -477,7 +477,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 			pkg_thermal_schedule_work(target, &pkgdev->work);
 	}
 
-	spin_unlock_irq(&pkg_temp_lock);
+	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
 	if (lastcpu)
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index e67645924404..87347ccbba0c 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -118,8 +118,6 @@ extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int cpu_down(unsigned int cpu);
-extern void pin_current_cpu(void);
-extern void unpin_current_cpu(void);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
@@ -131,8 +129,6 @@ static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
-static inline void pin_current_cpu(void) { }
-static inline void unpin_current_cpu(void) { }
 
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
diff --git a/include/linux/reservation.h b/include/linux/reservation.h
index 02166e815afb..0b31df1af698 100644
--- a/include/linux/reservation.h
+++ b/include/linux/reservation.h
@@ -72,7 +72,7 @@ struct reservation_object_list {
  */
 struct reservation_object {
 	struct ww_mutex lock;
-	seqcount_t seq;
+	seqlock_t seq;
 
 	struct dma_fence __rcu *fence_excl;
 	struct reservation_object_list __rcu *fence;
@@ -92,7 +92,7 @@ reservation_object_init(struct reservation_object *obj)
 {
 	ww_mutex_init(&obj->lock, &reservation_ww_class);
 
-	__seqcount_init(&obj->seq, reservation_seqcount_string, &reservation_seqcount_class);
+	seqlock_init(&obj->seq);
 	RCU_INIT_POINTER(obj->fence, NULL);
 	RCU_INIT_POINTER(obj->fence_excl, NULL);
 	obj->staged = NULL;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c213ec3d3b5..392a1ed7efd2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -227,6 +227,8 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
+int cpu_nr_pinned(int cpu);
+
 /**
  * struct prev_cputime - snapshot of system and user cputime
  * @utime: time spent in user mode
@@ -670,16 +672,13 @@ struct task_struct {
 	cpumask_t			cpus_mask;
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	int				migrate_disable;
-	int				migrate_disable_update;
-	int				pinned_on_cpu;
+	bool				migrate_disable_scheduled;
 # ifdef CONFIG_SCHED_DEBUG
-	int				migrate_disable_atomic;
+	int				pinned_on_cpu;
 # endif
-
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 # ifdef CONFIG_SCHED_DEBUG
 	int				migrate_disable;
-	int				migrate_disable_atomic;
 # endif
 #endif
 #ifdef CONFIG_PREEMPT_RT_FULL
@@ -2058,4 +2057,6 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+extern struct task_struct *takedown_cpu_task;
+
 #endif
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 6d3635c86dbe..82fc686ddd9e 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -26,6 +26,8 @@ struct cpu_stop_work {
 	cpu_stop_fn_t		fn;
 	void			*arg;
 	struct cpu_stop_done	*done;
+	/* Did not run due to disabled stopper; for nowait debug checks */
+	bool			disabled;
 };
 
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
diff --git a/init/init_task.c b/init/init_task.c
index 9e3362748214..4e5af4616dbd 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -80,6 +80,10 @@ struct task_struct init_task
 	.cpus_ptr	= &init_task.cpus_mask,
 	.cpus_mask	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE) && \
+    defined(CONFIG_SCHED_DEBUG)
+	.pinned_on_cpu	= -1,
+#endif
 	.mm		= NULL,
 	.active_mm	= &init_mm,
 	.restart_block	= {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 00dac381da2e..b9d7ac61d707 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -75,11 +75,6 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 	.fail = CPUHP_INVALID,
 };
 
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PREEMPT_RT_FULL)
-static DEFINE_PER_CPU(struct rt_rw_lock, cpuhp_pin_lock) = \
-	__RWLOCK_RT_INITIALIZER(cpuhp_pin_lock);
-#endif
-
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -286,55 +281,6 @@ static int cpu_hotplug_disabled;
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/**
- * pin_current_cpu - Prevent the current cpu from being unplugged
- */
-void pin_current_cpu(void)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin;
-	unsigned int cpu;
-	int ret;
-
-again:
-	cpuhp_pin = this_cpu_ptr(&cpuhp_pin_lock);
-	ret = __read_rt_trylock(cpuhp_pin);
-	if (ret) {
-		current->pinned_on_cpu = smp_processor_id();
-		return;
-	}
-	cpu = smp_processor_id();
-	preempt_lazy_enable();
-	preempt_enable();
-
-	__read_rt_lock(cpuhp_pin);
-
-	preempt_disable();
-	preempt_lazy_disable();
-	if (cpu != smp_processor_id()) {
-		__read_rt_unlock(cpuhp_pin);
-		goto again;
-	}
-	current->pinned_on_cpu = cpu;
-#endif
-}
-
-/**
- * unpin_current_cpu - Allow unplug of current cpu
- */
-void unpin_current_cpu(void)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin = this_cpu_ptr(&cpuhp_pin_lock);
-
-	if (WARN_ON(current->pinned_on_cpu != smp_processor_id()))
-		cpuhp_pin = per_cpu_ptr(&cpuhp_pin_lock, current->pinned_on_cpu);
-
-	current->pinned_on_cpu = -1;
-	__read_rt_unlock(cpuhp_pin);
-#endif
-}
-
 DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
 
 void cpus_read_lock(void)
@@ -864,6 +810,15 @@ static int take_cpu_down(void *_param)
 	int err, cpu = smp_processor_id();
 	int ret;
 
+#ifdef CONFIG_PREEMPT_RT_BASE
+	/*
+	 * If any tasks disabled migration before we got here,
+	 * go back and sleep again.
+	 */
+	if (cpu_nr_pinned(cpu))
+		return -EAGAIN;
+#endif
+
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
@@ -891,11 +846,12 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
+#ifdef CONFIG_PREEMPT_RT_BASE
+struct task_struct *takedown_cpu_task;
+#endif
+
 static int takedown_cpu(unsigned int cpu)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin = per_cpu_ptr(&cpuhp_pin_lock, cpu);
-#endif
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	int err;
 
@@ -908,17 +864,38 @@ static int takedown_cpu(unsigned int cpu)
 	 */
 	irq_lock_sparse();
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	__write_rt_lock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+	WARN_ON_ONCE(takedown_cpu_task);
+	takedown_cpu_task = current;
+
+again:
+	/*
+	 * If a task pins this CPU after we pass this check, take_cpu_down
+	 * will return -EAGAIN.
+	 */
+	for (;;) {
+		int nr_pinned;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		nr_pinned = cpu_nr_pinned(cpu);
+		if (nr_pinned == 0)
+			break;
+		schedule();
+	}
+	set_current_state(TASK_RUNNING);
 #endif
 
 	/*
 	 * So now all preempt/rcu users must observe !cpu_active().
 	 */
 	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
+#ifdef CONFIG_PREEMPT_RT_BASE
+	if (err == -EAGAIN)
+		goto again;
+#endif
 	if (err) {
-#ifdef CONFIG_PREEMPT_RT_FULL
-		__write_rt_unlock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+		takedown_cpu_task = NULL;
 #endif
 		/* CPU refused to die */
 		irq_unlock_sparse();
@@ -938,8 +915,8 @@ static int takedown_cpu(unsigned int cpu)
 	wait_for_ap_thread(st, false);
 	BUG_ON(st->state != CPUHP_AP_IDLE_DEAD);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	__write_rt_unlock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+	takedown_cpu_task = NULL;
 #endif
 	/* Interrupts are moved away from the dying cpu, reenable alloc/free */
 	irq_unlock_sparse();
diff --git a/kernel/futex.c b/kernel/futex.c
index 0b8cff8d9162..e815cf542b82 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -243,7 +243,7 @@ struct futex_q {
 	struct plist_node list;
 
 	struct task_struct *task;
-	raw_spinlock_t *lock_ptr;
+	spinlock_t *lock_ptr;
 	union futex_key key;
 	struct futex_pi_state *pi_state;
 	struct rt_mutex_waiter *rt_waiter;
@@ -264,7 +264,7 @@ static const struct futex_q futex_q_init = {
  */
 struct futex_hash_bucket {
 	atomic_t waiters;
-	raw_spinlock_t lock;
+	spinlock_t lock;
 	struct plist_head chain;
 } ____cacheline_aligned_in_smp;
 
@@ -825,13 +825,13 @@ static void get_pi_state(struct futex_pi_state *pi_state)
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
  */
-static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
+static void put_pi_state(struct futex_pi_state *pi_state)
 {
 	if (!pi_state)
-		return NULL;
+		return;
 
 	if (!atomic_dec_and_test(&pi_state->refcount))
-		return NULL;
+		return;
 
 	/*
 	 * If pi_state->owner is NULL, the owner is most probably dying
@@ -851,7 +851,9 @@ static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
 
-	if (!current->pi_state_cache) {
+	if (current->pi_state_cache) {
+		kfree(pi_state);
+	} else {
 		/*
 		 * pi_state->list is already empty.
 		 * clear pi_state->owner.
@@ -860,30 +862,6 @@ static struct futex_pi_state *__put_pi_state(struct futex_pi_state *pi_state)
 		pi_state->owner = NULL;
 		atomic_set(&pi_state->refcount, 1);
 		current->pi_state_cache = pi_state;
-		pi_state = NULL;
-	}
-	return pi_state;
-}
-
-static void put_pi_state(struct futex_pi_state *pi_state)
-{
-	kfree(__put_pi_state(pi_state));
-}
-
-static void put_pi_state_atomic(struct futex_pi_state *pi_state,
-				struct list_head *to_free)
-{
-	if (__put_pi_state(pi_state))
-		list_add(&pi_state->list, to_free);
-}
-
-static void free_pi_state_list(struct list_head *to_free)
-{
-	struct futex_pi_state *p, *next;
-
-	list_for_each_entry_safe(p, next, to_free, list) {
-		list_del(&p->list);
-		kfree(p);
 	}
 }
 
@@ -900,7 +878,6 @@ void exit_pi_state_list(struct task_struct *curr)
 	struct futex_pi_state *pi_state;
 	struct futex_hash_bucket *hb;
 	union futex_key key = FUTEX_KEY_INIT;
-	LIST_HEAD(to_free);
 
 	if (!futex_cmpxchg_enabled)
 		return;
@@ -934,7 +911,7 @@ void exit_pi_state_list(struct task_struct *curr)
 		}
 		raw_spin_unlock_irq(&curr->pi_lock);
 
-		raw_spin_lock(&hb->lock);
+		spin_lock(&hb->lock);
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 		raw_spin_lock(&curr->pi_lock);
 		/*
@@ -944,8 +921,10 @@ void exit_pi_state_list(struct task_struct *curr)
 		if (head->next != next) {
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
-			raw_spin_unlock(&hb->lock);
-			put_pi_state_atomic(pi_state, &to_free);
+			raw_spin_unlock_irq(&curr->pi_lock);
+			spin_unlock(&hb->lock);
+			raw_spin_lock_irq(&curr->pi_lock);
+			put_pi_state(pi_state);
 			continue;
 		}
 
@@ -956,7 +935,7 @@ void exit_pi_state_list(struct task_struct *curr)
 
 		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		raw_spin_unlock(&hb->lock);
+		spin_unlock(&hb->lock);
 
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
@@ -964,8 +943,6 @@ void exit_pi_state_list(struct task_struct *curr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
-
-	free_pi_state_list(&to_free);
 }
 
 #endif
@@ -1452,7 +1429,7 @@ static void __unqueue_futex(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
-	if (WARN_ON_SMP(!q->lock_ptr || !raw_spin_is_locked(q->lock_ptr))
+	if (WARN_ON_SMP(!q->lock_ptr || !spin_is_locked(q->lock_ptr))
 	    || WARN_ON(plist_node_empty(&q->list)))
 		return;
 
@@ -1580,21 +1557,21 @@ static inline void
 double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
 	if (hb1 <= hb2) {
-		raw_spin_lock(&hb1->lock);
+		spin_lock(&hb1->lock);
 		if (hb1 < hb2)
-			raw_spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
+			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
 	} else { /* hb1 > hb2 */
-		raw_spin_lock(&hb2->lock);
-		raw_spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
+		spin_lock(&hb2->lock);
+		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
 	}
 }
 
 static inline void
 double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 {
-	raw_spin_unlock(&hb1->lock);
+	spin_unlock(&hb1->lock);
 	if (hb1 != hb2)
-		raw_spin_unlock(&hb2->lock);
+		spin_unlock(&hb2->lock);
 }
 
 /*
@@ -1622,7 +1599,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if (!hb_waiters_pending(hb))
 		goto out_put_key;
 
-	raw_spin_lock(&hb->lock);
+	spin_lock(&hb->lock);
 
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
 		if (match_futex (&this->key, &key)) {
@@ -1641,7 +1618,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 		}
 	}
 
-	raw_spin_unlock(&hb->lock);
+	spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
 out_put_key:
 	put_futex_key(&key);
@@ -1948,7 +1925,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
-	LIST_HEAD(to_free);
 
 	if (nr_wake < 0 || nr_requeue < 0)
 		return -EINVAL;
@@ -2176,6 +2152,16 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				requeue_pi_wake_futex(this, &key2, hb2);
 				drop_count++;
 				continue;
+			} else if (ret == -EAGAIN) {
+				/*
+				 * Waiter was woken by timeout or
+				 * signal and has set pi_blocked_on to
+				 * PI_WAKEUP_INPROGRESS before we
+				 * tried to enqueue it on the rtmutex.
+				 */
+				this->pi_state = NULL;
+				put_pi_state(pi_state);
+				continue;
 			} else if (ret) {
 				/*
 				 * rt_mutex_start_proxy_lock() detected a
@@ -2186,7 +2172,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				 * object.
 				 */
 				this->pi_state = NULL;
-				put_pi_state_atomic(pi_state, &to_free);
+				put_pi_state(pi_state);
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.
@@ -2203,7 +2189,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
 	 * need to drop it here again.
 	 */
-	put_pi_state_atomic(pi_state, &to_free);
+	put_pi_state(pi_state);
 
 out_unlock:
 	double_unlock_hb(hb1, hb2);
@@ -2224,7 +2210,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 out_put_key1:
 	put_futex_key(&key1);
 out:
-	free_pi_state_list(&to_free);
 	return ret ? ret : task_count;
 }
 
@@ -2248,7 +2233,7 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 
 	q->lock_ptr = &hb->lock;
 
-	raw_spin_lock(&hb->lock); /* implies smp_mb(); (A) */
+	spin_lock(&hb->lock); /* implies smp_mb(); (A) */
 	return hb;
 }
 
@@ -2256,7 +2241,7 @@ static inline void
 queue_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	raw_spin_unlock(&hb->lock);
+	spin_unlock(&hb->lock);
 	hb_waiters_dec(hb);
 }
 
@@ -2295,7 +2280,7 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	__queue_me(q, hb);
-	raw_spin_unlock(&hb->lock);
+	spin_unlock(&hb->lock);
 }
 
 /**
@@ -2311,41 +2296,41 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
  */
 static int unqueue_me(struct futex_q *q)
 {
-	raw_spinlock_t *lock_ptr;
+	spinlock_t *lock_ptr;
 	int ret = 0;
 
 	/* In the common case we don't take the spinlock, which is nice. */
 retry:
 	/*
-	 * q->lock_ptr can change between this read and the following
-	 * raw_spin_lock. Use READ_ONCE to forbid the compiler from reloading
-	 * q->lock_ptr and optimizing lock_ptr out of the logic below.
+	 * q->lock_ptr can change between this read and the following spin_lock.
+	 * Use READ_ONCE to forbid the compiler from reloading q->lock_ptr and
+	 * optimizing lock_ptr out of the logic below.
 	 */
 	lock_ptr = READ_ONCE(q->lock_ptr);
 	if (lock_ptr != NULL) {
-		raw_spin_lock(lock_ptr);
+		spin_lock(lock_ptr);
 		/*
 		 * q->lock_ptr can change between reading it and
-		 * raw_spin_lock(), causing us to take the wrong lock.  This
+		 * spin_lock(), causing us to take the wrong lock.  This
 		 * corrects the race condition.
 		 *
 		 * Reasoning goes like this: if we have the wrong lock,
 		 * q->lock_ptr must have changed (maybe several times)
-		 * between reading it and the raw_spin_lock().  It can
-		 * change again after the raw_spin_lock() but only if it was
-		 * already changed before the raw_spin_lock().  It cannot,
+		 * between reading it and the spin_lock().  It can
+		 * change again after the spin_lock() but only if it was
+		 * already changed before the spin_lock().  It cannot,
 		 * however, change back to the original value.  Therefore
 		 * we can detect whether we acquired the correct lock.
 		 */
 		if (unlikely(lock_ptr != q->lock_ptr)) {
-			raw_spin_unlock(lock_ptr);
+			spin_unlock(lock_ptr);
 			goto retry;
 		}
 		__unqueue_futex(q);
 
 		BUG_ON(q->pi_state);
 
-		raw_spin_unlock(lock_ptr);
+		spin_unlock(lock_ptr);
 		ret = 1;
 	}
 
@@ -2361,16 +2346,13 @@ static int unqueue_me(struct futex_q *q)
 static void unqueue_me_pi(struct futex_q *q)
 	__releases(q->lock_ptr)
 {
-	struct futex_pi_state *ps;
-
 	__unqueue_futex(q);
 
 	BUG_ON(!q->pi_state);
-	ps = __put_pi_state(q->pi_state);
+	put_pi_state(q->pi_state);
 	q->pi_state = NULL;
 
-	raw_spin_unlock(q->lock_ptr);
-	kfree(ps);
+	spin_unlock(q->lock_ptr);
 }
 
 static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
@@ -2503,7 +2485,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 */
 handle_err:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	raw_spin_unlock(q->lock_ptr);
+	spin_unlock(q->lock_ptr);
 
 	switch (err) {
 	case -EFAULT:
@@ -2521,7 +2503,7 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 		break;
 	}
 
-	raw_spin_lock(q->lock_ptr);
+	spin_lock(q->lock_ptr);
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	/*
@@ -2617,7 +2599,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	/*
 	 * The task state is guaranteed to be set before another task can
 	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * queue_me() calls raw_spin_unlock() upon completion, both serializing
+	 * queue_me() calls spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -2908,7 +2890,15 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	raw_spin_unlock(q.lock_ptr);
+	/*
+	 * the migrate_disable() here disables migration in the in_atomic() fast
+	 * path which is enabled again in the following spin_unlock(). We have
+	 * one migrate_disable() pending in the slow-path which is reversed
+	 * after the raw_spin_unlock_irq() where we leave the atomic context.
+	 */
+	migrate_disable();
+
+	spin_unlock(q.lock_ptr);
 	/*
 	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
 	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
@@ -2916,6 +2906,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
+	migrate_enable();
 
 	if (ret) {
 		if (ret == 1)
@@ -2929,7 +2920,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
 cleanup:
-	raw_spin_lock(q.lock_ptr);
+	spin_lock(q.lock_ptr);
 	/*
 	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
@@ -3030,7 +3021,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return ret;
 
 	hb = hash_futex(&key);
-	raw_spin_lock(&hb->lock);
+	spin_lock(&hb->lock);
 
 	/*
 	 * Check waiters first. We do not trust user space values at
@@ -3064,10 +3055,19 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * rt_waiter. Also see the WARN in wake_futex_pi().
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		raw_spin_unlock(&hb->lock);
+		/*
+		 * Magic trickery for now to make the RT migrate disable
+		 * logic happy. The following spin_unlock() happens with
+		 * interrupts disabled so the internal migrate_enable()
+		 * won't undo the migrate_disable() which was issued when
+		 * locking hb->lock.
+		 */
+		migrate_disable();
+		spin_unlock(&hb->lock);
 
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
+		migrate_enable();
 
 		put_pi_state(pi_state);
 
@@ -3103,7 +3103,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * owner.
 	 */
 	if ((ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
-		raw_spin_unlock(&hb->lock);
+		spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
 			goto pi_faulted;
@@ -3123,7 +3123,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	ret = (curval == uval) ? 0 : -EAGAIN;
 
 out_unlock:
-	raw_spin_unlock(&hb->lock);
+	spin_unlock(&hb->lock);
 out_putkey:
 	put_futex_key(&key);
 	return ret;
@@ -3239,7 +3239,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	struct hrtimer_sleeper timeout, *to = NULL;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
+	struct futex_hash_bucket *hb, *hb2;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -3297,20 +3297,55 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
 	futex_wait_queue_me(hb, &q, to);
 
-	raw_spin_lock(&hb->lock);
-	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
-	raw_spin_unlock(&hb->lock);
-	if (ret)
-		goto out_put_keys;
+	/*
+	 * On RT we must avoid races with requeue and trying to block
+	 * on two mutexes (hb->lock and uaddr2's rtmutex) by
+	 * serializing access to pi_blocked_on with pi_lock.
+	 */
+	raw_spin_lock_irq(&current->pi_lock);
+	if (current->pi_blocked_on) {
+		/*
+		 * We have been requeued or are in the process of
+		 * being requeued.
+		 */
+		raw_spin_unlock_irq(&current->pi_lock);
+	} else {
+		/*
+		 * Setting pi_blocked_on to PI_WAKEUP_INPROGRESS
+		 * prevents a concurrent requeue from moving us to the
+		 * uaddr2 rtmutex. After that we can safely acquire
+		 * (and possibly block on) hb->lock.
+		 */
+		current->pi_blocked_on = PI_WAKEUP_INPROGRESS;
+		raw_spin_unlock_irq(&current->pi_lock);
+
+		spin_lock(&hb->lock);
+
+		/*
+		 * Clean up pi_blocked_on. We might leak it otherwise
+		 * when we succeeded with the hb->lock in the fast
+		 * path.
+		 */
+		raw_spin_lock_irq(&current->pi_lock);
+		current->pi_blocked_on = NULL;
+		raw_spin_unlock_irq(&current->pi_lock);
+
+		ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+		spin_unlock(&hb->lock);
+		if (ret)
+			goto out_put_keys;
+	}
 
 	/*
-	 * In order for us to be here, we know our q.key == key2, and since
-	 * we took the hb->lock above, we also know that futex_requeue() has
-	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code. The
-	 * futex_requeue dropped our key1 reference and incremented our key2
-	 * reference count.
+	 * In order to be here, we have either been requeued, are in
+	 * the process of being requeued, or requeue successfully
+	 * acquired uaddr2 on our behalf.  If pi_blocked_on was
+	 * non-null above, we may be racing with a requeue.  Do not
+	 * rely on q->lock_ptr to be hb2->lock until after blocking on
+	 * hb->lock or hb2->lock. The futex_requeue dropped our key1
+	 * reference and incremented our key2 reference count.
 	 */
+	hb2 = hash_futex(&key2);
 
 	/* Check if the requeue code acquired the second futex for us. */
 	if (!q.rt_waiter) {
@@ -3319,9 +3354,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * did a lock-steal - fix up the PI-state in that case.
 		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
-			struct futex_pi_state *ps_free;
-
-			raw_spin_lock(q.lock_ptr);
+			spin_lock(&hb2->lock);
+			BUG_ON(&hb2->lock != q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
 			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
 				pi_state = q.pi_state;
@@ -3331,9 +3365,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
 			 */
-			ps_free = __put_pi_state(q.pi_state);
-			raw_spin_unlock(q.lock_ptr);
-			kfree(ps_free);
+			put_pi_state(q.pi_state);
+			spin_unlock(&hb2->lock);
 		}
 	} else {
 		struct rt_mutex *pi_mutex;
@@ -3347,7 +3380,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		raw_spin_lock(q.lock_ptr);
+		spin_lock(&hb2->lock);
+		BUG_ON(&hb2->lock != q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
@@ -4014,7 +4048,7 @@ static int __init futex_init(void)
 	for (i = 0; i < futex_hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
-		raw_spin_lock_init(&futex_queues[i].lock);
+		spin_lock_init(&futex_queues[i].lock);
 	}
 
 	return 0;
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 44a33057a83a..c7d3ae01b4e5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -142,6 +142,12 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
+static int rt_mutex_real_waiter(struct rt_mutex_waiter *waiter)
+{
+	return waiter && waiter != PI_WAKEUP_INPROGRESS &&
+		waiter != PI_REQUEUE_INPROGRESS;
+}
+
 /*
  * We can speed up the acquire/release, if there's no debugging state to be
  * set up.
@@ -415,7 +421,8 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
+	return rt_mutex_real_waiter(p->pi_blocked_on) ?
+		p->pi_blocked_on->lock : NULL;
 }
 
 /*
@@ -551,7 +558,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * reached or the state of the chain has changed while we
 	 * dropped the locks.
 	 */
-	if (!waiter)
+	if (!rt_mutex_real_waiter(waiter))
 		goto out_unlock_pi;
 
 	/*
@@ -1135,6 +1142,7 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1150,6 +1158,7 @@ void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1163,6 +1172,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
@@ -1194,6 +1204,7 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -1210,6 +1221,7 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		sleeping_lock_inc();
+		rcu_read_lock();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	} else
@@ -1226,6 +1238,7 @@ int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		sleeping_lock_inc();
+		rcu_read_lock();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	}
@@ -1321,6 +1334,22 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		return -EDEADLK;
 
 	raw_spin_lock(&task->pi_lock);
+	/*
+	 * In the case of futex requeue PI, this will be a proxy
+	 * lock. The task will wake unaware that it is enqueueed on
+	 * this lock. Avoid blocking on two locks and corrupting
+	 * pi_blocked_on via the PI_WAKEUP_INPROGRESS
+	 * flag. futex_wait_requeue_pi() sets this when it wakes up
+	 * before requeue (due to a signal or timeout). Do not enqueue
+	 * the task if PI_WAKEUP_INPROGRESS is set.
+	 */
+	if (task != current && task->pi_blocked_on == PI_WAKEUP_INPROGRESS) {
+		raw_spin_unlock(&task->pi_lock);
+		return -EAGAIN;
+	}
+
+       BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));
+
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter->prio = task->prio;
@@ -1344,7 +1373,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		rt_mutex_enqueue_pi(owner, waiter);
 
 		rt_mutex_adjust_prio(owner);
-		if (owner->pi_blocked_on)
+		if (rt_mutex_real_waiter(owner->pi_blocked_on))
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
@@ -1444,7 +1473,7 @@ static void remove_waiter(struct rt_mutex *lock,
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock;
+	struct rt_mutex *next_lock = NULL;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1470,7 +1499,8 @@ static void remove_waiter(struct rt_mutex *lock,
 	rt_mutex_adjust_prio(owner);
 
 	/* Store the lock on which owner is blocked or NULL */
-	next_lock = task_blocked_on_lock(owner);
+	if (rt_mutex_real_waiter(owner->pi_blocked_on))
+		next_lock = task_blocked_on_lock(owner);
 
 	raw_spin_unlock(&owner->pi_lock);
 
@@ -1506,7 +1536,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!rt_mutex_real_waiter(waiter) ||
+	    rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
@@ -2295,6 +2326,26 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 	rt_mutex_set_owner(lock, NULL);
 }
 
+static void fixup_rt_mutex_blocked(struct rt_mutex *lock)
+{
+	struct task_struct *tsk = current;
+	/*
+	 * RT has a problem here when the wait got interrupted by a timeout
+	 * or a signal. task->pi_blocked_on is still set. The task must
+	 * acquire the hash bucket lock when returning from this function.
+	 *
+	 * If the hash bucket lock is contended then the
+	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
+	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
+	 * clearing task->pi_blocked_on which removes the task from the
+	 * boosting chain of the rtmutex. That's correct because the task
+	 * is not longer blocked on it.
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	tsk->pi_blocked_on = NULL;
+	raw_spin_unlock(&tsk->pi_lock);
+}
+
 /**
  * __rt_mutex_start_proxy_lock() - Start lock acquisition for another task
  * @lock:		the rt_mutex to take
@@ -2325,6 +2376,34 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/*
+	 * In PREEMPT_RT there's an added race.
+	 * If the task, that we are about to requeue, times out,
+	 * it can set the PI_WAKEUP_INPROGRESS. This tells the requeue
+	 * to skip this task. But right after the task sets
+	 * its pi_blocked_on to PI_WAKEUP_INPROGRESS it can then
+	 * block on the spin_lock(&hb->lock), which in RT is an rtmutex.
+	 * This will replace the PI_WAKEUP_INPROGRESS with the actual
+	 * lock that it blocks on. We *must not* place this task
+	 * on this proxy lock in that case.
+	 *
+	 * To prevent this race, we first take the task's pi_lock
+	 * and check if it has updated its pi_blocked_on. If it has,
+	 * we assume that it woke up and we return -EAGAIN.
+	 * Otherwise, we set the task's pi_blocked_on to
+	 * PI_REQUEUE_INPROGRESS, so that if the task is waking up
+	 * it will know that we are in the process of requeuing it.
+	 */
+	raw_spin_lock(&task->pi_lock);
+	if (task->pi_blocked_on) {
+		raw_spin_unlock(&task->pi_lock);
+		return -EAGAIN;
+	}
+	task->pi_blocked_on = PI_REQUEUE_INPROGRESS;
+	raw_spin_unlock(&task->pi_lock);
+#endif
+
 	/* We enforce deadlock detection for futexes */
 	ret = task_blocks_on_rt_mutex(lock, waiter, task,
 				      RT_MUTEX_FULL_CHAINWALK);
@@ -2339,6 +2418,9 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
+	if (ret)
+		fixup_rt_mutex_blocked(lock);
+
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
@@ -2419,7 +2501,6 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
-	struct task_struct *tsk = current;
 	int ret;
 
 	raw_spin_lock_irq(&lock->wait_lock);
@@ -2431,23 +2512,8 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 	 * have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
-	/*
-	 * RT has a problem here when the wait got interrupted by a timeout
-	 * or a signal. task->pi_blocked_on is still set. The task must
-	 * acquire the hash bucket lock when returning from this function.
-	 *
-	 * If the hash bucket lock is contended then the
-	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
-	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
-	 * clearing task->pi_blocked_on which removes the task from the
-	 * boosting chain of the rtmutex. That's correct because the task
-	 * is not longer blocked on it.
-	 */
-	if (ret) {
-		raw_spin_lock(&tsk->pi_lock);
-		tsk->pi_blocked_on = NULL;
-		raw_spin_unlock(&tsk->pi_lock);
-	}
+	if (ret)
+		fixup_rt_mutex_blocked(lock);
 
 	raw_spin_unlock_irq(&lock->wait_lock);
 
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 758dc43872e5..546aaf058b9e 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -132,6 +132,9 @@ enum rtmutex_chainwalk {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
+#define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
+#define PI_REQUEUE_INPROGRESS	((struct rt_mutex_waiter *) 2)
+
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index c3b91205161c..0ae8c62ea832 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -310,6 +310,7 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 	ret = do_read_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -327,6 +328,7 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 	ret = do_write_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -338,6 +340,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 void __lockfunc rt_read_lock(rwlock_t *rwlock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_read_rt_lock(rwlock);
@@ -347,6 +350,7 @@ EXPORT_SYMBOL(rt_read_lock);
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_write_rt_lock(rwlock);
@@ -358,6 +362,7 @@ void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_read_rt_unlock(rwlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_read_unlock);
@@ -367,6 +372,7 @@ void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_write_rt_unlock(rwlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_write_unlock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1c0123e7636..4616c086dd26 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -990,6 +990,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 struct migration_arg {
 	struct task_struct *task;
 	int dest_cpu;
+	bool done;
 };
 
 /*
@@ -1025,6 +1026,11 @@ static int migration_cpu_stop(void *data)
 	struct task_struct *p = arg->task;
 	struct rq *rq = this_rq();
 	struct rq_flags rf;
+	int dest_cpu = arg->dest_cpu;
+
+	/* We don't look at arg after this point. */
+	smp_mb();
+	arg->done = true;
 
 	/*
 	 * The original target CPU might have gone down and we might
@@ -1047,9 +1053,9 @@ static int migration_cpu_stop(void *data)
 	 */
 	if (task_rq(p) == rq) {
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
+			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
-			p->wake_cpu = arg->dest_cpu;
+			p->wake_cpu = dest_cpu;
 	}
 	rq_unlock(rq, &rf);
 	raw_spin_unlock(&p->pi_lock);
@@ -1065,7 +1071,8 @@ static int migration_cpu_stop(void *data)
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
 {
 	cpumask_copy(&p->cpus_mask, new_mask);
-	p->nr_cpus_allowed = cpumask_weight(new_mask);
+	if (p->cpus_ptr == &p->cpus_mask)
+		p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
@@ -1076,8 +1083,7 @@ int __migrate_disabled(struct task_struct *p)
 EXPORT_SYMBOL_GPL(__migrate_disabled);
 #endif
 
-static void __do_set_cpus_allowed_tail(struct task_struct *p,
-				       const struct cpumask *new_mask)
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -1106,20 +1112,6 @@ static void __do_set_cpus_allowed_tail(struct task_struct *p,
 		set_curr_task(rq, p);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	if (__migrate_disabled(p)) {
-		lockdep_assert_held(&p->pi_lock);
-
-		cpumask_copy(&p->cpus_mask, new_mask);
-		p->migrate_disable_update = 1;
-		return;
-	}
-#endif
-	__do_set_cpus_allowed_tail(p, new_mask);
-}
-
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -1157,7 +1149,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(p->cpus_ptr, new_mask))
+	if (cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
@@ -1179,15 +1171,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	}
 
 	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
-		goto out;
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	if (__migrate_disabled(p)) {
-		p->migrate_disable_update = 1;
+	if (cpumask_test_cpu(task_cpu(p), new_mask) ||
+	    p->cpus_ptr != &p->cpus_mask)
 		goto out;
-	}
-#endif
 
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
@@ -3461,6 +3447,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG();
 }
 
+static void migrate_disabled_sched(struct task_struct *p);
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -3531,6 +3519,9 @@ static void __sched notrace __schedule(bool preempt)
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
 
+	if (__migrate_disabled(prev))
+		migrate_disabled_sched(prev);
+
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
@@ -5786,6 +5777,8 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 		BUG_ON(!next);
 		put_prev_task(rq, next);
 
+		WARN_ON_ONCE(__migrate_disabled(next));
+
 		/*
 		 * Rules for changing task_struct::cpus_mask are holding
 		 * both pi_lock and rq->lock, such that holding either
@@ -7254,15 +7247,9 @@ update_nr_migratory(struct task_struct *p, long delta)
 static inline void
 migrate_disable_update_cpus_allowed(struct task_struct *p)
 {
-	struct rq *rq;
-	struct rq_flags rf;
-
 	p->cpus_ptr = cpumask_of(smp_processor_id());
-
-	rq = task_rq_lock(p, &rf);
 	update_nr_migratory(p, -1);
 	p->nr_cpus_allowed = 1;
-	task_rq_unlock(rq, p, &rf);
 }
 
 static inline void
@@ -7271,9 +7258,8 @@ migrate_enable_update_cpus_allowed(struct task_struct *p)
 	struct rq *rq;
 	struct rq_flags rf;
 
-	p->cpus_ptr = &p->cpus_mask;
-
 	rq = task_rq_lock(p, &rf);
+	p->cpus_ptr = &p->cpus_mask;
 	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
 	update_nr_migratory(p, 1);
 	task_rq_unlock(rq, p, &rf);
@@ -7281,54 +7267,35 @@ migrate_enable_update_cpus_allowed(struct task_struct *p)
 
 void migrate_disable(void)
 {
-	struct task_struct *p = current;
+	preempt_disable();
 
-	if (in_atomic() || irqs_disabled()) {
+	if (++current->migrate_disable == 1) {
+		this_rq()->nr_pinned++;
+		preempt_lazy_disable();
 #ifdef CONFIG_SCHED_DEBUG
-		p->migrate_disable_atomic++;
+		WARN_ON_ONCE(current->pinned_on_cpu >= 0);
+		current->pinned_on_cpu = smp_processor_id();
 #endif
-		return;
 	}
-#ifdef CONFIG_SCHED_DEBUG
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-#endif
 
-	if (p->migrate_disable) {
-		p->migrate_disable++;
-		return;
-	}
+	preempt_enable();
+}
+EXPORT_SYMBOL(migrate_disable);
 
-	preempt_disable();
-	preempt_lazy_disable();
-	pin_current_cpu();
+static void migrate_disabled_sched(struct task_struct *p)
+{
+	if (p->migrate_disable_scheduled)
+		return;
 
 	migrate_disable_update_cpus_allowed(p);
-	p->migrate_disable = 1;
-
-	preempt_enable();
+	p->migrate_disable_scheduled = 1;
 }
-EXPORT_SYMBOL(migrate_disable);
 
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
-
-	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
-		p->migrate_disable_atomic--;
-#endif
-		return;
-	}
-
-#ifdef CONFIG_SCHED_DEBUG
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-#endif
+	struct rq *rq = this_rq();
+	int cpu = task_cpu(p);
 
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	if (p->migrate_disable > 1) {
@@ -7338,69 +7305,71 @@ void migrate_enable(void)
 
 	preempt_disable();
 
+#ifdef CONFIG_SCHED_DEBUG
+	WARN_ON_ONCE(current->pinned_on_cpu != cpu);
+	current->pinned_on_cpu = -1;
+#endif
+
+	WARN_ON_ONCE(rq->nr_pinned < 1);
+
 	p->migrate_disable = 0;
+	rq->nr_pinned--;
+#ifdef CONFIG_HOTPLUG_CPU
+	if (rq->nr_pinned == 0 && unlikely(!cpu_active(cpu)) &&
+	    takedown_cpu_task)
+		wake_up_process(takedown_cpu_task);
+#endif
+
+	if (!p->migrate_disable_scheduled)
+		goto out;
+
+	p->migrate_disable_scheduled = 0;
+
 	migrate_enable_update_cpus_allowed(p);
 
-	if (p->migrate_disable_update) {
-		struct rq *rq;
+	WARN_ON(smp_processor_id() != cpu);
+	if (!is_cpu_allowed(p, cpu)) {
+		struct migration_arg arg = { .task = p };
+		struct cpu_stop_work work;
 		struct rq_flags rf;
 
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
-
-		__do_set_cpus_allowed_tail(p, &p->cpus_mask);
+		arg.dest_cpu = select_fallback_rq(cpu, p);
 		task_rq_unlock(rq, p, &rf);
 
-		p->migrate_disable_update = 0;
-
-		WARN_ON(smp_processor_id() != task_cpu(p));
-		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
-			const struct cpumask *cpu_valid_mask = cpu_active_mask;
-			struct migration_arg arg;
-			unsigned int dest_cpu;
-
-			if (p->flags & PF_KTHREAD) {
-				/*
-				 * Kernel threads are allowed on online && !active CPUs
-				 */
-				cpu_valid_mask = cpu_online_mask;
-			}
-			dest_cpu = cpumask_any_and(cpu_valid_mask, &p->cpus_mask);
-			arg.task = p;
-			arg.dest_cpu = dest_cpu;
-
-			unpin_current_cpu();
-			preempt_lazy_enable();
-			preempt_enable();
-			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-			tlb_migrate_finish(p->mm);
-
-			return;
+		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
+				    &arg, &work);
+		tlb_migrate_finish(p->mm);
+		__schedule(true);
+		if (!work.disabled) {
+			while (!arg.done)
+				cpu_relax();
 		}
 	}
-	unpin_current_cpu();
+
+out:
 	preempt_lazy_enable();
 	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_enable);
 
-#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-void migrate_disable(void)
+int cpu_nr_pinned(int cpu)
 {
-#ifdef CONFIG_SCHED_DEBUG
-	struct task_struct *p = current;
+	struct rq *rq = cpu_rq(cpu);
 
-	if (in_atomic() || irqs_disabled()) {
-		p->migrate_disable_atomic++;
-		return;
-	}
+	return rq->nr_pinned;
+}
 
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
+#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+static void migrate_disabled_sched(struct task_struct *p)
+{
+}
 
-	p->migrate_disable++;
+void migrate_disable(void)
+{
+#ifdef CONFIG_SCHED_DEBUG
+	current->migrate_disable++;
 #endif
 	barrier();
 }
@@ -7411,20 +7380,14 @@ void migrate_enable(void)
 #ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
-	if (in_atomic() || irqs_disabled()) {
-		p->migrate_disable_atomic--;
-		return;
-	}
-
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	p->migrate_disable--;
 #endif
 	barrier();
 }
 EXPORT_SYMBOL(migrate_enable);
+#else
+static void migrate_disabled_sched(struct task_struct *p)
+{
+}
 #endif
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 974a8f9b615a..929167a1d991 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -287,7 +287,7 @@ static void task_non_contending(struct task_struct *p)
 
 	dl_se->dl_non_contending = 1;
 	get_task_struct(p);
-	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL);
+	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
 }
 
 static void task_contending(struct sched_dl_entity *dl_se, int flags)
@@ -1325,7 +1325,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = inactive_task_timer;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c90574112bca..78fa5911dd55 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -913,6 +913,10 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#if defined(CONFIG_PREEMPT_RT_BASE) && defined(CONFIG_SMP)
+	int			nr_pinned;
+#endif
 };
 
 static inline int cpu_of(struct rq *rq)
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 067cb83f37ea..2d15c0d50625 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -86,8 +86,11 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	enabled = stopper->enabled;
 	if (enabled)
 		__cpu_stop_queue_work(stopper, work, &wakeq);
-	else if (work->done)
-		cpu_stop_signal_done(work->done);
+	else {
+		work->disabled = true;
+		if (work->done)
+			cpu_stop_signal_done(work->done);
+	}
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	wake_up_q(&wakeq);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 94d97eae0a46..e54a95de8b79 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -150,6 +150,11 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -274,6 +279,11 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -941,9 +951,9 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
 
 void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
-	struct hrtimer_clock_base *base = timer->base;
+	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (base && base->cpu_base) {
+	if (timer->is_soft && is_migration_base(base)) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 765e700962ab..c9964dc3276b 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1175,8 +1175,10 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
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
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index fb35c45b9421..2e7398534b66 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -22,7 +22,12 @@ notrace static unsigned int check_preemption_disabled(const char *what1,
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
-	if (cpumask_equal(current->cpus_ptr, cpumask_of(this_cpu)))
+#if defined(CONFIG_PREEMPT_RT_BASE) && (defined(CONFIG_SMP) || defined(CONFIG_SCHED_DEBUG))
+	if (current->migrate_disable)
+		goto out;
+#endif
+
+	if (current->nr_cpus_allowed == 1)
 		goto out;
 
 	/*
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 1e9e2ab25539..5830cc9a2164 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -143,25 +143,21 @@ static void val_to_string(char *str, size_t size, struct type_descriptor *type,
 	}
 }
 
-static DEFINE_SPINLOCK(report_lock);
-
-static void ubsan_prologue(struct source_location *location,
-			unsigned long *flags)
+static void ubsan_prologue(struct source_location *location)
 {
 	current->in_ubsan++;
-	spin_lock_irqsave(&report_lock, *flags);
 
 	pr_err("========================================"
 		"========================================\n");
 	print_source_location("UBSAN: Undefined behaviour in", location);
 }
 
-static void ubsan_epilogue(unsigned long *flags)
+static void ubsan_epilogue(void)
 {
 	dump_stack();
 	pr_err("========================================"
 		"========================================\n");
-	spin_unlock_irqrestore(&report_lock, *flags);
+
 	current->in_ubsan--;
 }
 
@@ -170,14 +166,13 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
 {
 
 	struct type_descriptor *type = data->type;
-	unsigned long flags;
 	char lhs_val_str[VALUE_LENGTH];
 	char rhs_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(lhs_val_str, sizeof(lhs_val_str), type, lhs);
 	val_to_string(rhs_val_str, sizeof(rhs_val_str), type, rhs);
@@ -189,7 +184,7 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
 		rhs_val_str,
 		type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 void __ubsan_handle_add_overflow(struct overflow_data *data,
@@ -217,20 +212,19 @@ EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
 void __ubsan_handle_negate_overflow(struct overflow_data *data,
 				void *old_val)
 {
-	unsigned long flags;
 	char old_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
 
 	pr_err("negation of %s cannot be represented in type %s:\n",
 		old_val_str, data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
 
@@ -238,13 +232,12 @@ EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
 void __ubsan_handle_divrem_overflow(struct overflow_data *data,
 				void *lhs, void *rhs)
 {
-	unsigned long flags;
 	char rhs_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(rhs_val_str, sizeof(rhs_val_str), data->type, rhs);
 
@@ -254,58 +247,52 @@ void __ubsan_handle_divrem_overflow(struct overflow_data *data,
 	else
 		pr_err("division by zero\n");
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_divrem_overflow);
 
 static void handle_null_ptr_deref(struct type_mismatch_data_common *data)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 
 	pr_err("%s null pointer of type %s\n",
 		type_check_kinds[data->type_check_kind],
 		data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void handle_misaligned_access(struct type_mismatch_data_common *data,
 				unsigned long ptr)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 
 	pr_err("%s misaligned address %p for type %s\n",
 		type_check_kinds[data->type_check_kind],
 		(void *)ptr, data->type->type_name);
 	pr_err("which requires %ld byte alignment\n", data->alignment);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
 					unsigned long ptr)
 {
-	unsigned long flags;
-
 	if (suppress_report(data->location))
 		return;
 
-	ubsan_prologue(data->location, &flags);
+	ubsan_prologue(data->location);
 	pr_err("%s address %p with insufficient space\n",
 		type_check_kinds[data->type_check_kind],
 		(void *) ptr);
 	pr_err("for an object of type %s\n", data->type->type_name);
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 
 static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
@@ -369,25 +356,23 @@ EXPORT_SYMBOL(__ubsan_handle_vla_bound_not_positive);
 
 void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
 {
-	unsigned long flags;
 	char index_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(index_str, sizeof(index_str), data->index_type, index);
 	pr_err("index %s is out of range for type %s\n", index_str,
 		data->array_type->type_name);
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_out_of_bounds);
 
 void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 					void *lhs, void *rhs)
 {
-	unsigned long flags;
 	struct type_descriptor *rhs_type = data->rhs_type;
 	struct type_descriptor *lhs_type = data->lhs_type;
 	char rhs_str[VALUE_LENGTH];
@@ -396,7 +381,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(rhs_str, sizeof(rhs_str), rhs_type, rhs);
 	val_to_string(lhs_str, sizeof(lhs_str), lhs_type, lhs);
@@ -419,18 +404,16 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 			lhs_str, rhs_str,
 			lhs_type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
 
 
 void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
 {
-	unsigned long flags;
-
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 	pr_err("calling __builtin_unreachable()\n");
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 	panic("can't return from __builtin_unreachable()");
 }
 EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
@@ -438,19 +421,18 @@ EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
 void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
 				void *val)
 {
-	unsigned long flags;
 	char val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
-	ubsan_prologue(&data->location, &flags);
+	ubsan_prologue(&data->location);
 
 	val_to_string(val_str, sizeof(val_str), data->type, val);
 
 	pr_err("load of value %s is not a valid value for type %s\n",
 		val_str, data->type->type_name);
 
-	ubsan_epilogue(&flags);
+	ubsan_epilogue();
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
diff --git a/localversion-rt b/localversion-rt
index 49bae8d6aa67..5498386d0d0c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt38
+-rt39
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 92ce99b15f2b..e5f5eeed338d 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -147,7 +147,7 @@ struct kmemleak_scan_area {
  * (use_count) and freed using the RCU mechanism.
  */
 struct kmemleak_object {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned int flags;		/* object status flags */
 	struct list_head object_list;
 	struct list_head gray_list;
@@ -561,7 +561,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	INIT_LIST_HEAD(&object->object_list);
 	INIT_LIST_HEAD(&object->gray_list);
 	INIT_HLIST_HEAD(&object->area_list);
-	spin_lock_init(&object->lock);
+	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
 	object->flags = OBJECT_ALLOCATED;
 	object->pointer = ptr;
@@ -642,9 +642,9 @@ static void __delete_object(struct kmemleak_object *object)
 	 * Locking here also ensures that the corresponding memory block
 	 * cannot be freed when it is being scanned.
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags &= ~OBJECT_ALLOCATED;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -716,9 +716,9 @@ static void paint_it(struct kmemleak_object *object, int color)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	__paint_it(object, color);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 static void paint_ptr(unsigned long ptr, int color)
@@ -778,7 +778,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 		goto out;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (size == SIZE_MAX) {
 		size = object->pointer + object->size - ptr;
 	} else if (ptr + size > object->pointer + object->size) {
@@ -794,7 +794,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 
 	hlist_add_head(&area->node, &object->area_list);
 out_unlock:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 out:
 	put_object(object);
 }
@@ -817,9 +817,9 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->excess_ref = excess_ref;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -839,9 +839,9 @@ static void object_no_scan(unsigned long ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags |= OBJECT_NO_SCAN;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -902,11 +902,11 @@ static void early_alloc(struct early_log *log)
 			       log->min_count, GFP_ATOMIC);
 	if (!object)
 		goto out;
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	for (i = 0; i < log->trace_len; i++)
 		object->trace[i] = log->trace[i];
 	object->trace_len = log->trace_len;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 out:
 	rcu_read_unlock();
 }
@@ -1096,9 +1096,9 @@ void __ref kmemleak_update_trace(const void *ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->trace_len = __save_stack_trace(object->trace);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 }
@@ -1344,7 +1344,7 @@ static void scan_block(void *_start, void *_end,
 		 * previously acquired in scan_object(). These locks are
 		 * enclosed by scan_mutex.
 		 */
-		spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 		/* only pass surplus references (object already gray) */
 		if (color_gray(object)) {
 			excess_ref = object->excess_ref;
@@ -1353,7 +1353,7 @@ static void scan_block(void *_start, void *_end,
 			excess_ref = 0;
 			update_refs(object);
 		}
-		spin_unlock(&object->lock);
+		raw_spin_unlock(&object->lock);
 
 		if (excess_ref) {
 			object = lookup_object(excess_ref, 0);
@@ -1362,9 +1362,9 @@ static void scan_block(void *_start, void *_end,
 			if (object == scanned)
 				/* circular reference, ignore */
 				continue;
-			spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 			update_refs(object);
-			spin_unlock(&object->lock);
+			raw_spin_unlock(&object->lock);
 		}
 	}
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -1400,7 +1400,7 @@ static void scan_object(struct kmemleak_object *object)
 	 * Once the object->lock is acquired, the corresponding memory block
 	 * cannot be freed (the same lock is acquired in delete_object).
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (object->flags & OBJECT_NO_SCAN)
 		goto out;
 	if (!(object->flags & OBJECT_ALLOCATED))
@@ -1419,9 +1419,9 @@ static void scan_object(struct kmemleak_object *object)
 			if (start >= end)
 				break;
 
-			spin_unlock_irqrestore(&object->lock, flags);
+			raw_spin_unlock_irqrestore(&object->lock, flags);
 			cond_resched();
-			spin_lock_irqsave(&object->lock, flags);
+			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
 	} else
 		hlist_for_each_entry(area, &object->area_list, node)
@@ -1429,7 +1429,7 @@ static void scan_object(struct kmemleak_object *object)
 				   (void *)(area->start + area->size),
 				   object);
 out:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 /*
@@ -1482,7 +1482,7 @@ static void kmemleak_scan(void)
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 #ifdef DEBUG
 		/*
 		 * With a few exceptions there should be a maximum of
@@ -1499,7 +1499,7 @@ static void kmemleak_scan(void)
 		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
 
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1564,14 +1564,14 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
 		    && update_checksum(object) && get_object(object)) {
 			/* color it gray temporarily */
 			object->count = object->min_count;
 			list_add_tail(&object->gray_list, &gray_list);
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1591,13 +1591,13 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
 			new_leaks++;
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1749,10 +1749,10 @@ static int kmemleak_seq_show(struct seq_file *seq, void *v)
 	struct kmemleak_object *object = v;
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if ((object->flags & OBJECT_REPORTED) && unreferenced_object(object))
 		print_unreferenced(seq, object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	return 0;
 }
 
@@ -1782,9 +1782,9 @@ static int dump_str_object_info(const char *str)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	dump_object_info(object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 	return 0;
@@ -1803,11 +1803,11 @@ static void kmemleak_clear(void)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if ((object->flags & OBJECT_REPORTED) &&
 		    unreferenced_object(object))
 			__paint_it(object, KMEMLEAK_GREY);
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 17cecc96f735..217d39f40393 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -67,7 +67,7 @@ static inline bool userspace_irqchip(struct kvm *kvm)
 static void soft_timer_start(struct hrtimer *hrt, u64 ns)
 {
 	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
-		      HRTIMER_MODE_ABS);
+		      HRTIMER_MODE_ABS_HARD);
 }
 
 static void soft_timer_cancel(struct hrtimer *hrt, struct work_struct *work)
@@ -638,10 +638,10 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 	vcpu_ptimer(vcpu)->cntvoff = 0;
 
 	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
-	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	timer->bg_timer.function = kvm_bg_timer_expire;
 
-	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	timer->phys_timer.function = kvm_phys_timer_expire;
 
 	vtimer->irq.irq = default_vtimer_irq.irq;
