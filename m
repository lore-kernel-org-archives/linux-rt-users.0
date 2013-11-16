From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [ANNOUNCE] 3.12.0-rt2
Date: Sun, 17 Nov 2013 01:26:00 +0400
Message-ID: <5287E2E8.7080004@pavlinux.ru>
References: <20131116194633.GD11518@linutronix.de>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gHxIcxijanlmTM24xCj77srtg1sirToqV"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:47901 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab3KPV1q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Nov 2013 16:27:46 -0500
In-Reply-To: <20131116194633.GD11518@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gHxIcxijanlmTM24xCj77srtg1sirToqV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

16.11.2013 23:46, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
> Dear RT folks!
>=20
> I'm pleased to announce the v3.12.0-rt2 patch set.

I cat't still to mount filesystems!
bash not start!

1. pull git kernel 3.12
2. wget rt-patch
3. patch'em all
4. make oldconfig && make && make install
5 In cmdline type init=3D/bin/bash
=2E...
And....  see screenshot:
http://i59.fastpic.ru/big/2013/1117/85/61c0a35e5a456263910ce4cf3152d085.j=
pg

system not response, SysRQ+B - work


3.2.52-rt72 - work
3.10.18-rt14 - work
3.12-rt2 - NO!





--=20

                                                         Pavel.


--gHxIcxijanlmTM24xCj77srtg1sirToqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJSh+LoAAoJEPtok08Dny2hM4UQAJVS0CqiAFOjqs92+rY3WBrA
BRHWQctJiQ6ns7BhciXgU3/A4uERLV6wk+iGETcPM1uB0JXLvggC7TxQh2yY9nT0
sQGtKzoEeBI51OU5PG/8SOQ1dOVQARCxZ0fYUdNIOY2bsnaMtsQKCCXS0ledrQuU
nB8ReYXBP7ml1MpyLN+MFvLqselODmj0FqyjmhKD8xePt54J+ErxborkR+WtwLzS
W4C+BsnNh+feLdJsYDKba5Z5xmi73UaLU2lxE1C1Hsui5SgqpQMlKcbu+SSNo7/2
t9piiXFMy5W4sT4+fBk5m4S7FcFLqxyNNe2kpWFhqJjilBtlJusuLL5sokNe9mvf
M3ZaEc2SVTHM3SofUxpk+t+7YLE7ClOFGhj7/RArEZDGyTaGZXFwnkmU7eJZ8b3z
n3Xbtl2q+V/xk34cCgRVZnXD/1FuyQUDnqB55DWow4BstnbLEfUnmZ3btG/bDF5b
jJS9hL30jS9YQqPNRx5kHRKkyaxsJuNJdS2b8zpdJ+QJEOh+/JfFMJVzI+gc9b7C
S+02s8Rooad1ORM6LOOmCjhj48nPMIBRdEz3CeLZiNjOql8NWl2m8pm/pBJ7gYST
WSwAr6vQHf7HTTCXWJ5C6pmQLQJN7iezClCXqrlNJnpUsihDeeAEqSuzYhK9ybYs
rHQJSIp0vrj4eBunONT5
=8Mjw
-----END PGP SIGNATURE-----

--gHxIcxijanlmTM24xCj77srtg1sirToqV--
