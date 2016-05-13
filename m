From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rt-tests: Add missing option to hwlatdetect man page
Date: Fri, 13 May 2016 15:11:52 +0200
Message-ID: <1463145113-9025-2-git-send-email-jkacur@redhat.com>
References: <1463145113-9025-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34310 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbcEMNMI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 May 2016 09:12:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so3625558wmn.1
        for <linux-rt-users@vger.kernel.org>; Fri, 13 May 2016 06:12:08 -0700 (PDT)
In-Reply-To: <1463145113-9025-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add --watch to the man page. Correct a few spelling errors at the same
time.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.8 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.8 b/src/hwlatdetect/hwlatdetect.8
index 2904e5fd8fde..645fb7d8e6c1 100644
--- a/src/hwlatdetect/hwlatdetect.8
+++ b/src/hwlatdetect/hwlatdetect.8
@@ -18,13 +18,13 @@ hwlatdetect \- program to control the kernel hardware latency detection module
 .B hwlatdetect
 .RI "[ \-\-duration=<time> ] [\-\-threshold=<usecs> ] \
 [\-\-window=<time interval> ] [\-\-width=<time interval> ] [\-\-report=<path> ] \
-[\-\-cleanup ] [\-\-debug ] [\-\-quiet ]
+[\-\-cleanup ] [\-\-debug ] [\-\-quiet ] [--watch]
 
 .\" .SH DESCRIPTION
 .\" This manual page documents briefly the
 .\" .B hwlatdetect commands.
 .\" .PP
-.\" \fI<whatever>\fP escape sequences to invode bold face and italics, respectively.
+.\" \fI<whatever>\fP escape sequences to invoke bold face and italics, respectively.
 .\" \fBhwlatdetect\fP is a program that...
 .SH DESCRIPTION
 \fBhwlatdetect\fP is a program that controls the kernel hardware
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
+<threshold> is considered to be the result of an SMI occurring. 
 
 .TP
 .B \-\-window=<time value>{us,ms,s,m,d}
@@ -92,6 +92,10 @@ Turn on debug prints
 .TP
 .B \-\-quiet
 Turn off all information prints
+.TP
+.B \-\-watch
+print sample data to stdout as it arrives
+
 .\" .SH SEE ALSO
 .\" .BR bar (1),
 .\" .BR baz (1).
-- 
2.4.11

