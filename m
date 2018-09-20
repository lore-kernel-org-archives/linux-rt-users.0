Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail5.windriver.com ([192.103.53.11]:47232 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbeITVHb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Sep 2018 17:07:31 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8KFNCup015978
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2018 08:23:22 -0700
From: He Zhe <zhe.he@windriver.com>
Subject: WARNING when running cyclictest
Message-ID: <043561c1-3fc1-5cbc-9cec-a87e39e0218a@windriver.com>
Date: Thu, 20 Sep 2018 23:22:58 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: "He, Zhe" <Zhe.He@windriver.com>

Hi,

When running cyclictest on latest preempt-rt kernel I met the following the WARNING. It only happens when "taskset -c 0" and "-c 1"(CLOCK_REALTIME) is specified in the command line. After bisecting, it seems this happens since v4.13-rt1. Is this possibly a bug?

taskset -c 0 cyclictest -p 80 -i 1000 -l 10000 -c 1 -q

[  164.505613] WARNING: CPU: 0 PID: 864 at /linux-rt-devel/kernel/rcu/tree_plugin.h:309 rcu_note_context_switch+0x56/0x500
[  164.505614] Modules linked in:
[  164.505617] CPU: 0 PID: 864 Comm: cyclictest Not tainted 4.18.7-rt5-preempt-rt #1
[  164.505617] Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E2R1.86C.0118.R01.1503110618 03/11/2015
[  164.505619] RIP: 0010:rcu_note_context_switch+0x56/0x500
[  164.505619] Code: 25 c0 4d 01 00 45 84 e4 8b 83 e4 03 00 00 0f 85 04 01 00 00 8b bb e0 03 00 00 85 ff 0f 85 f6 00 00 00 85 c0 0f 8e ee 00 00 00 <0f> 0b 80 bb e8 03 00 00 00 0f 85 f5
[  164.505641] RSP: 0018:ffffb035c11ffde0 EFLAGS: 00010002
[  164.505643] RAX: 0000000000000001 RBX: ffff97462c1b0000 RCX: 0000000000000001
[  164.505643] RDX: 0000000000000000 RSI: ffffffffb019568c RDI: 0000000000000000
[  164.505644] RBP: ffffb035c11ffe08 R08: ffff97462c1b03d0 R09: 0000000000000000
[  164.505645] R10: ffff97462c1b03d0 R11: ffff97462c1b03b0 R12: 0000000000000000
[  164.505646] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  164.505647] FS:  00007fee8978a700(0000) GS:ffff97463b000000(0000) knlGS:0000000000000000
[  164.505648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  164.505649] CR2: 00007fee84000010 CR3: 0000000064326001 CR4: 00000000003606f0
[  164.505649] Call Trace:
[  164.505653]  __schedule+0x9a/0x6e0
[  164.505655]  schedule+0x4c/0xf0
[  164.505657]  hrtimer_wait_for_timer+0x67/0xa0
[  164.505658]  ? wait_woken+0x80/0x80
[  164.505660]  timer_wait_for_callback+0x42/0x50
[  164.505662]  __se_sys_timer_delete+0x56/0x130
[  164.505663]  __x64_sys_timer_delete+0x12/0x20
[  164.505665]  do_syscall_64+0x55/0x110
[  164.505667]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  164.505669] RIP: 0033:0x7fee8996d1d3
[  164.505669] Code: d7 48 8b 7c 24 08 eb af 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 b8 e2 00 00 00 53 48 89 fb 48 83 ec 08 8b 7f 04 0f 05 <48> 3d 00 f0 ff ff 77 65 89 c5 85 c0
[  164.505691] RSP: 002b:00007fee89789860 EFLAGS: 00000206 ORIG_RAX: 00000000000000e2
[  164.505692] RAX: ffffffffffffffda RBX: 00007fee84000b20 RCX: 00007fee8996d1d3
[  164.505693] RDX: 000000005ba3a7f0 RSI: 00000000000f4240 RDI: 0000000000000000
[  164.505694] RBP: 000055f8ac9e22b0 R08: 0000000000014f8c R09: 0000000000000001
[  164.505694] R10: 0000000024d2fa0e R11: 0000000000000206 R12: 00007fee897898f0
[  164.505695] R13: 0000000000000000 R14: 000055f8ac9e2300 R15: 000055f8ac9e22b0
[  164.505697] ---[ end trace 0000000000000002 ]---

Zhe
