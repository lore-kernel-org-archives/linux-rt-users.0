From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.4-rc6-rt1 PATCH 0/2] ARM: am437x: boot test report
Date: Mon, 28 Dec 2015 20:00:09 +0200
Message-ID: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43664 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbbL1SA0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Dec 2015 13:00:26 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All, Sebastian,

! Merry Christmas and Happy New year !

Sebastian, Thanks alot for this Christmas present.

I was able to test -RT 4.4-rc6-rt1 Kernel on ARM TI am437x-gpevm (UP)
1) UP build is broken, so there are two fixes.

2) I can boot using very minimal rootfs

3) Seems there are some problem with HIGHMEM :(. System crashes if I'm trying
   to run hackbench (see log 1). I can run hackbench only if HIGHMEM is disabled.
   I've also tried to disable CONFIG_CPU_SW_DOMAIN_PAN, CONFIG_ARM_PATCH_PHYS_VIRT,
   and CONFIG_CPUSETS, before disabling HIGHMEM.
   Sorry, I'll not able to investigate it further because of Christmas holidays here.  

4) Could we revert commit 4fa5422 'ARM: OMAP2: Drop the concept of certain power
   domains not being able to lose context.'? It's not required for 4.4-rt wakeup
   and introduces build warnings.

Test1: cyclictest + hackbench
# ./cyclictest -D120s -m -n -Sp98 -q
T: 0 (14999) P:98 I:1000 C: 120000 Min:      3 Act:    4 Avg:    5 Max:      21

Test2: cyclictest + hackbench
T: 0 (  151) P:98 I:1000 C: 120000 Min:      4 Act:   31 Avg:   32 Max:      61


----------- log 1 ----
/ # ./hackbench 
Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
Each sender will pass 100 messages of 100 
[  205.565705] Unable to handle kernel paging request at virtual address ffefe378 
bytes
Unable to handle kernel paging request at virtual address ffefe378
pgd = ee8dc000
[ffefe378] *pgd=afffd861, *pte=00000000, *ppte=00000000
Internal error: Oops: 837 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 111 Comm: hackbench Not tainted 4.4.0-rc6-rt1-00069-g17f26b6-dirty #15
Segmentation fault[  205.574708] Hardware name: Generic AM43 (Flattened Device Tree)
task: ee8e8580 ti: ee92e000 task.ti: ee92e000
PC is at cpu_ca8_set_pte_ext+0x0/0x58
LR is at wp_page_copy+0x1ec/0x3c0
pc : [<c001c8e4>]    lr : [<c00da3a0>]    psr: 00000013
sp : ee92fd68  ip : ee92fd68  fp : ee92fdb4
r10: ffefe378  r9 : ee8a8540  r8 : b6ede000
r7 : 8942734f  r6 : ee8af000  r5 : ef84657c  r4 : ef9369c0
r3 : c001c8e4  r2 : 00000800  r1 : 8942734f  r0 : ffefe378
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: ae8dc059  DAC: 00000055
Process hackbench (pid: 111, stack limit = 0xee92e210)
Stack: (0xee92fd68 to 0xee930000)
fd60:                   ee92fd84 c07bf980 000000de c07bf980 ee8a8574 0008fef0
fd80: c0019c44 ef04e800 00000000 ef9369c0 ee8af000 8fef03cf b6ede000 ffefe378
fda0: ee8a8540 b6ede000 ee92fe1c ee92fdb8 c00dbc10 c00da1c0 ee8dedb8 8fef03cf
fdc0: ef9369c0 ef6f9000 0000004f c0776efc 000000de c07bf980 ee92fdfc ee92fde8
fde0: c00d994c c0572e44 effcd098 ef6f9000 ee92fe1c ee8a8574 ee8af000 ee8a8540
fe00: c0776efc 8fef03cf c07bf980 b6ede000 ee92fea4 ee92fe20 c00dd8d0 c00dbb68
fe20: ee8dedb8 ee8a8574 8fef03cf 00000040 ffefe000 b6e4f000 b6eb6000 ffefe13c
fe40: 000000de ffefe378 ffefe000 00000040 ee8dedb8 00000055 ee92ffb0 00000054
fe60: 0000005e b6e40000 ee8a8588 ee8e8580 b6ede1f8 ee8e8580 ee92fea4 ee92ffb0
fe80: ee8e8580 0000081f ee8a8540 b6ede1f8 ee8af000 ee8a8588 ee92fefc ee92fea8
fea0: c0573c48 c00dce84 00000000 00000054 00000000 c076aa0c 00000005 00000000
fec0: 00000000 00000800 00000000 00000055 ee92fefc c076a8ac 0000081f c05739d8
fee0: b6ede1f8 ee92ffb0 0000006e 0000006e ee92ffac ee92ff00 c00092a8 c05739e4
ff00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ff20: 00000000 c02aece0 80000113 ffffffff ee92ff7c 00000000 ee92ffac ee92ff48
ff40: c0573318 c0009274 b6f07068 beffffff 0000006f 00000000 beffffff b6f07068
ff60: 00000000 00000000 00000000 00000000 00000000 ee92ffac f7f0706b ee92ff98
ff80: c0050a80 c02aece0 80000113 b6e4fdce 00000030 ffffffff 10c53c7d 10c53c7d
ffa0: 00000000 ee92ffb0 c0573620 c0009274 00000000 00000004 0000006f b6ede1f8
ffc0: 00000000 be860c50 b6f07000 be860c70 b6f074c0 0000006e 0000006e b6ec0000
ffe0: 00000078 be860c50 b6e4fdaf b6e4fdce 00000030 ffffffff 00000000 00000000
Backtrace: 
[<c00da1b4>] (wp_page_copy) from [<c00dbc10>] (do_wp_page+0xb4/0x574)
 r10:b6ede000 r9:ee8a8540 r8:ffefe378 r7:b6ede000 r6:8fef03cf r5:ee8af000
 r4:ef9369c0
[<c00dbb5c>] (do_wp_page) from [<c00dd8d0>] (handle_mm_fault+0xa58/0x1058)
 r10:b6ede000 r9:c07bf980 r8:8fef03cf r7:c0776efc r6:ee8a8540 r5:ee8af000
 r4:ee8a8574
[<c00dce78>] (handle_mm_fault) from [<c0573c48>] (do_page_fault+0x270/0x43c)
 r10:ee8a8588 r9:ee8af000 r8:b6ede1f8 r7:ee8a8540 r6:0000081f r5:ee8e8580
 r4:ee92ffb0
[<c05739d8>] (do_page_fault) from [<c00092a8>] (do_DataAbort+0x40/0xc0)
 r10:0000006e r9:0000006e r8:ee92ffb0 r7:b6ede1f8 r6:c05739d8 r5:0000081f
 r4:c076a8ac
[<c0009268>] (do_DataAbort) from [<c0573620>] (__dabt_usr+0x40/0x60)
Exception stack(0xee92ffb0 to 0xee92fff8)
ffa0:                                     00000000 00000004 0000006f b6ede1f8
ffc0: 00000000 be860c50 b6f07000 be860c70 b6f074c0 0000006e 0000006e b6ec0000
ffe0: 00000078 be860c50 b6e4fdaf b6e4fdce 00000030 ffffffff
 r8:10c53c7d r7:10c53c7d r6:ffffffff r5:00000030 r4:b6e4fdce
Code: f57ff06f ee020f10 f57ff06f e12fff1e (e5801000) 
---[ end trace 0000000000000002 ]---

Grygorii Strashko (2):
  [4.4-rt] kernel/sched/core.c: UP: fix 'implicit declaration of
    function 'update_migrate_disable'
  [4.4-rt1] kernel/time/timer.c: UP: fix undefined reference to
    `del_timer_sync'

 kernel/sched/core.c | 18 +++++++++---------
 kernel/time/timer.c |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.6.4

