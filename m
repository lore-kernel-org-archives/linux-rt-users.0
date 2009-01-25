From: Remy Bohmer <linux@bohmer.net>
Subject: Spinlock recursion detected on preempt-RT and interrupt handler
	set_type code
Date: Sun, 25 Jan 2009 22:46:10 +0100
Message-ID: <3efb10970901251346i455e5869w9481d9c03aa2696f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:64608 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbZAYVqM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Jan 2009 16:46:12 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello All,

I ran into a spinlock recursion problem while testing the locking
corrctness of a 2.6.24.7-rt26-kernel on a Freescale iMX processor
(ARM). Unfortunately this Freescale architecture code is not in
mainline, but at least the blackfin architecture seems to have the
same setup (looking at bfin_gpio_irq_type() ), so it is not a
Freescale only problem.

What happens is that these routines are called in this order:
-> request_irq()
    -> setup_irq()  --> Lock the spinlock
(spin_lock_irqsave(&desc->lock, flags)) for the first time
        -> gpio_set_irq_type()  (or bfin_gpio_irq_type() on blackfin
in arch/blackfin/mach-common/ints-priority-sc.c)
            -> set_irq_handler()
               -> __set_irq_handler()   --> Locks the same spinlock a
2nd time, resulting in a BUG/hang, see below

I am looking at this code for a while now, and have not found a proper
solution to solve this problem yet. Does anyone have a great idea?

Kind Regards,

Remy


[    3.705384] BUG: spinlock recursion on CPU#0, swapper/1
[    3.710630]  lock: c03bc3c4, .magic: dead4ead, .owner: swapper/1,
.owner_cpu: 0
[    3.717944] [<c0034da8>] (dump_stack+0x0/0x14) from [<c016b558>]
(spin_bug+0x94/0xa8)
[    3.725867] [<c016b4c4>] (spin_bug+0x0/0xa8) from [<c02d49c4>]
(_raw_spin_lock+0x50/0x130)
[    3.734219]  r6:c7c26000 r5:c03bc3c4 r4:c03bc3c4
[    3.738890] [<c02d4974>] (_raw_spin_lock+0x0/0x130) from
[<c02d4250>] (__spin_lock_irqsave+0x28/0x30)
[    3.748181] [<c02d4228>] (__spin_lock_irqsave+0x0/0x30) from
[<c007cd44>] (__set_irq_handler+0x90/0x16c)
[    3.757731]  r5:0000007a r4:c03bc344
[    3.761343] [<c007ccb4>] (__set_irq_handler+0x0/0x16c) from
[<c00424a8>] (gpio_set_irq_type+0xd4/0x138)
[    3.770814] [<c00423d4>] (gpio_set_irq_type+0x0/0x138) from
[<c007c178>] (setup_irq+0x12c/0x20c)
[    3.779688]  r6:c7e877e0 r5:c03bc344 r4:00000000
[    3.784356] [<c007c04c>] (setup_irq+0x0/0x20c) from [<c007c2f0>]
(request_irq+0x98/0xc0)
[    3.792512] [<c007c258>] (request_irq+0x0/0xc0) from [<c01fb210>]
(clearpad_probe+0x3a0/0x414)
