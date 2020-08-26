Return-Path: <SRS0=PXli=CE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D77FC433E1
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Aug 2020 08:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B2920866
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Aug 2020 08:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHZIIH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:08:07 -0400
Received: from mail.monom.org ([188.138.9.77]:45854 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgHZIIG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Aug 2020 04:08:06 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 73A7550035A;
        Wed, 26 Aug 2020 10:08:03 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 13A6D500317;
        Wed, 26 Aug 2020 10:08:03 +0200 (CEST)
Date:   Wed, 26 Aug 2020 10:08:02 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On Mon, Aug 24, 2020 at 05:46:05PM +0200, Sebastian Andrzej Siewior wrote:
> I'm pleased to announce the v5.9-rc2-rt1 patch set.

I gave it a quick run on my test system. Can't boot the system at this
point. Didn't look closer at it, maybe it's something obvious...

 stack segment: 0000 [#1] PREEMPT_RT SMP PTI
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc2-rt1 #1
 Hardware name: wortmann G31M-ES2L/G31M-S2L, BIOS F10 09/29/2009
 RIP: 0010:intel_pipe_update_start+0x139/0x5f0
 Code: ed 7c a1 ff 48 8d 83 b8 05 00 00 48 89 c5 48 89 04 24 e8 ea 75 51 00 89 c0 48 03 2c c5 a0 26 0e a0 65 48 8b 04 25 80 6c 01 00 <48> 39 45 30 0f 84 4a 01 00 00 48 89 ef e8 35 e2 51 00 8b 35 b7 42
 RSP: 0000:ffffbc3d800179c8 EFLAGS: 00010287
 
 RAX: ffff9c91ab220000 RBX: ffff9c91aaac6800 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffffffffa0015367 RDI: ffffffffa003f1de
 RBP: ffff3923566c6db8 R08: 0000000000000000 R09: 0000000000000001
 R10: ffff9c91ab292b90 R11: 00000000000000ba R12: 00000000000001e8
 R13: ffff9c91a9e9cc30 R14: 00000000000001e4 R15: 00000000000001e7
 FS:  0000000000000000(0000) GS:ffff9c91abc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000000ac41a000 CR4: 00000000000406f0
 Call Trace:
  ? preempt_count_add+0x68/0xa0
  ? _raw_spin_lock+0x13/0x30
  ? wait_woken+0x90/0x90
  intel_update_crtc+0xa7/0x360
  ? wait_woken+0x90/0x90
  intel_commit_modeset_enables+0x5e/0x80
  intel_atomic_commit_tail+0x311/0x1210
  ? __queue_work+0x372/0x540
  ? migrate_enable+0x11b/0x430
  intel_atomic_commit+0x357/0x3e0
  intel_modeset_init+0x84d/0x1e50
  i915_driver_probe+0x95d/0xe00
  i915_pci_probe+0x44/0x120
  local_pci_probe+0x26/0x50
  pci_device_probe+0xd5/0x160
  really_probe+0xdb/0x2e0
  device_driver_attach+0x53/0x60
  __driver_attach+0x4c/0xc0
  ? device_driver_attach+0x60/0x60
  bus_for_each_dev+0x7b/0xc0
  bus_add_driver+0x17a/0x1c0
  driver_register+0x6c/0xc0
  ? mipi_dsi_bus_init+0x11/0x11
  i915_init+0x58/0x6b
  do_one_initcall+0x46/0x274
  kernel_init_freeable+0x199/0x1dc
  ? rest_init+0xba/0xba
  kernel_init+0xa/0x106
  ret_from_fork+0x22/0x30
 Modules linked in:
 
 Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
 Kernel Offset: 0x1de00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Thanks,
Daniel
