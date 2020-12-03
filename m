Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B4DC0018C
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 14:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1C520705
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 14:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgLCOGh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 09:06:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:55945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgLCOGg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 09:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607004295;
        bh=itK/InP4p0KmEq1VEw9LAS50y9tgkW7Dqrpv+2niPyg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Np4addABKXK8cKYIFErB2Ba9xeGSUwB0K4rnsGwCgBF0zgGRarMPt7Tg2fNULh1jD
         FyQIdk3p3YHNPWTgP+gYcQ45iIKJCjo3QnIhW3Og5/sUpDuBW9EfuRNwUIye4Vr/L6
         gwBdSlbkmkdaYvUTGZEJfdsehWfb/o9h66viUCKo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1kAxFA3Hck-00dHa0; Thu, 03
 Dec 2020 15:04:54 +0100
Message-ID: <03bd2c15e611d7b8bb74cf9ecb20d15fab31e067.camel@gmx.de>
Subject: Re: zswap explosion when using zsmalloc pool compression
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Date:   Thu, 03 Dec 2020 15:04:53 +0100
In-Reply-To: <f19f4df85d2469e5d186268f60be2657b7b8e99f.camel@gmx.de>
References: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <345fdb33f5bc0046b80c6319e61e9ee33b83cac6.camel@gmx.de>
         <20201203094805.dhk3f7mlth3vm6ck@linutronix.de>
         <2b297170dbf98b36526f876650a2707e59d4ae92.camel@gmx.de>
         <7d4e36c78320ec01b56a12bc14ac3ddce3e26827.camel@gmx.de>
         <13b102c659c2880fcd98541a2844f0f9a028826e.camel@gmx.de>
         <f19f4df85d2469e5d186268f60be2657b7b8e99f.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tj/0Br4Hac7I/qJ9dA7i2xRXhTmc888dh7HaQeU4HnyHq8ONo+6
 Kdxumq3eVdDSxxro+LuWBkYDMwGIXDFhiBTz1IaejFo7DRQUQOQcmPHty5Axd/Suxw/0DGJ
 9xlIzqGTivchD6qXS+63EBAcPCvNyKhEN8Q0h79M3YyKDsjVX3wcp2lu2lyPptd7gO/OwsK
 /JFj719kXwFpPSGC7WOsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EXTAoXxjHWw=:R/6jmaoqgECsPCgs4E+Q5m
 /BEJhmiMSk06PgWMLi3RBdpjLRbAkaOdNEXL0lIP9PuHErvsIQZL6tCPXVkwAA0bhVtmMSXgp
 fMde/zVbflPXixO/o+Mkd72Bvseu77fW+ZMNr/kFBY9Og/pUg/rk5shGH4sjHm21Ho6H14QFO
 XnKYJAz+/kzFEAtYaPDGOWqcmnB1h72varaKgFeOt2CF20ZresCXzy+HSgpVP0UYAmKDkBiAz
 K4fzi/iB6jcwbqteFQeGoNhV7m+ZJ0n7fcd+PhL9L6BhNLc8nWrADgKeRfesYlA44IDUpkmk/
 80kg1lx0MzQmmc35iv5ZxFCin3/CbepM+yyJd/G8lifd+qt3oS0Mq+Z07+YPKK/oUHdgt0Kqg
 bIOJ8qb2RM5JR/FMmhEgm+i8AjeBTimLJyxBdvA9FHWk3iO0JVMrx4vcoKYIz2PHRN2mC0BHI
 TBUEjBaRHIDlfFs+zB4Ak4cNW2y/PzK3rDUFrQHtdBDhcpKg9uVSegD7WunXzXpt96ZbDXb5c
 YfYocE4hLQziYZrJr6SxgV6rslm4odX3KQcCQW0qXw1kyhaFgk8z4ZXau6X66/44hhNDGT4uM
 qusugLgxoc7RuP8bQmEkhb2ebjbWC/y54mDSMEMkzbVW/5HsF9Pe/TntTdbgDcmD9ChEItTf5
 nzF30kVYNRhr2dIAwt7MY7pZZP03ni1xX+Ct4JK95MEXlKOBfk6E4sSr5JmirHUanwjc1s8w8
 tVa5Ekye23VV6SDSYikd/ctcunuZ1R8jztzLcJqvuhoCMmzYY2s7Zr7evd7YjWJj3FZs8w4HU
 3XzFwA8TCo0AnlUvK16T8VIlklSJHOI+k8nSmZOObcq+/fEzuEZ6GVyhvVDOyoxq2qo9PMoRC
 w7IkU2YPevmT1h3QmCsA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-12-03 at 14:43 +0100, Mike Galbraith wrote:
> Well crap.  I lost the zswap local_lock initialization fix in my 5.9-rt
> tree during an update, so will have to retest.

:) tadaaaa

[  484.806634] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  484.806634] WARNING: possible circular locking dependency detected
[  484.806635] 5.9.12-rt20-rt #22 Tainted: G S          E   =20
[  484.806636] ------------------------------------------------------
[  484.806637] systemd-udevd/13633 is trying to acquire lock:
[  484.806638] ffff9441dede95f0 ((lock).lock#4){+.+.}-{2:2}, at: zswap_fron=
tswap_load+0x19a/0x3c0
[  484.806645]=20
               but task is already holding lock:
[  484.806646] ffff9441dede9db0 ((lock).lock#5){+.+.}-{2:2}, at: zs_map_obj=
ect+0x10d/0x3d0
[  484.806651]=20
               which lock already depends on the new lock.
              =20
[  484.806651]=20
               the existing dependency chain (in reverse order) is:
[  484.806652]=20
               -> #2 ((lock).lock#5){+.+.}-{2:2}:
[  484.806654]        lock_acquire+0x2b7/0x420
[  484.806656]        rt_spin_lock+0x2b/0xc0
[  484.806659]        zs_map_object+0x10d/0x3d0
[  484.806661]        zswap_frontswap_store+0x716/0xa50
[  484.806662]        __frontswap_store+0x6e/0x100
[  484.806663]        swap_writepage+0x37/0x70
[  484.806665]        shmem_writepage+0x267/0x400
[  484.806667]        pageout+0xd2/0x400
[  484.806668]        shrink_page_list+0xa6e/0xbd0
[  484.806669]        shrink_inactive_list+0x216/0x620
[  484.806670]        shrink_lruvec+0x39f/0x5e0
[  484.806672]        shrink_node+0x237/0x6e0
[  484.806673]        do_try_to_free_pages+0xb9/0x400
[  484.806674]        try_to_free_pages+0xe6/0x3b0
[  484.806675]        __alloc_pages_slowpath.constprop.108+0x3f8/0x1090
[  484.806676]        __alloc_pages_nodemask+0x3f6/0x480
[  484.806677]        alloc_pages_vma+0x135/0x190
[  484.806679]        handle_mm_fault+0x87c/0x16f0
[  484.806681]        exc_page_fault+0x343/0x720
[  484.806683]        asm_exc_page_fault+0x1e/0x30
[  484.806684]=20
               -> #1 (&zh->lock){+.+.}-{0:0}:
[  484.806686]        lock_acquire+0x2b7/0x420
[  484.806687]        _mutex_lock+0x28/0x40
[  484.806688]        zs_map_object+0x53/0x3d0
[  484.806689]        zswap_frontswap_store+0x716/0xa50
[  484.806691]        __frontswap_store+0x6e/0x100
[  484.806692]        swap_writepage+0x37/0x70
[  484.806693]        shmem_writepage+0x267/0x400
[  484.806694]        pageout+0xd2/0x400
[  484.806695]        shrink_page_list+0xa6e/0xbd0
[  484.806696]        shrink_inactive_list+0x216/0x620
[  484.806697]        shrink_lruvec+0x39f/0x5e0
[  484.806698]        shrink_node+0x237/0x6e0
[  484.806699]        do_try_to_free_pages+0xb9/0x400
[  484.806700]        try_to_free_pages+0xe6/0x3b0
[  484.806701]        __alloc_pages_slowpath.constprop.108+0x3f8/0x1090
[  484.806702]        __alloc_pages_nodemask+0x3f6/0x480
[  484.806703]        alloc_pages_vma+0x135/0x190
[  484.806704]        handle_mm_fault+0x87c/0x16f0
[  484.806705]        exc_page_fault+0x343/0x720
[  484.806706]        asm_exc_page_fault+0x1e/0x30
[  484.806707]=20
               -> #0 ((lock).lock#4){+.+.}-{2:2}:
[  484.806709]        validate_chain+0xa4a/0x13e0
[  484.806710]        __lock_acquire+0x862/0xbc0
[  484.806711]        lock_acquire+0x2b7/0x420
[  484.806712]        rt_spin_lock+0x2b/0xc0
[  484.806713]        zswap_frontswap_load+0x19a/0x3c0
[  484.806715]        __frontswap_load+0x6e/0xd0
[  484.806716]        swap_readpage+0x88/0x240
[  484.806717]        swap_cluster_readahead+0x1cc/0x290
[  484.806718]        shmem_swapin+0x93/0xd0
[  484.806719]        shmem_swapin_page+0x2a3/0x6b0
[  484.806720]        shmem_getpage_gfp+0x321/0x700
[  484.806721]        shmem_file_read_iter+0x1a0/0x3a0
[  484.806722]        new_sync_read+0x10d/0x180
[  484.806724]        vfs_read+0x1a8/0x1d0
[  484.806725]        ksys_read+0x87/0xc0
[  484.806727]        do_syscall_64+0x33/0x40
[  484.806728]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  484.806729]=20
               other info that might help us debug this:
              =20
[  484.806730] Chain exists of:
                 (lock).lock#4 --> &zh->lock --> (lock).lock#5
              =20
[  484.806732]  Possible unsafe locking scenario:
              =20
[  484.806733]        CPU0                    CPU1
[  484.806733]        ----                    ----
[  484.806733]   lock((lock).lock#5);
[  484.806735]                                lock(&zh->lock);
[  484.806735]                                lock((lock).lock#5);
[  484.806736]   lock((lock).lock#4);
[  484.806736]=20
                *** DEADLOCK ***
              =20
[  484.806737] 5 locks held by systemd-udevd/13633:
[  484.806737]  #0: ffff9441ae089370 (&zh->lock){+.+.}-{0:0}, at: zs_map_ob=
ject+0x53/0x3d0
[  484.806741]  #1: ffff94412d6b0b38 (&zspage->lock){.+.+}-{0:0}, at: zs_ma=
p_object+0x93/0x3d0
[  484.806744]  #2: ffffffff825981a0 (rcu_read_lock){....}-{1:2}, at: rt_re=
ad_lock+0x5d/0x160
[  484.806747]  #3: ffff9441dede9db0 ((lock).lock#5){+.+.}-{2:2}, at: zs_ma=
p_object+0x10d/0x3d0
[  484.806750]  #4: ffffffff825981a0 (rcu_read_lock){....}-{1:2}, at: rt_sp=
in_lock+0x5/0xc0
[  484.806753]=20
               stack backtrace:
[  484.806754] CPU: 7 PID: 13633 Comm: systemd-udevd Kdump: loaded Tainted:=
 G S          E     5.9.12-rt20-rt #22
[  484.806755] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  484.806756] Call Trace:
[  484.806758]  dump_stack+0x77/0x97
[  484.806761]  check_noncircular+0x14d/0x160
[  484.806766]  ? validate_chain+0xa4a/0x13e0
[  484.806767]  validate_chain+0xa4a/0x13e0
[  484.806770]  __lock_acquire+0x862/0xbc0
[  484.806773]  lock_acquire+0x2b7/0x420
[  484.806774]  ? zswap_frontswap_load+0x19a/0x3c0
[  484.806778]  rt_spin_lock+0x2b/0xc0
[  484.806780]  ? zswap_frontswap_load+0x19a/0x3c0
[  484.806781]  zswap_frontswap_load+0x19a/0x3c0
[  484.806784]  __frontswap_load+0x6e/0xd0
[  484.806787]  swap_readpage+0x88/0x240
[  484.806789]  swap_cluster_readahead+0x1cc/0x290
[  484.806794]  ? shmem_swapin+0x93/0xd0
[  484.806796]  shmem_swapin+0x93/0xd0
[  484.806797]  ? find_held_lock+0x2d/0x90
[  484.806799]  ? find_get_entry+0x11a/0x2d0
[  484.806807]  shmem_swapin_page+0x2a3/0x6b0
[  484.806808]  ? find_get_entry+0x132/0x2d0
[  484.806812]  shmem_getpage_gfp+0x321/0x700
[  484.806816]  shmem_file_read_iter+0x1a0/0x3a0
[  484.806820]  new_sync_read+0x10d/0x180
[  484.806824]  vfs_read+0x1a8/0x1d0
[  484.806827]  ksys_read+0x87/0xc0
[  484.806828]  ? syscall_trace_enter.isra.15+0x8e/0x2b0
[  484.806832]  do_syscall_64+0x33/0x40
[  484.806834]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  484.806835] RIP: 0033:0x7f4c9ef9c1a1
[  484.806837] Code: fe ff ff 48 8d 3d 67 a1 09 00 48 83 ec 08 e8 e6 03 02 =
00 66 0f 1f 44 00 00 8b 05 0a d2 2c 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <48=
> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48 89
[  484.806839] RSP: 002b:00007ffd400c69e8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[  484.806840] RAX: ffffffffffffffda RBX: 000055da146ae940 RCX: 00007f4c9ef=
9c1a1
[  484.806841] RDX: 0000000000001000 RSI: 000055da1467bd20 RDI: 00000000000=
0000f
[  484.806842] RBP: 0000000000000d68 R08: 0000000000000000 R09: 00000000000=
00000
[  484.806843] R10: fffffffffffffe60 R11: 0000000000000246 R12: 00007f4c9f2=
647a0
[  484.806843] R13: 00007f4c9f2652e0 R14: 0000000000000d68 R15: 00000000000=
003cf
[  485.546571] ------------[ cut here ]------------
[  485.546574] kernel BUG at kernel/locking/rtmutex.c:1057!
[  485.546579] invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
[  485.546581] CPU: 4 PID: 13626 Comm: oom01 Kdump: loaded Tainted: G S    =
      E     5.9.12-rt20-rt #22
[  485.546583] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  485.546584] RIP: 0010:rt_spin_lock_slowlock_locked+0x29c/0x2b0
[  485.546589] Code: 88 d0 00 01 e8 a5 a5 76 ff e9 ce fe ff ff 48 8b 43 48 =
48 85 c0 74 06 48 3b 58 38 75 0f 49 39 c4 0f 85 69 ff ff ff 0f 0b 0f 0b <0f=
> 0b e8 ed 23 77 ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f
[  485.546590] RSP: 0000:ffffa5610be6f6d8 EFLAGS: 00010086
[  485.546592] RAX: 00000000ffffffdd RBX: ffff9441ded29d20 RCX: 00000000000=
00000
[  485.546593] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9441ded=
29d20
[  485.546593] RBP: ffff94412d509b40 R08: 0000000000000001 R09: 00000000000=
00000
[  485.546594] R10: ffffa5610be6f5f8 R11: 000000000000063e R12: ffffa5610be=
6f720
[  485.546595] R13: ffff94412d509b40 R14: ffff94412d50a4d0 R15: 00000000000=
00282
[  485.546595] FS:  00007ff63eb08700(0000) GS:ffff9441ded00000(0000) knlGS:=
0000000000000000
[  485.546597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  485.546597] CR2: 00007ff1f9e2f000 CR3: 0000000313dd6004 CR4: 00000000001=
706e0
[  485.546598] Call Trace:
[  485.546603]  rt_spin_lock_slowlock+0x4b/0x70
[  485.546607]  rt_spin_lock+0x46/0xc0
[  485.546609]  ? zs_map_object+0x10d/0x3d0
[  485.546612]  zs_map_object+0x10d/0x3d0
[  485.546616]  zswap_frontswap_store+0x716/0xa50
[  485.546620]  __frontswap_store+0x6e/0x100
[  485.546623]  swap_writepage+0x37/0x70
[  485.546625]  pageout+0xd2/0x400
[  485.546630]  shrink_page_list+0xa6e/0xbd0
[  485.546634]  shrink_inactive_list+0x216/0x620
[  485.546639]  shrink_lruvec+0x39f/0x5e0
[  485.546641]  ? lock_acquire+0x201/0x420
[  485.546647]  ? shrink_node+0x237/0x6e0
[  485.546649]  shrink_node+0x237/0x6e0
[  485.546652]  do_try_to_free_pages+0xb9/0x400
[  485.546655]  try_to_free_pages+0xe6/0x3b0
[  485.546660]  __alloc_pages_slowpath.constprop.108+0x3f8/0x1090
[  485.546662]  ? lock_release+0xf6/0x300
[  485.546665]  ? try_to_wake_up+0x70/0x750
[  485.546668]  ? lock_release+0xf6/0x300
[  485.546671]  __alloc_pages_nodemask+0x3f6/0x480
[  485.546673]  alloc_pages_vma+0x135/0x190
[  485.546677]  handle_mm_fault+0x87c/0x16f0
[  485.546680]  ? trace_hardirqs_on+0x35/0x130
[  485.546686]  exc_page_fault+0x343/0x720
[  485.546689]  ? asm_exc_page_fault+0x8/0x30
[  485.546691]  ? asm_exc_page_fault+0x8/0x30
[  485.546693]  asm_exc_page_fault+0x1e/0x30
[  485.546694] RIP: 0033:0x414300
[  485.546696] Code: e8 d5 f5 fe ff 48 83 f8 ff 0f 84 9c 00 00 00 41 83 fd =
02 48 89 c5 74 32 41 83 fd 03 74 74 49 63 c4 48 89 ea 66 0f 1f 44 00 00 <c6=
> 02 07 48 01 c2 48 89 d1 48 29 e9 48 39 cb 7f ef 31 c0 48 83 c4
[  485.546697] RSP: 002b:00007ff63eb07ec0 EFLAGS: 00010206
[  485.546698] RAX: 0000000000001000 RBX: 00000000c0000000 RCX: 000000003d3=
2a000
[  485.546699] RDX: 00007ff1f9e2f000 RSI: 00000000c0000000 RDI: 00000000000=
00000
[  485.546700] RBP: 00007ff1bcb05000 R08: ffffffffffffffff R09: 00000000000=
00000
[  485.546700] R10: 0000000000000022 R11: 0000000000000246 R12: 00000000000=
01000
[  485.546701] R13: 0000000000000001 R14: 0000000000000001 R15: 00007ffe3fd=
317f0
[  485.546706] Modules linked in: fuse(E) xt_comment(E) ebtable_filter(E) e=
btables(E) br_netfilter(E) xt_physdev(E) nfnetlink_cthelper(E) nfnetlink(E)=
 msr(E) af_packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) xt_pkttype(E) xt_tcpudp(E) ip6t_REJECT(E) ipt_REJECT(E) iptab=
le_filter(E) bpfilter(E) ip6table_mangle(E) ip_tables(E) xt_conntrack(E) nf=
_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) ip6table_fil=
ter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_cp437(E) intel_rapl_m=
sr(E) joydev(E) usblp(E) intel_rapl_common(E) x86_pkg_temp_thermal(E) intel=
_powerclamp(E) coretemp(E) at24(E) kvm_intel(E) kvm(E) irqbypass(E) crct10d=
if_pclmul(E) crc32_pclmul(E) snd_hda_codec_realtek(E) snd_hda_codec_generic=
(E) ghash_clmulni_intel(E) ledtrig_audio(E) aesni_intel(E) crypto_simd(E) c=
ryptd(E) glue_helper(E) mei_hdcp(E) snd_hda_codec_hdmi(E) iTCO_wdt(E) iTCO_=
vendor_support(E) snd_hda_intel(E) snd_intel_dspcfg(E) snd_hda_codec(E) snd=
_hda_core(E) r8169(E) pcspkr(E)
[  485.546742]  snd_hwdep(E) i2c_i801(E) i2c_smbus(E) snd_pcm(E) realtek(E)=
 mdio_devres(E) snd_timer(E) libphy(E) snd(E) mei_me(E) soundcore(E) lpc_ic=
h(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) tiny_power_button(E) sc=
h_fq_codel(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E)=
 hid_logitech_hidpp(E) sr_mod(E) cdrom(E) hid_logitech_dj(E) ums_realtek(E)=
 uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) wmi(E) i2c_algo_=
bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_=
fops(E) ahci(E) cec(E) ehci_pci(E) libahci(E) rc_core(E) xhci_pci(E) ehci_h=
cd(E) ttm(E) libata(E) xhci_hcd(E) drm(E) usbcore(E) video(E) button(E) sd_=
mod(E) t10_pi(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_ring(E)=
 virtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E=
) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) =
scsi_mod(E)
[  485.546783] Dumping ftrace buffer:
[  485.546787]    (ftrace buffer empty)

