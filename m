From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 1/2] x86/mce: Defer mce wakeups to threads for PREEMPT_RT
Date: Fri, 27 Feb 2015 15:20:37 +0100
Message-ID: <1425046838-4868-2-git-send-email-daniel.wagner@bmw-carit.de>
References: <1425046838-4868-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:53471 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752839AbbB0OUs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Feb 2015 09:20:48 -0500
In-Reply-To: <1425046838-4868-1-git-send-email-daniel.wagner@bmw-carit.de>
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
 arch/x86/kernel/cpu/mcheck/mce.c | 65 ++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 5776fdc..77afc3f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -42,6 +42,7 @@
 #include <linux/irq_work.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
+#include <linux/work-simple.h>
 
 #include <asm/processor.h>
 #include <asm/mce.h>
@@ -1363,6 +1364,53 @@ static void mce_do_trigger(struct work_struct *work)
 
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
+static struct swork_event notify_work;
+
+static int mce_notify_work_init(void)
+{
+	int err;
+
+	err = swork_get();
+	if (err)
+		return err;
+
+	INIT_SWORK(&notify_work, __mce_notify_work);
+	return 0;
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
@@ -1370,19 +1418,8 @@ static DECLARE_WORK(mce_trigger_work, mce_do_trigger);
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
