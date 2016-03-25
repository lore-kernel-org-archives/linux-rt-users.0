From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 25 Mar 2016 10:14:08 +0100
Message-ID: <1458897248.3870.9.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1458817594.3972.16.camel@gmail.com> <1458884330.3836.21.camel@gmail.com>
	 <alpine.DEB.2.11.1603250951100.3978@nanos>
	 <1458897196.3870.8.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34622 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcCYJOM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Mar 2016 05:14:12 -0400
In-Reply-To: <1458897196.3870.8.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Rock #1..

hotplug/rt: Nest module_mutex inside cpu_hotplug.lock

PID: 11107  TASK: ffff8803b12b9900  CPU: 4   COMMAND: "stress-cpu-hotp"                                                                                                                                                                      
 #0 [ffff88038b34f9b8] __schedule at ffffffff816b7132
 #1 [ffff88038b34fa08] schedule at ffffffff816b796b
 #2 [ffff88038b34fa28] rt_mutex_slowlock at ffffffff816b93ee
 #3 [ffff88038b34fac8] rt_mutex_fastlock at ffffffff811b0e9d
 #4 [ffff88038b34faf0] rt_mutex_lock at ffffffff816b95c8
 #5 [ffff88038b34fb08] _mutex_lock at ffffffff816baf59
 #6 [ffff88038b34fb28] kernfs_find_and_get_ns at ffffffff812cd573
 #7 [ffff88038b34fb50] sysfs_remove_group at ffffffff812d100a
 #8 [ffff88038b34fb78] thermal_throttle_cpu_callback at ffffffff81036ab9
 #9 [ffff88038b34fb98] notifier_call_chain at ffffffff8109b8dd
#10 [ffff88038b34fbd8] __raw_notifier_call_chain at ffffffff8109b90e
#11 [ffff88038b34fbe8] __cpu_notify at ffffffff81072825
#12 [ffff88038b34fbf8] cpu_notify_nofail at ffffffff81072b15
#13 [ffff88038b34fc08] notify_dead at ffffffff81072d06
#14 [ffff88038b34fc38] cpuhp_invoke_callback at ffffffff81073718
#15 [ffff88038b34fc78] cpuhp_down_callbacks at ffffffff81073a70
#16 [ffff88038b34fcb8] _cpu_down at ffffffff816afc61
#17 [ffff88038b34fd38] do_cpu_down at ffffffff8107434c
#18 [ffff88038b34fd60] cpu_down at ffffffff81074380
#19 [ffff88038b34fd70] cpu_subsys_offline at ffffffff814cd844
#20 [ffff88038b34fd80] device_offline at ffffffff814c7cca
#21 [ffff88038b34fda8] online_store at ffffffff814c7dc0
#22 [ffff88038b34fdd0] dev_attr_store at ffffffff814c4fb8
#23 [ffff88038b34fde0] sysfs_kf_write at ffffffff812cfbd4
#24 [ffff88038b34fe08] kernfs_fop_write at ffffffff812cf162
#25 [ffff88038b34fe50] __vfs_write at ffffffff81241418
#26 [ffff88038b34fed0] vfs_write at ffffffff81242525
#27 [ffff88038b34ff10] sys_write at ffffffff812438e9
#28 [ffff88038b34ff50] entry_SYSCALL_64_fastpath at ffffffff816bb4fc
    RIP: 00007f05f3d69cd0  RSP: 00007ffdfc934468  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000001908770  RCX: 00007f05f3d69cd0
    RDX: 0000000000000002  RSI: 00007f05f4898000  RDI: 0000000000000001
    RBP: 00007ffdfc934480   R8: 000000000000000a   R9: 00007f05f4892700
    R10: 00000000ffffffff  R11: 0000000000000246  R12: 0000000000000007
    R13: 0000000000000001  R14: 0000000000000009  R15: 000000000000000a
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

stress-cpu-hotp blocks on kernfs_mutex, held by systemd-udevd..

crash> bt ffff8803b12bcb00
PID: 11130  TASK: ffff8803b12bcb00  CPU: 6   COMMAND: "systemd-udevd"
 #0 [ffff88038b327a18] __schedule at ffffffff816b7132
 #1 [ffff88038b327a68] schedule at ffffffff816b796b
 #2 [ffff88038b327a88] rt_spin_lock_slowlock at ffffffff816b9750
 #3 [ffff88038b327b30] rt_spin_lock_fastlock at ffffffff811b0f2c
 #4 [ffff88038b327b50] rt_spin_lock__no_mg at ffffffff816bac7b
 #5 [ffff88038b327b70] pin_current_cpu at ffffffff8107406a
 #6 [ffff88038b327bb8] migrate_disable at ffffffff810a0e8e
 #7 [ffff88038b327bd8] rt_spin_lock at ffffffff816badc9
 #8 [ffff88038b327bf8] ida_simple_remove at ffffffff8138765c
 #9 [ffff88038b327c18] kernfs_put at ffffffff812ccc58
#10 [ffff88038b327c60] __kernfs_remove at ffffffff812cd15c
#11 [ffff88038b327cc0] kernfs_remove_by_name_ns at ffffffff812ce2f3
#12 [ffff88038b327ce8] sysfs_remove_link at ffffffff812d05e9
#13 [ffff88038b327cf8] free_module at ffffffff8111c8f2
#14 [ffff88038b327d30] do_init_module at ffffffff811b157f
#15 [ffff88038b327d58] load_module at ffffffff8111f11b
#16 [ffff88038b327e98] SYSC_finit_module at ffffffff8111faf9
#17 [ffff88038b327f40] sys_finit_module at ffffffff8111fb3e
#18 [ffff88038b327f50] entry_SYSCALL_64_fastpath at ffffffff816bb4fc
    RIP: 00007f75d9925f79  RSP: 00007ffd1c040ed8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000001d368e0  RCX: 00007f75d9925f79
    RDX: 0000000000000000  RSI: 00007f75da0233c1  RDI: 0000000000000008
    RBP: 0000000000000008   R8: 0000000000000000   R9: 0000000001d39c82
    R10: 0000000000000008  R11: 0000000000000246  R12: 00007ffd1c03ff00
    R13: 00007ffd1c03fee0  R14: 0000000000000005  R15: 000000000aba9500
    ORIG_RAX: 0000000000000139  CS: 0033  SS: 002b

..which stress-cpu-hotp has blocked via pin_current_cpu().  Game Over.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/cpu.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -23,6 +23,9 @@
 #include <linux/tick.h>
 #include <linux/irq.h>
 #include <trace/events/power.h>
+#ifdef CONFIG_PREEMPT_RT_BASE
+#include <linux/module.h>
+#endif
 
 #include "smpboot.h"
 
@@ -442,10 +445,16 @@ void cpu_hotplug_begin(void)
 		schedule();
 	}
 	finish_wait(&cpu_hotplug.wq, &wait);
+#ifdef CONFIG_PREEMPT_RT_BASE
+	mutex_lock(&module_mutex);
+#endif
 }
 
 void cpu_hotplug_done(void)
 {
+#ifdef CONFIG_PREEMPT_RT_BASE
+	mutex_unlock(&module_mutex);
+#endif
 	cpu_hotplug.active_writer = NULL;
 	mutex_unlock(&cpu_hotplug.lock);
 	cpuhp_lock_release();
