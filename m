From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: =?UTF-8?q?Don=27t=20reference=20non-standard=20realtime=20group?=
Date: Wed, 13 Jul 2011 22:48:31 +0200
Message-ID: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58854 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab1GMUtI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jul 2011 16:49:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

There is no dedicated realtime group in most distributions. So make the
error message a bit more understandable for people not running Redhat
MRG.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Closes: http://bugs.debian.org/619938
---
 src/lib/rt-utils.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -72,7 +72,8 @@
 	param.sched_priority =3D 1;
 	if (sched_setscheduler(0, SCHED_FIFO, &param)) {
 		fprintf(stderr, "Unable to change scheduling policy!\n");
-		fprintf(stderr, "either run as root or join realtime group\n");
+		fprintf(stderr, "Probably missing capabilities, either run as "
+				"root or increase RLIMIT_RTPRIO limits.\n");
 		return 1;
 	}
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
