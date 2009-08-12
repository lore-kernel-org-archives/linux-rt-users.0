From: taejin kim <tj7.kim@gmail.com>
Subject: 2.6.29.6-rt23 - Locking API testsuite Fail
Date: Wed, 12 Aug 2009 11:39:40 +0900
Message-ID: <ce93db530908111939k45c052eahb18e0ef59e4fa250@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:63771 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZHLCjj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Aug 2009 22:39:39 -0400
Received: by yxe5 with SMTP id 5so5305062yxe.33
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Aug 2009 19:39:40 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello.
I found the CONFIG_DEBUG_LOCKING_API_SELFTESTS hangs at (double
unlock)-(rlock) pair.

The kernel sources are at
www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.6.tar.bz2
rt.et.redhat.com/download/patch-2.6.29.6-rt23.bz2

We ported this kernel to ARM target. And we tested with our modules
which uses kernel semaphore API.
We found some mutex(semaphore) problems. So we activated =93Locking API
test=94option which is in kernel hacking menu.

How can I fix this problem? Is there some patch about this?


Here is log.
------------------------
| Locking API testsuite:
-----------------------------------------------------------------------=
-----
                                 | spin |wlock |rlock |mutex | wsem | r=
sem |
  ---------------------------------------------------------------------=
-----
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  =
ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  =
ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  =
ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  =
ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  =
ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  =
ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  =
ok  |
                    double unlock:  ok  |  ok  |<2>kernel BUG at
kernel/rt.c:257!
Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 805 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.29.6-rt23 #1)
PC is at __bug+0x20/0x2c
LR is at rt_up+0x48/0x64
pc : [<c0020ce0>]    lr : [<c005e7f8>]    psr: 00000153
sp : c021ff40  ip : c021fe58  fp : c021ff4c
r10: 20018e5c  r9 : 4117b362  r8 : 00000001
r7 : 00000002  r6 : 00000001  r5 : 00000000  r4 : c038ee20
r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : 00000022
=46lags: nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 20004008  DAC: 00000017
Process swapper (pid: 0, stack limit =3D 0xc021e268)
Stack: (0xc021ff40 to 0xc0220000)
ff40: c021ff64 c021ff50 c01ab07c c0020ccc c038ee20 c038ee20 c021ff7c c0=
21ff68
ff60: c0104c68 c01ab04c c021ff58 c0104c3c c021ffa4 c021ff80 c0103818 c0=
104c48
ff80: c039727c c0397250 c039727c c038e3e8 c0222550 20018e90 c021ffc4 c0=
21ffa8
ffa0: c0105c48 c01037d4 c01f5e20 c0397250 c039727c c001aee4 c021fff4 c0=
21ffc8
ffc0: c0008a34 c010586c c0008398 00000000 00000000 c001aee4 00000000 00=
c5387d
ffe0: c03972e0 c001b2e8 00000000 c021fff8 20008038 c0008888 00000000 00=
000000
Backtrace:
[<c0020cc0>] (__bug+0x0/0x2c) from [<c01ab07c>] (rt_read_unlock+0x3c/0x=
60)
[<c01ab040>] (rt_read_unlock+0x0/0x60) from [<c0104c68>]
(double_unlock_rlock+0x2c/0x34)
 r4:c038ee20
[<c0104c3c>] (double_unlock_rlock+0x0/0x34) from [<c0103818>]
(dotest+0x50/0x4f8)
 r4:c0104c3c
[<c01037c8>] (dotest+0x0/0x4f8) from [<c0105c48>] (locking_selftest+0x3=
e8/0x8b0)
 r8:20018e90 r7:c0222550 r6:c038e3e8 r5:c039727c r4:c0397250
[<c0105860>] (locking_selftest+0x0/0x8b0) from [<c0008a34>]
(start_kernel+0x1b8/0x308)
 r6:c001aee4 r5:c039727c r4:c0397250
[<c000887c>] (start_kernel+0x0/0x308) from [<20008038>] (0x20008038)
 r6:c001b2e8 r5:c03972e0 r4:00c5387d
Code: e1a01000 e59f000c eb0050a9 e3a03000 (e5833000)
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Attempted to kill the idle task!
[<c0021330>] (dump_stack+0x0/0x14) from [<c0034054>] (panic+0x54/0x130)
[<c0034000>] (panic+0x0/0x130) from [<c003711c>] (do_exit+0x68/0x648)
 r3:00000000 r2:00000001 r1:00000001 r0:c01f41d4
[<c00370b4>] (do_exit+0x0/0x648) from [<c0021230>] (die+0x1ac/0x1fc)
[<c0021084>] (die+0x0/0x1fc) from [<c00234c4>] (__do_kernel_fault+0x6c/=
0x7c)
[<c0023458>] (__do_kernel_fault+0x0/0x7c) from [<c00236fc>]
(do_page_fault+0x228/0x248)
 r7:c021fef8 r6:c0220c80 r5:c022294c r4:ffffffff
[<c00234d4>] (do_page_fault+0x0/0x248) from [<c00237bc>]
(do_translation_fault+0x1c/0x84)
[<c00237a0>] (do_translation_fault+0x0/0x84) from [<c001c23c>]
(do_DataAbort+0x3c/0xa0)
 r6:00000805 r5:c022294c r4:ffffffff
[<c001c200>] (do_DataAbort+0x0/0xa0) from [<c001c9ec>] (__dabt_svc+0x4c=
/0x60)
Exception stack(0xc021fef8 to 0xc021ff40)
fee0:                                                       00000022 00=
000001
ff00: 00000001 00000000 c038ee20 00000000 00000001 00000002 00000001 41=
17b362
ff20: 20018e5c c021ff4c c021fe58 c021ff40 c005e7f8 c0020ce0 00000153 ff=
ffffff
 r8:00000001 r7:00000002 r6:00000001 r5:c021ff2c r4:ffffffff
[<c0020cc0>] (__bug+0x0/0x2c) from [<c01ab07c>] (rt_read_unlock+0x3c/0x=
60)
[<c01ab040>] (rt_read_unlock+0x0/0x60) from [<c0104c68>]
(double_unlock_rlock+0x2c/0x34)
 r4:c038ee20
[<c0104c3c>] (double_unlock_rlock+0x0/0x34) from [<c0103818>]
(dotest+0x50/0x4f8)
 r4:c0104c3c
[<c01037c8>] (dotest+0x0/0x4f8) from [<c0105c48>] (locking_selftest+0x3=
e8/0x8b0)
 r8:20018e90 r7:c0222550 r6:c038e3e8 r5:c039727c r4:c0397250
[<c0105860>] (locking_selftest+0x0/0x8b0) from [<c0008a34>]
(start_kernel+0x1b8/0x308)
 r6:c001aee4 r5:c039727c r4:c0397250
[<c000887c>] (start_kernel+0x0/0x308) from [<20008038>] (0x20008038)
 r6:c001b2e8 r5:c03972e0 r4:00c5387d

Thank you
taejin
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
