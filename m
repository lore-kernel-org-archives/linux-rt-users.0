From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 3.18.9-rt4
Date: Sat, 7 Mar 2015 15:15:36 +0100
Message-ID: <20150307141536.GA6485@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58103 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbCGOPk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Mar 2015 09:15:40 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v3.18.9-rt4 patch set.

Changes since v3.18.9-rt3

- The patch "rwsem-rt: Do not allow readers to nest" has been reverted.
  This means cpufreq works again.

- A fix in sound/audio to not disable interrupts as part of the locking=
=2E
  (Mike Galbraith)

- A fix in NFS which caused " sleeping function called from invalid
  context" warnings (Mike Galbraith)

- Thermal wake ups on X86 are now handled defred into thread context
  (Daniel Wagner)

- A ifdefs in lockdep self-test to avoid long "defined but not used"
  compiler warnings (Josh Cartwright)

- Fixed dead-lock handling of the ww_mutex (Mike Galbraith)

- The primary handler of mmc/sdhci is moved into the threaded one to
  avoid taking sleeping locks in IRQ contet. (Reported by Michal =C5=A0=
mucr)

- The IRQ-work handling has been updated to get rid of the warning
  triggered in FULL_NO_HZ mode (Reported by Carsten Emde & Luis Claudio
  R. Goncalves)

- "rcu torture" now compiles if enabled (Luis Claudio R. Goncalves)

- "Simple work queue" now disables interrupts during list handling

- The MCE check now uses the "Simple work queue" instead of its own
  thread for defered work (Daniel Wagner)

Known issues:

      - bcache is disabled.

      - lazy preempt on x86_64 leads to a crash with some load.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the ne=
xt
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        measuring the performance of the individual implementation.


The delta patch against 3.18.9-rt3 is appended below and can be found h=
ere:=20

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-=
3.18.9-rt3-rt4.patch.xz

The RT patch against 3.18.9 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.=
9-rt4.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patches-3.1=
8.9-rt4.tar.xz

Sebastian

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mch=
eck/mce.c
index 718fc6cc6c64..d7f1c8316f94 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -18,7 +18,6 @@
 #include <linux/rcupdate.h>
 #include <linux/kobject.h>
 #include <linux/uaccess.h>
-#include <linux/kthread.h>
 #include <linux/kdebug.h>
 #include <linux/kernel.h>
 #include <linux/percpu.h>
@@ -43,6 +42,7 @@
 #include <linux/irq_work.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
+#include <linux/work-simple.h>
=20
 #include <asm/processor.h>
 #include <asm/mce.h>
@@ -1364,7 +1364,7 @@ static void mce_do_trigger(struct work_struct *wo=
rk)
=20
 static DECLARE_WORK(mce_trigger_work, mce_do_trigger);
=20
-static void __mce_notify_work(void)
+static void __mce_notify_work(struct swork_event *event)
 {
 	/* Not more than two messages every minute */
 	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
@@ -1385,43 +1385,31 @@ static void __mce_notify_work(void)
 }
=20
 #ifdef CONFIG_PREEMPT_RT_FULL
-struct task_struct *mce_notify_helper;
-
-static int mce_notify_helper_thread(void *unused)
-{
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		if (kthread_should_stop())
-			break;
-		__mce_notify_work();
-	}
-	return 0;
-}
+static bool notify_work_ready __read_mostly;
+static struct swork_event notify_work;
=20
 static int mce_notify_work_init(void)
 {
-	mce_notify_helper =3D kthread_run(mce_notify_helper_thread, NULL,
-					   "mce-notify");
-	if (!mce_notify_helper)
-		return -ENOMEM;
+	int err;
+
+	err =3D swork_get();
+	if (err)
+		return err;
=20
+	INIT_SWORK(&notify_work, __mce_notify_work);
+	notify_work_ready =3D true;
 	return 0;
 }
=20
 static void mce_notify_work(void)
 {
-	if (WARN_ON_ONCE(!mce_notify_helper)) {
-		pr_info(HW_ERR "Machine check event before MCE init; ignored\n");
-		return;
-	}
-
-	wake_up_process(mce_notify_helper);
+	if (notify_work_ready)
+		swork_queue(&notify_work);
 }
 #else
 static void mce_notify_work(void)
 {
-	__mce_notify_work();
+	__mce_notify_work(NULL);
 }
 static inline int mce_notify_work_init(void) { return 0; }
 #endif
@@ -2497,6 +2485,10 @@ static __init int mcheck_init_device(void)
 		goto err_out;
 	}
=20
+	err =3D mce_notify_work_init();
+	if (err)
+		goto err_out;
+
 	if (!zalloc_cpumask_var(&mce_device_initialized, GFP_KERNEL)) {
 		err =3D -ENOMEM;
 		goto err_out;
@@ -2533,15 +2525,8 @@ static __init int mcheck_init_device(void)
 	if (err)
 		goto err_register;
=20
-	err =3D mce_notify_work_init();
-	if (err)
-		goto err_notify;
-
 	return 0;
=20
-err_notify:
-	misc_deregister(&mce_chrdev_device);
-
 err_register:
 	unregister_syscore_ops(&mce_syscore_ops);
=20
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 023c2010cd75..bcde53774bc9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2565,6 +2565,31 @@ static irqreturn_t sdhci_thread_irq(int irq, voi=
d *dev_id)
 	return isr ? IRQ_HANDLED : IRQ_NONE;
 }
=20
+#ifdef CONFIG_PREEMPT_RT_BASE
+static irqreturn_t sdhci_rt_irq(int irq, void *dev_id)
+{
+	irqreturn_t ret;
+
+	local_bh_disable();
+	ret =3D sdhci_irq(irq, dev_id);
+	local_bh_enable();
+	if (ret =3D=3D IRQ_WAKE_THREAD)
+		ret =3D sdhci_thread_irq(irq, dev_id);
+	return ret;
+}
+#endif
+
+static int sdhci_req_irq(struct sdhci_host *host)
+{
+#ifdef CONFIG_PREEMPT_RT_BASE
+	return request_threaded_irq(host->irq, NULL, sdhci_rt_irq,
+				    IRQF_SHARED, mmc_hostname(host->mmc), host);
+#else
+	return request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+				    IRQF_SHARED, mmc_hostname(host->mmc), host);
+#endif
+}
+
 /*********************************************************************=
********\
  *                                                                    =
       *
  * Suspend/resume                                                     =
       *
@@ -2632,9 +2657,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
=20
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret =3D request_threaded_irq(host->irq, sdhci_irq,
-					   sdhci_thread_irq, IRQF_SHARED,
-					   mmc_hostname(host->mmc), host);
+		ret =3D sdhci_req_irq(host);
 		if (ret)
 			return ret;
 	} else {
@@ -3253,8 +3276,7 @@ int sdhci_add_host(struct sdhci_host *host)
=20
 	sdhci_init(host, 0);
=20
-	ret =3D request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
-				   IRQF_SHARED,	mmc_hostname(mmc), host);
+	ret =3D sdhci_req_irq(host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x=
86_pkg_temp_thermal.c
index 9ea3d9d49ffc..e3c2663e0b1f 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -29,6 +29,7 @@
 #include <linux/pm.h>
 #include <linux/thermal.h>
 #include <linux/debugfs.h>
+#include <linux/work-simple.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
=20
@@ -352,7 +353,7 @@ static void pkg_temp_thermal_threshold_work_fn(stru=
ct work_struct *work)
 	}
 }
=20
-static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
+static void platform_thermal_notify_work(struct swork_event *event)
 {
 	unsigned long flags;
 	int cpu =3D smp_processor_id();
@@ -369,7 +370,7 @@ static int pkg_temp_thermal_platform_thermal_notify=
(__u64 msr_val)
 			pkg_work_scheduled[phy_id]) {
 		disable_pkg_thres_interrupt();
 		spin_unlock_irqrestore(&pkg_work_lock, flags);
-		return -EINVAL;
+		return;
 	}
 	pkg_work_scheduled[phy_id] =3D 1;
 	spin_unlock_irqrestore(&pkg_work_lock, flags);
@@ -378,9 +379,48 @@ static int pkg_temp_thermal_platform_thermal_notif=
y(__u64 msr_val)
 	schedule_delayed_work_on(cpu,
 				&per_cpu(pkg_temp_thermal_threshold_work, cpu),
 				msecs_to_jiffies(notify_delay_ms));
+}
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+static struct swork_event notify_work;
+
+static int thermal_notify_work_init(void)
+{
+	int err;
+
+	err =3D swork_get();
+	if (err)
+		return err;
+
+	INIT_SWORK(&notify_work, platform_thermal_notify_work);
 	return 0;
 }
=20
+static void thermal_notify_work_cleanup(void)
+{
+	swork_put();
+}
+
+static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
+{
+	swork_queue(&notify_work);
+	return 0;
+}
+
+#else  /* !CONFIG_PREEMPT_RT_FULL */
+
+static int thermal_notify_work_init(void) { return 0; }
+
+static int thermal_notify_work_cleanup(void) {  }
+
+static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
+{
+	platform_thermal_notify_work(NULL);
+
+	return 0;
+}
+#endif /* CONFIG_PREEMPT_RT_FULL */
+
 static int find_siblings_cpu(int cpu)
 {
 	int i;
@@ -584,6 +624,9 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
=20
+	if (!thermal_notify_work_init())
+		return -ENODEV;
+
 	spin_lock_init(&pkg_work_lock);
 	platform_thermal_package_notify =3D
 			pkg_temp_thermal_platform_thermal_notify;
@@ -608,7 +651,7 @@ static int __init pkg_temp_thermal_init(void)
 	kfree(pkg_work_scheduled);
 	platform_thermal_package_notify =3D NULL;
 	platform_thermal_package_rate_control =3D NULL;
-
+	thermal_notify_work_cleanup();
 	return -ENODEV;
 }
=20
@@ -633,6 +676,7 @@ static void __exit pkg_temp_thermal_exit(void)
 	mutex_unlock(&phy_dev_list_mutex);
 	platform_thermal_package_notify =3D NULL;
 	platform_thermal_package_rate_control =3D NULL;
+	thermal_notify_work_cleanup();
 	for_each_online_cpu(i)
 		cancel_delayed_work_sync(
 			&per_cpu(pkg_temp_thermal_threshold_work, i));
diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem_rt.h
index 0065b08fbb7a..924c2d274ab5 100644
--- a/include/linux/rwsem_rt.h
+++ b/include/linux/rwsem_rt.h
@@ -20,6 +20,7 @@
=20
 struct rw_semaphore {
 	struct rt_mutex		lock;
+	int			read_depth;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 19c363a437bd..0c6491228b17 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -71,6 +71,8 @@ void __weak arch_irq_work_raise(void)
  */
 bool irq_work_queue_on(struct irq_work *work, int cpu)
 {
+	bool raise_irqwork;
+
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(cpu));
=20
@@ -81,7 +83,19 @@ bool irq_work_queue_on(struct irq_work *work, int cp=
u)
 	if (!irq_work_claim(work))
 		return false;
=20
-	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (work->flags & IRQ_WORK_HARD_IRQ)
+		raise_irqwork =3D llist_add(&work->llnode,
+					  &per_cpu(hirq_work_list, cpu));
+	else
+		raise_irqwork =3D llist_add(&work->llnode,
+					  &per_cpu(lazy_list, cpu));
+#else
+		raise_irqwork =3D llist_add(&work->llnode,
+					  &per_cpu(raised_list, cpu));
+#endif
+
+	if (raise_irqwork)
 		arch_send_call_function_single_ipi(cpu);
=20
 	return true;
@@ -101,19 +115,14 @@ bool irq_work_queue(struct irq_work *work)
=20
 #ifdef CONFIG_PREEMPT_RT_FULL
 	if (work->flags & IRQ_WORK_HARD_IRQ) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list))) {
-			if (work->flags & IRQ_WORK_LAZY) {
-				if (tick_nohz_tick_stopped())
-					arch_irq_work_raise();
-			} else {
-				arch_irq_work_raise();
-			}
-		}
-	/* If the work is "lazy", handle it from next tick if any */
-	} else if (work->flags & IRQ_WORK_LAZY) {
+		if (llist_add(&work->llnode, this_cpu_ptr(&hirq_work_list)))
+			arch_irq_work_raise();
+	} else {
+		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)))
+			arch_irq_work_raise();
+	}
 #else
 	if (work->flags & IRQ_WORK_LAZY) {
-#endif
 		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
 		    tick_nohz_tick_stopped())
 			arch_irq_work_raise();
@@ -121,6 +130,7 @@ bool irq_work_queue(struct irq_work *work)
 		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
 			arch_irq_work_raise();
 	}
+#endif
=20
 	preempt_enable();
=20
@@ -137,7 +147,8 @@ bool irq_work_needs_cpu(void)
=20
 	if (llist_empty(raised))
 		if (llist_empty(lazy))
-			return false;
+			if (llist_empty(this_cpu_ptr(&hirq_work_list)))
+				return false;
=20
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
diff --git a/kernel/locking/rt.c b/kernel/locking/rt.c
index eac2ddea9c45..73c55089fb93 100644
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -322,7 +322,8 @@ EXPORT_SYMBOL(rt_up_write);
 void  rt_up_read(struct rw_semaphore *rwsem)
 {
 	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	rt_mutex_unlock(&rwsem->lock);
+	if (--rwsem->read_depth =3D=3D 0)
+		rt_mutex_unlock(&rwsem->lock);
 }
 EXPORT_SYMBOL(rt_up_read);
=20
@@ -333,6 +334,7 @@ EXPORT_SYMBOL(rt_up_read);
 void  rt_downgrade_write(struct rw_semaphore *rwsem)
 {
 	BUG_ON(rt_mutex_owner(&rwsem->lock) !=3D current);
+	rwsem->read_depth =3D 1;
 }
 EXPORT_SYMBOL(rt_downgrade_write);
=20
@@ -361,7 +363,7 @@ void  rt_down_write_nested(struct rw_semaphore *rws=
em, int subclass)
 EXPORT_SYMBOL(rt_down_write_nested);
=20
 void rt_down_write_nested_lock(struct rw_semaphore *rwsem,
-		struct lockdep_map *nest)
+			       struct lockdep_map *nest)
 {
 	rwsem_acquire_nest(&rwsem->dep_map, 0, 0, nest, _RET_IP_);
 	rt_mutex_lock(&rwsem->lock);
@@ -370,20 +372,36 @@ EXPORT_SYMBOL(rt_down_write_nested_lock);
=20
 int  rt_down_read_trylock(struct rw_semaphore *rwsem)
 {
-	int ret;
+	struct rt_mutex *lock =3D &rwsem->lock;
+	int ret =3D 1;
=20
-	ret =3D rt_mutex_trylock(&rwsem->lock);
-	if (ret)
-		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
+	/*
+	 * recursive read locks succeed when current owns the rwsem,
+	 * but not when read_depth =3D=3D 0 which means that the rwsem is
+	 * write locked.
+	 */
+	if (rt_mutex_owner(lock) !=3D current)
+		ret =3D rt_mutex_trylock(&rwsem->lock);
+	else if (!rwsem->read_depth)
+		ret =3D 0;
=20
+	if (ret) {
+		rwsem->read_depth++;
+		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_down_read_trylock);
=20
 static void __rt_down_read(struct rw_semaphore *rwsem, int subclass)
 {
-	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
+	struct rt_mutex *lock =3D &rwsem->lock;
+
+	rwsem_acquire_read(&rwsem->dep_map, subclass, 0, _RET_IP_);
+
+	if (rt_mutex_owner(lock) !=3D current)
+		rt_mutex_lock(&rwsem->lock);
+	rwsem->read_depth++;
 }
=20
 void  rt_down_read(struct rw_semaphore *rwsem)
@@ -408,6 +426,7 @@ void  __rt_rwsem_init(struct rw_semaphore *rwsem, c=
onst char *name,
 	debug_check_no_locks_freed((void *)rwsem, sizeof(*rwsem));
 	lockdep_init_map(&rwsem->dep_map, name, key, 0);
 #endif
+	rwsem->read_depth =3D 0;
 	rwsem->lock.save_state =3D 0;
 }
 EXPORT_SYMBOL(__rt_rwsem_init);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e257819480a9..397373da53d2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1695,15 +1695,21 @@ rt_mutex_slowlock(struct rt_mutex *lock, int st=
ate,
 	ret =3D task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
=20
 	if (likely(!ret))
-		ret =3D __rt_mutex_slowlock(lock, state, timeout, &waiter,
-					  ww_ctx);
+		ret =3D __rt_mutex_slowlock(lock, state, timeout, &waiter, ww_ctx);
+	else if (ww_ctx) {
+		/* ww_mutex received EDEADLK, let it become EALREADY */
+		ret =3D __mutex_lock_check_stamp(lock, ww_ctx);
+		BUG_ON(!ret);
+	}
=20
 	set_current_state(TASK_RUNNING);
=20
 	if (unlikely(ret)) {
 		if (rt_mutex_has_waiters(lock))
 			remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		/* ww_mutex want to report EDEADLK/EALREADY, let them */
+		if (!ww_ctx)
+			rt_mutex_handle_deadlock(ret, chwalk, &waiter);
 	} else if (ww_ctx) {
 		ww_mutex_account_lock(lock, ww_ctx);
 	}
@@ -2244,8 +2250,7 @@ __ww_mutex_lock_interruptible(struct ww_mutex *lo=
ck, struct ww_acquire_ctx *ww_c
 	might_sleep();
=20
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_=
IP_);
-	ret =3D rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL,
-				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
+	ret =3D rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL,=
 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -2263,8 +2268,7 @@ __ww_mutex_lock(struct ww_mutex *lock, struct ww_=
acquire_ctx *ww_ctx)
 	might_sleep();
=20
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_=
IP_);
-	ret =3D rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NUL=
L,
-				RT_MUTEX_FULL_CHAINWALK, ww_ctx);
+	ret =3D rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NUL=
L, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -2276,11 +2280,13 @@ EXPORT_SYMBOL_GPL(__ww_mutex_lock);
=20
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
+	int nest =3D !!lock->ctx;
+
 	/*
 	 * The unlocking fastpath is the 0->1 transition from 'locked'
 	 * into 'unlocked' state:
 	 */
-	if (lock->ctx) {
+	if (nest) {
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
 #endif
@@ -2289,7 +2295,7 @@ void __sched ww_mutex_unlock(struct ww_mutex *loc=
k)
 		lock->ctx =3D NULL;
 	}
=20
-	mutex_release(&lock->base.dep_map, 1, _RET_IP_);
+	mutex_release(&lock->base.dep_map, nest, _RET_IP_);
 	rt_mutex_unlock(&lock->base.lock);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4e9e258bfe8..6aae258f9f62 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -378,6 +378,12 @@ void rcu_bh_force_quiescent_state(void)
 	force_quiescent_state(&rcu_bh_state);
 }
 EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
+
+#else
+void rcu_force_quiescent_state(void)
+{
+}
+EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 #endif
=20
 /*
diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
index 0b2fa5ac88c8..c996f755dba6 100644
--- a/kernel/sched/work-simple.c
+++ b/kernel/sched/work-simple.c
@@ -33,9 +33,9 @@ static bool swork_readable(struct sworker *worker)
 	if (kthread_should_stop())
 		return true;
=20
-	raw_spin_lock(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	r =3D !list_empty(&worker->events);
-	raw_spin_unlock(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
=20
 	return r;
 }
@@ -44,32 +44,28 @@ static int swork_kthread(void *arg)
 {
 	struct sworker *worker =3D arg;
=20
-	pr_info("swork_kthread enter\n");
-
 	for (;;) {
 		swait_event_interruptible(worker->wq,
 					swork_readable(worker));
 		if (kthread_should_stop())
 			break;
=20
-		raw_spin_lock(&worker->lock);
+		raw_spin_lock_irq(&worker->lock);
 		while (!list_empty(&worker->events)) {
 			struct swork_event *sev;
=20
 			sev =3D list_first_entry(&worker->events,
 					struct swork_event, item);
 			list_del(&sev->item);
-			raw_spin_unlock(&worker->lock);
+			raw_spin_unlock_irq(&worker->lock);
=20
 			WARN_ON_ONCE(!test_and_clear_bit(SWORK_EVENT_PENDING,
 							 &sev->flags));
 			sev->func(sev);
-			raw_spin_lock(&worker->lock);
+			raw_spin_lock_irq(&worker->lock);
 		}
-		raw_spin_unlock(&worker->lock);
+		raw_spin_unlock_irq(&worker->lock);
 	}
-
-	pr_info("swork_kthread exit\n");
 	return 0;
 }
=20
@@ -111,14 +107,14 @@ static void swork_destroy(struct sworker *worker)
  */
 bool swork_queue(struct swork_event *sev)
 {
+	unsigned long flags;
+
 	if (test_and_set_bit(SWORK_EVENT_PENDING, &sev->flags))
 		return false;
=20
-	WARN_ON(irqs_disabled());
-
-	raw_spin_lock(&glob_worker->lock);
+	raw_spin_lock_irqsave(&glob_worker->lock, flags);
 	list_add_tail(&sev->item, &glob_worker->events);
-	raw_spin_unlock(&glob_worker->lock);
+	raw_spin_unlock_irqrestore(&glob_worker->lock, flags);
=20
 	swait_wake(&glob_worker->wq);
 	return true;
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 19ae2366a7a9..b93a6103fa4d 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -590,6 +590,8 @@ GENERATE_TESTCASE(init_held_rsem)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_spin)
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_rlock)
=20
@@ -605,9 +607,12 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_rlock=
)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_wlock)
=20
+#endif
+
 #undef E1
 #undef E2
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Enabling hardirqs with a softirq-safe lock held:
  */
@@ -640,6 +645,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #undef E1
 #undef E2
=20
+#endif
+
 /*
  * Enabling irqs with an irq-safe lock held:
  */
@@ -663,6 +670,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_spin)
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_rlock)
=20
@@ -678,6 +687,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_rlock=
)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
=20
+#endif
+
 #undef E1
 #undef E2
=20
@@ -709,6 +720,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock=
)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_spin)
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_rlock)
=20
@@ -724,6 +737,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
=20
+#endif
+
 #undef E1
 #undef E2
 #undef E3
@@ -757,6 +772,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_spin)
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_rlock)
=20
@@ -772,10 +789,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_rloc=
k)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_wlock)
=20
+#endif
+
 #undef E1
 #undef E2
 #undef E3
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 /*
  * read-lock / write-lock irq inversion.
  *
@@ -838,6 +859,10 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_=
wlock)
 #undef E2
 #undef E3
=20
+#endif
+
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 /*
  * read-lock / write-lock recursion that is actually safe.
  */
@@ -876,6 +901,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_s=
oft)
 #undef E2
 #undef E3
=20
+#endif
+
 /*
  * read-lock / write-lock recursion that is unsafe.
  */
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885c..ad3da1bcab7e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index c179ca2a5aa4..ac93e74d5515 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -357,7 +357,7 @@ static void svc_xprt_do_enqueue(struct svc_xprt *xp=
rt)
 		return;
 	}
=20
-	cpu =3D get_cpu();
+	cpu =3D get_cpu_light();
 	pool =3D svc_pool_for_cpu(xprt->xpt_server, cpu);
 	spin_lock_bh(&pool->sp_lock);
=20
@@ -390,7 +390,7 @@ static void svc_xprt_do_enqueue(struct svc_xprt *xp=
rt)
 	}
=20
 	spin_unlock_bh(&pool->sp_lock);
-	put_cpu();
+	put_cpu_light();
 }
=20
 /*
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 166d59cdc86b..8854164197e5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -104,7 +104,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock);
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 {
 	if (!substream->pcm->nonatomic)
-		local_irq_disable();
+		local_irq_disable_nort();
 	snd_pcm_stream_lock(substream);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
@@ -113,7 +113,7 @@ void snd_pcm_stream_unlock_irq(struct snd_pcm_subst=
ream *substream)
 {
 	snd_pcm_stream_unlock(substream);
 	if (!substream->pcm->nonatomic)
-		local_irq_enable();
+		local_irq_enable_nort();
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irq);
=20
@@ -121,7 +121,7 @@ unsigned long _snd_pcm_stream_lock_irqsave(struct s=
nd_pcm_substream *substream)
 {
 	unsigned long flags =3D 0;
 	if (!substream->pcm->nonatomic)
-		local_irq_save(flags);
+		local_irq_save_nort(flags);
 	snd_pcm_stream_lock(substream);
 	return flags;
 }
@@ -132,7 +132,7 @@ void snd_pcm_stream_unlock_irqrestore(struct snd_pc=
m_substream *substream,
 {
 	snd_pcm_stream_unlock(substream);
 	if (!substream->pcm->nonatomic)
-		local_irq_restore(flags);
+		local_irq_restore_nort(flags);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irqrestore);
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
