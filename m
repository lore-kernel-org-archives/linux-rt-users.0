From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: 3.12.6-rt9 on AM335x (armv7)
Date: Wed, 08 Jan 2014 03:46:49 +0400
Message-ID: <52CC91E9.7070808@pavlinux.ru>
References: <52C44448.3030405@ma-fu.de> <15611103.51LOkxSQt9@dabox> <52CC6F94.6070906@ma-fu.de> <10785809.PZUZGWPMgY@hydra>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ECmTVdNB704UUEXNKNslMQStW8Ni8tS0b"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>, Matthias Fuchs <mfuchs@ma-fu.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:35913 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbaAGXrW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jan 2014 18:47:22 -0500
In-Reply-To: <10785809.PZUZGWPMgY@hydra>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ECmTVdNB704UUEXNKNslMQStW8Ni8tS0b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

08.01.2014 02:58, Tim Sander =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Yeah 118 =C2=B5s should be the right ballpark, while still a little hig=
h for my=20
> taste. All cortex a8 seem to have rather high latency. The A9's seem mu=
ch=20
> better in this respect.

On my Intel Atom D425, latency around 25-30 =C2=B5s (but peaks upto 5000 =
=C2=B5s :/ )

>=20
> Have you seen the following:
> https://www.osadl.org/Realtime-Preempt-Kernel.kernel-rt.0.html#latencyf=
ighting
>=20
> Cyclictest has tracing support which might help finding the cause of th=
e long=20
> latency.=20
>=20


--=20

                                                         Pavel.


--ECmTVdNB704UUEXNKNslMQStW8Ni8tS0b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJSzJHqAAoJEPtok08Dny2hopAP+gJb9MIE+qy7oTTz9NjR04K6
czW8TLXcjqhT6y3r/lLve1EBr5Vz8lU+gTWglixL95wXHC3sYw8GIbkzlmg48lyy
EntYAQkT6pldQbaNFefOLhsnq1WvdXiOu3X0E4fmOrRFsUk5PLxIdOZtmTa8SG0C
lZiHulOOkrrYGo0MKQ1jGqOu0eXvyXjiaxmOFvcsiV32moeb38NUQPGKdeybhNBn
o54pwmPWS/ZrSFpHsqn4zeUREu17okOV5ZpC1o2hEAO8IGde03pbNJO3rgpE8AtI
Z2Uo5i+fJKmbni0gZPDP4j+vP/5HG9ETs5Gojhy5OvPn9UvSvcJBIjHP4sn3OUko
Jn784A+ND7WQEksWMeFmvDrn6LyItzZRIt3I7tk61WHSQ2EBN3y/TaCJTKdxvnxL
tWL0MJoNIwiAVC+jh/Bq8qSP+7/yaQ1nqa5cpVdqFnBUb/ic87VyUxE5GU9H0Ntx
7tBAfBGX675EbR475NIW1oER7jLWREplaGJe5zEmqJ6sRdgeqgBJpeOfDpHsMjwc
QBfA/OGhVN7uOFeNqPNIEHszMizia8/2AATrfaJQre+5gSlMNr80J3WaYJI/jDz3
y7Svg1c0yqSq+uSC95tIZCzKaS5amTIgYqh7n9y8tG1IliJLvOUQSGeidnfL8qo6
G0mCH8chTUZ66E7LQrVA
=7sBA
-----END PGP SIGNATURE-----

--ECmTVdNB704UUEXNKNslMQStW8Ni8tS0b--
