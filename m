From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: debian RT kernel
Date: Wed, 27 May 2015 00:11:42 +0100
Message-ID: <1432681902.6319.10.camel@decadent.org.uk>
References: <7f79-55642000-25-50abc380@46760505>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RCCYwAwNx98OxXLOv+y2"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?Q?Jarom=C3=ADr_Mike=C5=A1?= <mira.mikes@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Braud Caroline <Caroline.Braud@univ-lille1.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39920 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751314AbbEZXME (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 May 2015 19:12:04 -0400
In-Reply-To: <7f79-55642000-25-50abc380@46760505>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-RCCYwAwNx98OxXLOv+y2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-05-26 at 09:24 +0200, Braud Caroline wrote:
> Hello,
>=20
> So if I understand well, the installation of RT package in a brand new PC=
:
>=20
> - step 1: installation of a distribution (I have installed debian jessie)
> - step 2: to be able to have access of RT packages in development:
> follow the link you gave me (4.3 and 4.2 steps) by replacing "dist" by "s=
id"
> - step 3: install RT packages in development using apt-get install (heade=
rs and image RT) ??

You would use 'dpkg -i', rather than 'apt-get' to install a local file.

> Thanks a lot, and sorry for my level in linux kernel ... =20
> The RT kernel is very usefull for me and I find the RT-PREEMPT developmen=
t very interesting :)

I uploaded a new linux package (version 4.0.4-1) to unstable earlier
today with the PREEMPT_RT patchset included, so you could also just wait
a day for it to hit the mirrors.

Ben.

--=20
Ben Hutchings
Unix is many things to many people,
but it's never been everything to anybody.

--=-RCCYwAwNx98OxXLOv+y2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVWT9s+e/yOyVhhEJAQqNMw//bHt0/fLhIqcoD/yAi1GVFXDhNpGS4K+Y
QafXXaa6ISEeMngTtBYjyi8Erhi/LGLky/xHJsNQUixsSiaG2FLl53UoELwsq+ZF
Dt20eehbV4d2S2n46ZI56n0rcQFRvfSymTJeu3KZ9pfb/ZLdM8+SXt0yy1kwayLT
wVAuhRYUDQB9tUQY0Sr9jKiVkJCoM0QCidZ87wQ2DIBwiAK3DMtvSIZ1OpwpFkP9
KCpnn6Ynbmvn59nkCgrue/5ffnC3TRoJ1k9jvy3GtcMfc6ie7xJcFxFN1r2zHRtT
TIQOXDutZOA6QAheaOy9wRDTvh3FYSBqiHWHbZ/+SZ5XcL11jZphq0cuotcgqQ2k
+fSWv9nce0pHJa2fEz/yjU8gcF+EI2Z8AQx9SVPemQd2lCpf/4hgxxgLOcGf6dbZ
NeW8R1u+UQqanfJH5uYNyDhYp47bbaMNpDb14BxO7TJu5hjuO5x6z3ol9qJNCFJL
RqxurrQ379WuIB5pUMe0IuqYqfGF+5NcPvmBUZb4eL5oA5GdaMOXPkAPhS/4g1ZK
xp5hQiWpGtlRNGXzJl9bohZqwMG9CIA3Zn2hCS+2/mTnuUZUIE3mBwjqIw5r04XC
ZhZkEbLnznvI67wzpc7btGzi8vd7lzIQ4mXTzvJGWIM2yNcoHhNNj/CH1r/GEDaU
P1vCK3sJtiQ=
=Tnw2
-----END PGP SIGNATURE-----

--=-RCCYwAwNx98OxXLOv+y2--
