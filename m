From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: VirtualBox 4.2.4 freezes PC using RT_PREEMPT kernel
Date: Sat, 15 Dec 2012 11:14:35 +0100
Message-ID: <50CC4D8B.9050004@web.de>
References: <F9467A784CC48947B1D879F07370839E0EBCE44D@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA3EB4B43A5B7049D46959663"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:56412 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab2LOKOm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 15 Dec 2012 05:14:42 -0500
In-Reply-To: <F9467A784CC48947B1D879F07370839E0EBCE44D@fe20099s.ecn.etasgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3EB4B43A5B7049D46959663
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-14 09:58, Koehrer Mathias (ETAS/ESS2) wrote:
> Hi all,
>=20
> I have detected the following issue:
> I use an x86 PC using kernel 3.2.34-rt51 and I want to run VirtualBox 4=
=2E2.4 using this PC as host.

> However, the PC freezes completely when loading the vbox driver "vboxdr=
v".
> Using the very same kernel without the RT_PREEMPT patch shows no issues=
=2E
>=20
> Using an older version of VirtualBox (V4.1.22) works fine as well.
>=20
> I know that this might be slightly off-topic. However there might be so=
me RT_PREEMPT users that have detected the same issue and know a solution=
 for this.
>=20
> I have attached my kernel .config file.
>=20
> Thanks for any feedback on this.

Try enabling lock debugging. Likely there is an incompatibility in the
vbox driver or even a bug, and that may reveal more details.

Otherwise: KVM is the better choice on Linux hosts, and it works fine
over -rt.

Jan



--------------enigA3EB4B43A5B7049D46959663
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDMTYsACgkQitSsb3rl5xRvnQCfW3TurRq+2maCHhErG8RArRYn
QOUAnjvI5pqdvSlG1o1O3zATw2wy5XTn
=zlAL
-----END PGP SIGNATURE-----

--------------enigA3EB4B43A5B7049D46959663--
