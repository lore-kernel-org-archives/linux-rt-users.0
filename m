From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-tests: Update the cyclictest man page
Date: Mon, 25 Apr 2016 11:19:13 -0500
Message-ID: <20160425111913.14c5573c@sluggy.hsv.redhat.com>
References: <alpine.LFD.2.20.1604251614270.6896@riemann>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/yD08.N5wA5.00F3+lS6fk8."; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60711 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932882AbcDYQTU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2016 12:19:20 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C06A6461D6
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Apr 2016 16:19:19 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1604251614270.6896@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/yD08.N5wA5.00F3+lS6fk8.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Apr 2016 16:17:11 +0200 (CEST)
John Kacur <jkacur@redhat.com> wrote:

> From 7e007ac70a83f62583d25b10ad2df0430306bf32 Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Mon, 25 Apr 2016 16:08:28 +0200
> Subject: [PATCH] rt-tests: Update the cyclictest man page
>=20
> We have done a good job keeping cyclictest help up-to-date, but we have
> not been actively updating the man page.
>=20
> There were many missing options, as well as options that don't exist
> anymore. To be more precise, some short form options had been removed,
> but there are still corresponding long-version options.
>=20
> This patch contains a considerable amount of updates to the man-page to
> keep it in sync, and in some cases it also updates the cyclictest help
> where needed. For example, the cyclictest help options were not always
> in the proper order. In some cases I changed the wording to make it more
> closely correspond to the man page
>=20
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.8 | 169 ++++++++++++++++++++++++--------------=
------
>  src/cyclictest/cyclictest.c |  35 ++++-----
>  2 files changed, 110 insertions(+), 94 deletions(-)

Looks good to me John. I did see one spelling issue:

> +Sned break trace command when latency > USEC

Thanks for cleaning the man page up. I'm afraid I neglected it.

Clark

--Sig_/yD08.N5wA5.00F3+lS6fk8.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXHkOBAAoJEOI5asVwYXLrY4AP/3l2z5xab7iP+ydzoc5rmVXA
VxI+3a0o+4Zs9BIyBHr5DDWdUSHkeUVA2Q8DWxLzo2OZhAhLXaorzp6IGQRFXHlI
T66fzQMxoznXq6/aTDQnROorBXkayv/yU8fZe1uF6LowbwHZlKWQKBdR2YcBHhXk
R5/IuPoFuHi/s4cn1mqIWdVKi4h+ponvFTbuNyIXDoBB9c5BqWdhUAtNQ/A5kHDS
D2Uke0o6knyd5+MeJGQcQNGn8RTnLB+mP0yWwerPQFNwaVzzNLfKs7KYF4cK/nTT
yIecLOGTFXhwCNeeF/JyQTzXTm3vCdSo8zunU//B27vIJsE0QmH+bSeZleYpHArF
UQ8sNoqi1ZaxlD3am7p6yZPTWTDZc49HazhfVL8AkGrj6pS8yijYUAvjwVmPvsTC
+nFrs/j2UHpyX9ivVDxsfw7oUsC4zm0EGv9FAVzevYTJUpefNA66rEFMUCKuCTEw
nhbcEvpbC7U31w3sazlIyIJnux1v/goorgQ53t7cx8S+2IFsGzm4ydnmVVHAsW41
SklXtInWVdXP1cqYuK2Cx3xAV19tFuJCpyq1QzJAD+7r1LDdl8EDSSEExygIcRFt
gfQcBXF2rLm5eFjbBiqApV8+a86BPwroTUYA0knmofmC39bwLD10ztVG0M5Ic8wm
Oy+MAwOWYaO+srdrmcis
=H9/o
-----END PGP SIGNATURE-----

--Sig_/yD08.N5wA5.00F3+lS6fk8.--
