From: Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Subject: [RFC v1 2/3] x86/mce: Defer mce wakeups to threads for PREEMPT_RT
Date: Fri, 11 Jul 2014 15:26:12 +0200
Message-ID: <1405085173-20449-3-git-send-email-daniel.wagner@oss.bmw-carit.de>
References: <1405085173-20449-1-git-send-email-daniel.wagner@oss.bmw-carit.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52411 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753857AbaGKNco (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jul 2014 09:32:44 -0400
In-Reply-To: <1405085173-20449-1-git-send-email-daniel.wagner@oss.bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Steven Rostedt <rostedt@goodmis.org>

We had a customer report a lockup on a 3.0-rt kernel that had the
following backtrace:

[ffff88107fca3e80] rt_spin_lock_slowlock at ffffffff81499113
[ffff88107fca3f40] rt_spin_lock at ffffffff81499a56
[ffff88107fca3f50] __wake_up at ffffffff81043379
[ffff88107fca3f80] mce_notify_irq at ffffffff81017328
[ffff88107fca3f90] intel_threshold_interrupt at ffffffff81019508
[ffff88107fca3fa0] smp_threshold_interrupt at ffffffff81019fc1
[ffff88107fca3fb0] threshold_interrupt at ffffffff814a1853

It actually bugged because the lock was taken by the same owner that
already had that lock. What happened was the thread that was setting
itself on a wait queue had the lock when an MCE triggered. The MCE
interrupt does a wake up on its wait list and grabs the same lock.

NOTE: THIS IS NOT A BUG ON MAINLINE

Sorry for yelling, but as I Cc'd mainline maintainers I want them to
know that this is an PREEMPT_RT bug only. I only Cc'd them for advice.

On PREEMPT_RT the wait queue locks are converted from normal
"spin_locks" into an rt_mutex (see the rt_spin_lock_slowlock above).
These are not to be taken by hard interrupt context. This usually isn't
a problem as most all interrupts in PREEMPT_RT are converted into
schedulable threads. Unfortunately that's not the case with the MCE irq.

As wait queue locks are notorious for long hold times, we can not
convert them to raw_spin_locks without causing issues with -rt. But
Thomas has created a "simple-wait" structure that uses raw spin locks
which may have been a good fit.

Unfortunately, wait queues are not the only issue, as the mce_notify_irq
also does a schedule_work(), which grabs the workqueue spin locks that
have the exact same issue.

Thus, this patch I'm proposing is to move the actual work of the MCE
interrupt into a helper thread that gets woken up on the MCE interrupt
and does the work in a schedulable context.

NOTE: THIS PATCH ONLY CHANGES THE BEHAVIOR WHEN PREEMPT_RT IS SET

Oops, sorry for yelling again, but I want to stress that I keep the same
behavior of mainline when PREEMPT_RT is not set. Thus, this only changes
the MCE behavior when PREEMPT_RT is configured.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[bigeasy@linutronix: make mce_notify_work() a proper prototype, use
		     kthread_run()]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[wagi: use work-simple framework to defer work to a kthread]
Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 57 +++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 6c9174b..a58e6b4 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -42,6 +42,7 @@
 #include <linux/irq_work.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
+#include <linux/work-simple.h>
 
 #include <asm/processor.h>
 #include <asm/mce.h>
@@ -1355,6 +1356,47 @@ static void mce_do_trigger(struct work_struct *work)
 
 static DECLARE_WORK(mce_trigger_work, mce_do_trigger);
 
+static void __mce_notify_work(struct swork_event *event)
+{
+	/* Not more than two messages every minute */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
+
+	/* wake processes polling /dev/mcelog */
+	wake_up_interruptible(&mce_chrdev_wait);
+
+	/*
+	 * There is no risk of missing notifications because
+	 * work_pending is always cleared before the function is
+	 * executed.
+	 */
+	if (mce_helper[0] && !work_pending(&mce_trigger_work))
+		schedule_work(&mce_trigger_work);
+
+	if (__ratelimit(&ratelimit))
+		pr_info(HW_ERR "Machine check events logged\n");
+}
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+struct swork_event notify_work;
+
+static int mce_notify_work_init(void)
+{
+	init_swork_event(&notify_work, __mce_notify_work);
+	return swork_get();
+}
+
+static void mce_notify_work(void)
+{
+	swork_queue(&notify_work);
+}
+#else
+static void mce_notify_work(void)
+{
+	__mce_notify_work(NULL);
+}
+static inline int mce_notify_work_init(void) { return 0; }
+#endif
+
 /*
  * Notify the user(s) about new machine check events.
  * Can be called from interrupt context, but not from machine check/NMI
@@ -1362,19 +1404,8 @@ static DECLARE_WORK(mce_trigger_work, mce_do_trigger);
  */
 int mce_notify_irq(void)
 {
-	/* Not more than two messages every minute */
-	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
-
 	if (test_and_clear_bit(0, &mce_need_notify)) {
-		/* wake processes polling /dev/mcelog */
-		wake_up_interruptible(&mce_chrdev_wait);
-
-		if (mce_helper[0])
-			schedule_work(&mce_trigger_work);
-
-		if (__ratelimit(&ratelimit))
-			pr_info(HW_ERR "Machine check events logged\n");
