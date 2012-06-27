From: Dong Liu <dliu.cn@gmail.com>
Subject: RT patch and XEN
Date: Wed, 27 Jun 2012 16:52:46 -0400
Message-ID: <4FEB729E.2080508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34492 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab2F0Uwj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2012 16:52:39 -0400
Received: by bkcji2 with SMTP id ji2so1445246bkc.19
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Jun 2012 13:52:38 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I tried to run PREEMPT_RT patch under XEN, but running into some problem.

My kernel is 3.4.3 with -r11 patch. XEN is 4.1.2. The kernel is running 
file as dom0. But as a Paravirtual (PV) domU, the system crashes normal 
when there is network traffic. kernel message indicates is 
kernel/rtmutex_common.h:75, which is,

        BUG_ON(w->lock != lock);

Is this a known problem?

Thanks!

Dong

PS. Here is the kernel message

[ 144.871050] kernel BUG at kernel/rtmutex_common.h:75! 

[  144.871052] invalid opcode: 0000 [#1] PREEMPT SMP 

[  144.871054] CPU 0 

[  144.871054] Modules linked in: 8021q garp stp llc sunrpc binfmt_misc 
uinput coretemp crc32c_intel microcode xen_netfront pcspkr x\
en_blkfront [last unloaded: scsi_wait_scan] 

[  144.871060] 

[  144.871062] Pid: 3, comm: ksoftirqd/0 Not tainted 
3.4.3-1.el6.alu_preempt_rt.x86_64-rt11 #1 

[  144.871064] RIP: e030:[<ffffffff810bb538>]  [<ffffffff810bb538>] 
wakeup_next_waiter+0x98/0xa0
[  144.871071] RSP: e02b:ffff88003e1f1dc0  EFLAGS: 00010096 

[  144.871072] RAX: ffff88003fc00068 RBX: ffff88003fc0c360 RCX: 
0000000000000001
[  144.871073] RDX: 0000000000003978 RSI: 0000000000000000 RDI: 
ffffffff81cf5368
[  144.871075] RBP: ffff88003e1f1df0 R08: 0000000000000001 R09: 
0000000000000000
[  144.871076] R10: 0000000000000004 R11: 0000000000000000 R12: 
ffff88003e1ee788
[  144.871077] R13: ffffffff81cf5350 R14: ffff88003e1ee0c0 R15: 
ffff88003fc00068
[  144.871081] FS:  00007fc492e307c0(0000) GS:ffff88003fc00000(0000) 
knlGS:0000000000000000
[  144.871083] CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
[  144.871084] CR2: 0000003d8be2c0f0 CR3: 00000000397bf000 CR4: 
0000000000002660
[  144.871086] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  144.871088] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[  144.871089] Process ksoftirqd/0 (pid: 3, threadinfo ffff88003e1f0000, 
task ffff88003e1ee0c0)
[  144.871090] Stack:
[  144.871091]  ffff88003e1f0000 ffff88003fc0c360 0000000000000000 
000000000000c360
[  144.871094]  ffff88003e1ee0c0 ffff88003e1f0010 ffff88003e1f1e10 
ffffffff81611e18
[  144.871096]  0000000000000000 ffff88003fc0c360 ffff88003e1f1e20 
ffffffff81612419
[  144.871097] Call Trace:
[  144.871102]  [<ffffffff81611e18>] rt_spin_lock_slowunlock+0x28/0xa0
[  144.871105]  [<ffffffff81612419>] rt_spin_unlock+0x29/0x40
[  144.871108]  [<ffffffff81064515>] __thread_do_softirq+0xe5/0x150
[  144.871110]  [<ffffffff81064669>] run_ksoftirqd+0xe9/0x1e0
[  144.871112]  [<ffffffff81064580>] ? __thread_do_softirq+0x150/0x150
[  144.871114]  [<ffffffff81064580>] ? __thread_do_softirq+0x150/0x150
[  144.871117]  [<ffffffff8108092e>] kthread+0x9e/0xb0
[  144.871119]  [<ffffffff8108e4f9>] ? finish_task_switch+0x49/0xf0
[  144.871122]  [<ffffffff8161b064>] kernel_thread_helper+0x4/0x10
[  144.871124]  [<ffffffff81612b7c>] ? retint_restore_args+0x5/0x6
[  144.871126]  [<ffffffff8161b060>] ? gs_change+0x13/0x13
[  144.871127] Code: c0 0f b6 c0 48 89 43 18 e8 a6 73 55 00 4c 89 ef e8 
4e ff ff ff 48 8b 5d d8 4c 8b 65 e0 4c 8b 6d e8 4c 8b 75 f0 \
4c 8b 7d f8 c9 c3 <0f> 0b eb fe 0f 1f 40 00 55 48 89 e5 66 83 07 01 bf 
01 00 00 00
[  144.871140] RIP  [<ffffffff810bb538>] wakeup_next_waiter+0x98/0xa0
[  144.871142]  RSP <ffff88003e1f1dc0>
