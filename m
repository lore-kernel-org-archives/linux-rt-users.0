From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Wed, 9 Mar 2016 11:13:53 +0000
Message-ID: <20160309111353.3530f35b@laptop>
References: <56CDCCE6.5020801@prevas.dk>
	<56CDEAE2.9050102@prevas.dk>
	<20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
	<20160226114340.GC8318@linutronix.de>
	<20160226114809.GD8318@linutronix.de>
	<C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
	<20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
	<835668C1-5DDB-4495-AD00-4EE8DDD0D146@wp.pl>
	<20160226190048.GC12917@jcartwri.amer.corp.natinst.com>
	<56DDAF2A.2000009@linutronix.de>
	<20160307165809.GC28102@jcartwri.amer.corp.natinst.com>
	<20160308211845.57e9796a@laptop>
	<56DFCAAA.3090807@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Josh Cartwright <joshc@ni.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.10]:42942 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbcCILOG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2016 06:14:06 -0500
In-Reply-To: <56DFCAAA.3090807@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 9 Mar 2016 08:03:06 +0100, Sean Nyekj=C3=A6r wrote:
> On 2016-03-08 22:18, Jakub Kicinski wrote:
> > On Mon, 7 Mar 2016 10:58:09 -0600, Josh Cartwright wrote:
> >>> I got lost here. Where do we stand here now?
> >> I understood the comment from Kuba to mean that he would be implem=
enting
> >> the disable_irq()/enable_irq() idea above to fix all the problems =
with
> >> this driver.
> >>
> >> Kuba- did I read that right?
> > I was hoping Sean or someone else would take up this task ;)
> Yes i could try :-) At least i have a working setup with the hardware=
=2E
> >
> > It should be a pretty simple patch.
> >
> > Kuba
> I not entirely sure what i have to do...
> - Reenable the ONE_SHOT
> - Disable irq when running in the loop, and enable when returning?
> - Implement threaded irq?
>=20
> /Sean

Do not reenable ONE_SHOT.  Disable interrupt (disable_irq_nosync())
in sc16is7xx_irq() and reenable at the end of sc16is7xx_ist().
I think reenabling at the end of sc16is7xx_ist() is fine since it's a
level triggered IRQ.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
