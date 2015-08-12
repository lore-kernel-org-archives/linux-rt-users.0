From: Felipe Balbi <balbi@ti.com>
Subject: Re: Common clock framework API vs RT patchset
Date: Wed, 12 Aug 2015 10:02:53 -0500
Message-ID: <20150812150253.GE13884@saruman.tx.rr.com>
References: <55C0A96F.80307@ti.com>
 <alpine.DEB.2.11.1508041405290.3983@nanos>
 <55C0D8F3.3030105@ti.com>
 <20150804153641.GR7557@n2100.arm.linux.org.uk>
 <55CA4BC2.4020505@ti.com>
 <20150811192514.GB7557@n2100.arm.linux.org.uk>
 <20150811220609.31346.15943@quantum>
 <55CB1A86.2050802@ti.com>
 <20150812101151.GK7557@n2100.arm.linux.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>, <linux-clk@vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57233 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbbHLPDU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2015 11:03:20 -0400
Content-Disposition: inline
In-Reply-To: <20150812101151.GK7557@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 11:11:51AM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 12, 2015 at 01:05:58PM +0300, Grygorii Strashko wrote:
> > On 08/12/2015 01:06 AM, Michael Turquette wrote:
> > > Quoting Russell King - ARM Linux (2015-08-11 12:25:15)
> > >>
> > >> clk_enable/clk_disable _should_ be usable from atomic contexts.
> >=20
> > Thanks Russell - above is not true on -RT.
>=20
> What I'm saying is that it _should_ be true.  You _should_ be able to
> call clk_enable()/clk_disable() from atomic contexts.  It's been
> documented since forever:
>=20
> /**
>  * clk_enable - inform the system when the clock source should be running.
>  * @clk: clock source
>  *
>  * If the clock can not be enabled/disabled, this should return success.
>  *
>  * May be called from atomic contexts.
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> /**
>  * clk_disable - inform the system when the clock source is no longer req=
uired.
>  * @clk: clock source
>  *
>  * Inform the system that a clock source is no longer required by
>  * a driver and may be shut down.
>  *
>  * May be called from atomic contexts.
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> If that's not true with CCF, that's a CCF bug, not a usage bug.

in that case, CCF's clock need to be converted to raw_spin_locks, that's
the only way to prevent its locks from being reimplemented as rt
mutexes.

--=20
balbi

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy2AdAAoJEIaOsuA1yqREBVUP+wbNa5pHqZOlUmSHpp7l2MHW
DrQvlU3TnTq8Et4yjnscMT3DLIAH1Doo0QyQE94PQXj2flDyJ6w/3fGfLvylJre4
nJ2a7ifLCPcQiQSHr7X1wype2JVPQE1E4L0cEnZhGEef9N0MUr0Cu+JJP2z13Ax4
DXqC9dqH/CYsRE3FR1A5aMd1JS5F10vaA7sL5u/ZYS+UJKTIsiMSTjL366iaKOgf
Aqk3iQZunS6HY/08bHLtUJMfz8LNN+5ME05iK9XS9C+JDFPVtkkIzNWfMHvo8Ox4
7OxEV3jecS2IETC3aitJ2IoLs7ITyYG6HILPomN847kg7voATmdrZb4zhFVCuprw
xSA2g41d3Z+PvUoT+zO6T2mL7io38VcnaSvTtAy51ybvGANx5vtLDOHJZ0eAHHbk
NpEA2SiKYGT+cPxwDKAKXFoVe8nni8KZTiqGkWIIMvxS5dlRQOa+mTKVBxEPmQvW
RreOK0ylTYohrHeFqTyNLHfIwRR37hkotHgE0XPZHxHSa+s9ORr+azgCizTTaqRR
1VMD3DgkNl9e/rUmBTXKebZXyR4yt2qCsW46P8A9Zn1dt15TlR6BBDo351LVePuI
KnJD/Trzyvj6SQJIoaH5ootawQxAeD5n2hcbWKaANJFYPjKhJk2OdNiW2YTqbDHt
QMZsBn+6uOkXXNcPUJ1N
=F/uV
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
