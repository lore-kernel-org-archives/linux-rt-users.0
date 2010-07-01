From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 0/2] Debian's rt-tests patches
Date: Thu, 1 Jul 2010 10:57:11 -0500
Message-ID: <20100701105711.1e22f6ce@riff>
References: <20100701052430.GB28535@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/CU_vezyc0cWI+AYpmQEZOPs"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Uwe =?ISO-8859-1?B?S2xlaW5lLUv2bmln?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25680 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762Ab0GAP5b (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Jul 2010 11:57:31 -0400
In-Reply-To: <20100701052430.GB28535@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/CU_vezyc0cWI+AYpmQEZOPs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Jul 2010 07:24:30 +0200
Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> wrote:

> Hi Clark,
>=20
> here come two patches I use for packaging rt-tests for Debian.  Actually
> I have two more patches[*1*], but one of them is Debian specific
> and the other one installs hwlatdetect to /usr/sbin instead of
> /usr/lib/pythonX.Y/site-packages + a symlink as this confuses debhelper.
> Maybe the right approach is to install a script to /usr/sbin that just
> does
>=20
> 	exec python -m hwlatdetect
>=20
> ?!  Another thing I do in the Debian packages is using dkms for building
> the backfire kernel module at install time.  I don't know how this
> works with Redhat's Linux distributions though.
>=20
> I'll send the two patches that I think are ready for you to include as a
> reply to this mail.  Diffstat, shortlog and an URL to pull these two are
> included below.
>=20
> Best regards
> Uwe
>=20
> [*1*] see http://patch-tracker.debian.org/package/rt-tests/0.71-1
>=20
> The following changes since commit 886d26833d637ab778023626a158061e4eb9c5=
d0:
>=20
>   version bump to 0.72 (2010-06-25 16:16:46 -0500)
>=20
> are available in the git repository at:
>   git://git.pengutronix.de/git/ukl/rt-tests.git for-clark
>=20
> Uwe Kleine-K=F6nig (2):
>       modernize backfire's Makefile
>       install backfire's Makefile
>=20
>  Makefile              |    1 +
>  src/backfire/Makefile |   21 ++++++++++++---------
>  2 files changed, 13 insertions(+), 9 deletions(-)

Thanks Uwe, I'll try and get these merged after the holiday this
weekend.=20

Clark

--Sig_/CU_vezyc0cWI+AYpmQEZOPs
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwsutsACgkQHyuj/+TTEp1fpACeP+k7fLdti1YpxQRj7dpaE/8/
TSkAnRTA7WoHiew8eg2/jEKEHeDpeYs6
=c0eP
-----END PGP SIGNATURE-----

--Sig_/CU_vezyc0cWI+AYpmQEZOPs--
