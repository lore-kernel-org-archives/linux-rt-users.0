Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD136C05027
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Jan 2023 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjAWQF2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjAWQF0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Jan 2023 11:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A667A80
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Jan 2023 08:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674489877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FbPwkDLsC8aZ6kGUlTGF3Ek+DwE18WKxvlvdoxvzrIM=;
        b=LGWzBsMmjmFF3Zrnr4uxAmqhlksbF8HfbgYdBNwftrPpAhi79uEWSuV/G52aNPql3U7Qe8
        Yw/tTO21k/pj17chStXoQ+4cZ/87V6Z/NqMtlXie+1D4E+OYHTmzqEfmfzclO+RYrv92lv
        JKzk42TwXb2ccecpa0kJyKnSvC4cKKA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-108-VgPQxTSyOvOGLmy2cc9R6Q-1; Mon, 23 Jan 2023 11:04:35 -0500
X-MC-Unique: VgPQxTSyOvOGLmy2cc9R6Q-1
Received: by mail-qk1-f200.google.com with SMTP id u11-20020a05620a430b00b007052a66d201so9199140qko.23
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Jan 2023 08:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbPwkDLsC8aZ6kGUlTGF3Ek+DwE18WKxvlvdoxvzrIM=;
        b=gVr1YScwYI5UZf6TpbXKNEiPQFc9wHZjwzXA03R7NUESlczinNCFP/OOU9BxxMOdHE
         MRZGeXQX8A5Vdqo9mlksp96Bcrt/hlQpma86KKDFoemawXbCHtwCOjPppoNIQJc2hJAA
         lxaWmg7fnPeppm7gR/NpHaTHH215CleV2VDadLQD3PKeClWSdSsBGr6QNHTTb11rS2ua
         JRkZGGsnqzcr+gCt0nCGgT1so2M9knr6Ytpv5F6mHQDC92zzjuTPhVle3lntnGRz52Jo
         g6GbY9kfFeEjk0V7IFhj1FMCIrniM3j1BKgmeaN43PB5luff6g/xSG6433YmGCaI+dN4
         O53g==
X-Gm-Message-State: AFqh2kohB/Rk1pviLH2E4laiG6FGLV0dSymqjVLbArZYZaj08L41FXNZ
        3QvWc+906ndD6jpjcUuBvpgC9XmZ5yGUV7Tb7OFipDrjA8DY4xU6/i6jp/1+bk2ipMZ5IiMlnaZ
        SRBu++Sgmxxu7QBEd0xvUG5E1aak=
X-Received: by 2002:ac8:6f09:0:b0:3a8:1789:73b1 with SMTP id bs9-20020ac86f09000000b003a8178973b1mr41100053qtb.2.1674489874695;
        Mon, 23 Jan 2023 08:04:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtIsvzbuPBsHbUSrJ8rX/SalVZf2cS6umogOV4Qtr/Gp7vUpCzIbOp8aKl+J2sKoNfn+ZvlzQ==
X-Received: by 2002:ac8:6f09:0:b0:3a8:1789:73b1 with SMTP id bs9-20020ac86f09000000b003a8178973b1mr41100023qtb.2.1674489874321;
        Mon, 23 Jan 2023 08:04:34 -0800 (PST)
Received: from localhost.localdomain ([176.206.23.228])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8711a000000b003b62dcbedb8sm12646963qto.74.2023.01.23.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:04:33 -0800 (PST)
Date:   Mon, 23 Jan 2023 17:04:30 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RT] i915 sleeping function from atomic in gen6_reset_engines()
Message-ID: <Y86wDg/EZfJOnlwJ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I've just noticed the following while testing v6.2-rc3-rt1.

# lspci -k | grep -EA3 'VGA|3D|Display'
00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3 Processor Integrated Graphics Controller (rev 06)
        DeviceName:  Onboard IGD
        Subsystem: Dell Device 0620
        Kernel driver in use: i915
 
---

[   11.960670] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[   11.960672] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 429, name: systemd-udevd
[   11.960673] preempt_count: 1, expected: 0
[   11.960674] RCU nest depth: 0, expected: 0
[   11.960674] 2 locks held by systemd-udevd/429:
[   11.960675]  #0: ffff8e1f022b71b0 (&dev->mutex){....}-{3:3}, at: __driver_attach+0xcb/0x1d0
[   11.960684]  #1: ffff8e1e27d32ed8 (&uncore->lock){+.+.}-{2:2}, at: gen6_reset_engines+0x1b/0x50 [i915]
[   11.960897] Preemption disabled at:
[   11.960898] [<ffffffffc07d5d62>] __intel_gt_reset+0x92/0x100 [i915]
[   11.961024] CPU: 3 PID: 429 Comm: systemd-udevd Not tainted 6.2.0-rc3-rt1 #1
[   11.961025] Hardware name: Dell Inc. PowerEdge T20/0VD5HY, BIOS A03 11/25/2013
[   11.961026] Call Trace:
[   11.961027]  <TASK>
[   11.961029]  ? __intel_gt_reset+0x92/0x100 [i915]
[   11.961155]  dump_stack_lvl+0x57/0x81
[   11.961160]  __might_resched.cold+0xf4/0x12f
[   11.961165]  rt_spin_lock+0x4a/0xe0
[   11.961169]  ? gen6_reset_engines+0x1b/0x50 [i915]
[   11.961294]  ? __pfx_gen6_reset_engines+0x10/0x10 [i915]
[   11.961453]  gen6_reset_engines+0x1b/0x50 [i915]
[   11.961579]  __intel_gt_reset+0xa0/0x100 [i915]
[   11.961708]  i915_driver_mmio_probe+0x126/0x220 [i915]
[   11.961815]  ? intel_gt_probe_all+0x70/0x280 [i915]
[   11.961939]  i915_driver_probe+0xd4/0x3c0 [i915]
[   11.962047]  ? i915_pci_probe+0x87/0x1b0 [i915]
[   11.962160]  local_pci_probe+0x45/0x80
[   11.962167]  pci_call_probe+0x56/0x170
[   11.962173]  pci_device_probe+0x79/0xf0
[   11.962175]  ? driver_sysfs_add+0x73/0xd0
[   11.962179]  really_probe+0xe1/0x390
[   11.962181]  ? pm_runtime_barrier+0x50/0x90
[   11.962187]  __driver_probe_device+0x78/0x180
[   11.962191]  driver_probe_device+0x1e/0x90
[   11.962195]  __driver_attach+0xd6/0x1d0
[   11.962197]  ? __pfx___driver_attach+0x10/0x10
[   11.962201]  bus_for_each_dev+0x7b/0xc0
[   11.962206]  bus_add_driver+0x1b2/0x200
[   11.962212]  driver_register+0x8f/0xf0
[   11.962215]  i915_init+0x20/0x80 [i915]
[   11.962337]  ? __pfx_init_module+0x10/0x10 [i915]
[   11.962461]  do_one_initcall+0x47/0x190
[   11.962467]  ? rcu_read_lock_sched_held+0x43/0x80
[   11.962471]  ? trace_kmalloc+0x3c/0x160
[   11.962473]  ? kmalloc_trace+0x44/0x60
[   11.962476]  do_init_module+0x4c/0x200
[   11.962480]  __do_sys_finit_module+0xb4/0x130
[   11.962497]  do_syscall_64+0x5c/0x90
[   11.962505]  ? do_syscall_64+0x69/0x90
[   11.962507]  ? lockdep_hardirqs_on+0x79/0x100
[   11.962511]  ? do_syscall_64+0x69/0x90
[   11.962513]  ? do_syscall_64+0x69/0x90
[   11.962515]  ? lockdep_hardirqs_on+0x79/0x100
[   11.962518]  ? do_syscall_64+0x69/0x90
[   11.962520]  ? lockdep_hardirqs_on+0x79/0x100
[   11.962523]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   11.962526] RIP: 0033:0x7fa35d020e5d
[   11.962529] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89
                     d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73
		     01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   11.962530] RSP: 002b:00007ffd62f23a78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   11.962532] RAX: ffffffffffffffda RBX: 000056058a1429e0 RCX: 00007fa35d020e5d
[   11.962533] RDX: 0000000000000000 RSI: 00007fa35d25232c RDI: 0000000000000017
[   11.962534] RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
[   11.962534] R10: 0000000000000017 R11: 0000000000000246 R12: 00007fa35d25232c
[   11.962535] R13: 000056058a147360 R14: 0000000000000007 R15: 000056058a12b790
[   11.962548]  </TASK>
[   11.964024] i915 0000:00:02.0: vgaarb: deactivate vga console
[   11.974095] Console: switching to colour dummy device 80x25
[   11.981308] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   12.041808] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0

---

Looks like this discussion might be relevant [1], but I'm not sure if
progress has been made after that.

Thanks!
Juri

1 - https://lore.kernel.org/all/20211006164628.s2mtsdd2jdbfyf7g@linutronix.de/

