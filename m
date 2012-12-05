From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: softlockup on 3.6.8-rt19
Date: Wed, 5 Dec 2012 03:19:37 -0800
Message-ID: <12BAC08C-7C55-4BC5-B69E-DC33E023C8BF@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33780 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab2LELTj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2012 06:19:39 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3505744pad.19
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Dec 2012 03:19:39 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This is the softlockup I am seeing on one of our HP blades.

I haven't fully ruled out bad hardware, trying to reproduce on another machine.

Sven


[  128.371195] BUG: soft lockup - CPU#9 stuck for 22s! [git:6333]
[  132.387637] BUG: soft lockup - CPU#10 stuck for 23s! [agetty:674]
[  144.398987] BUG: soft lockup - CPU#11 stuck for 22s! [flush-8:0:336]
[  156.353376] BUG: soft lockup - CPU#9 stuck for 22s! [git:6333]
[  160.369814] BUG: soft lockup - CPU#10 stuck for 22s! [agetty:674]
[  192.330459] BUG: soft lockup - CPU#9 stuck for 23s! [git:6333]
[  192.349444] BUG: soft lockup - CPU#10 stuck for 23s! [agetty:674]
[  192.368428] BUG: soft lockup - CPU#11 stuck for 23s! [flush-8:0:336]
[  195.632116] BUG: spinlock lockup suspected on CPU#9, git/6333
[  195.632122] general protection fault: 0000 [#1] PREEMPT SMP 
[  195.632134] Modules linked in: nfsv4 auth_rpcgss nfs fscache lockd sunrpc af_packet cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq mperf coretemp crc32c_intel ghash_clmulni_intel kvm_intel igb iTCO_wdt iTCO_vendor_support aesni_intel gpio_ich kvm pcspkr sg ablk_helper dca ptp pps_core lpc_ich mfd_core serio_raw cryptd i7core_edac edac_core aes_x86_64 button edd microcode autofs4 mgag200 ttm drm_kms_helper drm i2c_algo_bit sysimgblt sysfillrect syscopyarea processor thermal_sys scsi_dh_alua scsi_dh_hp_sw scsi_dh_emc scsi_dh_rdac scsi_dh
[  195.632135] CPU 9 
[  195.632135] Pid: 6333, comm: git Tainted: G        W    3.6.8-rt19-4-desktop #6 HP ProLiant SL2x170z G6/ProLiant SL2x170z G6
[  195.632138] RIP: 0010:[<ffffffff816438c1>]  [<ffffffff816438c1>] spin_dump+0x56/0x91
[  195.632138] RSP: 0000:ffff880be0077818  EFLAGS: 00010206
[  195.632139] RAX: 0000000000000031 RBX: 1067a77cb2247fcc RCX: 0000000000000871
[  195.632139] RDX: ffff880be0077fd8 RSI: 0000000000000001 RDI: 0000000000000246
[  195.632140] RBP: ffff880be0077828 R08: ffffffff81e6c624 R09: 000000004642dad1
[  195.632140] R10: 0000000000000001 R11: 0000000000000000 R12: ffff880bc1867c00
[  195.632141] R13: 00000000c6ad2908 R14: 0000000000000000 R15: ffffffff81c07c00
[  195.632142] FS:  00007f639cfdc700(0000) GS:ffff880c3fc60000(0000) knlGS:0000000000000000
[  195.632142] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  195.632143] CR2: 00007f6389c26fa8 CR3: 0000000be168d000 CR4: 00000000000007e0
[  195.632143] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  195.632144] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  195.632144] Process git (pid: 6333, threadinfo ffff880be0076000, task ffff880be11accc0)
[  195.632145] Stack:
[  195.632146]  ffff880bc1867c00 00000000c6ad2908 ffff880be0077858 ffffffff81343189
[  195.632147]  ffff880bc1867c00 ffff880be00778c8 ffff880bdf458d50 ffff880be11accc0
[  195.632149]  ffff880be0077888 ffffffff81649f44 ffffffff81648d63 ffffffff8164a046
[  195.632149] Call Trace:
[  195.632151]  [<ffffffff81343189>] do_raw_spin_lock+0xf9/0x140
[  195.632152]  [<ffffffff81649f44>] _raw_spin_lock+0x44/0x50
[  195.632153]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  195.632155]  [<ffffffff8164a046>] ? _raw_spin_unlock+0x26/0x60
[  195.632156]  [<ffffffff81648d63>] rt_spin_lock_slowlock+0x43/0x380
[  195.632158]  [<ffffffff81649817>] rt_spin_lock+0x27/0x60
[  195.632159]  [<ffffffff8113f4bd>] __lru_cache_add+0x5d/0x1f0
[  195.632163]  [<ffffffffa030ad90>] ? nfs_return_empty_page+0x70/0x70 [nfs]
[  195.632165]  [<ffffffff811306b9>] add_to_page_cache_lru+0x29/0x40
[  195.632166]  [<ffffffff8113ddcc>] read_cache_pages+0x7c/0x120
[  195.632171]  [<ffffffffa030b821>] nfs_readpages+0x151/0x1d0 [nfs]
[  195.632172]  [<ffffffff8113e12a>] __do_page_cache_readahead+0x2ba/0x370
[  195.632174]  [<ffffffff8113df80>] ? __do_page_cache_readahead+0x110/0x370
[  195.632175]  [<ffffffff8113e35c>] ra_submit+0x1c/0x20
[  195.632176]  [<ffffffff81132b96>] filemap_fault+0x416/0x470
[  195.632178]  [<ffffffff811594eb>] __do_fault+0x6b/0x4d0
[  195.632179]  [<ffffffff8115c0bd>] handle_pte_fault+0x8d/0xaa0
[  195.632180]  [<ffffffff8164a046>] ? _raw_spin_unlock+0x26/0x60
[  195.632182]  [<ffffffff81083c2b>] ? migrate_enable+0xeb/0x220
[  195.632183]  [<ffffffff8115a2fe>] ? __pte_alloc+0xae/0x100
[  195.632185]  [<ffffffff8115cdcd>] handle_mm_fault+0x13d/0x1d0
[  195.632186]  [<ffffffff8164d95e>] do_page_fault+0x1ce/0x4d0
[  195.632187]  [<ffffffff810b38ad>] ? trace_hardirqs_on+0xd/0x10
[  195.632189]  [<ffffffff8133d465>] ? trace_hardirqs_off_thunk+0x3a/0x3c
[  195.632190]  [<ffffffff8164a885>] page_fault+0x25/0x30
[  195.632201] Code: 80 9c 00 00 44 8b 80 e4 02 00 00 48 8d 88 90 04 00 00 31 c0 65 8b 14 25 c4 90 00 00 e8 a0 ac ff ff 48 85 db 45 8b 4c 24 08 74 10 <44> 8b 83 e4 02 00 00 48 8d 8b 90 04 00 00 eb 0b 41 83 c8 ff 48 
[  195.632202] RIP  [<ffffffff816438c1>] spin_dump+0x56/0x91
[  195.632202]  RSP <ffff880be0077818>
[  196.112977] ---[ end trace 0000000000000003 ]---
[  196.112979] BUG: sleeping function called from invalid context at kernel/rtmutex.c:1153
[  196.112979] in_atomic(): 1, irqs_disabled(): 0, pid: 6333, name: git
[  196.112980] INFO: lockdep is turned off.
[  196.112981] Pid: 6333, comm: git Tainted: G      D W    3.6.8-rt19-4-desktop #6
[  196.112981] Call Trace:
[  196.112984]  [<ffffffff8107f24a>] __might_sleep+0x13a/0x1f0
[  196.112986]  [<ffffffff81648cff>] rt_mutex_lock+0x1f/0x40
[  196.112987]  [<ffffffff810ba52b>] __rt_down_read+0x4b/0x60
[  196.112988]  [<ffffffff810ba55b>] ? rt_down_read+0xb/0x10
[  196.112989]  [<ffffffff810ba55b>] rt_down_read+0xb/0x10
[  196.112992]  [<ffffffff81061ebf>] exit_signals+0x1f/0x140
[  196.112994]  [<ffffffff8107ae81>] ? blocking_notifier_call_chain+0x11/0x20
[  196.112996]  [<ffffffff8104e49f>] do_exit+0xaf/0xb30
[  196.112998]  [<ffffffff8104abdd>] ? kmsg_dump+0x1ad/0x220
[  196.112999]  [<ffffffff8104aa50>] ? kmsg_dump+0x20/0x220
[  196.113001]  [<ffffffff8164b4c9>] oops_end+0x99/0xe0
[  196.113003]  [<ffffffff81005d63>] die+0x53/0x80
[  196.113004]  [<ffffffff8164afc2>] do_general_protection+0x162/0x170
[  196.113005]  [<ffffffff8164a664>] ? restore_args+0x30/0x30
[  196.113006]  [<ffffffff8164a855>] general_protection+0x25/0x30
[  196.113008]  [<ffffffff816438c1>] ? spin_dump+0x56/0x91
[  196.113009]  [<ffffffff816438b7>] ? spin_dump+0x4c/0x91
[  196.113010]  [<ffffffff81343189>] do_raw_spin_lock+0xf9/0x140
[  196.113012]  [<ffffffff81649f44>] _raw_spin_lock+0x44/0x50
[  196.113013]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  196.113015]  [<ffffffff8164a046>] ? _raw_spin_unlock+0x26/0x60
[  196.113016]  [<ffffffff81648d63>] rt_spin_lock_slowlock+0x43/0x380
[  196.113018]  [<ffffffff81649817>] rt_spin_lock+0x27/0x60
[  196.113020]  [<ffffffff8113f4bd>] __lru_cache_add+0x5d/0x1f0
[  196.113025]  [<ffffffffa030ad90>] ? nfs_return_empty_page+0x70/0x70 [nfs]
[  196.113027]  [<ffffffff811306b9>] add_to_page_cache_lru+0x29/0x40
[  196.113028]  [<ffffffff8113ddcc>] read_cache_pages+0x7c/0x120
[  196.113032]  [<ffffffffa030b821>] nfs_readpages+0x151/0x1d0 [nfs]
[  196.113034]  [<ffffffff8113e12a>] __do_page_cache_readahead+0x2ba/0x370
[  196.113036]  [<ffffffff8113df80>] ? __do_page_cache_readahead+0x110/0x370
[  196.113037]  [<ffffffff8113e35c>] ra_submit+0x1c/0x20
[  196.113038]  [<ffffffff81132b96>] filemap_fault+0x416/0x470
[  196.113040]  [<ffffffff811594eb>] __do_fault+0x6b/0x4d0
[  196.113041]  [<ffffffff8115c0bd>] handle_pte_fault+0x8d/0xaa0
[  196.113043]  [<ffffffff8164a046>] ? _raw_spin_unlock+0x26/0x60
[  196.113045]  [<ffffffff81083c2b>] ? migrate_enable+0xeb/0x220
[  196.113046]  [<ffffffff8115a2fe>] ? __pte_alloc+0xae/0x100
[  196.113047]  [<ffffffff8115cdcd>] handle_mm_fault+0x13d/0x1d0
[  196.113049]  [<ffffffff8164d95e>] do_page_fault+0x1ce/0x4d0
[  196.113050]  [<ffffffff810b38ad>] ? trace_hardirqs_on+0xd/0x10
[  196.113052]  [<ffffffff8133d465>] ? trace_hardirqs_off_thunk+0x3a/0x3c
[  196.113054]  [<ffffffff8164a885>] page_fault+0x25/0x30
[  196.113055] note: git[6333] exited with preempt_count 1
[  200.084385] BUG: spinlock lockup suspected on CPU#10, agetty/674
[  200.084388] general protection fault: 0000 [#2] PREEMPT SMP 
[  200.084399] Modules linked in: nfsv4 auth_rpcgss nfs fscache lockd sunrpc af_packet cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq mperf coretemp crc32c_intel ghash_clmulni_intel kvm_intel igb iTCO_wdt iTCO_vendor_support aesni_intel gpio_ich kvm pcspkr sg ablk_helper dca ptp pps_core lpc_ich mfd_core serio_raw cryptd i7core_edac edac_core aes_x86_64 button edd microcode autofs4 mgag200 ttm drm_kms_helper drm i2c_algo_bit sysimgblt sysfillrect syscopyarea processor thermal_sys scsi_dh_alua scsi_dh_hp_sw scsi_dh_emc scsi_dh_rdac scsi_dh
[  200.084401] CPU 10 
[  200.084401] Pid: 674, comm: agetty Tainted: G      D W    3.6.8-rt19-4-desktop #6 HP ProLiant SL2x170z G6/ProLiant SL2x170z G6
[  200.084403] RIP: 0010:[<ffffffff816438c1>]  [<ffffffff816438c1>] spin_dump+0x56/0x91
[  200.084403] RSP: 0018:ffff8805e03877a8  EFLAGS: 00010286
[  200.084404] RAX: 0000000000000034 RBX: cdc5c4fabb8bf87b RCX: 00000000000008d5
[  200.084404] RDX: ffff8805e0387fd8 RSI: 0000000000000001 RDI: 0000000000000246
[  200.084405] RBP: ffff8805e03877b8 R08: ffffffff81e6c624 R09: 0000000017f07438
[  200.084405] R10: 0000000000000001 R11: 0000000000000000 R12: ffff880bc1887c00
[  200.084406] R13: 00000000c6ad2908 R14: 0000000000000000 R15: ffffffff81c07c00
[  200.084406] FS:  00007fbc02ee8700(0000) GS:ffff880c3fc80000(0000) knlGS:0000000000000000
[  200.084407] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  200.084408] CR2: 00007fbc02d77000 CR3: 00000005e0847000 CR4: 00000000000007e0
[  200.084408] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  200.084409] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  200.084409] Process agetty (pid: 674, threadinfo ffff8805e0386000, task ffff8805e0bf8300)
[  200.084409] Stack:
[  200.084411]  ffff880bc1887c00 00000000c6ad2908 ffff8805e03877e8 ffffffff81343189
[  200.084412]  ffff880bc1887c00 ffff8805e0387858 00007fbc02d77000 ffff8805e0bf8300
[  200.084414]  ffff8805e0387818 ffffffff81649f44 ffffffff81648d63 ffffffff81648d63
[  200.084414] Call Trace:
[  200.084416]  [<ffffffff81343189>] do_raw_spin_lock+0xf9/0x140
[  200.084417]  [<ffffffff81649f44>] _raw_spin_lock+0x44/0x50
[  200.084418]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  200.084420]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  200.084421]  [<ffffffff81648d63>] rt_spin_lock_slowlock+0x43/0x380
[  200.084422]  [<ffffffff81649817>] rt_spin_lock+0x27/0x60
[  200.084424]  [<ffffffff8113f4bd>] __lru_cache_add+0x5d/0x1f0
[  200.084425]  [<ffffffff8113fcef>] lru_cache_add_lru+0x1f/0x40
[  200.084427]  [<ffffffff81165f45>] page_add_new_anon_rmap+0xa5/0xd0
[  200.084428]  [<ffffffff8115c85f>] ? handle_pte_fault+0x82f/0xaa0
[  200.084429]  [<ffffffff8115c88f>] handle_pte_fault+0x85f/0xaa0
[  200.084431]  [<ffffffff81189f47>] ? mem_cgroup_count_vm_event+0x17/0x1e0
[  200.084432]  [<ffffffff8115cdcd>] handle_mm_fault+0x13d/0x1d0
[  200.084433]  [<ffffffff810ba641>] ? rt_down_read_trylock+0x61/0x90
[  200.084435]  [<ffffffff8164d95e>] do_page_fault+0x1ce/0x4d0
[  200.084436]  [<ffffffff816490b8>] ? rt_mutex_unlock+0x18/0x80
[  200.084437]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  200.084439]  [<ffffffff8133d465>] ? trace_hardirqs_off_thunk+0x3a/0x3c
[  200.084440]  [<ffffffff8164a885>] page_fault+0x25/0x30
[  200.084441]  [<ffffffff8112f7fe>] ? file_read_actor+0x3e/0x1c0
[  200.084443]  [<ffffffff81130883>] ? find_get_page+0xf3/0x220
[  200.084444]  [<ffffffff81130790>] ? filemap_page_mkwrite+0xc0/0xc0
[  200.084446]  [<ffffffff81132194>] generic_file_aio_read+0x314/0x710
[  200.084447]  [<ffffffff81194797>] do_sync_read+0xa7/0xe0
[  200.084449]  [<ffffffff811950e7>] vfs_read+0xa7/0x180
[  200.084450]  [<ffffffff81195208>] sys_read+0x48/0x90
[  200.084452]  [<ffffffff81651bbd>] system_call_fastpath+0x1a/0x1f
[  200.084462] Code: 80 9c 00 00 44 8b 80 e4 02 00 00 48 8d 88 90 04 00 00 31 c0 65 8b 14 25 c4 90 00 00 e8 a0 ac ff ff 48 85 db 45 8b 4c 24 08 74 10 <44> 8b 83 e4 02 00 00 48 8d 8b 90 04 00 00 eb 0b 41 83 c8 ff 48 
[  200.084463] RIP  [<ffffffff816438c1>] spin_dump+0x56/0x91
[  200.084464]  RSP <ffff8805e03877a8>
[  200.815585] ---[ end trace 0000000000000004 ]---
[  200.815586] BUG: sleeping function called from invalid context at kernel/rtmutex.c:1153
[  200.815587] in_atomic(): 1, irqs_disabled(): 0, pid: 674, name: agetty
[  200.815587] INFO: lockdep is turned off.
[  200.815588] Pid: 674, comm: agetty Tainted: G      D W    3.6.8-rt19-4-desktop #6
[  200.815588] Call Trace:
[  200.815590]  [<ffffffff8107f24a>] __might_sleep+0x13a/0x1f0
[  200.815592]  [<ffffffff81648cff>] rt_mutex_lock+0x1f/0x40
[  200.815593]  [<ffffffff810ba52b>] __rt_down_read+0x4b/0x60
[  200.815594]  [<ffffffff810ba55b>] ? rt_down_read+0xb/0x10
[  200.815595]  [<ffffffff810ba55b>] rt_down_read+0xb/0x10
[  200.815597]  [<ffffffff81061ebf>] exit_signals+0x1f/0x140
[  200.815598]  [<ffffffff8107ae81>] ? blocking_notifier_call_chain+0x11/0x20
[  200.815600]  [<ffffffff8104e49f>] do_exit+0xaf/0xb30
[  200.815601]  [<ffffffff8104abdd>] ? kmsg_dump+0x1ad/0x220
[  200.815603]  [<ffffffff8104aa50>] ? kmsg_dump+0x20/0x220
[  200.815604]  [<ffffffff8164b4c9>] oops_end+0x99/0xe0
[  200.815605]  [<ffffffff81005d63>] die+0x53/0x80
[  200.815606]  [<ffffffff8164afc2>] do_general_protection+0x162/0x170
[  200.815607]  [<ffffffff8164a664>] ? restore_args+0x30/0x30
[  200.815608]  [<ffffffff8164a855>] general_protection+0x25/0x30
[  200.815609]  [<ffffffff816438c1>] ? spin_dump+0x56/0x91
[  200.815610]  [<ffffffff816438b7>] ? spin_dump+0x4c/0x91
[  200.815612]  [<ffffffff81343189>] do_raw_spin_lock+0xf9/0x140
[  200.815613]  [<ffffffff81649f44>] _raw_spin_lock+0x44/0x50
[  200.815614]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  200.815616]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  200.815617]  [<ffffffff81648d63>] rt_spin_lock_slowlock+0x43/0x380
[  200.815618]  [<ffffffff81649817>] rt_spin_lock+0x27/0x60
[  200.815620]  [<ffffffff8113f4bd>] __lru_cache_add+0x5d/0x1f0
[  200.815621]  [<ffffffff8113fcef>] lru_cache_add_lru+0x1f/0x40
[  200.815623]  [<ffffffff81165f45>] page_add_new_anon_rmap+0xa5/0xd0
[  200.815624]  [<ffffffff8115c85f>] ? handle_pte_fault+0x82f/0xaa0
[  200.815625]  [<ffffffff8115c88f>] handle_pte_fault+0x85f/0xaa0
[  200.815626]  [<ffffffff81189f47>] ? mem_cgroup_count_vm_event+0x17/0x1e0
[  200.815627]  [<ffffffff8115cdcd>] handle_mm_fault+0x13d/0x1d0
[  200.815629]  [<ffffffff810ba641>] ? rt_down_read_trylock+0x61/0x90
[  200.815630]  [<ffffffff8164d95e>] do_page_fault+0x1ce/0x4d0
[  200.815631]  [<ffffffff816490b8>] ? rt_mutex_unlock+0x18/0x80
[  200.815633]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  200.815634]  [<ffffffff8133d465>] ? trace_hardirqs_off_thunk+0x3a/0x3c
[  200.815635]  [<ffffffff8164a885>] page_fault+0x25/0x30
[  200.815637]  [<ffffffff8112f7fe>] ? file_read_actor+0x3e/0x1c0
[  200.815638]  [<ffffffff81130883>] ? find_get_page+0xf3/0x220
[  200.815639]  [<ffffffff81130790>] ? filemap_page_mkwrite+0xc0/0xc0
[  200.815641]  [<ffffffff81132194>] generic_file_aio_read+0x314/0x710
[  200.815642]  [<ffffffff81194797>] do_sync_read+0xa7/0xe0
[  200.815644]  [<ffffffff811950e7>] vfs_read+0xa7/0x180
[  200.815645]  [<ffffffff81195208>] sys_read+0x48/0x90
[  200.815646]  [<ffffffff81651bbd>] system_call_fastpath+0x1a/0x1f
[  200.815648] note: agetty[674] exited with preempt_count 1
[  215.299999] BUG: spinlock lockup suspected on CPU#11, flush-8:0/336
[  215.300003] general protection fault: 0000 [#3] PREEMPT SMP 
[  215.300015] Modules linked in: nfsv4 auth_rpcgss nfs fscache lockd sunrpc af_packet cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_cpufreq mperf coretemp crc32c_intel ghash_clmulni_intel kvm_intel igb iTCO_wdt iTCO_vendor_support aesni_intel gpio_ich kvm pcspkr sg ablk_helper dca ptp pps_core lpc_ich mfd_core serio_raw cryptd i7core_edac edac_core aes_x86_64 button edd microcode autofs4 mgag200 ttm drm_kms_helper drm i2c_algo_bit sysimgblt sysfillrect syscopyarea processor thermal_sys scsi_dh_alua scsi_dh_hp_sw scsi_dh_emc scsi_dh_rdac scsi_dh
[  215.300016] CPU 11 
[  215.300016] Pid: 336, comm: flush-8:0 Tainted: G      D W    3.6.8-rt19-4-desktop #6 HP ProLiant SL2x170z G6/ProLiant SL2x170z G6
[  215.300019] RIP: 0010:[<ffffffff816438c1>]  [<ffffffff816438c1>] spin_dump+0x56/0x91
[  215.300019] RSP: 0018:ffff8805df881770  EFLAGS: 00010206
[  215.300020] RAX: 0000000000000037 RBX: 7c135a0e23ab1dd8 RCX: 000000000000093d
[  215.300020] RDX: ffff8805df881fd8 RSI: 0000000000000001 RDI: 0000000000000246
[  215.300021] RBP: ffff8805df881780 R08: ffffffff81e6c624 R09: 0000000013d84b63
[  215.300021] R10: 0000000000000001 R11: 0000000000000000 R12: ffff880bc18a7c00
[  215.300022] R13: 00000000c6ad2908 R14: 0000000000000000 R15: 0000000001400001
[  215.300023] FS:  0000000000000000(0000) GS:ffff880c3fca0000(0000) knlGS:0000000000000000
[  215.300023] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  215.300024] CR2: 000000000069700c CR3: 0000000001c16000 CR4: 00000000000007e0
[  215.300024] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  215.300025] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  215.300025] Process flush-8:0 (pid: 336, threadinfo ffff8805df880000, task ffff8805e06953c0)
[  215.300026] Stack:
[  215.300027]  ffff880bc18a7c00 00000000c6ad2908 ffff8805df8817b0 ffffffff81343189
[  215.300029]  ffff880bc18a7c00 ffff8805df881820 0000000000000000 ffff8805e06953c0
[  215.300030]  ffff8805df8817e0 ffffffff81649f44 ffffffff81648d63 0000000000000001
[  215.300030] Call Trace:
[  215.300032]  [<ffffffff81343189>] do_raw_spin_lock+0xf9/0x140
[  215.300034]  [<ffffffff81649f44>] _raw_spin_lock+0x44/0x50
[  215.300035]  [<ffffffff81648d63>] ? rt_spin_lock_slowlock+0x43/0x380
[  215.300037]  [<ffffffff81648d63>] rt_spin_lock_slowlock+0x43/0x380
[  215.300038]  [<ffffffff81130582>] ? unlock_page+0x22/0x30
[  215.300040]  [<ffffffff81649817>] rt_spin_lock+0x27/0x60
[  215.300041]  [<ffffffff81140222>] lru_add_drain+0x42/0x140
[  215.300043]  [<ffffffff81140331>] __pagevec_release+0x11/0x30
[  215.300044]  [<ffffffff8113c2f6>] write_cache_pages+0x2c6/0x660
[  215.300045]  [<ffffffff8113b850>] ? mapping_tagged+0x10/0x10
[  215.300048]  [<ffffffff8164a046>] ? _raw_spin_unlock+0x26/0x60
[  215.300049]  [<ffffffff8113c6d8>] generic_writepages+0x48/0x70
[  215.300050]  [<ffffffff8113daac>] do_writepages+0x1c/0x40
[  215.300052]  [<ffffffff811c30d1>] __writeback_single_inode.isra.33+0x41/0x270
[  215.300053]  [<ffffffff811c390b>] writeback_sb_inodes+0x2db/0x5f0
[  215.300054]  [<ffffffff811c3cb7>] __writeback_inodes_wb+0x97/0xd0
[  215.300056]  [<ffffffff811c409b>] wb_writeback+0x3ab/0x5f0
[  215.300058]  [<ffffffff811c5240>] wb_do_writeback+0x300/0x370
[  215.300059]  [<ffffffff811c5343>] bdi_writeback_thread+0x93/0x570
[  215.300061]  [<ffffffff811c52b0>] ? wb_do_writeback+0x370/0x370
[  215.300062]  [<ffffffff81072543>] kthread+0xa3/0xb0
[  215.300064]  [<ffffffff8164a11b>] ? _raw_spin_unlock_irq+0x2b/0x70
[  215.300065]  [<ffffffff810802f7>] ? finish_task_switch+0x77/0x130
[  215.300067]  [<ffffffff810802ba>] ? finish_task_switch+0x3a/0x130
[  215.300068]  [<ffffffff81652f84>] kernel_thread_helper+0x4/0x10
[  215.300070]  [<ffffffff8164a11b>] ? _raw_spin_unlock_irq+0x2b/0x70
[  215.300071]  [<ffffffff8164a634>] ? retint_restore_args+0x13/0x13
[  215.300073]  [<ffffffff810724a0>] ? __init_kthread_worker+0xa0/0xa0
[  215.300074]  [<ffffffff81652f80>] ? gs_change+0x13/0x13
[  215.300084] Code: 80 9c 00 00 44 8b 80 e4 02 00 00 48 8d 88 90 04 00 00 31 c0 65 8b 14 25 c4 90 00 00 e8 a0 ac ff ff 48 85 db 45 8b 4c 24 08 74 10 <44> 8b 83 e4 02 00 00 48 8d 8b 90 04 00 00 eb 0b 41 83 c8 ff 48 
[  215.300086] RIP  [<ffffffff816438c1>] spin_dump+0x56/0x91
[  215.300086]  RSP <ffff8805df881770>

