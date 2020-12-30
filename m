Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55D2C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Dec 2020 11:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8026322209
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Dec 2020 11:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgL3LR0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 30 Dec 2020 06:17:26 -0500
Received: from mail.emcraft.com ([142.93.143.113]:58110 "EHLO mail.emcraft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgL3LRZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 30 Dec 2020 06:17:25 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Dec 2020 06:17:22 EST
Received: from sergmir.emcraft.com (unknown [95.165.7.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.emcraft.com (Postfix) with ESMTPSA id DEABA3F021;
        Wed, 30 Dec 2020 11:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=emcraft.com;
        s=default; t=1609326559;
        bh=A3AJWM7qwvjWDjVUusx0au1cX2Pe9FWL8W9YEA0cmRE=;
        h=Date:From:To:Subject:From;
        b=K7+zkc3dQMnWDuvStdkslVmV+NnwuvBiy8KLmiziTI+eEdIYX9Sy949SU5H+P6oSQ
         syNnYMewvVW7eWflL6mFq8g17V9Xgegg2ODb3IU58syLG/jzWu3Lr77swPNciZsSPB
         Htbv/3YYaQRwb5D9lOhWF5VSu/xxaw/GujRpNkNc=
Date:   Wed, 30 Dec 2020 14:09:17 +0300
From:   Sergei Poselenov <sposelenov@emcraft.com>
To:     linux-rt-users@vger.kernel.org
Subject: kernel crash with ARM64 5.4.47 preempt_rt
Message-ID: <20201230140917.50e86fc3@sergmir.emcraft.com>
Organization: Emcraft Systems
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

We applied patch-5.4.47-rt28.patch to NXP 5.4.47-2.2.0 release ARM64 kernel running on IMX8M NANO chip, and enabled CONFIG_PRREMPT_RT. We are observing the following crash (below), on a system running an application that communicates with some SPI device. Obviously, the system doesn't crash without the patch applied.

Any thoughts on the reason of the failure would be appreciated. How would we start debugging the problem?

Thanks!

Regards,
Sergei Poselenov,
Emcraft Systems

[   36.298369] 000: Unable to handle kernel paging request at virtual address 000000000024a848
[   36.298389] 000: Mem abort info:
[   36.298391] 000:   ESR = 0x96000004
[   36.298394] 000:   EC = 0x25: DABT (current EL), IL = 32 bits
[   36.298398] 000:   SET = 0, FnV = 0
[   36.298400] 000:   EA = 0, S1PTW = 0
[   36.298403] 000: Data abort info:
[   36.298405] 000:   ISV = 0, ISS = 0x00000004
[   36.298407] 000:   CM = 0, WnR = 0
[   36.298413] 000: user pgtable: 4k pages, 48-bit VAs, pgdp=0000000053e64000
[   36.298420] 000: [000000000024a848] pgd=0000000000000000
[   36.298424] 000: Internal error: Oops: 96000004 [#1] PREEMPT_RT SMP
[   36.298430] 000: Modules linked in: qca9377(O) crct10dif_ce
[   36.298440] 000: CPU: 0 PID: 409 Comm: mcumon Tainted: G           O      5.4.47-rt28-bsp_56-rt-20.12.28+gf164d986490b #1
[   36.298445] 000: Hardware name: Board i.MX8MNano DDR4 Lego board (DT)
[   36.298449] 000: pstate: 20000005 (nzCv daif -PAN -UAO)
[   36.298453] 000: pc : kmem_cache_free+0x22c/0x318
[   36.298467] 000: lr : free_uid+0x9c/0xb0
[   36.298475] 000: sp : ffff8000118cbcc0
[   36.298479] 000: x29: ffff8000118cbcc0 x28: ffff000013eb9528 
[   36.298485] 000: x27: ffff000013eb8e80 x26: 0000ffff807c969c 
[   36.298490] 000: x25: 0000000000000000 x24: 00000000400004d8 
[   36.298494] 000: x23: ffff8000100c4e2c x22: ffff8000112a1450 
[   36.298499] 000: x21: ffff8000112a1420 x20: 000000000024a840 
[   36.298504] 000: x19: ffff000012217000 x18: 0000000000000000 
[   36.298509] 000: x17: 0000000000000000 x16: 0000000000000000 
[   36.298514] 000: x15: 0000000000000000 x14: 0000000000000000 
[   36.298519] 000: x13: 0000000000000000 x12: 0000000000000000 
[   36.298524] 000: x11: 0000000000000000 x10: 0001800000018080 
[   36.298529] 000: x9 : 0000000000000000 x8 : 0000000000000000 
[   36.298533] 000: x7 : 000000000000001a x6 : 0000000000000001 
[   36.298538] 000: x5 : ffff8000112a1438 x4 : 0000000000000000 
[   36.298543] 000: x3 : ffff800004dbf000 x2 : 0000000000000000 
[   36.298548] 000: x1 : ffff8000112a1450 x0 : fffffdffffe00000 
[   36.298552] 000: Call trace:
[   36.298555] 000:  kmem_cache_free+0x22c/0x318
[   36.298559] 000:  free_uid+0x9c/0xb0
[   36.298563] 000:  collect_signal+0x184/0x198
[   36.298569] 000:  dequeue_signal+0x130/0x1f8
[   36.298574] 000:  get_signal+0x158/0x698
[   36.298579] 000:  do_notify_resume+0x17c/0x488
[   36.298586] 000:  work_pending+0x8/0x10
[   36.298598] 000: Code: b26babe0 d34cfe94 f2dfbfe0 8b141814 (f9400681) 
[   36.298604] 000: ---[ end trace 0000000000000002 ]---
[   36.298627] 000: ------------[ cut here ]------------
[   36.298629] 000: kernel BUG at kernel/locking/rtmutex.c:1047!
[   36.298632] 000: Internal error: Oops - BUG: 0 [#2] PREEMPT_RT SMP
[   36.298636] 000: Modules linked in: qca9377(O) crct10dif_ce
[   36.298642] 000: CPU: 0 PID: 409 Comm: mcumon Tainted: G      D    O      5.4.47-rt28-bsp_56-rt-20.12.28+gf164d986490b #1
[   36.298646] 000: Hardware name: Board i.MX8MNano DDR4 Lego board (DT)
[   36.298648] 000: pstate: 60000085 (nZCv daIf -PAN -UAO)
[   36.298652] 000: pc : rt_spin_lock_slowlock_locked+0x270/0x2a8
[   36.298661] 000: lr : rt_spin_lock_slowlock_locked+0x34/0x2a8
[   36.298665] 000: sp : ffff8000118cb7c0
[   36.298668] 000: x29: ffff8000118cb7c0 x28: ffff000013eb8e80 
[   36.298674] 000: x27: ffff000013eb8e80 x26: 0000ffff807c969c 
[   36.298679] 000: x25: 0000000000000000 x24: dead000000000100 
[   36.298683] 000: x23: ffff8000118cb858 x22: ffff000013eb8e80 
[   36.298688] 000: x21: 0000000000000000 x20: 0000000000000000 
[   36.298693] 000: x19: ffff000013e31100 x18: 0000000000000030 
[   36.298698] 000: x17: 0000000000000000 x16: 0000000000000000 
[   36.298703] 000: x15: ffff000013eb92f8 x14: ffffffffffffffff 
[   36.298708] 000: x13: ffff800011381600 x12: ffff8000118cb8c0 
[   36.298713] 000: x11: ffff8000112a40a8 x10: ffff8000112a40c0 
[   36.298718] 000: x9 : 0000000000000001 x8 : 0000000000000000 
[   36.298722] 000: x7 : 0000000000000000 x6 : 0000000000000048 
[   36.298727] 000: x5 : 0000000000000000 x4 : ffff000013e31118 
[   36.298732] 000: x3 : 0000000000000001 x2 : ffff000013eb8e81 
[   36.298737] 000: x1 : ffff000013eb8e80 x0 : ffff000013eb8e80 
[   36.298741] 000: Call trace:
[   36.298742] 000:  rt_spin_lock_slowlock_locked+0x270/0x2a8
[   36.298747] 000:  rt_spin_lock_slowlock+0x58/0x88
[   36.298751] 000:  rt_spin_lock+0x70/0x80
[   36.298756] 000:  sigqueue_free+0x28/0x80
[   36.298760] 000:  release_posix_timer+0x24/0x78
[   36.298768] 000:  exit_itimers+0x9c/0xc0
[   36.298772] 000:  do_exit+0xfc/0x980
[   36.298777] 000:  die+0x1fc/0x240
[   36.298779] 000:  die_kernel_fault+0x60/0x70
[   36.298786] 000:  __do_kernel_fault+0x84/0x120
[   36.298790] 000:  do_page_fault+0x1b4/0x460
[   36.298795] 000:  do_translation_fault+0x5c/0x78
[   36.298799] 000:  do_mem_abort+0x3c/0x98
[   36.298803] 000:  el1_da+0x1c/0x90
[   36.298806] 000:  kmem_cache_free+0x22c/0x318
[   36.298809] 000:  free_uid+0x9c/0xb0
[   36.298814] 000:  collect_signal+0x184/0x198
[   36.298819] 000:  dequeue_signal+0x130/0x1f8
[   36.298823] 000:  get_signal+0x158/0x698
[   36.298827] 000:  do_notify_resume+0x17c/0x488
[   36.298831] 000:  work_pending+0x8/0x10
[   36.298839] 000: Code: 17ffffad d4210000 97fff736 17ffff8f (d4210000) 
[   36.298842] 000: ---[ end trace 0000000000000003 ]---
[   36.298845] 000: Fixing recursive fault but reboot is needed!
[   36.298876] 000: ------------[ cut here ]------------
[   36.298879] 000: WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:571 rcu_idle_enter+0x78/0x80
[   36.298888] 000: Modules linked in: qca9377(O) crct10dif_ce
[   36.298894] 000: CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D    O      5.4.47-rt28-bsp_56-rt-20.12.28+gf164d986490b #1
[   36.298898] 000: Hardware name: Board i.MX8MNano DDR4 Lego board (DT)
[   36.298901] 000: pstate: 200003c5 (nzCv DAIF -PAN -UAO)
[   36.298904] 000: pc : rcu_idle_enter+0x78/0x80
[   36.298908] 000: lr : do_idle+0x1e0/0x288
[   36.298913] 000: sp : ffff800011283ec0
[   36.298916] 000: x29: ffff800011283ec0 x28: 0000000041460018 
[   36.298921] 000: x27: 000000005df0a6c8 x26: 0000000000000000 
[   36.298926] 000: x25: ffff000012b1d800 x24: ffff000015ed29c0 
[   36.298931] 000: x23: ffff800011294dc0 x22: ffff8000111139b8 
[   36.298935] 000: x21: ffff80001128e220 x20: 0000000000000000 
[   36.298940] 000: x19: ffff80001128e148 x18: 0000000000000030 
[   36.298945] 000: x17: 0000000000000000 x16: 0000000000000000 
[   36.298950] 000: x15: ffff000013eb92f8 x14: ffffffffffffffff 
[   36.298955] 000: x13: 00003ca316af8256 x12: 0000000000000000 
[   36.298960] 000: x11: 0000000000000001 x10: 0000000000000cb8 
[   36.298964] 000: x9 : ffff800011283e20 x8 : ffff800011295880 
[   36.298969] 000: x7 : ffff000015ed3c00 x6 : 0000000013268214 
[   36.298974] 000: x5 : 0000000000000b91 x4 : ffff800004dbf000 
[   36.298979] 000: x3 : 4000000000000002 x2 : 4000000000000000 
[   36.298984] 000: x1 : ffff800011115700 x0 : ffff000015ed4700 
[   36.298987] 000: Call trace:
[   36.298989] 000:  rcu_idle_enter+0x78/0x80
[   36.298992] 000:  do_idle+0x1e0/0x288
[   36.298996] 000:  cpu_startup_entry+0x20/0x40
[   36.299000] 000:  rest_init+0xd4/0xe0
[   36.299004] 000:  arch_call_rest_init+0xc/0x14
[   36.299011] 000:  start_kernel+0x41c/0x450
[   36.299015] 000: ---[ end trace 0000000000000004 ]---
[   36.341263] 000: ------------[ cut here ]------------
[   36.341276] 000: refcount_t: increment on 0; use-after-free.
[   36.341318] 000: WARNING: CPU: 0 PID: 330 at lib/refcount.c:156 refcount_inc_checked+0x40/0x48
[   36.341339] 000: Modules linked in: qca9377(O) crct10dif_ce
[   36.341349] 000: CPU: 0 PID: 330 Comm: systemd-journal Tainted: G      D W  O      5.4.47-rt28-bsp_56-rt-20.12.28+gf164d986490b #1
[   36.341353] 000: Hardware name: Board i.MX8MNano DDR4 Lego board (DT)
[   36.341356] 000: pstate: 60000005 (nZCv daif -PAN -UAO)
[   36.341360] 000: pc : refcount_inc_checked+0x40/0x48
[   36.341364] 000: lr : refcount_inc_checked+0x40/0x48
[   36.341368] 000: sp : ffff8000115fbda0
[   36.341371] 000: x29: ffff8000115fbda0 x28: ffff0000139e9d00 
[   36.341376] 000: x27: 0000000000000000 x26: ffff0000139e9d00 
[   36.341381] 000: x25: 0000000056000000 x24: 0000000000000015 
[   36.341385] 000: x23: 0000000040000000 x22: 0000000000000000 
[   36.341390] 000: x21: 0000ffff8f64aa38 x20: ffff0000131e8480 
[   36.341395] 000: x19: ffff0000125bb600 x18: 0000000000000000 
[   36.341399] 000: x17: 0000000000000000 x16: 0000000000000000 
[   36.341403] 000: x15: 0000000000000000 x14: 0000000000000000 
[   36.341407] 000: x13: 0000000000000000 x12: ffff8000115fbc80 
[   36.341411] 000: x11: ffff8000112a40a8 x10: ffff8000112a40c0 
[   36.341416] 000: x9 : 0000000000000001 x8 : 0000000000099450 
[   36.341420] 000: x7 : ffff80001137fda0 x6 : ffff80001137ed60 
[   36.341424] 000: x5 : 0000000000099450 x4 : 0000000000001040 
[   36.341428] 000: x3 : 0000000000000000 x2 : ffff8000112a40d0 
[   36.341433] 000: x1 : c73edc65b2401400 x0 : 0000000000000000 
[   36.341437] 000: Call trace:
[   36.341440] 000:  refcount_inc_checked+0x40/0x48
[   36.341444] 000:  prepare_creds+0x68/0xf8
[   36.341449] 000:  do_faccessat+0x40/0x260
[   36.341456] 000:  __arm64_sys_faccessat+0x1c/0x28
[   36.341460] 000:  el0_svc_common.constprop.0+0x68/0x160
[   36.341467] 000:  el0_svc_handler+0x20/0x80
[   36.341471] 000:  el0_svc+0x8/0xc
[   36.341477] 000: ---[ end trace 0000000000000005 ]---
[   36.341504] 000: ------------[ cut here ]------------
[   36.341506] 000: refcount_t: underflow; use-after-free.
[   36.341523] 000: WARNING: CPU: 0 PID: 330 at lib/refcount.c:288 refcount_dec_not_one+0xa4/0xb8
[   36.341529] 000: Modules linked in: qca9377(O) crct10dif_ce
[   36.341533] 000: CPU: 0 PID: 330 Comm: systemd-journal Tainted: G      D W  O      5.4.47-rt28-bsp_56-rt-20.12.28+gf164d986490b #1
[   36.341537] 000: Hardware name: Board i.MX8MNano DDR4 Lego board (DT)
[   36.341539] 000: pstate: 60000005 (nZCv daif -PAN -UAO)
[   36.341542] 000: pc : refcount_dec_not_one+0xa4/0xb8
[   36.341546] 000: lr : refcount_dec_not_one+0xa4/0xb8
[   36.341549] 000: sp : ffff8000115fbd20
[   36.341553] 000: x29: ffff8000115fbd20 x28: fffffffffffffffe 
[   36.341557] 000: x27: 0000000000000000 x26: ffff0000139e9d00 
[   36.341562] 000: x25: 0000000000000002 x24: 0000000000000010 
[   36.341565] 000: x23: 0000000000000000 x22: 0000000000000000 
[   36.341569] 000: x21: ffff8000115fbd90 x20: ffff8000112a1450 
[   36.341573] 000: x19: ffff8000112a1420 x18: 0000000000000000 
[   36.341577] 000: x17: 0000000000000000 x16: 0000000000000000 
[   36.341581] 000: x15: 0000000000000000 x14: 0000000000000000 
[   36.341585] 000: x13: ffff0000139e9d00 x12: ffff8000115fbc00 
[   36.341589] 000: x11: ffff8000112a40a8 x10: ffff8000112a40c0 
[   36.341594] 000: x9 : 0000000000000001 x8 : 00000000000aa8a0 
[   36.341598] 000: x7 : ffff8000113811f0 x6 : ffff80001137ed60 
[   36.341602] 000: x5 : 00000000000aa8a0 x4 : 0000000000002490 
[   36.341606] 000: x3 : 0000000000000000 x2 : ffff8000112a40d0 
[   36.341611] 000: x1 : c73edc65b2401400 x0 : 0000000000000000 
[   36.341614] 000: Call trace:
[   36.341615] 000:  refcount_dec_not_one+0xa4/0xb8
[   36.341619] 000:  refcount_dec_and_lock_irqsave+0x20/0xf8
[   36.341623] 000:  free_uid+0x3c/0xb0
[   36.341629] 000:  put_cred_rcu+0x70/0x118
[   36.341634] 000:  __put_cred+0x50/0x68
[   36.341638] 000:  do_faccessat+0x1fc/0x260
[   36.341642] 000:  __arm64_sys_faccessat+0x1c/0x28
[   36.341645] 000:  el0_svc_common.constprop.0+0x68/0x160
[   36.341650] 000:  el0_svc_handler+0x20/0x80
[   36.341655] 000:  el0_svc+0x8/0xc
[   36.341658] 000: ---[ end trace 0000000000000006 ]---
[   57.653584] 000: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   57.653606] 000: rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-0): P409
[   57.653615] 000:     (detected by 0, t=5252 jiffies, g=10889, q=1042)
[   57.653621] 000: mcumon          D    0   409      1 0x00000221
[   57.653628] 000: Call trace:
[   57.653629] 000:  __switch_to+0x104/0x170
[   57.653650] 000:  __schedule+0x238/0x608
[   57.653657] 000:  schedule+0x40/0xe8
[   57.653662] 000:  do_exit+0x978/0x980
[   57.653669] 000:  die+0x1fc/0x240
[   57.653673] 000:  bug_handler+0x44/0x80
[   57.653677] 000:  brk_handler+0x68/0xc0
[   57.653682] 000:  do_debug_exception+0xbc/0x178
[   57.653687] 000:  el1_dbg+0x18/0x8c
[   57.653691] 000:  rt_spin_lock_slowlock_locked+0x270/0x2a8
[   57.653697] 000:  rt_spin_lock_slowlock+0x58/0x88
[   57.653702] 000:  rt_spin_lock+0x70/0x80
[   57.653707] 000:  sigqueue_free+0x28/0x80
[   57.653713] 000:  release_posix_timer+0x24/0x78
[   57.653720] 000:  exit_itimers+0x9c/0xc0
[   57.653726] 000:  do_exit+0xfc/0x980
[   57.653729] 000:  die+0x1fc/0x240
[   57.653733] 000:  die_kernel_fault+0x60/0x70
[   57.653740] 000:  __do_kernel_fault+0x84/0x120
[   57.653744] 000:  do_page_fault+0x1b4/0x460
[   57.653749] 000:  do_translation_fault+0x5c/0x78
[   57.653754] 000:  do_mem_abort+0x3c/0x98
[   57.653757] 000:  el1_da+0x1c/0x90
[   57.653761] 000:  kmem_cache_free+0x22c/0x318
[   57.653767] 000:  free_uid+0x9c/0xb0
[   57.653773] 000:  collect_signal+0x184/0x198
[   57.653778] 000:  dequeue_signal+0x130/0x1f8
[   57.653782] 000:  get_signal+0x158/0x698
[   57.653786] 000:  do_notify_resume+0x17c/0x488
[   57.653792] 000:  work_pending+0x8/0x10
[  120.681757] 000: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  120.681775] 000: rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-0): P409
[  120.681784] 000:     (detected by 0, t=21007 jiffies, g=10889, q=1832)
[  120.681790] 000: mcumon          D    0   409      1 0x00000221
[  120.681797] 000: Call trace:
[  120.681798] 000:  __switch_to+0x104/0x170
[  120.681815] 000:  __schedule+0x238/0x608
[  120.681826] 000:  schedule+0x40/0xe8
[  120.681830] 000:  do_exit+0x978/0x980
[  120.681836] 000:  die+0x1fc/0x240
[  120.681841] 000:  bug_handler+0x44/0x80
[  120.681845] 000:  brk_handler+0x68/0xc0
[  120.681849] 000:  do_debug_exception+0xbc/0x178
[  120.681853] 000:  el1_dbg+0x18/0x8c
[  120.681857] 000:  rt_spin_lock_slowlock_locked+0x270/0x2a8
[  120.681864] 000:  rt_spin_lock_slowlock+0x58/0x88
[  120.681869] 000:  rt_spin_lock+0x70/0x80
[  120.681875] 000:  sigqueue_free+0x28/0x80
[  120.681880] 000:  release_posix_timer+0x24/0x78
[  120.681888] 000:  exit_itimers+0x9c/0xc0
[  120.681893] 000:  do_exit+0xfc/0x980
[  120.681897] 000:  die+0x1fc/0x240
[  120.681900] 000:  die_kernel_fault+0x60/0x70
[  120.681907] 000:  __do_kernel_fault+0x84/0x120
[  120.681911] 000:  do_page_fault+0x1b4/0x460
[  120.681916] 000:  do_translation_fault+0x5c/0x78
[  120.681921] 000:  do_mem_abort+0x3c/0x98
[  120.681924] 000:  el1_da+0x1c/0x90
[  120.681927] 000:  kmem_cache_free+0x22c/0x318
[  120.681933] 000:  free_uid+0x9c/0xb0
[  120.681940] 000:  collect_signal+0x184/0x198
[  120.681945] 000:  dequeue_signal+0x130/0x1f8
[  120.681950] 000:  get_signal+0x158/0x698
[  120.681954] 000:  do_notify_resume+0x17c/0x488
[  120.681959] 000:  work_pending+0x8/0x10

Board-Robot login: 
Board-Robot login: 
Board-Robot login: [  183.722728] 000: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  183.722751] 000: rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-0): P409
[  183.722761] 000:     (detected by 0, t=36762 jiffies, g=10889, q=2605)
[  183.722767] 000: mcumon          D    0   409      1 0x00000221
[  183.722774] 000: Call trace:
[  183.722775] 000:  __switch_to+0x104/0x170
[  183.722791] 000:  __schedule+0x238/0x608
[  183.722799] 000:  schedule+0x40/0xe8
[  183.722804] 000:  do_exit+0x978/0x980
[  183.722811] 000:  die+0x1fc/0x240
[  183.722815] 000:  bug_handler+0x44/0x80
[  183.722819] 000:  brk_handler+0x68/0xc0
[  183.722824] 000:  do_debug_exception+0xbc/0x178
[  183.722828] 000:  el1_dbg+0x18/0x8c
[  183.722831] 000:  rt_spin_lock_slowlock_locked+0x270/0x2a8
[  183.722837] 000:  rt_spin_lock_slowlock+0x58/0x88
[  183.722842] 000:  rt_spin_lock+0x70/0x80
[  183.722847] 000:  sigqueue_free+0x28/0x80
[  183.722852] 000:  release_posix_timer+0x24/0x78
[  183.722860] 000:  exit_itimers+0x9c/0xc0
[  183.722865] 000:  do_exit+0xfc/0x980
[  183.722869] 000:  die+0x1fc/0x240
[  183.722872] 000:  die_kernel_fault+0x60/0x70
[  183.722879] 000:  __do_kernel_fault+0x84/0x120
[  183.722883] 000:  do_page_fault+0x1b4/0x460
[  183.722887] 000:  do_translation_fault+0x5c/0x78
[  183.722892] 000:  do_mem_abort+0x3c/0x98
[  183.722896] 000:  el1_da+0x1c/0x90
[  183.722900] 000:  kmem_cache_free+0x22c/0x318
[  183.722905] 000:  free_uid+0x9c/0xb0
[  183.722911] 000:  collect_signal+0x184/0x198
[  183.722917] 000:  dequeue_signal+0x130/0x1f8
[  183.722921] 000:  get_signal+0x158/0x698
[  183.722925] 000:  do_notify_resume+0x17c/0x488
[  183.722930] 000:  work_pending+0x8/0x10
