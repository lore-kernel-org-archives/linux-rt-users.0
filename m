Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6AAC2BA19
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 10:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24672074F
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 10:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgDWKMy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:12:54 -0400
Received: from mail.klingt.org ([86.59.21.178]:35814 "EHLO klingt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWKMx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 06:12:53 -0400
X-Greylist: delayed 890 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 06:12:53 EDT
Received: from [192.168.1.4] ([42.191.166.60])
        (authenticated bits=0)
        by klingt.org (8.15.2/8.15.2/Debian-18) with ESMTPSA id 03N9vxFT1882147
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Apr 2020 11:58:01 +0200
To:     linux-rt-users@vger.kernel.org
From:   Tim Blechmann <tim@klingt.org>
Subject: [4.19.103-rt42] rcu_preempt detected stalls
Autocrypt: addr=tim@klingt.org; keydata=
 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
 4L9FRmj0m4Wovh7D9sqsUh6g9eiS4w==
Message-ID: <b22588fe-dce1-ba98-9022-5e7b2608443b@klingt.org>
Date:   Thu, 23 Apr 2020 17:57:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Greylist: inspected by milter-greylist-4.6.2 (klingt.org [86.59.21.178]); Thu, 23 Apr 2020 11:58:02 +0200 (CEST) for IP:'42.191.166.60' DOMAIN:'[42.191.166.60]' HELO:'[192.168.1.4]' FROM:'tim@klingt.org' RCPT:''
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (klingt.org [86.59.21.178]); Thu, 23 Apr 2020 11:58:02 +0200 (CEST)
X-Virus-Scanned: clamav-milter 0.102.2 at es.klingt.org
X-Virus-Status: Clean
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

hi all,

updating the RT kernel from 4.14 to 4.19, we're experiencing a lockup of
of RT threads:

"Worker 1" and "Worker 2" are my RT threads, which run at high
SCHED_FIFO priorities. they are both synchronised via the same futex.
wildly speculating, we might run into a race condition between
`futex_wake` while `try_to_wake_up -> futex_wait`

is this a known issue (it seems that rt48 has some RT related changes)?
or is there a good way to trace this down? cyclictest doesn't seem to
trigger this situation, with our real-world load, it takes hours to
trigger it.

thanks a lot,
tim

---

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:         Tasks blocked on level-0 rcu_node (CPUs 0-3): P693 P692
rcu:         (detected by 0, t=21002 jiffies, g=463681, q=2032)
Worker 2   D    0   693      1 0x00000000
Call Trace:
 ? __schedule+0x2cf/0x770
 schedule+0x43/0xe0
 rt_spin_lock_slowlock_locked+0x11b/0x2c0
 rt_spin_lock_slowlock+0x41/0x60
 futex_wake+0xa2/0x150
 do_futex+0x942/0xd90
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 ? do_preempt_schedule_irq+0x17/0x17
 ? do_futex+0xd90/0xd90
 __x64_sys_futex+0x136/0x14f
 ? do_syscall_64+0x1e/0x3f0
 do_syscall_64+0x5d/0x3f0
 ? trace_hardirqs_off_thunk+0x1a/0x1c
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f9f9e9a0311
Code: ff ff ff 7f 74 4b 48 8d 50 01 f0 48 0f b1 17 75 ee 48 c1 e8 20 74
1b 40 80 f6 81 45 31 d2 ba 01 00 00 00 b8 ca 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 83 c0 16 83 e0 f7 74
RSP: 002b:00007f9f7affca28 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9f9e9a0311
RDX: 0000000000000001 RSI: 0000000000000081 RDI: 000055b8f8c20a88
RBP: 0000000000000001 R08: 000055b9072f2820 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000055b8f8c20a88
R13: 00007f9f7affca97 R14: 00007f9f7affca98 R15: 00007f9f7affcaa0
Worker 1   R  running task        0   692      1 0x00000000
Call Trace:
 ? __schedule+0x2cf/0x770
 ? ___preempt_schedule+0x16/0x18
 preempt_schedule_common+0x32/0xc0
 ___preempt_schedule+0x16/0x18
 ? migrate_disable+0x38/0xc0
 ? migrate_disable+0x38/0xc0
 migrate_disable+0x6c/0xc0
 get_futex_value_locked+0x14/0x60
 futex_wait_setup+0x80/0x100
 ? futex_wait_queue_me+0xbf/0x120
 futex_wait+0xb9/0x210
 ? try_to_wake_up+0x230/0x6c0
 do_futex+0x134/0xd90
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 ? do_preempt_schedule_irq+0x17/0x17
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 ? trace_hardirqs_on_caller+0x32/0x130
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 ? do_preempt_schedule_irq+0x17/0x17
 __x64_sys_futex+0x136/0x14f
 ? do_syscall_64+0x1e/0x3f0
 do_syscall_64+0x5d/0x3f0
 ? trace_hardirqs_off_thunk+0x1a/0x1c
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f9f9e99fd54
Code: e8 41 0b 00 00 b9 ca 00 00 00 41 89 c4 89 de 41 b9 ff ff ff ff 45
31 c0 81 f6 89 01 00 00 45 31 d2 31 d2 48 89 ef 89 c8 0f 05 <48> 3d 00
f0 ff ff 77 14 44 89 e7 e8 6c 0b 00 00 5b 31 c0 5d 41 5c
RSP: 002b:00007f9f7b7fda80 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9f9e99fd54
RDX: 0000000000000000 RSI: 0000000000000189 RDI: 000055b8f8c20a88
RBP: 000055b8f8c20a88 R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: fffffffeffffffff R14: 000055b8f8c20a88 R15: 00007f9f7b7fe700
