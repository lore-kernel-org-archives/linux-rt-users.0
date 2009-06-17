From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 15:54:55 +0200
Message-ID: <c384c5ea0906170654w4cff785o392c271f15e3a1d2@mail.gmail.com>
References: <loom.20090615T222836-377@post.gmane.org>
	 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>
	 <loom.20090616T074347-549@post.gmane.org>
	 <20090616182734.GD13048@pengutronix.de>
	 <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906171114560.2800@localhost.localdomain>
	 <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Martin Shepherd <mcs@astro.caltech.edu>,
	linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:52357 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764935AbZFQNyy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 09:54:54 -0400
Received: by gxk10 with SMTP id 10so501310gxk.13
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2009 06:54:56 -0700 (PDT)
In-Reply-To: <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Wed, Jun 17, 2009 at 1:21 PM, Remy Bohmer<linux@bohmer.net> wrote:
> Thread-ids can/will vary, and a lot of scripting is needed to map the
> proper interrupt handler of the right device driver to the proper
> kernel thread, and to set the priorities accordingly.
> And what if there is not a userland at all? and init is the only
> process in the system, or there is no shell installed?
> Or some kernel developer change the name of the interrupt handler? All
> different implementations in userspace has to follow as well... And
> why is 50 the right default to use, and not 30 or 60?
> For a realtime embedded device this could all be the case, and it is
> not that strange.
>

To make sure the end solution covers all use cases, I re-submit my case:

>From my email: "[PATCH 2.6.24.7-rt14 v2] rt:
{queue,schedule}_work_prio() allowing work priorities other than
caller's priority".

"Adds schedule_work_prio() and queue_work_prio() so that work can be
scheduled with a different priority than the caller.

Currently under PREEMPT RT, queue_work() and therefore schedule_work() makes
the work inherit the caller's priority.

However, if a real-time kernel interrupt handler thread defers work it may want
the deferred work have lower priority so it does not contend for the CPU with
succeeding interrupt handling. In the non real-time kernel, this was guaranteed
because interrupts preempt workqueues.

The faulty case was a non-FIFO serial driver that deferred LED blinking to
a workqueue using schedule_work(). However, that work used GPIO bitbanged I2C,
which uses 50 usecs udelay()s. With the work inheriting the serial IRQ priority,
it easily missed the ~60 usec deadline of 115200 bps communications.

This patch solves the issue by introducing and using schedule_work_prio()."


Basically, what I did to fix our system, was run the workqueue with
lower priority (current - 1) than the interrupt handler.
So that when the interrupt handler started the work on the queue, that
work would not increase interrupt service latency.


What would be the solution forward for this case, for mainlined
drivers having the same problem?



Regards,
-- 
Leon
