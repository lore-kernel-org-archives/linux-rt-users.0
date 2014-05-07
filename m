From: Joakim Hernberg <jbh@alchemy.lu> (by way of Joakim Hernberg
	<jbh@alchemy.lu>)
Subject: Re: [ANNOUNCE] 3.14.2-rt3
Date: Wed, 7 May 2014 18:27:28 +0200
Message-ID: <20140507182728.60645288@tor.valhalla.alchemy.lu>
References: <20140503170110.GA10652@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/tvnEA_7o3HFqFzZWvX=XW++"
Cc: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:61384 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbaEGUXp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 May 2014 16:23:45 -0400
Received: from skinbark.wpsintrax.se (unknown [83.145.49.220])
	by mailsafe.webbplatsen.se (Halon Mail Gateway) with ESMTP
	for <linux-rt-users@vger.kernel.org>; Wed,  7 May 2014 22:23:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by skinbark.wpsintrax.se (Postfix) with ESMTP id 7B6A777C103
	for <linux-rt-users@vger.kernel.org>; Wed,  7 May 2014 22:23:37 +0200 (CEST)
Received: from skinbark.wpsintrax.se ([127.0.0.1])
	by localhost (skinbark.wpsintrax.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nJK7bwadZmNt for <linux-rt-users@vger.kernel.org>;
	Wed,  7 May 2014 22:23:37 +0200 (CEST)
Received: from tor.valhalla.alchemy.lu (vodsl-10810.vo.lu [85.93.208.58])
	by skinbark.wpsintrax.se (Postfix) with ESMTPA id 8A46B77C102
	for <linux-rt-users@vger.kernel.org>; Wed,  7 May 2014 22:23:36 +0200 (CEST)
In-Reply-To: <20140503170110.GA10652@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--MP_/tvnEA_7o3HFqFzZWvX=XW++
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 3 May 2014 19:01:11 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I'm pleased to announce the v3.14.2-rt3 patch set.

Hello,

My machine had a hicup :)  Don't know if the sr0 stuff belongs to it,
but this is what I found in the buffer afterwards.

Kernel config attached:

[89649.850386] sr 4:0:0:0: [sr0] Device not ready
[89649.850394] sr 4:0:0:0: [sr0]  
[89649.850397] Result: hostbyte=0x00 driverbyte=0x08
[89649.850401] sr 4:0:0:0: [sr0]  
[89649.850404] Sense Key : 0x2 [current] 
[89649.850410] sr 4:0:0:0: [sr0]  
[89649.850412] ASC=0x3a ASCQ=0x1
[89649.850416] sr 4:0:0:0: [sr0] CDB: 
[89649.850418] cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
[89649.850432] end_request: I/O error, dev sr0, sector 0
[89649.850438] Buffer I/O error on device sr0, logical block 0
[89649.850442] Buffer I/O error on device sr0, logical block 1
[89649.850446] Buffer I/O error on device sr0, logical block 2
[89649.850449] Buffer I/O error on device sr0, logical block 3
[89649.850453] Buffer I/O error on device sr0, logical block 4
[89649.850456] Buffer I/O error on device sr0, logical block 5
[89649.850460] Buffer I/O error on device sr0, logical block 6
[89649.850464] Buffer I/O error on device sr0, logical block 7
[89649.850482] Buffer I/O error on device sr0, logical block 8
[89649.850486] Buffer I/O error on device sr0, logical block 9
[89649.850505] sr 4:0:0:0: [sr0] unaligned transfer
[89649.850534] sr 4:0:0:0: [sr0] unaligned transfer
[89649.850557] sr 4:0:0:0: [sr0] unaligned transfer
[89649.850570] sr 4:0:0:0: [sr0] unaligned transfer
[89649.850583] sr 4:0:0:0: [sr0] unaligned transfer
[89649.850602] sr 4:0:0:0: [sr0] unaligned transfer
[89649.850611] sr 4:0:0:0: [sr0] unaligned transfer
[89649.850618] sr 4:0:0:0: [sr0] unaligned transfer
[89649.895322] sr 4:0:0:0: [sr0] Device not ready
[89649.895329] sr 4:0:0:0: [sr0]  
[89649.895654] Result: hostbyte=0x00 driverbyte=0x08
[89649.895659] sr 4:0:0:0: [sr0]  
[89649.895662] Sense Key : 0x2 [current] 
[89649.895667] sr 4:0:0:0: [sr0]  
[89649.895670] ASC=0x3a ASCQ=0x1
[89649.895675] sr 4:0:0:0: [sr0] CDB: 
[89649.895678] cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
[89649.895688] end_request: I/O error, dev sr0, sector 0
[89649.895735] sr 4:0:0:0: [sr0] unaligned transfer
[89649.895779] sr 4:0:0:0: [sr0] unaligned transfer
[89649.895806] sr 4:0:0:0: [sr0] unaligned transfer
[89649.895832] sr 4:0:0:0: [sr0] unaligned transfer
[89649.895865] sr 4:0:0:0: [sr0] unaligned transfer
[89649.895886] sr 4:0:0:0: [sr0] unaligned transfer
[89649.895901] sr 4:0:0:0: [sr0] unaligned transfer
[89649.895916] sr 4:0:0:0: [sr0] unaligned transfer
[89724.648852] INFO: rcu_preempt self-detected stall on CPU { 1}  (t=60000 jiffies g=12214731 c=12214730 q=0)
[89724.648853] sending NMI to all CPUs:
[89724.648856] NMI backtrace for cpu 2
[89724.648859] CPU: 2 PID: 50 Comm: ksoftirqd/2 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89724.648859] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89724.648861] task: ffff8803fd470000 ti: ffff8803fd478000 task.ti: ffff8803fd478000
[89724.648865] RIP: 0010:[<ffffffff810aaf05>]  [<ffffffff810aaf05>] update_blocked_averages+0x95/0x6a0
[89724.648866] RSP: 0018:ffff8803fd479cd0  EFLAGS: 00000006
[89724.648867] RAX: 0000000000000002 RBX: ffff8803fb7cca00 RCX: ffff88040f405000
[89724.648868] RDX: ffffffff81c8d240 RSI: ffff88040f9659c0 RDI: ffff8803fb7cca00
[89724.648868] RBP: ffff8803fd479d30 R08: 0000000000000002 R09: ffff8803fd55cc00
[89724.648869] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8803fb7cfe00
[89724.648870] R13: 000000000000b40e R14: ffff88040f965940 R15: ffff88040f9659c0
[89724.648871] FS:  0000000000000000(0000) GS:ffff88040f900000(0000) knlGS:0000000000000000
[89724.648871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89724.648872] CR2: 00007f50cc3ad000 CR3: 000000038f630000 CR4: 00000000000407e0
[89724.648873] Stack:
[89724.648875]  0000000000000306 0000000000001fde ffff88040f9659c0 0000000000000246
[89724.648876]  ffff88040f9661d0 ffff88040f965a80 00000000904bfafe 0000000000000002
[89724.648878]  0000000105556270 0000000000000007 ffff88040f965940 000000000420a140
[89724.648878] Call Trace:
[89724.648882]  [<ffffffff810b25dc>] rebalance_domains+0x4c/0x2c0
[89724.648884]  [<ffffffff810b288f>] run_rebalance_domains+0x3f/0x190
[89724.648886]  [<ffffffff810a7f5e>] ? __vtime_account_system+0x2e/0x40
[89724.648889]  [<ffffffff81070926>] do_current_softirqs+0x1f6/0x3f0
[89724.648891]  [<ffffffff81070d8d>] run_ksoftirqd+0x2d/0x50
[89724.648893]  [<ffffffff8109971d>] smpboot_thread_fn+0x15d/0x2a0
[89724.648896]  [<ffffffff815157ba>] ? schedule+0x2a/0x90
[89724.648898]  [<ffffffff810995c0>] ? SyS_setgroups+0x150/0x150
[89724.648900]  [<ffffffff8109168c>] kthread+0xdc/0x100
[89724.648901]  [<ffffffff810915b0>] ? flush_kthread_worker+0xe0/0xe0
[89724.648904]  [<ffffffff81520cbc>] ret_from_fork+0x7c/0xb0
[89724.648906]  [<ffffffff810915b0>] ? flush_kthread_worker+0xe0/0xe0
[89724.648918] Code: c7 4c 8d b8 40 ff ff ff 0f 84 f8 01 00 00 0f 1f 84 00 00 00 00 00 49 8b 97 d0 00 00 00 49 63 86 38 09 00 00 48 8b 8a 80 00 00 00 <48> 8b 92 88 00 00 00 48 8b 1c c1 4c 8b 24 c2 66 66 66 66 90 be 
[89724.648919] NMI backtrace for cpu 5
[89724.648921] CPU: 5 PID: 71 Comm: ksoftirqd/5 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89724.648921] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89724.648922] task: ffff8803fd5899f0 ti: ffff8803fd592000 task.ti: ffff8803fd592000
[89724.648925] RIP: 0010:[<ffffffff81070da8>]  [<ffffffff81070da8>] run_ksoftirqd+0x48/0x50
[89724.648926] RSP: 0000:ffff8803fd593e68  EFLAGS: 00000296
[89724.648927] RAX: ffff8803fd5899f0 RBX: 0000000000000005 RCX: ffffffff81a503c0
[89724.648928] RDX: 000000000000ed00 RSI: 0000000000000000 RDI: 0000000000000046
[89724.648928] RBP: ffff8803fd593e70 R08: 0000000000000000 R09: ffff88040fae5940
[89724.648929] R10: 0000000000000807 R11: 0000000000000020 R12: ffff88040f401960
[89724.648930] R13: ffffffff81a3d700 R14: ffff8803fd5899f0 R15: ffff8803fd5899f0
[89724.648931] FS:  0000000000000000(0000) GS:ffff88040fa80000(0000) knlGS:0000000000000000
[89724.648931] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89724.648932] CR2: 00007f1652eb4000 CR3: 00000003fc072000 CR4: 00000000000407e0
[89724.648933] Stack:
[89724.648934]  ffff8803fd5899f0 ffff8803fd593ec0 ffffffff8109971d 0000000000000000
[89724.648936]  ffffffff815157ba 0000000000000001 ffff8803fdb553c0 ffff88040f401960
[89724.648937]  ffffffff810995c0 0000000000000000 0000000000000000 ffff8803fd593f48
[89724.648938] Call Trace:
[89724.648940]  [<ffffffff8109971d>] smpboot_thread_fn+0x15d/0x2a0
[89724.648942]  [<ffffffff815157ba>] ? schedule+0x2a/0x90
[89724.648944]  [<ffffffff810995c0>] ? SyS_setgroups+0x150/0x150
[89724.648945]  [<ffffffff8109168c>] kthread+0xdc/0x100
[89724.648947]  [<ffffffff810915b0>] ? flush_kthread_worker+0xe0/0xe0
[89724.648949]  [<ffffffff81520cbc>] ret_from_fork+0x7c/0xb0
[89724.648950]  [<ffffffff810915b0>] ? flush_kthread_worker+0xe0/0xe0
[89724.648963] Code: 80 e8 19 00 00 01 bf 01 00 00 00 e8 a3 f9 ff ff 65 48 8b 04 25 40 c8 00 00 83 a8 e8 19 00 00 01 89 df e8 4c 78 06 00 fb 66 66 90 <66> 66 90 5b 5d c3 66 90 66 66 66 66 90 55 48 89 e5 41 57 41 56 
[89724.648964] NMI backtrace for cpu 7
[89724.648966] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89724.648966] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89724.648968] task: ffff8803fdb799f0 ti: ffff8803fdb80000 task.ti: ffff8803fdb80000
[89724.648971] RIP: 0010:[<ffffffff81314de9>]  [<ffffffff81314de9>] intel_idle+0xe9/0x180
[89724.648972] RSP: 0018:ffff8803fdb81e28  EFLAGS: 00000046
[89724.648973] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[89724.648973] RDX: 0000000000000000 RSI: ffff8803fdb81fd8 RDI: 0000000000000007
[89724.648974] RBP: ffff8803fdb81e58 R08: 0000000000593616 R09: 0000000034d860f9
[89724.648975] R10: 000116aba098c9bd R11: 0000000000000293 R12: 0000000000000001
[89724.648975] R13: 0000000000000001 R14: 0000000000000002 R15: ffff8803fdb81fd8
[89724.648976] FS:  0000000000000000(0000) GS:ffff88040fb80000(0000) knlGS:0000000000000000
[89724.648977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89724.648978] CR2: 00000000ed60a000 CR3: 000000038f630000 CR4: 00000000000407e0
[89724.648978] Stack:
[89724.648980]  00000007fdb81e58 32a7a8fb32a7a8da ffff88040fbecd00 ffffffff81a8ba40
[89724.648982]  000051a7f69eebbd 0000000000000002 ffff8803fdb81e88 ffffffff813e03ca
[89724.648983]  0000000000000002 ffff88040fbecd00 0000000000000000 ffffffff81a8ba40
[89724.648983] Call Trace:
[89724.648987]  [<ffffffff813e03ca>] cpuidle_enter_state+0x3a/0xc0
[89724.648989]  [<ffffffff813e0507>] cpuidle_idle_call+0xb7/0x250
[89724.648991]  [<ffffffff8102142e>] arch_cpu_idle+0xe/0x30
[89724.648994]  [<ffffffff810cdf79>] cpu_startup_entry+0x259/0x2e0
[89724.648997]  [<ffffffff81047572>] start_secondary+0x212/0x2d0
[89724.649010] Code: 00 00 48 89 d1 48 8d 86 38 e0 ff ff 0f 01 c8 65 48 8b 04 25 30 c8 00 00 48 8b 80 38 e0 ff ff a8 08 75 08 b1 01 4c 89 e0 0f 01 c9 <65> 48 8b 04 25 30 c8 00 00 83 a0 3c e0 ff ff fb 0f ae f0 65 48 
[89724.649011] NMI backtrace for cpu 6
[89724.649012] CPU: 6 PID: 1015 Comm: ksysguard Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89724.649012] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89724.649013] task: ffff8803d3728000 ti: ffff8803d3726000 task.ti: ffff8803d3726000
[89724.649029] RIP: 0033:[<00007f50caf4d74e>]  [<00007f50caf4d74e>] 0x7f50caf4d74e
[89724.649029] RSP: 002b:00007ffff8927c10  EFLAGS: 00000202
[89724.649030] RAX: 0000000000000000 RBX: 00000000025f88c0 RCX: 0000000000000002
[89724.649030] RDX: 0000000000000000 RSI: 00000000028a3638 RDI: 00000000025f88c0
[89724.649031] RBP: 0000000002607fb0 R08: 0000000000000002 R09: 0000000000000052
[89724.649031] R10: 00000000000002a7 R11: 000000000263fde0 R12: 0000000000000000
[89724.649031] R13: 000000000263c390 R14: 0000000000000008 R15: 0000000002503080
[89724.649032] FS:  00007f50cc393780(0000) GS:ffff88040fb00000(0000) knlGS:0000000000000000
[89724.649033] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89724.649033] CR2: 00000000ed60a000 CR3: 00000003d365f000 CR4: 00000000000407e0
 
[89724.649034] NMI backtrace for cpu 3
[89724.649035] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89724.649035] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89724.649036] task: ffff8803fdb699f0 ti: ffff8803fdb70000 task.ti: ffff8803fdb70000
[89724.649038] RIP: 0010:[<ffffffff81314de9>]  [<ffffffff81314de9>] intel_idle+0xe9/0x180
[89724.649038] RSP: 0018:ffff8803fdb71e28  EFLAGS: 00000046
[89724.649039] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000001
[89724.649039] RDX: 0000000000000000 RSI: ffff8803fdb71fd8 RDI: 0000000000000003
[89724.649040] RBP: ffff8803fdb71e58 R08: 0000000000258b7a R09: 0000000034d860f9
[89724.649041] R10: 000116aba0ccd674 R11: 0000000000000000 R12: 0000000000000000
[89724.649041] R13: 0000000000000001 R14: 0000000000000001 R15: ffff8803fdb71fd8
[89724.649042] FS:  0000000000000000(0000) GS:ffff88040f980000(0000) knlGS:0000000000000000
[89724.649043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89724.649044] CR2: 00007fa8ea61d000 CR3: 000000026b955000 CR4: 00000000000407e0
[89724.649044] Stack:
[89724.649046]  00000003fdb71e58 24a3ff0124a3fee0 ffff88040f9ecd00 ffffffff81a8ba40
[89724.649047]  000051a7f69f087f 0000000000000001 ffff8803fdb71e88 ffffffff813e03ca
[89724.649047]  0000000000000001 ffff88040f9ecd00 0000000000000000 ffffffff81a8ba40
[89724.649048] Call Trace:
[89724.649049]  [<ffffffff813e03ca>] cpuidle_enter_state+0x3a/0xc0
[89724.649050]  [<ffffffff813e0507>] cpuidle_idle_call+0xb7/0x250
[89724.649051]  [<ffffffff8102142e>] arch_cpu_idle+0xe/0x30
[89724.649053]  [<ffffffff810cdf79>] cpu_startup_entry+0x259/0x2e0
[89724.649054]  [<ffffffff81047572>] start_secondary+0x212/0x2d0
[89724.649061] Code: 00 00 48 89 d1 48 8d 86 38 e0 ff ff 0f 01 c8 65 48 8b 04 25 30 c8 00 00 48 8b 80 38 e0 ff ff a8 08 75 08 b1 01 4c 89 e0 0f 01 c9 <65> 48 8b 04 25 30 c8 00 00 83 a0 3c e0 ff ff fb 0f ae f0 65 48 
[89724.649062] NMI backtrace for cpu 1
[89724.649063] CPU: 1 PID: 28438 Comm: Ableton Live 9  Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89724.649064] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89724.649065] task: ffff880116290000 ti: ffff88026033e000 task.ti: ffff88026033e000
[89724.649069] RIP: 0010:[<ffffffff812aa610>]  [<ffffffff812aa610>] __const_udelay+0x0/0x30
[89724.649070] RSP: 0000:ffff88040f883da8  EFLAGS: 00200046
[89724.649071] RAX: 0000000000000000 RBX: 0000000000002710 RCX: 0000000000000002
[89724.649071] RDX: 0000000000000c00 RSI: 0000000000000080 RDI: 0000000000418958
[89724.649072] RBP: ffff88040f883db8 R08: 0000000000000002 R09: 0000000000000028
[89724.649073] R10: 0000000000000003 R11: 000000000001de30 R12: ffffffff81a51440
[89724.649073] R13: ffffffff81ad07f0 R14: ffffffff81a51440 R15: 0000000000000001
[89724.649075] FS:  0000000080b60000(0063) GS:ffff88040f880000(006b) knlGS:000000000b03fb40
[89724.649075] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[89724.649076] CR2: 00007f50ae7ee000 CR3: 000000032517e000 CR4: 00000000000407e0
[89724.649077] Stack:
[89724.649078]  ffffffff8104b315 ffff88040f88ed00 ffff88040f883e10 ffffffff810d9f4e
[89724.649080]  0000000000000001 ffff88040f883de0 ffffffff8107118e 0000000000000000
[89724.649081]  ffff880116290000 0000000000000001 0000000000000001 ffff88040f88e7c0
[89724.649082] Call Trace:
[89724.649083]  <IRQ> 
[89724.649085]  [<ffffffff8104b315>] ? arch_trigger_all_cpu_backtrace+0x75/0x90
[89724.649088]  [<ffffffff810d9f4e>] rcu_check_callbacks+0x50e/0x790
[89724.649090]  [<ffffffff8107118e>] ? raise_softirq_irqoff+0xe/0x40
[89724.649092]  [<ffffffff8107b042>] update_process_times+0x42/0x70
[89724.649095]  [<ffffffff810e5bb5>] tick_sched_handle.isra.16+0x25/0x60
[89724.649097]  [<ffffffff810e5c34>] tick_sched_timer+0x44/0x70
[89724.649099]  [<ffffffff81094a91>] __run_hrtimer+0x81/0x270
[89724.649100]  [<ffffffff810e5bf0>] ? tick_sched_handle.isra.16+0x60/0x60
[89724.649102]  [<ffffffff81095f3c>] hrtimer_interrupt+0x38c/0x3f0
[89724.649105]  [<ffffffff810495aa>] local_apic_timer_interrupt+0x3a/0x60
[89724.649107]  [<ffffffff81522daf>] smp_apic_timer_interrupt+0x3f/0x50
[89724.649109]  [<ffffffff815218dd>] apic_timer_interrupt+0x6d/0x80
[89724.649110]  <EOI> 
[89724.649123] Code: 48 ff c8 5d c3 66 0f 1f 44 00 00 66 66 66 66 90 55 48 89 e5 ff 15 69 da 7d 00 5d c3 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 <55> 48 8d 04 bd 00 00 00 00 65 48 8b 14 25 60 50 06 00 48 69 d2 
[89724.649123] NMI backtrace for cpu 4
[89724.649125] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89724.649126] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89724.649127] task: ffff8803fdb6b3e0 ti: ffff8803fdb72000 task.ti: ffff8803fdb72000
[89724.649129] RIP: 0010:[<ffffffff81314de9>]  [<ffffffff81314de9>] intel_idle+0xe9/0x180
[89724.649130] RSP: 0018:ffff8803fdb73e28  EFLAGS: 00000046
[89724.649131] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[89724.649131] RDX: 0000000000000000 RSI: ffff8803fdb73fd8 RDI: 0000000000000004
[89724.649132] RBP: ffff8803fdb73e58 R08: 0000000000580210 R09: 0000000034d860f9
[89724.649133] R10: 000116aba098c9bd R11: 0000000000000293 R12: 0000000000000001
[89724.649133] R13: 0000000000000001 R14: 0000000000000002 R15: ffff8803fdb73fd8
[89724.649134] FS:  0000000000000000(0000) GS:ffff88040fa00000(0000) knlGS:0000000000000000
[89724.649135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89724.649136] CR2: 00001c2f75b3c000 CR3: 000000038f630000 CR4: 00000000000407e0
[89724.649136] Stack:
[89724.649138]  00000004fdb73e58 2828648928286468 ffff88040fa6cd00 ffffffff81a8ba40
[89724.649140]  000051a7f69e9170 0000000000000002 ffff8803fdb73e88 ffffffff813e03ca
[89724.649141]  0000000000000002 ffff88040fa6cd00 0000000000000000 ffffffff81a8ba40
[89724.649141] Call Trace:
[89724.649144]  [<ffffffff813e03ca>] cpuidle_enter_state+0x3a/0xc0
[89724.649146]  [<ffffffff813e0507>] cpuidle_idle_call+0xb7/0x250
[89724.649148]  [<ffffffff8102142e>] arch_cpu_idle+0xe/0x30
[89724.649150]  [<ffffffff810cdf79>] cpu_startup_entry+0x259/0x2e0
[89724.649152]  [<ffffffff81047572>] start_secondary+0x212/0x2d0
[89724.649165] Code: 00 00 48 89 d1 48 8d 86 38 e0 ff ff 0f 01 c8 65 48 8b 04 25 30 c8 00 00 48 8b 80 38 e0 ff ff a8 08 75 08 b1 01 4c 89 e0 0f 01 c9 <65> 48 8b 04 25 30 c8 00 00 83 a0 3c e0 ff ff fb 0f ae f0 65 48 
[89724.649165] NMI backtrace for cpu 0
[89724.649167] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89724.649167] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89724.649168] task: ffffffff81a16500 ti: ffffffff81a00000 task.ti: ffffffff81a00000
[89724.649171] RIP: 0010:[<ffffffff81314de9>]  [<ffffffff81314de9>] intel_idle+0xe9/0x180
[89724.649171] RSP: 0018:ffffffff81a01e28  EFLAGS: 00000046
[89724.649172] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[89724.649173] RDX: 0000000000000000 RSI: ffffffff81a01fd8 RDI: 0000000000000000
[89724.649173] RBP: ffffffff81a01e58 R08: 0000000000256e34 R09: 0000000034d860f9
[89724.649174] R10: 000116aba0ccd674 R11: 0000000000000293 R12: 0000000000000001
[89724.649175] R13: 0000000000000001 R14: 0000000000000002 R15: ffffffff81a01fd8
[89724.649175] FS:  0000000000000000(0000) GS:ffff88040f800000(0000) knlGS:0000000000000000
[89724.649176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89724.649176] CR2: 00007f50cc3ad000 CR3: 000000038f630000 CR4: 00000000000407f0
[89724.649177] Stack:
[89724.649178]  0000000081a01e58 181d9c45181d9c24 ffff88040f86cd00 ffffffff81a8ba40
[89724.649179]  000051a7f69effeb 0000000000000002 ffffffff81a01e88 ffffffff813e03ca
[89724.649179]  0000000000000002 ffff88040f86cd00 0000000000000000 ffffffff81a8ba40
[89724.649180] Call Trace:
[89724.649181]  [<ffffffff813e03ca>] cpuidle_enter_state+0x3a/0xc0
[89724.649182]  [<ffffffff813e0507>] cpuidle_idle_call+0xb7/0x250
[89724.649184]  [<ffffffff8102142e>] arch_cpu_idle+0xe/0x30
[89724.649185]  [<ffffffff810cdf79>] cpu_startup_entry+0x259/0x2e0
[89724.649187]  [<ffffffff81508664>] rest_init+0x84/0x90
[89724.649189]  [<ffffffff81b41ea2>] start_kernel+0x444/0x465
[89724.649190]  [<ffffffff81b41120>] ? early_idt_handlers+0x120/0x120
[89724.649191]  [<ffffffff81b414d7>] x86_64_start_reservations+0x2a/0x2c
[89724.649192]  [<ffffffff81b41626>] x86_64_start_kernel+0x14d/0x170
[89724.649199] Code: 00 00 48 89 d1 48 8d 86 38 e0 ff ff 0f 01 c8 65 48 8b 04 25 30 c8 00 00 48 8b 80 38 e0 ff ff a8 08 75 08 b1 01 4c 89 e0 0f 01 c9 <65> 48 8b 04 25 30 c8 00 00 83 a0 3c e0 ff ff fb 0f ae f0 65 48 
[89904.537490] INFO: rcu_preempt self-detected stall on CPU { 1}  (t=240004 jiffies g=12214731 c=12214730 q=0)
[89904.537491] sending NMI to all CPUs:
[89904.537496] NMI backtrace for cpu 0
[89904.537499] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89904.537500] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89904.537502] task: ffffffff81a16500 ti: ffffffff81a00000 task.ti: ffffffff81a00000
[89904.537508] RIP: 0010:[<ffffffff810a7931>]  [<ffffffff810a7931>] sched_clock_idle_sleep_event+0x1/0x20
[89904.537509] RSP: 0018:ffffffff81a01e98  EFLAGS: 00000002
[89904.537510] RAX: 000051d1dfb228c7 RBX: ffff88040f80f5c0 RCX: 0000000000000018
[89904.537511] RDX: 000000006dda18c7 RSI: 0000000000015f68 RDI: 00000ae1befa96e0
[89904.537512] RBP: ffffffff81a01ec8 R08: 0000000000251e96 R09: 0000000034d860f9
[89904.537513] R10: 0001173a973d35e7 R11: 0000000000000293 R12: 0000000000000000
[89904.537514] R13: 000051d1dfb228c7 R14: ffffffff81bdd2c0 R15: ffffffff81a01fd8
[89904.537516] FS:  0000000000000000(0000) GS:ffff88040f800000(0000) knlGS:0000000000000000
[89904.537517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89904.537518] CR2: 00007f50cc3ad000 CR3: 000000038f630000 CR4: 00000000000407f0
[89904.537519] Stack:
[89904.537522]  ffffffff81a01ec8 ffffffff810e59fa 0000000000000002 ffffffff81ad07e0
[89904.537525]  ffffffff81a01fd8 ffffffff81bdd2c0 ffffffff81a01ed8 ffffffff810e5b50
[89904.537527]  ffffffff81a01f28 ffffffff810cddb5 ffffffff81a01fd8 ffffffff81a01fd8
[89904.537528] Call Trace:
[89904.537533]  [<ffffffff810e59fa>] ? __tick_nohz_idle_enter+0x3a/0x150
[89904.537536]  [<ffffffff810e5b50>] tick_nohz_idle_enter+0x40/0x80
[89904.537539]  [<ffffffff810cddb5>] cpu_startup_entry+0x95/0x2e0
[89904.537543]  [<ffffffff81508664>] rest_init+0x84/0x90
[89904.537547]  [<ffffffff81b41ea2>] start_kernel+0x444/0x465
[89904.537549]  [<ffffffff81b41120>] ? early_idt_handlers+0x120/0x120
[89904.537552]  [<ffffffff81b414d7>] x86_64_start_reservations+0x2a/0x2c
[89904.537554]  [<ffffffff81b41626>] x86_64_start_kernel+0x14d/0x170
[89904.537573] Code: 48 89 d0 41 5c 5d c3 0f 1f 00 e8 cb 7f f7 ff 5b 41 5c 5d c3 66 0f 1f 44 00 00 e8 fb 8f f7 ff 48 89 d0 eb eb 31 c0 eb e7 66 90 55 <65> 8b 3c 25 34 b0 00 00 48 89 e5 e8 1f ff ff ff 5d c3 66 66 66 
[89904.537575] NMI backtrace for cpu 2
[89904.537578] CPU: 2 PID: 1008 Comm: konsole Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89904.537579] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89904.537580] task: ffff8803f64d33e0 ti: ffff8803d34f6000 task.ti: ffff8803d34f6000
[89904.537600] RIP: 0033:[<00007f50ca3429be>]  [<00007f50ca3429be>] 0x7f50ca3429be
[89904.537601] RSP: 002b:00007ffff8926430  EFLAGS: 00000246
[89904.537602] RAX: 0000000000000004 RBX: 0000000000ff00ff RCX: 00000000ffc3c3c3
[89904.537603] RDX: 00000000000000ff RSI: 00007f50af21c0d4 RDI: 00000000ffffffff
[89904.537604] RBP: 0000000000000eac R08: 000000000287d448 R09: 0000000000ff0000
[89904.537605] R10: 00000000c23dc23d R11: 0000000000ff00ff R12: 0000000000000006
[89904.537606] R13: 0000000000000003 R14: 00000000000000ff R15: 0000000000000008
[89904.537608] FS:  00007f50cc393780(0000) GS:ffff88040f900000(0000) knlGS:0000000000000000
[89904.537609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89904.537610] CR2: 00007f1652eb4000 CR3: 00000003e1dfd000 CR4: 00000000000407e0
 
[89904.537612] NMI backtrace for cpu 1
[89904.537614] CPU: 1 PID: 28438 Comm: Ableton Live 9  Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89904.537615] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89904.537616] task: ffff880116290000 ti: ffff88026033e000 task.ti: ffff88026033e000
[89904.537622] RIP: 0010:[<ffffffff812aa622>]  [<ffffffff812aa622>] __const_udelay+0x12/0x30
[89904.537623] RSP: 0000:ffff88040f883da0  EFLAGS: 00200046
[89904.537624] RAX: 0000000001062560 RBX: 0000000000002710 RCX: 0000000000000002
[89904.537625] RDX: 0000000000340c34 RSI: 0000000000000080 RDI: 0000000000418958
[89904.537626] RBP: ffff88040f883db8 R08: 0000000000000002 R09: 0000000000000028
[89904.537627] R10: 0000000000000003 R11: 0000000000021fcc R12: ffffffff81a51440
[89904.537628] R13: ffffffff81ad07f0 R14: ffffffff81a51440 R15: 0000000000000001
[89904.537630] FS:  0000000080b60000(0063) GS:ffff88040f880000(006b) knlGS:000000000b03fb40
[89904.537631] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[89904.537633] CR2: 00007f50ae7ee000 CR3: 000000032517e000 CR4: 00000000000407e0
[89904.537633] Stack:
[89904.537636]  ffff88040f883db8 ffffffff8104b315 ffff88040f88ed00 ffff88040f883e10
[89904.537638]  ffffffff810d9f4e 0000000000000001 ffff88040f883de0 ffffffff8107118e
[89904.537641]  0000000000000000 ffff880116290000 0000000000000001 0000000000000001
[89904.537641] Call Trace:
[89904.537643]  <IRQ> 
[89904.537646]  [<ffffffff8104b315>] ? arch_trigger_all_cpu_backtrace+0x75/0x90
[89904.537650]  [<ffffffff810d9f4e>] rcu_check_callbacks+0x50e/0x790
[89904.537654]  [<ffffffff8107118e>] ? raise_softirq_irqoff+0xe/0x40
[89904.537657]  [<ffffffff8107b042>] update_process_times+0x42/0x70
[89904.537660]  [<ffffffff810e5bb5>] tick_sched_handle.isra.16+0x25/0x60
[89904.537662]  [<ffffffff810e5c34>] tick_sched_timer+0x44/0x70
[89904.537665]  [<ffffffff81094a91>] __run_hrtimer+0x81/0x270
[89904.537668]  [<ffffffff810e5bf0>] ? tick_sched_handle.isra.16+0x60/0x60
[89904.537670]  [<ffffffff81095f3c>] hrtimer_interrupt+0x38c/0x3f0
[89904.537675]  [<ffffffff810495aa>] local_apic_timer_interrupt+0x3a/0x60
[89904.537678]  [<ffffffff81522daf>] smp_apic_timer_interrupt+0x3f/0x50
[89904.537682]  [<ffffffff815218dd>] apic_timer_interrupt+0x6d/0x80
[89904.537684]  <EOI> 
[89904.537702] Code: 89 e5 ff 15 69 da 7d 00 5d c3 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 8d 04 bd 00 00 00 00 65 48 8b 14 25 60 50 06 00 <48> 69 d2 fa 00 00 00 48 89 e5 f7 e2 48 8d 7a 01 e8 b9 ff ff ff 
[89904.537703] NMI backtrace for cpu 7
[89904.537706] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89904.537707] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89904.537708] task: ffff8803fdb799f0 ti: ffff8803fdb80000 task.ti: ffff8803fdb80000
[89904.537713] RIP: 0010:[<ffffffff81314de9>]  [<ffffffff81314de9>] intel_idle+0xe9/0x180
[89904.537714] RSP: 0018:ffff8803fdb81e28  EFLAGS: 00000046
[89904.537715] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[89904.537716] RDX: 0000000000000000 RSI: ffff8803fdb81fd8 RDI: 0000000000000007
[89904.537717] RBP: ffff8803fdb81e58 R08: 000000000058909e R09: 0000000034d860f9
[89904.537719] R10: 0001173a97092930 R11: 0000000000000293 R12: 0000000000000001
[89904.537720] R13: 0000000000000001 R14: 0000000000000002 R15: ffff8803fdb81fd8
[89904.537721] FS:  0000000000000000(0000) GS:ffff88040fb80000(0000) knlGS:0000000000000000
[89904.537723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89904.537724] CR2: 00007fa8ea61d000 CR3: 000000038f630000 CR4: 00000000000407e0
[89904.537724] Stack:
[89904.537728]  00000007fdb81e58 32a7a8fb32a7a8da ffff88040fbecd00 ffffffff81a8ba40
[89904.537730]  000051d1dfb1fb6f 0000000000000002 ffff8803fdb81e88 ffffffff813e03ca
[89904.537732]  0000000000000002 ffff88040fbecd00 0000000000000000 ffffffff81a8ba40
[89904.537733] Call Trace:
[89904.537738]  [<ffffffff813e03ca>] cpuidle_enter_state+0x3a/0xc0
[89904.537740]  [<ffffffff813e0507>] cpuidle_idle_call+0xb7/0x250
[89904.537744]  [<ffffffff8102142e>] arch_cpu_idle+0xe/0x30
[89904.537747]  [<ffffffff810cdf79>] cpu_startup_entry+0x259/0x2e0
[89904.537750]  [<ffffffff81047572>] start_secondary+0x212/0x2d0
[89904.537770] Code: 00 00 48 89 d1 48 8d 86 38 e0 ff ff 0f 01 c8 65 48 8b 04 25 30 c8 00 00 48 8b 80 38 e0 ff ff a8 08 75 08 b1 01 4c 89 e0 0f 01 c9 <65> 48 8b 04 25 30 c8 00 00 83 a0 3c e0 ff ff fb 0f ae f0 65 48 
[89904.537771] NMI backtrace for cpu 4
[89904.537773] CPU: 4 PID: 1015 Comm: ksysguard Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89904.537774] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89904.537775] task: ffff8803d3728000 ti: ffff8803d3726000 task.ti: ffff8803d3726000
[89904.537784] RIP: 0033:[<00007f50ca2c03dd>]  [<00007f50ca2c03dd>] 0x7f50ca2c03dd
[89904.537784] RSP: 002b:00007ffff892b380  EFLAGS: 00000202
[89904.537785] RAX: 0000000000000040 RBX: 00007ffff892b530 RCX: 00007ffff892b570
[89904.537786] RDX: 00007ffff892b530 RSI: 00007ffff892b550 RDI: 00007ffff892b530
[89904.537786] RBP: 00000000028f8d60 R08: 00000000ffad17f8 R09: 000000000271bbe0
[89904.537787] R10: 0000000000000000 R11: 000000000000012c R12: 00007ffff892b550
[89904.537788] R13: 00007ffff892b570 R14: 00007ffff892b960 R15: 0000000000000017
[89904.537789] FS:  00007f50cc393780(0000) GS:ffff88040fa00000(0000) knlGS:0000000000000000
[89904.537789] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89904.537790] CR2: 00000000ed60a000 CR3: 00000003d365f000 CR4: 00000000000407e0
 
[89904.537792] NMI backtrace for cpu 6
[89904.537794] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89904.537795] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89904.537796] task: ffff8803fdb78000 ti: ffff8803fdb76000 task.ti: ffff8803fdb76000
[89904.537801] RIP: 0010:[<ffffffff81314de9>]  [<ffffffff81314de9>] intel_idle+0xe9/0x180
[89904.537802] RSP: 0018:ffff8803fdb77e28  EFLAGS: 00000046
[89904.537803] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[89904.537804] RDX: 0000000000000000 RSI: ffff8803fdb77fd8 RDI: 0000000000000006
[89904.537805] RBP: ffff8803fdb77e58 R08: 000000000056e0c8 R09: 0000000034d860f9
[89904.537806] R10: 0001173a97092930 R11: 0000000000000293 R12: 0000000000000001
[89904.537807] R13: 0000000000000001 R14: 0000000000000002 R15: ffff8803fdb77fd8
[89904.537809] FS:  0000000000000000(0000) GS:ffff88040fb00000(0000) knlGS:0000000000000000
[89904.537810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89904.537811] CR2: 00007f50cc3ad000 CR3: 000000038f630000 CR4: 00000000000407e0
[89904.537812] Stack:
[89904.537815]  00000006fdb77e58 2f29da8b2f29da6a ffff88040fb6cd00 ffffffff81a8ba40
[89904.537817]  000051d1dfb17cd6 0000000000000002 ffff8803fdb77e88 ffffffff813e03ca
[89904.537820]  0000000000000002 ffff88040fb6cd00 0000000000000000 ffffffff81a8ba40
[89904.537820] Call Trace:
[89904.537824]  [<ffffffff813e03ca>] cpuidle_enter_state+0x3a/0xc0
[89904.537827]  [<ffffffff813e0507>] cpuidle_idle_call+0xb7/0x250
[89904.537830]  [<ffffffff8102142e>] arch_cpu_idle+0xe/0x30
[89904.537833]  [<ffffffff810cdf79>] cpu_startup_entry+0x259/0x2e0
[89904.537836]  [<ffffffff81047572>] start_secondary+0x212/0x2d0
[89904.537854] Code: 00 00 48 89 d1 48 8d 86 38 e0 ff ff 0f 01 c8 65 48 8b 04 25 30 c8 00 00 48 8b 80 38 e0 ff ff a8 08 75 08 b1 01 4c 89 e0 0f 01 c9 <65> 48 8b 04 25 30 c8 00 00 83 a0 3c e0 ff ff fb 0f ae f0 65 48 
[89904.537855] NMI backtrace for cpu 3
[89904.537857] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89904.537858] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89904.537858] task: ffff8803fdb699f0 ti: ffff8803fdb70000 task.ti: ffff8803fdb70000
[89904.537861] RIP: 0010:[<ffffffff81314de9>]  [<ffffffff81314de9>] intel_idle+0xe9/0x180
[89904.537862] RSP: 0018:ffff8803fdb71e28  EFLAGS: 00000046
[89904.537862] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000001
[89904.537863] RDX: 0000000000000000 RSI: ffff8803fdb71fd8 RDI: 0000000000000003
[89904.537864] RBP: ffff8803fdb71e58 R08: 000000000057466b R09: 0000000034d860f9
[89904.537864] R10: 0001173a97092930 R11: 0000000000000293 R12: 0000000000000001
[89904.537865] R13: 0000000000000001 R14: 0000000000000002 R15: ffff8803fdb71fd8
[89904.537866] FS:  0000000000000000(0000) GS:ffff88040f980000(0000) knlGS:0000000000000000
[89904.537867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89904.537867] CR2: 000008fe86073000 CR3: 000000038f630000 CR4: 00000000000407e0
[89904.537868] Stack:
[89904.537869]  00000003fdb71e58 24a3ff0124a3fee0 ffff88040f9ecd00 ffffffff81a8ba40
[89904.537871]  000051d1dfb19aa2 0000000000000002 ffff8803fdb71e88 ffffffff813e03ca
[89904.537872]  0000000000000002 ffff88040f9ecd00 0000000000000000 ffffffff81a8ba40
[89904.537873] Call Trace:
[89904.537875]  [<ffffffff813e03ca>] cpuidle_enter_state+0x3a/0xc0
[89904.537878]  [<ffffffff813e0507>] cpuidle_idle_call+0xb7/0x250
[89904.537881]  [<ffffffff8102142e>] arch_cpu_idle+0xe/0x30
[89904.537883]  [<ffffffff810cdf79>] cpu_startup_entry+0x259/0x2e0
[89904.537885]  [<ffffffff81047572>] start_secondary+0x212/0x2d0
[89904.537896] Code: 00 00 48 89 d1 48 8d 86 38 e0 ff ff 0f 01 c8 65 48 8b 04 25 30 c8 00 00 48 8b 80 38 e0 ff ff a8 08 75 08 b1 01 4c 89 e0 0f 01 c9 <65> 48 8b 04 25 30 c8 00 00 83 a0 3c e0 ff ff fb 0f ae f0 65 48 
[89904.537897] NMI backtrace for cpu 5
[89904.537899] CPU: 5 PID: 28534 Comm: chromium Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89904.537900] Hardware name: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3603 11/09/2012
[89904.537902] task: ffff880023984dd0 ti: ffff880071208000 task.ti: ffff880071208000
[89904.537909] RIP: 0033:[<00007f05dafb25fe>]  [<00007f05dafb25fe>] 0x7f05dafb25fe
[89904.537910] RSP: 002b:00007fff08efaa90  EFLAGS: 00000202
[89904.537911] RAX: 0000000000000001 RBX: 00000d73f2566f41 RCX: 0000000000000018
[89904.537912] RDX: 0000000000008a02 RSI: 0000026c78b04611 RDI: 00000d73f2500000
[89904.537913] RBP: 00007fff08efaaf0 R08: 00007f05c7e96a00 R09: 00007fff08efabb0
[89904.537914] R10: 00000d73f2500000 R11: 00000d73f2566f41 R12: 00007f05c7e6b000
[89904.537915] R13: 00002bbffdb0eb01 R14: 00007fff08efae88 R15: 0000000000000000
[89904.537916] FS:  00007f05d9495940(0000) GS:ffff88040fa80000(0000) knlGS:0000000000000000
[89904.537918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89904.537919] CR2: 000027f5e1189000 CR3: 000000004a5cb000 CR4: 00000000000407e0
 
[89929.940648] sr 4:0:0:0: [sr0] Device not ready
[89929.940651] sr 4:0:0:0: [sr0]  
[89929.940653] Result: hostbyte=0x00 driverbyte=0x08
[89929.940654] sr 4:0:0:0: [sr0]  
[89929.940655] Sense Key : 0x2 [current] 
[89929.940657] sr 4:0:0:0: [sr0]  
[89929.940658] ASC=0x3a ASCQ=0x1
[89929.940660] sr 4:0:0:0: [sr0] CDB: 
[89929.940661] cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
[89929.940666] end_request: I/O error, dev sr0, sector 0
[89929.940669] quiet_error: 54 callbacks suppressed
[89929.940669] Buffer I/O error on device sr0, logical block 0
[89929.940672] Buffer I/O error on device sr0, logical block 1
[89929.940673] Buffer I/O error on device sr0, logical block 2
[89929.940675] Buffer I/O error on device sr0, logical block 3
[89929.940676] Buffer I/O error on device sr0, logical block 4
[89929.940677] Buffer I/O error on device sr0, logical block 5
[89929.940679] Buffer I/O error on device sr0, logical block 6
[89929.940680] Buffer I/O error on device sr0, logical block 7
[89929.940683] Buffer I/O error on device sr0, logical block 8
[89929.940684] Buffer I/O error on device sr0, logical block 9
[89929.940697] sr 4:0:0:0: [sr0] unaligned transfer
[89929.940712] sr 4:0:0:0: [sr0] unaligned transfer
[89929.940720] sr 4:0:0:0: [sr0] unaligned transfer
[89929.940724] sr 4:0:0:0: [sr0] unaligned transfer
[89929.940737] sr 4:0:0:0: [sr0] unaligned transfer
[89929.940743] sr 4:0:0:0: [sr0] unaligned transfer
[89929.940749] sr 4:0:0:0: [sr0] unaligned transfer
[89929.940757] sr 4:0:0:0: [sr0] unaligned transfer
[89929.987630] sr 4:0:0:0: [sr0] Device not ready
[89929.987637] sr 4:0:0:0: [sr0]  
[89929.987640] Result: hostbyte=0x00 driverbyte=0x08
[89929.987645] sr 4:0:0:0: [sr0]  
[89929.987648] Sense Key : 0x2 [current] 
[89929.987653] sr 4:0:0:0: [sr0]  
[89929.987654] ASC=0x3a ASCQ=0x1
[89929.987657] sr 4:0:0:0: [sr0] CDB: 
[89929.987658] cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
[89929.987667] end_request: I/O error, dev sr0, sector 0
[89929.987711] sr 4:0:0:0: [sr0] unaligned transfer
[89929.987754] sr 4:0:0:0: [sr0] unaligned transfer
[89929.987768] sr 4:0:0:0: [sr0] unaligned transfer
[89929.987781] sr 4:0:0:0: [sr0] unaligned transfer
[89929.987805] sr 4:0:0:0: [sr0] unaligned transfer
[89929.987817] sr 4:0:0:0: [sr0] unaligned transfer
[89929.987828] sr 4:0:0:0: [sr0] unaligned transfer
[89929.987839] sr 4:0:0:0: [sr0] unaligned transfer
[89930.032855] sr 4:0:0:0: [sr0] Device not ready
[89930.032859] sr 4:0:0:0: [sr0]  
[89930.032861] Result: hostbyte=0x00 driverbyte=0x08
[89930.032862] sr 4:0:0:0: [sr0]  
[89930.032864] Sense Key : 0x2 [current] 
[89930.032867] sr 4:0:0:0: [sr0]  
[89930.032868] ASC=0x3a ASCQ=0x1
[89930.032870] sr 4:0:0:0: [sr0] CDB: 
[89930.032871] cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
[89930.032879] end_request: I/O error, dev sr0, sector 0
[89930.032934] sr 4:0:0:0: [sr0] unaligned transfer
[89930.032947] sr 4:0:0:0: [sr0] unaligned transfer
[89930.032966] sr 4:0:0:0: [sr0] unaligned transfer
[89930.032974] sr 4:0:0:0: [sr0] unaligned transfer
[89930.032983] sr 4:0:0:0: [sr0] unaligned transfer
[89930.032993] sr 4:0:0:0: [sr0] unaligned transfer
[89930.033000] sr 4:0:0:0: [sr0] unaligned transfer
[89930.033016] sr 4:0:0:0: [sr0] unaligned transfer
[89943.406650] INFO: task nacl_helper:28497 blocked for more than 120 seconds.
[89943.406654]       Tainted: G        W    3.14.2-rt3-1-rt-314 #1
[89943.406655] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[89943.406656] nacl_helper     D ffff88001a3b4dd0     0 28497  28493 0x00000002
[89943.406660]  ffff88015bcfbb38 0000000000000002 0000000000065940 ffff88015bcfbfd8
[89943.406661]  0000000000065940 ffff8803fdb699f0 ffff880374383c00 ffff8803b0260530
[89943.406662]  ffff88015bcfbb78 ffffffff81515339 0000000000065940 ffff88015bcfbfd8
[89943.406664] Call Trace:
[89943.406670]  [<ffffffff81515339>] ? __schedule+0x3b9/0x810
[89943.406674]  [<ffffffff811560f0>] ? free_hot_cold_page+0x1d0/0x2f0
[89943.406675]  [<ffffffff815157ba>] schedule+0x2a/0x90
[89943.406677]  [<ffffffff81514949>] schedule_timeout+0x209/0x2b0
[89943.406680]  [<ffffffff812033cd>] ? fsnotify_clear_marks_by_inode+0xbd/0x160
[89943.406682]  [<ffffffff815162ef>] wait_for_common+0xff/0x170
[89943.406685]  [<ffffffff810d77a0>] ? call_rcu_sched+0x20/0x20
[89943.406686]  [<ffffffff8151637d>] wait_for_completion+0x1d/0x20
[89943.406687]  [<ffffffff810d4e24>] wait_rcu_gp+0x54/0x70
[89943.406688]  [<ffffffff810d4db0>] ? __rcu_read_unlock+0x70/0x70
[89943.406690]  [<ffffffff810d9489>] synchronize_rcu+0x29/0x40
[89943.406692]  [<ffffffff81096a3d>] switch_task_namespaces+0x2d/0x40
[89943.406693]  [<ffffffff81096a60>] exit_task_namespaces+0x10/0x20
[89943.406695]  [<ffffffff8106dae1>] do_exit+0x3a1/0xb30
[89943.406697]  [<ffffffff8106e300>] do_group_exit+0x50/0xe0
[89943.406699]  [<ffffffff8107f688>] get_signal_to_deliver+0x288/0x710
[89943.406703]  [<ffffffff81016557>] do_signal+0x57/0x6c0
[89943.406704]  [<ffffffff810d96a3>] ? rcu_eqs_enter+0x93/0xa0
[89943.406705]  [<ffffffff8110914c>] ? acct_account_cputime+0x1c/0x20
[89943.406707]  [<ffffffff810a7d52>] ? account_user_time+0x92/0xb0
[89943.406709]  [<ffffffff81016c70>] do_notify_resume+0xb0/0x110
[89943.406711]  [<ffffffff81520fa4>] int_signal+0x12/0x17
[89971.807100] Clocksource tsc unstable (delta = 299966057930 ns)
[89971.808750] Switched to clocksource hpet
[90485.778300] sr 4:0:0:0: [sr0] Device not ready
[90485.778309] sr 4:0:0:0: [sr0]  
[90485.778332] Result: hostbyte=0x00 driverbyte=0x08
[90485.778351] sr 4:0:0:0: [sr0]  
[90485.778353] Sense Key : 0x2 [current] 
[90485.778358] sr 4:0:0:0: [sr0]  
[90485.778360] ASC=0x3a ASCQ=0x1
[90485.778364] sr 4:0:0:0: [sr0] CDB: 
[90485.778366] cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
[90485.778396] end_request: I/O error, dev sr0, sector 0
[90485.778401] quiet_error: 86 callbacks suppressed
[90485.778404] Buffer I/O error on device sr0, logical block 0
[90485.778428] Buffer I/O error on device sr0, logical block 1
[90485.778431] Buffer I/O error on device sr0, logical block 2
[90485.778434] Buffer I/O error on device sr0, logical block 3
[90485.778436] Buffer I/O error on device sr0, logical block 4
[90485.778438] Buffer I/O error on device sr0, logical block 5
[90485.778441] Buffer I/O error on device sr0, logical block 6
[90485.778443] Buffer I/O error on device sr0, logical block 7
[90485.778447] Buffer I/O error on device sr0, logical block 8
[90485.778450] Buffer I/O error on device sr0, logical block 9
[90485.778499] sr 4:0:0:0: [sr0] unaligned transfer
[90485.778527] sr 4:0:0:0: [sr0] unaligned transfer
[90485.778545] sr 4:0:0:0: [sr0] unaligned transfer
[90485.778573] sr 4:0:0:0: [sr0] unaligned transfer
[90485.778601] sr 4:0:0:0: [sr0] unaligned transfer
[90485.778615] sr 4:0:0:0: [sr0] unaligned transfer
[90485.778625] sr 4:0:0:0: [sr0] unaligned transfer
[90485.778645] sr 4:0:0:0: [sr0] unaligned transfer
[90485.856225] sr 4:0:0:0: [sr0] Device not ready
[90485.856230] sr 4:0:0:0: [sr0]  
[90485.856245] Result: hostbyte=0x00 driverbyte=0x08
[90485.856247] sr 4:0:0:0: [sr0]  
[90485.856249] Sense Key : 0x2 [current] 
[90485.856253] sr 4:0:0:0: [sr0]  
[90485.856255] ASC=0x3a ASCQ=0x1
[90485.856258] sr 4:0:0:0: [sr0] CDB: 
[90485.856259] cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
[90485.856268] end_request: I/O error, dev sr0, sector 0
[90485.856332] sr 4:0:0:0: [sr0] unaligned transfer
[90485.856368] sr 4:0:0:0: [sr0] unaligned transfer
[90485.856420] sr 4:0:0:0: [sr0] unaligned transfer
[90485.856441] sr 4:0:0:0: [sr0] unaligned transfer
[90485.856472] sr 4:0:0:0: [sr0] unaligned transfer
[90485.856517] sr 4:0:0:0: [sr0] unaligned transfer
[90485.856540] sr 4:0:0:0: [sr0] unaligned transfer
[90485.856556] sr 4:0:0:0: [sr0] unaligned transfer
[91788.235522] hrtimer: interrupt took 28426 ns
jack@tor /home/jack $ 

-- 

   Joakim

--MP_/tvnEA_7o3HFqFzZWvX=XW++
Content-Type: application/octet-stream; name=config.x86_64
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.x86_64

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

--MP_/tvnEA_7o3HFqFzZWvX=XW++--
