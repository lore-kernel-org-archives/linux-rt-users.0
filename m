Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E7AC54EE9
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Sep 2022 19:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiIMTVy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIMTVx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Sep 2022 15:21:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89671BD6
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Sep 2022 12:21:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so16605950pjm.1
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Sep 2022 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Ia6zgXAYy4fr17YVYZrCH6y/Ad42Jyl3wRcQ+NjPKVI=;
        b=EmbTGYwWdOG4uj6t80pp7gRRY5Biz89qGSXXAmsZgBDa0syhw1mfAfiATx09H0A15A
         ZRQz5x6uKhKwN6f6oTN9Axbhpxgi6ducs/qUh71E0pTNGsW0N42KfQUlC2lx/o7hpu3A
         wtVtl0//9keH9yJNBy9UQ1RvUnerU3mOiKUIunjC+30qJjg65MCsElIHjq7e/4V/IGM1
         cSyXAFFG6X+mrBsCkyfTd2Ms0Myfzv2BmLKwjTyqa0zfqvUQEZ2F3GZy4YpoJyo3+7MJ
         sEqIl0wF0oy8s5QBfIPDr5gVdDej5bg3fgDaaw9NR088Z4NOR6vphGKGcexiAkPO/aba
         sslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Ia6zgXAYy4fr17YVYZrCH6y/Ad42Jyl3wRcQ+NjPKVI=;
        b=JECHx4Ss1n3Bj3p+WoZfw63aS1E5cHY9DwfYJ5029ErR26DueGSwlt2sG8fvJNtpX/
         r6if0vq+IRD6q2CXshDlN9HGJMxDTcUhu/+Xibe7wmHvYE17xG89OiHr1MBLdxV4j9Kn
         SFwNcZ0afLaRrVp99L9sSWKRr8mzkHNDUwMgWaSHfiHym/EcjNzo2X4ndzt9cMifDZ3U
         lAQSEAmPgXiU4SAcjrr0019HcbbmAzXY5JX+4Odt5Z8aM0QEzAVqZafHVhSWwADSGYif
         5BYDB3sC5Rw2Sh/iDR0Z3d7mp9ZaQBePz0uQkLseH/yB5hxL74JUyBn2D5j5uMgl/6HE
         CoFw==
X-Gm-Message-State: ACgBeo3Ld6p4W5qN+Yo+2Zo+zt3TXQq/wNLZZaPr/38vagyVmFc4a2nU
        /Ejpnp29I+v3zvBlx6AhfJEiCr4XeaE5a86vcSh+oRiUIPyrQg==
X-Google-Smtp-Source: AA6agR4GHQGXiEDg8txj3fqaN/KBWstPOT7N4fAad7u3/9hBCnq0y/nG3mLT2biDLTUy3YyDVQLCDtaljd1ApnQVsqY=
X-Received: by 2002:a17:902:e2d3:b0:176:e97a:d3eb with SMTP id
 l19-20020a170902e2d300b00176e97ad3ebmr31906658plc.172.1663096898626; Tue, 13
 Sep 2022 12:21:38 -0700 (PDT)
MIME-Version: 1.0
From:   Danilo Cezar Zanella <danilo.zanella@iag.usp.br>
Date:   Tue, 13 Sep 2022 16:21:27 -0300
Message-ID: <CAAxUTH4zpibkhOS+NPzcYsXFqx1bJfSU19gdt0eCAOrpWAkinA@mail.gmail.com>
Subject: Exception in function_graph tracing
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi

I'm getting the following error message when I set the current_tracer
to function_graph. Procedures:

cd / sys/kernel/tracing
echo function_graph > current_tracer

Then I saw the following message in the console.

Unable to handle kernel paging request at virtual address fffffffc
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:7270 migrate_disable+0x104/0x114
Modules linked in: rtc_armada38x ts7800_v2_wdt spi_orion spi_gpio
i2c_gpio i2c_algo_bit
CPU: 0 PID: 0 Comm:  Not tainted 4.19.249-rt111-llama-rt+ #36
Hardware name: Marvell Armada 380/385 (Device Tree)
[<c011424c>] (unwind_backtrace) from [<c010e318>] (show_stack+0x18/0x1c)
[<c010e318>] (show_stack) from [<c09da8ac>] (dump_stack+0x84/0x98)
[<c09da8ac>] (dump_stack) from [<c0124bc8>] (__warn+0x100/0x118)
[<c0124bc8>] (__warn) from [<c0124d0c>] (warn_slowpath_null+0x48/0x50)
[<c0124d0c>] (warn_slowpath_null) from [<c015163c>]
(migrate_disable+0x104/0x114)
[<c015163c>] (migrate_disable) from [<c0182920>] (vprintk_emit+0x10c/0x1ec)
[<c0182920>] (vprintk_emit) from [<c0182bc0>] (vprintk_default+0x28/0x30)
[<c0182bc0>] (vprintk_default) from [<c09d5100>] (printk+0x38/0x5c)
[<c09d5100>] (printk) from [<c09d4dc8>] (__do_kernel_fault.part.0+0x4c/0x7c)
[<c09d4dc8>] (__do_kernel_fault.part.0) from [<c0118d84>]
(do_page_fault+0x380/0x394)
[<c0118d84>] (do_page_fault) from [<c0118f6c>] (do_DataAbort+0x50/0xf0)
---[ end trace 0000000000000002 ]---
pgd = 721da14e
[fffffffc] *pgd=2fffd861, *pte=00000000, *ppte=00000000
Internal error: Oops: 37 [#1] PREEMPT SMP ARM
Modules linked in: rtc_armada38x ts7800_v2_wdt spi_orion spi_gpio
i2c_gpio i2c_algo_bit
CPU: 0 PID: 0 Comm:  Tainted: G        W         4.19.249-rt111-llama-rt+ #36
Hardware name: Marvell Armada 380/385 (Device Tree)
PC is at prepare_ftrace_return+0x20/0x48
LR is at ftrace_graph_caller+0x18/0x20
pc : [<c0112884>]    lr : [<c0112540>]    psr: 600f0193
sp : ef12a090  ip : 00000051  fp : 00000000
r10: e9c61d7c  r9 : ef12a000  r8 : 00000001
r7 : ef12a19c  r6 : ffffffff  r5 : 600f0193  r4 : c0112884
r3 : 00000000  r2 : 00000000  r1 : c0118f28  r0 : fffffffc
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 29c7004a  DAC: 00000051
Process  (pid: 0, stack limit = 0x6b08bd12)
Stack: (0xef12a090 to 0xef07651c)
[<c0112884>] (prepare_ftrace_return) from [<c0112540>]
(ftrace_graph_caller+0x18/0x20)
Code: e5933010 e593366c e3530000 18bd8070 (e5905000)
---[ end trace 0000000000000003 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
SMP: failed to stop secondary CPUs

What is going on?
Am I doing something wrong?
Thanks

Danilo
