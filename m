From: Yang Shi <yang.shi@linaro.org>
Subject: [v3 PATCH] arm64: replace read_lock to rcu lock in call_break_hook
Date: Mon,  5 Oct 2015 14:32:51 -0700
Message-ID: <1444080771-22468-1-git-send-email-yang.shi@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, yang.shi@linaro.org
To: rostedt@goodmis.org, catalin.marinas@arm.com, will.deacon@arm.com,
	paulmck@linux.vnet.ibm.com, dave.long@linaro.org, panand@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34471 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbJEVty (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 17:49:54 -0400
Received: by padhy16 with SMTP id hy16so47801802pad.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 14:49:53 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
in_atomic(): 0, irqs_disabled(): 128, pid: 342, name: perf
1 lock held by perf/342:
 #0:  (break_hook_lock){+.+...}, at: [<ffffffc0000851ac>] call_break_hook+0x34/0xd0
irq event stamp: 62224
hardirqs last  enabled at (62223): [<ffffffc00010b7bc>] __call_rcu.constprop.59+0x104/0x270
hardirqs last disabled at (62224): [<ffffffc0000fbe20>] vprintk_emit+0x68/0x640
softirqs last  enabled at (0): [<ffffffc000097928>] copy_process.part.8+0x428/0x17f8
softirqs last disabled at (0): [<          (null)>]           (null)
CPU: 0 PID: 342 Comm: perf Not tainted 4.1.6-rt5 #4
Hardware name: linux,dummy-virt (DT)
Call trace:
[<ffffffc000089968>] dump_backtrace+0x0/0x128
[<ffffffc000089ab0>] show_stack+0x20/0x30
[<ffffffc0007030d0>] dump_stack+0x7c/0xa0
[<ffffffc0000c878c>] ___might_sleep+0x174/0x260
[<ffffffc000708ac8>] __rt_spin_lock+0x28/0x40
[<ffffffc000708db0>] rt_read_lock+0x60/0x80
[<ffffffc0000851a8>] call_break_hook+0x30/0xd0
[<ffffffc000085a70>] brk_handler+0x30/0x98
[<ffffffc000082248>] do_debug_exception+0x50/0xb8
Exception stack(0xffffffc00514fe30 to 0xffffffc00514ff50)
fe20:                                     00000000 00000000 c1594680 0000007f
fe40: ffffffff ffffffff 92063940 0000007f 0550dcd8 ffffffc0 00000000 00000000
fe60: 0514fe70 ffffffc0 000be1f8 ffffffc0 0514feb0 ffffffc0 0008948c ffffffc0
fe80: 00000004 00000000 0514fed0 ffffffc0 ffffffff ffffffff 9282a948 0000007f
fea0: 00000000 00000000 9282b708 0000007f c1592820 0000007f 00083914 ffffffc0
fec0: 00000000 00000000 00000010 00000000 00000064 00000000 00000001 00000000
fee0: 005101e0 00000000 c1594680 0000007f c1594740 0000007f ffffffd8 ffffff80
ff00: 00000000 00000000 00000000 00000000 c1594770 0000007f c1594770 0000007f
ff20: 00665e10 00000000 7f7f7f7f 7f7f7f7f 01010101 01010101 00000000 00000000
ff40: 928e4cc0 0000007f 91ff11e8 0000007f

call_break_hook is called in atomic context (hard irq disabled), so replace
the sleepable lock to rcu lock, replace relevant list operations to rcu
version and call synchronize_rcu() in unregister_break_hook().

And, replace write lock to spinlock in {un}register_break_hook.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
v2 -> v3
Add synchronize_rcu() in ungister_break_hook()
Replace write lock to spinlock

v1 -> v2
Replace list operations to rcu version.

 arch/arm64/kernel/debug-monitors.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index cebf786..13ca9cd 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -271,20 +271,21 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
  * Use reader/writer locks instead of plain spinlock.
  */
 static LIST_HEAD(break_hook);
-static DEFINE_RWLOCK(break_hook_lock);
+static DEFINE_SPINLOCK(break_hook_lock);
 
 void register_break_hook(struct break_hook *hook)
 {
-	write_lock(&break_hook_lock);
-	list_add(&hook->node, &break_hook);
-	write_unlock(&break_hook_lock);
+	spin_lock(&break_hook_lock);
+	list_add_rcu(&hook->node, &break_hook);
+	spin_unlock(&break_hook_lock);
 }
 
 void unregister_break_hook(struct break_hook *hook)
 {
-	write_lock(&break_hook_lock);
-	list_del(&hook->node);
-	write_unlock(&break_hook_lock);
+	spin_lock(&break_hook_lock);
+	list_del_rcu(&hook->node);
+	spin_unlock(&break_hook_lock);
+	synchronize_rcu();
 }
 
 static int call_break_hook(struct pt_regs *regs, unsigned int esr)
@@ -292,11 +293,11 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
 	struct break_hook *hook;
 	int (*fn)(struct pt_regs *regs, unsigned int esr) = NULL;
 
-	read_lock(&break_hook_lock);
-	list_for_each_entry(hook, &break_hook, node)
+	rcu_read_lock();
+	list_for_each_entry_rcu(hook, &break_hook, node)
 		if ((esr & hook->esr_mask) == hook->esr_val)
 			fn = hook->fn;
-	read_unlock(&break_hook_lock);
+	rcu_read_unlock();
 
 	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
 }
-- 
2.0.2

