From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: =?UTF-8?q?support=20compilation=20with=20hardening=20flags?=
Date: Sun,  2 Sep 2012 21:46:10 +0200
Message-ID: <1346615170-25310-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54258 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417Ab2IBTqS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Sep 2012 15:46:18 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46or Debian 7.0 (aka wheezy) packages it's recommended to use several
hardening flags, the default on amd64 being:

	CFLAGS=3D-g -O2 -fstack-protector --param=3Dssp-buffer-size=3D4 -Wform=
at -Werror=3Dformat-security
	CPPFLAGS=3D-D_FORTIFY_SOURCE=3D2
	LDFLAGS=3D-Wl,-z,relro

This patch doesn't fix all warnings but at least makes all programs com=
pile
again by not using char *variables as printf format strings.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 src/pmqtest/pmqtest.c         |    4 ++--
 src/ptsematest/ptsematest.c   |    4 ++--
 src/sigwaittest/sigwaittest.c |    4 ++--
 src/svsematest/svsematest.c   |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -389,12 +389,12 @@
 					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
 					receiver[i].maxdiff);
 				if (receiver[i].error[0] !=3D '\0') {
-					printf(receiver[i].error);
+					printf("%s", receiver[i].error);
 					errorlines++;
 					receiver[i].error[0] =3D '\0';
 				}
 				if (sender[i].error[0] !=3D '\0') {
-					printf(sender[i].error);
+					printf("%s", sender[i].error);
 					errorlines++;
 					receiver[i].error[0] =3D '\0';
 				}
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -561,12 +561,12 @@
 					    receiver[i].samples) + 0.5),
 					    receiver[i].maxdiff);
 				if (receiver[i].error[0] !=3D '\0') {
-					printf(receiver[i].error);
+					printf("%s", receiver[i].error);
 					receiver[i].error[0] =3D '\0';
 					errorlines++;
 				}
 				if (sender[i].error[0] !=3D '\0') {
-					printf(sender[i].error);
+					printf("%s", sender[i].error);
 					sender[i].error[0] =3D '\0';
 					errorlines++;
 				}
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -646,12 +646,12 @@
 					    receiver[i].samples) + 0.5),
 					    receiver[i].maxdiff);
 				if (receiver[i].error[0] !=3D '\0') {
-					printf(receiver[i].error);
+					printf("%s", receiver[i].error);
 					receiver[i].error[0] =3D '\0';
 					errorlines++;
 				}
 				if (sender[i].error[0] !=3D '\0') {
-					printf(sender[i].error);
+					printf("%s", sender[i].error);
 					sender[i].error[0] =3D '\0';
 					errorlines++;
 				}
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -512,12 +512,12 @@
 					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
 					receiver[i].maxdiff);
 				if (receiver[i].error[0] !=3D '\0') {
-					printf(receiver[i].error);
+					printf("%s", receiver[i].error);
 					errorlines++;
 					receiver[i].error[0] =3D '\0';
 				}
 				if (sender[i].error[0] !=3D '\0') {
-					printf(sender[i].error);
+					printf("%s", sender[i].error);
 					errorlines++;
 					receiver[i].error[0] =3D '\0';
 				}
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
