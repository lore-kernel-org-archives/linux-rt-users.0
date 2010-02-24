From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/3] install backfire.c to $(srcdir)/backfire/
Date: Wed, 24 Feb 2010 17:58:07 +0100
Message-ID: <1267030688-12244-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100224165611.GA22159@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40832 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320Ab0BXQ6N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2010 11:58:13 -0500
In-Reply-To: <20100224165611.GA22159@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 043b747..99fbba4 100644
--- a/Makefile
+++ b/Makefile
@@ -110,6 +110,7 @@ install: all
 	install -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwla=
tdetect.py
 	ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect"
 	mkdir -p "$(DESTDIR)$(srcdir)/backfire"
+	install -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/=
backfire.c"
 	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4=
=2Egz"
 	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclic=
test.8.gz"
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress=
=2E8.gz"
--=20
1.6.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
