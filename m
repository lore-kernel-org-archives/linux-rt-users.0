From: Kuba Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead of homegrow
Date: Fri, 26 Feb 2016 13:26:27 -0500
Message-ID: <835668C1-5DDB-4495-AD00-4EE8DDD0D146@wp.pl>
References: <56CDCCE6.5020801@prevas.dk> <56CDEAE2.9050102@prevas.dk> <20160224223547.GF9598@jcartwri.amer.corp.natinst.com> <20160226114340.GC8318@linutronix.de> <20160226114809.GD8318@linutronix.de> <C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl> <20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.10]:54710 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbcBZS0j (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 13:26:39 -0500
In-Reply-To: <20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 26 February 2016 11:52:28 GMT-05:00, Josh Cartwright <joshc@ni.com> wrote:
>On Fri, Feb 26, 2016 at 09:34:57AM -0500, Kuba Kicinski wrote:
>> On 26 February 2016 06:48:09 GMT-05:00, Sebastian Andrzej Siewior
><bigeasy@linutronix.de> wrote:
>> >This ONESHOT + workqueue combo is something that is not required
>> >because
>> >we have infrastrucure for this kind of things: threaded interrupts.
>> >
>> >This is compile tested only due to -ENODEV.
>> >Now that we that sc16is7xx_irq() is an actual interrupt handler
>> >sc16is7xx_port_irq() could be improved so the former can return
>> >IRQ_NONE
>> >if nothing has been done.
>> >
>> >Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> The reason why this driver is not using threaded irqs is that it
>> already has a kthread to handle other things.
>
>The core problem here is still the use of IRQF_ONESHOT.  The semantics
>of IRQF_ONESHOT are only defined w.r.t. the irq core's threaded
>interrupt handling.
>
>If the driver isn't going to make use of the existing irqthread
>functionality, then it _also_ should not be making use of IRQF_ONESHOT.

Yes, I definitely dropped the ball there.

>Instead, the driver needs to implement it's own oneshot-like handling
>at
>the device-level: in the registered irq handler, capture triggered
>interrupt state, squelch/mask, and enqueue the kthread_work.  In the
>tail-end of the kthread_work, re-enable interrupts at the device level.

The problem there being IIRC that i2c doesn't provide async writes so we can't mask from irq callback. The only option would be disable_irq/enable_irq, right?

