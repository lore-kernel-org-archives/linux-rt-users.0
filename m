Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A6C43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 10:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiFXKS4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 06:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiFXKSz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 06:18:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0687A6D9
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 03:18:54 -0700 (PDT)
Date:   Fri, 24 Jun 2022 12:18:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656065932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/KAd8kHwLLqxgjifoKlOVRGBC45zaEN/8ij3Kk2vY4=;
        b=TfOzORdoYaqGkq7pjj6sCKlnr9Pjd81pif5otx/MhpS6Jutrzqw563j3qatZL/prXnB1Oj
        fZiSXWpzODz3gsP0hDSN1fK6CVKfiNEP1t29wRbSP8PsjXQ1oUs90Q7igvFz3JLfQyZsAe
        W/PhwvJCSbfkwApkZQVRIvBWZZVs6EmiEejOH/CwlbWr6z5zmxVUmXKqLKae5MGefUQRLY
        UfVpZnM6dOYE8Fih83adHcqqV/iMnJ+tFNw4gibuIg2qiSKtZLRIANnfpNMiuz4LawGp1Q
        VFHWxnwcNnc3rkS78bTk3DRpAQW5w9Mpz5fmGQSOkDxZwQiI7a8Z029zAIY4Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656065932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/KAd8kHwLLqxgjifoKlOVRGBC45zaEN/8ij3Kk2vY4=;
        b=uLD6ctKK7ewMH41rBpu0fzK7P9/EUzaEiRVZdrmWs7xDnbjM0fF4BRSEtkCDT7jFIY6mLE
        3hup06LZ2TX/29BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
Message-ID: <YrWPiwtk0kAWxXI9@linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
 <YrV4795StT13AUC+@linutronix.de>
 <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

+ John

On 2022-06-24 11:52:26 [+0200], Mike Galbraith wrote:
> On Fri, 2022-06-24 at 10:42 +0200, Sebastian Andrzej Siewior wrote:
> > On 2022-06-18 11:25:39 [+0200], Mike Galbraith wrote:
> > > I haven't done any digging to see why this now happens where it
> > > previously did not.
> >
> > I don't see where interrupts have been disabled but they have been. The
> > printk path should yell earlier but did not the crng path is kind of
> > late and I don't see anything obvious in between.
> 
> Allegedly vprintk_store().
> 
> (gdb) list *vprintk_store+0x3cc
> 0xffffffff8114283c is in vprintk_store (kernel/printk/printk.c:2280).
> warning: Source file is more recent than executable.
> 2275            u32 caller_id;
> 2276            u16 text_len;
> 2277            int ret = 0;
> 2278            u64 ts_nsec;
> 2279
> 2280            if (!printk_enter_irqsave(recursion_ptr, irqflags))
> 2281                    return 0;
> 2282
> 2283            /*
> 2284             * Since the duration of printk() can vary depending on the message
> (gdb)

ehm. Why do we need to keep interrupts disabled for vsnprintf()?
Wouldn't it work to move that lock a few lines below where it is
actually needed?

> [    6.520357] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [    6.520358] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 399, name: systemd-udevd
> [    6.520359] preempt_count: 0, expected: 0
> [    6.520359] RCU nest depth: 1, expected: 1
> [    6.520360] 5 locks held by systemd-udevd/399:
> [    6.520361]  #0: ffff909a815821a8 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xa1/0x170
> [    6.520367]  #1: ffff909a912b0a98 (&helper->lock){+.+.}-{3:3}, at: drm_fb_helper_initial_config+0x26/0x40 [drm_kms_helper]
> [    6.520383]  #2: ffffffffbd8e91b8 (filling){....}-{2:2}, at: default_pointer+0x17e/0x2d0
> [    6.520387]  #3: ffffffffbd7929a0 (rcu_read_lock){....}-{1:2}, at: rt_spin_trylock+0x36/0xd0
> [    6.520391]  #4: ffff909d8ea335a0 ((crngs.lock)){+.+.}-{2:2}, at: crng_make_state+0x76/0x1c0
> [    6.520394] irq event stamp: 843364
> [    6.520394] hardirqs last  enabled at (843363): [<ffffffffbc7dfb10>] _raw_spin_unlock_irqrestore+0x30/0x77
> [    6.520397] hardirqs last disabled at (843364): [<ffffffffbbd4283c>] vprintk_store+0x3cc/0x550
> [    6.520399] softirqs last  enabled at (151950): [<ffffffffbbcb8223>] __local_bh_enable_ip+0xc3/0x150
> [    6.520401] softirqs last disabled at (151944): [<ffffffffbbe8c135>] btf_alloc_id+0x5/0xb0
> [    6.520404] CPU: 0 PID: 399 Comm: systemd-udevd Tainted: G        W   E     5.19.0.gca1fdab-master-rt #5 2262f40963ee88d2873a82a86160b299ace0d165
> [    6.520406] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [    6.520407] Call Trace:
> [    6.520408]  <TASK>
> [    6.520409]  dump_stack_lvl+0x55/0x6d
> [    6.520413]  __might_resched+0x1aa/0x1e0
> [    6.520418]  rt_spin_lock+0x4d/0xe0
> [    6.520419]  ? crng_make_state+0x76/0x1c0
> [    6.520422]  crng_make_state+0x76/0x1c0
> [    6.520426]  _get_random_bytes.part.16+0x4e/0x110
> [    6.520428]  ? rt_spin_trylock+0x36/0xd0
> [    6.520432]  ? preempt_count_sub+0x43/0x50
> [    6.520434]  ? rt_spin_trylock+0x8b/0xd0
> [    6.520435]  ? rt_spin_trylock+0x8b/0xd0
> [    6.520438]  ? migrate_disable+0x119/0x120
> [    6.520442]  default_pointer+0x2a0/0x2d0
> [    6.520448]  vsnprintf+0x35a/0x4c0
> [    6.520449]  ? kernel_text_address+0xaa/0xc0
> [    6.520454]  va_format.isra.16+0x6e/0xa0
> [    6.520459]  vsnprintf+0x35a/0x4c0
> [    6.520464]  vprintk_store+0x150/0x550
> [    6.520468]  ? string+0x40/0x50
> [    6.520472]  ? vsnprintf+0x48f/0x4c0
> [    6.520480]  vprintk_emit+0x44/0x170
> [    6.520482]  ? __lock_acquire+0xb9d/0x18b0
> [    6.520487]  dev_vprintk_emit+0x185/0x1ae
> [    6.520494]  ? lock_is_held_type+0xb2/0x110
> [    6.520499]  ? dev_printk_emit+0x4a/0x66
> [    6.520501]  ? mark_held_locks+0x49/0x70
> [    6.520502]  dev_printk_emit+0x4a/0x66
> [    6.520506]  ? preempt_count_sub+0x43/0x50
> [    6.520510]  _dev_info+0x64/0x80
> [    6.520518]  nouveau_fbcon_create+0x2d4/0x500 [nouveau adfaa6c52e612d43880f223e1d4b1d7b83facd58]
> [    6.520615]  __drm_fb_helper_initial_config_and_unlock+0x336/0x5f0 [drm_kms_helper 8e2e6f207f0cb44a547a65ef3965573df1212de6]
> [    6.520635]  nouveau_fbcon_init+0x180/0x1f0 [nouveau adfaa6c52e612d43880f223e1d4b1d7b83facd58]
> [    6.520706]  nouveau_drm_device_init+0x1f7/0x860 [nouveau adfaa6c52e612d43880f223e1d4b1d7b83facd58]
> [    6.520778]  ? pci_update_current_state+0x65/0xa0
> [    6.520785]  nouveau_drm_probe+0x11b/0x220 [nouveau adfaa6c52e612d43880f223e1d4b1d7b83facd58]
> [    6.520856]  local_pci_probe+0x42/0x90
> [    6.520860]  pci_device_probe+0x176/0x240
> [    6.520862]  ? sysfs_do_create_link_sd.isra.2+0x68/0xd0
> [    6.520869]  really_probe+0x108/0x3d0
> [    6.520873]  __driver_probe_device+0x100/0x170
> [    6.520876]  driver_probe_device+0x1f/0xa0
> [    6.520879]  __driver_attach+0xac/0x170
> [    6.520881]  ? __device_attach_driver+0xe0/0xe0
> [    6.520884]  ? __device_attach_driver+0xe0/0xe0
> [    6.520886]  bus_for_each_dev+0x76/0xc0
> [    6.520890]  bus_add_driver+0x19f/0x240
> [    6.520893]  ? 0xffffffffc06ec000
> [    6.520896]  driver_register+0x5b/0xf0
> [    6.520898]  ? 0xffffffffc06ec000
> [    6.520899]  do_one_initcall+0x58/0x3d0
> [    6.520903]  ? trace_kmalloc+0xb6/0x140
> [    6.520905]  ? kmem_cache_alloc_trace+0x13c/0x1c0
> [    6.520907]  ? do_init_module+0x22/0x1fc
> [    6.520914]  do_init_module+0x4b/0x1fc
> [    6.520918]  load_module+0x18d2/0x2380
> [    6.520936]  ? __do_sys_finit_module+0xaf/0x120
> [    6.520937]  __do_sys_finit_module+0xaf/0x120
> [    6.520948]  do_syscall_64+0x58/0x80
> [    6.520951]  ? do_syscall_64+0x67/0x80
> [    6.520953]  ? lockdep_hardirqs_on_prepare+0xd8/0x170
> [    6.520957]  ? do_syscall_64+0x67/0x80
> [    6.520958]  ? do_syscall_64+0x67/0x80
> [    6.520962]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [    6.520965] RIP: 0033:0x7f911ee69ec9
> [    6.520967] Code: 2e 00 b8 ca 00 00 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 7f 2d 00 f7 d8 64 89 01 48
> [    6.520968] RSP: 002b:00007ffe6427de98 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [    6.520969] RAX: ffffffffffffffda RBX: 0000558cc2ab38a0 RCX: 00007f911ee69ec9
> [    6.520970] RDX: 0000000000000000 RSI: 00007f911f7dd79d RDI: 000000000000001b
> [    6.520971] RBP: 00007f911f7dd79d R08: 0000000000000000 R09: 0000558cc2a939a0
> [    6.520971] R10: 000000000000001b R11: 0000000000000246 R12: 0000000000020000
> [    6.520972] R13: 0000558cc2abec00 R14: 0000000000000000 R15: 0000558cc2ac7f80

Sebastian
