Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD3C32753
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 13:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A452083B
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 13:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNLy9nEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHNNuZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:50:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34687 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfHNNuZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 09:50:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so111210490wrm.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Aug 2019 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IyWq8mvkUWCIs0zltd7gF1mBt9oHOdeYd6XrX++Sth8=;
        b=ZNLy9nEcG8MOmwdJDXdaAmVEGcrQqJeKAmZFbHwopPPcvW0QJ1fdmWrL4H/EdCvJCv
         pfbPLt5ye1Ef0XSgFw7lYAomsJI1ipalNi1BO/oRhDIYqw9iygcHfQoZvwxnQGxsIofG
         SDlT+xfelxEwaG8rcGi1Esws4/MznODQX/fJbadLMdMbQvKoK2nchbJL8N/ZXxNGArC5
         m1QGZ4byq91NzJasBPbzyuayWjiuzMyftQaVqsW1BI5JPDZ54FzHNlytI9lzSr3Pz6LZ
         nQR1mzgVQgE6vhsvjzIU3V24p/VT0fSLIhFJMWYAa7wp9gCp2a2JTj5ALDNYweTvVx1w
         SzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IyWq8mvkUWCIs0zltd7gF1mBt9oHOdeYd6XrX++Sth8=;
        b=eUxlrHzwWQ6ZRE4zRBDbEjAS6+Yxl8wYiWa/L9f/yySHHzTM7Hyhg2xiLHoedTStc3
         ydkjXej65wyefSzzq6aGhFQZ87Rq7Mkczpz2dCWNnYvg31x3PaC+p8fP+hWtSoc31vex
         iwvsNpRN8mwfGrHdGMn3QwhLu4vnC+GVHXjpIUQDE9MGsz2Fu9XABtZX5fth0n5O//vK
         U6D1SfHHCV5WGtH9ZXT8Z63lVZBgaLHUTXuTtLMFquy1QA/DWq60HZ0ta1iHdeT8c9Yo
         gSTC8fsUkcSjFSGaWjU7WuWVAua/toGjZEkL9omzDRL02rwKKJDyuqBvPe2lMxWiUkMb
         SZuA==
X-Gm-Message-State: APjAAAVlJO0VNCDpJ2HXEDidAY7p5Dt56taq/ByPzmiQEI3Yb+x7DyP+
        L3xk9ejtKqeX46VMVj6IYcjDbiTI+cc=
X-Google-Smtp-Source: APXvYqxw0Y58jRyM05oXc7XJ2XI+7b7jqTe9Pden2v88AGD/0BQwinVDiYysX66ejx3BWucFSfwgDg==
X-Received: by 2002:a5d:6acd:: with SMTP id u13mr16278355wrw.257.1565790621938;
        Wed, 14 Aug 2019 06:50:21 -0700 (PDT)
Received: from planxty.redhat.com ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id i66sm7837220wmi.11.2019.08.14.06.50.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 06:50:21 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rt-tests: hwlatdetect: Remove kmodule options and clean-up help
Date:   Wed, 14 Aug 2019 15:50:08 +0200
Message-Id: <20190814135009.5954-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

hwlatdetect has used the ftrace hwlatdetector for quite sometime. When
we first moved away from our own kernel module, it was still possible to
force the use of the module for testing. This was useful for development
but is no longer supported. This patch does the following things.

- Remove references to the kmodule from the help option and the man
page.
- Remove support from the program to force loading of the module.
- Cleans up some differences between the manpage and the program help,
for example, adds the --hardlimit option to man page and removes the
--cleanup of the kmodule option

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.8  | 43 +++++++++++++++++-----------------
 src/hwlatdetect/hwlatdetect.py | 12 +---------
 2 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.8 b/src/hwlatdetect/hwlatdetect.8
index 645fb7d8e6c1..df331800d5cf 100644
--- a/src/hwlatdetect/hwlatdetect.8
+++ b/src/hwlatdetect/hwlatdetect.8
@@ -13,12 +13,13 @@
 .\" .sp <n>    insert n+1 empty lines
 .\" for manpage-specific macros, see man(7)
 .SH NAME
-hwlatdetect \- program to control the kernel hardware latency detection module
+hwlatdetect \- program to control the ftrace kernel hardware latency detection
 .SH SYNOPSIS
 .B hwlatdetect
 .RI "[ \-\-duration=<time> ] [\-\-threshold=<usecs> ] \
-[\-\-window=<time interval> ] [\-\-width=<time interval> ] [\-\-report=<path> ] \
-[\-\-cleanup ] [\-\-debug ] [\-\-quiet ] [--watch]
+[\-\-window=<time interval> ] [\-\-width=<time interval> ] \
+[\-\-hardlimit=<microsecond value> ] [\-\-report=<path> ] \
+[\-\-debug ] [\-\-quiet ] [--watch]
 
 .\" .SH DESCRIPTION
 .\" This manual page documents briefly the
@@ -27,15 +28,14 @@ hwlatdetect \- program to control the kernel hardware latency detection module
 .\" \fI<whatever>\fP escape sequences to invoke bold face and italics, respectively.
 .\" \fBhwlatdetect\fP is a program that...
 .SH DESCRIPTION
-\fBhwlatdetect\fP is a program that controls the kernel hardware
-latency detector module (hwlat_detector.ko). The module is a special
-purpose kernel module that is used to detect large system latencies
-induced by the behavior of certain underlying hardware or firmware,
-independent of Linux itself. The code was developed originally to
-detect SMIs (System Management Interrupts) on x86 systems, however
-there is nothing x86 specific about this patchset. It was originally
-written for use by the "RT" patch since the Real Time kernel is highly
-latency sensitive. 
+\fBhwlatdetect\fP is a program that controls the ftrace kernel hardware
+latency detector (hwlatdetector).hwlatdetector is used to detect large
+system latencies induced by the behavior of certain underlying hardware
+or firmware, independent of Linux itself.
+The code was developed originally to detect SMIs (System Management Interrupts)
+on x86 systems, however there is nothing x86 specific about it.
+It was originally written for use by the "RT" patch set
+since the Real Time kernel is highly latency sensitive. 
 
 SMIs are usually not serviced by the Linux kernel, which typically does not
 even know that they are occurring. SMIs are instead are set up by BIOS code
@@ -45,7 +45,7 @@ other tasks and those tasks can spend an inordinate amount of time in the
 handler (sometimes measured in milliseconds). Obviously this is a problem if
 you are trying to keep event service latencies down in the microsecond range.
 
-The hardware latency detector module works by hogging all of the cpus
+The ftrace hardware latency detector works by hogging all of the cpus
 for configurable amounts of time (by calling stop_machine()), polling
 the CPU Time Stamp Counter for some period, then looking for gaps in
 the TSC data. Any gap indicates a time when the polling was
@@ -53,10 +53,9 @@ interrupted and since the machine is stopped and interrupts turned off
 the only thing that could do that would be an SMI. 
 
 The hwlatdetector script manages the mounting/unmounting of the
-debugfs as well as the loading/unloading of the hwlat_detector
-module. If the debugfs is already mounted then hwlatdetector will not
-unmount it after a run. Likewise, if the hwlat_detector module is
-already loaded, it will not be unloaded after a run. 
+debugfs as well as interacting with the ftrace hwlatdetector
+If the debugfs is already mounted then hwlatdetector will not
+unmount it after a run.
 
 .SH OPTIONS
 .TP
@@ -70,10 +69,15 @@ optional suffix may be specified to indicate minutes, hours or days.
 Specify the TSC gap used to detect an SMI. Any gap value greater than
 <threshold> is considered to be the result of an SMI occurring. 
 
+.TP
+.B \-\-hardlimit=<microsecond value>
+The test is considered to fail if a value above the hardlimit occurs.
+This affects the exit value of hwlatdetect
+
 .TP
 .B \-\-window=<time value>{us,ms,s,m,d}
 specify the size of the sample window. Converted to microseconds when
-passed to the kernel module.
+passed to the kernel.
 
 .TP
 .B \-\-width=<time value>{us,ms,s,m,d}
@@ -84,9 +88,6 @@ actually sampling. Must be less than the \-\-window value.
 Specify the output filename of the detector report. Default
 behavior is to print to standard output
 .TP
-.B \-\-cleanup
-Force unload of hwlat_detector.ko and unmounting of debugfs filesystem.
-.TP
 .B \-\-debug
 Turn on debug prints
 .TP
diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index b72bdc3aa930..c11a6f8ea5b1 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -542,10 +542,6 @@ if __name__ == '__main__':
                         dest="watch",
                         help="print sample data to stdout as it arrives")
 
-    parser.add_argument("--kmodule", action="store_true", default=False,
-                        dest="kmodule",
-                        help="force using the kernel module")
-
     args = parser.parse_args()
 
     # need these before creating detector instance
@@ -558,13 +554,7 @@ if __name__ == '__main__':
         quiet = True
         debugging = False
 
-    if args.kmodule:
-        detect = Hwlat()
-    else:
-        try:
-            detect = Tracer()
-        except DetectorNotAvailable as err:
-            detect = HwLat()
+    detect = Tracer()
 
     if args.threshold:
         t = microseconds(args.threshold)
-- 
2.20.1

