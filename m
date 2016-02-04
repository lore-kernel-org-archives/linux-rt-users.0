From: Clark Williams <williams@redhat.com>
Subject: Re: [RT] oops in 4.1.3-rt3
Date: Thu, 4 Feb 2016 14:59:31 -0600
Message-ID: <20160204145931.47dd616d@sluggy.hsv.redhat.com>
References: <20150803142700.1de720e4@sluggy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/t0ITbzCFEuwpSFfwdSagB.V"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803142700.1de720e4@sluggy>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/t0ITbzCFEuwpSFfwdSagB.V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Aug 2015 14:27:00 -0500
Clark Williams <williams@redhat.com> wrote:

> Sebastian,
>=20
> Below is a traceback I hit while running 4.1.3-rt3 on my Lenovo T530.
>=20
> I was doing my normal, play music, copy files over the lan, do compiles,
> do email, etc., so I I can't really point you at a reproducer. The graphi=
cs
> system stayed up somewhat but the actual trace I hit scrolled off. This w=
as
> extracted from the syslog with 'journalctl'.=20
>=20
> If I encounter it again, I'll see if I can force a kdump.=20
>=20

I have been unable to reproduce this bug. It happened during normal use and=
 I haven't changed work habits, so I'd say drop this from the -rt open-issu=
es section until we can get an actual reproducer or at least until the freq=
uency goes up.

Thanks,
Clark

--Sig_/t0ITbzCFEuwpSFfwdSagB.V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJWs7u0AAoJEOI5asVwYXLrqwMP/1ejnmpOgS1HcLtmVd9rx6YO
Bg8DhPxB0VRAV0O3B6cSfVCdG7BTwhrBbcO1kyRD0JQtOd/jt+jZculWV6gORvy4
/6d+zz+g8i4LTbc+AM9sgPXURQ/3tFP6NaYwTDZ4IMrsIc6SONhIC7rv7Nvy66Yd
2EF9z03QA6yePywlku+o7lcA5BL1jdZkWvweMRCL6GFYK+0jht2sVFK3Qwda81C4
I0pGIUiHp7774gP6RySo5hGOblNC3TagmqPM0pyCs9J8N6qqhW7+F9x7NeAh1gMY
phZLIAVOZs3GHFu4aQrq6p9qdi6LXYfuKCPsGtOXHrrERBnmYxXwOXxlS7vbo0VQ
RZIvshrmqXJBNJl5/nxACetfWRxpMtl8oeLO6nXsm2zwrv5vjYqhGhJCImsGGsLo
uVHrYxMnjvc9EkoP/vR3HPA2x9ZwFyIaWWogrqpJL9wrV2UXUKLfC+nup7jdDh9W
9oQtlJQcHHXIf7otRgfSFLnhM9WYPtYWLd12Al2ms9W8iuzp8lDbDexPTPxDmqZZ
ilQwe/cmWkhqsB1kyCLBJRAFrErzArvNXSUukzQ8Yz4TZKicBHfrpcraoZjebsN4
EYfhtMmB6mGpaRiIEuIlecFg5t7MwlpmOXx7uptl6vm1U/Xg9VTzyYdmFF1t+POb
L3gTOoyxSo+ilAqV94OE
=NlVH
-----END PGP SIGNATURE-----

--Sig_/t0ITbzCFEuwpSFfwdSagB.V--
