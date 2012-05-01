From: Remy Bohmer <linux@bohmer.net>
Subject: Relation IRQF_ONESHOT compared to IRQF_NO_THREAD and forced threading setting.
Date: Tue, 1 May 2012 21:01:39 +0200
Message-ID: <CANqCtQ+PTbh-zvOek1aLZ_mZbYhu+_OCC35a8JpyQHkxTKaq=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60181 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757293Ab2EATBk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 May 2012 15:01:40 -0400
Received: by were53 with SMTP id e53so337014wer.19
        for <linux-rt-users@vger.kernel.org>; Tue, 01 May 2012 12:01:39 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have a question regarding the IRQF_ONESHOT setting to always be
enabled by default on preempt-RT in relation to forced threading

Let's consider the following:
1) I have a driver that subscribes its interrupt handlers with:
request_threaded_irq(irq, handler, thread_fn, IRQF_SHARED, "blah", dev_id);

Both handler AND thread_fn are nonzero and valid pointers.

2) request_thread_irq continues and calls __setup_irq()
3) eventually it comes here:
        if (nested) {
                     ...........
        } else {
                if (irq_settings_can_thread(desc))
                        irq_setup_forced_threading(new);
        }

4) we enter the function: irq_setup_forced_threading():
Data is still:
        new->handler = handler;
        new->thread_fn = thread_fn;

static void irq_setup_forced_threading(struct irqaction *new)
{
        if (!force_irqthreads)
                return;
        if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
                return;

        new->flags |= IRQF_ONESHOT;

        if (!new->thread_fn) {
                set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
                new->thread_fn = new->handler;
                new->handler = irq_default_primary_handler;
        }
}

On preempt-RT: force_irqthreads = nonzero

As I see it there are now 2 options:
* I want IRQF_ONESHOT: In that case the flags are allowed to be
IRQF_SHARED (default)
* I do NOT want IRQF_ONESHOT: I have to set IRQF_NO_THREAD | IRQF_SHARED.

So, if I do not want ONESHOT to be set, I have to pass NO_THREAD, I
cannot prevent it otherwise to be set. There is an implicit relation
between both flags where the default behavior of ONESHOT is influenced
by the NO_THREAD flag.
This feels weird, since I have called request_threaded_irq() with a
handler AND a thread-function (I have a thread, so why do I need to
specify NO_THREAD?, according to interrupt.h: "IRQF_NO_THREAD -
Interrupt cannot be threaded").

Can you please explain to me what the reasoning behind this is, since
it feels to me that specifying NO_THREAD in my driver now works by
accident...
(Would a flag name 'IRQF_NO_ONESHOT', or 'IRQF_NO_FORCED_THREAD' not
be more logical in this case?)

Furthermore, what if I call request_threaded_irq() without a thread
function, since I wanted to install the handler only as hard-irq? In
that case I MUST explicitly specify NO_THREAD as well, otherwise it
would force it to go threaded and in ONESHOT mode. Should the call to
request_thread_irq() without thread function pointer not imply this
NO_THREAD?

Kind regards,

Remy
