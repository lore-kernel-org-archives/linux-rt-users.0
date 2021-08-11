Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E26C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 13:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB13D60FC0
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 13:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhHKNO4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:14:56 -0400
Received: from foss.arm.com ([217.140.110.172]:50584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhHKNOz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Aug 2021 09:14:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED758106F;
        Wed, 11 Aug 2021 06:14:31 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AE953F718;
        Wed, 11 Aug 2021 06:14:30 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] cpu_pm: Make notifier chain use a raw spinlock
Date:   Wed, 11 Aug 2021 14:14:05 +0100
Message-Id: <20210811131405.1731576-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Booting a recent PREEMPT_RT kernel (v5.14-rc5-rt8 with the previous version
of this fix reverted) on my arm4 Juno leads to the idle task blocking on a
sleeping spinlock down some notifier path:

[    5.163034] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[    5.163042] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
[    5.163049] 1 lock held by swapper/1/0:
[    5.163053] #0: ffff8000120950e8 (cpu_pm_notifier_chain.lock){+.+.}-{2:2}, at: atomic_notifier_call_chain_robust (kernel/notifier.c:186)
[    5.163133] Preemption disabled at:
[    5.163136] rt_mutex_slowunlock (kernel/locking/rtmutex.c:1242)
[    5.163148] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.14.0-rc5-rt8-00001-ga7cd9160688d #202
[    5.163158] Hardware name: ARM Juno development board (r0) (DT)
[    5.163162] Call trace:
[    5.163165] dump_backtrace (arch/arm64/kernel/stacktrace.c:161)
[    5.163177] show_stack (arch/arm64/kernel/stacktrace.c:217)
[    5.163187] dump_stack_lvl (lib/dump_stack.c:106)
[    5.163195] dump_stack (lib/dump_stack.c:113)
[    5.163202] ___might_sleep (kernel/sched/core.c:9286)
[    5.163210] rt_spin_lock (kernel/locking/rtmutex.c:1668 (discriminator 4) kernel/locking/spinlock_rt.c:30 (discriminator 4) kernel/locking/spinlock_rt.c:36 (discriminator 4) kernel/locking/spinlock_rt.c:44 (discriminator 4))
[    5.163216] atomic_notifier_call_chain_robust (kernel/notifier.c:186)
[    5.163225] cpu_pm_notify_robust (kernel/cpu_pm.c:39)
[    5.163233] cpu_pm_enter (kernel/cpu_pm.c:94)
[    5.163239] psci_enter_idle_state (drivers/cpuidle/cpuidle-psci.c:53 drivers/cpuidle/cpuidle-psci.c:154)
[    5.163250] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:238)
[    5.163258] cpuidle_enter (drivers/cpuidle/cpuidle.c:353)
[    5.163266] call_cpuidle (kernel/sched/idle.c:159)
[    5.163272] do_idle (kernel/sched/idle.c:243 kernel/sched/idle.c:306)
[    5.163277] cpu_startup_entry (kernel/sched/idle.c:402 (discriminator 1))
[    5.163285] secondary_start_kernel (arch/arm64/kernel/smp.c:266)
[    5.163294] __secondary_switched (arch/arm64/kernel/head.S:661)

Making *all* atomic_notifiers use a raw_spinlock is too big of a hammer, as
only notifications issued by the idle task are problematic.

Special-case cpu_pm_notifier_chain by kludging a raw_notifier and
raw_spinlock together, matching the atomic_notifier behavior with a
raw_spinlock.

Fixes: 70d932985757 ("notifier: Fix broken error handling pattern")
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
v1 -> v2:
  Dropped the treewide change of atomic_notifier and special-cased
  cpu_pm_notifier_chain. This is done in cpu_pm itself rather than as a new
  notifier interface since this is caused by the idle task being "special",
  and AFAIA we don't want to encourage more widespread use.
---
 kernel/cpu_pm.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index f7e1d0eccdbc..707b8ace9fc7 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -13,19 +13,31 @@
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
-static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
+/*
+ * atomic_notifiers use a regular spinlock, but notifications for this chain
+ * will be issued by the idle task which cannot block.
+ */
+static struct {
+	struct raw_notifier_head chain;
+	raw_spinlock_t lock;
+} cpu_pm_notifier = {
+	.chain = RAW_NOTIFIER_INIT(cpu_pm_notifier.chain),
+	.lock  = __RAW_SPIN_LOCK_UNLOCKED(cpu_pm_notifier.lock),
+};
 
 static int cpu_pm_notify(enum cpu_pm_event event)
 {
 	int ret;
 
 	/*
-	 * atomic_notifier_call_chain has a RCU read critical section, which
-	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
-	 * RCU know this.
+	 * This introduces a RCU read critical section, which could be
+	 * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
+	 * this.
 	 */
 	rcu_irq_enter_irqson();
-	ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
+	rcu_read_lock();
+	ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
+	rcu_read_unlock();
 	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
@@ -33,10 +45,13 @@ static int cpu_pm_notify(enum cpu_pm_event event)
 
 static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event event_down)
 {
+	unsigned long flags;
 	int ret;
 
 	rcu_irq_enter_irqson();
-	ret = atomic_notifier_call_chain_robust(&cpu_pm_notifier_chain, event_up, event_down, NULL);
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
 	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
@@ -49,12 +64,17 @@ static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event ev
  * Add a driver to a list of drivers that are notified about
  * CPU and CPU cluster low power entry and exit.
  *
- * This function may sleep, and has the same return conditions as
- * raw_notifier_chain_register.
+ * This function has the same return conditions as raw_notifier_chain_register.
  */
 int cpu_pm_register_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&cpu_pm_notifier_chain, nb);
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_chain_register(&cpu_pm_notifier.chain, nb);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
 
@@ -64,12 +84,17 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
  *
  * Remove a driver from the CPU PM notifier list.
  *
- * This function may sleep, and has the same return conditions as
- * raw_notifier_chain_unregister.
+ * This function has the same return conditions as raw_notifier_chain_unregister.
  */
 int cpu_pm_unregister_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
+	ret = raw_notifier_chain_unregister(&cpu_pm_notifier.chain, nb);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
 
-- 
2.25.1

