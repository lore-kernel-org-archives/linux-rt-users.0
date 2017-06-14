From: Alex Shi <alex.shi@linaro.org>
Subject: [RFC PATCH] cpu_pm/rt: replace rt rwlock with raw spinlock
Date: Wed, 14 Jun 2017 21:22:19 +0800
Message-ID: <1497446539-6378-1-git-send-email-alex.shi@linaro.org>
Cc: Alex Shi <alex.shi@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: linux-kernel@vger.kernel.org (open list)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35534 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdFNNWv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Jun 2017 09:22:51 -0400
Received: by mail-pg0-f50.google.com with SMTP id k71so198339pgd.2
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Jun 2017 06:22:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a quick fix for a bug as 'scheduling while atomic' or
'scheduling from the idle thread' on arm/arm64.

On arm/arm64, rwlock cpu_pm_notifier_lock in cpu_pm cause a potential
schedule after irq disable in idle call chain:

cpu_startup_entry
  cpu_idle_loop
    local_irq_disable()
    cpuidle_idle_call
      call_cpuidle
        cpuidle_enter
          cpuidle_enter_state
            ->enter :arm_enter_idle_state
	      cpu_pm_enter/exit
	        CPU_PM_CPU_IDLE_ENTER
                  read_lock(&cpu_pm_notifier_lock); <-- sleep in idle
	             __rt_spin_lock();
			schedule();

The kernel panic is here:
[    4.609601] BUG: scheduling while atomic: swapper/1/0/0x00000002
[    4.609608] [<ffff0000086fae70>] arm_enter_idle_state+0x18/0x70
[    4.609614] Modules linked in:
[    4.609615] [<ffff0000086f9298>] cpuidle_enter_state+0xf0/0x218
[    4.609620] [<ffff0000086f93f8>] cpuidle_enter+0x18/0x20
[    4.609626] Preemption disabled at:
[    4.609627] [<ffff0000080fa234>] call_cpuidle+0x24/0x40
[    4.609635] [<ffff000008882fa4>] schedule_preempt_disabled+0x1c/0x28
[    4.609639] [<ffff0000080fa49c>] cpu_startup_entry+0x154/0x1f8
[    4.609645] [<ffff00000808e004>] secondary_start_kernel+0x15c/0x1a0

Daniel Lezcano said this notification is needed on arm/arm64 platforms.
I also tried use local_lock_irq to replace local_irq_disable, but my 2
boards just die without any output. So maybe it's only quick way to
make rt kernel work on arm/arm64.

Since this is quick fix, instead of split out the raw rwlock, to use
raw_spin_lock is simple and don't cost much.

Signed-off-by: Alex Shi <alex.shi@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
---
 kernel/cpu_pm.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 009cc9a..8ffa13e3 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -22,7 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
-static DEFINE_RWLOCK(cpu_pm_notifier_lock);
+static DEFINE_RAW_SPINLOCK(cpu_pm_notifier_lock);
 static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
 
 static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
@@ -50,9 +50,9 @@ int cpu_pm_register_notifier(struct notifier_block *nb)
 	unsigned long flags;
 	int ret;
 
-	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
+	raw_spin_lock_irqsave(&cpu_pm_notifier_lock, flags);
 	ret = raw_notifier_chain_register(&cpu_pm_notifier_chain, nb);
-	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
 
 	return ret;
 }
@@ -72,9 +72,9 @@ int cpu_pm_unregister_notifier(struct notifier_block *nb)
 	unsigned long flags;
 	int ret;
 
-	write_lock_irqsave(&cpu_pm_notifier_lock, flags);
+	raw_spin_lock_irqsave(&cpu_pm_notifier_lock, flags);
 	ret = raw_notifier_chain_unregister(&cpu_pm_notifier_chain, nb);
-	write_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
+	raw_spin_unlock_irqrestore(&cpu_pm_notifier_lock, flags);
 
 	return ret;
 }
@@ -100,7 +100,7 @@ int cpu_pm_enter(void)
 	int nr_calls;
 	int ret = 0;
 
-	read_lock(&cpu_pm_notifier_lock);
+	raw_spin_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
 	if (ret)
 		/*
@@ -108,7 +108,7 @@ int cpu_pm_enter(void)
 		 * PM entry who are notified earlier to prepare for it.
 		 */
 		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
+	raw_spin_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -130,9 +130,9 @@ int cpu_pm_exit(void)
 {
 	int ret;
 
-	read_lock(&cpu_pm_notifier_lock);
+	raw_spin_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
+	raw_spin_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -159,7 +159,7 @@ int cpu_cluster_pm_enter(void)
 	int nr_calls;
 	int ret = 0;
 
-	read_lock(&cpu_pm_notifier_lock);
+	raw_spin_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
 	if (ret)
 		/*
@@ -167,7 +167,7 @@ int cpu_cluster_pm_enter(void)
 		 * PM entry who are notified earlier to prepare for it.
 		 */
 		cpu_pm_notify(CPU_CLUSTER_PM_ENTER_FAILED, nr_calls - 1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
+	raw_spin_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
@@ -192,9 +192,9 @@ int cpu_cluster_pm_exit(void)
 {
 	int ret;
 
-	read_lock(&cpu_pm_notifier_lock);
+	raw_spin_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
-	read_unlock(&cpu_pm_notifier_lock);
+	raw_spin_unlock(&cpu_pm_notifier_lock);
 
 	return ret;
 }
-- 
1.9.1

