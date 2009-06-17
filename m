From: Remy Bohmer <linux@bohmer.net>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 22:14:55 +0200
Message-ID: <3efb10970906171314s2b60a2eerc3cbad09a6f8e4a6@mail.gmail.com>
References: <loom.20090615T222836-377@post.gmane.org>
	 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>
	 <loom.20090616T074347-549@post.gmane.org>
	 <20090616182734.GD13048@pengutronix.de>
	 <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906171114560.2800@localhost.localdomain>
	 <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com>
	 <alpine.LFD.2.00.0906171716170.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Martin Shepherd <mcs@astro.caltech.edu>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f212.google.com ([209.85.220.212]:59403 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbZFQUOy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 16:14:54 -0400
Received: by fxm8 with SMTP id 8so605345fxm.37
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2009 13:14:55 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906171716170.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Thomas,

2009/6/17 Thomas Gleixner <tglx@linutronix.de>:
> On Wed, 17 Jun 2009, Remy Bohmer wrote:
>> I do not agree that it is a userspace issue, the rationale behind this
>> is that users care about functionality, not specific interrupt thread
>> ids.
> It _is_ solely a user space issue. The kernel has absolutely no idea
> what a system is used for and what the system designer decides is the
> best priority balance. The kernel provides a default value which just
> works for bootup.

No, it is a system designer issue. The type of users of the kernel is
much wider than only the person who is sitting between the keyboard
and chair. The RT-kernel is also used in embedded devices which are
only configured for 1 single purpose, without a 'user' that knows how
to configure the system, or even cares/knows that there is linux
running behind the surface. That same person might not even have a
login shell to be able to configure anything.

In these cases the system designer wants to be able to configure those
priorities at build time, just like he is used to configure
high-resolution-timers, tickless kernel, board support options, or
whatever dedicated kernel config option.
This type of user do not want to configure it 'runtime' over and over
on every boot. (for example, to reduce boot times as well)
Configuring the kernel IRQ-thread priorities falls in the same
category as the other kernel config options, or kernel commandline
options (why does the average user care to select a certain
clocksource from the kernel commandline? It can be done after boot as
well...)

> The kernel has absolutely no idea what a system is used for

This sounds very weird, the kconfig options determine what the kernel
is used for. It decides if it is full featured, or tiny. What
architecture it runs on, and even if it is purposed for a realtime or
regular application.

So, we agree that determining the kernel IRQ-prios by the _user_, but
the definition of the user is much wider than only the person behind
keyboard and chair at a login shell, and the RT-kernel is used in many
different areas than X86 desktop only. So, even it is a _user_ issue,
it is wrong to conclude that is therefor also a _userspace_ issue.

> We want drivers and the kernel to be as generic as possible to avoid
> tons of extra special cases in the code which are no benefit at all.

I completely agree on that, but there is nothing wrong by integrating
a _generic_ mechanism to allow the user to customise their kernel for
their needs. (To be clear: I am _only_ talking about the patch series
to configure kernel threads from Kconfig of kernel cmd-line, not about
fixed relations between workqueues, softirqs and irq-threads, that is
up to the system designer to work out while tweaking the kernel)
It is as wrong to select a default of 50 instead of 30,40,whatever
(hypothetical) as to integrate a generic mechanism to choose the
default at compile time.

>> Thread-ids can/will vary, and a lot of scripting is needed to map the
>> proper interrupt handler of the right device driver to the proper
>> kernel thread, and to set the priorities accordingly.
>> And what if there is not a userland at all? and init is the only
>> process in the system, or there is no shell installed?
>
> Can we talk about real world issues please ?

Who said it was not a real world example? I have seen systems that do
just that. Just to squeeze out the last tiny bytes of flash space, to
be able to choose a 2 cent cheaper flash, and to minimize the memory
footprint. I talk about dedicated embedded devices here, not multi
gigabytes X86 systems. You might believe it is crazy to do this, but
it is real life...
One example is where the complete realtime application was implemented
inside the kernel as well, as a kernel driver. (This is extremely good
for RT-behaviour -> less/no cache flushes due to process context
switches).
While it is using kernel threads as well and the driver chooses to use
certain kernel thread priorities, the default of 50 could even result
in an unbootable system. In that case the user that defines the
kernel-configuration and selects the driver in Kconfig also needs to
configure the IRQ/SIRQ thread prios.

>> Or some kernel developer change the name of the interrupt handler? All
>> different implementations in userspace has to follow as well... And
>
> As I said already, we need to expose the tid of the irq thread to
> sysfs as we do with the irq number right now.

But the irq-thread-id and irq-number are _not_ relevant _at all_, it
is about device drivers and their interrupt handlers.
If I want to, for example, boost the interrupt handler
'uhci_hcd:usb6', because I have RT requirements to the device
connected to this USB-port, I want the irq-thread boosted that handles
this particular interrupt handler. The irq-thread that belongs to this
driver is hardware deployment specific and can differ on different
revisions of hardware as well. By making the tid public in sysfs,
there still has to be made a mapping between /proc/interrupts and the
sysfs entries.
The same is valid for soft-irqs, I might want to boost 'sirq-net', or
'sirq-timer', regardless what tid it might have.

By adding the tid to sysfs only, it still requires tools like a shell,
cat, grep, cut, ps, and chrt in the filesystem as well, but this cost
memory footprint, and that can make the difference in flash type to
choose in an embedded device, where every penny counts up.
Following your opinion here: you can skip the tid in sysfs as well,
because it can be looked up with 'ps' also...

The kernel can no longer keep its own pants up for stuff that is
implemented inside the kernel for the kernel its own needs. The
default options, only might give a bootable system, but no _realtime_
system. To get a _usable_ realtime kernel there should be no
dependencies to user space.
realtime systems always require lots of tweaking by system-designers
who configure the kernel to their application needs.

>> why is 50 the right default to use, and not 30 or 60?
>
> 50 is a default startup value and the driver does not know in which
> device it is built in. It does not care at all whether the device is a
> radio a screwdriver or a blinkenlight.

uuhh, but there is a selection option in kconfig and kernel cmd-line
for the tickless kernel and highres-timers as well, but why should it?
it does not need to know where it is built in, so it does not need to
be configurable...???
Or is there a different reason for making things configurable: that
the location where the kernel is built in _does_ make sense to make
something configurable?

> The kernel treats by default all irq threads in the same way as it resembles the mainline behaviour closely.

Not completely true: On mainline interrupt handlers have prios in
hardware as well, based on the hardware layout and the behaviour of
the interrupt controller one interrupt can preempt another interrupt
if it has a higher priority. The RT-kernel default maps everything to
50 and handles them equally, ignoring the priority mechanism in
hardware.

>> For a realtime embedded device this could all be the case, and it is
>> not that strange.
>
> There is no such thing "realtime embedded device". There is a device

I said 'a' realtime embedded device, in the sense of 'an example'

> which requires a real time kernel. Again the kernel does not care
> about the overall system requirements. This can only be decided by the
> system designer and the system designer has to do the same work for
> the user space as well. It's all about policies and the kernel does
> not implement policies except some safety ones.
> The kernel provides selinux as well and the system designer/admin
> decides which policies to use.

You seem to talk about X86 only here, and seem to forget those tiny
little devices for which SE-Linux is completely overkill.

>> If there is interest I can rework this and make it mainline ready on
>> the short term for mainline 2.6.29-RT. (in that case comments are very
>> welcome on the 2.6.26 edition, see above)
>
> You can post it and I'm not going to take it for the above reasons.

Unfortunately you seem to be missing the point here.

I certainly not state that that patchset is mainline-ready as it is
now, although others were quite positive about it, as you can see in
the older threads. I would prefer to see useful remarks to be able to
create a patchset that is useful for everybody, honouring the generic
purpose of the kernel, and that helps users of non-X86 systems as
well.
I notice a need for it lately, so I am willing to invest some good
time in it, but I am not going to waste it...

Kind regards,

Remy
