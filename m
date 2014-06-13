From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: 3.14.3-rt5: at91: Crash early at boot
Date: Fri, 13 Jun 2014 17:28:01 +0200
Message-ID: <20140613152801.GM3448@lukather>
References: <20140613142506.GL3448@lukather>
 <CAOcfFMw9e3_=Yz0jyU7HdYx4Kod=9-X5T9JPNcUjoVC4jBtS9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zROEGoKAXsG5UqGB"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas@free-electrons.com>
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46565 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752562AbaFMPaE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jun 2014 11:30:04 -0400
Content-Disposition: inline
In-Reply-To: <CAOcfFMw9e3_=Yz0jyU7HdYx4Kod=9-X5T9JPNcUjoVC4jBtS9Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--zROEGoKAXsG5UqGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jordan,

On Fri, Jun 13, 2014 at 10:48:05AM -0400, jordan wrote:
> Maxim,
>=20
> You may be one of the people affected by some upstream RT changes
> [dating back to 3.12-rt] that causes linux-rt to fail to boot on some
> H/W.
>=20
> I myself, am affected, i know of lots of AMD users and the some ARM
> h/w that doesn't boot, without reverting a couple of these changes.
> [as noted here;
> http://www.spinics.net/lists/linux-rt-users/msg11655.html]... You
> could try this patch; http://pastebin.com/jb4tuNna - which is applied
> after the rt patchset ... This is how i have been able to use RT on my
> machines for many RT releases now.
>=20
> your problem may or may not be the same. but it's probably worth a try.

I just gave your patch a try, and unfortunately, it doesn't change
anything, I still get the same panic at the same moment.

Thanks!
Maxime
--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--zROEGoKAXsG5UqGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTmxiBAAoJEBx+YmzsjxAgYfgP/0vQDtCK3pRRn3c56B5qibh+
nlb5c9fAyt/hioKvECxiwxGVVgj/41wzDbtXBaDycyMqx32cCXwZQw+5mlcoLJvU
T0+dVxwqU+RVi4s12nNJL+oQJTY1XAYzyxIj9obHwg6NmzhrP1ywWgQK88VpVmtT
ZO9Wr+ysQgE1KEmNSygkRoBhdEX0TrJoDS8aSl2RgYaJKvUKxtbNs7vxVVCz+/Sn
obwHQPXxeU2u2cgARCucXQguwJC1/AnJEorwkJLDrCs9XZ9K+OdVTYpIQG5r4/nj
ZhCHlAvmTTqEFGL1M28z1nPHVDFg6djyzU5FC4JUDAdQZJNpD1cuDJiyeELt/IMd
BahsR78NrYnvMuhI2a+XfP0j1kMgIh209MzDS/5HO88rLoo4Xv3ArCaRenmfiizs
I0O4CWbhniIzvf8hukgDrLwbSK26jxQWEqtt3pECXX/cPv+PypTZ41LD+K+tEioP
62wujoo6izattkUK39S4DDvSas0mx1g5I1Qs/trDZ6awZFn+to4wtylsozmTjbjl
jSTBsZ5fnlE3M2+8utxKE0MJho5ddUcp+t1JxbdRL1ZF3D65p+dYWVb+WLocOf8/
1S2tYgHNOfd8WVmWZ7NyTApxrEH8El5SdfaWzGYUXjwNuoSW3kxhX5Va93QYCdqL
11QWdenOGXBJe1RJpEYY
=HtJB
-----END PGP SIGNATURE-----

--zROEGoKAXsG5UqGB--
