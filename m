From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] fix documentation of thread priorities for option -p to cyclictest
Date: Sun,  4 Jan 2009 21:41:54 +0100
Message-ID: <1231101714-8734-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38816 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759528AbZADUmD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Jan 2009 15:42:03 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Clark Williams <williams@redhat.com>
---
 src/cyclictest/cyclictest.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 4b4eedc..f11c627 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -101,7 +101,7 @@ Oscilloscope mode, reduce verbose output by RED.
 .TP
 .B \-p, \-\-prio=3DPRIO
 Set the priority of the first thread. The given priority is set to the=
 first test thread. Each further thread gets a lower priority:
-Priority(Thread N) =3D Priority(Thread N-1)
+Priority(Thread N) =3D max(Priority(Thread N-1) - 1, 0)
 .TP
 .B \-q, \-\-quiet
 Run the tests quiet and print only a summary on exit. Useful for autom=
ated tests, where only the summary output needs to be captured.
--=20
1.5.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
