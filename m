From: John Kacur <jkacur@redhat.com>
Subject: i915_driver_irq_handler oops
Date: Fri, 10 Jul 2009 13:02:12 +0200
Message-ID: <20090710110212.GA31650@tycho.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:35662 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbZGJLCT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2009 07:02:19 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I noticed the following oops shutting down 2.6.29.5-rt22

Shutting down Avahi daemon: [drm:gm45_get_vblank_counter] *ERROR* trying to
get1
BUG: unable to handle kernel NULL pointer dereference at 0000000000000084
IP: [<ffffffffa05dc661>] i915_driver_irq_handler+0x19a/0x239 [i915]
PGD 0 
Oops: 0000 [#1] PREEMPT SMP 
last sysfs file: /sys/class/backlight/acpi_video0/brightness
CPU 1 
Modules linked in: tun fuse i915 drm i2c_algo_bit ipt_MASQUERADE iptable_nat nf]
Pid: 2889, comm: IRQ-31 Not tainted 2.6.29.5-rt22 #1 2241B48
RIP: 0010:[<ffffffffa05dc661>]  [<ffffffffa05dc661>] i915_driver_irq_handler+0x]
RSP: 0018:ffff88006a909df0  EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88007a00c150
RDX: ffffc20004c91898 RSI: ffffffff813b92d7 RDI: ffff88007a00c128
RBP: ffff88006a909e50 R08: ffff88006a908000 R09: ffff88007b8abf58
R10: 0000000000000005 R11: 9c5eedd40c8df66a R12: ffff88007a00c000
R13: ffff88006f036000 R14: 0000000000440000 R15: 0000000000040206
FS:  0000000000000000(0000) GS:ffff880001040000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000084 CR3: 0000000000201000 CR4: 00000000000026e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process IRQ-31 (pid: 2889, threadinfo ffff88006a908000, task ffff8800792d47c0)
Stack:
 000000000000aec8 ffff88007a00c128 ffff88007a00c0d8 00000040792d4b60
 0000000000000004 00000000a081823b 00000000960534b8 ffff88006e4042c0
 ffff880078dfacc0 ffff880078dfacc0 0000000000000000 000000000000001f
Call Trace:
 [<ffffffff810a521f>] handle_IRQ_event+0xc6/0x1d5
 [<ffffffff810a5c18>] do_irqd+0x182/0x2ee
 [<ffffffff810a5a96>] ? do_irqd+0x0/0x2ee
 [<ffffffff8106a4b1>] kthread+0x61/0xa4
 [<ffffffff8104ad7b>] ? schedule_tail+0x74/0xcc
 [<ffffffff8100d28a>] child_rip+0xa/0x20
 [<ffffffff8106a450>] ? kthread+0x0/0xa4
 [<ffffffff8100d280>] ? child_rip+0x0/0x20
Code: 00 8b 18 49 8b 85 08 05 00 00 48 8b 80 90 02 00 00 48 85 c0 74 21 48 8b 8 
RIP  [<ffffffffa05dc661>] i915_driver_irq_handler+0x19a/0x239 [i915]
 RSP <ffff88006a909df0>
CR2: 0000000000000084
---[ end trace c8f4761e2483b892 ]---

