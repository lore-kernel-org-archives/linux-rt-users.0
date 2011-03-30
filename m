From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: =?UTF-8?q?cyclictest=3A=20fix=20warning=20about=20printf=20format=20for=20u64?=
Date: Wed, 30 Mar 2011 15:12:44 +0200
Message-ID: <1301490764-15063-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42279 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1C3NMu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2011 09:12:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This fixes

	src/cyclictest/cyclictest.c: In function =E2=80=98print_hist=E2=80=99:
	src/cyclictest/cyclictest.c:1168: warning: format =E2=80=98%09llu=E2=80=
=99 expects type =E2=80=98long long unsigned int=E2=80=99, but argument=
 2 has type =E2=80=98uint64_t=E2=80=99

on amd64.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 src/cyclictest/cyclictest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1165,7 +1165,7 @@
 	}
 	printf("# Total:");
 	for (j =3D 0; j < nthreads; j++)
-		printf(" %09llu", log_entries[j]);
+		printf(" %09llu", (unsigned long long)log_entries[j]);
 	printf("\n");
 	printf("# Max Latencys:");
 	for (j =3D 0; j < nthreads; j++)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
