From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: add command line option for unbuffered
 output
Date: Tue, 29 Dec 2009 12:37:18 -0600
Message-ID: <20091229123718.6efbf5f0@torg>
References: <1261742519-7507-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/=W=BhhC7D86bYLuJu6Uzv1r"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	Wolfram Sang <w.sang@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8826 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbZL2Shb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Dec 2009 13:37:31 -0500
In-Reply-To: <1261742519-7507-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/=W=BhhC7D86bYLuJu6Uzv1r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Dec 2009 13:01:59 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> From: Michael Olbrich <m.olbrich@pengutronix.de>
>=20
> Wenn reading the output from cyclictest with another program, the data is
> buffered by default. This prevents nice 'live' display.
> This patch adds an command line option to force the output to always be
> unbuffered.
>=20
> Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks, applied to 0.60

Clark

--Sig_/=W=BhhC7D86bYLuJu6Uzv1r
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAks6TGIACgkQHyuj/+TTEp1zYQCdGOgDJ0ljk/aMp8vzidOiQpA8
cB4AoIdHE/IejHOeNWG9ljmf7sUWDUdH
=O/LD
-----END PGP SIGNATURE-----

--Sig_/=W=BhhC7D86bYLuJu6Uzv1r--
