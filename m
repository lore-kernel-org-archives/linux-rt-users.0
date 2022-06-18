Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E207BC43334
	for <linux-rt-users@archiver.kernel.org>; Sat, 18 Jun 2022 09:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiFRJZy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 18 Jun 2022 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiFRJZw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 18 Jun 2022 05:25:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE425E3
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Jun 2022 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655544340;
        bh=JdSZIiAcitMajXJ8uxO343BzZBcoI1KqqziWT7fjTaI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=ERtvcZtpMS8l8gvN+ZeoJVSthPuf0wMJNQedlDFnX8zyv8ho200BAilozu0xVkz1+
         dyr+3jQwS63uHT5K0RJOFkqB3bqTpJsenGssX0tAqhA9sofmPmcDro8Swbp+oP5Vb3
         vuHU+6isoF7aBbzVmNL77w8Y7ru/R5ZnVWVJ5ykY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbVu-1nvM6s019C-00H4yR; Sat, 18
 Jun 2022 11:25:40 +0200
Message-ID: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
Subject: v5.19-rc2-rt3: nouveau might sleep splat
From:   Mike Galbraith <efault@gmx.de>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 18 Jun 2022 11:25:39 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dmCDW9d4Z88lJNZqevly20xrygqb8WN3XnL4WjIK7lIQLCojVK7
 zL5zP/ACdqJwFjeDLqCZmEkVlRbY6d0ne83cdJFtTOiLv/PLllSOajsnKQvNk2cTqDNQneo
 JIbcR0aGypRBymPrlcn/6K0shwHq7q4ymAdP9EesIHvjPr8Za5cLm9/1UzmEJHOqp7f3mmS
 58ekpcsT0sUMdq7BV+YFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PTUKi1BUaMo=:RN//i5FoZz2+K8KUVqzCJs
 APJ/+siUBWeuWIcdHUk0i7f/1burTBFNKTIlDMe8ZH5O9mo18aFsLmDH8tr5umUEzZ4ZGfqd/
 IHqBMOu2EyX9THt1yf0zvZsocvhXnk1BUJvtd18ZxZ3vK0nJMRciE3hSEqV3WJkvA4GM9FhWo
 HtCJmFvXg/0WAvRbYPSBMs20G7Mc4rUsjC5vTSs1PU1iowVks92L+j2PTLKiQChryh8c5aQ20
 gQwIctryqlyLmznb9A4TZCNS5SVdI4BpnQ8iOBuaJNWQGMK62RPhqnPxZ8NLkQlZqPgpYxToQ
 G7Ehpni3xpb7zjZAL+EiI0s2G1S0ehAaCzCVFycm9f4JEp0WabO3WSuoTtyoVGi6pSFMRKfXD
 gnXAJL24y1eGwH8tFTAIsjAWiAGw/LgN/ubJoUicS1NbFwz3m2emnV0YUMBOXZy/1CLzWYC8x
 RfNRmyC8j7QmpMyVcOLEfXTEbLAYu+4EFW/d6PZXRM3xnczvWxNPgbGucnqsPNkVhjWHa1hxN
 gzXsJMNNuA9LreVGa/LtuNJ29oGytVclXHV0fM/72QSw8KhKm1btSse5AfC05wgexXnUfT+S0
 ZKwo8EJQt2Fw7L/AFrl/gVIauyVZbgXUvXhovQkYJjNTO1+B8zEYst5grarYbFcZ0XBOtAe2Y
 eFHqEuAQt5xlw6MSVwMHznNUOZgSZxTQ3yCbzRBtJZ2wTzCQ5WY/wumcVPbk8vhD2Vw/qZ2Fd
 Mqx7BOukkoGhUS/NOUB/CHqEycBI519Uk1HI9K9YzmMRgVLfKaBRgoJsZ8VGw9VAlJQePBCVo
 mLXpuVz504bG651zMRfbohbNl2rEByTXJZ6HZfqSM5PglyDYQeisAvA4qX5Z/OtBl4fCErBtf
 r9gUVfISX9AFbm9bF9tJXuUvXzB4nnTPg5tIRBhMZ0n4sFdtloUBqRwQ6yESruh0rq46vlfW8
 f0k9B+aoUYCng/Gtjf721wcsqTb3Tw6hd6S/Bs0+W3Ibdl2yXoBnSnP014vK8S7k7kAJogOhI
 hzF+PWbZQqgmk/zvNpXqk1bnoaPyPltDWNCN26vNnih6A3nHmC6+RKVkmMU+RDKE7LUBT8KNx
 3KI5wyTVkMEIb6VejhKtwtjcs2gfIDfmuazQSTHVyylJias1UxofnAaiA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I haven't done any digging to see why this now happens where it
previously did not.

[    3.867408] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[    3.867409] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 387, name: systemd-udevd
[    3.867409] preempt_count: 0, expected: 0
[    3.867410] RCU nest depth: 1, expected: 1
[    3.867411] CPU: 4 PID: 387 Comm: systemd-udevd Tainted: G        W   E     5.19.0.g0639b59-master-rt #3 2864531ca0be0aecd9a6687c6a7534c103a4beb1
[    3.867413] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[    3.867413] Call Trace:
[    3.867415]  <TASK>
[    3.867416]  dump_stack_lvl+0x44/0x58
[    3.867421]  __might_resched+0x141/0x160
[    3.867425]  rt_spin_lock+0x2d/0x70
[    3.867428]  crng_make_state+0x76/0x1c0
[    3.867430]  _get_random_bytes.part.16+0x4e/0x110
[    3.867432]  ? nvkm_vmm_iter.constprop.11+0x311/0x860 [nouveau d5cea19cce3ba6cfae6272043bf13df497098c8d]
[    3.867512]  ? ___slab_alloc+0x31a/0x660
[    3.867514]  ? nvkm_vmm_sparse_unref_ptes+0x80/0x80 [nouveau d5cea19cce3ba6cfae6272043bf13df497098c8d]
[    3.867579]  ? gf100_vmm_pgt_sgl+0x230/0x230 [nouveau d5cea19cce3ba6cfae6272043bf13df497098c8d]
[    3.867644]  default_pointer+0x2a0/0x2d0
[    3.867647]  vsnprintf+0x35a/0x4c0
[    3.867649]  va_format.isra.16+0x6e/0xa0
[    3.867651]  vsnprintf+0x35a/0x4c0
[    3.867653]  vprintk_store+0x141/0x520
[    3.867655]  ? vsnprintf+0x48f/0x4c0
[    3.867657]  vprintk_emit+0x44/0x170
[    3.867659]  dev_vprintk_emit+0x185/0x1ae
[    3.867662]  ? dev_printk_emit+0x4a/0x66
[    3.867663]  dev_printk_emit+0x4a/0x66
[    3.867665]  ? kfree+0x165/0x340
[    3.867667]  _dev_info+0x64/0x80
[    3.867669]  ? nvc0_fbcon_fillrect+0x132/0x170 [nouveau d5cea19cce3ba6cfae6272043bf13df497098c8d]
[    3.867738]  nouveau_fbcon_create+0x2bc/0x4e0 [nouveau d5cea19cce3ba6cfae6272043bf13df497098c8d]
[    3.867805]  __drm_fb_helper_initial_config_and_unlock+0x30b/0x570 [drm_kms_helper ecc92b0a1aa52e1818472d4bed64af1f48245922]
[    3.867820]  nouveau_fbcon_init+0x158/0x1c0 [nouveau d5cea19cce3ba6cfae6272043bf13df497098c8d]
[    3.867885]  nouveau_drm_device_init+0x1db/0x840 [nouveau d5cea19cce3ba6cfae6272043bf13df497098c8d]
[    3.867953]  ? pci_update_current_state+0x65/0xa0
[    3.867957]  nouveau_drm_probe+0x11b/0x220 [nouveau d5cea19cce3ba6cfae6272043bf13df497098c8d]
[    3.868023]  ? rt_spin_unlock+0x13/0x40
[    3.868025]  local_pci_probe+0x42/0x90
[    3.868027]  pci_device_probe+0x176/0x240
[    3.868029]  ? sysfs_do_create_link_sd.isra.2+0x68/0xd0
[    3.868031]  really_probe+0x108/0x3d0
[    3.868033]  __driver_probe_device+0x100/0x170
[    3.868035]  driver_probe_device+0x1f/0xa0
[    3.868036]  __driver_attach+0xaa/0x170
[    3.868038]  ? __device_attach_driver+0xe0/0xe0
[    3.868039]  ? __device_attach_driver+0xe0/0xe0
[    3.868040]  bus_for_each_dev+0x73/0xc0
[    3.868042]  bus_add_driver+0x153/0x240
[    3.868044]  ? 0xffffffffc083f000
[    3.868045]  driver_register+0x5b/0xf0
[    3.868046]  ? 0xffffffffc083f000
[    3.868047]  do_one_initcall+0x3e/0x260
[    3.868050]  ? kmem_cache_alloc_trace+0x116/0x260
[    3.868052]  do_init_module+0x4b/0x1f0
[    3.868054]  load_module+0x1891/0x22a0
[    3.868058]  ? __do_sys_finit_module+0xaf/0x120
[    3.868059]  __do_sys_finit_module+0xaf/0x120
[    3.868061]  do_syscall_64+0x58/0x80
[    3.868063]  ? ksys_mmap_pgoff+0xc9/0x1e0
[    3.868066]  ? syscall_exit_to_user_mode+0x17/0x30
[    3.868068]  ? do_syscall_64+0x67/0x80
[    3.868069]  ? syscall_exit_to_user_mode+0x17/0x30
[    3.868071]  ? do_syscall_64+0x67/0x80
[    3.868072]  ? do_syscall_64+0x67/0x80
[    3.868072]  ? do_syscall_64+0x67/0x80
[    3.868073]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[    3.868076] RIP: 0033:0x7fc66d483ec9
[    3.868078] Code: 2e 00 b8 ca 00 00 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 7f 2d 00 f7 d8 64 89 01 48
[    3.868079] RSP: 002b:00007fff450b9a48 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    3.868080] RAX: ffffffffffffffda RBX: 000055d3248168a0 RCX: 00007fc66d483ec9
[    3.868081] RDX: 0000000000000000 RSI: 00007fc66ddf779d RDI: 000000000000001b
[    3.868082] RBP: 00007fc66ddf779d R08: 0000000000000000 R09: 000055d3247f69a0
[    3.868083] R10: 000000000000001b R11: 0000000000000246 R12: 0000000000020000
[    3.868083] R13: 000055d32481e460 R14: 0000000000000000 R15: 000055d32481d260
[    3.868085]  </TASK>
[    3.867406] nouveau 0000:01:00.0: DRM: allocated 1920x1080 fb: 0xa0000, bo 00000000cb6e75e2
[    3.868165] fbcon: nouveaudrmfb (fb0) is primary device
[    4.190312] Console: switching to colour frame buffer device 240x67
[    4.474555] nouveau 0000:01:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[    4.502083] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0

