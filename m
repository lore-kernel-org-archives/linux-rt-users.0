From: Rex Feany <rfeany@laeos.net>
Subject: lockdep complaints with 3.2.5+rt11 on OMAP
Date: Tue, 7 Feb 2012 12:38:15 -0800
Message-ID: <20120207203814.GA32384@rexfeany.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ilona.fnordsoft.com ([173.230.144.79]:34580 "EHLO
	ilona.fnordsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384Ab2BGUod (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Feb 2012 15:44:33 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Is this the right place to report this? Booting 3.2.5+rt11 on an omap3730 gives me this:

[    0.138354] 
[    0.138374] =================================
[    0.138386] [ INFO: inconsistent lock state ]
[    0.138400] 3.2.5-rt11-00002-g7b398a8 #10
[    0.138409] ---------------------------------
[    0.138423] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[    0.138442] swapper/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
[    0.138456]  (rcu_kthread_wq.lock.lock.wait_lock){?.+...}, at: [<c0276810>] rt_spin_lock_slowlock+0x38/0x1e8
[    0.138506] {HARDIRQ-ON-W} state was registered at:
[    0.138518]   [<c00729f0>] mark_lock+0x290/0x600
[    0.138542]   [<c00749c8>] __lock_acquire+0x79c/0x1a34
[    0.138562]   [<c0076278>] lock_acquire+0x114/0x134
[    0.138580]   [<c0277724>] _raw_spin_lock+0x4c/0x5c
[    0.138602]   [<c0276810>] rt_spin_lock_slowlock+0x38/0x1e8
[    0.138621]   [<c0276da0>] rt_spin_lock+0x20/0x50
[    0.138639]   [<c005fab0>] prepare_to_wait+0x30/0x74
[    0.138660]   [<c0083c70>] rcu_kthread+0x74/0x1c4
[    0.138682]   [<c005f500>] kthread+0x8c/0x94
[    0.138698]   [<c0014cd4>] kernel_thread_exit+0x0/0x8
[    0.138719] irq event stamp: 2135
[    0.138729] hardirqs last  enabled at (2134): [<c0073360>] debug_check_no_locks_freed+0x11c/0x148
[    0.138755] hardirqs last disabled at (2135): [<c00137b4>] __irq_svc+0x34/0xa0
[    0.138784] softirqs last  enabled at (0): [<c003e3cc>] copy_process+0x334/0xde0
[    0.138811] softirqs last disabled at (0): [<  (null)>]   (null)
[    0.138828] 
[    0.138832] other info that might help us debug this:
[    0.138844]  Possible unsafe locking scenario:
[    0.138852] 
[    0.138858]        CPU0
[    0.138865]        ----
[    0.138872]   lock(rcu_kthread_wq.lock.lock.wait_lock);
[    0.138887]   <Interrupt>
[    0.138895]     lock(rcu_kthread_wq.lock.lock.wait_lock);
[    0.138909] 
[    0.138914]  *** DEADLOCK ***
[    0.138920] 
[    0.138929] 1 lock held by swapper/1:
[    0.138939]  #0:  (sysfs_assoc_lock.lock.wait_lock){+.+...}, at: [<c0276810>] rt_spin_lock_slowlock+0x38/0x1e8
[    0.138976] 
[    0.138980] stack backtrace:
[    0.139014] [<c0019e74>] (unwind_backtrace+0x0/0xf0) from [<c02749a0>] (dump_stack+0x1c/0x20)
[    0.139047] [<c02749a0>] (dump_stack+0x1c/0x20) from [<c00726f8>] (print_usage_bug+0x230/0x298)
[    0.139078] [<c00726f8>] (print_usage_bug+0x230/0x298) from [<c0072ab4>] (mark_lock+0x354/0x600)
[    0.139108] [<c0072ab4>] (mark_lock+0x354/0x600) from [<c007493c>] (__lock_acquire+0x710/0x1a34)
[    0.139138] [<c007493c>] (__lock_acquire+0x710/0x1a34) from [<c0076278>] (lock_acquire+0x114/0x134)
[    0.139170] [<c0076278>] (lock_acquire+0x114/0x134) from [<c0277724>] (_raw_spin_lock+0x4c/0x5c)
[    0.139202] [<c0277724>] (_raw_spin_lock+0x4c/0x5c) from [<c0276810>] (rt_spin_lock_slowlock+0x38/0x1e8)
[    0.139234] [<c0276810>] (rt_spin_lock_slowlock+0x38/0x1e8) from [<c0276da0>] (rt_spin_lock+0x20/0x50)
[    0.139265] [<c0276da0>] (rt_spin_lock+0x20/0x50) from [<c0036cf8>] (__wake_up+0x28/0x50)
[    0.139298] [<c0036cf8>] (__wake_up+0x28/0x50) from [<c0084374>] (rcu_check_callbacks+0xc8/0x11c)
[    0.139339] [<c0084374>] (rcu_check_callbacks+0xc8/0x11c) from [<c004e6d4>] (update_process_times+0x4c/0x58)
[    0.139383] [<c004e6d4>] (update_process_times+0x4c/0x58) from [<c006e9a8>] (tick_periodic+0x90/0xb4)
[    0.139419] [<c006e9a8>] (tick_periodic+0x90/0xb4) from [<c006e9f0>] (tick_handle_periodic+0x24/0x98)
[    0.139457] [<c006e9f0>] (tick_handle_periodic+0x24/0x98) from [<c00212a0>] (omap2_gp_timer_interrupt+0x30/0x40)
[    0.139495] [<c00212a0>] (omap2_gp_timer_interrupt+0x30/0x40) from [<c007f350>] (handle_irq_event_percpu+0xa8/0x260)
[    0.139526] [<c007f350>] (handle_irq_event_percpu+0xa8/0x260) from [<c007f554>] (handle_irq_event+0x4c/0x6c)
[    0.139556] [<c007f554>] (handle_irq_event+0x4c/0x6c) from [<c008200c>] (handle_level_irq+0xd0/0x100)
[    0.139586] [<c008200c>] (handle_level_irq+0xd0/0x100) from [<c007ee60>] (generic_handle_irq+0x38/0x4c)
[    0.139615] [<c007ee60>] (generic_handle_irq+0x38/0x4c) from [<c0014c54>] (handle_IRQ+0x6c/0x90)
[    0.139644] [<c0014c54>] (handle_IRQ+0x6c/0x90) from [<c00084ac>] (asm_do_IRQ+0x14/0x18)
[    0.139677] [<c00084ac>] (asm_do_IRQ+0x14/0x18) from [<c00137b8>] (__irq_svc+0x38/0xa0)
[    0.139696] Exception stack(0xdf84dd40 to 0xdf84dd88)
[    0.139719] dd40: 00000001 c053b798 00000001 df84a040 00000000 00000000 00000000 00000000
[    0.139746] dd60: c0450cd8 00000002 60000013 df84ddcc 00000526 df84dd88 c047ef70 c007628c
[    0.139765] dd80: 80000013 ffffffff
[    0.139792] [<c00137b8>] (__irq_svc+0x38/0xa0) from [<c007628c>] (lock_acquire+0x128/0x134)
[    0.139828] [<c007628c>] (lock_acquire+0x128/0x134) from [<c0277724>] (_raw_spin_lock+0x4c/0x5c)
[    0.139861] [<c0277724>] (_raw_spin_lock+0x4c/0x5c) from [<c0276810>] (rt_spin_lock_slowlock+0x38/0x1e8)
[    0.139894] [<c0276810>] (rt_spin_lock_slowlock+0x38/0x1e8) from [<c0276da0>] (rt_spin_lock+0x20/0x50)
[    0.139931] [<c0276da0>] (rt_spin_lock+0x20/0x50) from [<c0126070>] (sysfs_do_create_link+0x50/0x1e4)
[    0.139964] [<c0126070>] (sysfs_do_create_link+0x50/0x1e4) from [<c0126238>] (sysfs_create_link+0x18/0x1c)
[    0.140003] [<c0126238>] (sysfs_create_link+0x18/0x1c) from [<c018b1f8>] (bus_add_device+0xc4/0x178)
[    0.140038] [<c018b1f8>] (bus_add_device+0xc4/0x178) from [<c0189e48>] (device_add+0x3d4/0x5bc)
[    0.140070] [<c0189e48>] (device_add+0x3d4/0x5bc) from [<c018d768>] (platform_device_add+0x110/0x16c)
[    0.140104] [<c018d768>] (platform_device_add+0x110/0x16c) from [<c036ce7c>] (regulator_dummy_init+0x3c/0x9c)
[    0.140136] [<c036ce7c>] (regulator_dummy_init+0x3c/0x9c) from [<c036cc78>] (regulator_init+0x94/0xc4)
[    0.140167] [<c036cc78>] (regulator_init+0x94/0xc4) from [<c0357268>] (do_one_initcall+0x9c/0x168)
[    0.140198] [<c0357268>] (do_one_initcall+0x9c/0x168) from [<c03573ec>] (kernel_init+0x7c/0x120)
[    0.140228] [<c03573ec>] (kernel_init+0x7c/0x120) from [<c0014cd4>] (kernel_thread_exit+0x0/0x8)

config: http://tonya.fnordsoft.com/omap-rt/omap-3.2.5-rt-config
full dmesg: http://tonya.fnordsoft.com/omap-rt/rt-dmesg
non-rt kernel dmesg: http://tonya.fnordsoft.com/omap-rt/non-rt-dmesg

take care!
/rex.
