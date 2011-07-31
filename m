From: Remy Bohmer <linux@bohmer.net>
Subject: threaded interrupt handlers: what if hardirq part not disables device interrupt?
Date: Sun, 31 Jul 2011 16:15:01 +0200
Message-ID: <CANqCtQ+9ab1qt0WzuC6n6gX9Y8XNcDxaTosUBc94eecj0umuiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab1GaOPC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 31 Jul 2011 10:15:02 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Thomas, Peter,

While getting the new RT6-patch working properly on a Atmel AT91
board, I ran into the problem that the atmel-serial driver misses
characters since its interrupt hander runs in thread context and it
cannot keep up with the 1-byte RX 'FIFO' of the DBGU port.
It makes the terminal slow and broken.

To solve this issue, I thought to make proper use of the threaded
interrupt mechanism and make:
* 1 part run in hard-irq context, only handling the RX-fifo, push it
in a queue and
*  wake the irq-thread to process the data from the queue.

Digging through the interrupt code I read that the hard-irq part
should disable the device interrupt, while the irq-thread needs to
reenable it after it has handled it completely.
If I am going to use the queue idea as depicted above, the hard-irq
should keep on being enabled forever, and just wake up the irq-thread
once it has pushed data in the queue, on which the irq-thread could
process it on its own.
This seem to be against the principles as on which the current
interrupt handling code is based. It does not even work properly if I
do it this way.
Disabling the device interrupt in the hard-irq until the irq-thread
reenables it again, does not solve the problem since characters will
be missed.

As alternative solution I can do the following as well:
The driver now has a tasklet used for processing the queue. If I add
IRQF_NO_THREAD as irq-flag, the thread is not created and the handler
runs completely in hard-irq context. This seems to work okay, but it
does not feel as the right solution.

How is this supposed to work? Do you have better ideas how to solve
situations like this?

Kind regards,

Remy
