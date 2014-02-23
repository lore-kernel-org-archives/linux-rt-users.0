From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [ANNOUNCE] 3.12.12-rt19
Date: Sun, 23 Feb 2014 23:29:04 +0400
Message-ID: <530A4C00.5070205@pavlinux.ru>
References: <20140223184727.GA12442@linutronix.de> <530A486A.2000802@pavlinux.ru>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PG8D4f1NkITLFPc4gRt29glTqDHshv6B5"
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <530A486A.2000802@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PG8D4f1NkITLFPc4gRt29glTqDHshv6B5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

23.02.2014 23:13, Pavel Vasilyev =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> But not  -rt1, -rt2, -rt3 -rt4, .... -rt99

Or

3.12-rt1,
3.12-rt2,
=2E..
3.12-rt33,
=2E..
3.12-rt111,
=2E..
3.12-rt999
=2E..

Now, to have to roll back all my changes, then work -rt patch,
then impose SUBLEVEL mainline diff, then last -rt patch, then my =D1=81ha=
nges.



--=20

                                                         Pavel.


--PG8D4f1NkITLFPc4gRt29glTqDHshv6B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJTCkwAAAoJEPtok08Dny2hOn8P/jqr3hNlmlHYWFaVfqzIYXAF
0SHYz4wXaDs9WjDYyOYBgNPkyXCAHiSAFbeQsblb574fdUH8FhYY1HIaemdieiw5
D8BBwAE/XmFStfzvI6uJ08i88NoWtRwZ8LSIVhcJup7tqHU4Of8SEaJB88SFSJ9R
abK02vG1cv+5JhMYxSLfEB3M1NEgjfp06aF45yyuRE2eHiAA6WSi1my1FYoAh0wl
sz4bK2dsvHXBQtm7s94TOCZiHDq5mr4vv4DoeSvXRSaxy1lS+l2WAXsXrA5AxVWt
Y8udCqIre1OaI5fU3JW62sv2VpQCQMGioKgKtA0TsuV8qi4Qo2hJQF9k9VNsdFxf
6X5IpO7z4Nq03kUBIZSWZMtVjN8NMwwNFxbtoCLKO6x/FlAgxMJaB9KwZPSAfSYe
bXvwJjlD9W4T1xutRca4FQcU9n9zxClMYfhcagajFqldjsbEwkuyXZ5BMAWMt84g
4RTm+5VSp3PsVO46NZYEl7OpaR1m+73snsuikCjQMrKYvrO1/BxAVCYDsmqJqDLe
Mnpy5jQXziSA3N3a4qa4Rujq9V4fuSRuLYtIgNnAirBbxmvQJZkYNdkkihzkkFLs
TflOb432R+zEA+Vvf86IpPUOJnmvuSebl/4PbSB8bp29q+krB09P2ZiB3PVDYKXL
0pEF9RUd5tSDKOsQa86n
=6+8u
-----END PGP SIGNATURE-----

--PG8D4f1NkITLFPc4gRt29glTqDHshv6B5--
