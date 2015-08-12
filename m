From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.1.3-rt3] [report][suspend to ram] BUG: sleeping function called
 from invalid context at kernel/locking/rtmutex.c:917
Date: Wed, 12 Aug 2015 21:25:50 +0300
Message-ID: <55CB8FAE.9020309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Felipe Balbi <balbi@ti.com>, Sekhar Nori <nsekhar@ti.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39336 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbbHLS0Q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2015 14:26:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I can constantly see below error report with RT-kernel on TI ARM dra7-evm 
if I'm trying to do Suspend to RAM.

Sometimes, It's displayed alone (Log1) and sometimes in combination with 
"INFO: suspicious RCU usage" (Log2).
Below error was not reproduced on vanilla kernel (4.2-rc6).
I don't know if there are any relations, but on vanilla kernel (4.2-rc6)
i can see issue listed in log 3 (just in case).

I'm not familiar with affected code parts and would be appreciated for any comments.

===== LOG 1 =====
 Disabling non-boot CPUs ...
 PM: noirq suspend of devices complete after 7.295 msecs
[  100.285729] Disabling non-boot CPUs ...
[  100.287575] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
[  100.287580] in_atomic(): 1, irqs_disabled(): 128, pid: 18, name: migration/1
[  100.287583] INFO: lockdep is turned off.
[  100.287586] irq event stamp: 122
[  100.287600] hardirqs last  enabled at (121): [<c06ac0ac>] _raw_spin_unlock_irqrestore+0x88/0x90
[  100.287609] hardirqs last disabled at (122): [<c06abed0>] _raw_spin_lock_irq+0x28/0x5c
[  100.287620] softirqs last  enabled at (0): [<c003d294>] copy_process.part.52+0x410/0x19d8
[  100.287625] softirqs last disabled at (0): [<  (null)>]   (null)
[  100.287630] Preemption disabled at:[<  (null)>]   (null)
[  100.287631] 
[  100.287639] CPU: 1 PID: 18 Comm: migration/1 Tainted: G        W       4.1.4-rt3-01046-g96ac8da #204
[  100.287642] Hardware name: Generic DRA74X (Flattened Device Tree)
[  100.287659] [<c0019134>] (unwind_backtrace) from [<c0014774>] (show_stack+0x20/0x24)
[  100.287671] [<c0014774>] (show_stack) from [<c06a70f4>] (dump_stack+0x88/0xdc)
[  100.287681] [<c06a70f4>] (dump_stack) from [<c006cab8>] (___might_sleep+0x198/0x2a8)
[  100.287689] [<c006cab8>] (___might_sleep) from [<c06ac4dc>] (rt_spin_lock+0x30/0x70)
[  100.287699] [<c06ac4dc>] (rt_spin_lock) from [<c013f790>] (find_lock_task_mm+0x9c/0x174)
[  100.287710] [<c013f790>] (find_lock_task_mm) from [<c00409ac>] (clear_tasks_mm_cpumask+0xb4/0x1ac)
[  100.287720] [<c00409ac>] (clear_tasks_mm_cpumask) from [<c00166a4>] (__cpu_disable+0x98/0xbc)
[  100.287728] [<c00166a4>] (__cpu_disable) from [<c06a2e8c>] (take_cpu_down+0x1c/0x50)
[  100.287742] [<c06a2e8c>] (take_cpu_down) from [<c00f2600>] (multi_cpu_stop+0x11c/0x158)
[  100.287754] [<c00f2600>] (multi_cpu_stop) from [<c00f2a9c>] (cpu_stopper_thread+0xc4/0x184)
[  100.287767] [<c00f2a9c>] (cpu_stopper_thread) from [<c0069058>] (smpboot_thread_fn+0x18c/0x324)
[  100.287779] [<c0069058>] (smpboot_thread_fn) from [<c00649c4>] (kthread+0xe8/0x104)
[  100.287791] [<c00649c4>] (kthread) from [<c0010058>] (ret_from_fork+0x14/0x3c)
[  100.288114] CPU1: shutdown
[  100.317696] PM: Calling sched_clock_suspend+0x0/0x40
[  100.317698] PM: Calling timekeeping_suspend+0x0/0x2e0
[  100.317698] PM: Calling irq_gc_suspend+0x0/0x68
[  100.317698] PM: Calling fw_suspend+0x0/0x2c
[  100.317698] PM: Calling cpu_pm_suspend+0x0/0x28

==== LOG 2 ====
[  156.125122] PM: noirq suspend of devices complete after 16.499 msecs
[  156.125250] Disabling non-boot CPUs ...
[  156.153626] NOHZ: local_softirq_pending 02
[  156.154939] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
[  156.154943] in_atomic(): 1, irissueqs_disabled(): 128, pid: 18, name: migration/1
[  156.154948] 2 locks held by migration/1/18:
[  156.154974]  #0:  (rcu_read_lock){......}, at: [<c004093c>] clear_tasks_mm_cpumask+0x44/0x1ac
[  156.154992]  #1:  (rcu_read_lock){......}, at: [<c013f6f4>] find_lock_task_mm+0x0/0x174
[  156.154995] irq event stamp: 126
[  156.155005] hardirqs last  enabled at (125): [<c06ac0e8>] _raw_spin_unlock_irq+0x34/0x78
[  156.155016] hardirqs last disabled at (126): [<c00f25d8>] multi_cpu_stop+0xf4/0x158
[  156.155025] softirqs last  enabled at (0): [<c003d294>] copy_process.part.52+0x410/0x19d8
[  156.155031] softirqs last disabled at (0): [<  (null)>]   (null)
[  156.155036] Preemption disabled at:[<  (null)>]   (null)
[  156.155038] 
[  156.155046] CPU: 1 PID: 18 Comm: migration/1 Tainted: G        W       4.1.4-rt3-01046-g96ac8da #204
[  156.155049] Hardware name: Generic DRA74X (Flattened Device Tree)
[  156.155062] [<c0019134>] (unwind_backtrace) from [<c0014774>] (show_stack+0x20/0x24)
[  156.155074] [<c0014774>] (show_stack) from [<c06a70f4>] (dump_stack+0x88/0xdc)
[  156.155084] [<c06a70f4>] (dump_stack) from [<c006cab8>] (___might_sleep+0x198/0x2a8)
[  156.155091] [<c006cab8>] (___might_sleep) from [<c06ac4dc>] (rt_spin_lock+0x30/0x70)
[  156.155099] [<c06ac4dc>] (rt_spin_lock) from [<c013f790>] (find_lock_task_mm+0x9c/0x174)
[  156.155109] [<c013f790>] (find_lock_task_mm) from [<c00409ac>] (clear_tasks_mm_cpumask+0xb4/0x1ac)
[  156.155118] [<c00409ac>] (clear_tasks_mm_cpumask) from [<c00166a4>] (__cpu_disable+0x98/0xbc)
[  156.155126] [<c00166a4>] (__cpu_disable) from [<c06a2e8c>] (take_cpu_down+0x1c/0x50)
[  156.155136] [<c06a2e8c>] (take_cpu_down) from [<c00f2600>] (multi_cpu_stop+0x11c/0x158)
[  156.155147] [<c00f2600>] (multi_cpu_stop) from [<c00f2a9c>] (cpu_stopper_thread+0xc4/0x184)
[  156.155158] [<c00f2a9c>] (cpu_stopper_thread) from [<c0069058>] (smpboot_thread_fn+0x18c/0x324)
[  156.155170] [<c0069058>] (smpboot_thread_fn) from [<c00649c4>] (kthread+0xe8/0x104)
[  156.155181] [<c00649c4>] (kthread) from [<c0010058>] (ret_from_fork+0x14/0x3c)
[  156.156643] 
[  156.156646] ===============================
[  156.156648] [ INFO: suspicious RCU usage. ]
[  156.156653] 4.1.4-rt3-01046-g96ac8da #204 Tainted: G        W      
[  156.156655] -------------------------------
[  156.156660] include/trace/events/power.h:297 suspicious rcu_dereference_check() usage!
[  156.156662] 
[  156.156662] other info that might help us debug this:
[  156.156662] 
[  156.156666] 
[  156.156666] RCU used illegally from offline CPU!
[  156.156666] rcu_scheduler_active = 1, debug_locks = 0
[  156.156670] no locks held by swapper/1/0.
[  156.156671] 
[  156.156671] stack backtrace:
[  156.156678] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.1.4-rt3-01046-g96ac8da #204
[  156.156681] Hardware name: Generic DRA74X (Flattened Device Tree)
[  156.156692] [<c0019134>] (unwind_backtrace) from [<c0014774>] (show_stack+0x20/0x24)
[  156.156702] [<c0014774>] (show_stack) from [<c06a70f4>] (dump_stack+0x88/0xdc)
[  156.156715] [<c06a70f4>] (dump_stack) from [<c0091258>] (lockdep_rcu_suspicious+0xbc/0x11c)
[  156.156728] [<c0091258>] (lockdep_rcu_suspicious) from [<c00334d0>] (pwrdm_set_next_pwrst+0x134/0x2ec)
[  156.156740] [<c00334d0>] (pwrdm_set_next_pwrst) from [<c002f8ac>] (omap4_hotplug_cpu+0x68/0xd4)
[  156.156751] [<c002f8ac>] (omap4_hotplug_cpu) from [<c06a2d48>] (omap4_cpu_die+0x54/0x9c)
[  156.156759] [<c06a2d48>] (omap4_cpu_die) from [<c06a2cac>] (cpu_die+0x5c/0xa4)
[  156.156769] [<c06a2cac>] (cpu_die) from [<c0010bdc>] (arch_cpu_idle_dead+0x18/0x1c)
[  156.156780] [<c0010bdc>] (arch_cpu_idle_dead) from [<c008d7d4>] (cpu_startup_entry+0x22c/0x4f0)
[  156.156789] [<c008d7d4>] (cpu_startup_entry) from [<c001688c>] (secondary_start_kernel+0x130/0x14c)
[  156.156792] CPU1: shutdown
[  156.156799] [<c001688c>] (secondary_start_kernel) from [<8000970c>] (0x8000970c)
[  156.186995] PM: Calling sched_clock_suspend+0x0/0x40
[  156.186997] PM: Calling timekeeping_suspend+0x0/0x2e0
[  156.186997] PM: Calling irq_gc_suspend+0x0/0x68
[  156.186997] PM: Calling fw_suspend+0x0/0x2c
[  156.186997] PM: Calling cpu_pm_suspend+0x0/0x28

===== LOG 3 =====
[    8.099469] PM: suspend of devices complete after 7.968 msecs
[    8.103121] PM: late suspend of devices complete after 3.642 msecs
[    8.114611] PM: noirq suspend of devices complete after 11.481 msecs
[    8.114670] Disabling non-boot CPUs ...
[    8.119535] 
[    8.119538] ===============================
[    8.119540] [ INFO: suspicious RCU usage. ]
[    8.119545] 4.2.0-rc6-00011-g4a7ab45-dirty #50 Not tainted
[    8.119548] -------------------------------
[    8.119552] kernel/sched/fair.c:5032 suspicious rcu_dereference_check() usage!
[    8.119554] 
[    8.119554] other info that might help us debug this:
[    8.119554] 
[    8.119558] 
[    8.119558] RCU used illegally from offline CPU!
[    8.119558] rcu_scheduler_active = 1, debug_locks = 0
[    8.119562] 3 locks held by swapper/1/0:
[    8.119585]  #0:  ((cpu_died).wait.lock){......}, at: [<c00837a4>] complete+0x14/0x44
[    8.119606]  #1:  (&p->pi_lock){-.-.-.}, at: [<c006ab00>] try_to_wake_up+0x2c/0x410
[    8.119622]  #2:  (rcu_read_lock){......}, at: [<c0072c84>] select_task_rq_fair+0x60/0xae0
[    8.119625] 
[    8.119625] stack backtrace:
[    8.119631] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.2.0-rc6-00011-g4a7ab45-dirty #50
[    8.119634] Hardware name: Generic DRA74X (Flattened Device Tree)
[    8.119646] [<c0016e24>] (unwind_backtrace) from [<c0013338>] (show_stack+0x10/0x14)
[    8.119656] [<c0013338>] (show_stack) from [<c05f6b2c>] (dump_stack+0x84/0x9c)
[    8.119665] [<c05f6b2c>] (dump_stack) from [<c0073338>] (select_task_rq_fair+0x714/0xae0)
[    8.119675] [<c0073338>] (select_task_rq_fair) from [<c006abf0>] (try_to_wake_up+0x11c/0x410)
[    8.119684] [<c006abf0>] (try_to_wake_up) from [<c0082fe8>] (__wake_up_common+0x4c/0x80)
[    8.119690] [<c0082fe8>] (__wake_up_common) from [<c0083030>] (__wake_up_locked+0x14/0x1c)
[    8.119697] [<c0083030>] (__wake_up_locked) from [<c00837c4>] (complete+0x34/0x44)
[    8.119705] [<c00837c4>] (complete) from [<c05f2d34>] (cpu_die+0x34/0x9c)
[    8.119713] [<c05f2d34>] (cpu_die) from [<c0083be0>] (cpu_startup_entry+0x204/0x314)
[    8.119720] [<c0083be0>] (cpu_startup_entry) from [<800095ac>] (0x800095ac)
[    8.119748] CPU1: shutdown

-- 
regards,
-grygorii
