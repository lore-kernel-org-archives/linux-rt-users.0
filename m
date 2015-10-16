From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Lockdep splat + hardlock on 4.1.10-rt9
Date: Fri, 16 Oct 2015 19:52:32 -0300
Message-ID: <20151016225231.GL4265@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33638 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbbJPWwh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Oct 2015 18:52:37 -0400
Received: by qgeo38 with SMTP id o38so69144182qge.0
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Oct 2015 15:52:36 -0700 (PDT)
Received: from lclaudio.dyndns.org (179.176.247.35.dynamic.adsl.gvt.net.br. [179.176.247.35])
        by smtp.gmail.com with ESMTPSA id 84sm8784344qkz.8.2015.10.16.15.52.35
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2015 15:52:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Has anybody seen the lockdep splat listed below? I was rebooting a box to
run the last test before starting the weekend when I saw this one:

[  688.417543] =============================================
[  688.417544] [ INFO: possible recursive locking detected ]
[  688.417546] 4.1.10-rt9+ #4 Not tainted
[  688.417546] ---------------------------------------------
[  688.417548] ksoftirqd/0/3 is trying to acquire lock:
[  688.417556]  (((&req->rsk_timer))){+.+...}, at: [<ffffffff81115625>] del_timer_sync+0x5/0x190
[  688.417557] 
               but task is already holding lock:
[  688.417560]  (((&req->rsk_timer))){+.+...}, at: [<ffffffff81115885>] call_timer_fn+0x5/0x570
[  688.417560] 
               other info that might help us debug this:
[  688.417560]  Possible unsafe locking scenario:

[  688.417561]        CPU0
[  688.417561]        ----
[  688.417562]   lock(((&req->rsk_timer)));
[  688.417563]   lock(((&req->rsk_timer)));
[  688.417564] 
                *** DEADLOCK ***

[  688.417564]  May be due to missing lock nesting notation

[  688.417565] 2 locks held by ksoftirqd/0/3:
[  688.417571]  #0:  (&per_cpu(local_softirq_locks[i], __cpu).lock){+.+.+.}, at: [<ffffffff8108c1a3>] do_current_softirqs+0x143/0x820
[  688.417574]  #1:  (((&req->rsk_timer))){+.+...}, at: [<ffffffff81115885>] call_timer_fn+0x5/0x570
[  688.417575] 
               stack backtrace:
[  688.417577] CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 4.1.10-rt9+ #4
[  688.417578] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[  688.417581]  0000000000000000 00000000ba064747 ffff88019327b9c8 ffffffff81824f57
[  688.417583]  0000000000000000 ffffffff82b33de0 ffff88019327bab8 ffffffff810e78dc
[  688.417584]  ffff88019327ba08 ffff8801931dd960 ffff8801931dd960 ffffffff82b05950
[  688.417585] Call Trace:
[  688.417590]  [<ffffffff81824f57>] dump_stack+0x4a/0x61
[  688.417594]  [<ffffffff810e78dc>] __lock_acquire+0x205c/0x2110
[  688.417597]  [<ffffffff810e8a4f>] lock_acquire+0xef/0x2f0
[  688.417599]  [<ffffffff81115625>] ? del_timer_sync+0x5/0x190
[  688.417601]  [<ffffffff810e1e2e>] ? put_lock_stats.isra.22+0xe/0x40
[  688.417603]  [<ffffffff81115672>] del_timer_sync+0x52/0x190
[  688.417604]  [<ffffffff81115625>] ? del_timer_sync+0x5/0x190
[  688.417606]  [<ffffffff8182c7f5>] ? _raw_spin_unlock+0x35/0x70
[  688.417610]  [<ffffffff8182a828>] ? rt_spin_lock_slowunlock+0x68/0x70
[  688.417613]  [<ffffffff8173aa8e>] inet_csk_reqsk_queue_drop+0xbe/0x210
[  688.417614]  [<ffffffff8173acc7>] reqsk_timer_handler+0xe7/0x2d0
[  688.417616]  [<ffffffff8173abe0>] ? inet_csk_reqsk_queue_drop+0x210/0x210
[  688.417618]  [<ffffffff81115962>] call_timer_fn+0xe2/0x570
[  688.417619]  [<ffffffff81115885>] ? call_timer_fn+0x5/0x570
[  688.417620]  [<ffffffff8173abe0>] ? inet_csk_reqsk_queue_drop+0x210/0x210
[  688.417622]  [<ffffffff8173abe0>] ? inet_csk_reqsk_queue_drop+0x210/0x210
[  688.417624]  [<ffffffff81115f8c>] run_timer_softirq+0x19c/0x4f0
[  688.417627]  [<ffffffff8108c2cd>] do_current_softirqs+0x26d/0x820
[  688.417630]  [<ffffffff8108c959>] run_ksoftirqd+0x29/0x50
[  688.417633]  [<ffffffff810b2b47>] smpboot_thread_fn+0x207/0x340
[  688.417636]  [<ffffffff810b2940>] ? smpboot_register_percpu_thread+0x100/0x100
[  688.417640]  [<ffffffff810ae3b6>] kthread+0xf6/0x110
[  688.417643]  [<ffffffff818297ab>] ? wait_for_completion+0xeb/0x120
[  688.417646]  [<ffffffff810ae2c0>] ? kthread_create_on_node+0x260/0x260
[  688.417648]  [<ffffffff8182dad2>] ret_from_fork+0x42/0x70
[  688.417651]  [<ffffffff810ae2c0>] ? kthread_create_on_node+0x260/0x260
[  688.418499] NOHZ: local_softirq_pending 02
[  688.419498] NOHZ: local_softirq_pending 02
[  688.420151] NOHZ: local_softirq_pending 02
[  688.420500] NOHZ: local_softirq_pending 82
[  688.421499] NOHZ: local_softirq_pending 82
[  688.422497] NOHZ: local_softirq_pending 82
[  688.423502] NOHZ: local_softirq_pending 82
[  688.424497] NOHZ: local_softirq_pending 82
[  688.425497] NOHZ: local_softirq_pending 82
[  688.426497] NOHZ: local_softirq_pending 82
[  747.480722] systemd-journald[4585]: File /var/log/journal/69d27b356a94476da859461d3a3bc6fd/system.journal corrupted or uncleanly shut down, renaming and replacing.
[  753.461085] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  753.461088] 	(detected by 0, t=65002 jiffies, g=75549, c=75548, q=16630)
[  753.461090] All QSes seen, last rcu_preempt kthread activity 65002 (4295420639-4295355637), jiffies_till_next_fqs=3, root ->qsmask 0x0
[  753.461093] swapper/0       R  running task        0     0      0 0x00080000
[  753.461097]  ffffffff81e1b4e0 8bcdf5c08bcdf5b6 ffff880198c03d88 ffffffff810be939
[  753.461099]  ffffffff810be865 000000010006eadf ffffffff81e5cdc0 000000000001271d
[  753.461101]  ffff880198c03e18 ffffffff81110bae 0000000000000000 0000000000000096
[  753.461102] Call Trace:
[  753.461110]  <IRQ>  [<ffffffff810be939>] sched_show_task+0x139/0x260
[  753.461113]  [<ffffffff810be865>] ? sched_show_task+0x65/0x260
[  753.461117]  [<ffffffff81110bae>] rcu_check_callbacks+0xd6e/0xd80
[  753.461121]  [<ffffffff81116f1e>] update_process_times+0x3e/0x50
[  753.461138]  [<ffffffff8112b375>] tick_sched_handle.isra.17+0x25/0x60
[  753.461140]  [<ffffffff8112b717>] tick_sched_timer+0x47/0x90
[  753.461142]  [<ffffffff81118816>] __run_hrtimer+0x106/0x780
[  753.461144]  [<ffffffff81119924>] ? hrtimer_interrupt+0x94/0x270
[  753.461147]  [<ffffffff8112b6d0>] ? tick_sched_do_timer+0x50/0x50
[  753.461149]  [<ffffffff811199b8>] hrtimer_interrupt+0x128/0x270
[  753.461153]  [<ffffffff8103f3aa>] local_apic_timer_interrupt+0x3a/0x70
[  753.461157]  [<ffffffff81830141>] smp_apic_timer_interrupt+0x41/0x60
[  753.461160]  [<ffffffff8182e570>] apic_timer_interrupt+0x70/0x80
[  753.461164]  <EOI>  [<ffffffff81685a09>] ? cpuidle_enter_state+0x99/0x3d0
[  753.461167]  [<ffffffff81685a14>] ? cpuidle_enter_state+0xa4/0x3d0
[  753.461169]  [<ffffffff81685a09>] ? cpuidle_enter_state+0x99/0x3d0
[  753.461171]  [<ffffffff81685d77>] cpuidle_enter+0x17/0x20
[  753.461175]  [<ffffffff810da160>] cpu_startup_entry+0x3e0/0x650
[  753.461178]  [<ffffffff81820159>] rest_init+0x139/0x140
[  753.461181]  [<ffffffff8212dfc6>] start_kernel+0x481/0x4a2
[  753.461184]  [<ffffffff8212d2fe>] x86_64_start_reservations+0x2a/0x2c
[  753.461186]  [<ffffffff8212d464>] x86_64_start_kernel+0x164/0x173
[  753.461188] rcu_preempt kthread starved for 65002 jiffies!
[  771.935766] ------------[ cut here ]------------
[  771.935792] WARNING: CPU: 2 PID: 3913 at /home/lclaudio/SANDBOX/mrg-rt-v2-devel/net/core/request_sock.c:121 reqsk_queue_destroy+0x28b/0x2b0()
[  771.935793] Modules linked in: rfcomm fuse nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw bnep vfat fat coretemp kvm_intel kvm arc4 rt2800pci rt2800mmio rt2800lib rt2x00pci rt2x00mmio rt2x00lib btusb eeprom_93cx6 iTCO_wdt iTCO_vendor_support mac80211 btbcm joydev btintel snd_hda_codec_idt bluetooth snd_hda_codec_generic crc32c_intel snd_hda_intel snd_hda_controller snd_hda_codec snd_hda_core ghash_clmulni_intel snd_hwdep microcode snd_seq cfg802
 11 pcspkr
[  771.935818]  crc_ccitt
[  771.935818]  snd_seq_device
[  771.935819]  snd_pcm
[  771.935819]  rfkill
[  771.935820]  snd_timer
[  771.935820]  snd
[  771.935821]  soundcore
[  771.935821]  tpm_tis
[  771.935821]  lpc_ich
[  771.935822]  tpm
[  771.935822]  shpchp
[  771.935822]  mfd_core
[  771.935823]  i2c_i801
[  771.935823]  acpi_cpufreq
[  771.935824]  nfsd
[  771.935824]  auth_rpcgss
[  771.935824]  nfs_acl
[  771.935825]  lockd
[  771.935825]  grace
[  771.935825]  sunrpc
[  771.935826]  binfmt_misc
[  771.935826]  sch_fq_codel
[  771.935827]  efivarfs
[  771.935827]  serio_raw
[  771.935828]  i915
[  771.935828]  i2c_algo_bit
[  771.935828]  drm_kms_helper
[  771.935829]  drm
[  771.935829]  r8169
[  771.935830]  mii
[  771.935830]  i2c_core
[  771.935831]  video
[  771.935831]  usb_storage

[  771.935845] CPU: 2 PID: 3913 Comm: transmission-gt Not tainted 4.1.10-rt9+ #4
[  771.935846] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[  771.935848]  0000000000000000 0000000095cfbf60 ffff880139497cf8 ffffffff81824f57
[  771.935852]  0000000000000000 0000000000000000 ffff880139497d38 ffffffff8108622a
[  771.935855]  ffff88005de047f8 ffff8800d75d1c40 ffff88005de047f8 ffff88005de04008
[  771.935858] Call Trace:
[  771.935863]  [<ffffffff81824f57>] dump_stack+0x4a/0x61
[  771.935867]  [<ffffffff8108622a>] warn_slowpath_common+0x8a/0xe0
[  771.935869]  [<ffffffff8108637a>] warn_slowpath_null+0x1a/0x20
[  771.935871]  [<ffffffff816c6fdb>] reqsk_queue_destroy+0x28b/0x2b0
[  771.935874]  [<ffffffff8173a31f>] inet_csk_listen_stop+0x2f/0x350
[  771.935876]  [<ffffffff81740145>] tcp_close+0x45/0x450
[  771.935880]  [<ffffffff81771b3f>] inet_release+0x3f/0x70
[  771.935883]  [<ffffffff817b9a20>] inet6_release+0x30/0x40
[  771.935885]  [<ffffffff816bd45f>] sock_release+0x1f/0x90
[  771.935887]  [<ffffffff816bd4e2>] sock_close+0x12/0x20
[  771.935890]  [<ffffffff8123e200>] __fput+0xf0/0x210
[  771.935892]  [<ffffffff8123e36e>] ____fput+0xe/0x10
[  771.935895]  [<ffffffff810ac85c>] task_work_run+0xcc/0x100
[  771.935898]  [<ffffffff81003d95>] do_notify_resume+0xc5/0x100
[  771.935901]  [<ffffffff8182d8ae>] int_signal+0x12/0x17
[  771.935903] ---[ end trace 0000000000000002 ]---
[  771.935905] qlen 1
[  772.041809] systemd-journald[4585]: File /var/log/journal/69d27b356a94476da859461d3a3bc6fd/user-1000.journal corrupted or uncleanly shut down, renaming and replacing.
[  812.284647] INFO: rcu_sched detected stalls on CPUs/tasks:
[  812.284650] 	(detected by 0, t=65002 jiffies, g=2, c=1, q=12)
[  812.284651] All QSes seen, last rcu_sched kthread activity 65002 (4295479481-4295414479), jiffies_till_next_fqs=3, root ->qsmask 0x0
[  812.284655] polkitd         R  running task        0   775      1 0x00080080
[  812.284658]  ffff88018c2f2770 00000000a03f96c2 ffff880198c03d88 ffffffff810be939
[  812.284659]  ffffffff810be865 000000010007d0b9 ffffffff81e5db80 0000000000000002
[  812.284661]  ffff880198c03e18 ffffffff81110bae 0000000000000000 0000000000000096
[  812.284662] Call Trace:
[  812.284669]  <IRQ>  [<ffffffff810be939>] sched_show_task+0x139/0x260
[  812.284671]  [<ffffffff810be865>] ? sched_show_task+0x65/0x260
[  812.284676]  [<ffffffff81110bae>] rcu_check_callbacks+0xd6e/0xd80
[  812.284679]  [<ffffffff81116f1e>] update_process_times+0x3e/0x50
[  812.284682]  [<ffffffff8112b375>] tick_sched_handle.isra.17+0x25/0x60
[  812.284684]  [<ffffffff8112b717>] tick_sched_timer+0x47/0x90
[  812.284686]  [<ffffffff81118816>] __run_hrtimer+0x106/0x780
[  812.284688]  [<ffffffff81119924>] ? hrtimer_interrupt+0x94/0x270
[  812.284690]  [<ffffffff8112b6d0>] ? tick_sched_do_timer+0x50/0x50
[  812.284692]  [<ffffffff811199b8>] hrtimer_interrupt+0x128/0x270
[  812.284697]  [<ffffffff8103f3aa>] local_apic_timer_interrupt+0x3a/0x70
[  812.284701]  [<ffffffff81830141>] smp_apic_timer_interrupt+0x41/0x60
[  812.284703]  [<ffffffff8115cadc>] ? __audit_syscall_entry+0xac/0x100
[  812.284705]  [<ffffffff8182e570>] apic_timer_interrupt+0x70/0x80
[  812.284708]  <EOI>  [<ffffffff8115cadc>] ? __audit_syscall_entry+0xac/0x100
[  812.284711]  [<ffffffff8112128b>] ? current_kernel_time+0x5b/0xb0
[  812.284713]  [<ffffffff8112128d>] ? current_kernel_time+0x5d/0xb0
[  812.284714]  [<ffffffff8115cadc>] ? __audit_syscall_entry+0xac/0x100
[  812.284716]  [<ffffffff8115cadc>] __audit_syscall_entry+0xac/0x100
[  812.284719]  [<ffffffff81014135>] do_audit_syscall_entry+0x55/0x80
[  812.284721]  [<ffffffff810153eb>] syscall_trace_enter_phase1+0x14b/0x1b0
[  812.284724]  [<ffffffff81403919>] ? trace_hardirqs_on_thunk+0x17/0x19
[  812.284726]  [<ffffffff8182d741>] tracesys+0xd/0x44
[  812.284729] rcu_sched kthread starved for 65002 jiffies!
[  818.442715] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  818.442718] 	(detected by 0, t=65002 jiffies, g=75550, c=75549, q=45356)
[  818.442719] All QSes seen, last rcu_preempt kthread activity 65002 (4295485641-4295420639), jiffies_till_next_fqs=3, root ->qsmask 0x0
[  818.442722] polkitd         R  running task        0   775      1 0x00080080
[  818.442724]  ffff88018c2f2770 00000000a03f96c2 ffff880198c03d88 ffffffff810be939
[  818.442726]  ffffffff810be865 000000010007e8c9 ffffffff81e5cdc0 000000000001271e
[  818.442728]  ffff880198c03e18 ffffffff81110bae 0000000000000000 0000000000000096
[  818.442728] Call Trace:
[  818.442733]  <IRQ>  [<ffffffff810be939>] sched_show_task+0x139/0x260
[  818.442735]  [<ffffffff810be865>] ? sched_show_task+0x65/0x260
[  818.442738]  [<ffffffff81110bae>] rcu_check_callbacks+0xd6e/0xd80
[  818.442741]  [<ffffffff81116f1e>] update_process_times+0x3e/0x50
[  818.442743]  [<ffffffff8112b375>] tick_sched_handle.isra.17+0x25/0x60
[  818.442745]  [<ffffffff8112b717>] tick_sched_timer+0x47/0x90
[  818.442747]  [<ffffffff81118816>] __run_hrtimer+0x106/0x780
[  818.442749]  [<ffffffff81119924>] ? hrtimer_interrupt+0x94/0x270
[  818.442751]  [<ffffffff8112b6d0>] ? tick_sched_do_timer+0x50/0x50
[  818.442753]  [<ffffffff811199b8>] hrtimer_interrupt+0x128/0x270
[  818.442757]  [<ffffffff8103f3aa>] local_apic_timer_interrupt+0x3a/0x70
[  818.442760]  [<ffffffff81830141>] smp_apic_timer_interrupt+0x41/0x60
[  818.442762]  [<ffffffff8182e570>] apic_timer_interrupt+0x70/0x80
[  818.442765]  <EOI> 
[  818.442765] rcu_preempt kthread starved for 65002 jiffies!
[  877.266295] INFO: rcu_sched detected stalls on CPUs/tasks:
[  877.266297] 	(detected by 0, t=65002 jiffies, g=3, c=2, q=9)
[  877.266299] All QSes seen, last rcu_sched kthread activity 65002 (4295544483-4295479481), jiffies_till_next_fqs=3, root ->qsmask 0x0
[  877.266302] polkitd         R  running task        0   775      1 0x00080080
[  877.266305]  ffff88018c2f2770 00000000a03f96c2 ffff880198c03d88 ffffffff810be939
[  877.266307]  ffffffff810be865 000000010008cea3 ffffffff81e5db80 0000000000000003
[  877.266309]  ffff880198c03e18 ffffffff81110bae 0000000000000000 0000000000000096
[  877.266310] Call Trace:
[  877.266317]  <IRQ>  [<ffffffff810be939>] sched_show_task+0x139/0x260
[  877.266319]  [<ffffffff810be865>] ? sched_show_task+0x65/0x260
[  877.266323]  [<ffffffff81110bae>] rcu_check_callbacks+0xd6e/0xd80
[  877.266327]  [<ffffffff81116f1e>] update_process_times+0x3e/0x50
[  877.266330]  [<ffffffff8112b375>] tick_sched_handle.isra.17+0x25/0x60
[  877.266332]  [<ffffffff8112b717>] tick_sched_timer+0x47/0x90
[  877.266334]  [<ffffffff81118816>] __run_hrtimer+0x106/0x780
[  877.266336]  [<ffffffff81119924>] ? hrtimer_interrupt+0x94/0x270
[  877.266338]  [<ffffffff8112b6d0>] ? tick_sched_do_timer+0x50/0x50
[  877.266340]  [<ffffffff811199b8>] hrtimer_interrupt+0x128/0x270
[  877.266344]  [<ffffffff8103f3aa>] local_apic_timer_interrupt+0x3a/0x70
[  877.266349]  [<ffffffff81830141>] smp_apic_timer_interrupt+0x41/0x60
[  877.266351]  [<ffffffff8182e570>] apic_timer_interrupt+0x70/0x80
[  877.266355]  <EOI>  [<ffffffff810d8e19>] ? add_wait_queue+0x49/0x50
[  877.266359]  [<ffffffff812553a1>] __pollwait+0x81/0xf0
[  877.266363]  [<ffffffff81295e30>] eventfd_poll+0x30/0x70
[  877.266365]  [<ffffffff81256efa>] do_sys_poll+0x36a/0x600
[  877.266370]  [<ffffffff81255320>] ? poll_initwait+0x50/0x50
[  877.266372]  [<ffffffff81255740>] ? poll_select_copy_remaining+0x180/0x180
[  877.266375]  [<ffffffff81255740>] ? poll_select_copy_remaining+0x180/0x180
[  877.266379]  [<ffffffff810e0b75>] ? cpuacct_account_field+0x5/0x1e0
[  877.266382]  [<ffffffff81255953>] ? poll_select_set_timeout+0x53/0x80
[  877.266385]  [<ffffffff8115cadc>] ? __audit_syscall_entry+0xac/0x100
[  877.266387]  [<ffffffff810e554d>] ? trace_hardirqs_on+0xd/0x10
[  877.266390]  [<ffffffff81120af2>] ? ktime_get_ts64+0xa2/0x180
[  877.266392]  [<ffffffff81255953>] ? poll_select_set_timeout+0x53/0x80
[  877.266395]  [<ffffffff81014135>] ? do_audit_syscall_entry+0x55/0x80
[  877.266398]  [<ffffffff81257291>] SyS_poll+0x71/0x130
[  877.266400]  [<ffffffff8182d6d7>] system_call_fastpath+0x12/0x6f
[  877.266402] rcu_sched kthread starved for 65002 jiffies!
[  883.424366] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  883.424369] 	(detected by 0, t=65002 jiffies, g=75551, c=75550, q=44199)
[  883.424371] All QSes seen, last rcu_preempt kthread activity 65002 (4295550643-4295485641), jiffies_till_next_fqs=3, root ->qsmask 0x0
[  883.424374] polkitd         R  running task        0   775      1 0x00080080
[  883.424377]  ffff88018c2f2770 00000000a03f96c2 ffff880198c03d88 ffffffff810be939
[  883.424379]  ffffffff810be865 000000010008e6b3 ffffffff81e5cdc0 000000000001271f
[  883.424381]  ffff880198c03e18 ffffffff81110bae 0000000000000000 0000000000000096
[  883.424381] Call Trace:
[  883.424389]  <IRQ>  [<ffffffff810be939>] sched_show_task+0x139/0x260
[  883.424391]  [<ffffffff810be865>] ? sched_show_task+0x65/0x260
[  883.424396]  [<ffffffff81110bae>] rcu_check_callbacks+0xd6e/0xd80
[  883.424398]  [<ffffffff81116f1e>] update_process_times+0x3e/0x50
[  883.424402]  [<ffffffff8112b375>] tick_sched_handle.isra.17+0x25/0x60
[  883.424404]  [<ffffffff8112b717>] tick_sched_timer+0x47/0x90
[  883.424406]  [<ffffffff81118816>] __run_hrtimer+0x106/0x780
[  883.424407]  [<ffffffff81119924>] ? hrtimer_interrupt+0x94/0x270
[  883.424409]  [<ffffffff8112b6d0>] ? tick_sched_do_timer+0x50/0x50
[  883.424412]  [<ffffffff811199b8>] hrtimer_interrupt+0x128/0x270
[  883.424416]  [<ffffffff8103f3aa>] local_apic_timer_interrupt+0x3a/0x70
[  883.424420]  [<ffffffff81830141>] smp_apic_timer_interrupt+0x41/0x60
[  883.424422]  [<ffffffff8182e570>] apic_timer_interrupt+0x70/0x80
[  883.424426]  <EOI> 
[  883.424426] rcu_preempt kthread starved for 65002 jiffies!
[  942.247977] INFO: rcu_sched detected stalls on CPUs/tasks:
[  942.247979] 	(detected by 0, t=65002 jiffies, g=4, c=3, q=12)
[  942.247980] All QSes seen, last rcu_sched kthread activity 65002 (4295609485-4295544483), jiffies_till_next_fqs=3, root ->qsmask 0x0
[  942.247982] swapper/0       R  running task        0     0      0 0x00080000
[  942.247984]  ffffffff81e1b4e0 8bcdf5c08bcdf5b6 ffff880198c03d88 ffffffff810be939
[  942.247985]  ffffffff810be865 000000010009cc8d ffffffff81e5db80 0000000000000004
[  942.247987]  ffff880198c03e18 ffffffff81110bae 0000000000000000 0000000000000096
[  942.247987] Call Trace:
[  942.247993]  <IRQ>  [<ffffffff810be939>] sched_show_task+0x139/0x260
[  942.247994]  [<ffffffff810be865>] ? sched_show_task+0x65/0x260
[  942.247997]  [<ffffffff81110bae>] rcu_check_callbacks+0xd6e/0xd80
[  942.247999]  [<ffffffff81116f1e>] update_process_times+0x3e/0x50
[  942.248002]  [<ffffffff8112b375>] tick_sched_handle.isra.17+0x25/0x60
[  942.248015]  [<ffffffff8112b717>] tick_sched_timer+0x47/0x90
[  942.248016]  [<ffffffff81118816>] __run_hrtimer+0x106/0x780
[  942.248017]  [<ffffffff81119924>] ? hrtimer_interrupt+0x94/0x270
[  942.248031]  [<ffffffff8112b6d0>] ? tick_sched_do_timer+0x50/0x50
[  942.248032]  [<ffffffff811199b8>] hrtimer_interrupt+0x128/0x270
[  942.248035]  [<ffffffff8103f3aa>] local_apic_timer_interrupt+0x3a/0x70
[  942.248038]  [<ffffffff81830141>] smp_apic_timer_interrupt+0x41/0x60
[  942.248039]  [<ffffffff8182e570>] apic_timer_interrupt+0x70/0x80
[  942.248042]  <EOI>  [<ffffffff81685a09>] ? cpuidle_enter_state+0x99/0x3d0
[  942.248043]  [<ffffffff81685a14>] ? cpuidle_enter_state+0xa4/0x3d0
[  942.248045]  [<ffffffff81685a09>] ? cpuidle_enter_state+0x99/0x3d0
[  942.248046]  [<ffffffff81685d77>] cpuidle_enter+0x17/0x20
[  942.248049]  [<ffffffff810da160>] cpu_startup_entry+0x3e0/0x650
[  942.248050]  [<ffffffff81820159>] rest_init+0x139/0x140
[  942.248053]  [<ffffffff8212dfc6>] start_kernel+0x481/0x4a2
[  942.248055]  [<ffffffff8212d2fe>] x86_64_start_reservations+0x2a/0x2c
[  942.248056]  [<ffffffff8212d464>] x86_64_start_kernel+0x164/0x173
[  942.248058] rcu_sched kthread starved for 65002 jiffies!
[  948.406053] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  948.406055] 	(detected by 1, t=65002 jiffies, g=75552, c=75551, q=34053)
[  948.406056] All QSes seen, last rcu_preempt kthread activity 65002 (4295615645-4295550643), jiffies_till_next_fqs=3, root ->qsmask 0x0
[  948.406057] swapper/1       R  running task        0     0      1 0x00080000
[  948.406059]  ffff8801932ea770 90ec857a90ec8570 ffff880198e03d88 ffffffff810be939
[  948.406060]  ffffffff810be865 000000010009e49d ffffffff81e5cdc0 0000000000012720
[  948.406061]  ffff880198e03e18 ffffffff81110bae 0000000000000000 0000000000000096
[  948.406062] Call Trace:
[  948.406065]  <IRQ>  [<ffffffff810be939>] sched_show_task+0x139/0x260
[  948.406067]  [<ffffffff810be865>] ? sched_show_task+0x65/0x260
[  948.406069]  [<ffffffff81110bae>] rcu_check_callbacks+0xd6e/0xd80
[  948.406070]  [<ffffffff81116f1e>] update_process_times+0x3e/0x50
[  948.406072]  [<ffffffff8112b375>] tick_sched_handle.isra.17+0x25/0x60
[  948.406073]  [<ffffffff8112b717>] tick_sched_timer+0x47/0x90
[  948.406075]  [<ffffffff81118816>] __run_hrtimer+0x106/0x780
[  948.406088]  [<ffffffff81119924>] ? hrtimer_interrupt+0x94/0x270
[  948.406089]  [<ffffffff8112b6d0>] ? tick_sched_do_timer+0x50/0x50
[  948.406090]  [<ffffffff811199b8>] hrtimer_interrupt+0x128/0x270
[  948.406104]  [<ffffffff8103f3aa>] local_apic_timer_interrupt+0x3a/0x70
[  948.406106]  [<ffffffff81830141>] smp_apic_timer_interrupt+0x41/0x60
[  948.406107]  [<ffffffff8182e570>] apic_timer_interrupt+0x70/0x80
[  948.406110]  <EOI>  [<ffffffff81685a09>] ? cpuidle_enter_state+0x99/0x3d0
[  948.406111]  [<ffffffff81685a14>] ? cpuidle_enter_state+0xa4/0x3d0
[  948.406112]  [<ffffffff81685a09>] ? cpuidle_enter_state+0x99/0x3d0
[  948.406114]  [<ffffffff81685d77>] cpuidle_enter+0x17/0x20
[  948.406116]  [<ffffffff810da160>] cpu_startup_entry+0x3e0/0x650
[  948.406118]  [<ffffffff8103d80c>] start_secondary+0x17c/0x1c0
[  948.406119] rcu_preempt kthread starved for 65002 jiffies!

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

