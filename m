From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 10/12] irqwork: Move irq safe work to irq context
Date: Fri, 26 Feb 2016 16:32:45 -0500
Message-ID: <20160226213341.582113472@goodmis.org>
References: <20160226213235.253312067@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0010-irqwork-Move-irq-safe-work-to-irq-context.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.27-rt26-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

On architectures where arch_irq_work_has_interrupt() returns false, we
end up running the irq safe work from the softirq context. That
results in a potential deadlock in the scheduler irq work which
expects that function to be called with interrupts disabled.

Split the irq_work_tick() function into a hard and soft variant. Call
the hard variant from the tick interrupt and add the soft variant to
the timer softirq.

Reported-and-tested-by: Yanjiang Jin <yanjiang.jin@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/irq_work.h | 6 ++++++
 kernel/irq_work.c        | 9 +++++++++
 kernel/time/timer.c      | 6 ++----
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 30ef6c214e6f..af7ed9ad52c3 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -51,4 +51,10 @@ bool irq_work_needs_cpu(void);
 static inline bool irq_work_needs_cpu(void) { return false; }
 #endif
 
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
+void irq_work_tick_soft(void);
+#else
+static inline void irq_work_tick_soft(void) { }
+#endif
+
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 9678fd1382a7..3d5a476b58b9 100644
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
index 3a978d000fce..78e39b644780 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1451,7 +1451,7 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	rcu_check_callbacks(cpu, user_tick);
 
-#if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
+#if defined(CONFIG_IRQ_WORK)
 	if (in_irq())
 		irq_work_tick();
 #endif
@@ -1467,9 +1467,7 @@ static void run_timer_softirq(struct softirq_action *h)
 
 	hrtimer_run_pending();
 
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
-	irq_work_tick();
-#endif
+	irq_work_tick_soft();
 
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
-- 
2.7.0
