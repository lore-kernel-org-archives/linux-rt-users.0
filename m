From: Josh Cartwright <joshc@ni.com>
Subject: Re: sc16is7xx: a lot of time is spend in sc16is7xx_port_irq
Date: Wed, 24 Feb 2016 16:35:47 -0600
Message-ID: <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
References: <56CDCCE6.5020801@prevas.dk>
 <56CDEAE2.9050102@prevas.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Cc: linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Sean Nyekj?r <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:38473 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752208AbcBXWfv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2016 17:35:51 -0500
In-Reply-To: <56CDEAE2.9050102@prevas.dk>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2016 at 06:39:46PM +0100, Sean Nyekj?r wrote:
> CC'ing RT

I'm assuming this is with the other patch killing off IRQF_ONESHOT?

> On 2016-02-24 16:31, Sean Nyekj=E6r wrote:
> >Hi
> >
> >I'm using the sc16is750 on an imx6d platform with RT patches applied.
> >
> >I have observed that sometimes the driver locks the whole system as is
> >loops inside the sc16is7xx_port_irq.
> >I have applied some debug and seen we are looping upto 130000 times in t=
he
> >while(1) loop.
> >The SC16IS7XX_IIR_REG does signal the SC16IS7XX_IIR_XOFFI_SRC but the
> >SC16IS7XX_IER_XOFFI_BIT is not set.

Ouch.

I don't quite understand how the interrupt handling in this driver is
supposed to work.  sc16is7xx_irq() is invoked to handle the interrupt,
but it does absolutely nothing to squelch it...  how does this not cause
an interrupt storm?  The irq core is free to unmask the interrupt when
the handler return IRQ_HANDLED, and if you're dealing with
level-sensitive interrupts...

  Josh

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWzjBAAAoJEKp7ZBKwQFArDB0H+wXHXML+sI1nnkkdT8060tQE
W6/ckJHge1rpNXkBmwPVc83ypzbg3uEcG4tEKl6NupWTssFrMC8z3ySOVeFen568
xXqHpiIzs4bjb0ZmB3Gvf/FRaYdzRRJICbBWzWH8TpwpWkVQkOpzS32PAUV2SLrp
EtadsWnLoWbBBat+AnXVkiRmenH0TJGdyBEd6616R2O9yIaza5+lr0iDt8CsvyGX
XzxQ+A4s4oKyxsnvKDmmysJ9p3tOhsJbM5jFMXVOnmnTOTyF44xXpdaP5u28xkvb
td64nBkNgTV6I7XIoBQixvi7YvmxQITO+nH/2j8aUY8rpA/i59umQQUP6ZilHp4=
=o+KE
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
