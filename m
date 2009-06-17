From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 17:35:51 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906171716170.2800@localhost.localdomain>
References: <loom.20090615T222836-377@post.gmane.org>  <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>  <loom.20090616T074347-549@post.gmane.org>  <20090616182734.GD13048@pengutronix.de>  <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
 <alpine.LFD.2.00.0906171114560.2800@localhost.localdomain> <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Martin Shepherd <mcs@astro.caltech.edu>,
	linux-rt-users@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47667 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbZFQPgx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 11:36:53 -0400
In-Reply-To: <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 17 Jun 2009, Remy Bohmer wrote:
> I do not agree that it is a userspace issue, the rationale behind this
> is that users care about functionality, not specific interrupt thread
> ids.

It _is_ solely a user space issue. The kernel has absolutely no idea
what a system is used for and what the system designer decides is the
best priority balance. The kernel provides a default value which just
works for bootup.

We want drivers and the kernel to be as generic as possible to avoid
tons of extra special cases in the code which are no benefit at all.

> Thread-ids can/will vary, and a lot of scripting is needed to map the
> proper interrupt handler of the right device driver to the proper
> kernel thread, and to set the priorities accordingly.
> And what if there is not a userland at all? and init is the only
> process in the system, or there is no shell installed?

Can we talk about real world issues please ?

> Or some kernel developer change the name of the interrupt handler? All
> different implementations in userspace has to follow as well... And

As I said already, we need to expose the tid of the irq thread to
sysfs as we do with the irq number right now.

> why is 50 the right default to use, and not 30 or 60?

50 is a default startup value and the driver does not know in which
device it is built in. It does not care at all whether the device is a
radio a screwdriver or a blinkenlight.

> For a realtime embedded device this could all be the case, and it is
> not that strange.

There is no such thing "realtime embedded device". There is a device
which requires a real time kernel. Again the kernel does not care
about the overall system requirements. This can only be decided by the
system designer and the system designer has to do the same work for
the user space as well. It's all about policies and the kernel does
not implement policies except some safety ones.

The kernel provides selinux as well and the system designer/admin
decides which policies to use.

> If there is interest I can rework this and make it mainline ready on
> the short term for mainline 2.6.29-RT. (in that case comments are very
> welcome on the 2.6.26 edition, see above)

You can post it and I'm not going to take it for the above reasons.

Thanks,

	tglx
