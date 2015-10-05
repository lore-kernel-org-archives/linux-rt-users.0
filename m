From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests 1/3] all programs apart from sendme use pthreads so skip them on NPTL!=yes
Date: Mon,  5 Oct 2015 21:05:15 +0200
Message-ID: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: williams@redhat.com
To: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:55410 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751779AbbJETF2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 15:05:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

---
 Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6c96c9f31a19..af669263a5fb 100644
--- a/Makefile
+++ b/Makefile
@@ -7,11 +7,19 @@ OBJDIR = bld
 HAVE_NPTL ?= yes
 
 ifeq ($(HAVE_NPTL),yes)
-sources = cyclictest.c pi_stress.c pip_stress.c pmqtest.c rt-migrate-test.c
+sources = cyclictest.c \
+	  hackbench.c \
+	  pip_stress.c \
+	  pi_stress.c \
+	  pmqtest.c \
+	  ptsematest.c \
+	  rt-migrate-test.c \
+	  signaltest.c \
+	  sigwaittest.c \
+	  svsematest.c
 endif
 
-sources += signaltest.c ptsematest.c sigwaittest.c svsematest.c sendme.c \
-	  hackbench.c
+sources += sendme.c
 
 TARGETS = $(sources:.c=)
 
-- 
2.1.4

