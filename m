From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: =?UTF-8?q?Makefile=3A=20be=20more=20friendly=20with=20user=20supplied=20CFLAGS?=
Date: Sun,  2 Sep 2012 22:12:55 +0200
Message-ID: <1346616775-11714-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51134 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417Ab2IBUNJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Sep 2012 16:13:09 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46or compilation to work

	-D_GNU_SOURCE -Isrc/include

is needed to be passed to the compiler. For Debian packaging several
things are added but not these two from above. So be a bit more friendl=
y
and add them unconditionally. There is no harm if they are included in
the user supplied CFLAGS and so passed twice.

Moreover be a bit more correct about CFLAGS/CPPFLAGS. Both should be
passed to the compiler with CFLAGS taking options for the compiler and
CPPFLAGS taking options for the preprocessor. This is also needed for
Debian packaging where the helper scripts set CPPFLAGS.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=20
---
 Makefile |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: rt-tests/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- rt-tests.orig/Makefile	2012-09-02 22:04:06.547562496 +0200
+++ rt-tests/Makefile	2012-09-02 22:06:56.169496678 +0200
@@ -20,7 +20,8 @@
 NUMA 	:=3D 1
 endif
=20
-CFLAGS ?=3D -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
+CFLAGS ?=3D -Wall -Wno-nonnull
+CPPFLAGS +=3D -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=3D
=20
 ifndef DEBUG
@@ -47,7 +48,7 @@
 VPATH	+=3D src/hackbench
=20
 %.o: %.c
-	$(CC) -D VERSION_STRING=3D$(VERSION_STRING) -c $< $(CFLAGS)
+	$(CC) -D VERSION_STRING=3D$(VERSION_STRING) -c $< $(CFLAGS) $(CPPFLAG=
S)
=20
 # Pattern rule to generate dependency files from .c files
 %.d: %.c
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
