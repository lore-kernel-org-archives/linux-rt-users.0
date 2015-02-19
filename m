From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [PATCH] all programs that are linked with -lrttest must depend on librttest.a
Date: Thu, 19 Feb 2015 20:59:09 +0100
Message-ID: <1424375949-9334-1-git-send-email-r.schwebel@pengutronix.de>
Cc: Michael Olbrich <m.olbrich@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47812 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbBST7t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Feb 2015 14:59:49 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Michael Olbrich <m.olbrich@pengutronix.de>

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 9e479d3c0dca..4ee553849cce 100644
--- a/Makefile
+++ b/Makefile
@@ -73,14 +73,14 @@ cyclictest: cyclictest.o librttest.a
 signaltest: signaltest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

-pi_stress: pi_stress.o
+pi_stress: pi_stress.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

 hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 	chmod +x src/hwlatdetect/hwlatdetect.py
 	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect

-rt-migrate-test: rt-migrate-test.o
+rt-migrate-test: rt-migrate-test.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

 ptsematest: ptsematest.o librttest.a
@@ -101,7 +101,7 @@ sendme: sendme.o librttest.a
 pip_stress: pip_stress.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

-hackbench: hackbench.o
+hackbench: hackbench.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

 librttest.a: rt-utils.o error.o rt-get_cpu.o rt-sched.o
