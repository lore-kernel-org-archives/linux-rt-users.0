Return-Path: <SRS0=1fdT=7P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B7AC433DF
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jun 2020 07:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD29820734
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jun 2020 07:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgFBH2u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:28:50 -0400
Received: from mail.monom.org ([188.138.9.77]:47480 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBH2t (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Jun 2020 03:28:49 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 04877500626;
        Tue,  2 Jun 2020 09:28:47 +0200 (CEST)
Received: from localhost (b9168f17.cgn.dg-w.de [185.22.143.23])
        by mail.monom.org (Postfix) with ESMTPSA id 95CE250026A;
        Tue,  2 Jun 2020 09:28:46 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.225-rt198
Date:   Tue, 02 Jun 2020 07:24:26 -0000
Message-ID: <159108266692.10828.13848245676748143171@beryllium>
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

I'm pleased to announce the 4.4.225-rt198 stable release.

This release is just an update to the new stable 4.4.215 version
and no RT specific changes have been made.

Known issues:

  sigwaittest with hackbench as workload is able to trigger a crash on x86_64,
  the same as reported for the v4.4.220-rt196 release.

  BUG: unable to handle kernel paging request at 00000000ffffffff
  IP: [<ffffffff81190003>] kmem_cache_alloc_node+0xc3/0x1e0
  PGD 0 
  Oops: 0000 [#1] PREEMPT SMP 
  Modules linked in:
  CPU: 0 PID: 5215 Comm: hackbench Not tainted 4.4.225-rt197+ #6
  Hardware name: wortmann G31M-ES2L/G31M-S2L, BIOS F10 09/29/2009
  task: ffff8800c2fb4f80 ti: ffff8800c2a04000 task.ti: ffff8800c2a04000
  RIP: 0010:[<ffffffff81190003>]  [<ffffffff81190003>] kmem_cache_alloc_node+0xc3/0x1e0
  RSP: 0018:ffff8800c2a07bd8  EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000006551900
  RDX: 00000000065518c0 RSI: 00000000065518c0 RDI: 00000000000186e0
  RBP: ffff8800c2a07c18 R08: ffffffff8172b71b R09: 0000000000000003
  R10: 0000000000000000 R11: 0000000000000246 R12: ffff88012b001700
  R13: 00000000ffffffff R14: 00000000ffffffff R15: 00000000024004c0
  FS:  00007f94bc703740(0000) GS:ffff88012fc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000ffffffff CR3: 00000000c2f90000 CR4: 0000000000040670
  Stack:
   ffffea0004a24a80 ffffea000323f940 ffffffff8172b71b 0000000000000001
   ffff8800c2a07d00 ffff88012b001700 0000000000000000 00000000024004c0
   ffff8800c2a07c60 ffffffff8172b71b ffffffff024200ca ffff8800c2a08000
  Call Trace:
   [<ffffffff8172b71b>] ? __alloc_skb+0x4b/0x1c0
   [<ffffffff8172b71b>] __alloc_skb+0x4b/0x1c0
   [<ffffffff8172b8ee>] alloc_skb_with_frags+0x5e/0x1d0
   [<ffffffff8172738d>] sock_alloc_send_pskb+0x1bd/0x1e0
   [<ffffffff81806804>] unix_stream_sendmsg+0x244/0x390
   [<ffffffff81723090>] sock_sendmsg+0x40/0x50
   [<ffffffff8172311f>] sock_write_iter+0x7f/0xd0
   [<ffffffff8119a1d8>] __vfs_write+0xb8/0xf0
   [<ffffffff8119acaa>] vfs_write+0xba/0x1d0
   [<ffffffff8119b93f>] SyS_write+0x4f/0xd0
   [<ffffffff8193024a>] entry_SYSCALL_64_fastpath+0x1e/0x93
  Code: 00 00 74 51 48 85 c0 0f 84 2c 01 00 00 49 63 54 24 1c 31 f6 4c 89 ef e8 cc d0 1e 00 eb 37 49 63 44 24 20 49 8b 3c 24 48 8d 4a 40 <49> 8b 5c 05 00 4c 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 64 


You can get this release via the git tree at:
  
    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
  
    branch: v4.4-rt
    Head SHA1: fa195796a1c5385a6e6b41c343b861067770f9c7
  
  Or to build 4.4.225-rt198 directly, the following patches should be applied:
  
    https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz
  
    https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.225.xz
  
    https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.225-rt198.patch.xz
  
  
  You can also build from 4.4.220-rt197 by applying the incremental patch:
  
    https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.220-rt197-rt198.patch.xz
  
  Enjoy!
  Daniel
  
