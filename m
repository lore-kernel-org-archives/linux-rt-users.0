From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: why does __setup_irq use a raw spinlock? (Was: Trouble booting
 PREEMPT_RT kernel on ARM platform, 2.6.33)
Date: Fri, 27 Aug 2010 11:01:20 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1008271047070.2768@localhost.localdomain>
References: <AANLkTin7egyGVK_bVM3XsBhJt=P8cKoALGxaQAemL9sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jeremy Brown <jhbrown@repinvariant.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:53410 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab0H0JBZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Aug 2010 05:01:25 -0400
In-Reply-To: <AANLkTin7egyGVK_bVM3XsBhJt=P8cKoALGxaQAemL9sA@mail.gmail.com>
Content-ID: <alpine.LFD.2.00.1008271048041.2768@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 20 Aug 2010, Jeremy Brown wrote:

> We're using kernel 2.6.33.5 with corresponding 2.6.33.5-rt25 patches.
> __setup_irq in request_kernel/irq/manage.c contains a block guarded by
> a raw spinlock, with a preceding comment noting "The following block
> of code has to be executed atomically".   Why is this so?

Because this lock protects against an incoming interrupt.
 
> I ask because during RTC setup, this atomic region is causing calls to
> twl4030_sih_* functions to fail on my BeagleBoard platform (see stack
> trace below from a previous thread.).  As Gowrishankar noted in the
> previous thread, those routines use (non-raw) spinlocking.  As Thomas
> noted, they also call queue_work,  which in turn relies on non-raw
> spinlocking, so just patching up the twl4030_sih_* functions to use
> raw calls doesn't solve the problem.  I'm presently experimenting
> with:
> 
> a) pulling the calls to__irq_set_trigger and desc->chip->startup to a
> spot after the call to raw_spin_unlock_irqrestore, or
>
> b) making the atomic region use non-raw locking.
 
Neither of those approaches will work.

> However, I'm not really sure what the consequences of other approach
> are likely to be.  I'd be grateful for any thoughts and/or guidance
> that will keep me from wasting time and/or breaking things in subtle
> and confusing ways.

The right thing to do is to convert the driver to the chip_bus_lock()
functionality. 

See drivers/mfd/88pm860x-core.c
    drivers/mfd/ab8500-core.c
    drivers/mfd/max8925-core.c
    drivers/mfd/stmpe.c
    drivers/mfd/wm831x-irq.c
    drivers/mfd/wm8350-irq.c
    drivers/mfd/wm8994-irq.c

for examples. That'd be a nice cleanup for that driver anyway.  See
also commit 70aedd24d20e75198f5a0b11750faabbb56924e for documentation
about the core infrastructure.

Thanks,

	tglx
