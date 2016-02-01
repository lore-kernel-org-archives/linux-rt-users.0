From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.1.15-rt17
Date: Mon, 1 Feb 2016 21:51:57 +0100
Message-ID: <20160201205157.GA25777@linutronix.de>
References: <20151222165601.GG27274@linutronix.de>
 <CALqGcGqpZRwv1RbXwyYxsbGOJg8u7HYM_8VTHbjfi4fUkDmHtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>, tglx@linutronix.de,
	rostedt@goodmis.org, C.Emde@osadl.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44133 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122AbcBAUwF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Feb 2016 15:52:05 -0500
Content-Disposition: inline
In-Reply-To: <CALqGcGqpZRwv1RbXwyYxsbGOJg8u7HYM_8VTHbjfi4fUkDmHtQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christoph Mathys | 2015-12-23 13:43:49 [+0100]:

>Has anyone tried the following lately?
>
>echo 1 > /sys/kernel/debug/tracing/events/hist/preemptirqsoff_hist
>
>This will crash my system immediately (back to BIOS POST).

We somehow endup in do_int3 where things end badly

|CPU: 3 PID: 585 Comm: bash Not tainted 4.4.1-rt4+ #198
|Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Debian-1.8.2-1 04/01/2014
|task: ffff88007ab4cd00 ti: ffff88007ab94000 task.ti: ffff88007ab94000
|RIP: 0010:[<ffffffff81684870>]  [<ffffffff81684870>] int3+0x0/0x10
|RSP: 0018:ffff88013c107fd8  EFLAGS: 00010082
|RAX: ffff88007ab4cd00 RBX: ffffffff8100ceab RCX: 0000000080202001
|RDX: 0000000000000000 RSI: ffffffff8100ceab RDI: ffffffff810c78b2
|RBP: ffff88007ab97c10 R08: ffffffffff57b000 R09: 0000000000000000
|R10: ffff88013bb64790 R11: ffff88007ab4cd68 R12: ffffffff8100ceab
|R13: ffffffff810c78b2 R14: ffffffff810f8158 R15: ffffffff810f9120
|FS:  0000000000000000(0000) GS:ffff88013c100000(0063) knlGS:00000000f74e3940
|CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
|CR2: 0000000008cf6008 CR3: 000000013b169000 CR4: 00000000000006e0
|Stack:
| ffffffff810f8158 0000000000000010 0000000000000282 ffff88007ab97be0
| 0000000000000018
|Call Trace:
| <#DB>
| [<ffffffff810f8158>] ? trace_preempt_off+0x18/0x170
| <<EOE>>
| [<ffffffff81077745>] preempt_count_add+0xa5/0xc0
| [<ffffffff810c78b2>] on_each_cpu+0x22/0x90
| [<ffffffff8100ceab>] text_poke_bp+0x5b/0xc0
| [<ffffffff8100a29c>] arch_jump_label_transform+0x8c/0xf0
| [<ffffffff8111c77c>] __jump_label_update+0x6c/0x80
| [<ffffffff8111c83a>] jump_label_update+0xaa/0xc0
| [<ffffffff8111ca54>] static_key_slow_inc+0x94/0xa0
| [<ffffffff810e0d8d>] tracepoint_probe_register_prio+0x26d/0x2c0
| [<ffffffff810e0df3>] tracepoint_probe_register+0x13/0x20
| [<ffffffff810fca78>] trace_event_reg+0x98/0xd0
| [<ffffffff810fcc8b>] __ftrace_event_enable_disable+0x6b/0x180
| [<ffffffff810fd5b8>] event_enable_write+0x78/0xc0
| [<ffffffff8117a768>] __vfs_write+0x28/0xe0
| [<ffffffff8117b025>] vfs_write+0xa5/0x180
| [<ffffffff8117bb76>] SyS_write+0x46/0xa0
| [<ffffffff81002c91>] do_fast_syscall_32+0xa1/0x1d0
| [<ffffffff81684d57>] sysenter_flags_fixed+0xd/0x17

I don't why int3 is invoked here at all but it seems to happen and it
seems to do something with the jump_labels.
We broke this once we enabled jump_labels on X86. I would like to keep
the jump labels. This can also be "fixed" by doing this:

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -498,7 +498,6 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, caller_addr);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 
any comments and/or suggestions from the interresting party?

>Christoph

Sebastian
