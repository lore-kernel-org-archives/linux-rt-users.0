From: "Maarten Brock" <m.brock@vanmierlo.com>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Wed, 09 Mar 2016 15:06:44 +0100
Message-ID: <20160309150644.bd910362@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Josh Cartwright" <joshc@ni.com>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	"Jon Ringle" <jringle@gridpoint.com>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Jakub Kicinski" <kubakici@wp.pl>,
	=?iso-8859-1?Q?Sean_Nyekj=E6r?= <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web1.dommelhosting.nl ([88.159.17.71]:50825 "EHLO
	web1.dommelhosting.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401AbcCIO3E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2016 09:29:04 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> On Wed, 9 Mar 2016 08:03:06 +0100, Sean Nyekj=C3=A6r wrote:
> > On 2016-03-08 22:18, Jakub Kicinski wrote:
> > > On Mon, 7 Mar 2016 10:58:09 -0600, Josh Cartwright wrote:
> > >>> I got lost here. Where do we stand here now?
> > >> I understood the comment from Kuba to mean that he would be
> > >> implementing the disable_irq()/enable_irq() idea above to
> > >> fix all the problems with this driver.
> > >>
> > >> Kuba- did I read that right?
> > > I was hoping Sean or someone else would take up this task ;)
> > Yes i could try :-) At least i have a working setup with the hardwa=
re.
> > >
> > > It should be a pretty simple patch.
> > >
> > > Kuba
> > I not entirely sure what i have to do...
> > - Reenable the ONE_SHOT
> > - Disable irq when running in the loop, and enable when returning?
> > - Implement threaded irq?
> >=20
> > /Sean
>=20
> Do not reenable ONE_SHOT.  Disable interrupt (disable_irq_nosync())
> in sc16is7xx_irq() and reenable at the end of sc16is7xx_ist().
> I think reenabling at the end of sc16is7xx_ist() is fine since it's a
> level triggered IRQ.

What do you mean, it's level triggered? How do you know? The irq is
requested with either 0 or IRQF_TRIGGER_FALLING for irqflags. I don't
see anywhere where it would be configured IRQF_TRIGGER_LOW.

Maarten
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
