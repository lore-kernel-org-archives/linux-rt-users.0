From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: exit with an error code in error case
Date: Mon, 13 Jul 2009 12:37:36 -0500
Message-ID: <20090713123736.5b8fe8c4@torg>
References: <20090713123209.GA2515@www.tglx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/E+erKoHUaVan1aDfd/YJ0I."; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:46995 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbZGMRhx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 13:37:53 -0400
In-Reply-To: <20090713123209.GA2515@www.tglx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/E+erKoHUaVan1aDfd/YJ0I.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jul 2009 14:32:09 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> if cyclictest is started with invalid arguments or $SOMETHING, then it
> prints the help screen and the exit code is 0 which is wrong.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>=20

Thanks, merged and pushed in 0.49

--Sig_/E+erKoHUaVan1aDfd/YJ0I.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkpbcOcACgkQHyuj/+TTEp377ACcCoca9D455pDZboQy11b1IRa7
ywcAn1M/wnpG1vYEOnx7uqcm2wxqMEnR
=uTAg
-----END PGP SIGNATURE-----

--Sig_/E+erKoHUaVan1aDfd/YJ0I.--
