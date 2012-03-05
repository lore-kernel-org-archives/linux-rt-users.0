From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Panic when running 'shutdown -h' on 3.2.9-rt15
Date: Mon, 5 Mar 2012 13:01:36 -0300
Message-ID: <20120305160136.GA5334@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <clark@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: RT users list <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56023 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab2CEQEG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Mar 2012 11:04:06 -0500
Received: by yenl12 with SMTP id l12so1701823yen.19
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Mar 2012 08:04:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have two backtraces from attempts to halt (via shutdwon -h) a Core 2 Duo
box:

Backtrace 01: (panic)
-------------

[root@lab ~]# shutdown -h now

...
[  470.977145] ACPI: Preparing to enter system sleep state S5
[  470.978188] Disabling non-boot CPUs ...
[  470.981502] lockdep: fixing up alternatives.
[  470.986158] ------------[ cut here ]------------
[  471.014583] WARNING: at kernel/sched.c:4415 migrate_disable+0x5d/0xbf()
[  471.021225] Hardware name: 8810A56
[  471.025001] BUG: unable to handle kernel paging request at ffffffff8103e98f
[  471.025001] IP: [<ffffffff8106b749>] __lock_acquire+0xa9/0x42e
[  471.025001] PGD 1810067 PUD 1814063 PMD 10001e1 
[  471.025001] Thread overran stack, or stack corrupted
[  471.025001] Oops: 0003 [#1] PREEMPT SMP 
[  471.025001] CPU 0 
[  471.025001] Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_regio]
[  471.025001] 
[  471.025001] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36 LENOVO 8810A56/LENOVO
[  471.025001] RIP: 0010:[<ffffffff8106b749>]  [<ffffffff8106b749>] __lock_acquire+0xa9/0x42e
[  471.025001] RSP: 0018:ffff88007ea03cf8  EFLAGS: 00010082
[  471.025001] RAX: ffffffff8103e7f7 RBX: ffff88007c07a2b8 RCX: 0000000000000000
[  471.025001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88007c07a2b8
[  471.025001] RBP: ffff88007ea03d48 R08: 0000000000000001 R09: 0000000000000001
[  471.025001] R10: 00000000000001d6 R11: ffff88007c090300 R12: 0000000000000000
[  471.025001] R13: ffff88007c090300 R14: 0000000000000000 R15: 0000000000000001
[  471.025001] FS:  0000000000000000(0000) GS:ffff88007ea00000(0000) knlGS:0000000000000000
[  471.025001] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  471.025001] CR2: ffffffff8103e98f CR3: 000000007340d000 CR4: 00000000000006f0
[  471.025001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  471.025001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  471.025001] Process ksoftirqd/1 (pid: 12, threadinfo ffff88007c08a000, task ffff88007c090300)
[  471.025001] Stack:
[  471.025001]  ffff880000000000 ffffffff00000000 000000007ea03d28 ffffffff81060993
[  471.025001]  0000000000000000 0000000000000000 ffff88007c090300 ffffffff810341dc
[  471.025001]  0000000000000001 0000000000000000 ffff88007ea03dc8 ffffffff8106bb92
[  471.025001] Call Trace:
[  471.025001]  <IRQ> 
[  471.025001]  [<ffffffff81060993>] ? sched_clock_local+0x12/0x75
[  471.025001] BUG: unable to handle kernel paging request at 000000000000346f
[  471.025001] IP: [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] PGD 0 
[  471.025001] Thread overran stack, or stack corrupted
[  471.025001] Oops: 0000 [#2] PREEMPT SMP 
[  471.025001] CPU 0 
[  471.025001] Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_regio]
[  471.025001] 
[  471.025001] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36 LENOVO 8810A56/LENOVO
[  471.025001] RIP: 0010:[<ffffffff81004c35>]  [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] RSP: 0018:ffff88007ea03808  EFLAGS: 00010083
[  471.025001] RAX: ffffffff81400180 RBX: ffff88007ea03d10 RCX: ffff88007c08a000
[  471.025001] RDX: 000000000000113f RSI: ffffffff81576366 RDI: ffffffff81060993
[  471.025001] RBP: ffff88007ea03818 R08: ffff88007ea038e4 R09: ffffffff81576366
[  471.025001] R10: ffffffff81576366 R11: 0000000000000000 R12: ffff88007ea03d48
[  471.025001] R13: ffff88007ea03d48 R14: ffff88007ea03fc0 R15: ffffffff81060993
[  471.025001] FS:  0000000000000000(0000) GS:ffff88007ea00000(0000) knlGS:0000000000000000
[  471.025001] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  471.025001] CR2: 000000000000346f CR3: 000000007340d000 CR4: 00000000000006f0
[  471.025001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  471.025001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  471.025001] Process ksoftirqd/1 (pid: 12, threadinfo ffff88007c08a000, task ffff88007c090300)
[  471.025001] Stack:
[  471.025001]  ffff88007ea03d10 ffff88007ea03d48 ffff88007ea03888 ffffffff81004dd9
[  471.025001]  ffffffff8103eac3 ffff88007ea01fc0 ffff88007c08bff8 ffffffff81400180
[  471.025001]  ffffffff81576366 ffff88007c08a000 ffffffff815767be ffff88007ea03cf8
[  471.025001] Call Trace:
[  471.025001]  <IRQ> 
[  471.025001]  [<ffffffff81004dd9>] print_context_stack+0x93/0xd8
[  471.025001] BUG: unable to handle kernel paging request at 000000000000346f
[  471.025001] IP: [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] PGD 0 
[  471.025001] Thread overran stack, or stack corrupted
[  471.025001] Oops: 0000 [#3] PREEMPT SMP 
[  471.025001] CPU 0 
[  471.025001] Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_regio]
[  471.025001] 
[  471.025001] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36 LENOVO 8810A56/LENOVO
[  471.025001] RIP: 0010:[<ffffffff81004c35>]  [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] RSP: 0018:ffff88007ea03318  EFLAGS: 00010087
[  471.025001] RAX: ffffffff81400180 RBX: ffff88007ea03820 RCX: ffff88007c08a000
[  471.025001] RDX: 000000000000113f RSI: ffffffff81576366 RDI: ffffffff81004dd9
[  471.025001] RBP: ffff88007ea03328 R08: ffff88007ea033f4 R09: ffffffff81576366
[  471.025001] R10: ffffffff81576366 R11: 0000000000000000 R12: ffff88007ea03888
[  471.025001] R13: ffff88007ea03888 R14: ffff88007ea03fc0 R15: ffffffff81004dd9
[  471.025001] FS:  0000000000000000(0000) GS:ffff88007ea00000(0000) knlGS:0000000000000000
[  471.025001] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  471.025001] CR2: 000000000000346f CR3: 000000007340d000 CR4: 00000000000006f0
[  471.025001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  471.025001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  471.025001] Process ksoftirqd/1 (pid: 12, threadinfo ffff88007c08a000, task ffff88007c090300)
[  471.025001] Stack:
[  471.025001]  ffff88007ea03820 ffff88007ea03818 ffff88007ea03398 ffffffff81004dd9
[  471.025001]  ffffffff8103eac3 ffff88007ea01fc0 ffff88007c08bff8 ffffffff81400180
[  471.025001]  ffffffff81576366 ffff88007c08a000 ffffffff815767be ffff88007ea03808
[  471.025001] Call Trace:
[  471.025001]  <IRQ> 
[  471.025001]  [<ffffffff81004dd9>] print_context_stack+0x93/0xd8
[  471.025001] BUG: unable to handle kernel paging request at 000000000000346f
[  471.025001] IP: [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] PGD 0 
[  471.025001] Thread overran stack, or stack corrupted
[  471.025001] Oops: 0000 [#4] PREEMPT SMP 
[  471.025001] CPU 0 
[  471.025001] Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_regio]
[  471.025001] 
[  471.025001] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36 LENOVO 8810A56/LENOVO
[  471.025001] RIP: 0010:[<ffffffff81004c35>]  [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] RSP: 0018:ffff88007ea02e28  EFLAGS: 00010087
[  471.025001] RAX: ffffffff81400180 RBX: ffff88007ea03330 RCX: ffff88007c08a000
[  471.025001] RDX: 000000000000113f RSI: ffffffff81576366 RDI: ffffffff81004dd9
[  471.025001] RBP: ffff88007ea02e38 R08: ffff88007ea02f04 R09: ffffffff81576366
[  471.025001] R10: ffffffff81576366 R11: 0000000000000000 R12: ffff88007ea03398
[  471.025001] R13: ffff88007ea03398 R14: ffff88007ea03fc0 R15: ffffffff81004dd9
[  471.025001] FS:  0000000000000000(0000) GS:ffff88007ea00000(0000) knlGS:0000000000000000
[  471.025001] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  471.025001] CR2: 000000000000346f CR3: 000000007340d000 CR4: 00000000000006f0
[  471.025001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  471.025001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  471.025001] Process ksoftirqd/1 (pid: 12, threadinfo ffff88007c08a000, task ffff88007c090300)
[  471.025001] Stack:
[  471.025001]  ffff88007ea03330 ffff88007ea03328 ffff88007ea02ea8 ffffffff81004dd9
[  471.025001]  ffffffff8103eac3 ffff88007ea01fc0 ffff88007c08bff8 ffffffff81400180
[  471.025001]  ffffffff81576366 ffff88007c08a000 ffffffff815767be ffff88007ea03318
[  471.025001] Call Trace:
[  471.025001]  <IRQ> 
[  471.025001]  [<ffffffff81004dd9>] print_context_stack+0x93/0xd8
[  471.025001] BUG: unable to handle kernel paging request at 000000000000346f
[  471.025001] IP: [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] PGD 0 
[  471.025001] Thread overran stack, or stack corrupted
[  471.025001] Oops: 0000 [#5] PREEMPT SMP 
[  471.025001] CPU 0 
[  471.025001] Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_regio]
[  471.025001] 
[  471.025001] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36 LENOVO 8810A56/LENOVO
[  471.025001] RIP: 0010:[<ffffffff81004c35>]  [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] RSP: 0018:ffff88007ea02938  EFLAGS: 00010087
[  471.025001] RAX: ffffffff81400180 RBX: ffff88007ea02e40 RCX: ffff88007c08a000
[  471.025001] RDX: 000000000000113f RSI: ffffffff81576366 RDI: ffffffff81004dd9
[  471.025001] RBP: ffff88007ea02948 R08: ffff88007ea02a14 R09: ffffffff81576366
[  471.025001] R10: ffffffff81576366 R11: 0000000000000000 R12: ffff88007ea02ea8
[  471.025001] R13: ffff88007ea02ea8 R14: ffff88007ea03fc0 R15: ffffffff81004dd9
[  471.025001] FS:  0000000000000000(0000) GS:ffff88007ea00000(0000) knlGS:0000000000000000
[  471.025001] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  471.025001] CR2: 000000000000346f CR3: 000000007340d000 CR4: 00000000000006f0
[  471.025001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  471.025001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  471.025001] Process ksoftirqd/1 (pid: 12, threadinfo ffff88007c08a000, task ffff88007c090300)
[  471.025001] Stack:
[  471.025001]  ffff88007ea02e40 ffff88007ea02e38 ffff88007ea029b8 ffffffff81004dd9
[  471.025001]  ffffffff8103eac3 ffff88007ea01fc0 ffff88007c08bff8 ffffffff81400180
[  471.025001]  ffffffff81576366 ffff88007c08a000 ffffffff815767be ffff88007ea02e28
[  471.025001] Call Trace:
[  471.025001]  <IRQ> 
[  471.025001]  [<ffffffff81004dd9>] print_context_stack+0x93/0xd8
[  471.025001] BUG: unable to handle kernel paging request at 000000000000346f
[  471.025001] IP: [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] PGD 0 
[  471.025001] Thread overran stack, or stack corrupted
[  471.025001] Oops: 0000 [#6] PREEMPT SMP 
[  471.025001] CPU 0 
[  471.025001] Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_regio]
[  471.025001] 
[  471.025001] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36 LENOVO 8810A56/LENOVO
[  471.025001] RIP: 0010:[<ffffffff81004c35>]  [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] RSP: 0018:ffff88007ea02448  EFLAGS: 00010087
[  471.025001] RAX: ffffffff81400180 RBX: ffff88007ea02950 RCX: ffff88007c08a000
[  471.025001] RDX: 000000000000113f RSI: ffffffff81576366 RDI: ffffffff81004dd9
[  471.025001] RBP: ffff88007ea02458 R08: ffff88007ea02524 R09: ffffffff81576366
[  471.025001] R10: ffffffff81576366 R11: 0000000000000000 R12: ffff88007ea029b8
[  471.025001] R13: ffff88007ea029b8 R14: ffff88007ea03fc0 R15: ffffffff81004dd9
[  471.025001] FS:  0000000000000000(0000) GS:ffff88007ea00000(0000) knlGS:0000000000000000
[  471.025001] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  471.025001] CR2: 000000000000346f CR3: 000000007340d000 CR4: 00000000000006f0
[  471.025001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  471.025001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  471.025001] Process ksoftirqd/1 (pid: 12, threadinfo ffff88007c08a000, task ffff88007c090300)
[  471.025001] Stack:
[  471.025001]  ffff88007ea02950 ffff88007ea02948 ffff88007ea024c8 ffffffff81004dd9
[  471.025001]  ffffffff8103eac3 ffff88007ea01fc0 ffff88007c08bff8 ffffffff81400180
[  471.025001]  ffffffff81576366 ffff88007c08a000 ffffffff815767be ffff88007ea02938
[  471.025001] Call Trace:
[  471.025001]  <IRQ> 
[  471.025001]  [<ffffffff81004dd9>] print_context_stack+0x93/0xd8
[  471.025001] BUG: unable to handle kernel paging request at 000000000000346f
[  471.025001] IP: [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] PGD 0 
[  471.025001] Thread overran stack, or stack corrupted
[  471.025001] Oops: 0000 [#7] PREEMPT SMP 
[  471.025001] CPU 0 
[  471.025001] Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_regio]
[  471.025001] 
[  471.025001] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36 LENOVO 8810A56/LENOVO
[  471.025001] RIP: 0010:[<ffffffff81004c35>]  [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001] RSP: 0018:ffff88007ea01f58  EFLAGS: 00010087
[  471.025001] RAX: ffffffff81400180 RBX: ffff88007ea02460 RCX: ffff88007c08a000
[  471.025001] RDX: 000000000000113f RSI: ffffffff81576366 RDI: ffffffff81004dd9
[  471.025001] RBP: ffff88007ea01f68 R08: ffff88007ea02034 R09: ffffffff81576366
[  471.025001] R10: ffffffff81576366 R11: 0000000000000000 R12: ffff88007ea024c8
[  471.025001] R13: ffff88007ea024c8 R14: ffff88007ea03fc0 R15: ffffffff81004dd9
[  471.025001] FS:  0000000000000000(0000) GS:ffff88007ea00000(0000) knlGS:0000000000000000
[  471.025001] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  471.025001] CR2: 000000000000346f CR3: 000000007340d000 CR4: 00000000000006f0
[  471.025001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  471.025001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  471.025001] Process ksoftirqd/1 (pid: 12, threadinfo ffff88007c08a000, task ffff88007c090300)
[  471.025001] Stack:
[  471.025001]  ffff88007ea02460 ffff88007ea02458 ffff88007ea01fd8 ffffffff81004dd9
[  471.025001]  ffffffff8103eac3 ffff88007ea01fc0 ffff88007c08bff8 ffffffff81400180
[  471.025001]  ffffffff81576366 ffff88007c08a000 ffffffff815767be ffff88007ea02448
[  471.025001] Call Trace:
[  471.025001]  <IRQ> 
[  471.025001]  <EOI> 
[  471.025001] Code: f8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 90 90 55 48 89 e5 48 83 ec 10 66 66 66 66 90 48 89 d0 48 8b 11 48 81 ff 01 b6  
[  471.025001] RIP  [<ffffffff81004c35>] print_ftrace_graph_addr+0x1d/0x5c
[  471.025001]  RSP <ffff88007ea01f58>
[  471.025001] CR2: 000000000000346f
[  471.025001] ---[ end trace 0000000000000002 ]---
[  471.025001] Kernel panic - not syncing: Fatal exception in interrupt
[  471.025001] Pid: 12, comm: ksoftirqd/1 Tainted: G      D      3.2.9-rt15+ #36
[  471.025001] Call Trace:
[  471.025001]  <IRQ>  <EOI> 
[  471.025001] panic occurred, switching back to text console



Backtrace 02: (no panic)
-------------


[root@lab ~]# shutdown -h now

...
<6>ACPI: Preparing to enter system sleep state S5
Disabling non-boot CPUs ...
lockdep: fixing up alternatives.
<4>------------[ cut here ]------------
<4>WARNING: at kernel/sched.c:4446 migrate_enable+0x62/0x16a()
<4>Hardware name: 8810A56
<d>Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_region_hash dm_lo]
Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36
Call Trace:
 [<ffffffff8103ddc8>] warn_slowpath_common+0x83/0x9b
 [<ffffffff813d4d4e>] ? rt_spin_lock_slowunlock+0x1d/0x66
 [<ffffffff8103ddfa>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81037c66>] migrate_enable+0x62/0x16a
 [<ffffffff8103fa0b>] pin_current_cpu+0x9f/0xa9
 [<ffffffff81043f03>] __thread_do_softirq+0x13/0x132
 [<ffffffff810440ba>] run_ksoftirqd+0x98/0x195
 [<ffffffff81044022>] ? __thread_do_softirq+0x132/0x132
 [<ffffffff8105aeb8>] kthread+0x99/0xa1
 [<ffffffff81060ba7>] ? local_clock+0x27/0x2f
 [<ffffffff813dcd74>] kernel_thread_helper+0x4/0x10
 [<ffffffff8105ae1f>] ? __init_kthread_worker+0x8e/0x8e
 [<ffffffff813dcd70>] ? gs_change+0x13/0x13
<4>---[ end trace 0000000000000002 ]---
<4>------------[ cut here ]------------
<4>WARNING: at kernel/sched.c:4448 migrate_enable+0x8c/0x16a()
<4>Hardware name: 8810A56
<d>Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_region_hash dm_lo]
Pid: 12, comm: ksoftirqd/1 Tainted: G        W    3.2.9-rt15+ #36
Call Trace:
 [<ffffffff8103ddc8>] warn_slowpath_common+0x83/0x9b
 [<ffffffff8103ddfa>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81037c90>] migrate_enable+0x8c/0x16a
 [<ffffffff8103fa0b>] pin_current_cpu+0x9f/0xa9
 [<ffffffff81043f03>] __thread_do_softirq+0x13/0x132
 [<ffffffff810440ba>] run_ksoftirqd+0x98/0x195
 [<ffffffff81044022>] ? __thread_do_softirq+0x132/0x132
 [<ffffffff8105aeb8>] kthread+0x99/0xa1
 [<ffffffff81060ba7>] ? local_clock+0x27/0x2f
 [<ffffffff813dcd74>] kernel_thread_helper+0x4/0x10
 [<ffffffff8105ae1f>] ? __init_kthread_worker+0x8e/0x8e
 [<ffffffff813dcd70>] ? gs_change+0x13/0x13
<4>---[ end trace 0000000000000003 ]---
<4>------------[ cut here ]------------
<4>WARNING: at kernel/sched.c:4415 migrate_disable+0x5d/0xbf()
<4>Hardware name: 8810A56
<d>Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_region_hash dm_lo]
Pid: 12, comm: ksoftirqd/1 Tainted: G        W    3.2.9-rt15+ #36
Call Trace:
 [<ffffffff8103ddc8>] warn_slowpath_common+0x83/0x9b
 [<ffffffff8103ddfa>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff81037dcb>] migrate_disable+0x5d/0xbf
 [<ffffffff8105ee4f>] ? hrtimer_try_to_cancel+0x79/0x87
 [<ffffffff810808cd>] acct_collect+0x8b/0x192
 [<ffffffff81044022>] ? __thread_do_softirq+0x132/0x132
 [<ffffffff81041644>] do_exit+0x1f3/0x7ad
 [<ffffffff81044192>] ? run_ksoftirqd+0x170/0x195
 [<ffffffff81044022>] ? __thread_do_softirq+0x132/0x132
 [<ffffffff8105aec0>] kthread+0xa1/0xa1
 [<ffffffff81060ba7>] ? local_clock+0x27/0x2f
 [<ffffffff813dcd74>] kernel_thread_helper+0x4/0x10
 [<ffffffff8105ae1f>] ? __init_kthread_worker+0x8e/0x8e
 [<ffffffff813dcd70>] ? gs_change+0x13/0x13
<4>---[ end trace 0000000000000004 ]---
<0>Power down.
<7>acpi_power_off called




-- 
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

