From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Thu, 21 Jan 2016 13:54:05 +0100
Message-ID: <20160121125405.GA11749@linutronix.de>
References: <1453108103.4123.4.camel@gmail.com>
 <20160118201828.GE12309@linutronix.de>
 <1453170597.3740.7.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453170597.3740.7.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2016-01-19 03:29:57 [+0100]:

>> And this is a new piece. So you forbid that tasks leave the CPU if
>> lazy_count > 0. Let me look closed why this is happening and if this=
 is
>> v4.1 =E2=80=A6 v4.4 or not.
>
>We should probably just add the lazy bits to preemptible().

Subject: preempt-lazy: Add the lazy-preemption check to preempt_schedul=
e()

Probably in the rebase onto v4.1 this check got moved into less commonl=
y used
preempt_schedule_notrace(). This patch ensures that both functions use =
it.

Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3461,6 +3461,30 @@ static void __sched notrace preempt_sche
 	} while (need_resched());
 }
=20
+#ifdef CONFIG_PREEMPT_LAZY
+/*
+ * If TIF_NEED_RESCHED is then we allow to be scheduled away since thi=
s is
+ * set by a RT task. Oterwise we try to avoid beeing scheduled out as =
long as
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
@@ -3475,6 +3499,8 @@ asmlinkage __visible void __sched notrac
 	 */
 	if (likely(!preemptible()))
 		return;
+	if (!preemptible_lazy())
+		return;
=20
 	preempt_schedule_common();
 }
@@ -3501,15 +3527,9 @@ asmlinkage __visible void __sched notrac
=20
 	if (likely(!preemptible()))
 		return;
-
-#ifdef CONFIG_PREEMPT_LAZY
-	/*
-	 * Check for lazy preemption
-	 */
-	if (current_thread_info()->preempt_lazy_count &&
-	    !test_thread_flag(TIF_NEED_RESCHED))
+	if (!preemptible_lazy())
 		return;
-#endif
+
 	do {
 		preempt_disable_notrace();
 		/*
