From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] ARM AT91 Use IRQF_TIMER flag to prevent early boot
 crash
Date: Tue, 2 Jun 2015 22:27:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506022220170.20347@nanos>
References: <20150602133341.666241244@osadl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53025 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbbFBU1B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 16:27:01 -0400
In-Reply-To: <20150602133341.666241244@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2 Jun 2015, Carsten Emde wrote:
> When threaded interrupts are configured, they may not be
> requested before the khtread daemon is running. The system
> crashes at an early boot stage, otherwise:

<SNIP>

> Add the IRQF_TIMER flag as recommended by Sebastian Siewior
> -> http://www.spinics.net/lists/linux-rt-users/msg13171.html

This is wrong. The interrupts in question are not timers in the sense
of system timers. They are related to the clock subsystem and have a
totally different purpose, i.e. they are just there to wake up waiters
which wait for the synchronization of a particular clock, pll ...

So the proper flag is IRQF_NO_THREAD. And that's not a RT problem,
that's a mainline problem as well, if 'threadirqs' is set on the
kernel command line.

Now even if you add IRQF_NO_THREAD then still the interrupt service
routine is not RT compatible:

static irqreturn_t clk_main_osc_irq_handler(int irq, void *dev_id)
{
	struct clk_main_osc *osc = dev_id;

	wake_up(&osc->wait);

	^^^ takes sleeping spinlocks

Thanks,

	tglx
