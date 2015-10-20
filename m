From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.1.3-rt10][RFC PATCH] PM / sleep: freeze: fix bug "sleeping function called from invalid context"
Date: Tue, 20 Oct 2015 23:35:03 +0300
Message-ID: <1445373303-26264-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sekhar Nori <nsekhar@ti.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	<bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

With 4.1 RT-kernel on TI ARM dra7-evm the below error report is
displayed each time system is woken up from sleep state:

BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
in_atomic(): 1, irqs_disabled(): 128, pid: 142, name: sh
INFO: lockdep is turned off.
irq event stamp: 11575
hardirqs last  enabled at (11575): [<c06dd280>] _raw_spin_unlock_irq+0x24/0x68
hardirqs last disabled at (11574): [<c06dd0b8>] _raw_spin_lock_irq+0x18/0x4c
softirqs last  enabled at (0): [<c0045080>] copy_process.part.54+0x3f4/0x1930
softirqs last disabled at (0): [<  (null)>]   (null)
Preemption disabled at:[<  (null)>]   (null)

CPU: 0 PID: 142 Comm: sh Not tainted 4.1.10-rt8-01710-g6c5fab9 #61
Hardware name: Generic DRA74X (Flattened Device Tree)
[<c00190a8>] (unwind_backtrace) from [<c0014460>] (show_stack+0x10/0x14)
[<c0014460>] (show_stack) from [<c06d7638>] (dump_stack+0x7c/0x98)
[<c06d7638>] (dump_stack) from [<c06dd604>] (rt_spin_lock+0x20/0x60)
[<c06dd604>] (rt_spin_lock) from [<c00a2d20>] (freeze_wake+0x10/0x58)
[<c00a2d20>] (freeze_wake) from [<c00b1a1c>] (irq_pm_check_wakeup+0x40/0x48)
[<c00b1a1c>] (irq_pm_check_wakeup) from [<c00acee0>] (irq_may_run+0x20/0x48)
[<c00acee0>] (irq_may_run) from [<c00ad1f8>] (handle_level_irq+0x40/0x160)
[<c00ad1f8>] (handle_level_irq) from [<c00a8fbc>] (generic_handle_irq+0x28/0x3c)
[<c00a8fbc>] (generic_handle_irq) from [<c03fc330>] (pcs_irq_handle+0x6c/0x8c)
[<c03fc330>] (pcs_irq_handle) from [<c03fc380>] (pcs_irq_chain_handler+0x30/0x88)
[<c03fc380>] (pcs_irq_chain_handler) from [<c00a8fbc>] (generic_handle_irq+0x28/0x3c)
[<c00a8fbc>] (generic_handle_irq) from [<c00330c4>] (omap_prcm_irq_handler+0xc4/0x1a8)
[<c00330c4>] (omap_prcm_irq_handler) from [<c00a8fbc>] (generic_handle_irq+0x28/0x3c)
[<c00a8fbc>] (generic_handle_irq) from [<c00a92bc>] (__handle_domain_irq+0x8c/0x120)
[<c00a92bc>] (__handle_domain_irq) from [<c000958c>] (gic_handle_irq+0x20/0x60)
[<c000958c>] (gic_handle_irq) from [<c06ddea4>] (__irq_svc+0x44/0x90)
Exception stack(0xeca49dc8 to 0xeca49e10)
9dc0:                   c00a2e38 ec9fae00 00000100 00000000 c12fb80c 00000003
9de0: 00000000 c0b396a0 c0a70804 c0896b20 c0896ae8 00000000 00000000 eca49e10
9e00: c00a2e38 c00a2e3c 60000013 ffffffff
[<c06ddea4>] (__irq_svc) from [<c00a2e3c>] (arch_suspend_enable_irqs+0xc/0x10)
[<c00a2e3c>] (arch_suspend_enable_irqs) from [<c00a3138>] (suspend_enter+0x2f8/0xce4)
[<c00a3138>] (suspend_enter) from [<c00a3bf8>] (suspend_devices_and_enter+0xd4/0x648)
[<c00a3bf8>] (suspend_devices_and_enter) from [<c00a480c>] (enter_state+0x6a0/0x1030)
[<c00a480c>] (enter_state) from [<c00a51b0>] (pm_suspend+0x14/0x74)
[<c00a51b0>] (pm_suspend) from [<c00a1d6c>] (state_store+0x64/0xb8)
[<c00a1d6c>] (state_store) from [<c02143bc>] (kernfs_fop_write+0xb8/0x19c)
[<c02143bc>] (kernfs_fop_write) from [<c019c290>] (__vfs_write+0x20/0xd8)
[<c019c290>] (__vfs_write) from [<c019cb30>] (vfs_write+0x90/0x164)
[<c019cb30>] (vfs_write) from [<c019d354>] (SyS_write+0x44/0x9c)
[<c019d354>] (SyS_write) from [<c0010300>] (ret_fast_syscall+0x0/0x1c)

The root cause of issue is freeze_wake() which is called from
atomic context (HW IRQ handler). The call path:
gic_handle_irq
- omap_prcm_irq_handler
  - pcs_irq_chain_handler
    - [...]
      - handle_level_irq
        - irq_may_run
          - irq_pm_check_wakeup
            - freeze_wake
              - spin_lock_irqsave(&suspend_freeze_lock,..);

Hence, fix this issue by doing the following:
- convert suspend_freeze_lock to raw lock;
- convert suspend_freeze_wait_head to simple waitqueue;
- move pm_wakeup_pending() out of region, protected by suspend_freeze_lock;

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 kernel/power/suspend.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index db920b1..0e94058 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -29,6 +29,7 @@
 #include <trace/events/power.h>
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
+#include <linux/wait-simple.h>
 
 #include "power.h"
 
@@ -37,10 +38,10 @@ const char *pm_states[PM_SUSPEND_MAX];
 
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_freeze_ops *freeze_ops;
-static DECLARE_WAIT_QUEUE_HEAD(suspend_freeze_wait_head);
+static DEFINE_SWAIT_HEAD(suspend_freeze_wait_head);
 
 enum freeze_state __read_mostly suspend_freeze_state;
-static DEFINE_SPINLOCK(suspend_freeze_lock);
+static DEFINE_RAW_SPINLOCK(suspend_freeze_lock);
 
 void freeze_set_ops(const struct platform_freeze_ops *ops)
 {
@@ -56,12 +57,12 @@ static void freeze_begin(void)
 
 static void freeze_enter(void)
 {
-	spin_lock_irq(&suspend_freeze_lock);
 	if (pm_wakeup_pending())
 		goto out;
 
+	raw_spin_lock_irq(&suspend_freeze_lock);
 	suspend_freeze_state = FREEZE_STATE_ENTER;
-	spin_unlock_irq(&suspend_freeze_lock);
+	raw_spin_unlock_irq(&suspend_freeze_lock);
 
 	get_online_cpus();
 	cpuidle_resume();
@@ -70,30 +71,30 @@ static void freeze_enter(void)
 	wake_up_all_idle_cpus();
 	pr_debug("PM: suspend-to-idle\n");
 	/* Make the current CPU wait so it can enter the idle loop too. */
-	wait_event(suspend_freeze_wait_head,
-		   suspend_freeze_state == FREEZE_STATE_WAKE);
+	swait_event(suspend_freeze_wait_head,
+		    suspend_freeze_state == FREEZE_STATE_WAKE);
 	pr_debug("PM: resume from suspend-to-idle\n");
 
 	cpuidle_pause();
 	put_online_cpus();
 
-	spin_lock_irq(&suspend_freeze_lock);
+	raw_spin_lock_irq(&suspend_freeze_lock);
 
  out:
 	suspend_freeze_state = FREEZE_STATE_NONE;
-	spin_unlock_irq(&suspend_freeze_lock);
+	raw_spin_unlock_irq(&suspend_freeze_lock);
 }
 
 void freeze_wake(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&suspend_freeze_lock, flags);
+	raw_spin_lock_irqsave(&suspend_freeze_lock, flags);
 	if (suspend_freeze_state > FREEZE_STATE_NONE) {
 		suspend_freeze_state = FREEZE_STATE_WAKE;
-		wake_up(&suspend_freeze_wait_head);
+		swait_wake(&suspend_freeze_wait_head);
 	}
-	spin_unlock_irqrestore(&suspend_freeze_lock, flags);
+	raw_spin_unlock_irqrestore(&suspend_freeze_lock, flags);
 }
 EXPORT_SYMBOL_GPL(freeze_wake);
 
-- 
2.5.1

