Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C057EC47082
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Jun 2021 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F989610E7
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Jun 2021 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFGO6t (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGO6t (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Jun 2021 10:58:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB3BC061766
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Jun 2021 07:56:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so17936468wri.11
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Jun 2021 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3UdQUvJnVkbbO/GHD2GtfTntH6P4S0+pnStJWMvf1P0=;
        b=IWYqrZeIwput2hoKGsrls76d4ZTdTUYrlcXmhOWt78eIoz03DYq3y5CYE2WpgvfNUI
         6fxlDuhneCuD8dI2qaRSps6CkP8JX2ZxwdzhUjS2o4YYm8Ns9uMsy85prAfz6lcdaG6U
         YNUh8yz6Y1JhVd1a4uEZCKPGrUI0xP3B63qzS+QeY/Y7NmVc6aiqbmk1VM2tvJxS+lVG
         H8fb+o7Si/wG1Ne1JOiRGglNxbN6fqayUCdBc2ykeqqnyTYCNLrk7GN5ugFW3cvVuZXw
         mNwAnEq2jfb2jczeFJw83/c/j0J+v+AWezx8/+UM30vXLOCZHCXqhKBmHQDmmjd9fEDY
         Dngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3UdQUvJnVkbbO/GHD2GtfTntH6P4S0+pnStJWMvf1P0=;
        b=I2Gn29Pu2EdEtNsWoX9ryqKcv3ehsd1v/zVxmEz2wpynN+QPtpWXKI50L7mC9LHFEK
         zLXOzyV6YSpgzbKajf5s6blSpEO/I8znIXQOEWEKne1euFRvf9AzzlZDwb2GeGsSYqlC
         h5zMwhb0LNqcdolvjNAqO+h4j8m0qYBv1ob/OimtImXeByrXARJ7rOLQbsnO7QB8S9Kv
         +ZpENEk1Qnv+6nf2VECETb/lQPb9a9DfxPc6WFHQs1PDS8S8QEPrUzsupRuK/x46+jR5
         F1zya3VdyhMfwtonOWUgK504TUd9myAe2AirLOR0KI7dAn8SItHveb3fcjokfd1Rh1l9
         opKA==
X-Gm-Message-State: AOAM532KjfGiCui+cnXwK/iMb8+ZvQIIOV8st/lkJiFjEbFojHRHvyCQ
        o1Qlb8nThCTx7BIjR/wt7QPP6ZnpfdCFBEgciSVl/wS2SBc=
X-Google-Smtp-Source: ABdhPJxz54lA5rtBYvYDFYDFTG57eTbUHxtaTsZik0yLFciQt7QsPFyaKGw/fdsn89V1c1TVahtVYqUDFq3mPwzYeeg=
X-Received: by 2002:a05:6000:1282:: with SMTP id f2mr17073437wrx.67.1623077816730;
 Mon, 07 Jun 2021 07:56:56 -0700 (PDT)
MIME-Version: 1.0
From:   Christoph Mathys <eraserix@gmail.com>
Date:   Mon, 7 Jun 2021 16:56:45 +0200
Message-ID: <CALqGcGpVOTGK+WDwqvX=W9140p8xrdAWn01vB8zb_6=mATSjHw@mail.gmail.com>
Subject: Hung task in 4.9 using kvm 5.2
To:     Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

When running kvm 5.2 on 4.9-rt (I've yet to verify if !RT is also
affected), kvm gets stuck regulary requiring a reboot. I get the
hung_task warning below.

Any thoughts on how to avoid this problem?

Thanks!
Christoph

[ 2704.403272] INFO: task kvm:18206 blocked for more than 120 seconds.
[ 2704.403275]       Tainted: G     U          4.9.268-realtime-1-prove-rt179 #2
[ 2704.403276] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 2704.403278] kvm             D    0 18206  12599 0x00000320
[ 2704.403281]  0000000000000086 ffff88087e268a00 ffff8801d2822840
ffffffff81e19500
[ 2704.403283]  0000000000000000 ffff88087e268a18 ffffc90019637a98
ffffffff81841438
[ 2704.403286]  0000000000000086 ffff8801d2822e38 ffff88087e268a18
ffff88087e268a00
[ 2704.403288] Call Trace:
[ 2704.403293]  [<ffffffff81841438>] ? __schedule+0x308/0x830
[ 2704.403295]  [<ffffffff818419a9>] schedule+0x49/0xd0
[ 2704.403296]  [<ffffffff8184334c>] __rt_mutex_slowlock+0x4c/0x190
[ 2704.403298]  [<ffffffff81843882>] rt_mutex_slowlock_locked+0xa2/0x290
[ 2704.403300]  [<ffffffff8184446b>] __down_read+0x7b/0xb0
[ 2704.403301]  [<ffffffff81843070>] down_read+0x40/0x50
[ 2704.403304]  [<ffffffff8129cf20>] ? ext4_direct_IO+0x2e0/0xa40
[ 2704.403305]  [<ffffffff8129cf20>] ext4_direct_IO+0x2e0/0xa40
[ 2704.403308]  [<ffffffff81174789>] generic_file_read_iter+0x3c9/0x7a0
[ 2704.403310]  [<ffffffff81251fde>] aio_read+0xbe/0x140
[ 2704.403312]  [<ffffffff8121c688>] ? __fget+0x118/0x1e0
[ 2704.403313]  [<ffffffff8121c575>] ? __fget+0x5/0x1e0
[ 2704.403315]  [<ffffffff8121c7ba>] ? __fdget+0x2a/0x70
[ 2704.403317]  [<ffffffff81253802>] do_io_submit+0x602/0x680
[ 2704.403318]  [<ffffffff81253387>] ? do_io_submit+0x187/0x680
[ 2704.403320]  [<ffffffff81253890>] SyS_io_submit+0x10/0x20
[ 2704.403322]  [<ffffffff81001e1b>] do_syscall_64+0x7b/0x160
[ 2704.403324]  [<ffffffff81846983>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
[ 2704.403325] INFO: lockdep is turned off.
[ 2704.403327] INFO: task worker:18552 blocked for more than 120 seconds.
[ 2704.403328]       Tainted: G     U          4.9.268-realtime-1-prove-rt179 #2
[ 2704.403329] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 2704.403330] worker          D    0 18552  12599 0x00000320
[ 2704.403333]  0000000000000082 ffff88087e368a00 ffff8801d2b85080
ffff88086c0b0000
[ 2704.403335]  0000000000000000 ffff88087e368a18 ffffc9001cb63da0
ffffffff81841438
[ 2704.403338]  0000000081e08270 ffff8801d2b85678 ffff88087e368a18
ffff88087e368a00
[ 2704.403340] Call Trace:
[ 2704.403341]  [<ffffffff81841438>] ? __schedule+0x308/0x830
[ 2704.403343]  [<ffffffff818419a9>] schedule+0x49/0xd0
[ 2704.403345]  [<ffffffff81219097>] inode_dio_wait+0xa7/0xd0
[ 2704.403347]  [<ffffffff810ad650>] ? wake_up_atomic_t+0x90/0x90
[ 2704.403349]  [<ffffffff812cd670>] ext4_fallocate+0x480/0xe00
[ 2704.403351]  [<ffffffff811f4deb>] vfs_fallocate+0x15b/0x250
[ 2704.403352]  [<ffffffff811f6044>] SyS_fallocate+0x44/0x70
[ 2704.403354]  [<ffffffff81001e1b>] do_syscall_64+0x7b/0x160
[ 2704.403355]  [<ffffffff81846983>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
[ 2704.403357] INFO: lockdep is turned off.
