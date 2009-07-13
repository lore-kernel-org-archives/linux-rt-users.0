From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: process option before checking for
 permissions
Date: Mon, 13 Jul 2009 12:38:26 -0500
Message-ID: <20090713123826.56612b42@torg>
References: <20090713123448.GB2515@www.tglx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/tirPZ_4DHebxNubzgwBvQgH"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47055 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbZGMRij (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 13:38:39 -0400
In-Reply-To: <20090713123448.GB2515@www.tglx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/tirPZ_4DHebxNubzgwBvQgH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jul 2009 14:34:48 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> so a normal user is able to take a look on the available options
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20

Thanks (I've been meaning to and forgetting to do this for *forever*).

Merged and pushed in 0.49

--Sig_/tirPZ_4DHebxNubzgwBvQgH
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkpbcRUACgkQHyuj/+TTEp2YZgCghNpfigUFegHb2Ve3YXD5ZnNw
4kEAn1KtMYABSFIOlpOU82l7YwJu+Vno
=AOkw
-----END PGP SIGNATURE-----

--Sig_/tirPZ_4DHebxNubzgwBvQgH--
