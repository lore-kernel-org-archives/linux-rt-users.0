From: Clark Williams <williams@redhat.com>
Subject: hwlatdetect:  Add --hardlimit to define the real test failing
 criteria
Date: Mon, 15 Aug 2016 15:28:57 -0500
Message-ID: <20160815152857.054f67e3@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/I/iqd4SqilzWMK.8mAg5egw"; protocol="application/pgp-signature"
To: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50442 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932275AbcHOU3C (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Aug 2016 16:29:02 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32E5B61E53
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Aug 2016 20:29:02 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/I/iqd4SqilzWMK.8mAg5egw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

John,

Luis and I were working on our tests and decided it is more interesting, in=
 our=20
automated tests, to have a higher tolerance for SMIs, as most of the test b=
oxes are=20
not optimized for RT. On the other hand, we would like to know how big the =
firmware-induced
latencies on these boxes.

This commit adds the --hardlimit parameter, which defines the real
PASS/FAIL latency criteria. Latencies above --threshold will be
annotated, but the test may PASS if the observed latencies are smaller
than --hardlimit.

When --hardlimit is not informed, the value used for --threshold is also
used as the hard limit.

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Clark Williams <williams@redhat.com>

diff --git a/hwlatdetect.py b/hwlatdetect.py
index d9ef027..51bb401 100755
--- a/hwlatdetect.py
+++ b/hwlatdetect.py
@@ -474,6 +474,10 @@ if __name__ =3D=3D '__main__':
                       dest=3D"threshold",
                       help=3D"value above which is considered an hardware =
latency")
=20
+    parser.add_option("--hardlimit", default=3DNone, type=3D"string",
+                      dest=3D"hardlimit",
+                      help=3D"value above which the test is considered to =
fail")
+
     parser.add_option("--window", default=3DNone, type=3D"string",
                       dest=3D"window",
                       help=3D"time between samples")
@@ -526,6 +530,12 @@ if __name__ =3D=3D '__main__':
         detect.set("threshold", t)
         debug("threshold set to %dus" % t)
=20
+    if o.hardlimit:
+        hardlimit =3D microseconds(o.hardlimit)
+    else:
+        hardlimit =3D detect.get("threshold")
+    debug("hardlimit set to %dus" % hardlimit)
+
     if o.window:
         w =3D microseconds(o.window)
         if w < detect.get("width"):
@@ -595,5 +605,6 @@ if __name__ =3D=3D '__main__':
         for s in detect.samples:
             print("%s" % s)
=20
+    maxlatency =3D int(detect.get("max"))
     detect.cleanup()
-    sys.exit(exceeding)
+    sys.exit(maxlatency > hardlimit)

--=20
The United States Coast Guard:
Ruining natural selection since 1790

--Sig_/I/iqd4SqilzWMK.8mAg5egw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXsiYJAAoJEOI5asVwYXLrY2sP/A0naLzC3tYpd/FOZ+Bi8Vuh
7FRqf6L0xssjiktHnffXozsnbolg/HUgXyf+tKQ17k7UwoqaJr+yYb5QFnDWWlcb
AmdRlLJ9RJ9zbAbEippv1AnfkYWId5XSDw7B85Pm8RNeoyHKzQSsfEOLUiA8p60Z
8g1o8AveGPL9JkuuX49EPLpJg1z/rTZdgc5MkiJpbnoJf7eFsia3u/paQTmJaFFO
vuAOyHZfyot0ZDeiYimDMSEBLPpiCU+OXuSCUF3gYuIfM2oSLkyIrVFIrc+lsj0t
mHcCR/SKQd1CuCxtNkT4nAABQYCxzGXpWgoUqqYtKwwNf+Pn6yEfqL1pdKOHOi0Y
3VBuIX3gKlilg6VNtIaZxD7AVNJIPgGTl5U+0efvPhdZrrK+N/iKv9oemvxhhwpj
rwvFH4aqseC5DfqYB2VcpJlkRX/EVgWGQxl9c2wmGxsOgy6GJzTmIaTMjG7yYs7/
Hd8wBRV/pcI2qdwT/xYZvgpX9eXEiIwSdsq3m1MuPDoFRu9AUcDcJCoPN4jqMJVf
t6YV4Y4d2dTX4cKHZhMcoLXsiFrOD2yixcgkKn/kjl+F0pdr55otrEjFs1c18Yfe
XTPAT0o10GIqEpldlz/PodnSMUm66WXkI4aTeHSSBSXoGRixvjP0SyNe+499xSMr
fBVDt707II6Hur0IIK92
=0BW1
-----END PGP SIGNATURE-----

--Sig_/I/iqd4SqilzWMK.8mAg5egw--
