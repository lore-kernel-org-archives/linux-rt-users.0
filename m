From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Fri, 22 Jan 2016 14:19:05 +0100
Message-ID: <56A22C49.5020401@linutronix.de>
References: <1453108103.4123.4.camel@gmail.com>
 <20160118201828.GE12309@linutronix.de> <1453170597.3740.7.camel@gmail.com>
 <20160121125405.GA11749@linutronix.de> <56A21F7D.9070101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45992 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbcAVNTH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jan 2016 08:19:07 -0500
In-Reply-To: <56A21F7D.9070101@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/22/2016 01:24 PM, Grygorii Strashko wrote:
> I can see below backtrace during boot if i backport this change in K4.1-rt
> TI am437x-idk (UP) board.
> 
> [    0.204022] Switched to clocksource arm_global_timer
> [    0.211982] ------------[ cut here ]------------
> [    0.212021] WARNING: CPU: 0 PID: 3 at kernel/softirq.c:894 __tasklet_action+0x150/0x17c()
> [    0.212027] Modules linked in:
> [    0.212041] CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 4.1.15-rt11-00324-g52f8148-dirty #117
> [    0.212046] Hardware name: Generic AM43 (Flattened Device Tree)
> [    0.212052] Backtrace: 
> [    0.212080] [<c0012b50>] (dump_backtrace) from [<c0012d70>] (show_stack+0x18/0x1c)
> [    0.212085]  r7:c0730a84 r6:0000037e r5:00000009 r4:00000000
> [    0.212112] [<c0012d58>] (show_stack) from [<c05e6940>] (dump_stack+0x20/0x28)
> [    0.212124] [<c05e6920>] (dump_stack) from [<c003713c>] (warn_slowpath_common+0x7c/0xb4)
> [    0.212134] [<c00370c0>] (warn_slowpath_common) from [<c0037218>] (warn_slowpath_null+0x24/0x2c)
> [    0.212138]  r8:000f4240 r7:00000000 r6:c0841238 r5:00000018 r4:00000006
> [    0.212156] [<c00371f4>] (warn_slowpath_null) from [<c003a0a4>] (__tasklet_action+0x150/0x17c)
> [    0.212165] [<c0039f54>] (__tasklet_action) from [<c003a138>] (tasklet_action+0x30/0x38)
> [    0.212169]  r9:04208140 r8:c0862300 r7:000000c0 r6:c082d774 r5:00000018 r4:00000006
> [    0.212187] [<c003a108>] (tasklet_action) from [<c0039c2c>] (do_current_softirqs+0x190/0x258)
> [    0.212197] [<c0039a9c>] (do_current_softirqs) from [<c003a170>] (run_ksoftirqd+0x30/0x58)
> [    0.212201]  r10:00000000 r9:00000000 r8:00000002 r7:c082d8f0 r6:00000001 r5:ee81f740
> [    0.212213]  r4:ee874000
> [    0.212227] [<c003a140>] (run_ksoftirqd) from [<c00534e0>] (smpboot_thread_fn+0x15c/0x278)
> [    0.212242] [<c0053384>] (smpboot_thread_fn) from [<c00500fc>] (kthread+0xcc/0xe4)
> [    0.212246]  r9:00000000 r8:00000000 r7:c0053384 r6:ee81f740 r5:ee81f780 r4:00000000
> [    0.212265] [<c0050030>] (kthread) from [<c000f988>] (ret_from_fork+0x14/0x2c)
> [    0.212269]  r7:00000000 r6:00000000 r5:c0050030 r4:ee81f780
> [    0.212279] ---[ end trace 0000000000000001 ]---
> [    0.212284] softirq: ================== c037d4c4 <---- t->func
> ^^
> # grep c037d4c4 System.map
> c037d4c4 t kbd_bh

Do you still see it with the missing lazy bits? I don't see where this
could come from.

Sebastian

