From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] man page for pip_stress
Date: Mon, 27 Jun 2011 14:41:48 +0200
Message-ID: <1309178508-7392-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37068 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab1F0Ml7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jun 2011 08:41:59 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The Debian package checker lintian criticizes that pip_stress doesn't h=
ave a
man page. So put a short version of the description from the source fil=
e
into a man page to make lintian happy.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello Clark,

you can pull this branch and the buffer overflow fix from

	git://git.pengutronix.de/git/ukl/rt-tests.git for-clark

Best regards
Uwe

 Makefile                  |    1 +
 src/pi_tests/pip_stress.8 |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 src/pi_tests/pip_stress.8

diff --git a/Makefile b/Makefile
index 48bef8a..2dd065f 100644
--- a/Makefile
+++ b/Makefile
@@ -122,6 +122,7 @@ install: all
 	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4=
=2Egz"
 	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclic=
test.8.gz"
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress=
=2E8.gz"
+	gzip src/pi_tests/pip_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pip_stre=
ss.8.gz"
 	gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwla=
tdetect.8.gz"
 	gzip src/ptsematest/ptsematest.8 -c >"$(DESTDIR)$(mandir)/man8/ptsema=
test.8.gz"
 	gzip src/sigwaittest/sigwaittest.8 -c >"$(DESTDIR)$(mandir)/man8/sigw=
aittest.8.gz"
diff --git a/src/pi_tests/pip_stress.8 b/src/pi_tests/pip_stress.8
new file mode 100644
index 0000000..b733335
--- /dev/null
+++ b/src/pi_tests/pip_stress.8
@@ -0,0 +1,25 @@
+.TH pip_stress 8 2011-06-24
+.SH NAME
+pip_stress \- test priority inheritance between processes
+.SH SYNOPSIS
+.B pip_stress
+.SH DESCRIPTION
+.B pip_stress
+creates a priority inversion using three processes and a priority inhe=
ritance
+mutex shared via shared memory.
+All three processes are bound to run on the same cpu.
+The process with the lowest priority holds a mutex and is prempted by =
the
+medium priority process that just runs an infinite loop.
+The third process with the highest priority tries to grab the mutex th=
at is
+hold by the low prio process.
+As a priority inheritance mutex is used the low priority process lends=
 the high
+priority process' priority to unlock the mutex and so stops the medium=
 priority
+process blocking the high priority one.
+
+.B pip_stress
+doesn't take any options and quits as soon as the priority inversion i=
s
+resolved which should happen instantly.
+
+.SH AUTHOR
+.B pip_stress
+was written by John Kacur <jkacur@redhat.com>.
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
