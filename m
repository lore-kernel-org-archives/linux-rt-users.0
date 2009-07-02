From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest:
 change-output-format-to-allow-6-digits.patch
Date: Thu, 2 Jul 2009 09:49:23 -0500
Message-ID: <20090702094923.117fbd09@torg>
References: <1246500132.32598.12.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/0PV7P/r3tQwAw0RqTGAU3LX"; protocol="application/pgp-signature"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:40759 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbZGBOtZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jul 2009 10:49:25 -0400
In-Reply-To: <1246500132.32598.12.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/0PV7P/r3tQwAw0RqTGAU3LX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Jul 2009 19:02:12 -0700
Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:

> From: Sven-Thorsten Dietrich <sdietrich@suse.de>
> Date: Sat, 21 Mar 2009 16:41:40 -0700
> Subject: [PATCH] Change output format to allow 6 digits.
>=20
> This is useful when testing PREEMPT_NONE Kernels with cyclictest,
> where latencies approaching 1 second can be observed.
>

Thanks, applied.

v0.45 has been pushed to kernel.org (git and tarball).

Clark

--Sig_/0PV7P/r3tQwAw0RqTGAU3LX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkpMyPYACgkQHyuj/+TTEp1yWgCgsKbcEkzAgv4xp1SGQisUjwgF
OS8AnRzF9gEKmns/q2T+1oaKIZIQ3Sfb
=PSvV
-----END PGP SIGNATURE-----

--Sig_/0PV7P/r3tQwAw0RqTGAU3LX--
