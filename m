From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: debian RT kernel
Date: Tue, 19 May 2015 17:58:49 +0100
Message-ID: <1432054729.12412.26.camel@decadent.org.uk>
References: <CAG_ZyaA83dFKKvEsNhzyGkjrbsY=_mFBGjmg+M1-+MPo=-hOUw@mail.gmail.com>
	 <20150519115633.55ec7739@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0LMpDHlJiPmXzSIVxrm1"
Cc: =?UTF-8?Q?Jarom=C3=ADr_Mike=C5=A1?= <mira.mikes@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39758 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755168AbbESQ7D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2015 12:59:03 -0400
In-Reply-To: <20150519115633.55ec7739@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-0LMpDHlJiPmXzSIVxrm1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-05-19 at 11:56 -0400, Steven Rostedt wrote:
> On Mon, 18 May 2015 22:13:40 +0200
> Jarom=C3=ADr Mike=C5=A1 <mira.mikes@gmail.com> wrote:
>=20
> > Hi all,
> >=20
> > We quite recently had RT in debian easily accessible for all users
> > what I personally consider to be great achievement.
> > But because RT development interruption we don't have fresh RT kernels =
anymore.
> >=20
> > Pengutronix provided debian packages of RT kernels before.
> > Is there any place where to get debian packages of RT kernels?
> >=20
>=20
> I believe Ben is the one that maintains the RT kernels in Debian.

I built kernel packages with the RT patch set whenever it was available
for the upstream version we were using for standard kernel packages.
Unfortunately there is no patch set for Linux 3.16 as used in Debian 8
'jessie' or for Linux 4.0 which is currently in unstable.

Older versions are available from
<http://snapshot.debian.org/package/linux/> but they will have known
security issues.

Ben.

--=20
Ben Hutchings
I'm not a reverse psychological virus.  Please don't copy me into your sig.

--=-0LMpDHlJiPmXzSIVxrm1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVVtrzee/yOyVhhEJAQqnEQ/9GcICdULGefqXBXqMI98kWH/JmX8l9tdc
HHE5z9zIQrvwVgun3bvN4NaiAfCgmEf1vk2qj+U5T7PRoixFYorRHdyqkiVFwoWf
SIf1ZcyycvITjGK55+BudgO1q0AQ0P8+dm4pVvahJmZ35h75CkSWjObuvHgphz/y
w4Lqv77QYszrkBBgEQAjrgAKupMg42bm+KyewADMgVcyW2xxTOIRJS7093EEbN3i
HNHqKJIH/wrdB1rbPyczvL0y/EOd+ypj67NJVds7AtGY/IqgotX0f67qkgjY5hIl
D2IU3G0FVFX+jr5z5lkFzNLVdb8VXHoObosOfcZKJXZBkqSvRrwJoKtr2LhoBGwi
Jy5LUYi4V2lRmuYUHbK6oeFCHbcTWtuQAK3dFw45HGdYA6ReCtUz0GxkejZwV6HW
nLe8EqFQmK5LhTDJfGKZXkcjrwWsX3Cvl7i5IRwXlfi0zCp+pbj7XLxWeqN79Ddp
1QN7+wCS2/35NWYRU9c2R4zgho5Li3jKkl9eIFpYeAuC0a9OxcujKebrqKEX8ZBG
+9onTAAJOTSjHyQ5jq5KI5SFwDpUM6ZNqI/pjWCPasIqE+8YMdab3xUTjQ5J0bmv
3933oBwtvOv5TD9cSyz1F7ys4rKgCj2VegHobRLbjO6CGhnSwBnd8K5bsXQ7Ap8a
oGdY5pXsOjU=
=G0JF
-----END PGP SIGNATURE-----

--=-0LMpDHlJiPmXzSIVxrm1--
