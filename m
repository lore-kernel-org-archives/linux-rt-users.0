Return-Path: <SRS0=uP6E=SR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7D9C10F0E
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 20:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F6A20880
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555361080;
	bh=88oLDXLKgQuON2jjfS91RzTP3nYsYMmSHvn+YVbiWYg=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=ynvTes+6qwetjMakfuA12VpVKdnEY1mMsLetOXLFaGT5BixA1J7a3PmvwYOrHxeAd
	 krUuTBqsur+opFWi5BxeBRwEkLyM8w6zgpUZzA1NdCa2hV1zlMPBsMjULqiE/+wYE5
	 IyKKMwR/SnMwL1hkd8kG9GpQO7QfKUbsvlbmhvYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfDOUoe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfDOUoe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Apr 2019 16:44:34 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC42205F4;
        Mon, 15 Apr 2019 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555361072;
        bh=88oLDXLKgQuON2jjfS91RzTP3nYsYMmSHvn+YVbiWYg=;
        h=Subject:From:To:Cc:Date:From;
        b=eyQNtZ+JmKUeF7LjG4w8rPAneJksbgbuNeCM+wlpM9rFnOHDcuLWPVFO/dUSgpoep
         PKuEPsXUbzVppL5Kkned77qOl2pjL3VE8V9Rv7oGyiNxd5ekojO3HT1kFWorYVXFim
         H2q84n3O0sBOYvllQlefiLecKMZSpVYybpdiijvM=
Message-ID: <1555361070.12566.39.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.109-rt58
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Mon, 15 Apr 2019 15:44:30 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.109-rt58 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: d805ec17820ce0dc625fe3787c782eb0130130f7

Or to build 4.14.109-rt58 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.109.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.109-rt58.patch.xz


You can also build from 4.14.109-rt57 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.109-rt57-rt58.patch.xz

Enjoy!
   
   Tom

Changes from v4.14.109-rt57:
---
Julien Grall (1):
      tty/sysrq: Convert show_lock to raw_spinlock_t

Peter Zijlstra (1):
      sched/fair: Robustify CFS-bandwidth timer locking

Scott Wood (1):
      locking/rt-mutex: Flush block plug on __down_read()

Sebastian Andrzej Siewior (9):
      arm64: fpsimd: use preemp_disable in addition to local_bh_disable()
      sched/fair: Make the hrtimers non-hard again
      rtmutex/rwlock: preserve state like a sleeping lock
      softirq: Avoid "local_softirq_pending" messages if ksoftirqd is blocked
      softirq: Avoid "local_softirq_pending" messages if task is in cpu_chill()
      hrtimer: Don't lose state in cpu_chill()
      x86: lazy-preempt: properly check against preempt-mask
      hrtimer: cpu_chill(): save task state in ->saved_state()
      powerpc/pseries/iommu: Use a locallock instead local_irq_save()

Tom Zanussi (1):
      Linux 4.14.109-rt58

---
 arch/arm64/kernel/fpsimd.c             | 10 ++++++
 arch/powerpc/platforms/pseries/iommu.c | 16 +++++----
 arch/x86/include/asm/preempt.h         |  2 +-
 drivers/tty/sysrq.c                    |  6 ++--
 kernel/locking/rtmutex.c               |  2 +-
 kernel/locking/rwlock-rt.c             |  2 +-
 kernel/locking/rwsem-rt.c              |  9 +++++
 kernel/sched/fair.c                    | 34 ++++++++++---------
 kernel/softirq.c                       | 60 +++++++++++++++++++++++++---------
 kernel/time/hrtimer.c                  | 15 +++++++--
 localversion-rt                        |  2 +-
 11 files changed, 111 insertions(+), 47 deletions(-)
---
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5d547deb6996..049641a458f3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -172,6 +172,7 @@ void fpsimd_flush_thread(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
@@ -179,6 +180,7 @@ void fpsimd_flush_thread(void)
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -190,12 +192,14 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -208,6 +212,7 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
@@ -219,6 +224,7 @@ void fpsimd_restore_current_state(void)
 	}
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -231,6 +237,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	fpsimd_load_state(state);
@@ -242,6 +249,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 	}
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -281,6 +289,7 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
+	preempt_disable();
 	local_bh_disable();
 
 	__this_cpu_write(kernel_neon_busy, true);
@@ -295,6 +304,7 @@ void kernel_neon_begin(void)
 	preempt_disable();
 
 	local_bh_enable();
+	preempt_enable();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 7c181467d0ad..4bd046492c60 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -38,6 +38,7 @@
 #include <linux/of.h>
 #include <linux/iommu.h>
 #include <linux/rculist.h>
+#include <linux/locallock.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -213,6 +214,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 }
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
+static DEFINE_LOCAL_IRQ_LOCK(tcp_page_lock);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -233,7 +235,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		                           direction, attrs);
 	}
 
-	local_irq_save(flags);	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irqsave(tcp_page_lock, flags);
 
 	tcep = __this_cpu_read(tce_page);
 
@@ -244,7 +247,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(tcp_page_lock, flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					    direction, attrs);
 		}
@@ -278,7 +281,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(tcp_page_lock, flags);
 
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 		ret = (int)rc;
@@ -436,13 +439,14 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	u64 rc = 0;
 	long l, limit;
 
-	local_irq_disable();	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irq(tcp_page_lock);
 	tcep = __this_cpu_read(tce_page);
 
 	if (!tcep) {
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		if (!tcep) {
-			local_irq_enable();
+			local_unlock_irq(tcp_page_lock);
 			return -ENOMEM;
 		}
 		__this_cpu_write(tce_page, tcep);
@@ -488,7 +492,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	/* error cleanup: caller will clear whole range */
 
-	local_irq_enable();
+	local_unlock_irq(tcp_page_lock);
 	return rc;
 }
 
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 22992c837795..f66708779274 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -118,7 +118,7 @@ static __always_inline bool should_resched(int preempt_offset)
 
 	/* preempt count == 0 ? */
 	tmp &= ~PREEMPT_NEED_RESCHED;
-	if (tmp)
+	if (tmp != preempt_offset)
 		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 377b3592384e..5d1c6d496e2e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -215,7 +215,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
 #endif
 
 #ifdef CONFIG_SMP
-static DEFINE_SPINLOCK(show_lock);
+static DEFINE_RAW_SPINLOCK(show_lock);
 
 static void showacpu(void *dummy)
 {
@@ -225,10 +225,10 @@ static void showacpu(void *dummy)
 	if (idle_cpu(smp_processor_id()))
 		return;
 
-	spin_lock_irqsave(&show_lock, flags);
+	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
 	show_stack(NULL, NULL);
-	spin_unlock_irqrestore(&show_lock, flags);
+	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
 static void sysrq_showregs_othercpus(struct work_struct *dummy)
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2cf515877b8e..1177f2815040 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1946,7 +1946,7 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	 * If rt_mutex blocks, the function sched_submit_work will not call
 	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
 	 * We must call blk_schedule_flush_plug here, if we don't call it,
-	 * a deadlock in device mapper may happen.
+	 * a deadlock in I/O may happen.
 	 */
 	if (unlikely(blk_needs_flush_plug(current)))
 		blk_schedule_flush_plug(current);
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index f2e155b2c4a8..c3b91205161c 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -128,7 +128,7 @@ void __sched __read_rt_lock(struct rt_rw_lock *lock)
 	 * That would put Reader1 behind the writer waiting on
 	 * Reader2 to call read_unlock() which might be unbound.
 	 */
-	rt_mutex_init_waiter(&waiter, false);
+	rt_mutex_init_waiter(&waiter, true);
 	rt_spin_lock_slowlock_locked(m, &waiter, flags);
 	/*
 	 * The slowlock() above is guaranteed to return with the rtmutex is
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 26991ddb6c5a..dbdde2476b1c 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -1,5 +1,6 @@
 /*
  */
+#include <linux/blkdev.h>
 #include <linux/rwsem.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -86,6 +87,14 @@ void __sched __down_read(struct rw_semaphore *sem)
 
 	if (__down_read_trylock(sem))
 		return;
+	/*
+	 * If rt_mutex blocks, the function sched_submit_work will not call
+	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
+	 * We must call blk_schedule_flush_plug here, if we don't call it,
+	 * a deadlock in I/O may happen.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
 
 	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9e6ca7d463c0..7d2a8fa9a6ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4378,7 +4378,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 		struct rq *rq = rq_of(cfs_rq);
 		struct rq_flags rf;
 
-		rq_lock(rq, &rf);
+		rq_lock_irqsave(rq, &rf);
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
@@ -4395,7 +4395,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 			unthrottle_cfs_rq(cfs_rq);
 
 next:
-		rq_unlock(rq, &rf);
+		rq_unlock_irqrestore(rq, &rf);
 
 		if (!remaining)
 			break;
@@ -4411,7 +4411,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
  * period the timer is deactivated until scheduling resumes; cfs_b->idle is
  * used to track this state.
  */
-static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
+static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
 	u64 runtime, runtime_expires;
 	int throttled;
@@ -4453,11 +4453,11 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
 		runtime = cfs_b->runtime;
 		cfs_b->distribute_running = 1;
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
 		runtime = distribute_cfs_runtime(cfs_b, runtime,
 						 runtime_expires);
-		raw_spin_lock(&cfs_b->lock);
+		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
@@ -4566,17 +4566,18 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
 	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	unsigned long flags;
 	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (cfs_b->distribute_running) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
 	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
@@ -4587,18 +4588,18 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (runtime)
 		cfs_b->distribute_running = 1;
 
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	if (!runtime)
 		return;
 
 	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (expires == cfs_b->runtime_expires)
 		cfs_b->runtime -= min(runtime, cfs_b->runtime);
 	cfs_b->distribute_running = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
@@ -4676,20 +4677,21 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
+	unsigned long flags;
 	int overrun;
 	int idle = 0;
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
 		if (!overrun)
 			break;
 
-		idle = do_sched_cfs_period_timer(cfs_b, overrun);
+		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
 		cfs_b->period_active = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
 }
@@ -4702,9 +4704,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->distribute_running = 0;
 }
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 583c9ecf04e3..e42ee95fccda 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,6 +92,34 @@ static inline void softirq_clr_runner(unsigned int sirq)
 	sr->runner[sirq] = NULL;
 }
 
+static bool softirq_check_runner_tsk(struct task_struct *tsk,
+				     unsigned int *pending)
+{
+	bool ret = false;
+
+	if (!tsk)
+		return ret;
+
+	/*
+	 * The wakeup code in rtmutex.c wakes up the task
+	 * _before_ it sets pi_blocked_on to NULL under
+	 * tsk->pi_lock. So we need to check for both: state
+	 * and pi_blocked_on.
+	 * The test against UNINTERRUPTIBLE + ->sleeping_lock is in case the
+	 * task does cpu_chill().
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
+	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
+		/* Clear all bits pending in that task */
+		*pending &= ~(tsk->softirqs_raised);
+		ret = true;
+	}
+	raw_spin_unlock(&tsk->pi_lock);
+
+	return ret;
+}
+
 /*
  * On preempt-rt a softirq running context might be blocked on a
  * lock. There might be no other runnable task on this CPU because the
@@ -104,6 +132,7 @@ static inline void softirq_clr_runner(unsigned int sirq)
  */
 void softirq_check_pending_idle(void)
 {
+	struct task_struct *tsk;
 	static int rate_limit;
 	struct softirq_runner *sr = this_cpu_ptr(&softirq_runners);
 	u32 warnpending;
@@ -113,24 +142,23 @@ void softirq_check_pending_idle(void)
 		return;
 
 	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
+	if (!warnpending)
+		return;
 	for (i = 0; i < NR_SOFTIRQS; i++) {
-		struct task_struct *tsk = sr->runner[i];
+		tsk = sr->runner[i];
 
-		/*
-		 * The wakeup code in rtmutex.c wakes up the task
-		 * _before_ it sets pi_blocked_on to NULL under
-		 * tsk->pi_lock. So we need to check for both: state
-		 * and pi_blocked_on.
-		 */
-		if (tsk) {
-			raw_spin_lock(&tsk->pi_lock);
-			if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
-				/* Clear all bits pending in that task */
-				warnpending &= ~(tsk->softirqs_raised);
-				warnpending &= ~(1 << i);
-			}
-			raw_spin_unlock(&tsk->pi_lock);
-		}
+		if (softirq_check_runner_tsk(tsk, &warnpending))
+			warnpending &= ~(1 << i);
+	}
+
+	if (warnpending) {
+		tsk = __this_cpu_read(ksoftirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
+	}
+
+	if (warnpending) {
+		tsk = __this_cpu_read(ktimer_softirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
 	}
 
 	if (warnpending) {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c8d806126381..9990b567b089 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1864,17 +1864,28 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
  */
 void cpu_chill(void)
 {
-	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
+	struct task_struct *self = current;
+	ktime_t chill_time;
+
+	raw_spin_lock_irq(&self->pi_lock);
+	self->saved_state = self->state;
+	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
+	raw_spin_unlock_irq(&self->pi_lock);
 
 	chill_time = ktime_set(0, NSEC_PER_MSEC);
-	set_current_state(TASK_UNINTERRUPTIBLE);
+
 	current->flags |= PF_NOFREEZE;
 	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
+
+	raw_spin_lock_irq(&self->pi_lock);
+	__set_current_state_no_track(self->saved_state);
+	self->saved_state = TASK_RUNNING;
+	raw_spin_unlock_irq(&self->pi_lock);
 }
 EXPORT_SYMBOL(cpu_chill);
 #endif
diff --git a/localversion-rt b/localversion-rt
index c06cc4356292..f9df2cf089cf 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt57
+-rt58
