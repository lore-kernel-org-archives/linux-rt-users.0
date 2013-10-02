From: "Matthias Klein" <matthias.klein@optimeas.de>
Subject: Oops with spin_lock() in an IRQF_NO_THREAD interrupt
Date: Wed, 02 Oct 2013 14:54:00 +0000
Message-ID: <em8d903d65-1a3e-4973-9012-be50c5713bd5@nb-mak>
Reply-To: "Matthias Klein" <matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from optimeas.de ([78.46.18.2]:46968 "EHLO optimeas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928Ab3JBOyB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Oct 2013 10:54:01 -0400
Received: from [127.0.0.1] (ip-5-146-126-105.unitymediagroup.de [5.146.126.105])
	by optimeas.de (Postfix) with ESMTPSA id 16BC8421A2D7
	for <linux-rt-users@vger.kernel.org>; Wed,  2 Oct 2013 16:54:00 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

i am writing a kernel module on a rt kernel where I have an 
IRQF_NO_THREAD interrupt.
For sharing a "write index" between that interrupt and the process 
context (ioctl() etc.) I use a spin_lock for locking.

In the IRQ I use spin_lock() & spin_unlock(), and in the process context 
I use spin_lock_irq() & spin_unlock_irq().

Basically the driver and the test application are working, but after 
some time I get an oops message.

Do I use the right functions for locking ? Do you have a tip why I get 
that oops message ?


Best regards,

Matthias


------------[ cut here ]------------
kernel BUG at kernel/rtmutex.c:737!
Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
Modules linked in: omDriveLog_driver(O) rt5572sta(O) fsl_usb2_udc [last 
unloaded: omDriveLog_driver]
CPU: 0 Tainted: G O (3.4.61-rt77 #1)
PC is at rt_spin_lock_slowlock+0x90/0x268
LR is at rt_spin_lock_slowlock+0x68/0x268
pc : [<c0316ba0>] lr : [<c0316b78>] psr: 60070193
sp : de94fcf0 ip : de94fcf0 fp : de94fd44
r10: 00000001 r9 : de94e000 r8 : 00000000
r7 : 00000024 r6 : dfaa7080 r5 : de94e000 r4 : def7b0c4
r3 : de94e000 r2 : dfaa7080 r1 : dfaa7081 r0 : 00000000
Flags: nZCv IRQs off FIQs on Mode SVC_32 ISA ARM Segment user
Control: 10c5387d Table: 8e828019 DAC: 00000015
Process om::DriverThrea (pid: 652, stack limit = 0xde94e2e8)
Stack: (0xde94fcf0 to 0xde950000)
fce0: 00000000 df82ea98 de94fd14 de94fd08
fd00: c0317100 c0316e1c de94fd34 de94fd18 c01da800 c03170f4 df82ea98 
00000000
fd20: 00000001 00000001 de94fd54 bf0bb670 de94e000 c04665e0 de94fd54 
de94fd48
fd40: c03170c8 c0316b1c de94fd7c de94fd58 bf0ba648 c03170bc de94fda4 
de94fd68
fd60: c006895c dee45600 de94e000 c04665e0 de94fdbc de94fd80 c00687e0 
bf0ba558
fd80: c006c2e0 c04665e0 c0316e40 00000000 de94fdb4 c04665e0 de94e000 
dee45600
fda0: de94fe50 00000020 de94e000 00000001 de94fddc de94fdc0 c0068a3c 
c0068730
fdc0: 00020000 c04665e0 00000000 00000004 de94fdf4 de94fde0 c006b4d8 
c00689e0
fde0: c006b3fc 00000024 de94fe0c de94fdf8 c00680b4 c006b408 00000194 
00000024
fe00: de94fe24 de94fe10 c000f3fc c0068090 00000001 00000000 de94fe4c 
de94fe28
fe20: c00085fc c000f398 c0316e40 60070013 ffffffff de94fe84 dfbf12c8 
b689fc5c
fe40: de94feac de94fe50 c000dfc0 c00085a0 def7b0c4 def7b0c4 00000000 
def7b0c4
fe60: de94e000 bf0bb670 80046f01 00000008 dfbf12c8 de94e000 b689fc5c 
de94feac
fe80: de94feb0 de94fe98 c0317100 c0316e40 60070013 ffffffff 00000058 
b689fc5c
fea0: de94febc de94feb0 c0317100 c0316e1c de94feec de94fec0 bf0ba344 
c03170f4
fec0: 00085f00 538201bd 00000058 0000221b 00000058 b689fc5c ded4bc00 
80046f01
fee0: de94fefc de94fef0 c00d2f94 bf0ba140 de94ff7c de94ff00 c00d3ae4 
c00d2f68
ff00: de94ff00 00000000 00000000 00000000 5559191c 00000058 5559191c 
00000058
ff20: c0042594 c0463490 00000000 de94ff2c de94ff2c 00000001 00000000 
c00fac00
ff40: b689fc88 c00c4ef0 00000001 ded4bc00 de94ff7c b689fc5c ded4bc00 
80046f01
ff60: 00000008 c000e688 de94e000 00000000 de94ffa4 de94ff80 c00d3b7c 
c00d35a4
ff80: c00085fc 00000001 00000000 0113f5d4 be807c14 00000036 00000000 
de94ffa8
ffa0: c000e400 c00d3b44 00000000 0113f5d4 00000008 80046f01 b689fc5c 
00000008
ffc0: 00000000 0113f5d4 be807c14 00000036 b6c2dfcc 0113f5ec 0113f5d5 
b689fc44
ffe0: 00019a84 b689fc34 0000c250 b69fedbc 20070010 00000008 a6742600 
23000000
Backtrace:
[<c0316b10>] (rt_spin_lock_slowlock+0x0/0x268) from [<c03170c8>] 
(rt_spin_lock+0x18/0x1c)
r6:c04665e0 r5:de94e000 r4:bf0bb670
[<c03170b0>] (rt_spin_lock+0x0/0x1c) from [<bf0ba648>] 
(omEcspiInterrupt+0xfc/0x260 [omDriveLog_driver])
[<bf0ba54c>] (omEcspiInterrupt+0x0/0x260 [omDriveLog_driver]) from 
[<c00687e0>] (handle_irq_event_percpu+0xbc/0x2b0)
r6:c04665e0 r5:de94e000 r4:dee45600
[<c0068724>] (handle_irq_event_percpu+0x0/0x2b0) from [<c0068a3c>] 
(handle_irq_event+0x68/0x84)
[<c00689d4>] (handle_irq_event+0x0/0x84) from [<c006b4d8>] 
(handle_level_irq+0xdc/0x114)
r6:00000004 r5:00000000 r4:c04665e0 r3:00020000
[<c006b3fc>] (handle_level_irq+0x0/0x114) from [<c00680b4>] 
(generic_handle_irq+0x30/0x40)
r4:00000024 r3:c006b3fc
[<c0068084>] (generic_handle_irq+0x0/0x40) from [<c000f3fc>] 
(handle_IRQ+0x70/0x94)
r4:00000024 r3:00000194
[<c000f38c>] (handle_IRQ+0x0/0x94) from [<c00085fc>] 
(tzic_handle_irq+0x68/0xa0)
r5:00000000 r4:00000001
[<c0008594>] (tzic_handle_irq+0x0/0xa0) from [<c000dfc0>] 
(__irq_svc+0x40/0x70)
Exception stack(0xde94fe50 to 0xde94fe98)
fe40: def7b0c4 def7b0c4 00000000 def7b0c4
fe60: de94e000 bf0bb670 80046f01 00000008 dfbf12c8 de94e000 b689fc5c 
de94feac
fe80: de94feb0 de94fe98 c0317100 c0316e40 60070013 ffffffff
[<c0316e10>] (rt_spin_lock_slowunlock+0x0/0x98) from [<c0317100>] 
(rt_spin_unlock+0x18/0x1c)
r4:b689fc5c r3:00000058
[<c03170e8>] (rt_spin_unlock+0x0/0x1c) from [<bf0ba344>] 
(omDriverIoctl+0x210/0x418 [omDriveLog_driver])
[<bf0ba134>] (omDriverIoctl+0x0/0x418 [omDriveLog_driver]) from 
[<c00d2f94>] (vfs_ioctl+0x38/0x4c)
r6:80046f01 r5:ded4bc00 r4:b689fc5c
[<c00d2f5c>] (vfs_ioctl+0x0/0x4c) from [<c00d3ae4>] 
(do_vfs_ioctl+0x54c/0x5a0)
[<c00d3598>] (do_vfs_ioctl+0x0/0x5a0) from [<c00d3b7c>] 
(sys_ioctl+0x44/0x70)
[<c00d3b38>] (sys_ioctl+0x0/0x70) from [<c000e400>] 
(ret_fast_syscall+0x0/0x30)
r7:00000036 r6:be807c14 r5:0113f5d4 r4:00000000
Code: e5942008 e3c22001 e1560002 1a000000 (e7f001f2)
---[ end trace 0000000000000002 ]---
Kernel panic - not syncing: Fatal exception in interrupt

