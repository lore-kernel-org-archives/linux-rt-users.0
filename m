From: Jeremy Brown <jhbrown@repinvariant.com>
Subject: why does __setup_irq use a raw spinlock? (Was: Trouble booting
 PREEMPT_RT kernel on ARM platform, 2.6.33)
Date: Fri, 20 Aug 2010 17:14:38 -0700
Message-ID: <AANLkTin7egyGVK_bVM3XsBhJt=P8cKoALGxaQAemL9sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44023 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0HUAOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Aug 2010 20:14:40 -0400
Received: by wwi17 with SMTP id 17so4795854wwi.1
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Aug 2010 17:14:38 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We're using kernel 2.6.33.5 with corresponding 2.6.33.5-rt25 patches.
__setup_irq in request_kernel/irq/manage.c contains a block guarded by
a raw spinlock, with a preceding comment noting "The following block
of code has to be executed atomically".   Why is this so?

I ask because during RTC setup, this atomic region is causing calls to
twl4030_sih_* functions to fail on my BeagleBoard platform (see stack
trace below from a previous thread.).  As Gowrishankar noted in the
previous thread, those routines use (non-raw) spinlocking.  As Thomas
noted, they also call queue_work,  which in turn relies on non-raw
spinlocking, so just patching up the twl4030_sih_* functions to use
raw calls doesn't solve the problem.  I'm presently experimenting
with:

a) pulling the calls to__irq_set_trigger and desc->chip->startup to a
spot after the call to raw_spin_unlock_irqrestore, or

b) making the atomic region use non-raw locking.

However, I'm not really sure what the consequences of either approach
are likely to be.  I'd be grateful for any thoughts and/or guidance
that will keep me from wasting time and/or breaking things in subtle
and confusing ways.

Thanks in advance,

Jeremy


On Tue, Jul 20, 2010 at 3:26 PM, Jeremy Brown <jhbrown@repinvariant.com=
> wrote:
> We're trying to get a PREEMPT_RT kernel running on a BeagleBoard C4
> (OMAP3 Arm architecture). =A0We're using kernel version 2.6.33, with
> patches from
> patch-2.6.33.6-rt26.gz
>
> On boot, we start seeing messages of this form:
>
> ----
> [ 4528.227294] BUG: sleeping function called from invalid context at
> kernel/rtmutex.c:684
> [ 4528.227294] pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 128, pid:
> 223, name: modprobe
> [ 4528.227355] [<c0044490>] (unwind_backtrace+0x0/0xe8) from
> [<c04cb4e4>] (rt_spin_lock+0x30/0x5c)
> [ 4528.227386] [<c04cb4e4>] (rt_spin_lock+0x30/0x5c) from [<c032e3b0>=
]
> (twl4030_sih_set_type+0x3c/0xac)
> [ 4528.227416] [<c032e3b0>] (twl4030_sih_set_type+0x3c/0xac) from
> [<c00aa944>] (__irq_set_trigger+0x34/0x88)
> [ 4528.227447] [<c00aa944>] (__irq_set_trigger+0x34/0x88) from
> [<c00ab2ec>] (__setup_irq+0x34c/0x3c0)
> [ 4528.227478] [<c00ab2ec>] (__setup_irq+0x34c/0x3c0) from
> [<c00ab430>] (request_threaded_irq+0xd0/0x148)
> [ 4528.227508] [<c00ab430>] (request_threaded_irq+0xd0/0x148) from
> [<bf021770>] (twl_rtc_probe+0x104/0x1fc [rtc_twl])
> [ 4528.227539] [<bf021770>] (twl_rtc_probe+0x104/0x1fc [rtc_twl]) fro=
m
> [<c0324e2c>] (platform_drv_probe+0x18/0x1c)
> [ 4528.227569] [<c0324e2c>] (platform_drv_probe+0x18/0x1c) from
> [<c0323eec>] (driver_probe_device+0x98/0x194)
> [ 4528.227600] [<c0323eec>] (driver_probe_device+0x98/0x194) from
> [<c0324074>] (__driver_attach+0x8c/0x90)
> [ 4528.227600] [<c0324074>] (__driver_attach+0x8c/0x90) from
> [<c0323744>] (bus_for_each_dev+0x60/0x8c)
> [ 4528.227630] [<c0323744>] (bus_for_each_dev+0x60/0x8c) from
> [<c0323014>] (bus_add_driver+0xa0/0x240)
> [ 4528.227661] [<c0323014>] (bus_add_driver+0xa0/0x240) from
> [<c0324324>] (driver_register+0x78/0x13c)
> [ 4528.227661] [<c0324324>] (driver_register+0x78/0x13c) from
> [<c003e3c0>] (do_one_initcall+0x30/0x1c0)
> [ 4528.227691] [<c003e3c0>] (do_one_initcall+0x30/0x1c0) from
> [<c0097e40>] (sys_init_module+0xc4/0x1f8)
> [ 4528.227722] [<c0097e40>] (sys_init_module+0xc4/0x1f8) from
> [<c003ea60>] (ret_fast_syscall+0x0/0x2c)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
