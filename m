From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] show_stack_lvl smp_processor_id
Date: Tue, 21 Jul 2009 16:43:14 +0200
Message-ID: <20090721144314.GA3858@tycho.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47452 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558AbZGUOn3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Jul 2009 10:43:29 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In trying to find the source of an hwlat_detect hang, I encountered the following.
I have a little patch that fixes the "BUG: using smp_processor_id() in preemptible"
Howver, I think Thomas is thinking about whether this code is actually preemptible.
Still, wanted to get the patch out there for your scrutiny.

INFO: task hwlatdetect:4057 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
hwlatdetect   D (004) [ffff88012c188340] ffff88002bbd0180  3384  4057   3875
BUG: using smp_processor_id() in preemptible [00000000] code: khungtaskd/340
caller is show_stack_log_lvl+0x3c/0x133
Pid: 340, comm: khungtaskd Tainted: G        W  2.6.29.6-rt23-dbg #1
Call Trace:
 [<ffffffff811f5b9a>] debug_smp_processor_id+0xda/0x108
 [<ffffffff8100f023>] show_stack_log_lvl+0x3c/0x133
 [<ffffffff813d6a70>] ? printk+0x50/0x68
 [<ffffffff81010289>] show_stack+0x2f/0x45
 [<ffffffff810498fc>] sched_show_task+0x104/0x11f
 [<ffffffff810b1334>] watchdog+0x1ac/0x220
 [<ffffffff81081ec1>] ? trace_hardirqs_on+0x20/0x36
 [<ffffffff810b1188>] ? watchdog+0x0/0x220
 [<ffffffff8106e643>] kthread+0x61/0xa4
 [<ffffffff8100d3da>] child_rip+0xa/0x20
 [<ffffffff8100cd80>] ? restore_args+0x0/0x30
 [<ffffffff8106e5e2>] ? kthread+0x0/0xa4
 [<ffffffff8100d3d0>] ? child_rip+0x0/0x20
 ffff88012d957d28 0000000000000092 00000000de864e34 00000000de864e34
 00000000de864e34 ffffffff818c8008 ffff88012c188340 ffff88012c4d17c0
 ffff88012c1886e8 00000000de864e34 ffffffff813d8bb7 ffffffff818c8020
Call Trace:
 [<ffffffff813d8bb7>] ? rt_spin_lock_slowunlock+0x27/0xa1
 [<ffffffff813d8bb7>] ? rt_spin_lock_slowunlock+0x27/0xa1
 [<ffffffff813d7cf8>] schedule+0x27/0x61
 [<ffffffff813d7e82>] schedule_timeout+0x36/0xf2
 [<ffffffff813daa51>] ? __spin_unlock_irqrestore+0x7e/0xa3
 [<ffffffff813d8bed>] ? rt_spin_lock_slowunlock+0x5d/0xa1
 [<ffffffff813d9a71>] ? rt_spin_unlock+0x5c/0x77
 [<ffffffff813d6dfe>] wait_for_common+0xcc/0x129
 [<ffffffff8104c819>] ? default_wake_function+0x0/0x3d
 [<ffffffff813d6fad>] wait_for_completion+0x30/0x46
 [<ffffffff8106e76b>] kthread_stop+0xe5/0x17e
 [<ffffffffa046ef72>] debug_enable_fwrite+0xdd/0x121 [hwlat_detector]
 [<ffffffff8111dfc8>] vfs_write+0xc3/0x135
 [<ffffffff8111e13a>] sys_write+0x5b/0x98
 [<ffffffff8100c29b>] system_call_fastpath+0x16/0x1b
INFO: lockdep is turned off.
Kernel panic - not syncing: hung_task: blocked tasks


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-fix-for-BUG-smp_processor_id-called-from-preempti.patch"

>From ef4c64b259fe992058d9cbc07ddb12a94ac53b36 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Tue, 21 Jul 2009 14:02:51 +0200
Subject: [PATCH] fix for BUG: smp_processor_id() called from preemptible code

---
 arch/x86/kernel/dumpstack_64.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 2d256b5..1c33bdc 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -203,11 +203,12 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 {
 	unsigned long *stack;
 	int i;
-	const int cpu = smp_processor_id();
+	const int cpu = get_cpu();
 	unsigned long *irq_stack_end =
 		(unsigned long *)(per_cpu(irq_stack_ptr, cpu));
 	unsigned long *irq_stack =
 		(unsigned long *)(per_cpu(irq_stack_ptr, cpu) - IRQ_STACK_SIZE);
+	put_cpu();
 
 	/*
 	 * debugging aid: "show_stack(NULL, NULL);" prints the
-- 
1.6.0.6


--ZGiS0Q5IWpPtfppv--
