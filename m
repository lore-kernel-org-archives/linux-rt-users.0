From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] Make comment describing set_debugfileprefix a bit clearer
Date: Fri, 12 Jun 2009 15:41:26 +0200
Message-ID: <1244814086-10929-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090608045353.GA11319@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GeunSik Lim <leemgs1@gmail.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58929 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760878AbZFLNlc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Jun 2009 09:41:32 -0400
In-Reply-To: <20090608045353.GA11319@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This was noticed by GeunSik Lim.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: GeunSik Lim <leemgs1@gmail.com>
Cc: Luis Claudio R. Goncalves <lclaudio@uudg.org>
Cc: Clark Williams <williams@redhat.com>
---
Hello,

just to have the alternative suggestion in patch form, too.

@Clark:  If you prefer this version, too, you can pull it from my repo =
at:

	git://git.pengutronix.de/git/ukl/rt-tests.git for-clark

together with a manpage format fix.

Best regards
Uwe

 src/cyclictest/cyclictest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index be9a3f9..558091e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -179,7 +179,7 @@ static char functiontracer[MAX_PATH];
 static char traceroptions[MAX_PATH];
=20
 /*
- * Finds the path to the debugfs/tracing
+ * Finds the tracing directory in a mounted debugfs
  */
 static int set_debugfileprefix(void)
 {
--=20
1.6.3.1
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
