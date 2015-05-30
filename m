From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: debian RT kernel
Date: Sat, 30 May 2015 20:38:52 +0100
Message-ID: <1433014732.6319.65.camel@decadent.org.uk>
References: <7f79-55642000-25-50abc380@46760505>
	 <1432681902.6319.10.camel@decadent.org.uk>
	 <CAG_ZyaArK3knBuCqM68AdjqO_iVUySUZYAa546i9eje9hwJaJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gURE0igE1+dnr3hH69VL"
Cc: Braud Caroline <Caroline.Braud@univ-lille1.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: =?UTF-8?Q?Jarom=C3=ADr_Mike=C5=A1?= <mira.mikes@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54982 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932589AbbE3TjL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 May 2015 15:39:11 -0400
In-Reply-To: <CAG_ZyaArK3knBuCqM68AdjqO_iVUySUZYAa546i9eje9hwJaJA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-gURE0igE1+dnr3hH69VL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2015-05-30 at 21:23 +0200, Jarom=C3=ADr Mike=C5=A1 wrote:
> 2015-05-27 1:11 GMT+02:00 Ben Hutchings <ben@decadent.org.uk>:
>=20
> > I uploaded a new linux package (version 4.0.4-1) to unstable earlier
> > today with the PREEMPT_RT patchset included, so you could also just wai=
t
> > a day for it to hit the mirrors.
>=20
> Why we don't have linux-image-rt-amd64 but just linux-image-rt-686-pae?

The build broke on amd64; it will be fixed in the next upload.

Ben.

--=20
Ben Hutchings
In a hierarchy, every employee tends to rise to his level of incompetence.

--=-gURE0igE1+dnr3hH69VL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVWoR0ee/yOyVhhEJAQoRSg/+JpacPeDtziuiLhzpX4S6+6x9K3chXP1Z
BH11AnFt2KKcjM4JflK3kHnra1u3ovwF4VDQbWhYh6i+c0dbaFG+7U3f6Yd39Pi0
wzk7KNF4kavPDn9vAt61ka7NirLtRnyji0L65NC6LoV90mjU9u0gwYX12zON89n5
rg58MuAS85rnCUmHGsblVlkZDDdD9VHS/gyvnrc7gbr1JPTybAr0eonAs5oTpjct
q/D7qS9NYEOOEtzVp3rwD0wtvaSQMIcwFcIgzfJeE8KJ42UOEASli8sOW9gmxXed
hJN3OZrKCOOVM61fmvbMvktTvgzt/Zp0neUihhnpW22/PD1UcTb5e1pLznAN3zEq
K8FcOGUwvugsROH36B6uMmlmMooa/PYaI/5OrjAyfzZ0eVJ3SHXFVeiytumOXXXI
FKzM6C9jbkklOTNbOLmb/i3xeyLqARi6YN8a6mb9E4s9CFmIOgxjDum1+7ZRTAYF
iGLJeWDB1fphQkMMpQvPaqbA2mwPkaQwF5rxdTNRcY9rkYWJ152UGIAgCnjYiCwH
AROAouYjuAixBx1FPukZBUBuVcsfnXHY9Kdyj3FaHTRjzKeECHEr8uE2orNIIAM3
dEiK5tHyOfgK8Aq+MIyfcpSiLCY5Uu1UuHB38DLqOelIBTzWpkc0xypKtmkOXxMe
aPBzaDgmqLA=
=Yb2R
-----END PGP SIGNATURE-----

--=-gURE0igE1+dnr3hH69VL--
