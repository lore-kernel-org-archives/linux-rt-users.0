Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF4C64E8A
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 11:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA13621D91
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 11:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388903AbgLCLEq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 06:04:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:49371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388620AbgLCLEp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 06:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606993392;
        bh=9+nbOrXwLJSC+W7DSVLzLP7U34ixrGEowGrDbS6eeWE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=imnJRMJ/fhLqoVSSUsrAhzoOYA6obamY1b35vU4yq9sp8ssnEKzy/dWZyaXIrnGW0
         8ush9hLlX+H01QuXoK/AKlLOnK+BTMnLSzkRD3wteEvzdrywvMGpXkOrjJOmwG4IgO
         /7xrc5VhfIL7NNxpjLHi/99zu9FzCNnPtR0gNjdA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1kZkoS0Fg0-00SeJo; Thu, 03
 Dec 2020 12:03:12 +0100
Message-ID: <2b297170dbf98b36526f876650a2707e59d4ae92.camel@gmx.de>
Subject: Re: zswap explosion when using zsmalloc pool compression
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Date:   Thu, 03 Dec 2020 12:03:11 +0100
In-Reply-To: <20201203094805.dhk3f7mlth3vm6ck@linutronix.de>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wzf2ux7iY1baGuh3o5iJNxQREK76XgF/MeG1sqVJ1QAFayzMScC
 MuJJ5ZIl+YR7k/hjB+LOqwR0iYAiyiy7BzlwL8HD7Q4oL2jIMQ965JKeGM1DiO+On00x0l1
 9ihdZ6ShM5ad1avmTGEYRyuCaoqrcvntvtfjzppAQkyvi1qqXgmMA+nWK1o/2ddsHldRyQ7
 kMchudJjpVtzxVAsaLftQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r3X0u48/svY=:q7oTRAYFbRjT+taH5b+1C1
 PG3L21z4Capi6LLD6+4ifPopCUyJANCA8m9z2sETCiNdo+hYoMjfDP1bGHr3p0p9Tge4WwLPj
 9v0RqBr6wdBQgRr1LqvkZfLVx8TyJ03aynHpnsezhuZLtSbWVymnA5cquK+NijsEvGgotYSDx
 17HGAFBLAsfgLhYvcHgVwrfJq2Y4PYEOymGrTLhb9grFQt1J168UpH/oNHmjJ598z2w0J+IJy
 ZOTglabcQwZMQblSt62B426PlOreH36lkwPkj06x/zzvzinSNLbck5HRGp2wVFG31fOaOX9AH
 9Dw91Yck5U4q6xwuoNkqencrKcuh+aaS55E3qEJ647FPmDrN1poKn2ZJBB5B53hbe4dEYCfYj
 RU0hPAGowG0vgT7GXgwMROzK2wNAhanjEeWCBhj4pIwI+3Rl/IDjeibIgunc+Dz1HiZDI54pU
 ERqX8GOB494/VLxd6/us80bKrkH8JRp8t6xw+HJie0lbujm9668T4qGaHgI8nlL44Nk60+FPl
 K7BrRDWosQpNcnwdJVak7DWaHro2EhpWq17EMQUsX1dKUOtTonSGameOoZXZgj+5lR2Huk5p2
 /mNcaJY2XuyLV8SB1rx38M7BomaLdpaQJbxi39Kxa356JmYiNRbNNTi1R/pr7CCk8Kumq9e0w
 SjGv9GPoGdgP9n64Xa3YW8fJ7nlyR3Ew04ijttEanrxQu9QYLlXVcvfk41bVWnPTahtuZxi3k
 hI7NvcdNB/nIT9S9JmVIxlXZI8ZEHNegiLZUDUSeGf8YXJeQJSwD0QhNmMiYKgpZSYEEeTcyL
 jsDm/WEN60DVGXYPd2UnuLRFdLg11UFBIZEC4cpo6pNweNV5FAWxaiwLNfDsj5iZ3RhTnLRiV
 dD0Cy33pkzDoJJO/LJfQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-12-03 at 10:48 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-03 10:40:16 [+0100], Mike Galbraith wrote:
> > In thread "scheduling while atomic in z3fold", I mentioned that of the
> > three pool methods, only zbud did not explode.  Below is the explosion
> > encountered when zsmalloc is used in conjunction with runltp -f mm.  A=
s
> > with the z3fold explosion, this one also seems to be highly repeatable=
,
> > this from one of my full distro "my box plays russian dolls [1]" KVMs.
>
> great.
>
> > [ 5763.720268] kernel BUG at kernel/locking/rtmutex.c:1057!
> =E2=80=A6
> > [ 5763.726016] RAX: 00000000ffffffdd RBX: ffff903f77c68080 RCX: 000000=
0000000001
>
> That is a deadlock. Does lockdep say anything or does it disable the bug
> from happening?

The later, for the first time it did not explode.  However...

[  458.195604] BUG: spinlock bad magic on CPU#1, oom01/9449
[  458.195609]  lock: 0xffff980db7c69560, .magic: 00000000, .owner: <none>=
/-1, .owner_cpu: 0
[  458.195613] CPU: 1 PID: 9449 Comm: oom01 Kdump: loaded Tainted: G      =
      E     5.9.12-rt20-rt #19
[  458.195615] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  458.195616] Call Trace:
[  458.195617]  dump_stack+0x77/0x97
[  458.195633]  do_raw_spin_lock+0x71/0xc0
[  458.195644]  _raw_spin_lock_irqsave+0x45/0x50
[  458.195650]  ? rt_spin_lock_slowlock+0x3a/0x70
[  458.195652]  rt_spin_lock_slowlock+0x3a/0x70
[  458.195656]  rt_spin_lock+0x46/0xc0
[  458.195658]  ? zswap_frontswap_store+0x26e/0xa50
[  458.195665]  zswap_frontswap_store+0x26e/0xa50
[  458.195667]  ? rt_mutex_futex_unlock+0x56/0x80
[  458.195668]  __frontswap_store+0x6e/0x100
[  458.195670]  swap_writepage+0x37/0x70
[  458.195671]  shmem_writepage+0x267/0x400
[  458.195674]  pageout+0xd2/0x400
[  458.195677]  shrink_page_list+0xa6e/0xbd0
[  458.195679]  shrink_inactive_list+0x216/0x620
[  458.195683]  shrink_lruvec+0x39f/0x5e0
[  458.195689]  ? shrink_node+0x237/0x6e0
[  458.195694]  shrink_node+0x237/0x6e0
[  458.195697]  do_try_to_free_pages+0xb9/0x400
[  458.195698]  try_to_free_pages+0xe6/0x3b0
[  458.195701]  __alloc_pages_slowpath.constprop.108+0x3f8/0x1090
[  458.195705]  __alloc_pages_nodemask+0x3f6/0x480
[  458.195707]  alloc_pages_vma+0x135/0x190
[  458.195711]  handle_mm_fault+0x87c/0x16f0
[  458.195715]  ? lockdep_hardirqs_on+0x79/0x100
[  458.195718]  exc_page_fault+0x343/0x720
[  458.195720]  ? asm_exc_page_fault+0x1e/0x30
[  458.195722]  ? asm_exc_page_fault+0x8/0x30
[  458.195723]  asm_exc_page_fault+0x1e/0x30
[  458.195724] RIP: 0033:0x414300
[  458.195726] Code: e8 d5 f5 fe ff 48 83 f8 ff 0f 84 9c 00 00 00 41 83 fd=
 02 48 89 c5 74 32 41 83 fd 03 74 74 49 63 c4 48 89 ea 66 0f 1f 44 00 00 <=
c6> 02 07 48 01 c2 48 89 d1 48 29 e9 48 39 cb 7f ef 31 c0 48 83 c4
[  458.195730] RSP: 002b:00007f1e1d790ec0 EFLAGS: 00010206
[  458.195731] RAX: 0000000000001000 RBX: 00000000c0000000 RCX: 0000000041=
6a8000
[  458.195731] RDX: 00007f1cdde38000 RSI: 00000000c0000000 RDI: 0000000000=
000000
[  458.195732] RBP: 00007f1c9c790000 R08: ffffffffffffffff R09: 0000000000=
000000
[  458.195732] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000=
001000
[  458.195733] R13: 0000000000000001 R14: 0000000000000001 R15: 00007ffe1f=
97c860

