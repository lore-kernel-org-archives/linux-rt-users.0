From: Daniel Wagner <wagi@monom.org>
Subject: Warning: tree_plugin.h:310 rcu_note_context_switch
Date: Wed, 29 Nov 2017 17:29:59 +0100
Message-ID: <ec8b4367-ef5b-5446-2cd0-9f8f7fd6954f@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.monom.org ([188.138.9.77]:55488 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932190AbdK2Qiz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Nov 2017 11:38:55 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I was playing with cyclictest and pi_stress on x86_64 with v4.14-rt1 and got 
a greeting.

Unfortunately, I can't remember the exact the cyclictest arguments but it was either

"cyclictest -S -p 80" or "cyclictest -t -p 80"

[  142.205742] ------------[ cut here ]------------
[  142.205754] WARNING: CPU: 0 PID: 1552 at /home/wagi/work/rt/linux-rt/kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x2c7/0x560
[  142.205755] Modules linked in:
[  142.205762] CPU: 0 PID: 1552 Comm: cyclictest Not tainted 4.14.0-rt1 #3
[  142.205764] Hardware name: ADI Minnowboard Turbot D0 PLATFORM/MinnowBoard Turbot, BIOS MNW2MAX1.X64.0093.R01.1608031710 08/03/2016
[  142.205766] task: ffff8d7cf7c2e040 task.stack: ffffa4c14066c000
[  142.205770] RIP: 0010:rcu_note_context_switch+0x2c7/0x560
[  142.205772] RSP: 0018:ffffa4c14066fe20 EFLAGS: 00010002
[  142.205775] RAX: 0000000000000001 RBX: ffff8d7cf7c2e040 RCX: 0000000000000001
[  142.205777] RDX: 0000000000000000 RSI: ffffffff9c06913c RDI: ffffffff9c00196e
[  142.205779] RBP: ffffa4c14066fe58 R08: 0000000000000000 R09: 0000000000000000
[  142.205780] R10: 0000000000000000 R11: ffff8d7cf7c2e040 R12: 0000000000000000
[  142.205782] R13: ffffffff9be0da40 R14: ffff8d7cf7c2e040 R15: 0000000000000000
[  142.205784] FS:  00007f89d93a7700(0000) GS:ffff8d7cf8000000(0000) knlGS:0000000000000000
[  142.205786] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  142.205788] CR2: 00000031622286c8 CR3: 0000000079d48000 CR4: 00000000001006f0
[  142.205790] Call Trace:
[  142.205798]  __schedule+0x72/0x550
[  142.205803]  schedule+0x38/0xd0
[  142.205807]  hrtimer_wait_for_timer+0x44/0x80
[  142.205812]  ? wait_woken+0x80/0x80
[  142.205816]  SyS_timer_delete+0xb1/0x160
[  142.205821]  entry_SYSCALL_64_fastpath+0x13/0x94
[  142.205824] RIP: 0033:0x3162803f74
[  142.205826] RSP: 002b:00007f89d93a68d0 EFLAGS: 00000202 ORIG_RAX: 00000000000000e2
[  142.205829] RAX: ffffffffffffffda RBX: 00007f89d93a691c RCX: 0000003162803f74
[  142.205831] RDX: 0000000000000001 RSI: 00000000000f4240 RDI: 0000000000000000
[  142.205832] RBP: 00007f89d93a691c R08: 0000000000000000 R09: 000000000c43106a
[  142.205834] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  142.205835] R13: 0000000000000000 R14: fffffffffffffc41 R15: 0000000000000000
[  142.205839] Code: 59 8b 15 09 26 e9 00 83 ea 01 39 d1 0f 85 8a 02 00 00 83 f8 0f 48 8d 93 d8 03 00 00 0f 87 bd 01 00 00 89 c1 ff 24 cd 20 ca e0 9b <0f> ff 80 bb d0 03 00 00 00 0f 85 86 fd ff ff e9 02 ff ff ff 65 
[  142.205890] ---[ end trace 0000000000000002 ]---

Thanks,
Daniel
