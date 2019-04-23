Return-Path: <SRS0=0+XQ=SZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B6C10F03
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 21:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060E7218D2
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 21:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfDWV40 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:56:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWV40 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Apr 2019 17:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E27F030ADBAB;
        Tue, 23 Apr 2019 21:56:25 +0000 (UTC)
Received: from ovpn-117-112.phx2.redhat.com (ovpn-117-112.phx2.redhat.com [10.3.117.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82CE25C1B5;
        Tue, 23 Apr 2019 21:56:25 +0000 (UTC)
Message-ID: <91d59e3f2074265c834b9a7ea48a7b41292fc9f8.camel@redhat.com>
Subject: kmsg_dump() sleeping while atomic
From:   Scott Wood <swood@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Date:   Tue, 23 Apr 2019 16:56:25 -0500
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 23 Apr 2019 21:56:25 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I got an oops on v5.0.7-rt5 (due to kexec code not properly checking for
disabled EFI, patch coming) and after the primary oops, I got this:

[  111.575331] 055: BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
[  111.584457] 055: in_atomic(): 0, irqs_disabled(): 1, pid: 13289, name: kexec
[  111.591502] 055: INFO: lockdep is turned off.
[  111.595862] 055: irq event stamp: 481304
[  111.599786] 055: hardirqs last  enabled at (481303): [<ffffffff811853b0>] ktime_get_coarse_real_ts64+0x60/0xc0
[  111.609779] 055: hardirqs last disabled at (481304): [<ffffffff81001ea1>] trace_hardirqs_off_thunk+0x1a/0x1c
[  111.619599] 055: softirqs last  enabled at (0): [<ffffffff810d13e3>] copy_process.part.30+0x833/0x2680
[  111.628900] 055: softirqs last disabled at (0): [<0000000000000000>]           (null)
[  111.636723] 055: CPU: 55 PID: 13289 Comm: kexec Tainted: G      D     E     5.0.7-rt5+ #3
[  111.644896] 055: Hardware name: Intel Corporation S2600BT/S2600BT, BIOS SE5C620.86B.01.00.0763.022420181017 02/24/2018
[  111.655582] 055: Call Trace:
[  111.658468] 055:  dump_stack+0x5e/0x8b
[  111.662223] 055:  ___might_sleep+0x177/0x1e0
[  111.666494] 055:  __rt_mutex_lock_state+0x1f/0x80
[  111.671202] 055:  kmsg_dump+0x88/0x160
[  111.674951] 055:  ? kmsg_dump+0x1f/0x160
[  111.678880] 055:  oops_end+0x59/0xd0
[  111.682459] 055:  no_context+0x185/0x540
[  111.686383] 055:  ? __do_page_fault+0x1da/0x530
[  111.690918] 055:  do_page_fault+0x2d/0x290
[  111.695017] 055:  page_fault+0x1e/0x30
[  111.698769] 055: RIP: 0010:          (null)
[  111.702956] 055: Code: Bad RIP value.
[  111.706618] 055: RSP: 0018:ffffc900754d3ea8 EFLAGS: 00010246
[  111.712278] 055: 
[  111.714213] 055: RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc900754d3eb8
[  111.721777] 055: RDX: 0000000000000000 RSI: ffffc900754d3ec0 RDI: ffffc900754d3ed2
[  111.729342] 055: RBP: ffffc900754d3ef8 R08: ffffc900754d3eb7 R09: 0000000000000000
[  111.736910] 055: R10: 0000000000000000 R11: 0000000000000005 R12: 0000000000e84950
[  111.744476] 055: R13: 0000000037f54730 R14: 0000000000000000 R15: 0000000000000000
[  111.752045] 055:  ? arch_ima_get_secureboot+0x11e/0x190
[  111.757269] 055:  ? selinux_kernel_read_file+0x20/0x20
[  111.762406] 055:  ? ima_load_data+0x46/0xa0
[  111.766593] 055:  ? __x64_sys_kexec_load+0x44/0xd0
[  111.771384] 055:  ? do_syscall_64+0x5a/0x260
[  111.775657] 055:  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  111.791742] 055: RIP: 0010:          (null)
[  111.795930] 055: Code: Bad RIP value.
[  111.799595] 055: RSP: 0018:ffffc900754d3ea8 EFLAGS: 00010246
[  111.805254] 055: 
[  111.807185] 055: RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc900754d3eb8
[  111.814750] 055: RDX: 0000000000000000 RSI: ffffc900754d3ec0 RDI: ffffc900754d3ed2
[  111.822309] 055: RBP: ffffc900754d3ef8 R08: ffffc900754d3eb7 R09: 0000000000000000
[  111.829873] 055: R10: 0000000000000000 R11: 0000000000000005 R12: 0000000000e84950
[  111.837440] 055: R13: 0000000037f54730 R14: 0000000000000000 R15: 0000000000000000
[  111.845008] 055: FS:  00007fe31bffa740(0000) GS:ffff8897de200000(0000) knlGS:0000000000000000
[  111.853525] 055: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  111.859704] 055: CR2: ffffffffffffffd6 CR3: 00000017d47da004 CR4: 00000000007606e0
[  111.867272] 055: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  111.874837] 055: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  111.882401] 055: PKRU: 55555554
[  111.885540] 055: Kernel panic - not syncing: Fatal exception
[  111.891314] 055: Kernel Offset: disabled

...plus a bunch of "unexpected reschedule of offline CPU" messages.

kmsg_dump() calls kmsg_dump_rewind(), which calls mutex_lock().  This would
be broken even on non-RT.

It's not clear what kmsg_dump_lock is even supposed to be protecting --
kmsg_dump_get_buffer() does not take the lock, and the only caller to the
locked version of kmsg_dump_get_line() is in arch/um/kernel/kmsg_dump.c.

-Scott


