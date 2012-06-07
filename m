From: John Kacur <jkacur@redhat.com>
Subject: shutdown problem on -rt
Date: Thu, 7 Jun 2012 23:44:42 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206072339450.8398@tycho>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63553 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953Ab2FGVog (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2012 17:44:36 -0400
Received: by eeit10 with SMTP id t10so538680eei.19
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Jun 2012 14:44:35 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have a problem one one machine with shutdown on rt. It exists in 3.0-rt, 
3.2-rt and 3.4-rt, but it has become easier to reproduce on 3.4-rt.

The following are from
uname
3.4.0-rt6-debug
which is actuall 3.4.0-rt7

When things don't shutdown properly, then most often I get a hang that 
looks like this.

[ 6081.425324] Ebtables v2.0 unregistered
[  OK  ]
iptables: Flushing firewall rules: [  OK  ]
iptables: Setting chains to policy ACCEPT: nat filter [  OK  ]
iptables: Unloading modules: [  OK  ]
Disabling ondemand cpu frequency scaling: [  OK  ]
Sending all processes the TERM signal... [  OK  ]
Sending all processes the KILL signal... [  OK  ]
Saving random seed:  [  OK  ]
Syncing hardware clock to system time [  OK  ]
Turning off swap:  [  OK  ]
Turning off quotas:  [  OK  ]
Unmounting pipe file systems:  [  OK  ]
Unmounting file systems:  [  OK  ]
[ 6086.771957] EXT4-fs (md127p5): re-mounted. Opts: (null)
Halting system...
                 [ 6087.163411] audit_printk_skb: 46 callbacks suppressed
[ 6087.163413] type=1128 audit(1338547586.391:42067): pid=0 uid=0 
auid=42949672'
[ 6090.163329] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
[ 6090.163555] sd 3:0:0:0: [sdb] Stopping disk
[ 6091.089556] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[ 6091.089826] sd 2:0:0:0: [sda] Stopping disk
[ 6092.015365] pcieport 0000:00:1c.4: wake-up capability enabled by ACPI
[ 6092.026323] ACPI: Preparing to enter system sleep state S5
[ 6092.033399] Disabling non-boot CPUs ...


However, sometimes if I can trigger a BUG_ON that looks like this.

ip6tables: Flushing firewall rules: [  OK  ]
ip6tables: Setting chains to policy ACCEPT: filter [  OK  ]
ip6tables: Unloading modules: [   47.609934] type=1325 
audit(1338549028.459:26)6
[   47.610007] type=1300 audit(1338549028.459:26): arch=c000003e 
syscall=54 suc)
[   47.615848] type=1325 audit(1338549028.465:27): table=filter family=10 
entri4
[   47.615922] type=1300 audit(1338549028.465:27): arch=c000003e 
syscall=54 suc)
[   47.623856] type=1325 audit(1338549028.473:28): table=filter family=10 
entri4
[   47.623920] type=1300 audit(1338549028.473:28): arch=c000003e 
syscall=54 suc)
[   47.626763] type=1325 audit(1338549028.476:29): table=filter family=10 
entri4
[   47.626836] type=1300 audit(1338549028.476:29): arch=c000003e 
syscall=54 suc)
[   47.778121] Ebtables v2.0 unregistered
[  OK  ]
iptables: Flushing firewall rules: [  OK  ]
iptables: Setting chains to policy ACCEPT: nat filter [  OK  ]
iptables: Unloading modules: [  OK  ]
Disabling ondemand cpu frequency scaling: [  OK  ]
Sending all processes the TERM signal... [  OK  ]
Sending all processes the KILL signal... [  OK  ]
Saving random seed:  [  OK  ]
Syncing hardware clock to system time [  OK  ]
Turning off swap:  [  OK  ]
Turning off quotas:  [  OK  ]
Unmounting pipe file systems:  [  OK  ]
Unmounting file systems:  [  OK  ]
[   52.222387] EXT4-fs (md127p5): re-mounted. Opts: (null)
Halting system...
                 [   55.353736] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
[   55.353981] sd 3:0:0:0: [sdb] Stopping disk
[   56.275157] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[   56.275383] sd 2:0:0:0: [sda] Stopping disk
[   57.202136] pcieport 0000:00:1c.4: wake-up capability enabled by ACPI
[   57.212993] ACPI: Preparing to enter system sleep state S5
[   57.220326] Disabling non-boot CPUs ...
[   57.220973] ------------[ cut here ]------------
[   57.220977] kernel BUG at 
/home/jkacur/linux-rt/kernel/workqueue.c:1431!
[   57.220981] invalid opcode: 0000 [#1] PREEMPT SMP 
[   57.220984] CPU 0 
[   57.220986] Modules linked in: bridge stp sunrpc acpi_cpufreq 
nf_conntrack_i]
[   57.221031] 
[   57.221034] Pid: 3409, comm: halt Not tainted 3.4.0-rt6-debug+ #1 
Gigabyte TR
[   57.221039] RIP: 0010:[<ffffffff81061795>]  [<ffffffff81061795>] 
destroy_wor0
[   57.221047] RSP: 0018:ffff88019653bbe8  EFLAGS: 00010282
[   57.221050] RAX: 0000000000000000 RBX: ffff88018db7dcc0 RCX: 
0000000000000000
[   57.221052] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 
ffff88018db7dcc0
[   57.221058] RBP: ffff88019653bc08 R08: 0000000000000000 R09: 
0000000000000000
[   57.221059] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff8801a7a0bfc0
[   57.221060] R13: 0000000000000002 R14: ffff88019653bda4 R15: 
ffffffff81ab4dc0
[   57.221062] FS:  00007f28f2294700(0000) GS:ffff8801a7600000(0000) 
knlGS:00000
[   57.221064] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   57.221065] CR2: 00007ffd7998c940 CR3: 000000018c9c5000 CR4: 
00000000000007f0
[   57.221067] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   57.221068] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[   57.221070] Process halt (pid: 3409, threadinfo ffff88019653a000, task 
ffff8)
[   57.221071] Stack:
[   57.221072]  ffffffff810654f3 ffff8801a7a0bfc0 0000000000000000 
ffff8801a7a00
[   57.221075]  ffff88019653bcd8 ffffffff810657a8 ffff88019653bc28 
ffff880196538
[   57.221078]  ffff88019653bc48 ffff88018e67d140 000000000020b7a0 
0000000000001
[   57.221080] Call Trace:
[   57.221084]  [<ffffffff810654f3>] ? flush_gcwq+0x43/0x450
[   57.221086]  [<ffffffff810657a8>] flush_gcwq+0x2f8/0x450
[   57.221090]  [<ffffffff813eb0f4>] ? __cpufreq_remove_dev+0x164/0x390
[   57.221092]  [<ffffffff813e88b2>] ? lock_policy_rwsem_write+0x52/0x90
[   57.221096]  [<ffffffff814faa87>] workqueue_cpu_down_callback+0x33/0x3a
[   57.221099]  [<ffffffff81513bb5>] notifier_call_chain+0x55/0x80
[   57.221102]  [<ffffffff8107217e>] __raw_notifier_call_chain+0xe/0x10
[   57.221105]  [<ffffffff81046270>] __cpu_notify+0x20/0x40
[   57.221107]  [<ffffffff814f8b8b>] _cpu_down+0x18b/0x3b0
[   57.221109]  [<ffffffff81046635>] ? cpu_maps_update_begin+0x15/0x20
[   57.221111]  [<ffffffff81046783>] disable_nonboot_cpus+0xb3/0x130
[   57.221115]  [<ffffffff8105ee76>] kernel_power_off+0x26/0x50
[   57.221117]  [<ffffffff8105f1d7>] sys_reboot+0x147/0x250
[   57.221120]  [<ffffffff8150d284>] ? do_nanosleep+0xb4/0xe0
[   57.221122]  [<ffffffff81071477>] ? hrtimer_nanosleep+0xc7/0x180
[   57.221125]  [<ffffffff81510b13>] ? error_sti+0x5/0x6
[   57.221128]  [<ffffffff8109f489>] ? 
trace_hardirqs_off_caller+0x29/0x140
[   57.221131]  [<ffffffff8151070a>] ? retint_swapgs+0xe/0x13
[   57.221133]  [<ffffffff810a3d00>] ? trace_hardirqs_on_caller+0x20/0x200
[   57.221137]  [<ffffffff810ce91c>] ? __audit_syscall_entry+0xcc/0x210
[   57.221140]  [<ffffffff81283946>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[   57.221143]  [<ffffffff81517b92>] system_call_fastpath+0x16/0x1b
[   57.221145] Code: 22 5b 21 00 48 83 c4 08 5b 41 5c 41 5d c9 c3 0f 1f 80 
00 0 
[   57.221165] RIP  [<ffffffff81061795>] destroy_worker+0xc5/0xd0
[   57.221168]  RSP <ffff88019653bbe8>
[   57.730014] ---[ end trace 0000000000000002 ]---
init: rc0 main process (3409) killed by SEGV signal
[   60.944192] irq 19: nobody cared (try booting with the "irqpoll" 
option)
[   60.944195] Pid: 1449, comm: irq/19-uhci_hcd Tainted: G      D      
3.4.0-rt1
[   60.944198] Call Trace:
[   60.944203]  [<ffffffff810e18ed>] __report_bad_irq+0x3d/0xe0
[   60.944205]  [<ffffffff810e1afd>] note_interrupt+0x16d/0x220
[   60.944208]  [<ffffffff810dfaa2>] irq_thread+0x212/0x220
[   60.944210]  [<ffffffff810e1170>] ? irq_thread_fn+0x50/0x50
[   60.944213]  [<ffffffff810df890>] ? irq_select_affinity_usr+0x80/0x80
[   60.944215]  [<ffffffff810df890>] ? irq_select_affinity_usr+0x80/0x80
[   60.944218]  [<ffffffff8106b316>] kthread+0xb6/0xc0
[   60.944221]  [<ffffffff81513d89>] ? sub_preempt_count+0xa9/0xe0
[   60.944223]  [<ffffffff8151040b>] ? _raw_spin_unlock_irq+0x3b/0x60
[   60.944227]  [<ffffffff81519014>] kernel_thread_helper+0x4/0x10
[   60.944230]  [<ffffffff8107929c>] ? finish_task_switch+0x8c/0x110
[   60.944232]  [<ffffffff8151071d>] ? retint_restore_args+0xe/0xe
[   60.944234]  [<ffffffff8106b260>] ? kthreadd+0x1e0/0x1e0
[   60.944236]  [<ffffffff81519010>] ? gs_change+0xb/0xb
[   60.944238] handlers:
[   60.944239] [<ffffffff810df5e0>] irq_default_primary_handler threaded 
[<ffffq
[   60.944243] Disabling IRQ #19


I've been closely reading the code, but not sure how to procede right now.
I wanted to share the information with everyone in case someone sees 
something that I don't.

Of course I'm willing  to make alterations and try suggestions.

Thanks
John
