From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Add man page for rt-migrate-test
Date: Thu, 21 Apr 2016 23:13:37 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1604212311530.11619@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36355 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbcDUVNk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Apr 2016 17:13:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id l6so24617284wml.3
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Apr 2016 14:13:39 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 02d556361267f8335b2417bbb62ef6a498da112c Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 21 Apr 2016 23:10:26 +0200
Subject: [PATCH] rt-tests: Add man page for rt-migrate-test

Added a man page for rt-migrate-test
Fairly minimal, based on the output from the --help option

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.8 | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 src/rt-migrate-test/rt-migrate-test.8

diff --git a/src/rt-migrate-test/rt-migrate-test.8 b/src/rt-migrate-test/rt-migrate-test.8
new file mode 100644
index 000000000000..8af50e54291d
--- /dev/null
+++ b/src/rt-migrate-test/rt-migrate-test.8
@@ -0,0 +1,56 @@
+.\"
+.TH RT-MIGRATE-TEST 8 "April 21, 2016"
+.\" Please adjust this date whenever editing this manpage
+.SH NAME
+rt-migrate-test \- real-time task migration program
+.SH SYNOPSIS
+.B rt-migrate-test 
+.RI "[\-ceh] [\-p prio] [\-r time] [\-s time] [\-m time] [\-l loops] [nr_tasks]
+.SH DESCRIPTION
+Test real-time multiprocessor scheduling of tasks to ensure the highest priority tasks are running on all available CPUs
+.SH OPTIONS
+This program follows the usual GNU command line syntax, with long options starting with two dashes ('\-\-').
+.br
+.TP
+In the summary of options, a value in brackets (), indicates a default value
+.br
+.TP
+.B \-p, \-\-prio=prio
+base priority to start RT tasks with (2)
+.br
+.TP
+.B \-r, \-\-run\-time=time
+Run time (ms) to busy loop the threads (20)
+.br
+.TP
+.B \-s, \-\-sleep\-time=time
+Sleep time (ms) between intervals (100)
+.br
+.TP
+.B \-m, \-\-maxerr=time
+Max allowed error (microsecs)
+.br
+.TP
+.B \-l \-\-loops=loops
+Number of iterations to run (50)
+.br
+.TP
+.B \-e
+Use equal prio for #CPU-1 tasks (requires > 2 CPUS)
+.br
+.TP
+.B \-c, \-\-check
+Stop if lower prio task is quicker than higher (off)
+.br
+.TP
+.B \-h, \-\-help
+Display usage
+.br
+.TP
+.B [nr\-tasks]
+number of tasks to run (number of cpus + 1)
+.br
+.SH AUTHOR
+rt-migrate-test was written by Steven Rostedt <srostedt@redhat.com>
+.TP
+This manual page was written by John Kacur <jkacur@redhat.com>
-- 
2.4.11

