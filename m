From: Cliff Brake <cliff.brake@gmail.com>
Subject: 2.6.29-rc6-rt3 crash on PXA270
Date: Fri, 6 Mar 2009 17:33:57 -0500
Message-ID: <f96d234e0903061433t3a3c5817oc47a064474917b53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:39908 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbZCFWeA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2009 17:34:00 -0500
Received: by rv-out-0506.google.com with SMTP id g37so701881rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Mar 2009 14:33:58 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm using running code from the following source:

   git://git.pengutronix.de/git/ukl/linux-2.6.git rt-master

and getting the below trace on a PXA270.

Is 2.6.29-rc6-rt3 stable on ARM?  Should this work?  Any suggestions
for debugging?

It seems this fault occurred while udevd was loading, so it might be a
driver issue.

Thanks,
Cliff

-- 
=======================
Cliff Brake
http://bec-systems.com

INIT: version 2.86 booting
Starting udevudevd[514]: lookup_group: specified group 'scanner' unknown

udevd[514]: lookup_group: specified group 'scanner' unknown

udevd[514]: lookup_group: specified group 'scanner' unknown

udevd[514]: lookup_group: specified group 'scanner' unknown

udevd[514]: lookup_group: specified group 'nvram' unknown

udevd[514]: lookup_user: specudevd version 124 started
ified user 'tss' unknown

udevd[514]: lookup_group: specified group 'tss' unknown

udevd[514]: lookup_group: specified group 'fuse' unknown

udevd[514]: lookup_group: specified group 'kvm' unknown

udevd[514]: lookup_group: specified group 'rdma' unknown

udevd[514]: lookup_group: specified group 'rdma' unknown

udevd[514]: lookup_group: specified group 'rdma' unknown

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.29-rc6-rt3 #185)
PC is at exit_mmap+0x1a4/0x1bc
LR is at rt_spin_lock_slowunlock+0x50/0xa8
pc : [<c0084650>]    lr : [<c0242090>]    psr: 20000013
sp : c3943ee8  ip : c3943e78  fp : c3943f14
r10: 0001c168  r9 : 00000001  r8 : c0027024
r7 : c2ec6200  r6 : 00000000  r5 : 00000000  r4 : c2ec6040
BUG: scheduling while atomic: mount.sh/0x00000001/553, CPU#0
Modules linked in:
[
<c002a8d4>] (dump_stack+0x0/0x14) from [<c0034010>] (__schedule_bug+0x68/0x78)
[<c0033fa8>] (__schedule_bug+0x0/0x78) from [<c0240dd8>] (__schedule+0x68/0x3b0)
 r7:c38aa000 r6:c39d2cb4 r5:c39d2b20 r4:c38aa000
[<c0240d70>] (__schedule+0x0/0x3b0) from [<c024140c>] (schedule+0x28/0x44)
 r8:00000000 r7:c38aa000 r6:c341977c r5:c39d0160 r4:c38aa000
[<c02413e4>] (schedule+0x0/0x44) from [<c02426e8>]
(rt_spin_lock_slowlock+0x17c/0x23c)
 r4:20000013
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c0084954>]
(unlink_file_vma+0x2c/0x48)
 r4:c3419740
[<c0084928>] (unlink_file_vma+0x0/0x48) from [<c0082348>]
(free_pgtables+0x68/0xac)
 r7:40000000 r6:c38a1d88 r5:c38a1de0 r4:c38a1d30
[<c00822e0>] (free_pgtables+0x0/0xac) from [<c00845c0>] (exit_mmap+0x114/0x1bc)
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c391b900 r6:c391b900 r5:00000000 r4:c391b900
[<c0038070>] (mmput+0x0/0xfc) from [<c0098f9c>] (flush_old_exec+0x388/0x65c)
 r5:c39d2b20 r4:c391b3c0
[<c0098c14>] (flush_old_exec+0x0/0x65c) from [<c00c7c84>]
(load_elf_binary+0x38c/0x121c)
[<c00c78f8>] (load_elf_binary+0x0/0x121c) from [<c0097c5c>]
(search_binary_handler+0xf0/0x2bc)
[<c0097b6c>] (search_binary_handler+0x0/0x2bc) from [<c0098934>]
(do_execve+0x16c/0x224)
[<c00987c8>] (do_execve+0x0/0x224) from [<c0029d84>] (sys_execve+0x3c/0x5c)
[<c0029d48>] (sys_execve+0x0/0x5c) from [<c0026ea0>] (ret_fast_syscall+0x0/0x2c)
 r7:0000000b r6:00000000 r5:0008930c r4:000892c4
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c3a24000
[00000000] *pgd=00000000
BUG: scheduling while atomic: basename/0x00000001/559, CPU#0
Modules linked in:
[<c002a8d4>] (dump_stack+0x0/0x14) from [<c0034010>] (__schedule_bug+0x68/0x78)
[<c0033fa8>] (__schedule_bug+0x0/0x78) from [<c0240dd8>] (__schedule+0x68/0x3b0)
 r7:c3a0a000 r6:c38892f4 r5:c3889160 r4:c3a0a000
[<c0240d70>] (__schedule+0x0/0x3b0) from [<c024140c>] (schedule+0x28/0x44)
 r8:00000000 r7:c3a0a000 r6:c3485ebc r5:c39af4a0 r4:c3a0a000
[<c02413e4>] (schedule+0x0/0x44) from [<c02426e8>]
(rt_spin_lock_slowlock+0x17c/0x23c)
 r4:20000013
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c0084954>]
(unlink_file_vma+0x2c/0x48)
 r4:c3485e80
[<c0084928>] (unlink_file_vma+0x0/0x48) from [<c008231c>]
(free_pgtables+0x3c/0xac)
 r7:40000000 r6:c38a1de0 r5:c38a1f98 r4:c38a1f98
[<c00822e0>] (free_pgtables+0x0/0xac) from [<c00845c0>] (exit_mmap+0x114/0x1bc)
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c33c13f4 r6:c33c13c0 r5:00000000 r4:c33c13c0
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c3889160 r4:c38893f4
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c3a0a000 r6:00000000 r5:c3889160 r4:c3a0a000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
BUG: scheduling while atomic: basename/0x00000001/566, CPU#0
Modules linked in:
[<c002a8d4>] (dump_stack+0x0/0x14) from [<c0034010>] (__schedule_bug+0x68/0x78)
[<c0033fa8>] (__schedule_bug+0x0/0x78) from [<c0240dd8>] (__schedule+0x68/0x3b0)
 r7:c3148000 r6:c383e994 r5:c383e800 r4:c3148000
[<c0240d70>] (__schedule+0x0/0x3b0) from [<c024140c>] (schedule+0x28/0x44)
 r8:00000000 r7:c3148000 r6:c3485ebc r5:c39af4a0 r4:c3148000
[<c02413e4>] (schedule+0x0/0x44) from [<c02426e8>]
(rt_spin_lock_slowlock+0x17c/0x23c)
 r4:20000013
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c0084954>]
(unlink_file_vma+0x2c/0x48)
 r4:c3485e80
[<c0084928>] (unlink_file_vma+0x0/0x48) from [<c008231c>]
(free_pgtables+0x3c/0xac)
 r7:40000000 r6:c3a69288 r5:c3a690d0 r4:c3a690d0
[<c00822e0>] (free_pgtables+0x0/0xac) from [<c00845c0>] (exit_mmap+0x114/0x1bc)
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c2fff774 r6:c2fff740 r5:00000000 r4:c2fff740
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c383e800 r4:c383ea94
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c3148000 r6:00000000 r5:c383e800 r4:c3148000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
BUG: scheduling while atomic: cat/0x00000001/575, CPU#0
Modules linked in:
[<c002a8d4>] (dump_stack+0x0/0x14) from [<c0034010>] (__schedule_bug+0x68/0x78)
[<c0033fa8>] (__schedule_bug+0x0/0x78) from [<c0240dd8>] (__schedule+0x68/0x3b0)
 r7:c38d6000 r6:c39afd74 r5:c39afbe0 r4:c38d6000
[<c0240d70>] (__schedule+0x0/0x3b0) from [<c024140c>] (schedule+0x28/0x44)
 r8:00000000 r7:c38d6000 r6:c3485ebc r5:c39af4a0 r4:c38d6000
[<c02413e4>] (schedule+0x0/0x44) from [<c02426e8>]
(rt_spin_lock_slowlock+0x17c/0x23c)
 r4:20000013
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c0084954>]
(unlink_file_vma+0x2c/0x48)
 r4:c3485e80
[<c0084928>] (unlink_file_vma+0x0/0x48) from [<c008231c>]
(free_pgtables+0x3c/0xac)
 r7:40000000 r6:c33d05a0 r5:c33d0b20 r4:c33d0b20
[<c00822e0>] (free_pgtables+0x0/0xac) from [<c00845c0>] (exit_mmap+0x114/0x1bc)
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c33c15b4 r6:c33c1580 r5:00000000 r4:c33c1580
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c39afbe0 r4:c39afe74
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c38d6000 r6:00000000 r5:c39afbe0 r4:c38d6000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
BUG: scheduling while atomic: cat/0x00000001/573, CPU#0
Modules linked in:
[<c002a8d4>] (dump_stack+0x0/0x14) from [<c0034010>] (__schedule_bug+0x68/0x78)
[<c0033fa8>] (__schedule_bug+0x0/0x78) from [<c0240dd8>] (__schedule+0x68/0x3b0)
 r7:c2f9a000 r6:c38ddd94 r5:c38ddc00 r4:c2f9a000
[<c0240d70>] (__schedule+0x0/0x3b0) from [<c024140c>] (schedule+0x28/0x44)
 r8:00000000 r7:c2f9a000 r6:c3485ebc r5:c39af4a0 r4:c2f9a000
[<c02413e4>] (schedule+0x0/0x44) from [<c02426e8>]
(rt_spin_lock_slowlock+0x17c/0x23c)
 r4:20000013
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c0084954>]
(unlink_file_vma+0x2c/0x48)
 r4:c3485e80
[<c0084928>] (unlink_file_vma+0x0/0x48) from [<c008231c>]
(free_pgtables+0x3c/0xac)
 r7:40000000 r6:c32c0ee8 r5:c3a022e0 r4:c3a022e0
[<c00822e0>] (free_pgtables+0x0/0xac) from [<c00845c0>] (exit_mmap+0x114/0x1bc)
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c2fff934 r6:c2fff900 r5:00000000 r4:c2fff900
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c38ddc00 r4:c38dde94
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c2f9a000 r6:00000000 r5:c38ddc00 r4:c2f9a000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Unable to handle kernel paging request at virtual address 2000084c
pgd = c3160000
[2000084c] *pgd=00000000
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
udevd-event[547]: run_program: '/etc/udev/scripts/mount.sh' abnor3 :
00000003  r2 : c3942000  r1 : 00000000  r0 : 00000000
rmal exit

Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a39c8000  DAC: 00000015
Process udevd (pid: 521, stack limit = 0xc3942270)
Stack: (0xc3943ee8 to 0xc3944000)
3ee0:                   c3943ef0 00000000 00000069 c02e6240 c2ec6200 00000000
3f00: c2ec6200 c2ec6234 c3943f2c c3943f18 c00380c0 c00844b8 c39c0b14 c39c0880
3f20: c3943f54 c3943f30 c003c320 c003807c c39c0880 00000000 c3942000 c39c0880
3f40: 00000000 c3942000 c3943f74 c3943f58 c003d974 c003c1d4 c3943f84 ffffffff
3f60: 40137774 00000000 c3943f94 c3943f78 c003e00c c003d854 0008d3a8 0008d384
3f80: 00000000 000000f8 c3943fa4 c3943f98 c003e050 c003df84 00000000 c3943fa8
3fa0: c0026ea0 c003e044 0008d3a8 0008d384 00000000 00000000 fbad2088 ffffffff
3fc0: 0008d3a8 0008d384 00000000 000000f8 00000000 000182b4 0001c168 000182bc
3fe0: 00000000 beff4410 40050fb4 400abde0 60000010 00000000 a039e021 a039e421
Backtrace:
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c2ec6234 r6:c2ec6200 r5:00000000 r4:c2ec6200
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c39c0880 r4:c39c0b14
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c3942000 r6:00000000 r5:c39c0880 r4:c3942000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
Code: e5973098 e3530001 9a000002 e1a00006 (e5800000)
Internal error: Oops: 8f5 [#2] PREEMPT
Modules linked in:
CPU: 0    Tainted: G      D     (2.6.29-rc6-rt3 #185)
PC is at exit_mmap+0x1a4/0x1bc
---[ end trace 29d04a7ac2da5f95 ]---
Fixing recursive fault but reboot is needed!
LR is at rt_spin_lock_slowunlock+0x50/0xa8
pc : [<c0084650>]    lr : [<c0242090>]    psr: 20000013
sp : c38abdf0  ip : c38abd80  fp : c38abe1c
r10: c2eb8160  r9 : c390b580  r8 : 00000000
r7 : c391b900  r6 : 00000000  r5 : 00000000  r4 : c02e6240
r3 : 00000003  r2 : c38aa000  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3a24000  DAC: 00000015
Process mount.sh (pid: 553, stack limit = 0xc38aa270)
Stack: (0xc38abdf0 to 0xc38ac000)
bde0:                                     c38abdf8 00000000 00000046 c02e6240
be00: c391b900 00000000 c391b900 c391b900 c38abe34 c38abe20 c00380c0 c00844b8
be20: c391b3c0 c39d2b20 c38abe74 c38abe38 c0098f9c c003807c c38abe50 00000000
be40: c38abe74 c38abe50 c00980a8 c2f16254 00000000 c2f16220 00000000 c39ae540
be60: 00000000 c38aa000 c38abf14 c38abe78 c00c7c84 c0098c20 c38abee4 c38abe88
be80: c0242784 c38abfb0 c2eb8160 00000003 0000000b 00000000 c2dba520 00000080
bea0: c00809c4 c00806f4 00000003 c38abedc c2f16220 c2f0ea60 c38abefc c030e6f4
bec0: c38abeec c38abed0 c0242090 c0033824 00000000 60000013 c030e6f4 c2eb8160
bee0: c38abefc c38abef0 c0242a0c 00000000 c02f352c c2eb8160 00000000 c00c78f8
bf00: 00000000 c38aa000 c38abf4c c38abf18 c0097c5c c00c7904 c38abfb0 fffffffe
bf20: c38abfb0 00000000 c2eb8160 c38f9000 c38aa000 000892d4 c38abfb0 000892c4
bf40: c38abf84 c38abf50 c0098934 c0097b78 000892c4 00000000 c38abf84 c38f9000
bf60: 000892c4 000892d4 c38abfb0 c0027024 c38aa000 00000001 c38abfa4 c38abf88
bf80: c0029d84 c00987d4 000892c4 0008930c 00000000 0000000b 00000000 c38abfa8
bfa0: c0026ea0 c0029d54 000892c4 0008930c 0008930c 000892c4 000892d4 000000b8
bfc0: 000892c4 0008930c 00000000 0000000b 0007b873 00086648 00000001 00086960
bfe0: 40164e30 bedc25e8 0002ee40 40164e3c 60000010 0008930c a039e021 a039e421
Backtrace:
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c391b900 r6:c391b900 r5:00000000 r4:c391b900
[<c0038070>] (mmput+0x0/0xfc) from [<c0098f9c>] (flush_old_exec+0x388/0x65c)
 r5:c39d2b20 r4:c391b3c0
[<c0098c14>] (flush_old_exec+0x0/0x65c) from [<c00c7c84>]
(load_elf_binary+0x38c/0x121c)
[<c00c78f8>] (load_elf_binary+0x0/0x121c) from [<c0097c5c>]
(search_binary_handler+0xf0/0x2bc)
[<c0097b6c>] (search_binary_handler+0x0/0x2bc) from [<c0098934>]
(do_execve+0x16c/0x224)
[<c00987c8>] (do_execve+0x0/0x224) from [<c0029d84>] (sys_execve+0x3c/0x5c)
[<c0029d48>] (sys_execve+0x0/0x5c) from [<c0026ea0>] (ret_fast_syscall+0x0/0x2c)
 r7:0000000b r6:00000000 r5:0008930c r4:000892c4
Code: e5973098 e3530001 9a000002 e1a00006 (e5800000)
Internal error: Oops: 817 [#3] PREEMPT
Modules linked in:
CPU: 0    Tainted: G      D     (2.6.29-rc6-rt3 #185)
PC is at exit_mmap+0x1a4/0x1bc
---[ end trace 29d04a7ac2da5f96 ]---
LR is at rt_spin_lock_slowunlock+0x50/0xa8
pc : [<c0084650>]    lr : [<c0242090>]    psr: 20000013
sp : c3a0bee8  ip : c3a0be78  fp : c3a0bf14
r10: 00079528  r9 : 00000001  r8 : c0027024
r7 : c33c13c0  r6 : 00000000  r5 : 00000000  r4 : c02e6240
r3 : 00000003  r2 : c3a0a000  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3158000  DAC: 00000015
Process basename (pid: 559, stack limit = 0xc3a0a270)
Stack: (0xc3a0bee8 to 0xc3a0c000)
bee0:                   c3a0bef0 00000000 00000026 c02e6240 c33c13c0 00000000
bf00: c33c13c0 c33c13f4 c3a0bf2c c3a0bf18 c00380c0 c00844b8 c38893f4 c3889160
bf20: c3a0bf54 c3a0bf30 c003c320 c003807c c3889160 00000000 c3a0a000 c3889160
bf40: 00000000 c3a0a000 c3a0bf74 c3a0bf58 c003d974 c003c1d4 00000000 ffffffff
bf60: 401f0774 00000000 c3a0bf94 c3a0bf78 c003e00c c003d854 0008d3a8 0008d384
bf80: 00000000 000000f8 c3a0bfa4 c3a0bf98 c003e050 c003df84 00000000 c3a0bfa8
bfa0: c0026ea0 c003e044 0008d3a8 0008d384 00000000 00000000 fbad2088 ffffffff
bfc0: 0008d3a8 0008d384 00000000 000000f8 0007abda 00000005 00079528 00000002
bfe0: 4001e000 beaa3b38 40109fb4 40164de0 60000010 00000000 00000000 00000000
Backtrace:
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c33c13f4 r6:c33c13c0 r5:00000000 r4:c33c13c0
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c3889160 r4:c38893f4
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c3a0a000 r6:00000000 r5:c3889160 r4:c3a0a000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
Code: e5973098 e3530001 9a000002 e1a00006 (e5800000)
Internal error: Oops: 817 [#4] PREEMPT
Modules linked in:
CPU: 0    Tainted: G      D     (2.6.29-rc6-rt3 #185)
PC is at exit_mmap+0x1a4/0x1bc
---[ end trace 29d04a7ac2da5f97 ]---
Fixing recursive fault but reboot is needed!
LR is at rt_spin_lock_slowunlock+0x50/0xa8
pc : [<c0084650>]    lr : [<c0242090>]    psr: 20000013
sp : c2f9bee8  ip : c2f9be78  fp : c2f9bf14
r10: 00079528  r9 : 00000001  r8 : c0027024
r7 : c2fff900  r6 : 00000000  r5 : 00000000  r4 : c02e6240
r3 : 00000003  r2 : c2f9a000  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3158000  DAC: 00000015
Process cat (pid: 573, stack limit = 0xc2f9a270)
Stack: (0xc2f9bee8 to 0xc2f9c000)
bee0:                   c2f9bef0 00000000 00000025 c02e6240 c2fff900 00000000
bf00: c2fff900 c2fff934 c2f9bf2c c2f9bf18 c00380c0 c00844b8 c38dde94 c38ddc00
bf20: c2f9bf54 c2f9bf30 c003c320 c003807c c38ddc00 00000000 c2f9a000 c38ddc00
bf40: 00000000 c2f9a000 c2f9bf74 c2f9bf58 c003d974 c003c1d4 c2f9bf84 ffffffff
bf60: 401f0774 00000000 c2f9bf94 c2f9bf78 c003e00c c003d854 0008d3a8 0008d384
bf80: 00000000 000000f8 c2f9bfa4 c2f9bf98 c003e050 c003df84 00000000 c2f9bfa8
bfa0: c0026ea0 c003e044 0008d3a8 0008d384 00000000 00000000 fbad2088 ffffffff
bfc0: 0008d3a8 0008d384 00000000 000000f8 0007abda 00000008 00079528 00000002
bfe0: 00000000 beb82b38 40109fb4 40164de0 60000010 00000000 ffffffff ffffffff
Backtrace:
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c2fff934 r6:c2fff900 r5:00000000 r4:c2fff900
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c38ddc00 r4:c38dde94
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c2f9a000 r6:00000000 r5:c38ddc00 r4:c2f9a000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
Code: e5973098 e3530001 9a000002 e1a00006 (e5800000)
Internal error: Oops: 817 [#5] PREEMPT
Modules linked in:
CPU: 0    Tainted: G      D     (2.6.29-rc6-rt3 #185)
PC is at exit_mmap+0x1a4/0x1bc
---[ end trace 29d04a7ac2da5f98 ]---
Fixing recursive fault but reboot is needed!
LR is at rt_spin_lock_slowunlock+0x50/0xa8
pc : [<c0084650>]    lr : [<c0242090>]    psr: 20000013
sp : c3149ee8  ip : c3149e78  fp : c3149f14
r10: 00079528  r9 : 00000001  r8 : c0027024
r7 : c2fff740  r6 : 00000000  r5 : 00000000  r4 : c02e6240
r3 : 00000003  r2 : c3148000  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a39d8000  DAC: 00000015
Process basename (pid: 566, stack limit = 0xc3148270)
Stack: (0xc3149ee8 to 0xc314a000)
9ee0:                   c3149ef0 00000000 00000026 c02e6240 c2fff740 00000000
9f00: c2fff740 c2fff774 c3149f2c c3149f18 c00380c0 c00844b8 c383ea94 c383e800
9f20: c3149f54 c3149f30 c003c320 c003807c c383e800 00000000 c3148000 c383e800
9f40: 00000000 c3148000 c3149f74 c3149f58 c003d974 c003c1d4 00000000 ffffffff
9f60: 401f0774 00000000 c3149f94 c3149f78 c003e00c c003d854 0008d3a8 0008d384
9f80: 00000000 000000f8 c3149fa4 c3149f98 c003e050 c003df84 00000000 c3149fa8
9fa0: c0026ea0 c003e044 0008d3a8 0008d384 00000000 00000000 fbad2088 ffffffff
9fc0: 0008d3a8 0008d384 00000000 000000f8 0007abda 00000005 00079528 00000002
9fe0: 4001e000 be86fb38 40109fb4 40164de0 60000010 00000000 00000000 00000000
Backtrace:
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c2fff774 r6:c2fff740 r5:00000000 r4:c2fff740
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c383e800 r4:c383ea94
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c3148000 r6:00000000 r5:c383e800 r4:c3148000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
Code: e5973098 e3530001 9a000002 e1a00006 (e5800000)
Internal error: Oops: 5 [#6] PREEMPT
Modules linked in:
CPU: 0    Tainted: G      D     (2.6.29-rc6-rt3 #185)
---[ end trace 29d04a7ac2da5f99 ]---
Fixing recursive fault but reboot is needed!
PC is at __do_fault+0x22c/0x3d0
LR is at rt_spin_lock_slowlock+0x218/0x23c
pc : [<c007f0b0>]    lr : [<c0242784>]    psr: 60000013
sp : c32d5e88  ip : c32d5e10  fp : c32d5ed4
r10: 00000000  r9 : 40013000  r8 : 00000200
r7 : c32c0700  r6 : c0330500  r5 : 0000004c  r4 : 20000800
r3 : 00020000  r2 : c32d4000  r1 : 00000004  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3160000  DAC: 00000015
Process basename (pid: 577, stack limit = 0xc32d4270)
Stack: (0xc32d5e88 to 0xc32d6000)
5e80:                   c0241ffc c3a49ac0 00000000 00000000 00000000 00000013
5ea0: 40013000 c0330500 c32d5efc c3a5e800 c3a5e84c c39af4a0 00000000 c32c0700
5ec0: c3a49ac0 40013000 c32d5f3c c32d5ed8 c00802c0 c007ee90 00000013 00000000
5ee0: 00000000 c3a49af4 c32d5f14 00001000 00000000 c0033824 c3160000 0000004c
5f00: c3161000 c32d4000 c32d5f24 c32d5f18 c0241fe8 ffffffff 40013000 c39af4a0
5f20: c32c0700 c3a49af4 c3a49ac0 40013c4c c32d5f84 c32d5f40 c002c0ec c0080030
5f40: c32d5f5c c32d5f50 c02429d0 00000000 c32d5fb0 00000000 c008f7cc ffffffff
5f60: 40024000 bec52be0 400242d8 bec52e50 400007a4 40024000 c32d5f9c c32d5f88
5f80: c002c2d4 c002c004 ffffffff 40024000 c32d5fac c32d5fa0 c00261bc c002c2c8
5fa0: 00000000 c32d5fb0 c0026e20 c00261b0 bec52e50 40002098 400246c8 40017794
5fc0: 40024060 40024000 bec52be0 400242d8 bec52e50 400007a4 40024000 bec52bbc
5fe0: 40000000 bec52b98 40000cac 40013c4c 60000010 ffffffff 00000000 00000000
Backtrace:
[<c007ee84>] (__do_fault+0x0/0x3d0) from [<c00802c0>]
(handle_mm_fault+0x29c/0x6c4)
[<c0080024>] (handle_mm_fault+0x0/0x6c4) from [<c002c0ec>]
(do_page_fault+0xf4/0x240)
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c002c2d4>]
(do_translation_fault+0x18/0x80)
[<c002c2bc>] (do_translation_fault+0x0/0x80) from [<c00261bc>]
(do_PrefetchAbort+0x18/0x1c)
 r5:40024000 r4:ffffffff
[<c00261a4>] (do_PrefetchAbort+0x0/0x1c) from [<c0026e20>]
(ret_from_exception+0x0/0x10)
Exception stack(0xc32d5fb0 to 0xc32d5ff8)
5fa0:                                     bec52e50 40002098 400246c8 40017794
5fc0: 40024060 40024000 bec52be0 400242d8 bec52e50 400007a4 40024000 bec52bbc
5fe0: 40000000 bec52b98 40000cac 40013c4c 60000010 ffffffff
Code: e2844202 e2844b02 e283004c eb070e57 (e7942005)
Internal error: Oops: 817 [#7] PREEMPT
Modules linked in:
CPU: 0    Tainted: G      D     (2.6.29-rc6-rt3 #185)
PC is at exit_mmap+0x1a4/0x1bc
---[ end trace 29d04a7ac2da5f9a ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
BUG: scheduling while atomic: basename/0x00000002/577, CPU#0
Modules linked in:
[<c002a8d4>] (dump_stack+0x0/0x14) from [<c0034010>] (__schedule_bug+0x68/0x78)
[<c0033fa8>] (__schedule_bug+0x0/0x78) from [<c0240dd8>] (__schedule+0x68/0x3b0)
 r7:c32d4000 r6:c39af634 r5:c39af4a0 r4:c32d4000
[<c0240d70>] (__schedule+0x0/0x3b0) from [<c024140c>] (schedule+0x28/0x44)
 r8:00000000 r7:c32d4000 r6:c0303ba8 r5:c39afbe0 r4:c32d4000
[<c02413e4>] (schedule+0x0/0x44) from [<c02426e8>]
(rt_spin_lock_slowlock+0x17c/0x23c)
 r4:20000093
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c002a50c>] (die+0x40/0x2fc)
 r4:c32d4000
[<c002a4cc>] (die+0x0/0x2fc) from [<c002bfe4>] (__do_kernel_fault+0x6c/0x80)
[<c002bf78>] (__do_kernel_fault+0x0/0x80) from [<c002c21c>]
(do_page_fault+0x224/0x240)
 r7:c32d5b38 r6:c39af4a0 r5:c02e5ffc r4:ffffffff
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c00261fc>]
(do_DataAbort+0x3c/0xa0)
[<c00261c0>] (do_DataAbort+0x0/0xa0) from [<c00269ac>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc32d5b38 to 0xc32d5b80)
5b20:                                                       c32d4000 c39af4a0
5b40: c32d4000 00000000 20000013 00000000 c3a49b0c c3a5d820 c007f0b0 0007e000
5b60: 0007e000 c32d5bdc c32d5b80 c32d5b80 c024259c c02425d8 60000093 ffffffff
 r8:c007f0b0 r7:c3a5d820 r6:c3a49b0c r5:c32d5b6c r4:ffffffff
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c00819a0>] (unmap_vmas+0x668/0x688)
 r4:00000000
[<c0081338>] (unmap_vmas+0x0/0x688) from [<c0084584>] (exit_mmap+0xd8/0x1bc)
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c3a49af4 r6:c3a49ac0 r5:00000000 r4:c3a49ac0
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c39af4a0 r4:c39af734
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:00000000 r6:0000000b r5:c39af4a0 r4:c32d4000
[<c003d848>] (do_exit+0x0/0x730) from [<c002a768>] (die+0x29c/0x2fc)
[<c002a4cc>] (die+0x0/0x2fc) from [<c002bfe4>] (__do_kernel_fault+0x6c/0x80)
[<c002bf78>] (__do_kernel_fault+0x0/0x80) from [<c002c21c>]
(do_page_fault+0x224/0x240)
 r7:c32c0700 r6:c39af4a0 r5:c02e5fdc r4:00010000
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c002c2d4>]
(do_translation_fault+0x18/0x80)
[<c002c2bc>] (do_translation_fault+0x0/0x80) from [<c00261fc>]
(do_DataAbort+0x3c/0xa0)
 r5:c02e5fdc r4:ffffffff
[<c00261c0>] (do_DataAbort+0x0/0xa0) from [<c00269ac>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc32d5e40 to 0xc32d5e88)
5e40: 00000001 00000004 c32d4000 00020000 20000800 0000004c c0330500 c32c0700
5e60: 00000200 40013000 00000000 c32d5ed4 c32d5e10 c32d5e88 c0242784 c007f0b0
5e80: 60000013 ffffffff
 r8:00000200 r7:c32c0700 r6:c0330500 r5:c32d5e74 r4:ffffffff
[<c007ee84>] (__do_fault+0x0/0x3d0) from [<c00802c0>]
(handle_mm_fault+0x29c/0x6c4)
[<c0080024>] (handle_mm_fault+0x0/0x6c4) from [<c002c0ec>]
(do_page_fault+0xf4/0x240)
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c002c2d4>]
(do_translation_fault+0x18/0x80)
[<c002c2bc>] (do_translation_fault+0x0/0x80) from [<c00261bc>]
(do_PrefetchAbort+0x18/0x1c)
 r5:40024000 r4:ffffffff
[<c00261a4>] (do_PrefetchAbort+0x0/0x1c) from [<c0026e20>]
(ret_from_exception+0x0/0x10)
Exception stack(0xc32d5fb0 to 0xc32d5ff8)
5fa0:                                     bec52e50 40002098 400246c8 40017794
5fc0: 40024060 40024000 bec52be0 400242d8 bec52e50 400007a4 40024000 bec52bbc
5fe0: 40000000 bec52b98 40000cac 40013c4c 60000010 ffffffff
LR is at rt_spin_lock_slowunlock+0x50/0xa8
pc : [<c0084650>]    lr : [<c0242090>]    psr: 20000013
sp : c38d7ee8  ip : c38d7e78  fp : c38d7f14
r10: 00079528  r9 : 00000001  r8 : c0027024
r7 : c33c1580  r6 : 00000000  r5 : 00000000  r4 : c02e6240
r3 : 00000003  r2 : c38d6000  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3160000  DAC: 00000015
Process cat (pid: 575, stack limit = 0xc38d6270)
Stack: (0xc38d7ee8 to 0xc38d8000)
7ee0:                   c38d7ef0 00000000 00000025 c02e6240 c33c1580 00000000
7f00: c33c1580 c33c15b4 c38d7f2c c38d7f18 c00380c0 c00844b8 c39afe74 c39afbe0
7f20: c38d7f54 c38d7f30 c003c320 c003807c c39afbe0 00000000 c38d6000 c39afbe0
7f40: 00000000 c38d6000 c38d7f74 c38d7f58 c003d974 c003c1d4 c38d7f84 ffffffff
7f60: 401f0774 00000000 c38d7f94 c38d7f78 c003e00c c003d854 0008d3a8 0008d384
7f80: 00000000 000000f8 c38d7fa4 c38d7f98 c003e050 c003df84 00000000 c38d7fa8
7fa0: c0026ea0 c003e044 0008d3a8 0008d384 00000000 00000000 fbad2088 ffffffff
7fc0: 0008d3a8 0008d384 00000000 000000f8 0007abda 00000008 00079528 00000002
7fe0: 00000000 bea14b38 40109fb4 40164de0 60000010 00000000 a039e021 a039e421
Backtrace:
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c33c15b4 r6:c33c1580 r5:00000000 r4:c33c1580
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c39afbe0 r4:c39afe74
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:c38d6000 r6:00000000 r5:c39afbe0 r4:c38d6000
[<c003d848>] (do_exit+0x0/0x730) from [<c003e00c>] (do_group_exit+0x94/0xc0)
[<c003df78>] (do_group_exit+0x0/0xc0) from [<c003e050>]
(sys_exit_group+0x18/0x20)
 r7:000000f8 r6:00000000 r5:0008d384 r4:0008d3a8
[<c003e038>] (sys_exit_group+0x0/0x20) from [<c0026ea0>]
(ret_fast_syscall+0x0/0x2c)
Code: e5973098 e3530001 9a000002 e1a00006 (e5800000)
Internal error: Oops: 817 [#8] PREEMPT
Modules linked in:
CPU: 0    Tainted: G      D     (2.6.29-rc6-rt3 #185)
PC is at rt_spin_lock_slowlock+0x6c/0x23c
LR is at rt_spin_lock_slowlock+0x30/0x23c
pc : [<c02425d8>]    lr : [<c024259c>]    psr: 60000093
sp : c32d5b80  ip : c32d5b80  fp : c32d5bdc
r10: 0007e000  r9 : 0007e000  r8 : c007f0b0
r7 : c3a5d820  r6 : c3a49b0c  r5 : 00000000  r4 : 20000013
r3 : 00000000  r2 : c32d4000  r1 : c39af4a0  r0 : c32d4000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3160000  DAC: 00000015
Process basename (pid: 577, stack limit = 0xc32d4270)
Stack: (0xc32d5b80 to 0xc32d6000)
5b80: 00000055 c2f0ee20 c32d5ba4 c32d5b98 c02429d0 c024204c c32d5bbc c32d5ba8
5ba0: c002ecd4 c02429a4 00000000 c32d5bb8 c005dff4 c3a49b0c 00008000 c32c05f8
5bc0: c3a5d820 c007f0b0 0007e000 0007e000 c32d5bf4 c32d5be0 c0242a6c c0242578
5be0: c005ea94 00000000 c32d5c6c c32d5bf8 c00819a0 c0242a1c 0007dfff 0007dfff
5c00: ffffffff 00000000 c32d5c7c 00000001 00000000 c32d4000 c02e6240 c3160000
5c20: c3160000 c3a49ac0 00000001 00000005 c02f2950 00400000 0007e000 00000000
5c40: c02429d0 c3a49ac0 00000000 c32c05f8 c3a49ac0 c007f0b0 00000001 bf000000
5c60: c32d5c9c c32d5c70 c0084584 c0081344 c32d5c78 00000000 00000000 c02e6240
5c80: c3a49ac0 00000000 c3a49ac0 c3a49af4 c32d5cb4 c32d5ca0 c00380c0 c00844b8
5ca0: c39af734 c39af4a0 c32d5cdc c32d5cb8 c003c320 c003807c c39af4a0 0000000b
5cc0: c32d4000 c39af4a0 0000000b 00000000 c32d5cfc c32d5ce0 c003d974 c003c1d4
5ce0: c32d5cfc c32d5cf0 c003a4cc c003a388 c32d5d0c c32d5d00 c002a768 c003d854
5d00: c32d5d2c c32d5d10 c002bfe4 c002a4d8 00010000 c02e5fdc c39af4a0 c32c0700
5d20: c32d5d74 c32d5d30 c002c21c c002bf84 c005ad24 c005abd8 00000000 0000000f
5d40: c32d5e40 00000005 c32d5da4 ffffffff c02e5fdc 00000005 c32d5e40 2000084c
5d60: 60000013 00000000 c32d5d8c c32d5d78 c002c2d4 c002c004 ffffffff c02e5fdc
5d80: c32d5e3c c32d5d90 c00261fc c002c2c8 c32d5dc4 c32d5da0 c0054d98 c0068068
5da0: 00000000 c39af4d0 c383a01c c39af4a0 00000017 c3829080 c32d5ddc c32d5dc8
5dc0: c0054dc4 c0054d5c 00000000 c39af4a0 c32d5e04 c32d5de0 c32d5e0c c32d5de8
5de0: c005dff4 c005db34 c32d4000 40000013 00000000 c3a49b0c c32d4000 00000000
5e00: c32d5e6c c32d5e10 c0242784 c0033824 00000000 00000001 c32d5e84 ffffffff
5e20: c32d5e74 c0330500 c32c0700 00000200 c32d5ed4 c32d5e40 c00269ac c00261cc
5e40: 00000001 00000004 c32d4000 00020000 20000800 0000004c c0330500 c32c0700
5e60: 00000200 40013000 00000000 c32d5ed4 c32d5e10 c32d5e88 c0242784 c007f0b0
5e80: 60000013 ffffffff c0241ffc c3a49ac0 00000000 00000000 00000000 00000013
5ea0: 40013000 c0330500 c32d5efc c3a5e800 c3a5e84c c39af4a0 00000000 c32c0700
5ec0: c3a49ac0 40013000 c32d5f3c c32d5ed8 c00802c0 c007ee90 00000013 00000000
5ee0: 00000000 c3a49af4 c32d5f14 00001000 00000000 c0033824 c3160000 0000004c
5f00: c3161000 c32d4000 c32d5f24 c32d5f18 c0241fe8 ffffffff 40013000 c39af4a0
5f20: c32c0700 c3a49af4 c3a49ac0 40013c4c c32d5f84 c32d5f40 c002c0ec c0080030
5f40: c32d5f5c c32d5f50 c02429d0 00000000 c32d5fb0 00000000 c008f7cc ffffffff
5f60: 40024000 bec52be0 400242d8 bec52e50 400007a4 40024000 c32d5f9c c32d5f88
5f80: c002c2d4 c002c004 ffffffff 40024000 c32d5fac c32d5fa0 c00261bc c002c2c8
5fa0: 00000000 c32d5fb0 c0026e20 c00261b0 bec52e50 40002098 400246c8 40017794
5fc0: 40024060 40024000 bec52be0 400242d8 bec52e50 400007a4 40024000 bec52bbc
5fe0: 40000000 bec52b98 40000cac 40013c4c 60000010 ffffffff 00000000 00000000
Backtrace:
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c00819a0>] (unmap_vmas+0x668/0x688)
 r4:00000000
[<c0081338>] (unmap_vmas+0x0/0x688) from [<c0084584>] (exit_mmap+0xd8/0x1bc)
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c3a49af4 r6:c3a49ac0 r5:00000000 r4:c3a49ac0
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c39af4a0 r4:c39af734
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:00000000 r6:0000000b r5:c39af4a0 r4:c32d4000
[<c003d848>] (do_exit+0x0/0x730) from [<c002a768>] (die+0x29c/0x2fc)
[<c002a4cc>] (die+0x0/0x2fc) from [<c002bfe4>] (__do_kernel_fault+0x6c/0x80)
[<c002bf78>] (__do_kernel_fault+0x0/0x80) from [<c002c21c>]
(do_page_fault+0x224/0x240)
 r7:c32c0700 r6:c39af4a0 r5:c02e5fdc r4:00010000
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c002c2d4>]
(do_translation_fault+0x18/0x80)
[<c002c2bc>] (do_translation_fault+0x0/0x80) from [<c00261fc>]
(do_DataAbort+0x3c/0xa0)
 r5:c02e5fdc r4:ffffffff
[<c00261c0>] (do_DataAbort+0x0/0xa0) from [<c00269ac>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc32d5e40 to 0xc32d5e88)
5e40: 00000001 00000004 c32d4000 00020000 20000800 0000004c c0330500 c32c0700
5e60: 00000200 40013000 00000000 c32d5ed4 c32d5e10 c32d5e88 c0242784 c007f0b0
5e80: 60000013 ffffffff
 r8:00000200 r7:c32c0700 r6:c0330500 r5:c32d5e74 r4:ffffffff
[<c007ee84>] (__do_fault+0x0/0x3d0) from [<c00802c0>]
(handle_mm_fault+0x29c/0x6c4)
[<c0080024>] (handle_mm_fault+0x0/0x6c4) from [<c002c0ec>]
(do_page_fault+0xf4/0x240)
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c002c2d4>]
(do_translation_fault+0x18/0x80)
[<c002c2bc>] (do_translation_fault+0x0/0x80) from [<c00261bc>]
(do_PrefetchAbort+0x18/0x1c)
 r5:40024000 r4:ffffffff
[<c00261a4>] (do_PrefetchAbort+0x0/0x1c) from [<c0026e20>]
(ret_from_exception+0x0/0x10)
Exception stack(0xc32d5fb0 to 0xc32d5ff8)
5fa0:                                     bec52e50 40002098 400246c8 40017794
5fc0: 40024060 40024000 bec52be0 400242d8 bec52e50 400007a4 40024000 bec52bbc
5fe0: 40000000 bec52b98 40000cac 40013c4c 60000010 ffffffff
Code: e3c33003 e1530001 1a000002 e1a03005 (e5833000)
---[ end trace 29d04a7ac2da5f9b ]---
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: basename/0x00000002/577, CPU#0
Modules linked in:
[<c002a8d4>] (dump_stack+0x0/0x14) from [<c0034010>] (__schedule_bug+0x68/0x78)
[<c0033fa8>] (__schedule_bug+0x0/0x78) from [<c0240dd8>] (__schedule+0x68/0x3b0)
 r7:00000000 r6:c39af634 r5:c39af4a0 r4:c32d4000
[<c0240d70>] (__schedule+0x0/0x3b0) from [<c024140c>] (schedule+0x28/0x44)
 r8:c02425d8 r7:00000000 r6:0000000b r5:c39af4a0 r4:c32d4000
[<c02413e4>] (schedule+0x0/0x44) from [<c003d8fc>] (do_exit+0xb4/0x730)
 r4:c32d4000
[<c003d848>] (do_exit+0x0/0x730) from [<c002a768>] (die+0x29c/0x2fc)
[<c002a4cc>] (die+0x0/0x2fc) from [<c002bfe4>] (__do_kernel_fault+0x6c/0x80)
[<c002bf78>] (__do_kernel_fault+0x0/0x80) from [<c002c21c>]
(do_page_fault+0x224/0x240)
 r7:c32d5b38 r6:c39af4a0 r5:c02e5ffc r4:ffffffff
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c00261fc>]
(do_DataAbort+0x3c/0xa0)
[<c00261c0>] (do_DataAbort+0x0/0xa0) from [<c00269ac>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc32d5b38 to 0xc32d5b80)
5b20:                                                       c32d4000 c39af4a0
5b40: c32d4000 00000000 20000013 00000000 c3a49b0c c3a5d820 c007f0b0 0007e000
5b60: 0007e000 c32d5bdc c32d5b80 c32d5b80 c024259c c02425d8 60000093 ffffffff
 r8:c007f0b0 r7:c3a5d820 r6:c3a49b0c r5:c32d5b6c r4:ffffffff
[<c024256c>] (rt_spin_lock_slowlock+0x0/0x23c) from [<c0242a6c>]
(rt_spin_lock+0x5c/0x68)
[<c0242a10>] (rt_spin_lock+0x0/0x68) from [<c00819a0>] (unmap_vmas+0x668/0x688)
 r4:00000000
[<c0081338>] (unmap_vmas+0x0/0x688) from [<c0084584>] (exit_mmap+0xd8/0x1bc)
[<c00844ac>] (exit_mmap+0x0/0x1bc) from [<c00380c0>] (mmput+0x50/0xfc)
 r7:c3a49af4 r6:c3a49ac0 r5:00000000 r4:c3a49ac0
[<c0038070>] (mmput+0x0/0xfc) from [<c003c320>] (exit_mm+0x158/0x160)
 r5:c39af4a0 r4:c39af734
[<c003c1c8>] (exit_mm+0x0/0x160) from [<c003d974>] (do_exit+0x12c/0x730)
 r7:00000000 r6:0000000b r5:c39af4a0 r4:c32d4000
[<c003d848>] (do_exit+0x0/0x730) from [<c002a768>] (die+0x29c/0x2fc)
[<c002a4cc>] (die+0x0/0x2fc) from [<c002bfe4>] (__do_kernel_fault+0x6c/0x80)
[<c002bf78>] (__do_kernel_fault+0x0/0x80) from [<c002c21c>]
(do_page_fault+0x224/0x240)
 r7:c32c0700 r6:c39af4a0 r5:c02e5fdc r4:00010000
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c002c2d4>]
(do_translation_fault+0x18/0x80)
[<c002c2bc>] (do_translation_fault+0x0/0x80) from [<c00261fc>]
(do_DataAbort+0x3c/0xa0)
 r5:c02e5fdc r4:ffffffff
[<c00261c0>] (do_DataAbort+0x0/0xa0) from [<c00269ac>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc32d5e40 to 0xc32d5e88)
5e40: 00000001 00000004 c32d4000 00020000 20000800 0000004c c0330500 c32c0700
5e60: 00000200 40013000 00000000 c32d5ed4 c32d5e10 c32d5e88 c0242784 c007f0b0
5e80: 60000013 ffffffff
 r8:00000200 r7:c32c0700 r6:c0330500 r5:c32d5e74 r4:ffffffff
[<c007ee84>] (__do_fault+0x0/0x3d0) from [<c00802c0>]
(handle_mm_fault+0x29c/0x6c4)
[<c0080024>] (handle_mm_fault+0x0/0x6c4) from [<c002c0ec>]
(do_page_fault+0xf4/0x240)
[<c002bff8>] (do_page_fault+0x0/0x240) from [<c002c2d4>]
(do_translation_fault+0x18/0x80)
[<c002c2bc>] (do_translation_fault+0x0/0x80) from [<c00261bc>]
(do_PrefetchAbort+0x18/0x1c)
 r5:40024000 r4:ffffffff
[<c00261a4>] (do_PrefetchAbort+0x0/0x1c) from [<c0026e20>]
(ret_from_exception+0x0/0x10)
Exception stack(0xc32d5fb0 to 0xc32d5ff8)
5fa0:                                     bec52e50 40002098 400246c8 40017794
5fc0: 40024060 40024000 bec52be0 400242d8 bec52e50 400007a4 40024000 bec52bbc
5fe0: 40000000 bec52b98 40000cac 40013c4c 60000010 ffffffff
---[ end trace 29d04a7ac2da5f9c ]---
Fixing recursive fault but reboot is needed!
JFFS2 notice: (463) check_node_data: wrong data CRC in data node at
0x03e65950: read 0xf60cbeb1, calculated 0x97379e3f.
