From: John Keeping <john@metanate.com>
Subject: Lockdep splat from destroy_workqueue() with RT_PREEMPT_FULL
Date: Thu, 8 Dec 2016 12:20:28 +0000
Message-ID: <20161208122028.18e7b9e1.john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dougal.metanate.com ([90.155.101.14]:21862 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932184AbcLHMqo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Dec 2016 07:46:44 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am seeing the following splat when stopping btattach on v4.4.30-rt41
with PREEMPT_RT_FULL with lockdep and slub_debug.

The bad unlock balance seems to just be an effect of the lock having
been overwritten with POISON_FREE, the real issue is that
put_pwq_unlocked() is not resuming and unlocking the pool before the RCU
work scheduled indirectly by put_pwq() has completed.

Please let me know if there's anything I can do to help debug this.


=====================================
[ BUG: bad unlock balance detected! ]
4.4.30-rt41 #51 Tainted: G        W      
-------------------------------------
btattach/345 is trying to release lock (
Unable to handle kernel paging request at virtual address 6b6b6bbb
pgd = c0004000
[6b6b6bbb] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 345 Comm: btattach Tainted: G        W       4.4.30-rt41 #51
Hardware name: Rockchip (Device Tree)
task: ec4f1d80 ti: ec77a000 task.ti: ec77a000
PC is at print_lockdep_cache+0x14/0x68
LR is at print_unlock_imbalance_bug+0x74/0xe4
pc : [<c01c4cb8>]    lr : [<c0167118>]    psr: 60070193
sp : ec77bc90  ip : ec77bd30  fp : ec77bd2c
r10: ec4f23a8  r9 : 6b6b6baf  r8 : c171c434
r7 : 00000003  r6 : 6b6b6baf  r5 : c0138954  r4 : ec4f1d80
r3 : c0d07348  r2 : dc8ba61e  r1 : c0a87a46  r0 : 6b6b6baf
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 2c48806a  DAC: 00000051
Process btattach (pid: 345, stack limit = 0xec77a210)
Stack: (0xec77bc90 to 0xec77c000)
bc80:                                     c171c054 00000025 c01742dc c0174304
bca0: 00000000 00000000 00000000 00000000 ec77bcd4 c0d07348 c01742dc c0a7b60b
bcc0: 00000003 c171c434 6b6b6baf ec4f23a8 ec77bcf4 ec77bce0 c0174304 c0173c24
bce0: c0a7b60b ec77bd24 ec77bd1c ec77bcf8 c01c4fb4 c01742e8 ec77bd24 dc8ba61e
bd00: c0a7b2b4 ec4f1d80 c0138954 6b6b6baf ec77bd4c ec77bd30 c0167110 ec4f1d80
bd20: ec77bd4c ec77bd30 c0167118 c01c4cb0 ec4f23a8 ffffffff ec4f1d80 00000003
bd40: ec77bda4 ec77bd50 c016b734 c01670b0 c0d07dc8 00000001 ec77bd74 ec77bd68
bd60: c035cbe4 c035ca78 ec4f23a8 60070113 00000002 c0138954 c0d073f4 6b6b6b6b
bd80: eef4a8dc c0d07dc8 ee51dc00 ece620c8 00000000 00000001 ec77bdbc ec77bda8
bda0: c0804844 c016b5ac c0c4b8dc eef4a8dc ec77bddc ec77bdc0 c0138954 c0804830
bdc0: 00000000 ec4d8840 ec4d8850 c0d542e6 ec77bdfc ec77bde0 c0138b2c c01388bc
bde0: ece620c0 00000000 ece62cc8 c0d63a58 ec77be2c ec77be00 c078e1ac c01389d4
be00: ece620c0 ec5e6918 ec6b1400 ece620c0 ec5e6918 00000001 00000000 ece91d40
be20: ec77be44 ec77be30 c054f658 c078e098 ec5e6900 ec70d700 ec77be5c ec77be48
be40: c03a2be8 c054f5d4 ec5e6900 ec5e6900 ec77be74 ec77be60 c03a2cb4 c03a2ba4
be60: 00000000 ec5e6900 ec77be94 ec77be78 c03a3528 c03a2ca8 ec5e6900 00000000
be80: 00000000 00000001 ec77bedc ec77be98 c039cd68 c03a3434 ec4f1d80 ec4f22d8
bea0: ec5e6d24 ec5e6cd0 ec5e6bfc ec5e6bfc c035cbe4 ece91d40 edfcc448 00000000
bec0: ee03c990 ee4cefd0 00000008 ece91d48 ec77bf14 ec77bee0 c020cc08 c039c9b8
bee0: 00000000 00000000 ec4f22d8 ec4f1d80 ecee5200 c0d6c088 ec77bf54 ec79c088
bf00: 00000000 00000000 ec77bf24 ec77bf18 c020cd3c c020cb34 ec77bf44 ec77bf28
bf20: c013e0d4 c020cd38 ec4f1d80 ec79c000 ec4f22d8 ec77bf54 ec77bf74 ec77bf48
bf40: c0121754 c013e03c ecee5200 c0d07348 c0d07348 ecee5200 b6fb6000 dc8ba61e
bf60: ec77bfa4 000000f8 ec77bf94 ec77bf78 c0122ff8 c0121354 00000001 00000000
bf80: b6f83764 000000f8 ec77bfa4 ec77bf98 c0123080 c0122fb0 00000000 ec77bfa8
bfa0: c0108120 c0123074 00000001 00000000 00000000 00000000 00000000 00000000
bfc0: 00000001 00000000 b6f83764 000000f8 b6f860b4 00000000 b6fba000 00000000
bfe0: fbad2887 befd4d3c b6e72a90 b6ee3ee0 600d0010 00000000 5a5a5a5a 5a5a5a5a
Backtrace: 
[<c01c4ca4>] (print_lockdep_cache) from [<c0167118>] (print_unlock_imbalance_bug+0x74/0xe4)
 r4:ec4f1d80
[<c01670a4>] (print_unlock_imbalance_bug) from [<c016b734>] (lock_release+0x194/0x338)
 r7:00000003 r6:ec4f1d80 r5:ffffffff r4:ec4f23a8
[<c016b5a0>] (lock_release) from [<c0804844>] (rt_spin_unlock+0x20/0x30)
 r10:00000001 r9:00000000 r8:ece620c8 r7:ee51dc00 r6:c0d07dc8 r5:eef4a8dc
 r4:6b6b6b6b
[<c0804824>] (rt_spin_unlock) from [<c0138954>] (put_pwq_unlocked+0xa4/0x118)
 r5:eef4a8dc r4:c0c4b8dc
[<c01388b0>] (put_pwq_unlocked) from [<c0138b2c>] (destroy_workqueue+0x164/0x1b0)
 r7:c0d542e6 r6:ec4d8850 r5:ec4d8840 r4:00000000
[<c01389c8>] (destroy_workqueue) from [<c078e1ac>] (hci_unregister_dev+0x120/0x21c)
 r7:c0d63a58 r6:ece62cc8 r5:00000000 r4:ece620c0
[<c078e08c>] (hci_unregister_dev) from [<c054f658>] (hci_uart_tty_close+0x90/0xbc)
 r9:ece91d40 r8:00000000 r7:00000001 r6:ec5e6918 r5:ece620c0 r4:ec6b1400
[<c054f5c8>] (hci_uart_tty_close) from [<c03a2be8>] (tty_ldisc_close+0x50/0x58)
 r5:ec70d700 r4:ec5e6900
[<c03a2b98>] (tty_ldisc_close) from [<c03a2cb4>] (tty_ldisc_kill+0x18/0x78)
 r5:ec5e6900 r4:ec5e6900
[<c03a2c9c>] (tty_ldisc_kill) from [<c03a3528>] (tty_ldisc_release+0x100/0x134)
 r5:ec5e6900 r4:00000000
[<c03a3428>] (tty_ldisc_release) from [<c039cd68>] (tty_release+0x3bc/0x460)
 r7:00000001 r6:00000000 r5:00000000 r4:ec5e6900
[<c039c9ac>] (tty_release) from [<c020cc08>] (__fput+0xe0/0x1b4)
 r10:ece91d48 r9:00000008 r8:ee4cefd0 r7:ee03c990 r6:00000000 r5:edfcc448
 r4:ece91d40
[<c020cb28>] (__fput) from [<c020cd3c>] (____fput+0x10/0x14)
 r10:00000000 r9:00000000 r8:ec79c088 r7:ec77bf54 r6:c0d6c088 r5:ecee5200
 r4:ec4f1d80
[<c020cd2c>] (____fput) from [<c013e0d4>] (task_work_run+0xa4/0xb8)
[<c013e030>] (task_work_run) from [<c0121754>] (do_exit+0x40c/0x8b0)
 r7:ec77bf54 r6:ec4f22d8 r5:ec79c000 r4:ec4f1d80
[<c0121348>] (do_exit) from [<c0122ff8>] (do_group_exit+0x54/0xc4)
 r7:000000f8

