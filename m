From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/20] net: provide a way to delegate processing a softirq to ksoftirqd
Date: Wed, 02 Mar 2016 10:37:04 -0500
Message-ID: <20160302153715.035216568@goodmis.org>
References: <20160302153658.995489487@goodmis.org>
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
Content-Disposition: inline; filename=0006-net-provide-a-way-to-delegate-processing-a-softirq-t.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.27-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

If the NET_RX uses up all of his budget it moves the following NAPI
invocations into the `ksoftirqd`. On -RT it does not do so. Instead it
rises the NET_RX softirq in its current context again.

In order to get closer to mainline's behaviour this patch provides
__raise_softirq_irqoff_ksoft() which raises the softirq in the ksoftird.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/interrupt.h |  8 ++++++++
 kernel/softirq.c          | 21 +++++++++++++++++++++
 net/core/dev.c            |  2 +-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 86628c733be7..ce50b6ebd65d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -444,6 +444,14 @@ extern void thread_do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
+#ifdef CONFIG_PREEMPT_RT_FULL
+extern void __raise_softirq_irqoff_ksoft(unsigned int nr);
+#else
+static inline void __raise_softirq_irqoff_ksoft(unsigned int nr)
+{
+	__raise_softirq_irqoff(nr);
+}
+#endif
 
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 40dbf5fcc869..a55e80dca611 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -704,6 +704,27 @@ void __raise_softirq_irqoff(unsigned int nr)
 }
 
 /*
+ * Same as __raise_softirq_irqoff() but will process them in ksoftirqd
+ */
+void __raise_softirq_irqoff_ksoft(unsigned int nr)
+{
+	unsigned int mask;
+
+	if (WARN_ON_ONCE(!__this_cpu_read(ksoftirqd) ||
+			 !__this_cpu_read(ktimer_softirqd)))
+		return;
+	mask = 1UL << nr;
+
+	trace_softirq_raise(nr);
+	or_softirq_pending(mask);
+	if (mask & TIMER_SOFTIRQS)
+		__this_cpu_read(ktimer_softirqd)->softirqs_raised |= mask;
+	else
+		__this_cpu_read(ksoftirqd)->softirqs_raised |= mask;
+	wakeup_proper_softirq(nr);
+}
+
+/*
  * This function must run with irqs disabled!
  */
 void raise_softirq_irqoff(unsigned int nr)
diff --git a/net/core/dev.c b/net/core/dev.c
index b89a1dd9f4d8..da674bb38606 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4679,7 +4679,7 @@ out:
 
 softnet_break:
 	sd->time_squeeze++;
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	__raise_softirq_irqoff_ksoft(NET_RX_SOFTIRQ);
 	goto out;
 }
 
-- 
2.7.0
