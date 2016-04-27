From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
Subject: [PATCH rt-tests] manpages: fix typos found by lintian
Date: Wed, 27 Apr 2016 08:51:35 +0200
Message-ID: <1461739895-4147-1-git-send-email-ukleinek@debian.org>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:33954 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641AbcD0HA7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Apr 2016 03:00:59 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This fixes these spelling errors:

	mutiple -> multiple
	occuring -> occurring
	specifed -> specified
	synchonized -> synchronized

---
BTW, I wonder if the manpages are using dos line endings on purpose.

 src/hwlatdetect/hwlatdetect.8 | 4 ++--
 src/pi_tests/README           | 2 +-
 src/pmqtest/pmqtest.8         | 2 +-
 src/ptsematest/ptsematest.8   | 2 +-
 src/sigwaittest/sigwaittest.8 | 4 ++--
 src/svsematest/svsematest.8   | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.8 b/src/hwlatdetect/hwlatdetect.8
index 2904e5fd8fde..6f5501445ce1 100644
--- a/src/hwlatdetect/hwlatdetect.8
+++ b/src/hwlatdetect/hwlatdetect.8
@@ -38,7 +38,7 @@ written for use by the "RT" patch since the Real Time kernel is highly
 latency sensitive. 
 
 SMIs are usually not serviced by the Linux kernel, which typically does not
-even know that they are occuring. SMIs are instead are set up by BIOS code
+even know that they are occurring. SMIs are instead are set up by BIOS code
 and are serviced by BIOS code, usually for "critical" events such as
 management of thermal sensors and fans. Sometimes though, SMIs are used for
 other tasks and those tasks can spend an inordinate amount of time in the
@@ -68,7 +68,7 @@ optional suffix may be specified to indicate minutes, hours or days.
 .TP
 .B \-\-threshold=<microsecond value>
 Specify the TSC gap used to detect an SMI. Any gap value greater than
-<theshold> is considered to be the result of an SMI occuring. 
+<theshold> is considered to be the result of an SMI occurring.
 
 .TP
 .B \-\-window=<time value>{us,ms,s,m,d}
diff --git a/src/pi_tests/README b/src/pi_tests/README
index 6b2850d6b970..f40b972db716 100644
--- a/src/pi_tests/README
+++ b/src/pi_tests/README
@@ -74,7 +74,7 @@ that have been performed. To stop the test, press any key and a
 summary will be printed to show how many inversions were performed and
 how long the test ran.
 
-To run the test for a specifed time, use the --duraton=<seconds>
+To run the test for a specified time, use the --duraton=<seconds>
 option.
 
 
diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
index 6e9719815165..5e00ff8596e7 100644
--- a/src/pmqtest/pmqtest.8
+++ b/src/pmqtest/pmqtest.8
@@ -37,7 +37,7 @@ Set the priority of the process.
 Test mode for symmetric multi-processing, implies -a and -t and uses the same priority on all threads.
 .TP
 .B \-t, \-\-threads[=NUM]
-Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specifed, NUM is set to the number of available CPUs.
+Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specified, NUM is set to the number of available CPUs.
 .TP
 .B \-T, \-\-timeout=TO
 Use mq_timedreceive() instead of mq_receive() and specify timeout TO in seconds.
diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
index 001e80936349..f4af37c1a7b5 100644
--- a/src/ptsematest/ptsematest.8
+++ b/src/ptsematest/ptsematest.8
@@ -31,7 +31,7 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 Set the priority of the process.
 .TP
 .B \-t, \-\-threads[=NUM]
-Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specifed, NUM is set to the number of available CPUs.
+Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specified, NUM is set to the number of available CPUs.
 .SH "EXAMPLES"
 The following example was running on a 4-way processor:
 .LP
diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittest.8
index 89a97f1e7557..078f33a7c81c 100644
--- a/src/sigwaittest/sigwaittest.8
+++ b/src/sigwaittest/sigwaittest.8
@@ -8,7 +8,7 @@ sigwaittest [-a|-a PROC] [-b USEC] [-d DIST] [-f] [-i INTV] [-l loops] [-p PRIO]
 .br
 .SH "DESCRIPTION"
 .LP
-The program \fBsigwaittest\fR starts two threads or, optionally, forks two processes that are synchonized via signals and measures the latency between sending a signal and returning from sigwait().
+The program \fBsigwaittest\fR starts two threads or, optionally, forks two processes that are synchronized via signals and measures the latency between sending a signal and returning from sigwait().
 .SH "OPTIONS"
 .TP
 .B \-a, \-\-affinity[=PROC]
@@ -34,7 +34,7 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 Set the priority of the process.
 .TP
 .B \-t, \-\-threads[=NUM]
-Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specifed, NUM is set to the number of available CPUs.
+Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specified, NUM is set to the number of available CPUs.
 .SH "EXAMPLES"
 The following example was running on a 4-way CPU:
 .LP
diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
index 93b163ea4dc0..14af8d431ece 100644
--- a/src/svsematest/svsematest.8
+++ b/src/svsematest/svsematest.8
@@ -34,7 +34,7 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 Set the priority of the process.
 .TP
 .B \-t, \-\-threads[=NUM]
-Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specifed, NUM is set to the number of available CPUs.
+Set the number of test threads (default is 1, if this option is not given). If NUM is specified, create NUM test threads. If NUM is not specified, NUM is set to the number of available CPUs.
 .SH "EXAMPLES"
 The following example was running on a 4-way CPU:
 .LP
-- 
2.8.0.rc3

