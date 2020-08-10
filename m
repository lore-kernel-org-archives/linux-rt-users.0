Return-Path: <SRS0=EAED=BU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4287C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Aug 2020 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF5206E9
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Aug 2020 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9TpahFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgHJNgv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:36:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40261 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726518AbgHJNgu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Aug 2020 09:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597066606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=/MBBPUkRGxre/AAvOqJU5HhtXINTwhr1RAwI6jkA3nw=;
        b=X9TpahFz5gvWOJoSawDHVyBfo70xiXg2Z0WuDpT4nU6vdQ131at1YLysKjVl5XQ/nY8d7w
        2qtC1TrEQxQxFgDqtbfP9KHV8xPkpxyC/oq7Hb1/Eh2g4Rd3Ri4nMHt9nJ/mwRTPQnbV1z
        /kM6Ri3LOV9DcdSXGY668jiomtp1n8A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-UNyB32ClMJqTCs9d7GAz2A-1; Mon, 10 Aug 2020 09:36:45 -0400
X-MC-Unique: UNyB32ClMJqTCs9d7GAz2A-1
Received: by mail-wm1-f71.google.com with SMTP id h205so2884184wmf.0
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Aug 2020 06:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=/MBBPUkRGxre/AAvOqJU5HhtXINTwhr1RAwI6jkA3nw=;
        b=aWtAhzd/w7l/ZDfStvnRKxBf6EBjnrLxGfJuvDmHhNZL0S+O8IJgdif7FegIPgCIVy
         eUTMzRmRhLhn1jL73bUaWG66Dwl/3eeKdDqi2nMEH611JqqKnY8RIISMXQ/ygZ7FJzn4
         i2O44IqUbY+kFOlP1e2Xn3LhVpQX30ZoNe9PZOrQLAUCbI2cYp1YnwXkimK3+1BIzdr6
         ZGkVcK+61OzIU3v0MkGeCl+bHOoiPdJMQsJR/84E1UrqxtEcVlzp/+pAl3Et2a9358zi
         GrEuf51dWjiUJjHK+oaYoaXWc/v45CqJ/I2u7ZSL3VFTU4wfEJAlg/h3qGzgarhMvk/7
         NXsw==
X-Gm-Message-State: AOAM530Wl+e2QT7xWcy9qN8bsSPD6uYT5qDkBBwFVaaPs2Pp9euUFNlh
        Q6ZClDZO1M6JvE8Iezue5m5GReGsvqN+WwoS3SunKAuNklD3kk9eA7n+h75WPi1NzD5T0ApemOh
        UzhQT1SiXcGY3Yka9AmWBfOZWczk=
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr27215613wml.133.1597066603234;
        Mon, 10 Aug 2020 06:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV+GWwYpaGIXPv+dgZtx9i+Bsm6fXzRTzYpWmbyNvqlexgk1Ob4WzXhPtQAzMKuwqavmXJXg==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr27215556wml.133.1597066602551;
        Mon, 10 Aug 2020 06:36:42 -0700 (PDT)
Received: from localhost.localdomain ([151.38.0.154])
        by smtp.gmail.com with ESMTPSA id f12sm21590491wmc.46.2020.08.10.06.36.41
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 06:36:42 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:36:39 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [BUG] stress-ng close causes kernel oops(es) v5.6-rt and v5.4-rt
Message-ID: <20200810133639.GA59705@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

As per subject, the following test

# stress-ng --close 0 --verbose --timeout 60 --metrics-brief

Causes kernel crashes for both v5.6.19-rt11 and v5.4.28-rt19 (splats
follow). Will try to dig deeper, but wanted to report early as this
seems to be very easy to reproduce and maybe someone already saw it and
might have suggestions.

Thanks!

Juri

--->8---
[  122.246746] 005: BUG: Bad rss-counter state mm:00000000d2a7d1a3 type:MM_FILEPAGES val:4
[  122.246750] 005: BUG: Bad rss-counter state mm:00000000d2a7d1a3 type:MM_ANONPAGES val

[  122.263285] 001: BUG: unable to handle page fault for address: 0000002f00000022
[  122.270857] 001: #PF: supervisor read access in kernel mode
[  122.276677] 001: #PF: error_code(0x0000) - not-present page
[  122.282499] 001: PGD 0
[  122.285201] 001: P4D 0
[  122.287900] 001:
[  122.289910] 001: Oops: 0000 [#1] PREEMPT_RT SMP PTI
[  122.294790] 001: CPU: 1 PID: 1394 Comm: stress-ng-close Not tainted 5.6.19-rt11 #1
[  122.302530] 001: Hardware name: IBM System x3550 M3 -[7944J2G]-/69Y4438, BIOS -[D6E148BUS-1.08]- 06/25/2010
[  122.312510] 001: RIP: 0010:d_path+0x13/0x170
[  122.317032] 001: Code: fe ff ff e8 4f d7 d8 ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 55 48 89 e5 41 54 49 89 fc 53 48 83 ec 28 <48> 8b 7f 08 89 54 24 04 65 48 8b 04 25 28 00 00 00 48 89 44 24 20
[  122.336459] 001: RSP: 0018:ffffbaf140707a00 EFLAGS: 00010286
[  122.342365] 001:
[  122.344546] 001: RAX: ffff9e7f57240e40 RBX: 00000000000009f0 RCX: ffff9e7f5a5fc000
[  122.352359] 001: RDX: 00000000000009f0 RSI: ffff9e7f5a5fc610 RDI: 0000002f0000001a
[  122.360172] 001: RBP: ffffbaf140707a38 R08: 0000000000000000 R09: ffff9e7c07c06840
[  122.367985] 001: R10: ffffffffa598953e R11: 0000000000000038 R12: 0000002f0000001a
[  122.375798] 001: R13: ffff9e7f57242ac0 R14: ffff9e7f5a5fc610 R15: 0000000000000000
[  122.383613] 001: FS:  00007f1728dcf700(0000) GS:ffff9e7f6f840000(0000) knlGS:0000000000000000
[  122.392381] 001: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  122.398807] 001: CR2: 0000002f00000022 CR3: 000000045a256005 CR4: 00000000000206e0
[  122.406620] 001: Call Trace:
[  122.409754] 001:  ? __kmalloc_node+0x126/0x360
[  122.414445] 001:  ? fill_note_info.isra.11+0x8ae/0xa50
[  122.419833] 001:  fill_note_info.isra.11+0x917/0xa50
[  122.425045] 001:  elf_core_dump+0xae/0x9e0
[  122.429389] 001:  ? __switch_to_asm+0x34/0x70
[  122.433997] 001:  ? __switch_to_asm+0x40/0x70
[  122.438605] 001:  ? __switch_to_asm+0x34/0x70
[  122.443214] 001:  ? __switch_to_asm+0x40/0x70
[  122.447822] 001:  ? _raw_spin_unlock_irq+0x17/0x50
[  122.452862] 001:  ? finish_task_switch+0x9e/0x2e0
[  122.457813] 001:  ? __switch_to+0x1c/0x4c0
[  122.462163] 001:  ? rt_spin_unlock+0x28/0x40
[  122.466679] 001:  do_coredump+0x561/0xb2e
[  122.470940] 001:  ? prb_unlock+0x23/0x60
[  122.475115] 001:  get_signal+0x3b6/0x910
[  122.479285] 001:  ? _raw_spin_unlock_irqrestore+0x18/0x50
[  122.484933] 001:  do_signal+0x36/0x690
[  122.488932] 001:  ? preempt_count_add+0x49/0xa0
[  122.493713] 001:  ? migrate_enable+0x118/0x360
[  122.498328] 001:  ? __send_signal+0x1f8/0x480
[  122.502938] 001:  ? rt_spin_unlock+0x28/0x40
[  122.507457] 001:  exit_to_usermode_loop+0xc1/0x110
[  122.512496] 001:  prepare_exit_to_usermode+0xa9/0xc0
[  122.517709] 001:  ret_from_intr+0x20/0x20
[  122.521968] 001: RIP: 0033:0x0
[  122.525273] 001: Code: Bad RIP value.
[  122.529188] 001: RSP: 002b:00007f1728dceea0 EFLAGS: 00010206
[  122.535093] 001:
[  122.537274] 001: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f172a7c3fb0
[  122.545088] 001: RDX: 0000000000000000 RSI: 00007f1728dceeb0 RDI: 0000000000000000
[  122.552901] 001: RBP: 0000000000000000 R08: 00007f1728dcf700 R09: 00007f1728dcf700
[  122.560713] 001: R10: 0000000000000008 R11: 0000000000000000 R12: 00007ffcd833f90e
[  122.568447] 001: R13: 00007ffcd833f90f R14: 0000000000000000 R15: 00007f1728dcefc0
[  122.576263] 001: Modules linked in:
[  122.580002] 001:  atm
[  122.582530] 001:  rfkill
[  122.585315] 001:  intel_powerclamp
[  122.588967] 001:  coretemp
[  122.591925] 001:  kvm_intel
[  122.594973] 001:  kvm
[  122.597501] 001:  iTCO_wdt
[  122.600461] 001:  ipmi_ssif
[  122.603509] 001:  cdc_ether
[  122.606557] 001:  usbnet
[  122.609342] 001:  iTCO_vendor_support
[  122.613256] 001:  irqbypass
[  122.616304] 001:  mii
[  122.618832] 001:  intel_cstate
[  122.622138] 001:  intel_uncore
[  122.625444] 001:  pcspkr
[  122.628229] 001:  ipmi_si
[  122.631104] 001:  i2c_i801
[  122.634062] 001:  lpc_ich
[  122.636937] 001:  ipmi_devintf
[  122.640243] 001:  ipmi_msghandler
[  122.643811] 001:  i7core_edac
[  122.647032] 001:  i5500_temp
[  122.650164] 001:  ioatdma
[  122.653039] 001:  ip_tables
[  122.656086] 001:  xfs
[  122.658440] 001:  libcrc32c
[  122.661235] 001:  sd_mod
[  122.663951] 001:  t10_pi
[  122.666737] 001:  sg
[  122.669175] 001:  mgag200
[  122.672049] 001:  ata_generic
[  122.675271] 001:  drm_kms_helper
[  122.678750] 001:  syscopyarea
[  122.681971] 001:  sysfillrect
[  122.685192] 001:  sysimgblt
[  122.688240] 001:  fb_sys_fops
[  122.691461] 001:  drm_vram_helper
[  122.695029] 001:  drm_ttm_helper
[  122.698508] 001:  ttm
[  122.701036] 001:  drm
[  122.703563] 001:  crc32c_intel
[  122.706869] 001:  ata_piix
[  122.709828] 001:  i2c_algo_bit
[  122.713133] 001:  libata
[  122.715919] 001:  ixgbe
[  122.718619] 001:  mdio
[  122.721231] 001:  bnx2
[  122.723843] 001:  dca
[  122.726371] 001:  dm_mirror
[  122.729418] 001:  dm_region_hash
[  122.732897] 001:  dm_log
[  122.735682] 001:  dm_mod
[  122.738468] 001:
[  122.740649] 001: CR2: 0000002f00000022
[  122.744844] 001: Kernel panic - not syncing: Fatal exception
[  123.369631] 001: Kernel Offset: 0x24600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  123.381007] 001: ---[ end Kernel panic - not syncing: Fatal exception ]---

[  122.744906] 003: BUG: unable to handle page fault for address: 0000002f0000002a
[  122.758368] 003: #PF: supervisor read access in kernel mode
[  122.764107] 003: #PF: error_code(0x0000) - not-present page
[  122.769846] 003: PGD 0
[  122.772464] 003: P4D 0
[  122.775082] 003:
[  122.777180] 003: Oops: 0000 [#2] PREEMPT_RT SMP PTI
[  122.782227] 003: CPU: 3 PID: 40329 Comm: systemd-coredum Tainted: G      D           5.6.19-rt11 #1
[  122.791434] 003: Hardware name: IBM System x3550 M3 -[7944J2G]-/69Y4438, BIOS -[D6E148BUS-1.08]- 06/25/2010
[  122.801333] 003: RIP: 0010:show_map_vma+0x28/0x140
[  122.806297] 003: Code: 00 00 66 66 66 66 90 41 55 41 54 55 48 89 fd 53 4c 8b a6 a0 00 00 00 48 89 f3 48 8b 4e 50 48 8b 53 08 48 8b 36 4d 85 e4 74 56 <49> 8b 44 24 20 4c 8b 83 98 00 00 00 48 8b 78 28 49 c1 e0 0c 44 8b
[  122.825643] 003: RSP: 0018:ffffbaf14998fe30 EFLAGS: 00010206
[  122.831471] 003:
[  122.833570] 003: RAX: ffffffffa599f5b0 RBX: ffff9e7f57242ac0 RCX: 00000000000c3148
[  122.841304] 003: RDX: 00000000000c3118 RSI: ffff9e7f572463c0 RDI: ffff9e7f3d36bcc0
[  122.849038] 003: RBP: ffff9e7f3d36bcc0 R08: ffffffffa6473ca0 R09: ffff9e7c07c06840
[  122.856772] 003: R10: ffffffffa5935e96 R11: 0000000000000001 R12: 0000002f0000000a
[  122.864507] 003: R13: ffff9e7f57242ac0 R14: ffff9e7f6c802e80 R15: ffff9e7f3d36bcc0
[  122.872242] 003: FS:  00007f1fecec0300(0000) GS:ffff9e7f6f8c0000(0000) knlGS:0000000000000000
[  122.880928] 003: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  122.887276] 003: CR2: 0000002f0000002a CR3: 000000045739c005 CR4: 00000000000206e0
[  122.895010] 003: Call Trace:
[  122.898066] 003:  show_map+0x12/0x30
[  122.901814] 003:  seq_read+0x153/0x440
[  122.905739] 003:  vfs_read+0x91/0x140
[  122.909574] 003:  ksys_read+0x5c/0xd0
[  122.913408] 003:  do_syscall_64+0x81/0x1b0
[  122.917677] 003:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  122.923332] 003: RIP: 0033:0x7f1feba54805
[  122.927512] 003: Code: fe ff ff 50 48 8d 3d 7a cb 09 00 e8 65 01 02 00 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 55 4d 2d 00 8b 00 85 c0 75 0f 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89
[  122.946861] 003: RSP: 002b:00007ffca2d36378 EFLAGS: 00000246
[  122.952688] 003:  ORIG_RAX: 0000000000000000
[  122.957129] 003: RAX: ffffffffffffffda RBX: 0000563c6b5b82f0 RCX: 00007f1feba54805
[  122.964864] 003: RDX: 0000000000000800 RSI: 0000563c6b5df690 RDI: 0000000000000001
[  122.972598] 003: RBP: 00007f1febd213c0 R08: 0000000000000b40 R09: 0000563c6b5b82f0
[  122.980332] 003: R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000800
[  122.988066] 003: R13: 0000563c6b5df690 R14: 0000000000000d68 R15: 00007f1febd20880
[  122.995802] 003: Modules linked in:
[  122.999460] 003:  atm
[  123.001905] 003:  rfkill
[  123.004612] 003:  intel_powerclamp
[  123.008186] 003:  coretemp
[  123.011067] 003:  kvm_intel
[  123.014031] 003:  kvm
[  123.016476] 003:  iTCO_wdt
[  123.019357] 003:  ipmi_ssif
[  123.022321] 003:  cdc_ether
[  123.025286] 003:  usbnet
[  123.027992] 003:  iTCO_vendor_support
[  123.031824] 003:  irqbypass
[  123.034789] 003:  mii
[  123.037233] 003:  intel_cstate
[  123.040461] 003:  intel_uncore
[  123.043687] 003:  pcspkr
[  123.046394] 003:  ipmi_si
[  123.049186] 003:  i2c_i801
[  123.052066] 003:  lpc_ich
[  123.054857] 003:  ipmi_devintf
[  123.058084] 003:  ipmi_msghandler
[  123.061569] 003:  i7core_edac
[  123.064707] 003:  i5500_temp
[  123.067760] 003:  ioatdma
[  123.070551] 003:  ip_tables
[  123.073517] 003:  xfs
[  123.075961] 003:  libcrc32c
[  123.078926] 003:  sd_mod
[  123.081632] 003:  t10_pi
[  123.084339] 003:  sg
[  123.086699] 003:  mgag200
[  123.089490] 003:  ata_generic
[  123.092628] 003:  drm_kms_helper
[  123.096029] 003:  syscopyarea
[  123.099167] 003:  sysfillrect
[  123.102305] 003:  sysimgblt
[  123.105270] 003:  fb_sys_fops
[  123.108408] 003:  drm_vram_helper
[  123.111892] 003:  drm_ttm_helper
[  123.115292] 003:  ttm
[  123.117737] 003:  drm
[  123.120182] 003:  crc32c_intel
[  123.123409] 003:  ata_piix
[  123.126289] 003:  i2c_algo_bit
[  123.129516] 003:  libata
[  123.132223] 003:  ixgbe
[  123.134841] 003:  mdio
[  123.137375] 003:  bnx2
[  123.139908] 003:  dca
[  123.142353] 003:  dm_mirror
[  123.145318] 003:  dm_region_hash
[  123.148718] 003:  dm_log
[  123.151425] 003:  dm_mod
[  123.154132] 003:
[  123.156231] 003: CR2: 0000002f0000002a
--->8---
BUG: Bad rss-counter state mm:00000000a88b60b9 type:MM_FILEPAGES val:1

[10011.163557] 002: invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
[10011.169607] 002: CPU: 2 PID: 6051 Comm: stress-ng-close Tainted: G        W         5.4.28-rt19 #1
[10011.178807] 002: Hardware name: IBM System x3550 M3 -[7944J2G]-/69Y4438, BIOS -[D6E148BUS-1.08]- 06/25/2010
[10011.188789] 002: RIP: 0010:__list_del_entry_valid.cold.1+0x12/0x4c
[10011.195215] 002: Code: cc ff 0f 0b 48 89 c1 4c 89 c6 48 c7 c7 98 1e f1 9d e8 b0 55 cc ff 0f 0b 48 89 fe 48 89 c2 48 c7 c7 28 1f f1 9d e8 9c 55 cc ff <0f> 0b 48 c7 c7 d8 1f f1 9d e8 8e 55 cc ff 0f 0b 48 89 f2 48 89 fe
[10011.214641] 002: RSP: 0018:ffffb3c701387df8 EFLAGS: 00010246
[10011.220547] 002:
[10011.222728] 002: RAX: 000000000000004e RBX: fffff492112ac780 RCX: 0000000000000001
[10011.230541] 002: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000ffffffff
[10011.238354] 002: RBP: ffff8d854ab1e000 R08: 00000000001638e0 R09: 0000000000000001
[10011.246166] 002: R10: ffffffff9e0592c0 R11: 0000000000000001 R12: ffff8d854aa5b780
[10011.253979] 002: R13: ffff8d856bda9a70 R14: ffff8d855b31b028 R15: 0000000000000000
[10011.261792] 002: FS:  00007f671bde3f40(0000) GS:ffff8d856f680000(0000) knlGS:0000000000000000
[10011.270559] 002: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10011.276985] 002: CR2: 00007fb99a77b000 CR3: 000000044ab1e002 CR4: 00000000000206e0
[10011.284799] 002: Call Trace:
[10011.287933] 002:  pgd_free+0x50/0xa0
[10011.291758] 002:  __mmdrop+0x50/0xf0
[10011.295584] 002:  userfaultfd_ctx_put+0x46/0x50
[10011.300362] 002:  userfaultfd_release+0x195/0x220
[10011.305318] 002:  __fput+0xb5/0x240
[10011.309059] 002:  task_work_run+0x8f/0xb0
[10011.313321] 002:  exit_to_usermode_loop+0x10b/0x110
[10011.318449] 002:  do_syscall_64+0x188/0x1a0
[10011.322883] 002:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10011.328616] 002: RIP: 0033:0x7f671a9e7977
[10011.332877] 002: Code: 12 b8 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3b c3 66 90 53 89 fb 48 83 ec 10 e8 e4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 26 fc ff ff 8b 44 24
[10011.352303] 002: RSP: 002b:00007ffd132b99e0 EFLAGS: 00000293
[10011.358208] 002:  ORIG_RAX: 0000000000000003
[10011.362727] 002: RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f671a9e7977
[10011.370540] 002: RDX: 0000000000000000 RSI: 00007ffd132b9a80 RDI: 0000000000000005
[10011.378353] 002: RBP: 0000561f85d0fc20 R08: 00007ffd132b99a0 R09: 00007ffd132b9c60
[10011.386165] 002: R10: 00007ffd132b99a8 R11: 0000000000000293 R12: 0000000000000001
[10011.393978] 002: R13: 00007ffd132b9c78 R14: 00007ffd132b9a60 R15: 0000000000000001
[10011.401793] 002: Modules linked in:
[10011.405532] 002:  atm
[10011.408060] 002:  rfkill
[10011.410845] 002:  intel_powerclamp
[10011.414497] 002:  coretemp
[10011.417456] 002:  kvm_intel
[10011.420503] 002:  kvm
[10011.423031] 002:  cdc_ether
[10011.426079] 002:  usbnet
[10011.428865] 002:  iTCO_wdt
[10011.431823] 002:  iTCO_vendor_support
[10011.435737] 002:  ipmi_ssif
[10011.438785] 002:  irqbypass
[10011.441833] 002:  mii
[10011.444360] 002:  intel_cstate
[10011.447665] 002:  intel_uncore
[10011.450971] 002:  pcspkr
[10011.453756] 002:  i2c_i801
[10011.456716] 002:  lpc_ich
[10011.459590] 002:  ipmi_si
[10011.462464] 002:  ipmi_devintf
[10011.465769] 002:  ipmi_msghandler
[10011.469337] 002:  ioatdma
[10011.472211] 002:  i7core_edac
[10011.475432] 002:  i5500_temp
[10011.478565] 002:  ip_tables
[10011.481613] 002:  xfs
[10011.484140] 002:  libcrc32c
[10011.487188] 002:  sd_mod
[10011.489973] 002:  sg
[10011.492413] 002:  mgag200
[10011.495287] 002:  drm_kms_helper
[10011.498766] 002:  syscopyarea
[10011.501987] 002:  sysfillrect
[10011.505208] 002:  sysimgblt
[10011.508256] 002:  fb_sys_fops
[10011.511477] 002:  drm_vram_helper
[10011.515045] 002:  ixgbe
[10011.517746] 002:  ata_generic
[10011.520795] 002:  ttm
[10011.523069] 002:  ata_piix
[10011.525959] 002:  drm
[10011.528487] 002:  libata
[10011.531272] 002:  bnx2
[10011.533884] 002:  crc32c_intel
[10011.537190] 002:  mdio
[10011.539802] 002:  i2c_algo_bit
[10011.543107] 002:  dca
[10011.545634] 002:  dm_mirror
[10011.548682] 002:  dm_region_hash
[10011.552160] 002:  dm_log
[10011.554946] 002:  dm_mod
[10011.557731] 002:
[10011.559945] 002: Kernel panic - not syncing: Fatal exception
[10011.827694] 002: Kernel Offset: 0x1be00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[10011.839070] 002: ---[ end Kernel panic - not syncing: Fatal exception ]---

