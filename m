From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Set UIO priority on 3.0.X
Date: Wed, 12 Oct 2011 16:11:26 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110121605400.3240@ionos>
References: <CANoBzaOntUyBmyXvSO=3VfWyQgeHVUewL483178U8FYtkwHHLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Friedrich Schick <friedrich.schick@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60628 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1JLOL2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Oct 2011 10:11:28 -0400
In-Reply-To: <CANoBzaOntUyBmyXvSO=3VfWyQgeHVUewL483178U8FYtkwHHLw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 9 Oct 2011, Friedrich Schick wrote:
> Hello,

Resending the same message over and over does not make people more
repsonsive - quite the contrary it might promote you on the ignore
list easily.
 
> I am running a 3.0.3 rt11 on an FPGA embedded PowerPC 440. Everything
> runs fine so far.
> 
> Currently, I am trying to get an UIO driver working with interrupts
> (the kernel Oops after a short while, see below). I guess, its
> something with the connected hardware, that fires too fast.

That guess is very wrong and guessing in the context of kernel oopses
is never a good idea.

> How can I set the UIO kernel driver to a higher priority than my
> rt-userspace threads? Since I need the rt-threads to be scheduled
> before TCP priorities, my userspace priorities are 51 and up.

chrt
 
> By the way, what is meant by "Kernel panic - not syncing: Fatal
> exception in interrupt"?

A fatal exception happend in interrupt context. The kernel can not
recover from that. The only resolution is PANIC.
 
> NIP [c02f2030] rt_spin_lock_slowlock+0x98/0x260
> LR [c02f1fe8] rt_spin_lock_slowlock+0x50/0x260
> Call Trace:
> [c9ff3ef0] [c02f1fe8] rt_spin_lock_slowlock+0x50/0x260 (unreliable)
> [c9ff3f50] [c0029a70] __wake_up+0x24/0x58

This looks very wrong. Seems you requested the interrupt with
IRQF_NO_THREAD which cannot work with UIO.

> [c9ff3f70] [c02548f8] uio_event_notify+0x3c/0x64
> [c9ff3f80] [c0254970] uio_interrupt+0x50/0x68
> [c9ff3f90] [c006a6cc] handle_irq_event_percpu+0x68/0x174
> [c9ff3fd0] [c006a82c] handle_irq_event+0x54/0x8c
> [c9ff3fe0] [c006cf30] handle_edge_irq+0xa8/0x1a8
> [c9ff3ff0] [c000b5e4] call_handle_irq+0x18/0x28
> [c90c1980] [c000360c] do_IRQ+0xf0/0x14c
> [c90c19b0] [c000caf8] ret_from_except+0x0/0x18

Thanks,

	tglx
