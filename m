From: Jeremy Brown <jhbrown@repinvariant.com>
Subject: Re: why does __setup_irq use a raw spinlock? (Was: Trouble booting
 PREEMPT_RT kernel on ARM platform, 2.6.33)
Date: Fri, 27 Aug 2010 16:38:06 -0700
Message-ID: <AANLkTimvxKBcbu6eEWKOZRHZPbHYJZ9Sqj97G+i_8Xp_@mail.gmail.com>
References: <AANLkTin7egyGVK_bVM3XsBhJt=P8cKoALGxaQAemL9sA@mail.gmail.com>
	<alpine.LFD.2.00.1008271047070.2768@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58925 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab0H0XiI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Aug 2010 19:38:08 -0400
Received: by wwb28 with SMTP id 28so4093175wwb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2010 16:38:06 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1008271047070.2768@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Aug 27, 2010 at 2:01 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Fri, 20 Aug 2010, Jeremy Brown wrote:
>
>> We're using kernel 2.6.33.5 with corresponding 2.6.33.5-rt25 patches=
=2E
>> __setup_irq in request_kernel/irq/manage.c contains a block guarded =
by
>> a raw spinlock, with a preceding comment noting "The following block
>> of code has to be executed atomically". =A0 Why is this so?
>
> Because this lock protects against an incoming interrupt.
>
>> I ask because during RTC setup, this atomic region is causing calls =
to
>> twl4030_sih_* functions to fail on my BeagleBoard platform (see stac=
k
>> trace below from a previous thread.). =A0As Gowrishankar noted in th=
e
>> previous thread, those routines use (non-raw) spinlocking. =A0As Tho=
mas
>> noted, they also call queue_work, =A0which in turn relies on non-raw
>> spinlocking, so just patching up the twl4030_sih_* functions to use
>> raw calls doesn't solve the problem. =A0I'm presently experimenting
>> with:
>>
>> a) pulling the calls to__irq_set_trigger and desc->chip->startup to =
a
>> spot after the call to raw_spin_unlock_irqrestore, or
>>
>> b) making the atomic region use non-raw locking.
>
> Neither of those approaches will work.
>
>> However, I'm not really sure what the consequences of other approach
>> are likely to be. =A0I'd be grateful for any thoughts and/or guidanc=
e
>> that will keep me from wasting time and/or breaking things in subtle
>> and confusing ways.
>
> The right thing to do is to convert the driver to the chip_bus_lock()
> functionality.

Thanks for this, and for the driver references below.   I recently
stumbled chip_bus_lock, but hadn't yet tried using it.  For the short
term, we've abandoned the RTC entirely, but if we return to it, I'll
take a stab at a chip_bus_lock conversion.

Thanks again,

Jeremy


> See drivers/mfd/88pm860x-core.c
> =A0 =A0drivers/mfd/ab8500-core.c
> =A0 =A0drivers/mfd/max8925-core.c
> =A0 =A0drivers/mfd/stmpe.c
> =A0 =A0drivers/mfd/wm831x-irq.c
> =A0 =A0drivers/mfd/wm8350-irq.c
> =A0 =A0drivers/mfd/wm8994-irq.c
>
> for examples. That'd be a nice cleanup for that driver anyway. =A0See
> also commit 70aedd24d20e75198f5a0b11750faabbb56924e for documentation
> about the core infrastructure.
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
