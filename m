From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: sc16is7xx: a lot of time is spend in sc16is7xx_port_irq
Date: Fri, 26 Feb 2016 12:43:40 +0100
Message-ID: <20160226114340.GC8318@linutronix.de>
References: <56CDCCE6.5020801@prevas.dk>
 <56CDEAE2.9050102@prevas.dk>
 <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Jakub Kicinski <kubakici@wp.pl>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59202 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcBZLnp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 06:43:45 -0500
Content-Disposition: inline
In-Reply-To: <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Josh Cartwright | 2016-02-24 16:35:47 [-0600]:

>On Wed, Feb 24, 2016 at 06:39:46PM +0100, Sean Nyekj?r wrote:
>> CC'ing RT
>
>I'm assuming this is with the other patch killing off IRQF_ONESHOT?
>
>> On 2016-02-24 16:31, Sean Nyekj=C3=A6r wrote:
>> >Hi
>> >
>> >I'm using the sc16is750 on an imx6d platform with RT patches applie=
d.
>> >
>> >I have observed that sometimes the driver locks the whole system as=
 is
>> >loops inside the sc16is7xx_port_irq.
>> >I have applied some debug and seen we are looping upto 130000 times=
 in the
>> >while(1) loop.
>> >The SC16IS7XX_IIR_REG does signal the SC16IS7XX_IIR_XOFFI_SRC but t=
he
>> >SC16IS7XX_IER_XOFFI_BIT is not set.
>
>Ouch.
>
>I don't quite understand how the interrupt handling in this driver is
>supposed to work.  sc16is7xx_irq() is invoked to handle the interrupt,
>but it does absolutely nothing to squelch it...  how does this not cau=
se
>an interrupt storm?  The irq core is free to unmask the interrupt when
>the handler return IRQ_HANDLED, and if you're dealing with
>level-sensitive interrupts...

The irqcore does not shut down the driver because it always returns
IRQ_HANDLED. The reason why don't end up in a storm is the IRQF_ONESHOT
part. However it should use proper irq threads and not this homegrow
stuff. I could be a bug in general and not related to -RT.

>  Josh

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
