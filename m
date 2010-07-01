From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] install backfire's Makefile
Date: Thu,  1 Jul 2010 07:25:16 +0200
Message-ID: <1277961916-2538-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100701052430.GB28535@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37119 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0GAFZW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Jul 2010 01:25:22 -0400
In-Reply-To: <20100701052430.GB28535@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Only installing backfire.c hardly makes sense.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b83614c..3554bec 100644
--- a/Makefile
+++ b/Makefile
@@ -120,6 +120,7 @@ install: all
 	fi
 	mkdir -p "$(DESTDIR)$(srcdir)/backfire"
 	install -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/=
backfire.c"
+	install -m 644 src/backfire/Makefile "$(DESTDIR)$(srcdir)/backfire/Ma=
kefile"
 	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4=
=2Egz"
 	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclic=
test.8.gz"
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress=
=2E8.gz"
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
