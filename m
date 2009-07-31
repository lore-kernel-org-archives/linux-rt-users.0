From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: 2.6.31-rc4-rt1: BUG: unable to handle kernel NULL pointer
	dereference at 0000006
Date: Thu, 30 Jul 2009 23:29:01 -0300
Message-ID: <20090731022901.GG22657@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:58497 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZGaC3M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jul 2009 22:29:12 -0400
Received: by qyk34 with SMTP id 34so1307755qyk.33
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jul 2009 19:29:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I was booting my brand new 2.6.31-rc4-rt1 kernel to impress some friends and
stumbled over this nasty BUG message:

Starting autofs:  Loading autofs4: 
BUG: unable to handle kernel NULL pointer dereference at 0000006
IP: [<ffffffff811ff47c>] strcmp+0x1b/0x46
PGD 794bd067 PUD 77578067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP 
last sysfs file: /sys/class/misc/rfkill/dev
CPU 1 
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth rfkill sunrpc nf_conntrack_netbios_ns ipt_R]
Pid: 19, comm: sirq-timer/1 Not tainted 2.6.31-rc4-rt1 #2 8810A56
RIP: 0010:[<ffffffff811ff47c>]  [<ffffffff811ff47c>] strcmp+0x1b/0x46
RSP: 0018:ffff88007e88b760  EFLAGS: 00010046
RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffffffff819d2020
RDX: ffffffff819d1e26 RSI: 0000000000000006 RDI: ffffffff815467a2
RBP: ffff88007e88b770 R08: ffffffff81a28b60 R09: 0000000000000006
R10: 0000000000000000 R11: ffffffff81db3020 R12: ffff8800045ac580
R13: ffffffff81a28b50 R14: 0000000000056d30 R15: ffffffff81db3020
FS:  0000000000000000(0000) GS:ffff8800043da000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000006 CR3: 00000000779d3000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process sirq-timer/1 (pid: 19, threadinfo ffff88007e88a000, task ffff88007e88c4c0)
Stack:
 ffff8800045ac580 00000000a1159f0c ffff88007e88b810 ffffffff81086203
<0> 0000000000000006 ffffffff81a28b60 ffffffff81db3020 ffff880000000000
<0> ffffffff819d1e20 ffffffff819d2020 ffff8800045ac580 00000000a1159f0c
Call Trace:
 [<ffffffff81086203>] register_lock_class+0x245/0x351
 [<ffffffffa036dcec>] ? ip6t_do_table+0xbf/0x65b [ip6_tables]
 [<ffffffff810875d3>] __lock_acquire+0xac/0x3d3
 [<ffffffffa036dcec>] ? ip6t_do_table+0xbf/0x65b [ip6_tables]
 [<ffffffff81087c9c>] lock_acquire+0x104/0x13d
 [<ffffffffa036dcec>] ? ip6t_do_table+0xbf/0x65b [ip6_tables]
 [<ffffffffa03284dc>] ? dst_output+0x0/0x39 [ipv6]
 [<ffffffff813e6c7e>] rt_spin_lock+0x45/0x60
 [<ffffffffa036dcec>] ? ip6t_do_table+0xbf/0x65b [ip6_tables]
 [<ffffffffa036dcec>] ip6t_do_table+0xbf/0x65b [ip6_tables]
 [<ffffffff810876ec>] ? __lock_acquire+0x1c5/0x3d3
 [<ffffffff81088156>] ? put_lock_stats+0x3b/0x5a
 [<ffffffffa03284dc>] ? dst_output+0x0/0x39 [ipv6]
 [<ffffffffa03760d9>] ip6t_local_out_hook+0x37/0x52 [ip6table_filter]
 [<ffffffff81357f7c>] nf_iterate+0x5c/0xb3
 [<ffffffffa03284dc>] ? dst_output+0x0/0x39 [ipv6]
 [<ffffffff81358060>] nf_hook_slow+0x8d/0x109
 [<ffffffffa03284dc>] ? dst_output+0x0/0x39 [ipv6]
 [<ffffffffa032af3b>] mld_sendpack+0x2c7/0x4a2 [ipv6]
 [<ffffffff810882bf>] ? lock_release_holdtime+0x14a/0x165
 [<ffffffffa032b75a>] mld_ifc_timer_expire+0x255/0x2ab [ipv6]
 [<ffffffff810640e6>] ? run_timer_softirq+0x234/0x397
 [<ffffffffa032b505>] ? mld_ifc_timer_expire+0x0/0x2ab [ipv6]
 [<ffffffff8106415d>] run_timer_softirq+0x2ab/0x397
 [<ffffffff810640e6>] ? run_timer_softirq+0x234/0x397
 [<ffffffff8105ee36>] ksoftirqd+0x16e/0x2a0
 [<ffffffff8105ecc8>] ? ksoftirqd+0x0/0x2a0
 [<ffffffff810735ab>] kthread+0xa8/0xb0
 [<ffffffff8100d1da>] child_rip+0xa/0x20
 [<ffffffff81073503>] ? kthread+0x0/0xb0
 [<ffffffff8100d1d0>] ? child_rip+0x0/0x20
Code: 33 14 25 28 00 00 00 74 05 e8 fa 77 e5 ff c9 c3 55 48 89 e5 48 83 ec 10 65 48 8b 04 25 28 00 
RIP  [<ffffffff811ff47c>] strcmp+0x1b/0x46
 RSP <ffff88007e88b760>
CR2: 0000000000000006
---[ end trace 0c5a17dc9397339f ]---
NOHZ: local_softirq_pending 02
[  OK  ]
Starting automount: NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02


I remember seeing these last bits about local_softirq_pending in the list
few weeks ago. I intend to check the other BUG message but decided posting
to the list just in case someone is suffering from insomnia...

Cheers,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

