Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07F1C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Mar 2022 19:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbiCWThT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344307AbiCWThQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Mar 2022 15:37:16 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8330E89090
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 12:35:45 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id c4so1413983vkq.9
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Mar 2022 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6gZr5RFx2ghdzotAtFrgJtRK7f3V/b1riCGzfNKNtVo=;
        b=dI90R7RKPImXzBoD8xduXsVMBDEf9qmbG/xI5NNXHBevr/lvJwaaYb9szmdf8cGVlF
         YIxZKumP3/YQQX3bU2yNAFhmOPShbA/2thl5hBToBgV80p2kcf1XKMePcmWG0rrUayfL
         utNTxpL7MuhSGbjXKhI9i88vyYnrZK3yXO+vMzYYKTcrUIwYwcb2E8pKxa0pxdPnj9jt
         fZBren4YZZCgvDpx7XhAX96htC2R35Gq6Z6urNYYY/HqUEF4g4eqJL0lT0gzfGf1deTg
         q+9hO6Lsil1QsuPM67lT6W474wJa3LkWC2NUm3E9uhudXjFCfrQF5SJ3mWV7NEtn2o5D
         q7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6gZr5RFx2ghdzotAtFrgJtRK7f3V/b1riCGzfNKNtVo=;
        b=jNHq32jb4zxsYgLThJQDADPAT8I1t2mCXLikNXSU+q5n00wlLmomKGNsxYKBwc8yqy
         ggLiVv/Q4vqsiyC2pWjrZvQUGKGFAx45yrIonGRv5DMt91jhc+yI1lJWz3Dc1fiAmVgQ
         L9hDY4HT5nN78fDk6imGhnwTV3AMcxZahbG1miCMfMuMaQjI6ED8S1BNRSseoDNWStGE
         y4DFL4bPYxwM+pp/Gyob2BBUm1+OW+VLvqGcnLCkIosXQ02jclHljgrBz5vZs640bR/S
         BYcwAdu14NKBEUjKfEyVDtH042Or2zsTuu1RFSmXCIjBh2/ja2GvMlowa6Zjy4Y4M7yP
         eBHg==
X-Gm-Message-State: AOAM531ewx9LWRtla47O8W8k6SKggY8NocZAT5QzNQZakgWtUzgCgial
        w0ziGJe8kTAsu/dwg/eNFclZcIGmw59e3a+9Zi3CFHSBTRo=
X-Google-Smtp-Source: ABdhPJzf5zuDjEIbGdOf7k92J0F3ZWAfuvX4gfrzwZ1+6n+LfKiBDzjLlqagy7BB5SVaN9lXL9nmlHcOguIVK/wtuko=
X-Received: by 2002:a05:6122:218d:b0:33f:b74a:17e1 with SMTP id
 j13-20020a056122218d00b0033fb74a17e1mr885949vkd.26.1648064144123; Wed, 23 Mar
 2022 12:35:44 -0700 (PDT)
MIME-Version: 1.0
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Wed, 23 Mar 2022 12:35:33 -0700
Message-ID: <CA+1+E3UVmbLA76t_JkZMMC6FHsmc_EOKeLztvgN6nAhTjjK5bQ@mail.gmail.com>
Subject: 5.15.28-rt35 #2 SMP PREEMPT_RT: Should scheduling latency be as large
 as 800 usec?
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I built 5.15.28-rt35 #2 SMP PREEMPT_RT  with  =E2=80=9CFully Preemptible
Kernel" option and otherwise using .config from  a stock Ubuntu 20.04
 5.4.0 kernel.

Quick question: I see scheduling/wake_up latencies around 800 usec and
this is confirmed by cyclictest. Is there a link that can point me to
systematic steps I can take to trace down if my problem is a wrong
config param (un-needed, hurtful debug option) or this is best that I
can do (on good modern HW.)?  I am hoping that with PREEMPT-RT on an
unloaded system running at SCHED_FIFO prio 99 I can get max latencies
of <=3D 100 usec? Is this possible?

Details:

node-0> grep -i preempt /boot/config-5.15.28-rt35
CONFIG_HAVE_PREEMPT_LAZY=3Dy
CONFIG_PREEMPT_LAZY=3Dy
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_RT=3Dy
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy
CONFIG_PREEMPT_RCU=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC=3DyA
CONFIG_PREEMPT_NOTIFIERS=3Dy
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

node-0> grep -i debug  /boot/config-5.15.28-rt35 |grep  =3Dy
CONFIG_SLUB_DEBUG=3Dy
CONFIG_IOSF_MBI_DEBUG=3Dy
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_PM_DEBUG=3Dy
CONFIG_PM_ADVANCED_DEBUG=3Dy
CONFIG_PM_SLEEP_DEBUG=3Dy
CONFIG_ACPI_DEBUGGER=3Dy
CONFIG_ACPI_DEBUGGER_USER=3Dy
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_BLK_DEBUG_FS=3Dy
CONFIG_BLK_DEBUG_FS_ZONED=3Dy
CONFIG_NFS_DEBUG=3Dy
CONFIG_SUNRPC_DEBUG=3Dy
CONFIG_DYNAMIC_DEBUG=3Dy
CONFIG_DYNAMIC_DEBUG_CORE=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_INFO=3Dy
CONFIG_DEBUG_INFO_DWARF4=3Dy
CONFIG_DEBUG_FS=3Dy
CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
CONFIG_ARCH_HAS_EARLY_DEBUG=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_DEBUG_MISC=3Dy
CONFIG_ARCH_HAS_DEBUG_WX=3Dy
CONFIG_DEBUG_WX=3Dy
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
CONFIG_SCHED_DEBUG=3Dy
CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
CONFIG_X86_DEBUG_FPU=3Dy

My test involves using "nanosleep(x)" with different values of "x" and
examining stats of actual sleep durations. I see:

#nanosleep_duration  minimum:  maximum:  mean:    num_points:  Range
100                  103       934       108.635  100000       831
500                  504       1377      543.272  100000       873
1000                 1010      1870      1053.24  100000       860
2000                 2010      2872      2052.46  100000       862
4000                 4011      4906      4046.66  100000       895
10000                10013     10738     10067.3  100000       725

I next ran cyclictest which mostly agrees with the ~700-800 max
latency I see in my own tests:

node-0> sudo ./cyclictest --mlockall --smp --priority=3D80
--interval=3D1000 --distance=3D0
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 2.84 0.86 0.62 1/551 8688

T: 0 ( 8655) P:80 I:1000 C:   6656 Min:      3 Act:    3 Avg:    4 Max:    =
  24
T: 1 ( 8656) P:80 I:1000 C:   6650 Min:      3 Act:    4 Avg:    5 Max:    =
  68
T: 2 ( 8657) P:80 I:1000 C:   6645 Min:      3 Act:    4 Avg:    4 Max:    =
  24
T: 3 ( 8658) P:80 I:1000 C:   6640 Min:      3 Act:    4 Avg:    4 Max:    =
  28
T: 4 ( 8659) P:80 I:1000 C:   6635 Min:      3 Act:    3 Avg:    4 Max:    =
  27
T: 5 ( 8660) P:80 I:1000 C:   6629 Min:      3 Act:    3 Avg:    4 Max:    =
  26
T: 6 ( 8661) P:80 I:1000 C:   6625 Min:      3 Act:    3 Avg:    4 Max:    =
  25
T: 7 ( 8662) P:80 I:1000 C:   6620 Min:      3 Act:    3 Avg:    4 Max:    =
  98
T: 8 ( 8663) P:80 I:1000 C:   6615 Min:      3 Act:    4 Avg:    5 Max:    =
 300
T: 9 ( 8664) P:80 I:1000 C:   6610 Min:      3 Act:    3 Avg:    5 Max:    =
 610
T:10 ( 8665) P:80 I:1000 C:   6606 Min:      3 Act:    4 Avg:    4 Max:    =
  16
T:11 ( 8666) P:80 I:1000 C:   6601 Min:      3 Act:    3 Avg:    5 Max:    =
 319
T:12 ( 8667) P:80 I:1000 C:   6596 Min:      3 Act:    5 Avg:    5 Max:    =
 696
T:13 ( 8668) P:80 I:1000 C:   6592 Min:      3 Act:    4 Avg:    5 Max:    =
 149
T:14 ( 8669) P:80 I:1000 C:   6587 Min:      3 Act:    3 Avg:    5 Max:    =
 633
T:15 ( 8670) P:80 I:1000 C:   6583 Min:      3 Act:    3 Avg:    4 Max:    =
 159
T:16 ( 8671) P:80 I:1000 C:   6578 Min:      3 Act:    3 Avg:    5 Max:    =
 661
T:17 ( 8672) P:80 I:1000 C:   6574 Min:      3 Act:    4 Avg:    5 Max:    =
 170
T:18 ( 8673) P:80 I:1000 C:   6569 Min:      3 Act:    3 Avg:    4 Max:    =
  13
T:19 ( 8674) P:80 I:1000 C:   6565 Min:      3 Act:    4 Avg:    4 Max:    =
 348
T:20 ( 8675) P:80 I:1000 C:   6561 Min:      3 Act:    3 Avg:    4 Max:    =
  23
T:21 ( 8676) P:80 I:1000 C:   6556 Min:      3 Act:    4 Avg:    5 Max:    =
 635
T:22 ( 8677) P:80 I:1000 C:   6552 Min:      3 Act:    4 Avg:    5 Max:    =
 349
T:23 ( 8678) P:80 I:1000 C:   6548 Min:      3 Act:    3 Avg:    4 Max:    =
  16
T:24 ( 8679) P:80 I:1000 C:   6543 Min:      3 Act:    4 Avg:    6 Max:    =
 610
T:25 ( 8680) P:80 I:1000 C:   6539 Min:      3 Act:    3 Avg:    4 Max:    =
  99
T:26 ( 8681) P:80 I:1000 C:   6534 Min:      3 Act:    4 Avg:    4 Max:    =
 547
T:27 ( 8682) P:80 I:1000 C:   6530 Min:      3 Act:    3 Avg:    5 Max:    =
 157
T:28 ( 8683) P:80 I:1000 C:   6526 Min:      3 Act:    4 Avg:    4 Max:    =
  26
T:29 ( 8684) P:80 I:1000 C:   6521 Min:      3 Act:    4 Avg:    5 Max:    =
 382
T:30 ( 8685) P:80 I:1000 C:   6517 Min:      3 Act:    3 Avg:    4 Max:    =
  17
T:31 ( 8686) P:80 I:1000 C:   6512 Min:      3 Act:    3 Avg:    5 Max:    =
 639

My HW is a Dell d430 on which /proc/cpuinfo shows 32 processors of type:

processor       : 31
vendor_id       : GenuineIntel
cpu family      : 6
model           : 63
model name      : Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz
stepping        : 2
microcode       : 0x46
cpu MHz         : 1200.000
cache size      : 20480 KB

Any directions to how one goes about reducing my max latencies will be
much appreciated.
