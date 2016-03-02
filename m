From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 06/22] preempt-lazy: Add the lazy-preemption check to preempt_schedule()
Date: Wed, 02 Mar 2016 10:09:05 -0500
Message-ID: <20160302151111.214477863@goodmis.org>
References: <20160302150859.204542604@goodmis.org>
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
Content-Disposition: inline; filename=0006-preempt-lazy-Add-the-lazy-preemption-check-to-preemp.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.15-rt18-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Probably in the rebase onto v4.1 this check got moved into less commonly used
preempt_schedule_notrace(). This patch ensures that both functions use it.

Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d21091f2fd1f..5cbfb0548574 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3116,6 +3116,30 @@ static void __sched notrace preempt_schedule_common(void)
 	} while (need_resched());
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
@@ -3130,6 +3154,8 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 	 */
 	if (likely(!preemptible()))
 		return;
+	if (!preemptible_lazy())
+		return;
 
 	preempt_schedule_common();
 }
@@ -3157,15 +3183,9 @@ asmlinkage __visible void __sched notrace preempt_schedule_context(void)
 
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
