From: Bo Hansen <bh@newtec.dk>
Subject: hrtimer problem on AT91RM9200
Date: Wed, 19 Aug 2009 14:24:41 +0200
Message-ID: <4A8BEF09.2080300@newtec.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010208050509050505050703"
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:56317 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbZHSMYm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Aug 2009 08:24:42 -0400
Received: from [192.168.0.120] (unknown [93.165.103.94])
	by pasmtpB.tele.dk (Postfix) with ESMTP id C7782E306BF
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Aug 2009 14:24:41 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010208050509050505050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have tested 2.6.29.6 with/without rt23 and 2.6.31-rc6 with/without rt2,
but I keep getting kernel panics sometimes soon after I start cyclictest 
(v0.5),
but sometimes it runs for hours without problems.

I have tested with different options and the only one making a
difference is disabling high resolution timers. Whenever this is disabled
(RT patch or not) the system does not panic. This of course does not
make the latency as good as I would like it to be.

A kernel panic from both an RT and non-RT kernel with high resolution
timer has been attached. The source seems to vary from time to time.

I noticed than when I stress the system I sometimes get the
following message:
hrtimer: interrupt too slow, forcing clock min delta to 52482 ns

And often (but no always) the system panics a little while later. I guess
it tells the system is too busy? but should it really end in a kernel
panic? Using the RT patch I understand as we can set the priority
as we like and stall the system completely, but on a non-RT kernel this
should not be possible?

Any thoughts on how to proceed?


Thanks in advance,
Bo

--------------010208050509050505050703
Content-Type: text/plain;
 name="190809_kernel_panic_2.6.29.6-highres_2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="190809_kernel_panic_2.6.29.6-highres_2"

hrtimer: interrupt too slow, forcing clock min delta to 52482 ns
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c3a8c000
[00000000] *pgd=23a27031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.29.6 #1)
PC is at clkevt32k_next_event+0x70/0xac
LR is at clockevents_program_event+0xfc/0x168
pc : [<c002fb90>]    lr : [<c005687c>]    psr: 60000093
sp : c3a35ca0  ip : c3a35cc0  fp : c3a35cbc
r10: 00000000  r9 : 00000000  r8 : c02da8a8
r7 : 00000041  r6 : 00000000  r5 : 00000001  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : c02da8a8  r0 : 00000001
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: c000717f  Table: 23a8c000  DAC: 00000015
Process cyclictest (pid: 498, stack limit = 0xc3a34268)
Stack: (0xc3a35ca0 to 0xc3a36000)
5ca0: 00000041 00000000 000225c1 00000000 c3a35ce4 c3a35cc0 c005687c c002fb30 
5cc0: 00000041 23cc4bf5 00000041 23cbf12f 00000041 c02da8a8 c3a35d34 c3a35ce8 
5ce0: c00572b8 c0056790 23cbf12f 00000041 c02f8620 c3a34000 c3a35d2c c3a35d08 
5d00: 23cbf12f 00000041 c004f9e0 23cc4bf5 00000041 00000041 00000000 00000000 
5d20: c02dd1f8 c02dd1f8 c3a35d54 c3a35d38 c005735c c00571fc 00000001 c02da8a8 
5d40: c02dd1c8 23cbde68 c3a35db4 c3a35d58 c004fc04 c005733c c00572b8 c02da8a8 
5d60: 23cbde68 00000041 23cc4bf5 00000041 00000000 00000001 23cbde68 00000041 
5d80: c3a35d9c 23cc4bf5 00000041 c02da888 00000000 00000001 00000000 c02f10f8 
5da0: c02f8620 c3a34000 c3a35dd4 c3a35db8 c002fc80 c004fa34 c02dd1c8 c02da888 
5dc0: 00000000 00000001 c3a35df4 c3a35dd8 c005f604 c002fbdc c02dd754 00000001 
5de0: 00000000 c38165e0 c3a35e0c c3a35df8 c0061130 c005f5d0 00000001 c02faab8 
5e00: c3a35e2c c3a35e10 c002606c c00610c0 c3a35e34 ffffffff fefff000 00000001 
5e20: c3a35ea4 c3a35e30 c00269a8 c0026010 c02f0b64 00000002 c3946000 4a96e930 
5e40: c394601c c3816e20 00000015 c38165e0 c02f10f8 c02f8620 c3a34000 c3a35ea4 
5e60: c3a34044 c3a35e78 c0026d00 c0050a80 a0000013 ffffffff c3a35e9c 7fffffff 
5e80: 7fffffff c3a34000 00000000 c3a35f78 c3a34000 c3a35ef0 c3a35edc c3a35ea8 
5ea0: c023cd54 c023c868 00000000 60000093 60000093 60000013 0000000e 7fffffff 
5ec0: 7fffffff 00000000 c3a34000 00000000 c3a35eec c3a35ee0 c023cde0 c023ccd4 
5ee0: c3a35fa4 c3a35ef0 c004437c c023cdcc 0000000e 00000000 0001fffe 00000011 
5f00: c3a35f4c c3a35f10 c0053fd0 c01b4b58 00000000 00000000 c3a35f88 0000419e 
5f20: 00000000 0000419e c3a35f88 c02f7400 c02f73e0 c02f73e0 c3a34000 000172f4 
5f40: c3a35f74 c3a35f50 c004f9e0 c003aeb4 00000000 c3a35f88 4916ddf4 40029770 
5f60: 00000107 4916ddf4 40029770 00000107 c0026ec4 4916ddf4 ffffdfff ffffffff 
5f80: 4916ddfc 00000000 4916ddfc 000000b1 c0026ec4 40040000 00000000 c3a35fa8 
5fa0: c0026d40 c00441bc 4916ddfc 00000000 4916dcfc 00000000 00000000 00000008 
5fc0: 4916ddfc 00000000 4916ddfc 000000b1 00017978 00015c60 40040000 4916ddf4 
5fe0: 4916dcfc 4916dbc0 40033904 40033864 60000010 4916dcfc 00000000 00000000 
Backtrace: 
[<c002fb20>] (clkevt32k_next_event+0x0/0xac) from [<c005687c>] (clockevents_program_e)
 r6:00000000 r5:000225c1 r4:00000000
[<c0056780>] (clockevents_program_event+0x0/0x168) from [<c00572b8>] (tick_dev_progra)
 r8:c02da8a8 r7:00000041 r6:23cbf12f r5:00000041 r4:23cc4bf5
[<c00571ec>] (tick_dev_program_event+0x0/0xf8) from [<c005735c>] (tick_program_event+)
[<c005732c>] (tick_program_event+0x0/0x3c) from [<c004fc04>] (hrtimer_interrupt+0x1e0)
 r5:23cbde68 r4:c02dd1c8
[<c004fa24>] (hrtimer_interrupt+0x0/0x284) from [<c002fc80>] (at91rm9200_timer_interr)
[<c002fbcc>] (at91rm9200_timer_interrupt+0x0/0xc8) from [<c005f604>] (handle_IRQ_even)
 r6:00000001 r5:00000000 r4:c02da888
[<c005f5c0>] (handle_IRQ_event+0x0/0x80) from [<c0061130>] (handle_level_irq+0x80/0x1)
 r7:c38165e0 r6:00000000 r5:00000001 r4:c02dd754
[<c00610b0>] (handle_level_irq+0x0/0x11c) from [<c002606c>] (__exception_text_start+0)
 r5:c02faab8 r4:00000001
[<c0026000>] (__exception_text_start+0x0/0x8c) from [<c00269a8>] (__irq_svc+0x28/0x60)
Exception stack(0xc3a35e30 to 0xc3a35e78)
5e20:                                     c02f0b64 00000002 c3946000 4a96e930 
5e40: c394601c c3816e20 00000015 c38165e0 c02f10f8 c02f8620 c3a34000 c3a35ea4 
5e60: c3a34044 c3a35e78 c0026d00 c0050a80 a0000013 ffffffff                   
 r6:00000001 r5:fefff000 r4:ffffffff
[<c023c858>] (schedule+0x0/0x2ac) from [<c023cd54>] (schedule_timeout+0x90/0xd0)
[<c023ccc4>] (schedule_timeout+0x0/0xd0) from [<c023cde0>] (schedule_timeout_interrup)
 r7:00000000 r6:c3a34000 r5:00000000 r4:7fffffff
[<c023cdbc>] (schedule_timeout_interruptible+0x0/0x28) from [<c004437c>] (sys_rt_sigt)
[<c00441ac>] (sys_rt_sigtimedwait+0x0/0x270) from [<c0026d40>] (ret_fast_syscall+0x0/)
Code: e121f004 e3a00000 e89da878 e3a03000 (e5833000) 
Kernel panic - not syncing: Fatal exception in interrupt


--------------010208050509050505050703
Content-Type: text/plain;
 name="180809_kernel_panic_2.6.29.6-rt23_5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="180809_kernel_panic_2.6.29.6-rt23_5"

Unable to handle kernel NULL pointer dereference at virtual a0
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.29.6-rt23 #1)
PC is at clkevt32k_next_event+0x70/0xac
LR is at clockevents_program_event+0xfc/0x168
pc : [<c002ef88>]    lr : [<c005a1e0>]    psr: 60000093
sp : c02f3d98  ip : c02f3db8  fp : c02f3db4
r10: 00000000  r9 : 00000000  r8 : c02f6a30
r7 : 00000045  r6 : 00000000  r5 : 00000001  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : c02f6a30  r0 : 00000001
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c000717f  Table: 23970000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc02f2270)
Stack: (0xc02f3d98 to 0xc02f4000)
3d80:                                                       2d2c08e3 00000000 
3da0: 000225c1 00000000 c02f3ddc c02f3db8 c005a1e0 c002ef28 00000045 2d484309 
3dc0: 00000045 2d483fe8 00000045 c02f6a30 c02f3e2c c02f3de0 c005aea8 c005a0f4 
3de0: 2d483fe8 00000045 68e2da6f 00000000 00000000 c02f3e70 2d483fe8 00000045 
3e00: 689e360d 2d484309 00000045 00000045 c02f9de0 2d484309 00000045 c02f2000 
3e20: c02f3e4c c02f3e30 c005af4c c005adec 00000001 00000000 c02f9de0 2d48106f 
3e40: c02f3eac c02f3e50 c005215c c005af2c 3fd06258 c02f6a30 2d48106f 00000045 
3e60: 00000001 c02f9de0 00000001 00000000 2d48106f 00000045 00000001 00000000 
3e80: 00000000 c02f6a08 00010002 c02f2000 00000001 00000000 00000000 00000001 
3ea0: c02f3ecc c02f3eb0 c002f078 c0051f28 c385f7a0 c02f6a08 00010002 c02f2000 
3ec0: c02f3efc c02f3ed0 c006513c c002efd4 c02f3ef4 c02fa4f8 c02f2000 c02f6a08 
3ee0: 00000001 00000001 c02f2000 2001fc9c c02f3f1c c02f3f00 c00678dc c00650f8 
3f00: 00000001 c0302d40 00000000 00000002 c02f3f3c c02f3f20 c002506c c00677e8 
3f20: c02f3f54 ffffffff fefff000 00000001 c02f3f94 c02f3f40 c00259dc c0025010 
3f40: 00000000 00000001 c02f2000 60000013 c0026eb0 c02f2000 c02f5eb0 c03104e0 
3f60: 2001fcd0 41129200 2001fc9c c02f3f94 c02f3f98 c02f3f88 c0026ef0 c0026efc 
3f80: 60000013 ffffffff c02f3fb4 c02f3f98 c0026db0 c0026ec0 c02f2000 c031048c 
3fa0: c00222c0 c02f5ce0 c02f3fcc c02f3fb8 c02540dc c0026d70 c031048c c03195fc 
3fc0: c02f3ff4 c02f3fd0 c0008b38 c0254068 c0008594 00000000 00000000 c0021ebc 
3fe0: c0007175 c0310518 00000000 c02f3ff8 20008034 c0008970 00000000 00000000 
Backtrace: 
[<c002ef18>] (clkevt32k_next_event+0x0/0xac) from [<c005a1e0>] (clockevents_pro)
 r6:00000000 r5:000225c1 r4:00000000
[<c005a0e4>] (clockevents_program_event+0x0/0x168) from [<c005aea8>] (tick_dev_)
 r8:c02f6a30 r7:00000045 r6:2d483fe8 r5:00000045 r4:2d484309
[<c005addc>] (tick_dev_program_event+0x0/0xf8) from [<c005af4c>] (tick_program_)
[<c005af1c>] (tick_program_event+0x0/0x3c) from [<c005215c>] (hrtimer_interrupt)
 r5:2d48106f r4:c02f9de0
[<c0051f18>] (hrtimer_interrupt+0x0/0x2e8) from [<c002f078>] (at91rm9200_timer_)
[<c002efc4>] (at91rm9200_timer_interrupt+0x0/0xc8) from [<c006513c>] (handle_IR)
 r6:c02f2000 r5:00010002 r4:c02f6a08
[<c00650e8>] (handle_IRQ_event+0x0/0xec) from [<c00678dc>] (handle_level_irq+0x)
[<c00677d8>] (handle_level_irq+0x0/0x174) from [<c002506c>] (_text+0x6c/0x8c)
 r7:00000002 r6:00000000 r5:c0302d40 r4:00000001
[<c0025000>] (_text+0x0/0x8c) from [<c00259dc>] (__irq_svc+0x3c/0x80)
Exception stack(0xc02f3f40 to 0xc02f3f88)
3f40: 00000000 00000001 c02f2000 60000013 c0026eb0 c02f2000 c02f5eb0 c03104e0 
3f60: 2001fcd0 41129200 2001fc9c c02f3f94 c02f3f98 c02f3f88 c0026ef0 c0026efc 
3f80: 60000013 ffffffff                                                       
 r6:00000001 r5:fefff000 r4:ffffffff
[<c0026eb0>] (default_idle+0x0/0x54) from [<c0026db0>] (cpu_idle+0x50/0xac)
[<c0026d60>] (cpu_idle+0x0/0xac) from [<c02540dc>] (rest_init+0x84/0x9c)
 r7:c02f5ce0 r6:c00222c0 r5:c031048c r4:c02f2000
[<c0254058>] (rest_init+0x0/0x9c) from [<c0008b38>] (start_kernel+0x1d8/0x2c8)
 r4:c03195fc
[<c0008960>] (start_kernel+0x0/0x2c8) from [<20008034>] (0x20008034)
 r5:c0310518 r4:c0007175
Code: e121f004 e3a00000 e89da878 e3a03000 (e5833000) 
Kernel panic - not syncing: Fatal exception in interrupt

--------------010208050509050505050703--
