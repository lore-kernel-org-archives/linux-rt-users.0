From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 17:45:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906171736150.2800@localhost.localdomain>
References: <loom.20090615T222836-377@post.gmane.org>  <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>  <loom.20090616T074347-549@post.gmane.org>  <20090616182734.GD13048@pengutronix.de>  <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
 <alpine.LFD.2.00.0906171114560.2800@localhost.localdomain>  <3efb10970906170421r1f4b8556h26a3c08a3cb9ee5e@mail.gmail.com> <49b7c2350906170632t4ea086f3tb0269d5948885568@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Remy Bohmer <linux@bohmer.net>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Martin Shepherd <mcs@astro.caltech.edu>,
	linux-rt-users@vger.kernel.org
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:37149 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbZFQPpW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 11:45:22 -0400
In-Reply-To: <49b7c2350906170632t4ea086f3tb0269d5948885568@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 17 Jun 2009, GeunSik Lim wrote:
> On Wed, Jun 17, 2009 at 8:21 PM, Remy Bohmer<linux@bohmer.net> wrote:
> > Hello Thomas,
> > Or some kernel developer change the name of the interrupt handler? All
> > different implementations in userspace has to follow as well... And
> > why is 50 the right default to use, and not 30 or 60?
> > For a realtime embedded device this could all be the case, and it is
> > not that strange.

> Um..., I also don't know exact reason that seted irq priority with 50.
> I think that  the value is irq priotiry  is promise in Realtime system.

No, it depends on the system. If your super important device irq needs
to run above all others then you configure it, but it's not a kernel
problem. We have run unimportant irq threads on prio 1 to keep them
out of the way.

> In my case, When I have to change( or set) RT priority about RT
> Kernel thread or Userspace RT applications in a realtime embedded
> device, I change( or set ) priority of RT Process(or thread) after
> consider that irq priority is 50.
 
Again, 50 is a default value. There is no law which prohibits that the
irq priorities can be adjusted to the needs of the system.

The kernel treats by default all irq threads in the same way as it
resembles the mainline behaviour closely. But in contrary to the
mainline hardirq handlers you have now the possibility to change
that. If you are happy with the default then of course you can leave
it as is.

Also a vanilla non-rt kernel comes up with defaults and gives you
enough freedom to customize it to your needs. preempt-rt gives you
some more knobs to tweak and of course an easier way to shoot yourself
into the foot.

Thanks,

	tglx
