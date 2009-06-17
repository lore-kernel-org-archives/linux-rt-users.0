From: Remy Bohmer <linux@bohmer.net>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 13:21:41 +0200
Message-ID: <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com>
References: <loom.20090615T222836-377@post.gmane.org>
	 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>
	 <loom.20090616T074347-549@post.gmane.org>
	 <20090616182734.GD13048@pengutronix.de>
	 <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906171114560.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Martin Shepherd <mcs@astro.caltech.edu>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:65347 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbZFQLVm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 07:21:42 -0400
Received: by bwz9 with SMTP id 9so230076bwz.37
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2009 04:21:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906171114560.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Thomas,

>> > The right way is to do this change from userspace.
>> What a nonsense. Care to look at the code ?
>> The irq/softirq threads call sys_sched_setscheduler() already to
>> change their priorities.
> More awake, it should be changed for correctness sake. :)
>> The right way to do this is to have an interface
>> set_irq_thread_prio(irq, prio)
> This still stands, if we need a way to change the prio from the
> driver.
> But the more I think about it should be done from user space.

Some time ago we discussed on lkml this same subject.
I made several patches for it back then, but due to change of focus I
somewhat forgot these patches...
First post: http://www.nabble.com/-patch-0-3--add-kernel-cmdline-support-for-interrupt-thread-priorities-(repost:CC-to-LKML)-td14424269.html
I posted them recently again forward ported to 2.6.26:
http://www.spinics.net/lists/linux-rt-users/msg04237.html

I do not agree that it is a userspace issue, the rationale behind this
is that users care about functionality, not specific interrupt thread
ids.
Thread-ids can/will vary, and a lot of scripting is needed to map the
proper interrupt handler of the right device driver to the proper
kernel thread, and to set the priorities accordingly.
And what if there is not a userland at all? and init is the only
process in the system, or there is no shell installed?
Or some kernel developer change the name of the interrupt handler? All
different implementations in userspace has to follow as well... And
why is 50 the right default to use, and not 30 or 60?
For a realtime embedded device this could all be the case, and it is
not that strange.

This was for me the reasoning back then to provide patches that do it
from inside the kernel. The patches provide a means by configuring it
via the kernel commandline, or Kconfig.
The configuration is based on the name provided by the interrupt
handler name provided by request_irq(). If the irq-thread is created
it is looked up inside a map what the priority of the IRQ-thread needs
to be. The IRQ-thread is created with the required prio. It also
checks if the IRQ is shared, and it checks if there are conflicts as
well.

If there is interest I can rework this and make it mainline ready on
the short term for mainline 2.6.29-RT. (in that case comments are very
welcome on the 2.6.26 edition, see above)


Kind Regards,

Remy
