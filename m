From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/17] preempt-lazy: Add the lazy-preemption check to preempt_schedule()
Date: Wed, 02 Mar 2016 10:44:36 -0500
Message-ID: <20160302154500.249845384@goodmis.org>
References: <20160302154433.638594715@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-preempt-lazy-Add-the-lazy-preemption-check-to-preemp.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.61-rt64-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Probably in the rebase onto v4.1 this check got moved into less commonly used
preempt_schedule_notrace(). This patch ensures that both functions use it.

Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index edacb6d1d2bf..157ef7f121fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2998,6 +2998,30 @@ void __sched schedule_preempt_disabled(void)
 	preempt_disable();
 }
 
+#ifdef CONFIG_PREEMPT_LAZY
+/*
+ * If TIF_NEED_RESCHED is then we allow to be scheduled away since this is
+ * set by a RT task. Oterwise we try to avoid beeing scheduled out as long as
+ * preempt_lazy_count counter >0.
+ */
+static int preemptible_lazy(void)
+{
+	if (test_thread_flag(TIF_NEED_RESCHED))
+		return 1;
+	if (current_thread_info()->preempt_lazy_count)
+		return 0;
+	return 1;
+}
+
+#else
+
+static int preemptible_lazy(void)
+{
+	return 1;
+}
+
+#endif
+
 #ifdef CONFIG_PREEMPT
 /*
  * this is the entry point to schedule() from in-kernel preemption
@@ -3012,15 +3036,9 @@ asmlinkage void __sched notrace preempt_schedule(void)
 	 */
 	if (likely(!preemptible()))
 		return;
-
-#ifdef CONFIG_PREEMPT_LAZY
-	/*
-	 * Check for lazy preemption
-	 */
-	if (current_thread_info()->preempt_lazy_count &&
-			!test_thread_flag(TIF_NEED_RESCHED))
+	if (!preemptible_lazy())
 		return;
-#endif
+
 	do {
 		__preempt_count_add(PREEMPT_ACTIVE);
 		/*
-- 
2.7.0
