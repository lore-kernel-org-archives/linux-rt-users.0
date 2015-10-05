From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] signaltest: Add a man page to signaltest
Date: Mon, 5 Oct 2015 16:11:39 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510051610540.14006@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37428 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbJEOLp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 10:11:45 -0400
Received: by wicfx3 with SMTP id fx3so116399238wic.0
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 07:11:44 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 7d22087c84a612b6221c7addfc53ac79ab1bc4f7 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 1 Oct 2015 11:20:25 +0200
Subject: [PATCH] signaltest: Add a man page to signaltest

- Add a man page to signaltest
- Improve the display_help in signaltest
- Add install of new man page to makefile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                    |  1 +
 src/signaltest/signaltest.8 | 48 +++++++++++++++++++++++++++++++++++++++++++++
 src/signaltest/signaltest.c | 19 +++++++++---------
 3 files changed, 59 insertions(+), 9 deletions(-)
 create mode 100644 src/signaltest/signaltest.8

diff --git a/Makefile b/Makefile
index 35a7d5a83fec..6e6ac1350fb2 100644
--- a/Makefile
+++ b/Makefile
@@ -192,6 +192,7 @@ install: all install_hwlatdetect
 	gzip -c src/pmqtest/pmqtest.8 >"$(DESTDIR)$(mandir)/man8/pmqtest.8.gz"
 	gzip -c src/backfire/sendme.8 >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
 	gzip -c src/hackbench/hackbench.8 >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
+	gzip -c src/signaltest/signaltest.8 >"$(DESTDIR)$(mandir)/man8/signaltest.8.gz"
 
 .PHONY: install_hwlatdetect
 install_hwlatdetect: hwlatdetect
diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
new file mode 100644
index 000000000000..d6c11c213e11
--- /dev/null
+++ b/src/signaltest/signaltest.8
@@ -0,0 +1,48 @@
+.\"
+.TH SIGNALTEST 8 "October 1, 2015"
+.\" Please adjust this date whenever updating this manpage
+.SH NAME
+signaltest \- signal roundtrip test software
+.SH SYNOPSIS
+.B signaltest
+.RI "[ \-b USEC ] [ \-l LOOPS ] [ \-p PRIO] [ \-q ] [ \-t NUM ] [ \-m ] [ \-v ] [ \-\-help ]"
+.SH OPTIONS
+These programs follow the usual GNU command line syntax, with long options
+starting with two dashes ('\-\-').
+.TP
+.B \-b, \-\-breaktrace=USEC
+Send break trace command whn latency > USEC
+.TP
+.B \-l, \-\-loops=LOOPS
+Number of loops: default=0 (endless)
+.TP
+.B \-p, \-\-priority=PRIO
+Priority of highest priority thread
+.TP
+.B \-q, \-\-quiet
+print a summary only on exit
+.TP
+.B \-t, \-\-threads=NUM
+number of threads: default=2
+.TP
+.B \-m, \-\-mlockall
+lock current and future memory allocations
+.TP
+.B \-v, \-\-verbose
+output values on stdout for statistics
+.br
+format: n:c:v n=tasknum c=count v=value in us
+.TP
+.B \-\-help
+display usage information
+.SH AUTHOR
+signaltest was written by Thomas Gleixner <tglx@linuxtronix.de>.
+.PP
+This manual page was originally written by
+.br
+John Kacur <jkacur@redhat.com>
+.PP
+Copying and distribution of this file, with or without modification,
+are permitted in any medium without royalty provided the copyright
+notice and this notice are preserved.  This file is offered as-is,
+without any warranty.
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 2ee1929f135b..b80969b021e3 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -205,15 +205,16 @@ static void display_help(void)
 {
 	printf("signaltest V %1.2f\n", VERSION);
 	printf("Usage:\n"
-	       "signaltest <options>\n\n"
-	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
-	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
-	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
-	       "-q       --quiet           print only a summary on exit\n"
-	       "-t NUM   --threads=NUM     number of threads: default=2\n"
-	       "-m       --mlockall        lock current and future memory allocations\n"
-	       "-v       --verbose         output values on stdout for statistics\n"
-	       "                           format: n:c:v n=tasknum c=count v=value in us\n");
+		"signaltest <options>\n\n"
+		"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
+		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
+		"-q       --quiet           print a summary only on exit\n"
+		"-t NUM   --threads=NUM     number of threads: default=2\n"
+		"-m       --mlockall        lock current and future memory allocations\n"
+		"-v       --verbose         output values on stdout for statistics\n"
+		"                           format: n:c:v n=tasknum c=count v=value in us\n"
+		"--help			    display usage information\n");
 	exit(0);
 }
 
-- 
2.4.3

