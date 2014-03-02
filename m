From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: Linux-rt fails to boot [any release past 3.12.5-rt7] on all of
 my machines
Date: Sun, 02 Mar 2014 18:18:58 +0400
Message-ID: <53133DD2.40107@pavlinux.ru>
References: <CAOcfFMw2P9QwQrzUYL4rpvrJ2_d7L8Q3fi3-U=dgB=krjd2QoQ@mail.gmail.com> <20140207152250.GC2382@linutronix.de> <CAOcfFMzcymuyoi+Ox6pQ=U7KBbmbwFOYwHZHKBQPQpmjBLkQJQ@mail.gmail.com> <53131268.4070806@me.com>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="diWMRBw2TUG2swV7nT4SHRXWhqPhsfP8h"
To: Kimmo Taskinen <kimmo.taskinen@me.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:46460 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbaCBOTH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Mar 2014 09:19:07 -0500
In-Reply-To: <53131268.4070806@me.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--diWMRBw2TUG2swV7nT4SHRXWhqPhsfP8h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

02.03.2014 15:13, Kimmo Taskinen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
>=20
> Phenom has had boot problems with all patches after 3.12.5-rt7.
>=20
> Today I noticed that an old Turion64 laptop didn't boot even with 3.12.=
5-rt7. I
> tried 3.10.32-rt30 and that worked fine.


I have yet three or four months ago that most x86 systems, almost all of =
the
patches to the kernel 3.12 do not work.

Partially or accidentally only work with debug information: if enable
CONFIG_DEBUG_KERNEL and DEBUG_LATENCYTOP,.... and other.


See mailing list history.

--=20

                                                         Pavel.


--diWMRBw2TUG2swV7nT4SHRXWhqPhsfP8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJTEz3SAAoJEPtok08Dny2hiPMQAMnGv3qGHABX96B9Boz3Mdd5
ccHWKWgfOBL6J6jBBdoGJIs4iqww2rHea594nKHC5bMphvUleNe/qJR+Kcazrt9i
xbZMcjt+uYHCOKSR3Ozh3BZJr55UAe9JRhu/DZzPHD1Xb29H0z+kF/xcKyZ106Wy
nCRw9DZcwymOH0A9aIvGwYik0ENUEGYUK/Uyzmi2FE+bDke5yuMPsbYrfIhMdTp1
StgoFUJu+M5CuxpQe90ZTkpx0SGEhfzWGt6qrB+WcWfDZLXoNZTs6tAfu2vj9m2t
VL1kQMKfkDdUHsjiHfEF6acjOAPgVhljsBQx9CWevBUYPePkXKKjRwAuta7WC71j
B1dZznaQSZ3zHJ82jnMUrr2qveS+yvglPni8e2uZ92mjbdeVxbEX8SOUpRYDre3v
uHf83INDNxPtgDrb1WZgKoBfsSo18STacNPSP+0/4yc4ECAWupVlxzUjnwz0o9xs
RuZcEU3wuRtn2YSslmu/MlAKrL/kpG9eV0uAiD9PDI23lofnk1O6lG7zHNFyO9j2
BG9zchtHggNIq8jmtrQAeohV6yi7fdwvb8xKa/Q39EKoV0RWxKjf9+oz9HbeJEXp
YT/NnRvr5P2xFgFFA2OS97nc9j7CzWZI1agKcIz1FOe1gC+lpgVekqCOGZQxXRxj
E2braMVEEe9tOIOuGIz8
=2Xrx
-----END PGP SIGNATURE-----

--diWMRBw2TUG2swV7nT4SHRXWhqPhsfP8h--
