From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] clock_nanosleep interrupt
Date: Thu, 2 Jul 2009 09:48:26 -0500
Message-ID: <20090702094826.7f4cbf8f@torg>
References: <20090429155011.09e2218f@torg>
	<1246499863.32598.3.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/LfUlwmLh2sAmufuJS.By.Tj"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>,
	Daniel Gollub <gollub@b1-systems.de>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:40747 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbZGBOsg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jul 2009 10:48:36 -0400
In-Reply-To: <1246499863.32598.3.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/LfUlwmLh2sAmufuJS.By.Tj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Jul 2009 18:57:43 -0700
Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:

> Subject: Avoid segfault of cyclictest if it gets immediately interrupted.
>=20
> From: Daniel Gollub <dgollub@suse.de>
>=20
>

Thanks, applied; will go out with 0.45 shortly.

Clark

--Sig_/LfUlwmLh2sAmufuJS.By.Tj
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkpMyL4ACgkQHyuj/+TTEp0XYACgoO8xZwyvx+okAfAuI6lBJrtd
PC0AnR7EJA/dYmvfNCFqHRsRA8OePG4Q
=yX6j
-----END PGP SIGNATURE-----

--Sig_/LfUlwmLh2sAmufuJS.By.Tj--
