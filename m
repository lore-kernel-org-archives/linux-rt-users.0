From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.6.4-rt8
Date: Fri, 15 Jul 2016 13:48:04 +0200
Message-ID: <20160715114803.GA11606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.6.4-rt8 patch set. 

Changes since v4.6.4-rt8:

  - Import Thomas' timer rework known as "timer: Refactor the timer
    wheel" patch set which made its way into the -TIP tree. With this
    changes we get NOHZ_FULL working. Finally.

  - Avoid warning of an unused symbol in the !RT case
    (preemptible_lazy())

  - Replace the "trace event preempt count" fixup with Steven's version.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.6.4-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/incr/patch-4.6.4-rt7-rt8.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.6.4-rt8

The RT patch against 4.6.4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patch-4.6.4-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patches-4.6.4-rt8.tar.xz

Sebastian

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 57773fd02253..cd97771f61d6 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -755,7 +755,7 @@ static void uv_heartbeat(unsigned long ignored)
 	uv_set_scir_bits(bits);
 
 	/* enable next timer period */
-	mod_timer_pinned(timer, jiffies + SCIR_CPU_HB_INTERVAL);
+	mod_timer(timer, jiffies + SCIR_CPU_HB_INTERVAL);
 }
 
 static void uv_heartbeat_enable(int cpu)
@@ -764,7 +764,7 @@ static void uv_heartbeat_enable(int cpu)
 		struct timer_list *timer = &uv_cpu_hub_info(cpu)->scir.timer;
 
 		uv_set_cpu_scir_bits(cpu, SCIR_CPU_HEARTBEAT|SCIR_CPU_ACTIVITY);
-		setup_timer(timer, uv_heartbeat, cpu);
+		setup_pinned_timer(timer, uv_heartbeat, cpu);
 		timer->expires = jiffies + SCIR_CPU_HB_INTERVAL;
 		add_timer_on(timer, cpu);
 		uv_cpu_hub_info(cpu)->scir.enabled = 1;
diff --git a/block/genhd.c b/block/genhd.c
index 9f42526b4d62..f06d7f3b075b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1523,12 +1523,7 @@ static void __disk_unblock_events(struct gendisk *disk, bool check_now)
 	if (--ev->block)
 		goto out_unlock;
 
-	/*
-	 * Not exactly a latency critical operation, set poll timer
-	 * slack to 25% and kick event check.
-	 */
 	intv = disk_events_poll_jiffies(disk);
-	set_timer_slack(&ev->dwork.timer, intv / 4);
 	if (check_now)
 		queue_delayed_work(system_freezable_power_efficient_wq,
 				&ev->dwork, 0);
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index daba7ebb9699..18d58f136628 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -714,7 +714,7 @@ struct intel_uncore {
 		struct drm_i915_private *i915;
 		enum forcewake_domain_id id;
 		unsigned wake_count;
-		struct timer_list timer;
+		struct hrtimer timer;
 		i915_reg_t reg_set;
 		u32 val_set;
 		u32 val_clear;
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index 68b6f69aa682..49aefb097c15 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -60,7 +60,11 @@ fw_domain_reset(const struct intel_uncore_forcewake_domain *d)
 static inline void
 fw_domain_arm_timer(struct intel_uncore_forcewake_domain *d)
 {
-	mod_timer_pinned(&d->timer, jiffies + 1);
+	d->wake_count++;
+	hrtimer_start_range_ns(&d->timer,
+			       ktime_set(0, NSEC_PER_MSEC),
+			       NSEC_PER_MSEC,
+			       HRTIMER_MODE_REL);
 }
 
 static inline void
@@ -224,9 +228,11 @@ static int __gen6_gt_wait_for_fifo(struct drm_i915_private *dev_priv)
 	return ret;
 }
 
-static void intel_uncore_fw_release_timer(unsigned long arg)
+static enum hrtimer_restart
+intel_uncore_fw_release_timer(struct hrtimer *timer)
 {
-	struct intel_uncore_forcewake_domain *domain = (void *)arg;
+	struct intel_uncore_forcewake_domain *domain =
+	       container_of(timer, struct intel_uncore_forcewake_domain, timer);
 	unsigned long irqflags;
 
 	assert_rpm_device_not_suspended(domain->i915);
@@ -240,6 +246,8 @@ static void intel_uncore_fw_release_timer(unsigned long arg)
 							  1 << domain->id);
 
 	spin_unlock_irqrestore(&domain->i915->uncore.lock, irqflags);
+
+	return HRTIMER_NORESTART;
 }
 
 void intel_uncore_forcewake_reset(struct drm_device *dev, bool restore)
@@ -259,16 +267,16 @@ void intel_uncore_forcewake_reset(struct drm_device *dev, bool restore)
 		active_domains = 0;
 
 		for_each_fw_domain(domain, dev_priv, id) {
-			if (del_timer_sync(&domain->timer) == 0)
+			if (hrtimer_cancel(&domain->timer) == 0)
 				continue;
 
-			intel_uncore_fw_release_timer((unsigned long)domain);
+			intel_uncore_fw_release_timer(&domain->timer);
 		}
 
 		spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 		for_each_fw_domain(domain, dev_priv, id) {
-			if (timer_pending(&domain->timer))
+			if (hrtimer_active(&domain->timer))
 				active_domains |= (1 << id);
 		}
 
@@ -491,7 +499,6 @@ static void __intel_uncore_forcewake_put(struct drm_i915_private *dev_priv,
 		if (--domain->wake_count)
 			continue;
 
-		domain->wake_count++;
 		fw_domain_arm_timer(domain);
 	}
 }
@@ -732,7 +739,6 @@ static inline void __force_wake_get(struct drm_i915_private *dev_priv,
 			continue;
 		}
 
-		domain->wake_count++;
 		fw_domain_arm_timer(domain);
 	}
 
@@ -1150,7 +1156,8 @@ static void fw_domain_init(struct drm_i915_private *dev_priv,
 	d->i915 = dev_priv;
 	d->id = domain_id;
 
-	setup_timer(&d->timer, intel_uncore_fw_release_timer, (unsigned long)d);
+	hrtimer_init(&d->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	d->timer.function = intel_uncore_fw_release_timer;
 
 	dev_priv->uncore.fw_domains |= (1 << domain_id);
 
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 03ddf0ecf402..684087db170b 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1068,8 +1068,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	jz4740_mmc_clock_disable(host);
 	setup_timer(&host->timeout_timer, jz4740_mmc_timeout,
 			(unsigned long)host);
-	/* It is not important when it times out, it just needs to timeout. */
-	set_timer_slack(&host->timeout_timer, HZ);
 
 	host->use_dma = true;
 	if (host->use_dma && jz4740_mmc_acquire_dma_channels(host) != 0)
diff --git a/drivers/net/ethernet/tile/tilepro.c b/drivers/net/ethernet/tile/tilepro.c
index 298e059d0498..ea5d774fc89b 100644
--- a/drivers/net/ethernet/tile/tilepro.c
+++ b/drivers/net/ethernet/tile/tilepro.c
@@ -588,7 +588,7 @@ static bool tile_net_lepp_free_comps(struct net_device *dev, bool all)
 static void tile_net_schedule_egress_timer(struct tile_net_cpu *info)
 {
 	if (!info->egress_timer_scheduled) {
-		mod_timer_pinned(&info->egress_timer, jiffies + 1);
+		mod_timer(&info->egress_timer, jiffies + 1);
 		info->egress_timer_scheduled = true;
 	}
 }
@@ -1004,7 +1004,7 @@ static void tile_net_register(void *dev_ptr)
 		BUG();
 
 	/* Initialize the egress timer. */
-	init_timer(&info->egress_timer);
+	init_timer_pinned(&info->egress_timer);
 	info->egress_timer.data = (long)info;
 	info->egress_timer.function = tile_net_handle_egress_timer;
 
diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 45f6ebf88df6..e90b3f307e0f 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -735,11 +735,8 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 
 	bq27xxx_battery_update(di);
 
-	if (poll_interval > 0) {
-		/* The timer does not have to be accurate. */
-		set_timer_slack(&di->work.timer, poll_interval * HZ / 4);
+	if (poll_interval > 0)
 		schedule_delayed_work(&di->work, poll_interval * HZ);
-	}
 }
 
 /*
diff --git a/drivers/tty/metag_da.c b/drivers/tty/metag_da.c
index 9325262289f9..25ccef2fe748 100644
--- a/drivers/tty/metag_da.c
+++ b/drivers/tty/metag_da.c
@@ -323,12 +323,12 @@ static void dashtty_timer(unsigned long ignored)
 	if (channel >= 0)
 		fetch_data(channel);
 
-	mod_timer_pinned(&poll_timer, jiffies + DA_TTY_POLL);
+	mod_timer(&poll_timer, jiffies + DA_TTY_POLL);
 }
 
 static void add_poll_timer(struct timer_list *poll_timer)
 {
-	setup_timer(poll_timer, dashtty_timer, 0);
+	setup_pinned_timer(poll_timer, dashtty_timer, 0);
 	poll_timer->expires = jiffies + DA_TTY_POLL;
 
 	/*
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index a119176a1855..234123b0c642 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -689,7 +689,7 @@ static void mips_ejtag_fdc_tty_timer(unsigned long opaque)
 
 	mips_ejtag_fdc_handle(priv);
 	if (!priv->removing)
-		mod_timer_pinned(&priv->poll_timer, jiffies + FDC_TTY_POLL);
+		mod_timer(&priv->poll_timer, jiffies + FDC_TTY_POLL);
 }
 
 /* TTY Port operations */
@@ -1002,7 +1002,7 @@ static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
 		raw_spin_unlock_irq(&priv->lock);
 	} else {
 		/* If we didn't get an usable IRQ, poll instead */
-		setup_timer(&priv->poll_timer, mips_ejtag_fdc_tty_timer,
+		setup_pinned_timer(&priv->poll_timer, mips_ejtag_fdc_tty_timer,
 			    (unsigned long)priv);
 		priv->poll_timer.expires = jiffies + FDC_TTY_POLL;
 		/*
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 04dcedfdebf8..86919ec47163 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -500,7 +500,6 @@ static int ohci_init (struct ohci_hcd *ohci)
 
 	setup_timer(&ohci->io_watchdog, io_watchdog_func,
 			(unsigned long) ohci);
-	set_timer_slack(&ohci->io_watchdog, msecs_to_jiffies(20));
 
 	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
 			sizeof(*ohci->hcca), &ohci->hcca_dma, GFP_KERNEL);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 327280535848..7901a685b8de 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -490,8 +490,6 @@ static void compliance_mode_recovery_timer_init(struct xhci_hcd *xhci)
 	xhci->comp_mode_recovery_timer.expires = jiffies +
 			msecs_to_jiffies(COMP_MODE_RCVRY_MSECS);
 
-	set_timer_slack(&xhci->comp_mode_recovery_timer,
-			msecs_to_jiffies(COMP_MODE_RCVRY_MSECS));
 	add_timer(&xhci->comp_mode_recovery_timer);
 	xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 			"Compliance mode recovery timer initialized");
diff --git a/include/linux/list.h b/include/linux/list.h
index 5356f4d661a7..3df0783a25e4 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -679,6 +679,16 @@ static inline bool hlist_fake(struct hlist_node *h)
 }
 
 /*
+ * Check whether the node is the only node of the head without
+ * accessing head.
+ */
+static inline bool hlist_is_singular_node(struct hlist_node *n,
+					  struct hlist_head *h)
+{
+	return !n->next && n->pprev == &h->first;
+}
+
+/*
  * Move a list from one list head to another. Fixup the pprev
  * reference of the first entry if it exists.
  */
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 299d2b78591f..a915acbd0072 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -19,7 +19,6 @@ struct timer_list {
 	void			(*function)(unsigned long);
 	unsigned long		data;
 	u32			flags;
-	int			slack;
 
 #ifdef CONFIG_TIMER_STATS
 	int			start_pid;
@@ -58,11 +57,14 @@ struct timer_list {
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
  */
-#define TIMER_CPUMASK		0x0007FFFF
-#define TIMER_MIGRATING		0x00080000
+#define TIMER_CPUMASK		0x0003FFFF
+#define TIMER_MIGRATING		0x00040000
 #define TIMER_BASEMASK		(TIMER_CPUMASK | TIMER_MIGRATING)
-#define TIMER_DEFERRABLE	0x00100000
+#define TIMER_DEFERRABLE	0x00080000
+#define TIMER_PINNED		0x00100000
 #define TIMER_IRQSAFE		0x00200000
+#define TIMER_ARRAYSHIFT	22
+#define TIMER_ARRAYMASK		0xFFC00000
 
 #define __TIMER_INITIALIZER(_function, _expires, _data, _flags) { \
 		.entry = { .next = TIMER_ENTRY_STATIC },	\
@@ -70,7 +72,6 @@ struct timer_list {
 		.expires = (_expires),				\
 		.data = (_data),				\
 		.flags = (_flags),				\
-		.slack = -1,					\
 		__TIMER_LOCKDEP_MAP_INITIALIZER(		\
 			__FILE__ ":" __stringify(__LINE__))	\
 	}
@@ -78,9 +79,15 @@ struct timer_list {
 #define TIMER_INITIALIZER(_function, _expires, _data)		\
 	__TIMER_INITIALIZER((_function), (_expires), (_data), 0)
 
+#define TIMER_PINNED_INITIALIZER(_function, _expires, _data)	\
+	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_PINNED)
+
 #define TIMER_DEFERRED_INITIALIZER(_function, _expires, _data)	\
 	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_DEFERRABLE)
 
+#define TIMER_PINNED_DEFERRED_INITIALIZER(_function, _expires, _data)	\
+	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_DEFERRABLE | TIMER_PINNED)
+
 #define DEFINE_TIMER(_name, _function, _expires, _data)		\
 	struct timer_list _name =				\
 		TIMER_INITIALIZER(_function, _expires, _data)
@@ -124,8 +131,12 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 
 #define init_timer(timer)						\
 	__init_timer((timer), 0)
+#define init_timer_pinned(timer)					\
+	__init_timer((timer), TIMER_PINNED)
 #define init_timer_deferrable(timer)					\
 	__init_timer((timer), TIMER_DEFERRABLE)
+#define init_timer_pinned_deferrable(timer)				\
+	__init_timer((timer), TIMER_DEFERRABLE | TIMER_PINNED)
 #define init_timer_on_stack(timer)					\
 	__init_timer_on_stack((timer), 0)
 
@@ -145,10 +156,20 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 
 #define setup_timer(timer, fn, data)					\
 	__setup_timer((timer), (fn), (data), 0)
+#define setup_pinned_timer(timer, fn, data)				\
+	__setup_timer((timer), (fn), (data), TIMER_PINNED)
+#define setup_deferrable_timer(timer, fn, data)				\
+	__setup_timer((timer), (fn), (data), TIMER_DEFERRABLE)
+#define setup_pinned_deferrable_timer(timer, fn, data)			\
+	__setup_timer((timer), (fn), (data), TIMER_DEFERRABLE | TIMER_PINNED)
 #define setup_timer_on_stack(timer, fn, data)				\
 	__setup_timer_on_stack((timer), (fn), (data), 0)
+#define setup_pinned_timer_on_stack(timer, fn, data)			\
+	__setup_timer_on_stack((timer), (fn), (data), TIMER_PINNED)
 #define setup_deferrable_timer_on_stack(timer, fn, data)		\
 	__setup_timer_on_stack((timer), (fn), (data), TIMER_DEFERRABLE)
+#define setup_pinned_deferrable_timer_on_stack(timer, fn, data)		\
+	__setup_timer_on_stack((timer), (fn), (data), TIMER_DEFERRABLE | TIMER_PINNED)
 
 /**
  * timer_pending - is a timer pending?
@@ -169,12 +190,7 @@ extern void add_timer_on(struct timer_list *timer, int cpu);
 extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
-extern int mod_timer_pinned(struct timer_list *timer, unsigned long expires);
 
-extern void set_timer_slack(struct timer_list *time, int slack_hz);
-
-#define TIMER_NOT_PINNED	0
-#define TIMER_PINNED		1
 /*
  * The jiffies value which is added to now, when there is no timer
  * in the timer wheel:
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 12cb3bb40c1c..be586c632a0c 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -33,19 +33,6 @@ struct trace_enum_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
-/*
- * The preempt count recorded in trace_event_raw_event_# are off by one due to
- * rcu_read_lock_sched_notrace() in __DO_TRACE. This is corrected here.
- */
-static inline int event_preempt_count(void)
-{
-#ifdef CONFIG_PREEMPT
-	return preempt_count() - 1;
-#else
-	return 0;
-#endif
-}
-
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 58040375efe3..140ee06079b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3521,7 +3521,7 @@ static __always_inline int preemptible_lazy(void)
 
 #else
 
-static int preemptible_lazy(void)
+static inline int preemptible_lazy(void)
 {
 	return 1;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index cacc654a243c..0a625c7b8792 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2837,23 +2837,18 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
  *  @ts: upper bound on process time suspension
  */
 int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
-			const struct timespec *ts)
+		    const struct timespec *ts)
 {
+	ktime_t *to = NULL, timeout = { .tv64 = KTIME_MAX };
 	struct task_struct *tsk = current;
-	long timeout = MAX_SCHEDULE_TIMEOUT;
 	sigset_t mask = *which;
-	int sig;
+	int sig, ret = 0;
 
 	if (ts) {
 		if (!timespec_valid(ts))
 			return -EINVAL;
-		timeout = timespec_to_jiffies(ts);
-		/*
-		 * We can be close to the next tick, add another one
-		 * to ensure we will wait at least the time asked for.
-		 */
-		if (ts->tv_sec || ts->tv_nsec)
-			timeout++;
+		timeout = timespec_to_ktime(*ts);
+		to = &timeout;
 	}
 
 	/*
@@ -2864,7 +2859,7 @@ int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 
 	spin_lock_irq(&tsk->sighand->siglock);
 	sig = dequeue_signal(tsk, &mask, info);
-	if (!sig && timeout) {
+	if (!sig && timeout.tv64) {
 		/*
 		 * None ready, temporarily unblock those we're interested
 		 * while we are sleeping in so that we'll be awakened when
@@ -2876,8 +2871,9 @@ int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 		recalc_sigpending();
 		spin_unlock_irq(&tsk->sighand->siglock);
 
-		timeout = freezable_schedule_timeout_interruptible(timeout);
-
+		__set_current_state(TASK_INTERRUPTIBLE);
+		ret = freezable_schedule_hrtimeout_range(to, tsk->timer_slack_ns,
+							 HRTIMER_MODE_REL);
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
@@ -2887,7 +2883,7 @@ int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 
 	if (sig)
 		return sig;
-	return timeout ? -EINTR : -EAGAIN;
+	return ret ? -EINTR : -EAGAIN;
 }
 
 /**
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 966a5a6fdd0a..f738251000fe 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -164,3 +164,4 @@ static inline void timers_update_migration(bool update_nohz) { }
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+void timer_clear_idle(void);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8b005db22760..6fc9a5fdd5f4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -706,6 +706,12 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 	delta = next_tick - basemono;
 	if (delta <= (u64)TICK_NSEC) {
 		tick.tv64 = 0;
+
+		/*
+		 * Tell the timer code that the base is not idle, i.e. undo
+		 * the effect of get_next_timer_interrupt().
+		 */
+		timer_clear_idle();
 		/*
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
@@ -814,6 +820,12 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now, int
 	tick_do_update_jiffies64(now);
 	update_cpu_load_nohz(active);
 
+	/*
+	 * Clear the timer idle flag, so we avoid IPIs on remote queueing and
+	 * the clock forward checks in the enqueue path.
+	 */
+	timer_clear_idle();
+
 	calc_load_exit_idle();
 	touch_softlockup_watchdog_sched();
 	/*
@@ -1090,35 +1102,6 @@ static void tick_nohz_switch_to_nohz(void)
 	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
 }
 
-/*
- * When NOHZ is enabled and the tick is stopped, we need to kick the
- * tick timer from irq_enter() so that the jiffies update is kept
- * alive during long running softirqs. That's ugly as hell, but
- * correctness is key even if we need to fix the offending softirq in
- * the first place.
- *
- * Note, this is different to tick_nohz_restart. We just kick the
- * timer and do not touch the other magic bits which need to be done
- * when idle is left.
- */
-static void tick_nohz_kick_tick(struct tick_sched *ts, ktime_t now)
-{
-#if 0
-	/* Switch back to 2.6.27 behaviour */
-	ktime_t delta;
-
-	/*
-	 * Do not touch the tick device, when the next expiry is either
-	 * already reached or less/equal than the tick period.
-	 */
-	delta =	ktime_sub(hrtimer_get_expires(&ts->sched_timer), now);
-	if (delta.tv64 <= tick_period.tv64)
-		return;
-
-	tick_nohz_restart(ts, now);
-#endif
-}
-
 static inline void tick_nohz_irq_enter(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
@@ -1129,10 +1112,8 @@ static inline void tick_nohz_irq_enter(void)
 	now = ktime_get();
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
-	if (ts->tick_stopped) {
+	if (ts->tick_stopped)
 		tick_nohz_update_jiffies(now);
-		tick_nohz_kick_tick(ts, now);
-	}
 }
 
 #else
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 716ef84a5d87..b1d2d4026cfe 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -59,46 +59,156 @@ __visible u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 EXPORT_SYMBOL(jiffies_64);
 
 /*
- * per-CPU timer vector definitions:
+ * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
+ * LVL_SIZE buckets. Each level is driven by its own clock and therefor each
+ * level has a different granularity.
+ *
+ * The level granularity is:		LVL_CLK_DIV ^ lvl
+ * The level clock frequency is:	HZ / (LVL_CLK_DIV ^ level)
+ *
+ * The array level of a newly armed timer depends on the relative expiry
+ * time. The farther the expiry time is away the higher the array level and
+ * therefor the granularity becomes.
+ *
+ * Contrary to the original timer wheel implementation, which aims for 'exact'
+ * expiry of the timers, this implementation removes the need for recascading
+ * the timers into the lower array levels. The previous 'classic' timer wheel
+ * implementation of the kernel already violated the 'exact' expiry by adding
+ * slack to the expiry time to provide batched expiration. The granularity
+ * levels provide implicit batching.
+ *
+ * This is an optimization of the original timer wheel implementation for the
+ * majority of the timer wheel use cases: timeouts. The vast majority of
+ * timeout timers (networking, disk I/O ...) are canceled before expiry. If
+ * the timeout expires it indicates that normal operation is disturbed, so it
+ * does not matter much whether the timeout comes with a slight delay.
+ *
+ * The only exception to this are networking timers with a small expiry
+ * time. They rely on the granularity. Those fit into the first wheel level,
+ * which has HZ granularity.
+ *
+ * We don't have cascading anymore. timers with a expiry time above the
+ * capacity of the last wheel level are force expired at the maximum timeout
+ * value of the last wheel level. From data sampling we know that the maximum
+ * value observed is 5 days (network connection tracking), so this should not
+ * be an issue.
+ *
+ * The currently chosen array constants values are a good compromise between
+ * array size and granularity.
+ *
+ * This results in the following granularity and range levels:
+ *
+ * HZ 1000 steps
+ * Level Offset  Granularity            Range
+ *  0      0         1 ms                0 ms -         63 ms
+ *  1     64         8 ms               64 ms -        511 ms
+ *  2    128        64 ms              512 ms -       4095 ms (512ms - ~4s)
+ *  3    192       512 ms             4096 ms -      32767 ms (~4s - ~32s)
+ *  4    256      4096 ms (~4s)      32768 ms -     262143 ms (~32s - ~4m)
+ *  5    320     32768 ms (~32s)    262144 ms -    2097151 ms (~4m - ~34m)
+ *  6    384    262144 ms (~4m)    2097152 ms -   16777215 ms (~34m - ~4h)
+ *  7    448   2097152 ms (~34m)  16777216 ms -  134217727 ms (~4h - ~1d)
+ *  8    512  16777216 ms (~4h)  134217728 ms - 1073741822 ms (~1d - ~12d)
+ *
+ * HZ  300
+ * Level Offset  Granularity            Range
+ *  0	   0         3 ms                0 ms -        210 ms
+ *  1	  64        26 ms              213 ms -       1703 ms (213ms - ~1s)
+ *  2	 128       213 ms             1706 ms -      13650 ms (~1s - ~13s)
+ *  3	 192      1706 ms (~1s)      13653 ms -     109223 ms (~13s - ~1m)
+ *  4	 256     13653 ms (~13s)    109226 ms -     873810 ms (~1m - ~14m)
+ *  5	 320    109226 ms (~1m)     873813 ms -    6990503 ms (~14m - ~1h)
+ *  6	 384    873813 ms (~14m)   6990506 ms -   55924050 ms (~1h - ~15h)
+ *  7	 448   6990506 ms (~1h)   55924053 ms -  447392423 ms (~15h - ~5d)
+ *  8    512  55924053 ms (~15h) 447392426 ms - 3579139406 ms (~5d - ~41d)
+ *
+ * HZ  250
+ * Level Offset  Granularity            Range
+ *  0	   0         4 ms                0 ms -        255 ms
+ *  1	  64        32 ms              256 ms -       2047 ms (256ms - ~2s)
+ *  2	 128       256 ms             2048 ms -      16383 ms (~2s - ~16s)
+ *  3	 192      2048 ms (~2s)      16384 ms -     131071 ms (~16s - ~2m)
+ *  4	 256     16384 ms (~16s)    131072 ms -    1048575 ms (~2m - ~17m)
+ *  5	 320    131072 ms (~2m)    1048576 ms -    8388607 ms (~17m - ~2h)
+ *  6	 384   1048576 ms (~17m)   8388608 ms -   67108863 ms (~2h - ~18h)
+ *  7	 448   8388608 ms (~2h)   67108864 ms -  536870911 ms (~18h - ~6d)
+ *  8    512  67108864 ms (~18h) 536870912 ms - 4294967288 ms (~6d - ~49d)
+ *
+ * HZ  100
+ * Level Offset  Granularity            Range
+ *  0	   0         10 ms               0 ms -        630 ms
+ *  1	  64         80 ms             640 ms -       5110 ms (640ms - ~5s)
+ *  2	 128        640 ms            5120 ms -      40950 ms (~5s - ~40s)
+ *  3	 192       5120 ms (~5s)     40960 ms -     327670 ms (~40s - ~5m)
+ *  4	 256      40960 ms (~40s)   327680 ms -    2621430 ms (~5m - ~43m)
+ *  5	 320     327680 ms (~5m)   2621440 ms -   20971510 ms (~43m - ~5h)
+ *  6	 384    2621440 ms (~43m) 20971520 ms -  167772150 ms (~5h - ~1d)
+ *  7	 448   20971520 ms (~5h) 167772160 ms - 1342177270 ms (~1d - ~15d)
  */
-#define TVN_BITS (CONFIG_BASE_SMALL ? 4 : 6)
-#define TVR_BITS (CONFIG_BASE_SMALL ? 6 : 8)
-#define TVN_SIZE (1 << TVN_BITS)
-#define TVR_SIZE (1 << TVR_BITS)
-#define TVN_MASK (TVN_SIZE - 1)
-#define TVR_MASK (TVR_SIZE - 1)
-#define MAX_TVAL ((unsigned long)((1ULL << (TVR_BITS + 4*TVN_BITS)) - 1))
 
-struct tvec {
-	struct hlist_head vec[TVN_SIZE];
-};
+/* Clock divisor for the next level */
+#define LVL_CLK_SHIFT	3
+#define LVL_CLK_DIV	(1UL << LVL_CLK_SHIFT)
+#define LVL_CLK_MASK	(LVL_CLK_DIV - 1)
+#define LVL_SHIFT(n)	((n) * LVL_CLK_SHIFT)
+#define LVL_GRAN(n)	(1UL << LVL_SHIFT(n))
 
-struct tvec_root {
-	struct hlist_head vec[TVR_SIZE];
-};
+/*
+ * The time start value for each level to select the bucket at enqueue
+ * time.
+ */
+#define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
 
-struct tvec_base {
-	spinlock_t lock;
-	struct timer_list *running_timer;
-#ifdef CONFIG_PREEMPT_RT_FULL
-	wait_queue_head_t wait_for_running_timer;
+/* Size of each clock level */
+#define LVL_BITS	6
+#define LVL_SIZE	(1UL << LVL_BITS)
+#define LVL_MASK	(LVL_SIZE - 1)
+#define LVL_OFFS(n)	((n) * LVL_SIZE)
+
+/* Level depth */
+#if HZ > 100
+# define LVL_DEPTH	9
+# else
+# define LVL_DEPTH	8
 #endif
-	unsigned long timer_jiffies;
-	unsigned long next_timer;
-	unsigned long active_timers;
-	unsigned long all_timers;
-	int cpu;
-	bool migration_enabled;
-	bool nohz_active;
-	struct tvec_root tv1;
-	struct tvec tv2;
-	struct tvec tv3;
-	struct tvec tv4;
-	struct tvec tv5;
+
+/* The cutoff (max. capacity of the wheel) */
+#define WHEEL_TIMEOUT_CUTOFF	(LVL_START(LVL_DEPTH))
+#define WHEEL_TIMEOUT_MAX	(WHEEL_TIMEOUT_CUTOFF - LVL_GRAN(LVL_DEPTH - 1))
+
+/*
+ * The resulting wheel size. If NOHZ is configured we allocate two
+ * wheels so we have a separate storage for the deferrable timers.
+ */
+#define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
+
+#ifdef CONFIG_NO_HZ_COMMON
+# define NR_BASES	2
+# define BASE_STD	0
+# define BASE_DEF	1
+#else
+# define NR_BASES	1
+# define BASE_STD	0
+# define BASE_DEF	0
+#endif
+
+struct timer_base {
+	raw_spinlock_t		lock;
+	struct timer_list	*running_timer;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	struct swait_queue_head	wait_for_running_timer;
+#endif
+	unsigned long		clk;
+	unsigned long		next_expiry;
+	unsigned int		cpu;
+	bool			migration_enabled;
+	bool			nohz_active;
+	bool			is_idle;
+	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
+	struct hlist_head	vectors[WHEEL_SIZE];
 } ____cacheline_aligned;
 
-
-static DEFINE_PER_CPU(struct tvec_base, tvec_bases);
+static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 unsigned int sysctl_timer_migration = 1;
@@ -109,15 +219,17 @@ void timers_update_migration(bool update_nohz)
 	unsigned int cpu;
 
 	/* Avoid the loop, if nothing to update */
-	if (this_cpu_read(tvec_bases.migration_enabled) == on)
+	if (this_cpu_read(timer_bases[BASE_STD].migration_enabled) == on)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		per_cpu(tvec_bases.migration_enabled, cpu) = on;
+		per_cpu(timer_bases[BASE_STD].migration_enabled, cpu) = on;
+		per_cpu(timer_bases[BASE_DEF].migration_enabled, cpu) = on;
 		per_cpu(hrtimer_bases.migration_enabled, cpu) = on;
 		if (!update_nohz)
 			continue;
-		per_cpu(tvec_bases.nohz_active, cpu) = true;
+		per_cpu(timer_bases[BASE_STD].nohz_active, cpu) = true;
+		per_cpu(timer_bases[BASE_DEF].nohz_active, cpu) = true;
 		per_cpu(hrtimer_bases.nohz_active, cpu) = true;
 	}
 }
@@ -136,20 +248,6 @@ int timer_migration_handler(struct ctl_table *table, int write,
 	mutex_unlock(&mutex);
 	return ret;
 }
-
-static inline struct tvec_base *get_target_base(struct tvec_base *base,
-						int pinned)
-{
-	if (pinned || !base->migration_enabled)
-		return this_cpu_ptr(&tvec_bases);
-	return per_cpu_ptr(&tvec_bases, get_nohz_timer_target());
-}
-#else
-static inline struct tvec_base *get_target_base(struct tvec_base *base,
-						int pinned)
-{
-	return this_cpu_ptr(&tvec_bases);
-}
 #endif
 
 static unsigned long round_jiffies_common(unsigned long j, int cpu,
@@ -354,101 +452,126 @@ unsigned long round_jiffies_up_relative(unsigned long j)
 }
 EXPORT_SYMBOL_GPL(round_jiffies_up_relative);
 
-/**
- * set_timer_slack - set the allowed slack for a timer
- * @timer: the timer to be modified
- * @slack_hz: the amount of time (in jiffies) allowed for rounding
- *
- * Set the amount of time, in jiffies, that a certain timer has
- * in terms of slack. By setting this value, the timer subsystem
- * will schedule the actual timer somewhere between
- * the time mod_timer() asks for, and that time plus the slack.
- *
- * By setting the slack to -1, a percentage of the delay is used
- * instead.
- */
-void set_timer_slack(struct timer_list *timer, int slack_hz)
+
+static inline unsigned int timer_get_idx(struct timer_list *timer)
 {
-	timer->slack = slack_hz;
+	return (timer->flags & TIMER_ARRAYMASK) >> TIMER_ARRAYSHIFT;
+}
+
+static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
+{
+	timer->flags = (timer->flags & ~TIMER_ARRAYMASK) |
+			idx << TIMER_ARRAYSHIFT;
+}
+
+/*
+ * Helper function to calculate the array index for a given expiry
+ * time.
+ */
+static inline unsigned calc_index(unsigned expires, unsigned lvl)
+{
+	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
+	return LVL_OFFS(lvl) + (expires & LVL_MASK);
+}
+
+static int calc_wheel_index(unsigned long expires, unsigned long clk)
+{
+	unsigned long delta = expires - clk;
+	unsigned int idx;
+
+	if (delta < LVL_START(1)) {
+		idx = calc_index(expires, 0);
+	} else if (delta < LVL_START(2)) {
+		idx = calc_index(expires, 1);
+	} else if (delta < LVL_START(3)) {
+		idx = calc_index(expires, 2);
+	} else if (delta < LVL_START(4)) {
+		idx = calc_index(expires, 3);
+	} else if (delta < LVL_START(5)) {
+		idx = calc_index(expires, 4);
+	} else if (delta < LVL_START(6)) {
+		idx = calc_index(expires, 5);
+	} else if (delta < LVL_START(7)) {
+		idx = calc_index(expires, 6);
+	} else if (LVL_DEPTH > 8 && delta < LVL_START(8)) {
+		idx = calc_index(expires, 7);
+	} else if ((long) delta < 0) {
+		idx = clk & LVL_MASK;
+	} else {
+		/*
+		 * Force expire obscene large timeouts to expire at the
+		 * capacity limit of the wheel.
+		 */
+		if (expires >= WHEEL_TIMEOUT_CUTOFF)
+			expires = WHEEL_TIMEOUT_MAX;
+
+		idx = calc_index(expires, LVL_DEPTH - 1);
+	}
+	return idx;
+}
+
+/*
+ * Enqueue the timer into the hash bucket, mark it pending in
+ * the bitmap and store the index in the timer flags.
+ */
+static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
+			  unsigned int idx)
+{
+	hlist_add_head(&timer->entry, base->vectors + idx);
+	__set_bit(idx, base->pending_map);
+	timer_set_idx(timer, idx);
 }
-EXPORT_SYMBOL_GPL(set_timer_slack);
 
 static void
-__internal_add_timer(struct tvec_base *base, struct timer_list *timer)
+__internal_add_timer(struct timer_base *base, struct timer_list *timer)
 {
-	unsigned long expires = timer->expires;
-	unsigned long idx = expires - base->timer_jiffies;
-	struct hlist_head *vec;
+	unsigned int idx;
 
-	if (idx < TVR_SIZE) {
-		int i = expires & TVR_MASK;
-		vec = base->tv1.vec + i;
-	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
-		int i = (expires >> TVR_BITS) & TVN_MASK;
-		vec = base->tv2.vec + i;
-	} else if (idx < 1 << (TVR_BITS + 2 * TVN_BITS)) {
-		int i = (expires >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
-		vec = base->tv3.vec + i;
-	} else if (idx < 1 << (TVR_BITS + 3 * TVN_BITS)) {
-		int i = (expires >> (TVR_BITS + 2 * TVN_BITS)) & TVN_MASK;
-		vec = base->tv4.vec + i;
-	} else if ((signed long) idx < 0) {
-		/*
-		 * Can happen if you add a timer with expires == jiffies,
-		 * or you set a timer to go off in the past
-		 */
-		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
-	} else {
-		int i;
-		/* If the timeout is larger than MAX_TVAL (on 64-bit
-		 * architectures or with CONFIG_BASE_SMALL=1) then we
-		 * use the maximum timeout.
-		 */
-		if (idx > MAX_TVAL) {
-			idx = MAX_TVAL;
-			expires = idx + base->timer_jiffies;
-		}
-		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
-		vec = base->tv5.vec + i;
-	}
-
-	hlist_add_head(&timer->entry, vec);
+	idx = calc_wheel_index(timer->expires, base->clk);
+	enqueue_timer(base, timer, idx);
 }
 
-static void internal_add_timer(struct tvec_base *base, struct timer_list *timer)
+static void
+trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 {
-	/* Advance base->jiffies, if the base is empty */
-	if (!base->all_timers++)
-		base->timer_jiffies = jiffies;
-
-	__internal_add_timer(base, timer);
-	/*
-	 * Update base->active_timers and base->next_timer
-	 */
-	if (!(timer->flags & TIMER_DEFERRABLE)) {
-		if (!base->active_timers++ ||
-		    time_before(timer->expires, base->next_timer))
-			base->next_timer = timer->expires;
-	}
+	if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
+		return;
 
 	/*
-	 * Check whether the other CPU is in dynticks mode and needs
-	 * to be triggered to reevaluate the timer wheel.
-	 * We are protected against the other CPU fiddling
-	 * with the timer by holding the timer base lock. This also
-	 * makes sure that a CPU on the way to stop its tick can not
-	 * evaluate the timer wheel.
-	 *
-	 * Spare the IPI for deferrable timers on idle targets though.
-	 * The next busy ticks will take care of it. Except full dynticks
-	 * require special care against races with idle_cpu(), lets deal
-	 * with that later.
+	 * This wants some optimizing similar to the below, but we do that
+	 * when we switch from push to pull for deferrable timers.
 	 */
-	if (base->nohz_active) {
-		if (!(timer->flags & TIMER_DEFERRABLE) ||
-		    tick_nohz_full_cpu(base->cpu))
+	if (timer->flags & TIMER_DEFERRABLE) {
+		if (tick_nohz_full_cpu(base->cpu))
 			wake_up_nohz_cpu(base->cpu);
+		return;
 	}
+
+	/*
+	 * We might have to IPI the remote CPU if the base is idle and the
+	 * timer is not deferrable. If the other cpu is on the way to idle
+	 * then it can't set base->is_idle as we hold base lock.
+	 */
+	if (!base->is_idle)
+		return;
+
+	/* Check whether this is the new first expiring timer */
+	if (time_after_eq(timer->expires, base->next_expiry))
+		return;
+
+	/*
+	 * Set the next expiry time and kick the cpu so it can reevaluate the
+	 * wheel
+	 */
+	base->next_expiry = timer->expires;
+		wake_up_nohz_cpu(base->cpu);
+}
+
+static void
+internal_add_timer(struct timer_base *base, struct timer_list *timer)
+{
+	__internal_add_timer(base, timer);
+	trigger_dyntick_cpu(base, timer);
 }
 
 #ifdef CONFIG_TIMER_STATS
@@ -684,7 +807,6 @@ static void do_init_timer(struct timer_list *timer, unsigned int flags,
 {
 	timer->entry.pprev = NULL;
 	timer->flags = flags | raw_smp_processor_id();
-	timer->slack = -1;
 #ifdef CONFIG_TIMER_STATS
 	timer->start_site = NULL;
 	timer->start_pid = -1;
@@ -724,104 +846,170 @@ static inline void detach_timer(struct timer_list *timer, bool clear_pending)
 	entry->next = LIST_POISON2;
 }
 
-static inline void
-detach_expired_timer(struct timer_list *timer, struct tvec_base *base)
-{
-	detach_timer(timer, true);
-	if (!(timer->flags & TIMER_DEFERRABLE))
-		base->active_timers--;
-	base->all_timers--;
-}
-
-static int detach_if_pending(struct timer_list *timer, struct tvec_base *base,
+static int detach_if_pending(struct timer_list *timer, struct timer_base *base,
 			     bool clear_pending)
 {
+	unsigned idx = timer_get_idx(timer);
+
 	if (!timer_pending(timer))
 		return 0;
 
+	if (hlist_is_singular_node(&timer->entry, base->vectors + idx))
+		__clear_bit(idx, base->pending_map);
+
 	detach_timer(timer, clear_pending);
-	if (!(timer->flags & TIMER_DEFERRABLE)) {
-		base->active_timers--;
-		if (timer->expires == base->next_timer)
-			base->next_timer = base->timer_jiffies;
-	}
-	/* If this was the last timer, advance base->jiffies */
-	if (!--base->all_timers)
-		base->timer_jiffies = jiffies;
 	return 1;
 }
 
+static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
+{
+	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_STD], cpu);
+
+	/*
+	 * If the timer is deferrable and nohz is active then we need to use
+	 * the deferrable base.
+	 */
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active &&
+	    (tflags & TIMER_DEFERRABLE))
+		base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
+	return base;
+}
+
+static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+
+	/*
+	 * If the timer is deferrable and nohz is active then we need to use
+	 * the deferrable base.
+	 */
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active &&
+	    (tflags & TIMER_DEFERRABLE))
+		base = this_cpu_ptr(&timer_bases[BASE_DEF]);
+	return base;
+}
+
+static inline struct timer_base *get_timer_base(u32 tflags)
+{
+	return get_timer_cpu_base(tflags, tflags & TIMER_CPUMASK);
+}
+
+#ifdef CONFIG_NO_HZ_COMMON
+static inline struct timer_base *__get_target_base(struct timer_base *base,
+						   unsigned tflags)
+{
+#ifdef CONFIG_SMP
+	if ((tflags & TIMER_PINNED) || !base->migration_enabled)
+		return get_timer_this_cpu_base(tflags);
+	return get_timer_cpu_base(tflags, get_nohz_timer_target());
+#else
+	return get_timer_this_cpu_base(tflags);
+#endif
+}
+
+static inline void forward_timer_base(struct timer_base *base)
+{
+	/*
+	 * We only forward the base when it's idle and we have a delta between
+	 * base clock and jiffies.
+	 */
+	if (!base->is_idle || (long) (jiffies - base->clk) < 2)
+		return;
+
+	/*
+	 * If the next expiry value is > jiffies, then we fast forward to
+	 * jiffies otherwise we forward to the next expiry value.
+	 */
+	if (time_after(base->next_expiry, jiffies))
+		base->clk = jiffies;
+	else
+		base->clk = base->next_expiry;
+}
+#else
+static inline struct timer_base *__get_target_base(struct timer_base *base,
+						   unsigned tflags)
+{
+	return get_timer_this_cpu_base(tflags);
+}
+
+static inline void forward_timer_base(struct timer_base *base) { }
+#endif
+
+static inline struct timer_base *get_target_base(struct timer_base *base,
+						 unsigned tflags)
+{
+	struct timer_base *target = __get_target_base(base, tflags);
+
+	forward_timer_base(target);
+	return target;
+}
+
 /*
- * We are using hashed locking: holding per_cpu(tvec_bases).lock
- * means that all timers which are tied to this base via timer->base are
- * locked, and the base itself is locked too.
+ * We are using hashed locking: Holding per_cpu(timer_bases[x]).lock means
+ * that all timers which are tied to this base are locked, and the base itself
+ * is locked too.
  *
  * So __run_timers/migrate_timers can safely modify all timers which could
- * be found on ->tvX lists.
+ * be found in the base->vectors array.
  *
- * When the timer's base is locked and removed from the list, the
- * TIMER_MIGRATING flag is set, FIXME
+ * When a timer is migrating then the TIMER_MIGRATING flag is set and we need
+ * to wait until the migration is done.
  */
-static struct tvec_base *lock_timer_base(struct timer_list *timer,
-					unsigned long *flags)
+static struct timer_base *lock_timer_base(struct timer_list *timer,
+					  unsigned long *flags)
 	__acquires(timer->base->lock)
 {
 	for (;;) {
+		struct timer_base *base;
 		u32 tf = timer->flags;
-		struct tvec_base *base;
 
 		if (!(tf & TIMER_MIGRATING)) {
-			base = per_cpu_ptr(&tvec_bases, tf & TIMER_CPUMASK);
-			spin_lock_irqsave(&base->lock, *flags);
+			base = get_timer_base(tf);
+			raw_spin_lock_irqsave(&base->lock, *flags);
 			if (timer->flags == tf)
 				return base;
-			spin_unlock_irqrestore(&base->lock, *flags);
+			raw_spin_unlock_irqrestore(&base->lock, *flags);
 		}
 		cpu_relax();
 	}
 }
-#ifdef CONFIG_PREEMPT_RT_FULL
-static inline struct tvec_base *switch_timer_base(struct timer_list *timer,
-						  struct tvec_base *old,
-						  struct tvec_base *new)
-{
-	/*
-	 * We cannot do the below because we might be preempted and
-	 * then the preempter would see NULL and loop forever.
-	 */
-	if (spin_trylock(&new->lock)) {
-		WRITE_ONCE(timer->flags,
-			   (timer->flags & ~TIMER_BASEMASK) | new->cpu);
-		spin_unlock(&old->lock);
-		return new;
-	}
-	return old;
-}
-
-#else
-static inline struct tvec_base *switch_timer_base(struct timer_list *timer,
-						  struct tvec_base *old,
-						  struct tvec_base *new)
-{
-	/* See the comment in lock_timer_base() */
-	timer->flags |= TIMER_MIGRATING;
-
-	spin_unlock(&old->lock);
-	spin_lock(&new->lock);
-	WRITE_ONCE(timer->flags,
-		   (timer->flags & ~TIMER_BASEMASK) | new->cpu);
-	return new;
-}
-#endif
 
 static inline int
-__mod_timer(struct timer_list *timer, unsigned long expires,
-	    bool pending_only, int pinned)
+__mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 {
-	struct tvec_base *base, *new_base;
-	unsigned long flags;
+	struct timer_base *base, *new_base;
+	unsigned int idx = UINT_MAX;
+	unsigned long clk = 0, flags;
 	int ret = 0;
 
+	/*
+	 * This is a common optimization triggered by the networking code - if
+	 * the timer is re-modified to be the same thing or ends up in the
+	 * same array bucket then just return:
+	 */
+	if (timer_pending(timer)) {
+		if (timer->expires == expires)
+			return 1;
+		/*
+		 * Take the current timer_jiffies of base, but without holding
+		 * the lock!
+		 */
+		base = get_timer_base(timer->flags);
+		clk = base->clk;
+
+		idx = calc_wheel_index(expires, clk);
+
+		/*
+		 * Retrieve and compare the array index of the pending
+		 * timer. If it matches set the expiry to the new value so a
+		 * subsequent call will exit in the expires check above.
+		 */
+		if (idx == timer_get_idx(timer)) {
+			timer->expires = expires;
+			return 1;
+		}
+	}
+
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(!timer->function);
 
@@ -833,25 +1021,44 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 
 	debug_activate(timer, expires);
 
-	new_base = get_target_base(base, pinned);
+	new_base = get_target_base(base, timer->flags);
 
 	if (base != new_base) {
 		/*
-		 * We are trying to schedule the timer on the local CPU.
+		 * We are trying to schedule the timer on the new base.
 		 * However we can't change timer's base while it is running,
 		 * otherwise del_timer_sync() can't detect that the timer's
-		 * handler yet has not finished. This also guarantees that
-		 * the timer is serialized wrt itself.
+		 * handler yet has not finished. This also guarantees that the
+		 * timer is serialized wrt itself.
 		 */
-		if (likely(base->running_timer != timer))
-			base = switch_timer_base(timer, base, new_base);
+		if (likely(base->running_timer != timer)) {
+			/* See the comment in lock_timer_base() */
+			timer->flags |= TIMER_MIGRATING;
+
+			raw_spin_unlock(&base->lock);
+			base = new_base;
+			raw_spin_lock(&base->lock);
+			WRITE_ONCE(timer->flags,
+				   (timer->flags & ~TIMER_BASEMASK) | base->cpu);
+		}
 	}
 
 	timer->expires = expires;
-	internal_add_timer(base, timer);
+	/*
+	 * If idx was calculated above and the base time did not advance
+	 * between calculating idx and taking the lock, only enqueue_timer()
+	 * and trigger_dyntick_cpu() is required. Otherwise we need to
+	 * (re)calculate the wheel index via internal_add_timer().
+	 */
+	if (idx != UINT_MAX && clk == base->clk) {
+		enqueue_timer(base, timer, idx);
+		trigger_dyntick_cpu(base, timer);
+	} else {
+		internal_add_timer(base, timer);
+	}
 
 out_unlock:
-	spin_unlock_irqrestore(&base->lock, flags);
+	raw_spin_unlock_irqrestore(&base->lock, flags);
 
 	return ret;
 }
@@ -868,49 +1075,10 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
 {
-	return __mod_timer(timer, expires, true, TIMER_NOT_PINNED);
+	return __mod_timer(timer, expires, true);
 }
 EXPORT_SYMBOL(mod_timer_pending);
 
-/*
- * Decide where to put the timer while taking the slack into account
- *
- * Algorithm:
- *   1) calculate the maximum (absolute) time
- *   2) calculate the highest bit where the expires and new max are different
- *   3) use this bit to make a mask
- *   4) use the bitmask to round down the maximum time, so that all last
- *      bits are zeros
- */
-static inline
-unsigned long apply_slack(struct timer_list *timer, unsigned long expires)
-{
-	unsigned long expires_limit, mask;
-	int bit;
-
-	if (timer->slack >= 0) {
-		expires_limit = expires + timer->slack;
-	} else {
-		long delta = expires - jiffies;
-
-		if (delta < 256)
-			return expires;
-
-		expires_limit = expires + delta / 256;
-	}
-	mask = expires ^ expires_limit;
-	if (mask == 0)
-		return expires;
-
-	bit = __fls(mask);
-
-	mask = (1UL << bit) - 1;
-
-	expires_limit = expires_limit & ~(mask);
-
-	return expires_limit;
-}
-
 /**
  * mod_timer - modify a timer's timeout
  * @timer: the timer to be modified
@@ -933,49 +1101,11 @@ unsigned long apply_slack(struct timer_list *timer, unsigned long expires)
  */
 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	expires = apply_slack(timer, expires);
-
-	/*
-	 * This is a common optimization triggered by the
-	 * networking code - if the timer is re-modified
-	 * to be the same thing then just return:
-	 */
-	if (timer_pending(timer) && timer->expires == expires)
-		return 1;
-
-	return __mod_timer(timer, expires, false, TIMER_NOT_PINNED);
+	return __mod_timer(timer, expires, false);
 }
 EXPORT_SYMBOL(mod_timer);
 
 /**
- * mod_timer_pinned - modify a timer's timeout
- * @timer: the timer to be modified
- * @expires: new timeout in jiffies
- *
- * mod_timer_pinned() is a way to update the expire field of an
- * active timer (if the timer is inactive it will be activated)
- * and to ensure that the timer is scheduled on the current CPU.
- *
- * Note that this does not prevent the timer from being migrated
- * when the current CPU goes offline.  If this is a problem for
- * you, use CPU-hotplug notifiers to handle it correctly, for
- * example, cancelling the timer when the corresponding CPU goes
- * offline.
- *
- * mod_timer_pinned(timer, expires) is equivalent to:
- *
- *     del_timer(timer); timer->expires = expires; add_timer(timer);
- */
-int mod_timer_pinned(struct timer_list *timer, unsigned long expires)
-{
-	if (timer->expires == expires && timer_pending(timer))
-		return 1;
-
-	return __mod_timer(timer, expires, false, TIMER_PINNED);
-}
-EXPORT_SYMBOL(mod_timer_pinned);
-
-/**
  * add_timer - start a timer
  * @timer: the timer to be added
  *
@@ -1005,13 +1135,14 @@ EXPORT_SYMBOL(add_timer);
  */
 void add_timer_on(struct timer_list *timer, int cpu)
 {
-	struct tvec_base *new_base = per_cpu_ptr(&tvec_bases, cpu);
-	struct tvec_base *base;
+	struct timer_base *new_base, *base;
 	unsigned long flags;
 
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(timer_pending(timer) || !timer->function);
 
+	new_base = get_timer_cpu_base(timer->flags, cpu);
+
 	/*
 	 * If @timer was on a different CPU, it should be migrated with the
 	 * old base locked to prevent other operations proceeding with the
@@ -1021,16 +1152,16 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	if (base != new_base) {
 		timer->flags |= TIMER_MIGRATING;
 
-		spin_unlock(&base->lock);
+		raw_spin_unlock(&base->lock);
 		base = new_base;
-		spin_lock(&base->lock);
+		raw_spin_lock(&base->lock);
 		WRITE_ONCE(timer->flags,
 			   (timer->flags & ~TIMER_BASEMASK) | cpu);
 	}
 
 	debug_activate(timer, timer->expires);
 	internal_add_timer(base, timer);
-	spin_unlock_irqrestore(&base->lock, flags);
+	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
@@ -1040,18 +1171,18 @@ EXPORT_SYMBOL_GPL(add_timer_on);
  */
 static void wait_for_running_timer(struct timer_list *timer)
 {
-	struct tvec_base *base;
+	struct timer_base *base;
 	u32 tf = timer->flags;
 
 	if (tf & TIMER_MIGRATING)
 		return;
 
-	base = per_cpu_ptr(&tvec_bases, tf & TIMER_CPUMASK);
-	wait_event(base->wait_for_running_timer,
+	base = get_timer_base(tf);
+	swait_event(base->wait_for_running_timer,
 		   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)
+# define wakeup_timer_waiters(b)	swake_up_all(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
@@ -1074,7 +1205,7 @@ static inline void wait_for_running_timer(struct timer_list *timer)
  */
 int del_timer(struct timer_list *timer)
 {
-	struct tvec_base *base;
+	struct timer_base *base;
 	unsigned long flags;
 	int ret = 0;
 
@@ -1084,7 +1215,7 @@ int del_timer(struct timer_list *timer)
 	if (timer_pending(timer)) {
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
-		spin_unlock_irqrestore(&base->lock, flags);
+		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
 	return ret;
@@ -1100,7 +1231,7 @@ EXPORT_SYMBOL(del_timer);
  */
 int try_to_del_timer_sync(struct timer_list *timer)
 {
-	struct tvec_base *base;
+	struct timer_base *base;
 	unsigned long flags;
 	int ret = -1;
 
@@ -1112,7 +1243,7 @@ int try_to_del_timer_sync(struct timer_list *timer)
 		timer_stats_timer_clear_start_info(timer);
 		ret = detach_if_pending(timer, base, true);
 	}
-	spin_unlock_irqrestore(&base->lock, flags);
+	raw_spin_unlock_irqrestore(&base->lock, flags);
 
 	return ret;
 }
@@ -1184,27 +1315,6 @@ int del_timer_sync(struct timer_list *timer)
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 
-static int cascade(struct tvec_base *base, struct tvec *tv, int index)
-{
-	/* cascade all the timers from tv up one level */
-	struct timer_list *timer;
-	struct hlist_node *tmp;
-	struct hlist_head tv_list;
-
-	hlist_move_list(tv->vec + index, &tv_list);
-
-	/*
-	 * We are removing _all_ timers from the list, so we
-	 * don't have to detach them individually.
-	 */
-	hlist_for_each_entry_safe(timer, tmp, &tv_list, entry) {
-		/* No accounting, while moving them */
-		__internal_add_timer(base, timer);
-	}
-
-	return index;
-}
-
 static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
 			  unsigned long data)
 {
@@ -1248,149 +1358,144 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
 	}
 }
 
-#define INDEX(N) ((base->timer_jiffies >> (TVR_BITS + (N) * TVN_BITS)) & TVN_MASK)
-
-/**
- * __run_timers - run all expired timers (if any) on this CPU.
- * @base: the timer vector to be processed.
- *
- * This function cascades all vectors and executes all expired timer
- * vectors.
- */
-static inline void __run_timers(struct tvec_base *base)
+static void expire_timers(struct timer_base *base, struct hlist_head *head)
 {
-	struct timer_list *timer;
+	while (!hlist_empty(head)) {
+		struct timer_list *timer;
+		void (*fn)(unsigned long);
+		unsigned long data;
 
-	spin_lock_irq(&base->lock);
+		timer = hlist_entry(head->first, struct timer_list, entry);
+		timer_stats_account_timer(timer);
 
-	while (time_after_eq(jiffies, base->timer_jiffies)) {
-		struct hlist_head work_list;
-		struct hlist_head *head = &work_list;
-		int index;
+		base->running_timer = timer;
+		detach_timer(timer, true);
 
-		if (!base->all_timers) {
-			base->timer_jiffies = jiffies;
-			break;
-		}
+		fn = timer->function;
+		data = timer->data;
 
-		index = base->timer_jiffies & TVR_MASK;
-
-		/*
-		 * Cascade timers:
-		 */
-		if (!index &&
-			(!cascade(base, &base->tv2, INDEX(0))) &&
-				(!cascade(base, &base->tv3, INDEX(1))) &&
-					!cascade(base, &base->tv4, INDEX(2)))
-			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies;
-		hlist_move_list(base->tv1.vec + index, head);
-		while (!hlist_empty(head)) {
-			void (*fn)(unsigned long);
-			unsigned long data;
-			bool irqsafe;
-
-			timer = hlist_entry(head->first, struct timer_list, entry);
-			fn = timer->function;
-			data = timer->data;
-			irqsafe = timer->flags & TIMER_IRQSAFE;
-
-			timer_stats_account_timer(timer);
-
-			base->running_timer = timer;
-			detach_expired_timer(timer, base);
-
-			if (irqsafe) {
-				spin_unlock(&base->lock);
-				call_timer_fn(timer, fn, data);
-				base->running_timer = NULL;
-				spin_lock(&base->lock);
-			} else {
-				spin_unlock_irq(&base->lock);
-				call_timer_fn(timer, fn, data);
-				base->running_timer = NULL;
-				spin_lock_irq(&base->lock);
-			}
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
+		    timer->flags & TIMER_IRQSAFE) {
+			raw_spin_unlock(&base->lock);
+			call_timer_fn(timer, fn, data);
+			base->running_timer = NULL;
+			raw_spin_lock(&base->lock);
+		} else {
+			raw_spin_unlock_irq(&base->lock);
+			call_timer_fn(timer, fn, data);
+			base->running_timer = NULL;
+			raw_spin_lock_irq(&base->lock);
 		}
 	}
-	spin_unlock_irq(&base->lock);
-	wakeup_timer_waiters(base);
+}
+
+static int __collect_expired_timers(struct timer_base *base,
+				    struct hlist_head *heads)
+{
+	unsigned long clk = base->clk;
+	struct hlist_head *vec;
+	int i, levels = 0;
+	unsigned int idx;
+
+	for (i = 0; i < LVL_DEPTH; i++) {
+		idx = (clk & LVL_MASK) + i * LVL_SIZE;
+
+		if (__test_and_clear_bit(idx, base->pending_map)) {
+			vec = base->vectors + idx;
+			hlist_move_list(vec, heads++);
+			levels++;
+		}
+		/* Is it time to look at the next level? */
+		if (clk & LVL_CLK_MASK)
+			break;
+		/* Shift clock for the next level granularity */
+		clk >>= LVL_CLK_SHIFT;
+	}
+	return levels;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
 /*
- * Find out when the next timer event is due to happen. This
- * is used on S/390 to stop all activity when a CPU is idle.
- * This function needs to be called with interrupts disabled.
+ * Find the next pending bucket of a level. Search from level start (@offset)
+ * + @clk upwards and if nothing there, search from start of the level
+ * (@offset) up to @offset + clk.
  */
-static unsigned long __next_timer_interrupt(struct tvec_base *base)
+static int next_pending_bucket(struct timer_base *base, unsigned offset,
+			       unsigned clk)
 {
-	unsigned long timer_jiffies = base->timer_jiffies;
-	unsigned long expires = timer_jiffies + NEXT_TIMER_MAX_DELTA;
-	int index, slot, array, found = 0;
-	struct timer_list *nte;
-	struct tvec *varray[4];
+	unsigned pos, start = offset + clk;
+	unsigned end = offset + LVL_SIZE;
 
-	/* Look for timer events in tv1. */
-	index = slot = timer_jiffies & TVR_MASK;
-	do {
-		hlist_for_each_entry(nte, base->tv1.vec + slot, entry) {
-			if (nte->flags & TIMER_DEFERRABLE)
-				continue;
+	pos = find_next_bit(base->pending_map, end, start);
+	if (pos < end)
+		return pos - start;
 
-			found = 1;
-			expires = nte->expires;
-			/* Look at the cascade bucket(s)? */
-			if (!index || slot < index)
-				goto cascade;
-			return expires;
+	pos = find_next_bit(base->pending_map, start, offset);
+	return pos < start ? pos + LVL_SIZE - start : -1;
+}
+
+/*
+ * Search the first expiring timer in the various clock levels. Caller must
+ * hold base->lock.
+ */
+static unsigned long __next_timer_interrupt(struct timer_base *base)
+{
+	unsigned long clk, next, adj;
+	unsigned lvl, offset = 0;
+
+	next = base->clk + NEXT_TIMER_MAX_DELTA;
+	clk = base->clk;
+	for (lvl = 0; lvl < LVL_DEPTH; lvl++, offset += LVL_SIZE) {
+		int pos = next_pending_bucket(base, offset, clk & LVL_MASK);
+
+		if (pos >= 0) {
+			unsigned long tmp = clk + (unsigned long) pos;
+
+			tmp <<= LVL_SHIFT(lvl);
+			if (time_before(tmp, next))
+				next = tmp;
 		}
-		slot = (slot + 1) & TVR_MASK;
-	} while (slot != index);
-
-cascade:
-	/* Calculate the next cascade event */
-	if (index)
-		timer_jiffies += TVR_SIZE - index;
-	timer_jiffies >>= TVR_BITS;
-
-	/* Check tv2-tv5. */
-	varray[0] = &base->tv2;
-	varray[1] = &base->tv3;
-	varray[2] = &base->tv4;
-	varray[3] = &base->tv5;
-
-	for (array = 0; array < 4; array++) {
-		struct tvec *varp = varray[array];
-
-		index = slot = timer_jiffies & TVN_MASK;
-		do {
-			hlist_for_each_entry(nte, varp->vec + slot, entry) {
-				if (nte->flags & TIMER_DEFERRABLE)
-					continue;
-
-				found = 1;
-				if (time_before(nte->expires, expires))
-					expires = nte->expires;
-			}
-			/*
-			 * Do we still search for the first timer or are
-			 * we looking up the cascade buckets ?
-			 */
-			if (found) {
-				/* Look at the cascade bucket(s)? */
-				if (!index || slot < index)
-					break;
-				return expires;
-			}
-			slot = (slot + 1) & TVN_MASK;
-		} while (slot != index);
-
-		if (index)
-			timer_jiffies += TVN_SIZE - index;
-		timer_jiffies >>= TVN_BITS;
+		/*
+		 * Clock for the next level. If the current level clock lower
+		 * bits are zero, we look at the next level as is. If not we
+		 * need to advance it by one because that's going to be the
+		 * next expiring bucket in that level. base->clk is the next
+		 * expiring jiffie. So in case of:
+		 *
+		 * LVL5 LVL4 LVL3 LVL2 LVL1 LVL0
+		 *  0    0    0    0    0    0
+		 *
+		 * we have to look at all levels @index 0. With
+		 *
+		 * LVL5 LVL4 LVL3 LVL2 LVL1 LVL0
+		 *  0    0    0    0    0    2
+		 *
+		 * LVL0 has the next expiring bucket @index 2. The upper
+		 * levels have the next expiring bucket @index 1.
+		 *
+		 * In case that the propagation wraps the next level the same
+		 * rules apply:
+		 *
+		 * LVL5 LVL4 LVL3 LVL2 LVL1 LVL0
+		 *  0    0    0    0    F    2
+		 *
+		 * So after looking at LVL0 we get:
+		 *
+		 * LVL5 LVL4 LVL3 LVL2 LVL1
+		 *  0    0    0    1    0
+		 *
+		 * So no propagation from LVL1 to LVL2 because that happened
+		 * with the add already, but then we need to propagate further
+		 * from LVL2 to LVL3.
+		 *
+		 * So the simple check whether the lower bits of the current
+		 * level are 0 or not is sufficient for all cases.
+		 */
+		adj = clk & LVL_CLK_MASK ? 1 : 0;
+		clk >>= LVL_CLK_SHIFT;
+		clk += adj;
 	}
-	return expires;
+	return next;
 }
 
 /*
@@ -1436,7 +1541,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
-	struct tvec_base *base = this_cpu_ptr(&tvec_bases);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	u64 expires = KTIME_MAX;
 	unsigned long nextevt;
 
@@ -1447,28 +1552,81 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (cpu_is_offline(smp_processor_id()))
 		return expires;
 
-#ifdef CONFIG_PREEMPT_RT_FULL
+	raw_spin_lock(&base->lock);
+	nextevt = __next_timer_interrupt(base);
+	base->next_expiry = nextevt;
 	/*
-	 * On PREEMPT_RT we cannot sleep here. As a result we can't take
-	 * the base lock to check when the next timer is pending and so
-	 * we assume the next jiffy.
+	 * We have a fresh next event. Check whether we can forward the base.
 	 */
-	return basem + TICK_NSEC;
-#endif
-	spin_lock(&base->lock);
-	if (base->active_timers) {
-		if (time_before_eq(base->next_timer, base->timer_jiffies))
-			base->next_timer = __next_timer_interrupt(base);
-		nextevt = base->next_timer;
-		if (time_before_eq(nextevt, basej))
-			expires = basem;
-		else
-			expires = basem + (nextevt - basej) * TICK_NSEC;
+	if (time_after(nextevt, jiffies))
+		base->clk = jiffies;
+	else if (time_after(nextevt, base->clk))
+		base->clk = nextevt;
+
+	if (time_before_eq(nextevt, basej)) {
+		expires = basem;
+		base->is_idle = false;
+	} else {
+		expires = basem + (nextevt - basej) * TICK_NSEC;
+		/*
+		 * If we expect to sleep more than a tick, mark the base idle.
+		 */
+		if ((expires - basem) > TICK_NSEC)
+			base->is_idle = true;
 	}
-	spin_unlock(&base->lock);
+	raw_spin_unlock(&base->lock);
 
 	return cmp_next_hrtimer_event(basem, expires);
 }
+
+/**
+ * timer_clear_idle - Clear the idle state of the timer base
+ *
+ * Called with interrupts disabled
+ */
+void timer_clear_idle(void)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+
+	/*
+	 * We do this unlocked. The worst outcome is a remote enqueue sending
+	 * a pointless IPI, but taking the lock would just make the window for
+	 * sending the IPI a few instructions smaller for the cost of taking
+	 * the lock in the exit from idle path.
+	 */
+	base->is_idle = false;
+}
+
+static int collect_expired_timers(struct timer_base *base,
+				  struct hlist_head *heads)
+{
+	/*
+	 * NOHZ optimization. After a long idle sleep we need to forward the
+	 * base to current jiffies. Avoid a loop by searching the bitfield for
+	 * the next expiring timer.
+	 */
+	if ((long)(jiffies - base->clk) > 2) {
+		unsigned long next = __next_timer_interrupt(base);
+
+		/*
+		 * If the next timer is ahead of time forward to current
+		 * jiffies, otherwise forward to the next expiry time.
+		 */
+		if (time_after(next, jiffies)) {
+			/* The call site will increment clock! */
+			base->clk = jiffies - 1;
+			return 0;
+		}
+		base->clk = next;
+	}
+	return __collect_expired_timers(base, heads);
+}
+#else
+static inline int collect_expired_timers(struct timer_base *base,
+					 struct hlist_head *heads)
+{
+	return __collect_expired_timers(base, heads);
+}
 #endif
 
 /*
@@ -1491,17 +1649,44 @@ void update_process_times(int user_tick)
 	run_posix_cpu_timers(p);
 }
 
+/**
+ * __run_timers - run all expired timers (if any) on this CPU.
+ * @base: the timer vector to be processed.
+ */
+static inline void __run_timers(struct timer_base *base)
+{
+	struct hlist_head heads[LVL_DEPTH];
+	int levels;
+
+	if (!time_after_eq(jiffies, base->clk))
+		return;
+
+	raw_spin_lock_irq(&base->lock);
+
+	while (time_after_eq(jiffies, base->clk)) {
+
+		levels = collect_expired_timers(base, heads);
+		base->clk++;
+
+		while (levels--)
+			expire_timers(base, heads + levels);
+	}
+	raw_spin_unlock_irq(&base->lock);
+	wakeup_timer_waiters(base);
+}
+
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
 static void run_timer_softirq(struct softirq_action *h)
 {
-	struct tvec_base *base = this_cpu_ptr(&tvec_bases);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	irq_work_tick_soft();
 
-	if (time_after_eq(jiffies, base->timer_jiffies))
-		__run_timers(base);
+	__run_timers(base);
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active)
+		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
 }
 
 /*
@@ -1509,7 +1694,18 @@ static void run_timer_softirq(struct softirq_action *h)
  */
 void run_local_timers(void)
 {
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+
 	hrtimer_run_queues();
+	/* Raise the softirq only if required. */
+	if (time_before(jiffies, base->clk)) {
+		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
+			return;
+		/* CPU is awake, so check the deferrable base. */
+		base++;
+		if (time_before(jiffies, base->clk))
+			return;
+	}
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
@@ -1594,7 +1790,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	expire = timeout + jiffies;
 
 	setup_timer_on_stack(&timer, process_timeout, (unsigned long)current);
-	__mod_timer(&timer, expire, false, TIMER_NOT_PINNED);
+	__mod_timer(&timer, expire, false);
 	schedule();
 	del_singleshot_timer_sync(&timer);
 
@@ -1645,14 +1841,13 @@ signed long __sched schedule_timeout_idle(signed long timeout)
 EXPORT_SYMBOL(schedule_timeout_idle);
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void migrate_timer_list(struct tvec_base *new_base, struct hlist_head *head)
+static void migrate_timer_list(struct timer_base *new_base, struct hlist_head *head)
 {
 	struct timer_list *timer;
 	int cpu = new_base->cpu;
 
 	while (!hlist_empty(head)) {
 		timer = hlist_entry(head->first, struct timer_list, entry);
-		/* We ignore the accounting on the dying cpu */
 		detach_timer(timer, false);
 		timer->flags = (timer->flags & ~TIMER_BASEMASK) | cpu;
 		internal_add_timer(new_base, timer);
@@ -1661,37 +1856,31 @@ static void migrate_timer_list(struct tvec_base *new_base, struct hlist_head *he
 
 static void migrate_timers(int cpu)
 {
-	struct tvec_base *old_base;
-	struct tvec_base *new_base;
-	int i;
+	struct timer_base *old_base;
+	struct timer_base *new_base;
+	int b, i;
 
 	BUG_ON(cpu_online(cpu));
-	old_base = per_cpu_ptr(&tvec_bases, cpu);
-	new_base = get_local_ptr(&tvec_bases);
-	/*
-	 * The caller is globally serialized and nobody else
-	 * takes two locks at once, deadlock is not possible.
-	 */
-	spin_lock_irq(&new_base->lock);
-	spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
-	BUG_ON(old_base->running_timer);
+	for (b = 0; b < NR_BASES; b++) {
+		old_base = per_cpu_ptr(&timer_bases[b], cpu);
+		new_base = get_cpu_ptr(&timer_bases[b]);
+		/*
+		 * The caller is globally serialized and nobody else
+		 * takes two locks at once, deadlock is not possible.
+		 */
+		raw_spin_lock_irq(&new_base->lock);
+		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
-	for (i = 0; i < TVR_SIZE; i++)
-		migrate_timer_list(new_base, old_base->tv1.vec + i);
-	for (i = 0; i < TVN_SIZE; i++) {
-		migrate_timer_list(new_base, old_base->tv2.vec + i);
-		migrate_timer_list(new_base, old_base->tv3.vec + i);
-		migrate_timer_list(new_base, old_base->tv4.vec + i);
-		migrate_timer_list(new_base, old_base->tv5.vec + i);
+		BUG_ON(old_base->running_timer);
+
+		for (i = 0; i < WHEEL_SIZE; i++)
+			migrate_timer_list(new_base, old_base->vectors + i);
+
+		raw_spin_unlock(&old_base->lock);
+		raw_spin_unlock_irq(&new_base->lock);
+		put_cpu_ptr(&timer_bases);
 	}
-
-	old_base->active_timers = 0;
-	old_base->all_timers = 0;
-
-	spin_unlock(&old_base->lock);
-	spin_unlock_irq(&new_base->lock);
-	put_local_ptr(&tvec_bases);
 }
 
 static int timer_cpu_notify(struct notifier_block *self,
@@ -1719,16 +1908,18 @@ static inline void timer_register_cpu_notifier(void) { }
 
 static void __init init_timer_cpu(int cpu)
 {
-	struct tvec_base *base = per_cpu_ptr(&tvec_bases, cpu);
+	struct timer_base *base;
+	int i;
 
-	base->cpu = cpu;
-	spin_lock_init(&base->lock);
+	for (i = 0; i < NR_BASES; i++) {
+		base = per_cpu_ptr(&timer_bases[i], cpu);
+		base->cpu = cpu;
+		raw_spin_lock_init(&base->lock);
+		base->clk = jiffies;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	init_waitqueue_head(&base->wait_for_running_timer);
+		init_swait_queue_head(&base->wait_for_running_timer);
 #endif
-
-	base->timer_jiffies = jiffies;
-	base->next_timer = base->timer_jiffies;
+	}
 }
 
 static void __init init_timer_cpus(void)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 90b40cf6ec98..72a4cf8dbef5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -245,7 +245,15 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 		return NULL;
 
 	local_save_flags(fbuffer->flags);
-	fbuffer->pc = event_preempt_count();
+	fbuffer->pc = preempt_count();
+	/*
+	 * If CONFIG_PREEMPT is enabled, then the tracepoint itself disables
+	 * preemption (adding one to the preempt_count). Since we are
+	 * interested in the preempt_count at the time the tracepoint was
+	 * hit, we need to subtract one to offset the increment.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		fbuffer->pc--;
 	fbuffer->trace_file = trace_file;
 
 	fbuffer->event =
diff --git a/lib/random32.c b/lib/random32.c
index 510d1ce7d4d2..69ed593aab07 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -233,7 +233,6 @@ static void __prandom_timer(unsigned long dontcare)
 
 static void __init __prandom_start_seed_timer(void)
 {
-	set_timer_slack(&seed_timer, HZ);
 	seed_timer.expires = jiffies + msecs_to_jiffies(40 * MSEC_PER_SEC);
 	add_timer(&seed_timer);
 }
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f..700c857efd9b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index bc5196ea1bdf..fc646aa7fad7 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -603,7 +603,7 @@ static void reqsk_timer_handler(unsigned long data)
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
 		timeo = min(TCP_TIMEOUT_INIT << req->num_timeout, TCP_RTO_MAX);
-		mod_timer_pinned(&req->rsk_timer, jiffies + timeo);
+		mod_timer(&req->rsk_timer, jiffies + timeo);
 		return;
 	}
 drop:
@@ -617,8 +617,9 @@ static void reqsk_queue_hash_req(struct request_sock *req,
 	req->num_timeout = 0;
 	req->sk = NULL;
 
-	setup_timer(&req->rsk_timer, reqsk_timer_handler, (unsigned long)req);
-	mod_timer_pinned(&req->rsk_timer, jiffies + timeout);
+	setup_pinned_timer(&req->rsk_timer, reqsk_timer_handler,
+			    (unsigned long)req);
+	mod_timer(&req->rsk_timer, jiffies + timeout);
 
 	inet_ehash_insert(req_to_sk(req), NULL);
 	/* before letting lookups find us, make sure all req fields
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index c67f9bd7699c..dfb6286f2e49 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -188,7 +188,8 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
-		setup_timer(&tw->tw_timer, tw_timer_handler, (unsigned long)tw);
+		setup_pinned_timer(&tw->tw_timer, tw_timer_handler,
+				   (unsigned long)tw);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
@@ -248,7 +249,7 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 
 	tw->tw_kill = timeo <= 4*HZ;
 	if (!rearm) {
-		BUG_ON(mod_timer_pinned(&tw->tw_timer, jiffies + timeo));
+		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
 		atomic_inc(&tw->tw_dr->tw_count);
 	} else {
 		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
