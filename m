Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62DCC636CC
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Jan 2023 13:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjAaNRT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjAaNRN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Jan 2023 08:17:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E034017
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Jan 2023 05:17:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d30so24116644lfv.8
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Jan 2023 05:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x6s0iCMWuAK4ptR5FhCISafPq+7nb//fmqvvy56t6Jg=;
        b=T0X4Lk764XhaiqZGiTb3k1rm6EgNtdqfP9by69Szqz67k9BIdimBZytHcU4N9n0i0/
         m/DLzZYvu1rCVvf+9bXYDglCgok2UFKjOhTC4/JpYOkmbBfPsWeuRVAuJgXs8w3qxufl
         uqshAhtIHj562X9FZIurP9MjIeMQ+WFobQm7jwsXjqQnsFSIFvbvWS8fZ1z8gYD79wkH
         zYka+q+hd4Hb0WngCywYaA/pwjdX30OpaKazMOqaDZHDJ482UKFI9Df2mHVZl7EgiLwo
         PKOcJXtviPNl1u5qFU6nWpEwsYm9DVePOBL8XNHI9ADSF/x0r4KlHTPbEvXGODV4bylP
         onow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6s0iCMWuAK4ptR5FhCISafPq+7nb//fmqvvy56t6Jg=;
        b=udV0yqAtx7cmdhPnvO4UdhRG0YGYVEjUgbBFDJ6V7WD6T0rfXKG5acouBIu+B309O/
         7rPQBz/dzZHY8zqPl7TLgnBFv98mBK4qa8AZKPrVmZTiXuerLykWCwk8XRQ1pBkVQzo8
         4crGL7fx9Et8VzV+1CgltZTlC/s4rn2AnYbc3dJ3/bJF52mnuaDkn+35ijZU+Ol4reJw
         pKlOz2XHoPXNHRZ4oUsPky9na0t/M7d1pcrlIlwsfMX4IB7Tb1nKO34Q6yUvRvJsNEmS
         AXhrX0wKRV0mB7zQ0uG01yk5ayYFrSxQuhe+b47/RBWJC1VUutVFRj+42/9ikVHbsMFp
         xDcw==
X-Gm-Message-State: AFqh2kqmACA0309ZXaQtdqgq4DH992kFRsrlQbOITXMgDz7q4qYNfbAr
        AGc8t54OejJcmaauVe1AcmE6denkOdpyk7ZN0Z9TVhTIUbo=
X-Google-Smtp-Source: AMrXdXt/MRjGXSSd+4Ojhbb9jILlDFp8PxKxlq+d4Qh2Z4JLE4HE7WhdDEfwoYJ8ZdzVPja4PSrN+66Y5TeteghBAic=
X-Received: by 2002:a05:6512:3a96:b0:4cc:66d4:41a0 with SMTP id
 q22-20020a0565123a9600b004cc66d441a0mr5159760lfu.21.1675171020380; Tue, 31
 Jan 2023 05:17:00 -0800 (PST)
MIME-Version: 1.0
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 31 Jan 2023 14:16:48 +0100
Message-ID: <CAFLxGvw0WMxaMqYqJ5WgvVSbKHq2D2xcXTOgMCpgq9nDC-MWTQ@mail.gmail.com>
Subject: Scheduling while atomic due to i915 intel_uncore->lock
To:     rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 5.15.40-rt43 I came across the following splat followed by a lockup:

[10416.548215] BUG: scheduling while atomic: X/447/0x00000002
[10416.548226] Modules linked in: magic(O) mei_hdcp mei_me mei
[10416.548238] CPU: 2 PID: 447 Comm: X Tainted: G           O
5.15.40-rt43 #1
[10416.548241] Hardware name: FUJITSU D3544-Sx/D3544-Sx, BIOS
V5.0.0.13 R1.12.0 for D3544-Sxx                    06/28/2020
[10416.548244] Call Trace:
[10416.548250]  <TASK>
[10416.548253]  dump_stack_lvl+0x34/0x44
[10416.548263]  __schedule_bug.cold+0x47/0x53
[10416.548267]  __schedule+0x108d/0x1450
[10416.548271]  ? raw_spin_rq_lock_nested+0x1a/0xe0
[10416.548276]  ? sched_clock_cpu+0x9/0xe0
[10416.548279]  ? update_rq_clock+0x31/0x160
[10416.548281]  ? rt_mutex_setprio+0x188/0x520
[10416.548284]  schedule_rtlock+0x1b/0x40
[10416.548286]  rtlock_slowlock_locked+0x373/0xcf0
[10416.548291]  ? rt_spin_unlock+0x13/0x40
[10416.548294]  rt_spin_lock+0x41/0x60
[10416.548296]  intel_gt_flush_ggtt_writes+0x45/0x70
[10416.548301]  reloc_cache_reset.constprop.0+0x71/0x110
[10416.548306]  eb_relocate_vma+0x125/0x150
[10416.548309]  ? rt_spin_unlock+0x13/0x40
[10416.548312]  ? kvfree_call_rcu+0x67/0x2d0
[10416.548316]  ? __kmalloc+0x145/0x2e0
[10416.548321]  ? ksize+0x14/0x30
[10416.548324]  ? i915_vma_pin_ww+0x731/0x920
[10416.548327]  ? eb_validate_vmas+0x24b/0x7f0
[10416.548329]  ? i915_gem_object_userptr_submit_init+0x20b/0x3f0
[10416.548333]  i915_gem_do_execbuffer+0x1082/0x1f90
[10416.548338]  ? ___slab_alloc+0x106/0x8c0
[10416.548341]  ? rt_spin_lock+0x26/0x60Move mesa/etnaviv to
xf86-video-modesetting
[10416.548344]  ? i915_gem_execbuffer2_ioctl+0xb5/0x250
[10416.548346]  ? __i915_gem_object_set_pages+0x1b4/0x200
[10416.548349]  ? i915_gem_userptr_get_pages+0x17f/0x190
[10416.548352]  ? __kmalloc_node+0x153/0x340
[10416.548355]  i915_gem_execbuffer2_ioctl+0x106/0x250
[10416.548357]  ? i915_gem_do_execbuffer+0x1f90/0x1f90
[10416.548360]  drm_ioctl_kernel+0x84/0xd0
[10416.548364]  drm_ioctl+0x1ff/0x3d0
[10416.548366]  ? i915_gem_do_execbuffer+0x1f90/0x1f90
[10416.548370]  __x64_sys_ioctl+0x7f/0xb0
[10416.548374]  do_syscall_64+0x35/0x80
[10416.548378]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[10416.548381] RIP: 0033:0x7fe88b8cfd6c
[10416.548385] Code: 1e fa 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24
c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00
00 0f 05 <3d> 00 f0 ff ff 41 89 c0 77 0a 44 89 c0 c3 66 0f 1f 44 00 00
48 8b
[10416.548387] RSP: 002b:00007ffdec4f0598 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[10416.548390] RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007fe88b8cfd6c
[10416.548391] RDX: 00007ffdec4f05d0 RSI: 0000000040406469 RDI: 000000000000000b
[10416.548393] RBP: 000055c4c7893b10 R08: 0000000000000000 R09: 0000000000003fd0
[10416.548394] R10: 00007fe88971e000 R11: 0000000000000246 R12: 00007ffdec4f05d0
[10416.548395] R13: 000055c4c7d18530 R14: 00007fe88972f488 R15: 00007fe88972f000
[10416.548398]  </TASK>

A reliable trigger for the problem is using the Chromium browser when
it utilizes OpenGL.

The root of the problem seems to be that struct intel_uncore->lock is
a regular spinlock but
taken in atomic context.
AFAICT the atomic context is a result of kmap_atomic() and
io_mapping_map_atomic_wc()
usage in i915.
Converting the said lock to a raw spinlock cures the problem but the
overall latency almost doubles.

I'm pretty sure the problem exists also on v6.2-rc3-rt1 because there
the affected lock is also
still a spinlock and used below kmap_atomic() and io_mapping_map_atomic_wc().

-- 
Thanks,
//richard
