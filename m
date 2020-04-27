Return-Path: <SRS0=jUvr=6L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED7C4CECC
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 19:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8795F206B8
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 19:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgD0Tzt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:55:49 -0400
Received: from mail.monom.org ([188.138.9.77]:44782 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgD0Tzt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Apr 2020 15:55:49 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id BD690500592;
        Mon, 27 Apr 2020 21:55:46 +0200 (CEST)
Received: from localhost (b9168f17.cgn.dg-w.de [185.22.143.23])
        by mail.monom.org (Postfix) with ESMTPSA id 1C7645002C0;
        Mon, 27 Apr 2020 21:55:46 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.220-rt196
Date:   Mon, 27 Apr 2020 19:49:20 -0000
Message-ID: <158801696068.26039.9162549222309574579@beryllium>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.220-rt196 stable release.

This release is just an update to the new stable 4.4.215 version
and no RT specific changes have been made.

Known issues:

  I've updated my test setup and during all rt-tests there is now a
  background workload running. sigwaittest with hackbench as workload is
  able to trigger a crash on x86_64 but not on ARMv7. It's not clear if
  this existed for a longer period already or if it's new.

  [   41.148863] BUG: unable to handle kernel paging request at 00000000ffffffff
  [   41.148871] IP: [<ffffffff8118fce3>] kmem_cache_alloc_node+0xc3/0x1e0
  [   41.148873] PGD 0 
  [   41.148874] Oops: 0000 [#1] PREEMPT SMP 
  [   41.148877] Modules linked in:
  [   41.148879] CPU: 1 PID: 4394 Comm: hackbench Not tainted 4.4.220-rt195+ #9
  [   41.148880] Hardware name: wortmann G31M-ES2L/G31M-S2L, BIOS F10 09/29/2009
  [   41.148881] task: ffff8800ca89a7c0 ti: ffff8800cb39c000 task.ti: ffff8800cb39c000
  [   41.148884] RIP: 0010:[<ffffffff8118fce3>]  [<ffffffff8118fce3>] kmem_cache_alloc_node+0xc3/0x1e0
  [   41.148885] RSP: 0018:ffff8800cb39fbd8  EFLAGS: 00010246
  [   41.148886] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000005021c81
  [   41.148886] RDX: 0000000005021c41 RSI: 0000000005021c41 RDI: 00000000000186e0
  [   41.148887] RBP: ffff8800cb39fc18 R08: ffffffff8172abcb R09: 0000000000000003
  [   41.148888] R10: 0000000000000000 R11: 0000000000000246 R12: ffff88012b001700
  [   41.148888] R13: 00000000ffffffff R14: 00000000ffffffff R15: 00000000024004c0
  [   41.148889] FS:  00007fe50befd740(0000) GS:ffff88012fc80000(0000) knlGS:0000000000000000
  [   41.148890] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   41.148891] CR2: 00000000ffffffff CR3: 00000000c8562000 CR4: 0000000000040670
  [   41.148891] Stack:
  [   41.148893]  ffffea0003137ec0 ffffea00031b62c0 ffffffff8172abcb 0000000000000001
  [   41.148895]  ffff8800cb39fd00 ffff88012b001700 0000000000000000 00000000024004c0
  [   41.148896]  ffff8800cb39fc60 ffffffff8172abcb ffffffff024200ca ffff8800cb3a0000
  [   41.148897] Call Trace:
  [   41.148901]  [<ffffffff8172abcb>] ? __alloc_skb+0x4b/0x1c0
  [   41.148903]  [<ffffffff8172abcb>] __alloc_skb+0x4b/0x1c0
  [   41.148904]  [<ffffffff8172ad9e>] alloc_skb_with_frags+0x5e/0x1d0
  [   41.148906]  [<ffffffff8172682d>] sock_alloc_send_pskb+0x1bd/0x1e0
  [   41.148909]  [<ffffffff81805a84>] unix_stream_sendmsg+0x244/0x390
  [   41.148912]  [<ffffffff81722530>] sock_sendmsg+0x40/0x50
  [   41.148914]  [<ffffffff817225bf>] sock_write_iter+0x7f/0xd0
  [   41.148917]  [<ffffffff81199eb8>] __vfs_write+0xb8/0xf0
  [   41.148918]  [<ffffffff8119a98a>] vfs_write+0xba/0x1d0
  [   41.148920]  [<ffffffff8119b61f>] SyS_write+0x4f/0xd0
  [   41.148923]  [<ffffffff8192f1ca>] entry_SYSCALL_64_fastpath+0x1e/0x93
  [   41.148939] Code: 00 00 74 51 48 85 c0 0f 84 2c 01 00 00 49 63 54 24 1c 31 f6 4c 89 ef e8 9c c7 1e 00 eb 37 49 63 44 24 20 49 8b 3c 24 48 8d 4a 40 <49> 8b 5c 05 00 4c 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 64 
  [   41.148940] RIP  [<ffffffff8118fce3>] kmem_cache_alloc_node+0xc3/0x1e0
  [   41.148941]  RSP <ffff8800cb39fbd8>
  [   41.148941] CR2: 00000000ffffffff
  [   41.384003] ---[ end trace 0000000000000002 ]---


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 2a1573bd8805c11aa1cce2998bc55396633e596b

Or to build 4.4.220-rt196 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.220.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.220-rt196.patch.xz


You can also build from 4.4.215-rt192 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.215-rt192-rt196.patch.xz

Enjoy!
Daniel
