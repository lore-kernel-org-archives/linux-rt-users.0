From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Mon, 7 Mar 2016 10:58:09 -0600
Message-ID: <20160307165809.GC28102@jcartwri.amer.corp.natinst.com>
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
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuba Kicinski <kubakici@wp.pl>,
	Sean Nyekj?r <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:57063 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752698AbcCGQ6X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 11:58:23 -0500
In-Reply-To: <56DDAF2A.2000009@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 05:41:14PM +0100, Sebastian Andrzej Siewior wrote:
> On 02/26/2016 08:00 PM, Josh Cartwright wrote:
> > On Fri, Feb 26, 2016 at 01:26:27PM -0500, Kuba Kicinski wrote:
> >> On 26 February 2016 11:52:28 GMT-05:00, Josh Cartwright <joshc@ni.com>=
 wrote:
> > [..]
> >>> Instead, the driver needs to implement it's own oneshot-like
> >>> handling at the device-level: in the registered irq handler, capture
> >>> triggered interrupt state, squelch/mask, and enqueue the
> >>> kthread_work.  In the tail-end of the kthread_work, re-enable
> >>> interrupts at the device level.
> >>
> >> The problem there being IIRC that i2c doesn't provide async writes so
> >> we can't mask from irq callback. The only option would be
> >> disable_irq/enable_irq, right?
> >=20
> > Ah, yes, that is a problem.  If by disable_irq(), you mean
> > disable_irq_nosync(), then yes, I think that'd work.
>=20
> I got lost here. Where do we stand here now?

I understood the comment from Kuba to mean that he would be implementing
the disable_irq()/enable_irq() idea above to fix all the problems with
this driver.

Kuba- did I read that right?

Sean- are you still stuck without this?

Thanks for the ping,
  Josh

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW3bMeAAoJEKp7ZBKwQFArWGoH/1pxiLJxD+VbTTPeyVHrbarS
jyO04N4Umw465tifuzyQ+SHt+eHLoCW3t7RozMrbCA4a7EoVQf9xGQnWgcEKN8Ev
6Ztt9QvxXIGFUZO/G0gZLOUim6EHyCP5zDKalh7HcwBG7D/4tw7HvJNFU7In0r3w
H1JfqENyzSiMKJdV/3WgEfhDziy36bB++XXzqit9J9YovBzPeIc4dd5IBxTndRyP
k+O8GW1PBIdwtBz9qEKL4dtORe0BZPkmhOrbLqlsuyMb1lKkUoTN5C4rElniGDab
i/Y1l+kTnN0fy3UFHb9mNB4JVBu90oYkJ4VRZ2LC1ekvhWLYTiilNIw81VcqyTE=
=CQO8
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
