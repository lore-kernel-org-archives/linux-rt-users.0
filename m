From: Friedrich Schick <Friedrich.Schick@web.de>
Subject: Set UIO priority on 3.0.X
Date: Sat, 8 Oct 2011 16:26:31 +0200
Message-ID: <CANoBzaPT3h+S5EvO+1zXe92xDEQ-Mir3UNiJCrWuqkY-QQ8Cmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42506 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab1JHO0c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Oct 2011 10:26:32 -0400
Received: by qadb15 with SMTP id b15so3257698qad.19
        for <linux-rt-users@vger.kernel.org>; Sat, 08 Oct 2011 07:26:31 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,


I am running a 3.0.3 rt11 on an FPGA embedded PowerPC 440. Everything
runs fine so far.

Currently, I am trying to get an UIO driver working with interrupts
(the kernel Oops after a short while, see below). I guess, its
something with the connected hardware, that fires too fast.

How can I set the UIO kernel driver to a higher priority than my
rt-userspace threads? Since I need the rt-threads to be scheduled
before TCP priorities are 51 and up.

By the way, what is meant by "Kernel panic - not syncing: Fatal
exception in interrupt"?


Best regards

Friedrich

-- snip

NIP [c02f2030] rt_spin_lock_slowlock+0x98/0x260
LR [c02f1fe8] rt_spin_lock_slowlock+0x50/0x260
Call Trace:
[c9ff3ef0] [c02f1fe8] rt_spin_lock_slowlock+0x50/0x260 (unreliable)
[c9ff3f50] [c0029a70] __wake_up+0x24/0x58
[c9ff3f70] [c02548f8] uio_event_notify+0x3c/0x64
[c9ff3f80] [c0254970] uio_interrupt+0x50/0x68
[c9ff3f90] [c006a6cc] handle_irq_event_percpu+0x68/0x174
[c9ff3fd0] [c006a82c] handle_irq_event+0x54/0x8c
[c9ff3fe0] [c006cf30] handle_edge_irq+0xa8/0x1a8
[c9ff3ff0] [c000b5e4] call_handle_irq+0x18/0x28
[c90c1980] [c000360c] do_IRQ+0xf0/0x14c
[c90c19b0] [c000caf8] ret_from_except+0x0/0x18
--- Exception: 501 at rt_spin_lock+0x20/0x28
   LR = add_wait_queue+0x28/0x60
[c90c1a70] [20000005] 0x20000005 (unreliable)
[c90c1a80] [c00b6df4] __pollwait+0x8c/0x108
[c90c1aa0] [c0253df4] uio_poll+0x4c/0x80
[c90c1ab0] [c00b7308] do_select+0x264/0x4e0
[c90c1db0] [c00b7734] core_sys_select+0x1b0/0x368
[c90c1f00] [c00b7928] sys_select+0x3c/0x14c
[c90c1f40] [c000c498] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xfc61ac4
   LR = 0xfc61aa4
Instruction dump:
70090004 408201a8 80010064 bb61004c 38210060 7c0803a6 4e800020 801f0008
5400003c 7fa00278 7c000034 5400d97e <0f000000> 7c000146 38600001 4bd37b75
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[c9ff3c90] [c0006890] show_stack+0x44/0x154 (unreliable)
[c9ff3cd0] [c02f2a34] panic+0xac/0x1d0
[c9ff3d20] [c0008dac] die+0x11c/0x1cc
[c9ff3d40] [c0008f58] _exception+0xa4/0x11c
[c9ff3e30] [c000caac] ret_from_except_full+0x0/0x4c
--- Exception: 700 at rt_spin_lock_slowlock+0x98/0x260
   LR = rt_spin_lock_slowlock+0x50/0x260
[c9ff3f50] [c0029a70] __wake_up+0x24/0x58
[c9ff3f70] [c02548f8] uio_event_notify+0x3c/0x64
[c9ff3f80] [c0254970] uio_interrupt+0x50/0x68
[c9ff3f90] [c006a6cc] handle_irq_event_percpu+0x68/0x174
[c9ff3fd0] [c006a82c] handle_irq_event+0x54/0x8c
[c9ff3fe0] [c006cf30] handle_edge_irq+0xa8/0x1a8
[c9ff3ff0] [c000b5e4] call_handle_irq+0x18/0x28
[c90c1980] [c000360c] do_IRQ+0xf0/0x14c
[c90c19b0] [c000caf8] ret_from_except+0x0/0x18
--- Exception: 501 at rt_spin_lock+0x20/0x28
   LR = add_wait_queue+0x28/0x60
[c90c1a70] [20000005] 0x20000005 (unreliable)
[c90c1a80] [c00b6df4] __pollwait+0x8c/0x108
[c90c1aa0] [c0253df4] uio_poll+0x4c/0x80
[c90c1ab0] [c00b7308] do_select+0x264/0x4e0
[c90c1db0] [c00b7734] core_sys_select+0x1b0/0x368
[c90c1f00] [c00b7928] sys_select+0x3c/0x14c
[c90c1f40] [c000c498] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xfc61ac4
   LR = 0xfc61aa4

-- snip
