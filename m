From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: rcu  stalls running 3.0.1-rt8
Date: Mon, 8 Aug 2011 16:10:39 -0700
Message-ID: <20110808231039.GP4435@linux.vnet.ibm.com>
References: <1312580681.28695.44.camel@twins>
 <1312811718.5896.29.camel@marge.simson.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:46927 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338Ab1HHXKm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Aug 2011 19:10:42 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p78MvSAJ031785
	for <linux-rt-users@vger.kernel.org>; Mon, 8 Aug 2011 18:57:28 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p78NAeaR260630
	for <linux-rt-users@vger.kernel.org>; Mon, 8 Aug 2011 19:10:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p78NAekQ017333
	for <linux-rt-users@vger.kernel.org>; Mon, 8 Aug 2011 19:10:40 -0400
Content-Disposition: inline
In-Reply-To: <1312811718.5896.29.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 08, 2011 at 03:55:18PM +0200, Mike Galbraith wrote:
> Greetings,
> 
> I've had no time to tinker with this but though I should get it posted,
> so build latest/greatest to make sure it's still there.  It is.
> 
> Box can be idling along, and pow.  If RCU_BOOST is enabled, I get a hung
> task panic after the stall.  If RCU_BOOST is off, and debugging options
> are cut to the bone, box will stay up despite periodic gripes.

Yow!

Is this new in -rt8?  I wasn't seeing it in earlier versions.  Then
again, I was running 32 bits.

							Thanx, Paul

> [  958.518744] INFO: rcu_preempt_state detected stalls on CPUs/tasks: {} (detected by 1, t=65002 jiffies)
> [  958.518748] sending NMI to all CPUs:
> [  958.518751] NMI backtrace for cpu 3
> [  958.518753] CPU 3 
> [  958.518754] Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler cpufreq_conservative cdc_ether usbnet mii bnx2 shpchp i7core_edac edac_core ext4 jbd2 megaraid_sas
> [  958.518761] 
> [  958.518763] Pid: 6948, comm: pert Not tainted 3.0.1-rt8 #6 IBM System x3550 M3 -[7944K3G]-/69Y5698     
> [  958.518766] RIP: 0010:[<ffffffff810cd4e7>]  [<ffffffff810cd4e7>] mark_lock+0x377/0x660
> [  958.518772] RSP: 0000:ffff88017fcc3bf8  EFLAGS: 00000082
> [  958.518774] RAX: 0000000000000001 RBX: ffff880177eb4920 RCX: 0000000000000003
> [  958.518775] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88017fcc3b68
> [  958.518777] RBP: ffff88017fcc3c48 R08: 0000000000000001 R09: 0000000000010001
> [  958.518778] R10: 0000000000000000 R11: 0000000000010002 R12: 0000000000000000
> [  958.518780] R13: ffff880177eb42c0 R14: ffffffff82174f20 R15: ffffffff810cc340
> [  958.518781] FS:  00007f24e0383700(0000) GS:ffff88017fcc0000(0000) knlGS:0000000000000000
> [  958.518783] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  958.518784] CR2: 00007f24dfce0430 CR3: 00000001752dc000 CR4: 00000000000006e0
> [  958.518786] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  958.518787] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  958.518789] Process pert (pid: 6948, threadinfo ffff880174b92000, task ffff880177eb42c0)
> [  958.518790] Stack:
> [  958.518791]  00000000000000bb 0000000000000001 0000000000000000 ffffffff00000003
> [  958.518794]  000048807c158089 0000000000000018 ffff880177eb42c0 0000000000000000
> [  958.518796]  0000000000000002 0000000000000000 ffff88017fcc3d48 ffffffff810cf2d3
> [  958.518798] Call Trace:
> [  958.518799]  <IRQ> 
> [  958.518802]  [<ffffffff810cf2d3>] __lock_acquire+0x8e3/0x1f20
> [  958.518804]  [<ffffffff810ceef9>] ? __lock_acquire+0x509/0x1f20
> [  958.518809]  [<ffffffff81050f4f>] ? intel_pmu_enable_all+0x5f/0x110
> [  958.518811]  [<ffffffff8105117b>] ? intel_pmu_nhm_enable_all+0x2b/0x150
> [  958.518814]  [<ffffffff810d0feb>] lock_acquire+0x9b/0x1d0
> [  958.518817]  [<ffffffff810ffd69>] ? __rcu_pending+0x89/0x3e0
> [  958.518821]  [<ffffffff81818966>] _raw_spin_lock_irqsave+0x46/0x60
> [  958.518823]  [<ffffffff810ffd69>] ? __rcu_pending+0x89/0x3e0
> [  958.518826]  [<ffffffff810ffd69>] __rcu_pending+0x89/0x3e0
> [  958.518828]  [<ffffffff8110024a>] rcu_check_callbacks+0x10a/0x160
> [  958.518832]  [<ffffffff810a387d>] update_process_times+0x4d/0x70
> [  958.518835]  [<ffffffff810c9cda>] tick_sched_timer+0x5a/0x150
> [  958.518839]  [<ffffffff810bc193>] __run_hrtimer+0x73/0x390
> [  958.518841]  [<ffffffff810c9c80>] ? tick_init_highres+0x20/0x20
> [  958.518843]  [<ffffffff810bd1bf>] hrtimer_interrupt+0xff/0x230
> [  958.518846]  [<ffffffff8181c1ad>] ? add_preempt_count+0x9d/0xd0
> [  958.518850]  [<ffffffff81821786>] smp_apic_timer_interrupt+0x66/0x98
> [  958.518852]  [<ffffffff81820a93>] apic_timer_interrupt+0x13/0x20
> [  958.518853]  <EOI> 
> [  958.518856]  [<ffffffff81818f31>] ? retint_swapgs+0xe/0x13
> [  958.518857] Code: 0f b7 43 20 44 89 75 c8 66 25 ff 1f 0f 85 0b 01 00 00 45 31 f6 83 3d 4c ee f5 00 00 0f 84 ca 00 00 00 b8 01 00 00 00 0f b6 4d c8 <d3> e0 48 98 49 85 46 30 0f 85 93 00 00 00 41 8d 44 24 01 a8 01 
> [  958.518874] Call Trace:
> [  958.518875]  <IRQ>  [<ffffffff810cf2d3>] __lock_acquire+0x8e3/0x1f20
> [  958.518879]  [<ffffffff810ceef9>] ? __lock_acquire+0x509/0x1f20
> [  958.518881]  [<ffffffff81050f4f>] ? intel_pmu_enable_all+0x5f/0x110
> [  958.518884]  [<ffffffff8105117b>] ? intel_pmu_nhm_enable_all+0x2b/0x150
> [  958.518886]  [<ffffffff810d0feb>] lock_acquire+0x9b/0x1d0
> [  958.518888]  [<ffffffff810ffd69>] ? __rcu_pending+0x89/0x3e0
> [  958.518891]  [<ffffffff81818966>] _raw_spin_lock_irqsave+0x46/0x60
> [  958.518893]  [<ffffffff810ffd69>] ? __rcu_pending+0x89/0x3e0
> [  958.518896]  [<ffffffff810ffd69>] __rcu_pending+0x89/0x3e0
> [  958.518898]  [<ffffffff8110024a>] rcu_check_callbacks+0x10a/0x160
> [  958.518901]  [<ffffffff810a387d>] update_process_times+0x4d/0x70
> [  958.518903]  [<ffffffff810c9cda>] tick_sched_timer+0x5a/0x150
> [  958.518905]  [<ffffffff810bc193>] __run_hrtimer+0x73/0x390
> [  958.518907]  [<ffffffff810c9c80>] ? tick_init_highres+0x20/0x20
> [  958.518910]  [<ffffffff810bd1bf>] hrtimer_interrupt+0xff/0x230
> [  958.518912]  [<ffffffff8181c1ad>] ? add_preempt_count+0x9d/0xd0
> [  958.518914]  [<ffffffff81821786>] smp_apic_timer_interrupt+0x66/0x98
> [  958.518916]  [<ffffffff81820a93>] apic_timer_interrupt+0x13/0x20
> [  958.518918]  <EOI>  [<ffffffff81818f31>] ? retint_swapgs+0xe/0x13
> [  958.518921] NMI backtrace for cpu 1
> [  958.518922] CPU 1 
> [  958.518923] Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler cpufreq_conservative cdc_ether usbnet mii bnx2 shpchp i7core_edac edac_core ext4 jbd2 megaraid_sas
> [  958.518929] 
> [  958.518931] Pid: 0, comm: kworker/0:0 Not tainted 3.0.1-rt8 #6 IBM System x3550 M3 -[7944K3G]-/69Y5698     
> [  958.518934] RIP: 0010:[<ffffffff8133c690>]  [<ffffffff8133c690>] __ndelay+0x30/0x30
> [  958.518939] RSP: 0018:ffff88017fc43dc0  EFLAGS: 00000807
> [  958.518940] RAX: 00000000462f5480 RBX: 0000000000002710 RCX: 0000000000000098
> [  958.518942] RDX: 0000000000249ec0 RSI: 0000000000000002 RDI: 0000000000249ec1
> [  958.518943] RBP: ffff88017fc43dc8 R08: 0000000000000000 R09: 0000000000000000
> [  958.518944] R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff81e2ec80
> [  958.518946] R13: ffffffff81e2ec80 R14: ffffffff81e2ee00 R15: 000000000000fdea
> [  958.518948] FS:  0000000000000000(0000) GS:ffff88017fc40000(0000) knlGS:0000000000000000
> [  958.518949] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  958.518951] CR2: 00007f4e2ab33000 CR3: 000000017789f000 CR4: 00000000000006e0
> [  958.518952] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  958.518953] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  958.518955] Process kworker/0:0 (pid: 0, threadinfo ffff88017a90e000, task ffff88017a90c480)
> [  958.518956] Stack:
> [  958.518957]  ffffffff8133c5ef ffff88017fc43dd8 ffffffff8133c62c ffff88017fc43df8
> [  958.518960]  ffffffff8105eb6a 0000000000000000 ffff88017fc4b8e0 ffff88017fc43e48
> [  958.518962]  ffffffff81100060 ffff88017fc43f48 ffffffff81e2ec80 ffff88017fc43e28
> [  958.518964] Call Trace:
> [  958.518965]  <IRQ> 
> [  958.518967]  [<ffffffff8133c5ef>] ? __delay+0xf/0x20
> [  958.518970]  [<ffffffff8133c62c>] __const_udelay+0x2c/0x30
> [  958.518973]  [<ffffffff8105eb6a>] arch_trigger_all_cpu_backtrace+0x6a/0x90
> [  958.518976]  [<ffffffff81100060>] __rcu_pending+0x380/0x3e0
> [  958.518979]  [<ffffffff8110024a>] rcu_check_callbacks+0x10a/0x160
> [  958.518982]  [<ffffffff810a387d>] update_process_times+0x4d/0x70
> [  958.518985]  [<ffffffff810c9cda>] tick_sched_timer+0x5a/0x150
> [  958.518988]  [<ffffffff810bc193>] __run_hrtimer+0x73/0x390
> [  958.518990]  [<ffffffff810c9c80>] ? tick_init_highres+0x20/0x20
> [  958.518992]  [<ffffffff810bd1bf>] hrtimer_interrupt+0xff/0x230
> [  958.518996]  [<ffffffff81821786>] smp_apic_timer_interrupt+0x66/0x98
> [  958.518998]  [<ffffffff81820a93>] apic_timer_interrupt+0x13/0x20
> [  958.518999]  <EOI> 
> [  958.519003]  [<ffffffff813a3e7d>] ? intel_idle+0xcd/0x120
> [  958.519006]  [<ffffffff813a3e76>] ? intel_idle+0xc6/0x120
> [  958.519009]  [<ffffffff815fdfcb>] cpuidle_idle_call+0xcb/0x500
> [  958.519013]  [<ffffffff8103f876>] cpu_idle+0x56/0x80
> [  958.519015]  [<ffffffff8180fd12>] start_secondary+0x21a/0x221
> [  958.519017] Code: 66 66 66 90 48 8d 04 bf 65 48 8b 14 25 d8 7c 03 00 48 c1 e0 02 48 69 d2 fa 00 00 00 f7 e2 48 8d 7a 01 ff 15 53 de b0 00 c9 c3 90 
> [  958.519028]  48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 08 66 66 66 66 
> [  958.519034] Call Trace:
> [  958.519035]  <IRQ>  [<ffffffff8133c5ef>] ? __delay+0xf/0x20
> [  958.519038]  [<ffffffff8133c62c>] __const_udelay+0x2c/0x30
> [  958.519041]  [<ffffffff8105eb6a>] arch_trigger_all_cpu_backtrace+0x6a/0x90
> [  958.519043]  [<ffffffff81100060>] __rcu_pending+0x380/0x3e0
> [  958.519045]  [<ffffffff8110024a>] rcu_check_callbacks+0x10a/0x160
> [  958.519048]  [<ffffffff810a387d>] update_process_times+0x4d/0x70
> [  958.519050]  [<ffffffff810c9cda>] tick_sched_timer+0x5a/0x150
> [  958.519052]  [<ffffffff810bc193>] __run_hrtimer+0x73/0x390
> [  958.519054]  [<ffffffff810c9c80>] ? tick_init_highres+0x20/0x20
> [  958.519057]  [<ffffffff810bd1bf>] hrtimer_interrupt+0xff/0x230
> [  958.519060]  [<ffffffff81821786>] smp_apic_timer_interrupt+0x66/0x98
> [  958.519062]  [<ffffffff81820a93>] apic_timer_interrupt+0x13/0x20
> [  958.519063]  <EOI>  [<ffffffff813a3e7d>] ? intel_idle+0xcd/0x120
> [  958.519067]  [<ffffffff813a3e76>] ? intel_idle+0xc6/0x120
> [  958.519070]  [<ffffffff815fdfcb>] cpuidle_idle_call+0xcb/0x500
> [  958.519072]  [<ffffffff8103f876>] cpu_idle+0x56/0x80
> [  958.519074]  [<ffffffff8180fd12>] start_secondary+0x21a/0x221
> [  958.519077] NMI backtrace for cpu 2
> [  958.519079] CPU 2 
> [  958.519079] Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler cpufreq_conservative cdc_ether usbnet mii bnx2 shpchp i7core_edac edac_core ext4 jbd2 megaraid_sas
> [  958.519086] 
> [  958.519087] Pid: 23, comm: ksoftirqd/2 Not tainted 3.0.1-rt8 #6 IBM System x3550 M3 -[7944K3G]-/69Y5698     
> [  958.519090] RIP: 0010:[<ffffffff8107efa0>]  [<ffffffff8107efa0>] task_rq_lock+0x10/0xb0
> [  958.519096] RSP: 0018:ffff88017a94fd50  EFLAGS: 00000086
> [  958.519097] RAX: 0000000000000001 RBX: ffff88017a94c600 RCX: 0000000000000000
> [  958.519099] RDX: 0000000000006c6b RSI: ffff88017a94fd98 RDI: ffff88017a94c600
> [  958.519100] RBP: ffff88017a94fd80 R08: 0000000000000001 R09: 0000000000000000
> [  958.519101] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000ab80
> [  958.519103] R13: ffff88017a94c600 R14: ffff88017a94fdf0 R15: ffff88017a94e000
> [  958.519105] FS:  0000000000000000(0000) GS:ffff88017fc80000(0000) knlGS:0000000000000000
> [  958.519106] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  958.519108] CR2: 00007f4e2ab33000 CR3: 000000017789f000 CR4: 00000000000006e0
> [  958.519109] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  958.519111] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  958.519112] Process ksoftirqd/2 (pid: 23, threadinfo ffff88017a94e000, task ffff88017a94c600)
> [  958.519113] Stack:
> [  958.519114]  ffff88017a94fd70 ffff88017a94c600 000000000000ab80 ffffffff8181c1ad
> [  958.519117]  ffff88017a94fd90 ffff88017a94c600 ffff88017a94fdb0 ffffffff81087fe4
> [  958.519119]  ffff88017a94fdb0 ffffffff818180be ffff88017fc8ab80 000000000000ab80
> [  958.519121] Call Trace:
> [  958.519124]  [<ffffffff8181c1ad>] ? add_preempt_count+0x9d/0xd0
> [  958.519127]  [<ffffffff81087fe4>] migrate_enable+0x94/0x180
> [  958.519130]  [<ffffffff818180be>] ? rt_spin_unlock+0x2e/0x40
> [  958.519132]  [<ffffffff81098b93>] __thread_do_softirq+0x123/0x200
> [  958.519134]  [<ffffffff81098d6a>] run_ksoftirqd+0xfa/0x210
> [  958.519136]  [<ffffffff81098c70>] ? __thread_do_softirq+0x200/0x200
> [  958.519138]  [<ffffffff81098c70>] ? __thread_do_softirq+0x200/0x200
> [  958.519141]  [<ffffffff810b7556>] kthread+0xa6/0xb0
> [  958.519144]  [<ffffffff81818a8b>] ? _raw_spin_unlock_irq+0x3b/0x60
> [  958.519147]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [  958.519150]  [<ffffffff81820ed4>] kernel_thread_helper+0x4/0x10
> [  958.519152]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [  958.519155]  [<ffffffff81818f44>] ? retint_restore_args+0xe/0xe
> [  958.519157]  [<ffffffff810b74b0>] ? __init_kthread_worker+0xa0/0xa0
> [  958.519159]  [<ffffffff81820ed0>] ? gs_change+0xb/0xb
> [  958.519161] Code: 1a c2 81 e8 63 17 01 00 c6 05 04 ce fa 00 01 eb 9b 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 48 83 ec 30 48 89 5d d8 4c 89 65 e0 <4c> 89 6d e8 4c 89 75 f0 4c 89 7d f8 66 66 66 66 90 48 c7 c3 40 
> [  958.519176] Call Trace:
> [  958.519178]  [<ffffffff8181c1ad>] ? add_preempt_count+0x9d/0xd0
> [  958.519180]  [<ffffffff81087fe4>] migrate_enable+0x94/0x180
> [  958.519182]  [<ffffffff818180be>] ? rt_spin_unlock+0x2e/0x40
> [  958.519184]  [<ffffffff81098b93>] __thread_do_softirq+0x123/0x200
> [  958.519186]  [<ffffffff81098d6a>] run_ksoftirqd+0xfa/0x210
> [  958.519188]  [<ffffffff81098c70>] ? __thread_do_softirq+0x200/0x200
> [  958.519190]  [<ffffffff81098c70>] ? __thread_do_softirq+0x200/0x200
> [  958.519192]  [<ffffffff810b7556>] kthread+0xa6/0xb0
> [  958.519195]  [<ffffffff81818a8b>] ? _raw_spin_unlock_irq+0x3b/0x60
> [  958.519198]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [  958.519200]  [<ffffffff81820ed4>] kernel_thread_helper+0x4/0x10
> [  958.519203]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [  958.519205]  [<ffffffff81818f44>] ? retint_restore_args+0xe/0xe
> [  958.519207]  [<ffffffff810b74b0>] ? __init_kthread_worker+0xa0/0xa0
> [  958.519210]  [<ffffffff81820ed0>] ? gs_change+0xb/0xb
> [  958.519212] NMI backtrace for cpu 0
> [  958.519213] CPU 0 
> [  958.519214] Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler cpufreq_conservative cdc_ether usbnet mii bnx2 shpchp i7core_edac edac_core ext4 jbd2 megaraid_sas
> [  958.519220] 
> [  958.519222] Pid: 3, comm: ksoftirqd/0 Not tainted 3.0.1-rt8 #6 IBM System x3550 M3 -[7944K3G]-/69Y5698     
> [  958.519225] RIP: 0010:[<ffffffff8181c115>]  [<ffffffff8181c115>] add_preempt_count+0x5/0xd0
> [  958.519228] RSP: 0018:ffff88017a801d08  EFLAGS: 00000082
> [  958.519230] RAX: 0000000000000000 RBX: ffff88017fc37d40 RCX: 0000000000000000
> [  958.519231] RDX: 000000000000ae01 RSI: ffff88017aefe720 RDI: 0000000000000001
> [  958.519233] RBP: ffff88017a801d10 R08: 0000000000000000 R09: 0000000000000000
> [  958.519234] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88017aefe0c0
> [  958.519236] R13: ffff88017aefe660 R14: ffff88017a801d98 R15: ffff88017fc37d40
> [  958.519237] FS:  0000000000000000(0000) GS:ffff88017fc00000(0000) knlGS:0000000000000000
> [  958.519239] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  958.519240] CR2: 00007f4e2ab33000 CR3: 0000000174886000 CR4: 00000000000006f0
> [  958.519242] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  958.519243] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  958.519245] Process ksoftirqd/0 (pid: 3, threadinfo ffff88017a800000, task ffff88017aefe0c0)
> [  958.519246] Stack:
> [  958.519247]  ffff88017fc37d40 ffff88017a801d40 ffffffff8181882b ffffffff8107efd0
> [  958.519249]  0000000000000001 0000000000037d40 0000000000037d40 ffff88017a801d80
> [  958.519252]  ffffffff8107efeb ffff88017a801d70 ffff88017aefe0c0 000000000000ab80
> [  958.519254] Call Trace:
> [  958.519257]  [<ffffffff8181882b>] _raw_spin_lock+0x1b/0x50
> [  958.519260]  [<ffffffff8107efd0>] ? task_rq_lock+0x40/0xb0
> [  958.519263]  [<ffffffff8107efeb>] task_rq_lock+0x5b/0xb0
> [  958.519265]  [<ffffffff81087fe4>] migrate_enable+0x94/0x180
> [  958.519267]  [<ffffffff81098b93>] __thread_do_softirq+0x123/0x200
> [  958.519269]  [<ffffffff81098d6a>] run_ksoftirqd+0xfa/0x210
> [  958.519272]  [<ffffffff81098c70>] ? __thread_do_softirq+0x200/0x200
> [  958.519274]  [<ffffffff81098c70>] ? __thread_do_softirq+0x200/0x200
> [  958.519276]  [<ffffffff810b7556>] kthread+0xa6/0xb0
> [  958.519279]  [<ffffffff81818a8b>] ? _raw_spin_unlock_irq+0x3b/0x60
> [  958.519282]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [  958.519284]  [<ffffffff81820ed4>] kernel_thread_helper+0x4/0x10
> [  958.519287]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [  958.519289]  [<ffffffff81818f44>] ? retint_restore_args+0xe/0xe
> [  958.519292]  [<ffffffff810b74b0>] ? __init_kthread_worker+0xa0/0xa0
> [  958.519294]  [<ffffffff81820ed0>] ? gs_change+0xb/0xb
> [  958.519295] Code: d1 78 0b 01 00 75 8b be 43 10 00 00 48 c7 c7 92 1a c2 81 e8 de 45 87 ff e9 75 ff ff ff 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 53 
> [  958.519306]  83 ec 08 66 66 66 66 90 8b 05 00 02 81 00 89 fb 85 c0 75 4e 
> [  958.519311] Call Trace:
> [  958.519313]  [<ffffffff8181882b>] _raw_spin_lock+0x1b/0x50
> [  958.519315]  [<ffffffff8107efd0>] ? task_rq_lock+0x40/0xb0
> [  958.519318]  [<ffffffff8107efeb>] task_rq_lock+0x5b/0xb0
> [  958.519320]  [<ffffffff81087fe4>] migrate_enable+0x94/0x180
> [  958.519322]  [<ffffffff81098b93>] __thread_do_softirq+0x123/0x200
> [  958.519324]  [<ffffffff81098d6a>] run_ksoftirqd+0xfa/0x210
> [  958.519326]  [<ffffffff81098c70>] ? __thread_do_softirq+0x200/0x200
> [  958.519328]  [<ffffffff81098c70>] ? __thread_do_softirq+0x200/0x200
> [  958.519330]  [<ffffffff810b7556>] kthread+0xa6/0xb0
> [  958.519333]  [<ffffffff81818a8b>] ? _raw_spin_unlock_irq+0x3b/0x60
> [  958.519335]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [  958.519338]  [<ffffffff81820ed4>] kernel_thread_helper+0x4/0x10
> [  958.519340]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [  958.519343]  [<ffffffff81818f44>] ? retint_restore_args+0xe/0xe
> [  958.519345]  [<ffffffff810b74b0>] ? __init_kthread_worker+0xa0/0xa0
> [  958.519347]  [<ffffffff81820ed0>] ? gs_change+0xb/0xb
> [ 1080.183365] INFO: task rcub0:10 blocked for more than 120 seconds.
> [ 1080.183366] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1080.183368] rcub0           D 0000000000000000     0    10      2 0x00000000
> [ 1080.183372]  ffff88017a841b90 0000000000000046 ffffffff81815939 0000000000000000
> [ 1080.183374]  ffff880100000000 ffff88017a841fd8 ffff88017a841fd8 ffff88017a841fd8
> [ 1080.183377]  ffff88017a840000 ffff88017a840000 0000000000004000 ffff88017a841fd8
> [ 1080.183379] Call Trace:
> [ 1080.183386]  [<ffffffff81815939>] ? __schedule+0x879/0xab0
> [ 1080.183391]  [<ffffffff810d80b0>] ? debug_rt_mutex_print_deadlock+0x50/0x200
> [ 1080.183394]  [<ffffffff810d8230>] ? debug_rt_mutex_print_deadlock+0x1d0/0x200
> [ 1080.183397]  [<ffffffff81087e8e>] schedule+0x2e/0xa0
> [ 1080.183400]  [<ffffffff818173b3>] __rt_mutex_slowlock+0x53/0xd0
> [ 1080.183402]  [<ffffffff818175a3>] rt_mutex_slowlock+0xd3/0x1c0
> [ 1080.183405]  [<ffffffff81817765>] rt_mutex_lock+0x35/0x40
> [ 1080.183408]  [<ffffffff810fdb09>] rcu_boost+0x99/0x120
> [ 1080.183412]  [<ffffffff81818b15>] ? _raw_spin_unlock_irqrestore+0x65/0x80
> [ 1080.183414]  [<ffffffff810fdc45>] rcu_boost_kthread+0xb5/0xe0
> [ 1080.183416]  [<ffffffff810fdb90>] ? rcu_boost+0x120/0x120
> [ 1080.183418]  [<ffffffff810fdb90>] ? rcu_boost+0x120/0x120
> [ 1080.183422]  [<ffffffff810b7556>] kthread+0xa6/0xb0
> [ 1080.183424]  [<ffffffff81818a8b>] ? _raw_spin_unlock_irq+0x3b/0x60
> [ 1080.183429]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [ 1080.183432]  [<ffffffff81820ed4>] kernel_thread_helper+0x4/0x10
> [ 1080.183435]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [ 1080.183437]  [<ffffffff81818f44>] ? retint_restore_args+0xe/0xe
> [ 1080.183440]  [<ffffffff810b74b0>] ? __init_kthread_worker+0xa0/0xa0
> [ 1080.183442]  [<ffffffff81820ed0>] ? gs_change+0xb/0xb
> [ 1080.183444] no locks held by rcub0/10.
> [ 1080.183445] Kernel panic - not syncing: hung_task: blocked tasks
> [ 1080.183447] Pid: 702, comm: khungtaskd Not tainted 3.0.1-rt8 #6
> [ 1080.183448] Call Trace:
> [ 1080.183450]  [<ffffffff81814e60>] panic+0x9b/0x1a8
> [ 1080.183455]  [<ffffffff810f77b6>] watchdog+0x2b6/0x330
> [ 1080.183457]  [<ffffffff810f7578>] ? watchdog+0x78/0x330
> [ 1080.183459]  [<ffffffff810f7500>] ? hung_task_panic+0x20/0x20
> [ 1080.183461]  [<ffffffff810f7500>] ? hung_task_panic+0x20/0x20
> [ 1080.183463]  [<ffffffff810b7556>] kthread+0xa6/0xb0
> [ 1080.183466]  [<ffffffff81818a8b>] ? _raw_spin_unlock_irq+0x3b/0x60
> [ 1080.183468]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [ 1080.183471]  [<ffffffff81820ed4>] kernel_thread_helper+0x4/0x10
> [ 1080.183473]  [<ffffffff810825e5>] ? finish_task_switch+0x85/0x130
> [ 1080.183475]  [<ffffffff81818f44>] ? retint_restore_args+0xe/0xe
> [ 1080.183478]  [<ffffffff810b74b0>] ? __init_kthread_worker+0xa0/0xa0
> [ 1080.183480]  [<ffffffff81820ed0>] ? gs_change+0xb/0xb
> 
> 
