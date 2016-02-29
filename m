From: Josh Cartwright <joshc@ni.com>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Mon, 29 Feb 2016 10:18:26 -0600
Message-ID: <20160229161826.GD12917@jcartwri.amer.corp.natinst.com>
References: <nat4ql$41m$1@ger.gmane.org>
 <20160229081039.GC2613@pengutronix.de>
 <nb1qeg$9mm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Cc: linux-rt-users@vger.kernel.org
To: Jean-Denis Girard <jd.girard@sysnux.pf>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:51016 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755840AbcB2QSi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 11:18:38 -0500
In-Reply-To: <nb1qeg$9mm$1@ger.gmane.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jean-Denis-

On Mon, Feb 29, 2016 at 06:08:47AM -1000, Jean-Denis Girard wrote:
> Le 28/02/2016 22:10, Uwe Kleine-K=F6nig a =E9crit :
> > Alexandre Belloni wrote something about rt and at91 that might be worth
> > to look into. I don't know how much of it is obsolete with 4.4.2-rt7,
> > though.
> >=20
> > http://article.gmane.org/gmane.linux.rt.user/14728
>=20
> I have read (and replied to) that article, and even tried to apply some
> of the patches mentioned, but could never get kernel to boot.
>=20
> As I said, I'm a newbie on Linux RT: is there anything I should check in
> my kernel config? I mean, are there any configuration parameters none to
> be a problem with PREEMPT_RT_FULL, but working fine with PREEMPT__LL?

I think your best bet will be to try to get early console output, with
the hope that you can get visibility into what is going wrong.  I'm sure
there are many tutorials out there on how to build a kernel with this
serial debugging information.  Do a search for DEBUG_LL, earlyprintk,
and perhaps earlycon; these are not -rt specific.

  Josh

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW1G9PAAoJEKp7ZBKwQFArayAIAKPrvU8qJbYZcDI3ySTFcqk2
GDP0uv7cDp2Ie0yS8Z8/GQX3gO45HtoC6fU1uQnnZrqefVaJspPreTjutPG7dYJU
dMgixiNGvaRhyTpuVPl/63KDm6l9E+5bHad1t4ZH27371SeUR789RxN1yarQClgN
FPTbG8aHl3E1ljWPK181OmPpUu2wTVaiVpEoKSqywvW4aF7eqFMznbt2hTiSqwg9
Y6200KIlXarebRBtIaSzU7R9ffJHttIkvQghHhT1rhKaRgTLGbvOgL39ed7H6xNc
RnJJaEBTIpM0fhIC+bisjIvwQ22IpNx2zm6Q8/c4tg4kvbOYEvwVeRKuFOEd/uo=
=GRPC
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
