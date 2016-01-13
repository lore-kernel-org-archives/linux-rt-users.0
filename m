From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.4-rc6-rt1 PATCH 0/2] ARM: am437x: boot test report
Date: Wed, 13 Jan 2016 22:14:29 +0200
Message-ID: <5696B025.8020909@ti.com>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
 <20160112171556.GB31009@linutronix.de> <569637ED.1030304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sekhar Nori <nsekhar@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34969 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbcAMUOo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 15:14:44 -0500
In-Reply-To: <569637ED.1030304@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,
On 01/13/2016 01:41 PM, Grygorii Strashko wrote:
> On 01/12/2016 07:15 PM, Sebastian Andrzej Siewior wrote:
>> * Grygorii Strashko | 2015-12-28 20:00:09 [+0200]:
>>
>>> Hi All, Sebastian,
>> Hi Grygorii,
>>
>>> 3) Seems there are some problem with HIGHMEM :(. System crashes if I'm trying
>>>     to run hackbench (see log 1). I can run hackbench only if HIGHMEM is disabled.
>>>     I've also tried to disable CONFIG_CPU_SW_DOMAIN_PAN, CONFIG_ARM_PATCH_PHYS_VIRT,
>>>     and CONFIG_CPUSETS, before disabling HIGHMEM.
>>>     Sorry, I'll not able to investigate it further because of Christmas holidays here.
>>
>> I see. It seems not to trigger anything on x86.
> 
> Yah. I saw other reports - it seems this issue is not triggered on ARM SMP also
> (as per report from Tim Sander). Will try to dig deeper.
> 

I did more tests, but still don't know what is wrong.
1) vanilla 4.4 - no issue
2) 4.4-rt: CONFIG_PREEMPT_RT_BASE=n and CONFIG_PREEMPT_RT_FULL=n -- no issue
3) 4.4-rt: CONFIG_DEBUG_HIGHMEM=y -- issue is present log1
4) 4.4-rt: this is interesting ;) 
I can run hackbench few times without issues If I run hackbench with RT priority (log2)
But I got crash immediately once I run it using non-RT priorities.

======================== log1 =============================
/ # 
/ # ./hackbench 
Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
Each sender will pass 100 messages of 100 bytes
[  104.105133] ------------[ cut here ]------------
[  104.105163] kernel BUG at arch/arm/mm/highmem.c:90!
[  104.105163] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[  104.105163] Modules linked in:
[  104.105194] CPU: 0 PID: 168 Comm: hackbench Not tainted 4.4.0-rt2-debug-00261-g16b2b9c #51
[  104.105194] Hardware name: Generic AM43 (Flattened Device Tree)
[  104.105194] task: edeb9a00 ti: edeec000 task.ti: edeec000
[  104.105224] PC is at kmap_atomic+0x174/0x178
[  104.105224] LR is at 0x7ff
[  104.105224] pc : [<c00200d8>]    lr : [<000007ff>]    psr: a0000113
[  104.105224] sp : edeedd80  ip : c0004000  fp : b6fce000
[  104.105224] r10: 000be875  r9 : 00000001  r8 : ffefe000
[  104.105224] r7 : 00080000  r6 : ef6f9000  r5 : 0000004f  r4 : effc4074
[  104.105224] r3 : efffd000  r2 : bec6524f  r1 : c084e414  r0 : 000000fe
[  104.105255] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  104.105255] Control: 10c5387d  Table: adef0059  DAC: 00000055
[  104.105255] Process hackbench (pid: 168, stack limit = 0xedeec218)
[  104.105255] Stack: (0xedeedd80 to 0xedeee000)
[  104.105255] dd80: effc4074 effc558c effc558c edeae780 b6fce000 c00208f0 000be875 c0020900
[  104.105285] dda0: effc4074 eded0000 effc558c c01585a4 edecb738 c003658c edeb9a00 eded0000
[  104.105285] ddc0: edeedddc c00667c4 2e0cb000 effc4074 eded0000 be8753cf b6fce000 edecb738
[  104.105285] dde0: edeae780 edecb738 b6fce000 c0159fa8 edef2db8 be8753cf effc4074 edeae7b4
[  104.105285] de00: c015b668 edeae7b4 be8753cf c09af5c4 c120c640 edecb738 b6fce000 c06b06fc
[  104.105316] de20: eded0000 edeae780 edeae7b4 be8753cf c09af5c4 c120c640 edecb738 c015bdc8
[  104.105316] de40: edef2db8 edeae7b4 be8753cf c0a2e768 00000055 edef2db8 00000040 000001ce
[  104.105316] de60: edecb000 00000001 00000000 00000000 0000006d edeae808 c09c0f28 60000113
[  104.105316] de80: c082d628 0000012f b6fce1f8 c008c334 c0a2d88a 00000000 c082d628 edeedfb0
[  104.105316] dea0: edeb9a00 0000081f edeae780 b6fce1f8 eded0000 edeae808 00000055 c06b18ac
[  104.105346] dec0: 00000001 00000001 000003b4 00000079 00000001 00000000 00000000 00000800
[  104.105346] dee0: 00000000 edeb9a00 edeb9f00 c09b1aa4 0000081f c06b1570 b6fce1f8 edeedfb0
[  104.105346] df00: 0000006d 0000006d b6fb0000 c000935c 00000000 00000001 c11fc8fc edeb9f00
[  104.105346] df20: 00000000 c008dcb4 60000113 c008dfe4 c0383ac0 80000113 c0383ac0 80000113
[  104.105377] df40: c0383ac0 80000113 ffffffff c06b0ea8 b6ff7068 beffffff 000000a8 60000113
[  104.105377] df60: beffffff b6ff7068 00000000 00000000 00000000 00000000 00000000 edeedfac
[  104.105377] df80: f7ff706b edeedfa0 c0065d1c c0383ac0 b6f3fdce 00000030 b6f3fdce 00000030
[  104.105377] dfa0: ffffffff 10c5387d 10c5387d c06b11a0 00000000 00000004 000000a8 b6fce1f8
[  104.105377] dfc0: 00000000 bef9cc50 b6ff7000 bef9cc70 b6ff74c0 0000006d 0000006d b6fb0000
[  104.105407] dfe0: 00000078 bef9cc50 b6f3fdaf b6f3fdce 00000030 ffffffff 84e7c1f5 00b90c8b
[  104.105407] [<c00200d8>] (kmap_atomic) from [<c0020900>] (v6_copy_user_highpage_nonaliasing+0x10/0x3c)
[  104.105438] [<c0020900>] (v6_copy_user_highpage_nonaliasing) from [<c01585a4>] (wp_page_copy+0x90/0x42c)
[  104.105438] [<c01585a4>] (wp_page_copy) from [<c0159fa8>] (do_wp_page+0xb0/0x58c)
[  104.105468] [<c0159fa8>] (do_wp_page) from [<c015bdc8>] (handle_mm_fault+0xba4/0x131c)
[  104.105468] [<c015bdc8>] (handle_mm_fault) from [<c06b18ac>] (do_page_fault+0x33c/0x464)
[  104.105468] [<c06b18ac>] (do_page_fault) from [<c000935c>] (do_DataAbort+0x38/0xb8)
[  104.105499] [<c000935c>] (do_DataAbort) from [<c06b11a0>] (__dabt_usr+0x40/0x60)
[  104.105499] Exception stack(0xedeedfb0 to 0xedeedff8)
[  104.105499] dfa0:                                     00000000 00000004 000000a8 b6fce1f8
[  104.105499] dfc0: 00000000 bef9cc50 b6ff7000 bef9cc70 b6ff74c0 0000006d 0000006d b6fb0000
[  104.105499] dfe0: 00000078 bef9cc50 b6f3fdaf b6f3fdce 00000030 ffffffff
[  104.105529] Code: f57ff06f e1a00008 e8bd87f0 e7f001f2 (e7f001f2) 
[  104.459960] ---[ end trace 0000000000000002 ]---
[  104.459960] Kernel panic - not syncing: Fatal exception
[  104.469879] ---[ end Kernel panic - not syncing: Fatal exception
[  104.470123] ------------[ cut here ]------------
[  104.470123] kernel BUG at arch/arm/mm/highmem.c:90!
[  104.470123] Internal error: Oops - BUG: 0 [#2] PREEMPT SMP ARM
[  104.470153] Modules linked in:
[  104.470153] CPU: 0 PID: 169 Comm: hackbench Tainted: G      D         4.4.0-rt2-debug-00261-g16b2b9c #51
[  104.470153] Hardware name: Generic AM43 (Flattened Device Tree)
[  104.470153] task: edeba700 ti: edeee000 task.ti: edeee000
[  104.470184] PC is at kmap_atomic+0x174/0x178
[  104.470184] LR is at 0x7ff
[  104.470184] pc : [<c00200d8>]    lr : [<000007ff>]    psr: a0000113
[  104.470184] sp : edeefdc0  ip : c0004000  fp : b6ff7000
[  104.470184] r10: 000007dc  r9 : 00000001  r8 : ffefe000
[  104.470184] r7 : 00080000  r6 : ef6f9000  r5 : 0000004f  r4 : effccd80
[  104.470184] r3 : efffd000  r2 : bec6524f  r1 : c084e414  r0 : 000000fe
[  104.470184] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  104.470214] Control: 10c5387d  Table: adef4059  DAC: 00000055
[  104.470214] Process hackbench (pid: 169, stack limit = 0xedeee218)
[  104.470214] Stack: (0xedeefdc0 to 0xedef0000)
[  104.470214] fdc0: eded09f8 edeaea00 c09c501c 000001f7 c09af5c4 c120c640 000007dc c015b3e8
[  104.470214] fde0: 00000000 00000000 c015b294 c0a2e768 00000015 edef6db8 00000000 000001f7
[  104.470245] fe00: 000007dc c06b1600 00000000 00000000 00000000 edeaea88 00000015 00000001
[  104.470245] fe20: edeaea88 c06b1600 edeaea00 b6ff7068 00000000 edeaea88 00000015 edeeff50
[  104.470245] fe40: edeba700 00000817 edeaea00 b6ff7068 eded09f8 edeaea88 00000015 c06b18ac
[  104.470245] fe60: 46645842 17d0a331 40676928 65e14918 0121ab18 0802f85c 2d40a304 00000800
[  104.470245] fe80: 89a57429 57055c13 bd1cad2d c09b1a24 00000817 c06b1570 b6ff7068 edeeff50
[  104.470275] fea0: 00000000 00000000 edeeffac c000935c 3934894a c2228357 b030396c a0149d40
[  104.470275] fec0: 28cf2586 88402298 4227321a 0098d964 6100c3ba 45034574 da227e42 92a62662
[  104.470275] fee0: b103ebd0 51162a81 1b14562f 8ab07f9d b159415c 00000000 00000001 ef6ae150
[  104.470275] ff00: 00000000 00000000 00000000 00000000 00000001 c09c0f38 00000000 00000000
[  104.470306] ff20: 00000002 c0a2e768 60000113 c008dfe4 00000000 00000000 c0383ac0 80000113
[  104.470306] ff40: ffffffff edeeff84 00000000 c06b0e9c b6ff7068 beffffff 000000a9 60000113
[  104.470306] ff60: beffffff b6ff7068 00000000 00000000 00000000 00000000 00000000 edeeffac
[  104.470306] ff80: f7ff706b edeeffa0 c0065d1c c0383ac0 80000113 ffffffff 00000000 c0065d0c
[  104.470306] ffa0: 00000000 00000000 00000000 c0010338 00000000 00000000 00000000 00000000
[  104.470336] ffc0: b6ff7068 bef9cc50 b6ff7000 00000078 b6ff74c0 0000006d 0000006d b6fb0000
[  104.470336] ffe0: 00000078 bef9cc48 b6f3fdaf b6ee9276 00000030 01200011 77168c61 1e1444b0
[  104.470336] [<c00200d8>] (kmap_atomic) from [<c015b3e8>] (handle_mm_fault+0x1c4/0x131c)
[  104.470367] [<c015b3e8>] (handle_mm_fault) from [<c06b18ac>] (do_page_fault+0x33c/0x464)
[  104.470367] [<c06b18ac>] (do_page_fault) from [<c000935c>] (do_DataAbort+0x38/0xb8)
[  104.470367] [<c000935c>] (do_DataAbort) from [<c06b0e9c>] (__dabt_svc+0x3c/0x60)
[  104.470367] Exception stack(0xedeeff50 to 0xedeeff98)
[  104.470397] ff40:                                     b6ff7068 beffffff 000000a9 60000113
[  104.470397] ff60: beffffff b6ff7068 00000000 00000000 00000000 00000000 00000000 edeeffac
[  104.470397] ff80: f7ff706b edeeffa0 c0065d1c c0383ac0 80000113 ffffffff
[  104.470428] [<c06b0e9c>] (__dabt_svc) from [<c0383ac0>] (__put_user_4+0xc/0x18)
[  104.470428] Code: f57ff06f e1a00008 e8bd87f0 e7f001f2 (e7f001f2) 


======================== log2 =============================
/ # chrt -f 99 ./hackbench 
Running in process mode with 10 groups using 40 [   78.947326] sched: RT throttling activated
file descriptors each (== 400 tasks)
Each sende[   78.948150] NOHZ: local_softirq_pending 02
r will pass 100 messages of 100 bytes
Time: 10.[   78.956817] NOHZ: local_softirq_pending 02
600
[   78.966949] NOHZ: local_softirq_pending 02
[   78.976593] NOHZ: local_softirq_pending 02
[   78.986572] NOHZ: local_softirq_pending 02
[   78.996582] NOHZ: local_softirq_pending 02
[   79.006561] NOHZ: local_softirq_pending 02
[   79.956848] NOHZ: local_softirq_pending 02
[   79.966735] NOHZ: local_softirq_pending 02
[   79.976562] NOHZ: local_softirq_pending 02
/ # 
/ # chrt -f 98 ./hackbench 
Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
Each sender will pass 100 messages of 100 bytes
Time: 11.468
/ # ./hackbench 
Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
Each sender will pass 100 messages of 100 bytes
[  158.488372] Unable to handle kernel paging request at virtual address ffefe2a0
[  158.522277] pgd = ed718000
[  158.525115] [ffefe2a0] *pgd=afffd861, *pte=00000000, *ppte=00000000
[  158.543548] Internal error: Oops: 837 [#1] PREEMPT SMP ARM
[  158.543548] Modules linked in:
[  158.543548] CPU: 0 PID: 904 Comm: hackbench Not tainted 4.4.0-rt2-00261-g16b2b9c #52
[  158.543579] Hardware name: Generic AM43 (Flattened Device Tree)
[  158.543579] task: edbd9b80 ti: eefb6000 task.ti: eefb6000
[  158.543609] PC is at cpu_ca8_set_pte_ext+0x0/0x58
[  158.543609] LR is at filemap_map_pages+0x3bc/0x414
[  158.543609] pc : [<c00222a8>]    lr : [<c0125c88>]    psr: 40000113
[  158.543609] sp : eefb7de0  ip : 00000000  fp : ee634d5c
[  158.543640] r10: edd60000  r9 : c0a324ee  r8 : 00000000
[  158.543640] r7 : ee634bf8  r6 : eefb7e7c  r5 : ef937a34  r4 : ee5bbf14
[  158.543640] r3 : c00222a8  r2 : 00000800  r1 : 8ff6518f  r0 : ffefe2a0
[  158.543640] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  158.543640] Control: 10c5387d  Table: ad718059  DAC: 00000051
[  158.543640] Process hackbench (pid: 904, stack limit = 0xeefb6218)
[  158.543670] Stack: (0xeefb7de0 to 0xeefb8000)
[  158.543670] 7de0: 00000000 00000000 c015b178 c015b078 ee634d60 c015b178 b6ea0000 ed9804d0
[  158.543670] 7e00: 000000d8 00000000 ee634cac ee5bbf14 c0977128 00000057 00000080 b6ea1000
[  158.543670] 7e20: 000000a1 ed9804d0 edbb0500 b6ea1000 000d4000 b6f25000 00000050 ffefe284
[  158.543701] 7e40: 000000a1 c015b178 00000000 00000000 c015a934 c0097314 00000001 00000054
[  158.543701] 7e60: ed71adb8 00000040 00000284 edbb0534 ffefe000 00000000 00000008 00000054
[  158.543701] 7e80: 0000004f b6ea0000 edbb0500 b6ea1e70 0000005e ffefe280 00000054 eefb7fb0
[  158.543701] 7ea0: edbd9b80 80000007 edbb0500 b6ea1e70 ed9804d0 edbb0578 00000054 c068ece0
[  158.543731] 7ec0: 00000000 edbda170 00000000 00000000 00000000 00000000 00000008 00000000
[  158.543731] 7ee0: 00000000 c082e334 00000000 c097c8f4 00000007 c068e9b8 b6ea1e70 eefb7fb0
[  158.543731] 7f00: 00000386 00000386 b6f2f000 c000943c 00000001 c09bc35c 00000000 00000000
[  158.543731] 7f20: 00000002 c0a331d4 60000113 c0097314 00000000 00000000 c03761c0 80000113
[  158.543762] 7f40: c03761c0 80000113 ffffffff c068e138 b6f76068 beffffff 00000388 00000000
[  158.543762] 7f60: 00000051 b6f76068 00000000 00000000 00000000 00000000 00000000 eefb7fac
[  158.543762] 7f80: f7f7606b eefb7fa0 00000000 beefac50 b6f76000 c000f99c b6ea1e70 00000030
[  158.543762] 7fa0: ffffffff 10c5387d 10c5387d c068e814 00000000 0000000c 00000388 b6f37bfd
[  158.543792] 7fc0: 00000000 beefac50 b6f76000 beefac70 b6f764c0 00000386 00000386 b6f2f000
[  158.543792] 7fe0: 00000152 beefac50 b6ebede3 b6ea1e70 00000030 ffffffff afffd861 afffdc61
[  158.543823] [<c00222a8>] (cpu_ca8_set_pte_ext) from [<c015b178>] (handle_mm_fault+0x8ac/0x12f8)
[  158.543823] [<c015b178>] (handle_mm_fault) from [<c068ece0>] (do_page_fault+0x328/0x45c)
[  158.543853] [<c068ece0>] (do_page_fault) from [<c000943c>] (do_PrefetchAbort+0x34/0x98)
[  158.543853] [<c000943c>] (do_PrefetchAbort) from [<c068e814>] (ret_from_exception+0x0/0x2c)
[  158.543853] Exception stack(0xeefb7fb0 to 0xeefb7ff8)
[  158.543853] 7fa0:                                     00000000 0000000c 00000388 b6f37bfd
[  158.543884] 7fc0: 00000000 beefac50 b6f76000 beefac70 b6f764c0 00000386 00000386 b6f2f000
[  158.543884] 7fe0: 00000152 beefac50 b6ebede3 b6ea1e70 00000030 ffffffff
[  158.543884] Code: f57ff06f ee020f10 f57ff06f e12fff1e (e5801000) 
[  158.987609] Unable to handle kernel paging request at virtual address ffefe5c8
[  158.995178] pgd = ed80c000
[  159.015991] [ffefe5c8] *pgd=afffd861, *pte=00000000, *ppte=00000000
[  159.032867] Internal error: Oops: 837 [#2] PREEMPT SMP ARM
[  159.032867] Modules linked in:
[  159.032867] CPU: 0 PID: 1012 Comm: hackbench Tainted: G      D         4.4.0-rt2-00261-g16b2b9c #52
[  159.032867] Hardware name: Generic AM43 (Flattened Device Tree)
[  159.032897] task: ed536e00 ti: ed808000 task.ti: ed808000
[  159.032897] PC is at cpu_ca8_set_pte_ext+0x0/0x58
[  159.032928] LR is at filemap_map_pages+0x3bc/0x414
[  159.032928] pc : [<c00222a8>]    lr : [<c0125c88>]    psr: 40000113
[  159.032928] sp : ed809de0  ip : 00000000  fp : ee6128dc
[  159.032928] r10: ed271000  r9 : c0a324ee  r8 : 00000000
[  159.032958] r7 : ee612778  r6 : ed809e7c  r5 : ef937350  r4 : ee5bb688
[  159.032958] r3 : c00222a8  r2 : 00000800  r1 : 8ff3418f  r0 : ffefe5c8
[  159.032958] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  159.032958] Control: 10c5387d  Table: ad80c059  DAC: 00000051
[  159.032958] Process hackbench (pid: 1012, stack limit = 0xed808218)
[  159.032958] Stack: (0xed809de0 to 0xed80a000)
[  159.032989] 9de0: 00000000 00000000 c015b178 c015b078 ee6128e0 c015b178 b6f70000 ed0c1790
[  159.032989] 9e00: 00000018 00000000 ee61282c ee5bb688 c0977128 00000016 00000040 b6f70000
[  159.032989] 9e20: 00000170 ed0c1790 ed80a000 b6f70000 00017000 b6f73000 00000014 ffefe5c0
[  159.033020] 9e40: 00000170 c015b178 00000000 00000000 c015a934 c0097314 00000001 00000054
[  159.033020] 9e60: ed80edb8 00000040 000005c0 ed80a034 ffefe000 00000000 00000008 00000054
[  159.033020] 9e80: 00000014 b6f70000 ed80a000 b6f70378 00000016 ffefe5c0 00000054 ed809fb0
[  159.033020] 9ea0: ed536e00 00000017 ed80a000 b6f70378 ed0c1790 ed80a078 00000054 c068ece0
[  159.033020] 9ec0: 00000000 00000000 00000000 c0a331d4 60000013 00000000 00000000 00000000
[  159.033050] 9ee0: 00000000 c005093c 00000000 c097c6f4 00000017 c068e9b8 b6f70378 ed809fb0
[  159.033050] 9f00: 00000000 b6f7adc8 10a8b550 c0009388 ed809f68 c003dc08 ed536e00 00000001
[  159.033050] 9f20: ed809f3c c006e5a0 ed7405e8 00000001 ed536e00 00000001 000221ac c00509d8
[  159.033050] 9f40: ffffffff beefaa34 00000051 00000051 c000fa64 beefaa34 00000014 00000000
[  159.033081] 9f60: 00000000 c0050e50 00000000 14000000 b6e76aa0 00000002 00000000 0001121d
[  159.033081] 9f80: 14000000 b6e76aa0 00000002 00000000 80000013 beefab64 b6f6d254 80000030
[  159.033081] 9fa0: ffffffff 10c5387d 10c5387d c068e508 000105f2 b6f70378 0000000b 0000006c
[  159.033081] 9fc0: b6f7b960 000105f1 b6f7759c b6f7b960 00000005 00000000 b6f7adc8 10a8b550
[  159.033111] 9fe0: beefaa90 beefaa58 b6f678cd b6f6d254 80000030 ffffffff 00000000 00000000
[  159.033142] [<c00222a8>] (cpu_ca8_set_pte_ext) from [<c015b178>] (handle_mm_fault+0x8ac/0x12f8)
[  159.033142] [<c015b178>] (handle_mm_fault) from [<c068ece0>] (do_page_fault+0x328/0x45c)
[  159.033172] [<c068ece0>] (do_page_fault) from [<c0009388>] (do_DataAbort+0x34/0xb4)
[  159.033172] [<c0009388>] (do_DataAbort) from [<c068e508>] (__dabt_usr+0x48/0x60)
[  159.033172] Exception stack(0xed809fb0 to 0xed809ff8)
[  159.033172] 9fa0:                                     000105f2 b6f70378 0000000b 0000006c
[  159.033172] 9fc0: b6f7b960 000105f1 b6f7759c b6f7b960 00000005 00000000 b6f7adc8 10a8b550
[  159.033203] 9fe0: beefaa90 beefaa58 b6f678cd b6f6d254 80000030 ffffffff
[  159.033203] Code: f57ff06f ee020f10 f57ff06f e12fff1e (e5801000) 
[  159.607635] Unable to handle kernel paging request at virtual address ffefe350
[  159.615203] pgd = eefe0000
[  159.636474] [ffefe350] *pgd=afffd861, *pte=00000000, *ppte=00000000
[  159.653350] Internal error: Oops: 837 [#3] PREEMPT SMP ARM
[  159.653381] Modules linked in:
[  159.653381] CPU: 0 PID: 1208 Comm: hackbench Tainted: G      D         4.4.0-rt2-00261-g16b2b9c #52
[  159.653381] Hardware name: Generic AM43 (Flattened Device Tree)
[  159.653381] task: edc35280 ti: eef5c000 task.ti: eef5c000
[  159.653411] PC is at cpu_ca8_set_pte_ext+0x0/0x58
[  159.653442] LR is at filemap_map_pages+0x3bc/0x414
[  159.653442] pc : [<c00222a8>]    lr : [<c0125c88>]    psr: 40000113
[  159.653442] sp : eef5dde0  ip : 00000000  fp : ee634d5c
[  159.653442] r10: edd60000  r9 : c0a324ee  r8 : 00000000
[  159.653442] r7 : ee634bf8  r6 : eef5de7c  r5 : efd97424  r4 : ee618024
[  159.653472] r3 : c00222a8  r2 : 00000800  r1 : af10118f  r0 : ffefe350
[  159.653472] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  159.653472] Control: 10c5387d  Table: aefe0059  DAC: 00000051
[  159.653472] Process hackbench (pid: 1208, stack limit = 0xeef5c218)
[  159.653472] Stack: (0xeef5dde0 to 0xeef5e000)
[  159.653503] dde0: 00000000 00000000 c015b178 c015b078 ee634d60 c015b178 b6ed0000 ed311b00
[  159.653503] de00: 000000d8 00000000 ee634cac ee618024 c0977128 00000083 000000c0 b6ed7000
[  159.653503] de20: 000000d7 ed311b00 ed304a00 b6ed7000 000d4000 b6f25000 00000086 ffefe35c
[  159.653503] de40: 000000d7 c015b178 00000000 00000000 c015a934 c0097314 00000001 00000054
[  159.653533] de60: eefe2db8 00000040 0000035c ed304a34 ffefe000 00000000 00000000 00000054
[  159.653533] de80: 0000007f b6ed0000 ed304a00 b6ed7470 0000008e ffefe340 00000054 eef5dfb0
[  159.653533] dea0: edc35280 80000007 ed304a00 b6ed7470 ed311b00 ed304a78 00000054 c068ece0
[  159.653533] dec0: 00000000 00000000 00000000 00000001 00000000 00000000 00000000 00000000
[  159.653564] dee0: 00000000 00000000 00000000 c097c8f4 00000007 c068e9b8 b6ed7470 eef5dfb0
[  159.653564] df00: 00024610 000221ac 000221ac c000943c eef5df68 beefabe7 00000001 00000001
[  159.653564] df20: 00000000 00000000 eef5df1c 00000000 edd60300 00000000 00000000 00000000
[  159.653564] df40: 00000000 edd60300 00000001 ee6682e0 00000002 edd60308 eef5c000 00000000
[  159.653564] df60: 000221ac c0187d6c 00000000 00000000 edd60300 edd60300 beefabe7 00000001
[  159.653594] df80: c000fa64 c018850c 00000000 00000000 80000013 0000002a b6ed7470 80000030
[  159.653594] dfa0: ffffffff 10c5387d 10c5387d c068e814 beefabe8 00000001 ffffffff 00000001
[  159.653594] dfc0: 0000002a 00000000 0001131d beefac68 000113c1 00024610 000221ac 000221ac
[  159.653594] dfe0: b6ed7471 beefabe0 000112fd b6ed7470 80000030 ffffffff 00000000 00000000
[  159.653625] [<c00222a8>] (cpu_ca8_set_pte_ext) from [<c015b178>] (handle_mm_fault+0x8ac/0x12f8)
[  159.653656] [<c015b178>] (handle_mm_fault) from [<c068ece0>] (do_page_fault+0x328/0x45c)
[  159.653656] [<c068ece0>] (do_page_fault) from [<c000943c>] (do_PrefetchAbort+0x34/0x98)
[  159.653717] [<c000943c>] (do_PrefetchAbort) from [<c068e814>] (ret_from_exception+0x0/0x2c)
[  159.653717] Exception stack(0xeef5dfb0 to 0xeef5dff8)
[  159.653717] dfa0:                                     beefabe8 00000001 ffffffff 00000001
[  159.653717] dfc0: 0000002a 00000000 0001131d beefac68 000113c1 00024610 000221ac 000221ac
[  159.653717] dfe0: b6ed7471 beefabe0 000112fd b6ed7470 80000030 ffffffff
[  159.653747] Code: f57ff06f ee020f10 f57ff06f e12fff1e (e5801000) 
[  160.039001] Unable to handle kernel paging request at virtual address ffefdb20
[  160.046752] pgd = edab8000
[  160.049560] [ffefdb20] *pgd=afffd861, *pte=00000000, *ppte=00000000
[  160.056152] Internal error: Oops: 837 [#4] PREEMPT SMP ARM
[  160.056152] Modules linked in:
[  160.056152] CPU: 0 PID: 902 Comm: hackbench Tainted: G      D         4.4.0-rt2-00261-g16b2b9c #52
[  160.056182] Hardware name: Generic AM43 (Flattened Device Tree)
[  160.056182] task: edbd8dc0 ti: eefb2000 task.ti: eefb2000
[  160.056182] PC is at copy_page+0x2c/0x80
[  160.056182] LR is at 0x19ef1cf1
[  160.056213] pc : [<c0373e0c>]    lr : [<19ef1cf1>]    psr: 20000113
[  160.056213] sp : eefb3da0  ip : abfb4583  fp : 000000fa
[  160.056213] r10: 000be6a9  r9 : edbb0280  r8 : c0021684
[  160.056213] r7 : beefa000  r6 : effc00c0  r5 : ffefd000  r4 : bfdf5a74
[  160.056213] r3 : 3f3779db  r2 : 00000009  r1 : ffefeb30  r0 : ffefdb20
[  160.056213] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  160.056213] Control: 10c5387d  Table: adab8059  DAC: 00000051
[  160.056243] Process hackbench (pid: 902, stack limit = 0xeefb2218)
[  160.056243] Stack: (0xeefb3da0 to 0xeefb4000)
[  160.056243] 3da0: ffefe000 c00216ac effbffc4 edbb8108 effc00c0 c0157d88 edbd8dc0 edbb8108
[  160.056243] 3dc0: eefb3ddc c006e5a0 effbffc4 edbb8108 be6a93cf effbffc4 edbb8108 be6a93cf
[  160.056274] 3de0: beefa000 ed0913e8 edbb0280 ed0913e8 000000fa c0159664 edabafb8 be6a93cf
[  160.056274] 3e00: effbffc4 edbb02b4 c015ace0 beefa000 be6a93cf edbb02b4 c09bf68c ed0913e8
[  160.056274] 3e20: 000000fa c068d88c edbb8108 edbb0280 beefa000 be6a93cf edbb02b4 c09bf68c
[  160.056274] 3e40: ed0913e8 c015b400 edabafb8 edbb02b4 be6a93cf c0097314 00000001 00000055
[  160.056304] 3e60: edabafb8 00000040 ed091000 00000001 eefb3f2c c007e94c 00000001 00000001
[  160.056304] 3e80: edbb02f8 c068ea48 edbb0280 beefac48 00000386 edbb02f8 00000055 eefb3fb0
[  160.056304] 3ea0: edbd8dc0 0000081f edbb0280 beefac48 edbb8108 edbb02f8 00000055 c068ece0
[  160.056304] 3ec0: edbd8dc0 c007c3a8 60000093 edbd8dc0 ef6b2e80 00000000 00000008 00000800
[  160.056335] 3ee0: 00000000 c0a33008 ed3c4a40 c097c774 0000081f c068e9b8 beefac48 eefb3fb0
[  160.056335] 3f00: 00000386 00000386 b6f2f000 c0009388 ed031000 00000000 b6f2f000 c068d51c
[  160.056335] 3f20: ed3c44c0 beefac50 ed3c44c0 c003c4b0 ed031000 00000000 00000000 eefb3f58
[  160.056335] 3f40: c06e9440 c01892d4 c0977ba0 00000000 ee677080 c0527538 ee949410 00000007
[  160.056365] 3f60: ed02e600 00000000 00000051 ed02e480 00000018 b6f76068 beefac50 b6f76000
[  160.056365] 3f80: 00000078 c000fa64 eefb2000 00000000 b6f2f000 c003cbb0 b6ea1ee6 60000030
[  160.056365] 3fa0: ffffffff 10c5387d 10c5387d c068e508 000004ff 00000000 00000000 0008e7c4
[  160.056365] 3fc0: 000004ff beefac50 b6f76000 beefac70 b6f764c0 00000386 00000386 b6f2f000
[  160.056396] 3fe0: 00000078 beefac50 b6ebee77 b6ea1ee6 60000030 ffffffff afffd861 afffdc61
[  160.056396] Code: e8a05018 e8b15018 e8a05018 e8b15018 (e8a05018) 
[  160.317626] ---[ end trace 0000000000000002 ]---
[  160.322509] ------------[ cut here ]------------
[  160.322509] Kernel BUG at c068bc0c [verbose debug info unavailable]
[  160.322509] Internal error: Oops - BUG: 0 [#5] PREEMPT SMP ARM
[  160.322540] Modules linked in:
[  160.322540] CPU: 0 PID: 904 Comm: hackbench Tainted: G      D         4.4.0-rt2-00261-g16b2b9c #52
[  160.322540] Hardware name: Generic AM43 (Flattened Device Tree)
[  160.322540] task: edbd9b80 ti: eefb6000 task.ti: eefb6000
[  160.322570] PC is at rt_spin_lock_slowlock+0x248/0x2f8
[  160.322570] LR is at 0xedbb055c
[  160.322570] pc : [<c068bc0c>]    lr : [<edbb055c>]    psr: 60000113
[  160.322570] sp : eefb7a78  ip : edbd9b80  fp : 00011000
[  160.322570] r10: c0976454  r9 : 00012000  r8 : 00000001
[  160.322570] r7 : edbd9b80  r6 : eefb7a88  r5 : 00000000  r4 : edbb0534
[  160.322570] r3 : 00000001  r2 : edbd9b80  r1 : edbd9b80  r0 : 00000000
[  160.322601] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  160.322601] Control: 10c5387d  Table: ad718059  DAC: 00000051
[  160.322601] Process hackbench (pid: 904, stack limit = 0xeefb6218)
[  160.322601] Stack: (0xeefb7a78 to 0xeefb8000)
[  160.322601] 7a60:                                                       c0a2f2c0 c0a30108
[  160.322601] 7a80: 00000100 00000000 eefb7a88 00000000 c0968ad8 eefb7a94 c0820b1b 00000000
[  160.322631] 7aa0: 00000000 c0968ad8 00000001 00000141 00000000 edbb0534 c0158ef0 eefb7b88
[  160.322631] 7ac0: 00000000 eefb7b88 00012000 c0976454 00011000 c068d89c 00000339 c0020bfc
[  160.322631] 7ae0: 00000001 ffffffff ffefd040 ffefd040 ffffffff c0158ef0 eefb7af8 ed9805d8
[  160.322631] 7b00: ed718004 00000000 edbb0534 ffefd040 edbb0500 edbb06c8 00012000 00000000
[  160.322662] 7b20: ed718000 00011fff c0136d70 00000000 00000000 00000000 00000000 ed9805d8
[  160.322662] 7b40: ffffffff eefb7b88 00000000 00000000 00000001 edbb0578 c00222aa c015a164
[  160.322662] 7b60: 00000000 edbb0500 ed9805d8 edbb0500 eefb7bb0 60000113 edbb0500 c01608ec
[  160.322662] 7b80: 60000113 c0097314 edbb0500 00000001 00000000 00000000 ffffffff 00000000
[  160.322692] 7ba0: 00000000 00000000 00000400 ed032000 c0041644 c097befc 60000113 edbb0500
[  160.322692] 7bc0: edbb0500 00000000 c097befc 60000113 edbb0500 00000000 c097befc c003a7a8
[  160.322692] 7be0: edbd9b80 edbda0bc c097befc c0041670 60000113 c0123600 00000001 c0a38244
[  160.322692] 7c00: eefb7d90 c097befc 60000113 0000000b 00000000 00000001 c00222aa c0014724
[  160.322723] 7c20: eefb6218 0000000b c00222ac eefb6000 bf000000 00000008 660a2314 66663735
[  160.322723] 7c40: 20663630 32306565 30316630 37356620 36306666 31652066 66666632 28206531
[  160.322723] 7c60: 30383565 30303031 c0002029 eefb7c8c ee634d5c ffefe2a0 eefb7d90 00000837
[  160.322723] 7c80: edbb0500 ffefe2a0 c0a324ee edd60000 ee634d5c c0023704 edbb0500 c068ede8
[  160.322723] 7ca0: edbd9b80 c00947cc c068d584 edbd9b80 00000001 edbda940 c068a110 c0094930
[  160.322753] 7cc0: ef6b2e80 00000000 eefb7d14 c097c6f4 00000837 c068e9b8 ffefe2a0 eefb7d90
[  160.322753] 7ce0: c0a324ee edd60000 ee634d5c c0009388 edbd9b80 ef6b2e90 edbd9b80 ee8b1b80
[  160.322753] 7d00: 00000000 edbb0500 00000000 c0a33008 eefb7d64 c068a110 c09690f4 00000000
[  160.322753] 7d20: 00000001 edbda198 e681b990 00000024 00000001 edbda198 edbd9b80 00000004
[  160.322784] 7d40: 00000006 eefb6000 edd60000 c00947cc c068e1f0 edbd9b80 00000001 eefb7dac
[  160.322784] 7d60: 00000001 c0094930 c017913c 20000113 ffffffff c068e1f0 c00222a8 40000113
[  160.322784] 7d80: ffffffff eefb7dc4 00000000 c068e12c ffefe2a0 8ff6518f 00000800 c00222a8
[  160.322784] 7da0: ee5bbf14 ef937a34 eefb7e7c ee634bf8 00000000 c0a324ee edd60000 ee634d5c
[  160.322814] 7dc0: 00000000 eefb7de0 c0125c88 c00222a8 40000113 ffffffff 00000051 c0125c88
[  160.322814] 7de0: 00000000 00000000 c015b178 c015b078 ee634d60 c015b178 b6ea0000 ed9804d0
[  160.322814] 7e00: 000000d8 00000000 ee634cac ee5bbf14 c0977128 00000057 00000080 b6ea1000
[  160.322814] 7e20: 000000a1 ed9804d0 edbb0500 b6ea1000 000d4000 b6f25000 00000050 ffefe284
[  160.322845] 7e40: 000000a1 c015b178 00000000 00000000 c015a934 c0097314 00000001 00000054
[  160.322845] 7e60: ed71adb8 00000040 00000284 edbb0534 ffefe000 00000000 00000008 00000054
[  160.322845] 7e80: 0000004f b6ea0000 edbb0500 b6ea1e70 0000005e ffefe280 00000054 eefb7fb0
[  160.322845] 7ea0: edbd9b80 80000007 edbb0500 b6ea1e70 ed9804d0 edbb0578 00000054 c068ece0
[  160.322875] 7ec0: 00000000 edbda170 00000000 00000000 00000000 00000000 00000008 00000000
[  160.322875] 7ee0: 00000000 c082e334 00000000 c097c8f4 00000007 c068e9b8 b6ea1e70 eefb7fb0
[  160.322875] 7f00: 00000386 00000386 b6f2f000 c000943c 00000001 c09bc35c 00000000 00000000
[  160.322875] 7f20: 00000002 c0a331d4 60000113 c0097314 00000000 00000000 c03761c0 80000113
[  160.322906] 7f40: c03761c0 80000113 ffffffff c068e138 b6f76068 beffffff 00000388 00000000
[  160.322906] 7f60: 00000051 b6f76068 00000000 00000000 00000000 00000000 00000000 eefb7fac
[  160.322906] 7f80: f7f7606b eefb7fa0 00000000 beefac50 b6f76000 c000f99c b6ea1e70 00000030
[  160.322906] 7fa0: ffffffff 10c5387d 10c5387d c068e814 00000000 0000000c 00000388 b6f37bfd
[  160.322906] 7fc0: 00000000 beefac50 b6f76000 beefac70 b6f764c0 00000386 00000386 b6f2f000
[  160.322937] 7fe0: 00000152 beefac50 b6ebede3 b6ea1e70 00000030 ffffffff afffd861 afffdc61
[  160.322937] [<c068bc0c>] (rt_spin_lock_slowlock) from [<c068d89c>] (rt_spin_lock+0x80/0x84)
[  160.322967] [<c068d89c>] (rt_spin_lock) from [<c0158ef0>] (unmap_single_vma+0x16c/0x56c)
[  160.322967] [<c0158ef0>] (unmap_single_vma) from [<c015a164>] (unmap_vmas+0x54/0x68)
[  160.322998] [<c015a164>] (unmap_vmas) from [<c01608ec>] (exit_mmap+0xd8/0x1dc)
[  160.322998] [<c01608ec>] (exit_mmap) from [<c003a7a8>] (mmput+0x44/0xec)
[  160.323028] [<c003a7a8>] (mmput) from [<c0041670>] (do_exit+0x2c0/0xb98)
[  160.323028] [<c0041670>] (do_exit) from [<c0014724>] (die+0x430/0x480)
[  160.323059] [<c0014724>] (die) from [<c0023704>] (__do_kernel_fault.part.0+0x54/0x1e4)
[  160.323089] [<c0023704>] (__do_kernel_fault.part.0) from [<c068ede8>] (do_page_fault+0x430/0x45c)
[  160.323089] [<c068ede8>] (do_page_fault) from [<c0009388>] (do_DataAbort+0x34/0xb4)
[  160.323089] [<c0009388>] (do_DataAbort) from [<c068e12c>] (__dabt_svc+0x4c/0x80)
[  160.323089] Exception stack(0xeefb7d90 to 0xeefb7dd8)
[  160.323120] 7d80:                                     ffefe2a0 8ff6518f 00000800 c00222a8
[  160.323120] 7da0: ee5bbf14 ef937a34 eefb7e7c ee634bf8 00000000 c0a324ee edd60000 ee634d5c
[  160.323120] 7dc0: 00000000 eefb7de0 c0125c88 c00222a8 40000113 ffffffff
[  160.323120] [<c068e12c>] (__dabt_svc) from [<c00222a8>] (cpu_ca8_set_pte_ext+0x0/0x58)
[  160.323150] [<c00222a8>] (cpu_ca8_set_pte_ext) from [<c015b178>] (handle_mm_fault+0x8ac/0x12f8)
[  160.323150] [<c015b178>] (handle_mm_fault) from [<c068ece0>] (do_page_fault+0x328/0x45c)
[  160.323150] [<c068ece0>] (do_page_fault) from [<c000943c>] (do_PrefetchAbort+0x34/0x98)
[  160.323181] [<c000943c>] (do_PrefetchAbort) from [<c068e814>] (ret_from_exception+0x0/0x2c)
[  160.323181] Exception stack(0xeefb7fb0 to 0xeefb7ff8)
[  160.323181] 7fa0:                                     00000000 0000000c 00000388 b6f37bfd
[  160.323181] 7fc0: 00000000 beefac50 b6f76000 beefac70 b6f764c0 00000386 00000386 b6f2f000
[  160.323181] 7fe0: 00000152 beefac50 b6ebede3 b6ea1e70 00000030 ffffffff
[  160.323211] Code: e1540002 1a000001 e1530006 1a000010 (e7f001f2) 
[  161.006896] ---[ end trace 0000000000000003 ]---
[  161.006896] Fixing recursive fault but reboot is needed!
[  161.007080] ---[ end trace 0000000000000004 ]---

-- 
regards,
-grygorii
