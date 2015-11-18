From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.1.13-rt15
Date: Wed, 18 Nov 2015 16:55:59 +0100
Message-ID: <20151118155559.GA3652@linutronix.de>
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

I'm pleased to announce the v4.1.13-rt15 patch set.
Changes since v4.1.13-rt14:

Sebastian Andrzej Siewior (1):
      v4.1.13-rt15

Thomas Gleixner (1):
      irqwork: Move irq safe work to irq context

Known issues:
  - bcache stays disabled

  - CPU hotplug is not better than before

  - The netlink_release() OOPS, reported by Clark, is still on the
    list, but unsolved due to lack of information

The delta patch against 4.1.13-rt15 is appended below and can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.13-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.1.13-rt15

The RT patch against 4.1.13 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.13-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.13-rt15.tar.xz

Sebastian

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -52,4 +52,10 @@ static inline bool irq_work_needs_cpu(void) { return false; }
 static inline void irq_work_run(void) { }
 #endif
 
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
+void irq_work_tick_soft(void);
+#else
+static inline void irq_work_tick_soft(void) { }
+#endif
+
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -200,8 +200,17 @@ void irq_work_tick(void)
 
 	if (!llist_empty(raised) && !arch_irq_work_has_interrupt())
 		irq_work_run_list(raised);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		irq_work_run_list(this_cpu_ptr(&lazy_list));
+}
+
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
+void irq_work_tick_soft(void)
+{
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
 }
+#endif
 
 /*
  * Synchronize against the irq_work @entry, ensures the entry is not
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1455,7 +1455,7 @@ void update_process_times(int user_tick)
 	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(user_tick);
-#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_IRQ_WORK)
 	if (in_irq())
 		irq_work_tick();
 #endif
@@ -1471,9 +1471,7 @@ static void run_timer_softirq(struct softirq_action *h)
 
 	hrtimer_run_pending();
 
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
-	irq_work_tick();
-#endif
+	irq_work_tick_soft();
 
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
