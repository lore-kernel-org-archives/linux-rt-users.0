From: Thomas Pfaff <tpfaff@pcs.com>
Subject: 2.6.26.8-rt16: oops on Atmel AT91SAM9260-EK when PREEMPT_HARDIRQ is
 disabled
Date: Thu, 19 Feb 2009 13:13:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0902191253020.22561@lxtpfaff.pcs.ditec.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.pcs.de ([145.253.69.50]:33266 "EHLO mail.pcs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbZBSMSn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Feb 2009 07:18:43 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Although it makes no sense to have a realtime patched kernel without 
CONFIG_PREEMPT_HARDIRQ i send this oops for the sake of completeness :

Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = c0004000
[00000004] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.26.8-rt16 #11)
PC is at handle_IRQ_event+0xc0/0x10c
LR is at try_to_wake_up+0x5c/0xa8
pc : [<c00572f4>]    lr : [<c002ae98>]    psr: 00000013
sp : c02dfed8  ip : c02dfe38  fp : c02dff04
r10: 00000040  r9 : 00000015  r8 : 00000001
r7 : 00000001  r6 : c02de000  r5 : 00010000  r4 : 00000000
r3 : 00010000  r2 : c2820000  r1 : 80000093  r0 : 00000001
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 20004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc02de268)
Stack: (0xc02dfed8 to 0xc02e0000)
fec0:                                                       00000100 c02e6358
fee0: c1c6f120 00000015 00000000 2001b98c 41069265 2001b958 c02dff24 c02dff08
ff00: c0058974 c0057244 c02e6358 00000015 c03261c4 00000000 c02dff44 c02dff28
ff20: c001f04c c00588f8 ffffffff fefff000 00000015 c02f91e4 c02dff9c c02dff48
ff40: c001f734 c001f010 00000000 0005317f 0005217f 60000013 c0020b5c c02de000
ff60: c0020b5c c02f91e4 2001b98c 41069265 2001b958 c02dff9c 600000d3 c02dff90
ff80: c0020bb4 c0020bc0 60000013 ffffffff c02dffbc c02dffa0 c0020b24 c0020b6c
ffa0: c031d0c8 c02f91a0 c001cdc0 c02e1ce0 c02dffcc c02dffc0 c02492cc c0020ae4
ffc0: c02dfff4 c02dffd0 c0008b54 c0249274 c0008668 00000000 00000000 c001cdc4
ffe0: 00053175 c02f92a8 00000000 c02dfff8 20008034 c0008934 00000000 00000000
Backtrace:
[<c0057234>] (handle_IRQ_event+0x0/0x10c) from [<c0058974>] (handle_level_irq+0x8c/0x124)
[<c00588e8>] (handle_level_irq+0x0/0x124) from [<c001f04c>] (__exception_text_start+0x4c/0x70)
 r7:00000000 r6:c03261c4 r5:00000015 r4:c02e6358
[<c001f000>] (__exception_text_start+0x0/0x70) from [<c001f734>] (__irq_svc+0x34/0x60)
Exception stack(0xc02dff48 to 0xc02dff90)
ff40:                   00000000 0005317f 0005217f 60000013 c0020b5c c02de000
ff60: c0020b5c c02f91e4 2001b98c 41069265 2001b958 c02dff9c 600000d3 c02dff90
ff80: c0020bb4 c0020bc0 60000013 ffffffff
 r7:c02f91e4 r6:00000015 r5:fefff000 r4:ffffffff
[<c0020b5c>] (default_idle+0x0/0x6c) from [<c0020b24>] (cpu_idle+0x50/0x88)
[<c0020ad4>] (cpu_idle+0x0/0x88) from [<c02492cc>] (rest_init+0x68/0x80)
 r7:c02e1ce0 r6:c001cdc0 r5:c02f91a0 r4:c031d0c8
[<c0249264>] (rest_init+0x0/0x80) from [<c0008b54>] (start_kernel+0x230/0x2a0)
[<c0008924>] (start_kernel+0x0/0x2a0) from [<20008034>] (0x20008034)
 r5:c02f92a8 r4:00053175
Code: e10f3000 e3c33080 e121f003 eaffffdd (e5943004)
Kernel panic - not syncing: Fatal exception in interrupt
[<c024a7dc>] (dump_stack+0x0/0x14) from [<c024a83c>] (panic+0x4c/0x128)
[<c024a7f0>] (panic+0x0/0x128) from [<c00235f0>] (die+0x24c/0x2ac)
 r3:00010000 r2:00000000 r1:c02f9bc0 r0:c02a2838
[<c00233a4>] (die+0x0/0x2ac) from [<c0024a1c>] (__do_kernel_fault+0x6c/0x7c)
[<c00249b0>] (__do_kernel_fault+0x0/0x7c) from [<c0024a9c>] (do_page_fault+0x70/0x264)
 r7:c02dfe90 r6:00000004 r5:00000000 r4:c02e1078
[<c0024a2c>] (do_page_fault+0x0/0x264) from [<c0024d98>] (do_translation_fault+0x78/0x80)
[<c0024d20>] (do_translation_fault+0x0/0x80) from [<c001f1f8>] (do_DataAbort+0x3c/0xa0)
 r7:c02e1f10 r6:00000005 r5:c02dfec4 r4:c02e1ec0
[<c001f1bc>] (do_DataAbort+0x0/0xa0) from [<c001f6ec>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc02dfe90 to 0xc02dfed8)
fe80:                                     00000001 80000093 c2820000 00010000
fea0: 00000000 00010000 c02de000 00000001 00000001 00000015 00000040 c02dff04
fec0: c02dfe38 c02dfed8 c002ae98 c00572f4 00000013 ffffffff
[<c0057234>] (handle_IRQ_event+0x0/0x10c) from [<c0058974>] (handle_level_irq+0x8c/0x124)
[<c00588e8>] (handle_level_irq+0x0/0x124) from [<c001f04c>] (__exception_text_start+0x4c/0x70)
 r7:00000000 r6:c03261c4 r5:00000015 r4:c02e6358
[<c001f000>] (__exception_text_start+0x0/0x70) from [<c001f734>] (__irq_svc+0x34/0x60)
Exception stack(0xc02dff48 to 0xc02dff90)
ff40:                   00000000 0005317f 0005217f 60000013 c0020b5c c02de000
ff60: c0020b5c c02f91e4 2001b98c 41069265 2001b958 c02dff9c 600000d3 c02dff90
ff80: c0020bb4 c0020bc0 60000013 ffffffff
 r7:c02f91e4 r6:00000015 r5:fefff000 r4:ffffffff
[<c0020b5c>] (default_idle+0x0/0x6c) from [<c0020b24>] (cpu_idle+0x50/0x88)
[<c0020ad4>] (cpu_idle+0x0/0x88) from [<c02492cc>] (rest_init+0x68/0x80)
 r7:c02e1ce0 r6:c001cdc0 r5:c02f91a0 r4:c031d0c8
[<c0249264>] (rest_init+0x0/0x80) from [<c0008b54>] (start_kernel+0x230/0x2a0)
[<c0008924>] (start_kernel+0x0/0x2a0) from [<20008034>] (0x20008034)
 r5:c02f92a8 r4:00053175
