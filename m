From: Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] 2.6.33.9-rt31
Date: Mon, 18 Apr 2011 10:08:50 -0500
Message-ID: <20110418100850.135e3f4c@riff>
References: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6>
	<4DA582AE.9020706@autostatic.com>
	<4DA5A786.8060001@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/RBcPJXx181GHCK+yAMA4zZo"; protocol="application/pgp-signature"
Cc: Jeremy Jongepier <jeremy@autostatic.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42334 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab1DRPI4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Apr 2011 11:08:56 -0400
In-Reply-To: <4DA5A786.8060001@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/RBcPJXx181GHCK+yAMA4zZo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Apr 2011 15:39:18 +0200
Jan Kiszka <jan.kiszka@siemens.com> wrote:

> A nouveau hacker recently explained to me that it's fairly hard to
> backport their improvements to older kernels as they heavily depend on
> infrastructure changes. That likely explains why you don't see many
> stable fixes or a nouveau-compat package.
>=20
> If you can live with the nvidia driver, I can share a patch that makes
> it build&work for me (Quadro FX 880M).
>=20
> Jan


I'd like to see that patch. Looking at fixing the nvidia wrapper
locking for -rt has been on my list for a while, it just hasn't bubbled
up to the top :).

Clark

--Sig_/RBcPJXx181GHCK+yAMA4zZo
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk2sVAIACgkQHyuj/+TTEp1BAgCeOnYSnS1RUek/p+HNVlf4wQSW
AY0AmwV3G6zmnZHod70swuJxKANrQ8II
=RgmH
-----END PGP SIGNATURE-----

--Sig_/RBcPJXx181GHCK+yAMA4zZo--
