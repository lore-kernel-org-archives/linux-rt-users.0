From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-tests - allow build without NUMA
Date: Fri, 23 Sep 2011 16:09:18 -0500
Message-ID: <20110923160918.582041c8@redhat.com>
References: <4E7CDD4B.2070202@am.sony.com>
	<20110923194632.GT20550@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/ab=fWC62ci=oev8D=pdDuTv"; protocol="application/pgp-signature"
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	linux-rt-users@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab1IWVJZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Sep 2011 17:09:25 -0400
In-Reply-To: <20110923194632.GT20550@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/ab=fWC62ci=oev8D=pdDuTv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Sep 2011 21:46:32 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> On Fri, Sep 23, 2011 at 12:26:03PM -0700, Frank Rowand wrote:
> >=20
> >=20


How about this?

diff --git a/Makefile b/Makefile
index 4f51154..4776391 100644
--- a/Makefile
+++ b/Makefile
@@ -14,7 +14,11 @@ bindir  ?=3D $(prefix)/bin
 mandir ?=3D $(prefix)/share/man
 srcdir ?=3D $(prefix)/src
=20
-NUMA   :=3D 1
+machinetype =3D $(shell uname -m | \
+    sed -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
+ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
+NUMA   :=3D 1
+endif
=20
 CFLAGS =3D -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
=20
@@ -26,7 +30,7 @@ else
        CFLAGS  +=3D -O0 -g
 endif
=20
-ifdef NUMA
+ifeq ($(NUMA),1)
        CFLAGS +=3D -DNUMA
        NUMA_LIBS =3D -lnuma
 endif

--Sig_/ab=fWC62ci=oev8D=pdDuTv
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk589X4ACgkQHyuj/+TTEp18+gCeKUzz8BLWON/NNWLzwXaxCj12
wmMAn1aM83Y7nU7zD2D2NRuG/2oMyBXO
=YLlk
-----END PGP SIGNATURE-----

--Sig_/ab=fWC62ci=oev8D=pdDuTv--
