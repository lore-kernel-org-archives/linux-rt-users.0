From: tstone@vlsi.informatik.tu-darmstadt.de (Tim Sander)
Subject: Ooops 805 2.6.31.12-rt20
Date: Wed, 27 Jan 2010 15:09:02 +0100 (CET)
Message-ID: <20100127140902.8EDEBE967@iss1.vlsi.informatik.tu-darmstadt.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx503.hrz.tu-darmstadt.de ([130.83.156.232]:58770 "EHLO
	lnx503.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754719Ab0A0OOd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jan 2010 09:14:33 -0500
Received: from iss1.vlsi.informatik.tu-darmstadt.de (iss1.vlsi.informatik.tu-darmstadt.de [130.83.164.1])
	by lnx503.hrz.tu-darmstadt.de (8.14.2/8.14.2/HRZ/PMX) with ESMTP id o0RE92u2029194
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Jan 2010 15:09:02 +0100
	(envelope-from tstone@vlsi.informatik.tu-darmstadt.de)
Received: from localhost (localhost [127.0.0.1])
	by iss1.vlsi.informatik.tu-darmstadt.de (Postfix) with ESMTP id A86E8E9F3
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Jan 2010 15:09:02 +0100 (CET)
Received: from iss1.vlsi.informatik.tu-darmstadt.de ([127.0.0.1])
	by localhost (iss1.vlsi.informatik.tu-darmstadt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ssv0cKtvh0si for <linux-rt-users@vger.kernel.org>;
	Wed, 27 Jan 2010 15:09:02 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I have just tested the newest RT Kernel. It gives me an oops:
FEC Ethernet Driver
kernel BUG at kernel/rtmutex.c:807!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 805 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.31.12-rt20-00001-g36e2ecd #1)
PC is at __bug+0x1c/0x28
LR is at __bug+0x18/0x28
pc : [<c00231d0>]    lr : [<c00231cc>]    psr: 00000093
sp : c784bef0  ip : c784be30  fp : 00000002
r10: c79cfc24  r9 : c02e2074  r8 : c030e7f4
r7 : 40000013  r6 : c0188624  r5 : c784a000  r4 : 600e0000
r3 : 00000000  r2 : 00000001  r1 : c784a000  r0 : 0000002a
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 80004008  DAC: 00000017
Process irq/57-fec (pid: 115, stack limit = 0xc784a268)
Stack: (0xc784bef0 to 0xc784c000)
bee0:                                     c022ef38 c022f134 00000000 40000013
bf00: ffffffff c784bf10 c022f0d4 c0030704 c0031a3c c00317f4 c78c2840 c02de460
bf20: 00000073 00000001 00000000 c784bf38 c005b4fc 600e0000 c79cf800 c0188624
bf40: c79cfc24 c030e7f4 c02e2074 c030e7f8 00000002 c01887ac c030e704 c79cfb20
bf60: c79cf800 c79cfc24 c030e7f4 c0189144 c02e2030 c02e206c c790a760 c784a000
bf80: c02e2030 c790a788 c02e208c c0061110 00000000 00000032 c784bfbc c781de4c
bfa0: c790a760 c0060fdc 00000000 00000000 00000000 00000000 00000000 c004ad68
bfc0: 00000000 00000000 c784bfc8 c784bfc8 c784bfd0 c784bfd0 00000000 00000000
bfe0: c784bfe0 c784bfe0 00000000 00000000 00000000 c00208b4 cfee7cd4 8fcd69f9
[<c00231d0>] (__bug+0x1c/0x28) from [<c022f134>] (rt_spin_lock_slowlock+0x220/0x234)
[<c022f134>] (rt_spin_lock_slowlock+0x220/0x234) from [<c01887ac>] (mii_queue+0x20/0xb4)
[<c01887ac>] (mii_queue+0x20/0xb4) from [<c0189144>] (fec_enet_interrupt+0x84/0x104)
[<c0189144>] (fec_enet_interrupt+0x84/0x104) from [<c0061110>] (irq_thread+0x134/0x1c0)
[<c0061110>] (irq_thread+0x134/0x1c0) from [<c004ad68>] (kthread+0x7c/0x84)
[<c004ad68>] (kthread+0x7c/0x84) from [<c00208b4>] (kernel_thread_exit+0x0/0x8)
Code: e1a01000 e59f000c eb08299b e3a03000 (e5833000)
---[ end trace 7ce2cf1764dda59d ]---
exiting task "irq/57-fec" (115) is an active IRQ thread (irq 57)
note: irq/57-fec[115] exited with preempt_count 1
physmap platform flash device: 02000000 at a0000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank


...
and later than
------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:250 dev_watchdog+0x288/0x2a8()
NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
Modules linked in:
[<c002492c>] (unwind_backtrace+0x0/0xe4) from [<c0035ea8>] (warn_slowpath_common+0x4c/0x80)
[<c0035ea8>] (warn_slowpath_common+0x4c/0x80) from [<c0035f18>] (warn_slowpath_fmt+0x28/0x38)
[<c0035f18>] (warn_slowpath_fmt+0x28/0x38) from [<c01c8e58>] (dev_watchdog+0x288/0x2a8)
[<c01c8e58>] (dev_watchdog+0x288/0x2a8) from [<c0040350>] (run_timer_softirq+0x160/0x280)
[<c0040350>] (run_timer_softirq+0x160/0x280) from [<c003b32c>] (ksoftirqd+0x11c/0x224)
[<c003b32c>] (ksoftirqd+0x11c/0x224) from [<c004ad68>] (kthread+0x7c/0x84)
[<c004ad68>] (kthread+0x7c/0x84) from [<c00208b4>] (kernel_thread_exit+0x0/0x8)
---[ end trace 7ce2cf1764dda59f ]---

it seems as if the FEC ethernet driver of the phycore pcm043 freescale imx35 is unhappy.
If there is an easy way to test this i would give it a try.

Best regards
Tim
