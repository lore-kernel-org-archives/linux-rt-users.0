From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests RFC 6/6] Move info, warn, and fatal functions to error.[ch]
Date: Thu, 22 Mar 2012 02:14:06 +0100
Message-ID: <1332378846-18104-7-git-send-email-jkacur@redhat.com>
References: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>,
	Darren Hart <dvhart@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nicholas McGuire <der.herr@hofr.at>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50419 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030377Ab2CVBPx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 21:15:53 -0400
Received: by wejx9 with SMTP id x9so1412830wej.19
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 18:15:52 -0700 (PDT)
In-Reply-To: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Move warning, error and fatal function to the error files.
This is a first step in cleaning up rt-tests.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/rt_numa.h    |    1 +
 src/include/error.h         |    3 +++
 src/include/rt-utils.h      |    5 -----
 src/lib/error.c             |   31 +++++++++++++++++++++++++++++++
 src/lib/rt-utils.c          |   32 +-------------------------------
 src/pmqtest/pmqtest.c       |    1 +
 src/ptsematest/ptsematest.c |    1 +
 src/svsematest/svsematest.c |    1 +
 8 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 2b91615..4ae10ee 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -15,6 +15,7 @@
 #define _RT_NUMA_H
 
 #include "rt-utils.h"
+#include "error.h"
 
 static int numa = 0;
 
diff --git a/src/include/error.h b/src/include/error.h
index 512b3a6..1e33f6c 100644
--- a/src/include/error.h
+++ b/src/include/error.h
@@ -10,6 +10,9 @@ void err_exit(int err, char *fmt, ...);
 void err_msg(char *fmt, ...);
 void err_msg_n(int err, char *fmt, ...);
 void err_quit(char *fmt, ...);
+void info(char *fmt, ...);
+void warn(char *fmt, ...);
+void fatal(char *fmt, ...);
 void err_doit(int err, const char *fmt, va_list ap);
 
 #endif	/* __ERROR_H */
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 316b09c..4a7d01f 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -1,7 +1,6 @@
 #ifndef __RT_UTILS_H
 #define __RT_UTILS_H
 
-
 #define _STR(x) #x
 #define STR(x) _STR(x)
 #define MAX_PATH 256
@@ -18,8 +17,4 @@ int event_disable(char *event);
 int event_enable_all(void);
 int event_disable_all(void);
 
-void warn(char *fmt, ...);
-void fatal(char *fmt, ...);
-void info(char *fmt, ...);
-
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/error.c b/src/lib/error.c
index e9fe58f..1b5de5d 100644
--- a/src/lib/error.c
+++ b/src/lib/error.c
@@ -46,6 +46,37 @@ void err_quit(char *fmt, ...)
 	exit(1);
 }
 
+void info(char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	fputs("INFO: ", stderr);
+	err_doit(0, fmt, ap);
+	va_end(ap);
+}
+
+void warn(char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	fputs("WARN: ", stderr);
+	err_doit(0, fmt, ap);
+	va_end(ap);
+}
+
+void fatal(char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	fputs("FATAL: ", stderr);
+	err_doit(0, fmt, ap);
+	va_end(ap);
+	exit(EXIT_FAILURE);
+}
+
 void err_doit(int err, const char *fmt, va_list ap)
 {
 	if (err)
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index ec71dbd..f4da4b3 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include "rt-utils.h"
+#include "error.h"
 
 static char debugfileprefix[MAX_PATH];
 
@@ -272,34 +273,3 @@ int check_privs(void)
 	return sched_setscheduler(0, policy, &old_param);
 }
 
-void info(char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	fputs("INFO: ", stderr);
-	vfprintf(stderr, fmt, ap);
-	va_end(ap);
-}
-
-void warn(char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	fputs("WARNING: ", stderr);
-	vfprintf(stderr, fmt, ap);
-	va_end(ap);
-}
-
-void fatal(char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	fputs("FATAL: ", stderr);
-	vfprintf(stderr, fmt, ap);
-	va_end(ap);
-	exit(EXIT_FAILURE);
-}
-
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 2ac6c55..b811d95 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -37,6 +37,7 @@
 #include <mqueue.h>
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
+#include "error.h"
 
 #include <pthread.h>
 
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 14c3f81..92f0ab5 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -36,6 +36,7 @@
 #include <utmpx.h>
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
+#include "error.h"
 
 #include <pthread.h>
 
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index d4ee1c4..89473a5 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -42,6 +42,7 @@
 #include <sys/mman.h>
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
+#include "error.h"
 
 #define gettid() syscall(__NR_gettid)
 
-- 
1.7.7.6

