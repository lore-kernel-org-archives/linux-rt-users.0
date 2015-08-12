From: Felipe Balbi <balbi@ti.com>
Subject: Re: Common clock framework API vs RT patchset
Date: Wed, 12 Aug 2015 14:08:22 -0500
Message-ID: <20150812190822.GA20390@saruman.tx.rr.com>
References: <alpine.DEB.2.11.1508041405290.3983@nanos>
 <55C0D8F3.3030105@ti.com>
 <20150804153641.GR7557@n2100.arm.linux.org.uk>
 <55CA4BC2.4020505@ti.com>
 <20150811192514.GB7557@n2100.arm.linux.org.uk>
 <20150811220609.31346.15943@quantum>
 <55CB1A86.2050802@ti.com>
 <20150812101151.GK7557@n2100.arm.linux.org.uk>
 <20150812150253.GE13884@saruman.tx.rr.com>
 <20150812164649.31346.9236@quantum>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Cc: <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
	<linux-clk@vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40750 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbbHLTIn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2015 15:08:43 -0400
Content-Disposition: inline
In-Reply-To: <20150812164649.31346.9236@quantum>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 09:46:49AM -0700, Michael Turquette wrote:
> Quoting Felipe Balbi (2015-08-12 08:02:53)
> > On Wed, Aug 12, 2015 at 11:11:51AM +0100, Russell King - ARM Linux wrot=
e:
> > > On Wed, Aug 12, 2015 at 01:05:58PM +0300, Grygorii Strashko wrote:
> > > > On 08/12/2015 01:06 AM, Michael Turquette wrote:
> > > > > Quoting Russell King - ARM Linux (2015-08-11 12:25:15)
> > > > >>
> > > > >> clk_enable/clk_disable _should_ be usable from atomic contexts.
> > > >=20
> > > > Thanks Russell - above is not true on -RT.
> > >=20
> > > What I'm saying is that it _should_ be true.  You _should_ be able to
> > > call clk_enable()/clk_disable() from atomic contexts.  It's been
> > > documented since forever:
> > >=20
> > > /**
> > >  * clk_enable - inform the system when the clock source should be run=
ning.
> > >  * @clk: clock source
> > >  *
> > >  * If the clock can not be enabled/disabled, this should return succe=
ss.
> > >  *
> > >  * May be called from atomic contexts.
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >=20
> > > /**
> > >  * clk_disable - inform the system when the clock source is no longer=
 required.
> > >  * @clk: clock source
> > >  *
> > >  * Inform the system that a clock source is no longer required by
> > >  * a driver and may be shut down.
> > >  *
> > >  * May be called from atomic contexts.
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >=20
> > > If that's not true with CCF, that's a CCF bug, not a usage bug.
> >=20
> > in that case, CCF's clock need to be converted to raw_spin_locks, that's
> > the only way to prevent its locks from being reimplemented as rt
> > mutexes.
>=20
> I do not keep up much with rt stuff, so I am going to ask a naive
> question: is it common to simply do s/spin_lock/raw_spin_lock/g for
> driver subsystems when using rt? Sounds like that is all that is
> required...

depends, if you want to guarantee your code isn't preemptable, then
yeah.

--=20
balbi

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy5mmAAoJEIaOsuA1yqREbSoP/ior+tlhdy6Ka69mFX9EBR3t
ar780saqq5sFwKHDRhQlmd6piSgArulDUllRrLeGcVS2gAPERxpEwXWw5NHkZTum
aOdlp4pxFLP6kMe7o5r1L2jVWvKneu4PIHV2aQAWdsf6XNpCStYbBjm4AhyeJimG
bs861zT04MpvhVW6RfbIDX1BiTqEqPAkHpVatmOa97JWsqSsfD+T+VPSSdUOhCWZ
2+gZbhCiyN+BlqGYVgEUxjRKLBRqO3o50PNTp/mDzWNcpwAt+dFp9KDyreKRMkGY
wMzz4O5/VO+qnu99r6b88hvWoGZlHNyBRN4gH9k0d+qPoGu869Cz8iV4V4e3qAVE
MRIgAkUQvoNBCBBq0q1uIvKodMEYgIq1cjc6ES6KBpvxqGWdFvd/Ss13dg51WWJE
yP0w4BaokzYv0VlcLahA2j5Mnv8tIjPInm72HFgEHwpYPJc/wbg8IKTAR2/67tw5
7qeOVOqXHs9hPV1xwLkfagyXoTWPy+X5tJa1dobR8w1nrYWYKu7mNYj2RCkt8IFD
DYf7gfKDeMopUXtPHVxiWxfcWUokCFkzDm8j69gHZG6dEgaQYMyHAvwsNg3tmU9J
MzOODMPnBou4C3ycXnp+B5koE4ZZvG/2nf9OQ5FAflv5rttzjDxdA4TIZ2PGXJ1a
PVSXtkP/Z43CR71HRjNR
=yejM
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
