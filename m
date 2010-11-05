From: Lai Weilin-B04597 <B04597@freescale.com>
Subject: register_cdrom() problem.
Date: Thu, 4 Nov 2010 19:13:09 -0700
Message-ID: <720495D6851AC945B07A65EA0CD65C86016D5D@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:17793 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0KECMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Nov 2010 22:12:52 -0400
Received: from mail128-tx2 (localhost.localdomain [127.0.0.1])	by
 mail128-tx2-R.bigfish.com (Postfix) with ESMTP id EECE516C01DE	for
 <linux-rt-users@vger.kernel.org>; Fri,  5 Nov 2010 02:12:48 +0000 (UTC)
Received: from TX2EHSMHS012.bigfish.com (unknown [10.9.14.253])	by
 mail128-tx2.bigfish.com (Postfix) with ESMTP id 8EBB73D8050	for
 <linux-rt-users@vger.kernel.org>; Fri,  5 Nov 2010 02:12:48 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id oA52CgPf003176	for
 <linux-rt-users@vger.kernel.org>; Thu, 4 Nov 2010 19:12:44 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
 [10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 oA52TiLa025082	for <linux-rt-users@vger.kernel.org>; Thu, 4 Nov 2010 21:29:44
 -0500 (CDT)
Content-Language: en-US
Content-Class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi guys,
I am trying to enable the CD-ROM on Freescale's i.MX25 PDK, 31 kernel, with the rt patch applied. But met the problem as below. I turned on most of the RT debug options.  I went through the register_cdrom() function, and it does not seem to any problem. Has anyone met this before ? Any one can help ? 


------------[ cut here ]------------
WARNING: at kernel/lockdep.c:2631 __lock_acquire+0x6cc/0x89c()
Modules linked in: cdmm10(+) cdrom ehci_hcd
[<c002561c>] (unwind_backtrace+0x0/0xd4) from [<c003aabc>] (warn_slowpath_common+0x4c/0x68)
[<c003aabc>] (warn_slowpath_common+0x4c/0x68) from [<c005f25c>] (__lock_acquire+0x6cc/0x89c)
[<c005f25c>] (__lock_acquire+0x6cc/0x89c) from [<c0060198>] (lock_acquire+0x5c/0x70)
[<c0060198>] (lock_acquire+0x5c/0x70) from [<c0249aa0>] (_atomic_spin_lock_irqsave+0x4c/0x60)
[<c0249aa0>] (_atomic_spin_lock_irqsave+0x4c/0x60) from [<c0248a6c>] (rt_mutex_slowlock+0x30/0x228)
[<c0248a6c>] (rt_mutex_slowlock+0x30/0x228) from [<bf00ebf4>] (register_cdrom+0x224/0x28c [cdrom])
[<bf00ebf4>] (register_cdrom+0x224/0x28c [cdrom]) from [<bf026098>] (cdmm10_init+0x98/0x17c [cdmm10])
[<bf026098>] (cdmm10_init+0x98/0x17c [cdmm10]) from [<c0020300>] (do_one_initcall+0x58/0x1a8)
[<c0020300>] (do_one_initcall+0x58/0x1a8) from [<c0068a5c>] (sys_init_module+0xc0/0x1d8)
[<c0068a5c>] (sys_init_module+0xc0/0x1d8) from [<c0020e20>] (ret_fast_syscall+0x0/0x2c)
---[ end trace 6ec5129019052f27 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000030
pgd = c3054000
[00000030] *pgd=83bf2031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT
Modules linked in: cdmm10(+) cdrom ehci_hcd
CPU: 0    Tainted: G        W   (2.6.31-209-g699787d-g7105196-dirty #9)
PC is at task_blocks_on_rt_mutex+0xa8/0x1d0
LR is at __rt_mutex_adjust_prio+0xc/0x2c
pc : [<c0064074>]    lr : [<c0063814>]    psr: 00000093
sp : c3025e30  ip : c3024000  fp : c3025ed0
r10: fffffff4  r9 : c38540e0  r8 : bf01668c
r7 : 00000000  r6 : c3025eb4  r5 : bf016636  r4 : c385442c
r3 : bf0166b0  r2 : 00000000  r1 : 00000076  r0 : 00000000
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 83054000  DAC: 00000015
Process modprobe (pid: 500, stack limit = 0xc3024270)
Stack: (0xc3025e30 to 0xc3026000)
5e20:                                     00000002 60000093 c3024000 00000000 
5e40: 00000000 c3025eb4 c3024000 bf01668c 00000000 00000000 40000013 00000004 
5e60: 00000000 c0248854 40000013 00000000 bf02304c 00000004 00000000 bf01668c 
5e80: 00000000 bf02304c c3025eb4 40000013 00000000 c0248bbc 00000000 40000013 
5ea0: 00000001 00000000 00000004 ffffffff 60000013 00000076 c3025eb8 c3025eb8 
5ec0: c3025ec0 c3025ec0 00000000 00000000 00000076 c3025ed4 c3025ed4 c3025edc 
5ee0: c3025edc 00000000 00000000 c38540e0 bf01668c 11111111 00000000 11111111 
5f00: bf01695c bf022ecc bf022e2c bf01695c bf022e2c bf02304c c3024000 00000001 
5f20: 00000002 bf00ebf4 c3bf4000 00000000 c0339e2c bf026098 00000002 bf02618c 
5f40: 00000000 bf022f08 c0339e2c bf02617c 00000000 c0020300 c0249bc0 0000869e 
5f60: bf022f08 00000000 0009eaf8 c0020fa4 00000000 bf022f08 00000000 0009eaf8 
5f80: c0020fa4 c0068a5c 0000000c c0094564 0009eaf8 0000869e 0009e1a0 0009e498 
5fa0: 00000080 c0020e20 0000869e 0009e1a0 0009eaf8 0000869e 0009e498 0009e3d8 
5fc0: 0000869e 0009e1a0 0009e498 00000080 0009e3f8 0000006c 00000001 00000002 
5fe0: be89b970 be89b960 00015a50 400dc320 20000010 0009eaf8 00000000 00000000 
[<c0064074>] (task_blocks_on_rt_mutex+0xa8/0x1d0) from [<c0248854>] (__rt_mutex_slowlock+0xa4/0x100)
[<c0248854>] (__rt_mutex_slowlock+0xa4/0x100) from [<c0248bbc>] (rt_mutex_slowlock+0x180/0x228)
[<c0248bbc>] (rt_mutex_slowlock+0x180/0x228) from [<bf00ebf4>] (register_cdrom+0x224/0x28c [cdrom])
[<bf00ebf4>] (register_cdrom+0x224/0x28c [cdrom]) from [<bf026098>] (cdmm10_init+0x98/0x17c [cdmm10])
[<bf026098>] (cdmm10_init+0x98/0x17c [cdmm10]) from [<c0020300>] (do_one_initcall+0x58/0x1a8)
[<c0020300>] (do_one_initcall+0x58/0x1a8) from [<c0068a5c>] (sys_init_module+0xc0/0x1d8)
[<c0068a5c>] (sys_init_module+0xc0/0x1d8) from [<c0020e20>] (ret_fast_syscall+0x0/0x2c)
Code: e286b01c 01a0a006 0a000006 e242a00c (e59a303c) 
---[ end trace 6ec5129019052f28 ]---


Best Regards.
William Lai



