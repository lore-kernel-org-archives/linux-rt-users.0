Return-Path: <SRS0=QNvF=T5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BBEC28CC0
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 May 2019 10:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7276C208CB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 May 2019 10:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE2KVa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 May 2019 06:21:30 -0400
Received: from mail5.windriver.com ([192.103.53.11]:49984 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfE2KVa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 May 2019 06:21:30 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x4TAL908012317
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-rt-users@vger.kernel.org>; Wed, 29 May 2019 03:21:19 -0700
Received: from [128.224.162.221] (128.224.162.221) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 29 May
 2019 03:20:58 -0700
To:     <linux-rt-users@vger.kernel.org>
From:   He Zhe <zhe.he@windriver.com>
Subject: glibc nptl tst-robustpi8.c crashes since v5.0.3-rt1
Message-ID: <edd7c4be-738e-5b4f-73f4-0ff4b233a281@windriver.com>
Date:   Wed, 29 May 2019 18:20:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.221]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Since v5.0.3-rt1, glibc/nptl/tst-robustpi8.c causes the following crash.
https://github.com/lattera/glibc/blob/master/nptl/tst-robustpi8.c

root@intel-x86-64:~# ./tst-robustpi8
007: ------------[ cut here ]------------
007: kernel BUG at /buildarea2/zhe/repo/linux-rt-devel/kernel/locking/rtmutex.c:1336!
007: invalid opcode: 0000 [#1] PREEMPT SMP PTI
007: CPU: 7 PID: 536 Comm: tst-robustpi8 Tainted: G        W         5.0.3-yocto-preempt-rt+ #23
007: Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E2R1.86C.0118.R01.1503110618 03/11/2015
007: RIP: 0010:task_blocks_on_rt_mutex+0x211/0x240
007: Code: 89 de 4c 89 e7 e8 0f f7 ff ff 4c 89 e7 e8 f7 f7 ff ff 49 8b 84 24 30 09 00 00 31 d2 48 83 f8 02 0f 97 c2 e9 07 ff ff ff 0f 0b <0f> 0b 0f 0b 48 89 5d c8 e9 99 fe ff ff b8 dd ff ff ff e9 61 ff ff
007: RSP: 0018:ffffa15c41adfab0 EFLAGS: 00010096
007:
007: RAX: ffffa15c41adfc80 RBX: ffffa15c41adfb50 RCX: 0000000000000000
007: RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9af85af288d0
007: RBP: ffffa15c41adfaf0 R08: 0000000000000001 R09: 0000000000000000
007: R10: 0000000000000000 R11: ffff9af85af283a8 R12: ffff9af85af20000
007: R13: ffff9af85af288d0 R14: ffff9af85af28000 R15: ffffa15c414a2308
007: FS:  00007fac9dd8b700(0000) GS:ffff9af878fc0000(0000) knlGS:0000000000000000
007: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
007: CR2: 000055fd7d150240 CR3: 000000005af18005 CR4: 00000000003606e0
007: Call Trace:
007:  rt_spin_lock_slowlock_locked+0x87/0x230
007:  rt_spin_lock_slowlock+0x67/0xa0
007:  rt_spin_lock+0x38/0x40
007:  ? futex_lock_pi+0x2cd/0x490
007:  futex_lock_pi+0x2cd/0x490
007:  ? hrtimer_init_sleeper+0x130/0x130
007:  do_futex+0x330/0xc40
007:  ? trace_hardirqs_on_thunk+0x1a/0x1c
007:  ? _copy_from_user+0x36/0x70
007:  __se_sys_futex+0x7f/0x170
007:  __x64_sys_futex+0x29/0x30
007:  do_syscall_64+0x55/0x130
007:  entry_SYSCALL_64_after_hwframe+0x49/0xbe
007: RIP: 0033:0x7fac9f7590c4
007: Code: 85 c0 0f 84 ee 03 00 00 be 06 00 00 00 45 85 c0 0f 84 b0 04 00 00 4c 8b 54 24 18 ba 01 00 00 00 48 89 df b8 ca 00 00 00 0f 05 <3d> 00 f0 ff ff 0f 86 59 04 00 00 83 f8 92 74 72 89 c2 83 e2 df 83
007: RSP: 002b:00007fac9dd8ade0 EFLAGS: 00000202
007:  ORIG_RAX: 00000000000000ca
007: RAX: ffffffffffffffda RBX: 00007fac9f7727d0 RCX: 00007fac9f7590c4
007: RDX: 0000000000000001 RSI: 0000000000000006 RDI: 00007fac9f7727d0
007: RBP: 00007fac9f7727e0 R08: 0000000000000010 R09: 0000000000000000
007: R10: 000055fd7d150240 R11: 0000000000000202 R12: 00007ffe550b363e
007: R13: 0000000000000218 R14: 00007fac9dd8b700 R15: 0000000000000000
007: Modules linked in:
007:
007: ---[ end trace ae0f59c8162f348b ]---
007: RIP: 0010:task_blocks_on_rt_mutex+0x211/0x240
007: Code: 89 de 4c 89 e7 e8 0f f7 ff ff 4c 89 e7 e8 f7 f7 ff ff 49 8b 84 24 30 09 00 00 31 d2 48 83 f8 02 0f 97 c2 e9 07 ff ff ff 0f 0b <0f> 0b 0f 0b 48 89 5d c8 e9 99 fe ff ff b8 dd ff ff ff e9 61 ff ff
007: RSP: 0018:ffffa15c41adfab0 EFLAGS: 00010096
007:
007: RAX: ffffa15c41adfc80 RBX: ffffa15c41adfb50 RCX: 0000000000000000
007: RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9af85af288d0
007: RBP: ffffa15c41adfaf0 R08: 0000000000000001 R09: 0000000000000000
007: R10: 0000000000000000 R11: ffff9af85af283a8 R12: ffff9af85af20000
007: R13: ffff9af85af288d0 R14: ffff9af85af28000 R15: ffffa15c414a2308
007: FS:  00007fac9dd8b700(0000) GS:ffff9af878fc0000(0000) knlGS:0000000000000000
007: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
007: CR2: 000055fd7d150240 CR3: 000000005af18005 CR4: 00000000003606e0


Zhe
