Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FD4C433E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 09:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3A823104
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 09:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbhAZJXD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 04:23:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:58998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389533AbhAZJT4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 04:19:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 930A3B292;
        Tue, 26 Jan 2021 09:15:07 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v3 16/16] rt-tests: Rename error.h to rt-error.h
Date:   Tue, 26 Jan 2021 10:15:00 +0100
Message-Id: <20210126091500.31735-17-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126091500.31735-1-dwagner@suse.de>
References: <20210126091500.31735-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Avoid confusion with the system header called error.h.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c         | 2 +-
 src/include/pip_stress.h            | 5 +++--
 src/include/{error.h => rt-error.h} | 0
 src/lib/error.c                     | 2 +-
 src/lib/rt-numa.c                   | 2 +-
 src/lib/rt-utils.c                  | 3 ++-
 src/oslat/oslat.c                   | 2 +-
 src/pi_tests/pi_stress.c            | 3 +--
 src/pmqtest/pmqtest.c               | 6 +++---
 src/ptsematest/ptsematest.c         | 6 +++---
 src/sched_deadline/cyclicdeadline.c | 6 +++---
 src/signaltest/signaltest.c         | 2 +-
 src/sigwaittest/sigwaittest.c       | 2 +-
 src/svsematest/svsematest.c         | 3 ++-
 14 files changed, 23 insertions(+), 21 deletions(-)
 rename src/include/{error.h => rt-error.h} (100%)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f912bcf82def..c4b2369bee6b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -36,7 +36,7 @@
 
 #include "rt-utils.h"
 #include "rt-numa.h"
-#include "error.h"
+#include "rt-error.h"
 
 #include <bionic.h>
 
diff --git a/src/include/pip_stress.h b/src/include/pip_stress.h
index ee8b545ab117..f03aaf397897 100644
--- a/src/include/pip_stress.h
+++ b/src/include/pip_stress.h
@@ -14,8 +14,9 @@
 #include <sys/wait.h>
 #include <signal.h>
 #include <sched.h>
-#include <rt-utils.h>
-#include "error.h"
+
+#include "rt-utils.h"
+#include "rt-error.h"
 
 void low(pid_t pid);	/* low priority process */
 void medium(void);	/* medium priority process */
diff --git a/src/include/error.h b/src/include/rt-error.h
similarity index 100%
rename from src/include/error.h
rename to src/include/rt-error.h
diff --git a/src/lib/error.c b/src/lib/error.c
index 4434a842da17..616f70b044e0 100644
--- a/src/lib/error.c
+++ b/src/lib/error.c
@@ -5,7 +5,7 @@
  * error routines, similar to those found in
  * Advanced Programming in the UNIX Environment 2nd ed.
  */
-#include "error.h"
+#include "rt-error.h"
 
 /* Print an error message, plus a message for err and exit with error err */
 void err_exit(int err, char *fmt, ...)
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 04f2e9adb4b1..4a0865715141 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -10,7 +10,7 @@
 #include <sched.h>
 #include <pthread.h>
 
-#include "error.h"
+#include "rt-error.h"
 #include "rt-numa.h"
 
 int get_available_cpus(struct bitmask *cpumask)
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 2d68d62cd875..321a11b1172d 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -20,9 +20,10 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <sys/syscall.h> /* For SYS_gettid definitions */
+
 #include "rt-utils.h"
 #include "rt-sched.h"
-#include "error.h"
+#include "rt-error.h"
 
 #define  TRACEBUFSIZ  1024
 
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 0811079d9f04..9e6f70600830 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -43,7 +43,7 @@
 
 #include "rt-utils.h"
 #include "rt-numa.h"
-#include "error.h"
+#include "rt-error.h"
 
 #ifdef __GNUC__
 # define atomic_inc(ptr)   __sync_add_and_fetch((ptr), 1)
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 538d12c975aa..49f89b7b0136 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -47,8 +47,7 @@
 
 #include "rt-sched.h"
 #include "rt-utils.h"
-
-#include "error.h"
+#include "rt-error.h"
 
 /* test timeout */
 #define TIMEOUT 2
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 5f7a24d55db6..349b47741003 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -21,11 +21,11 @@
 #include <linux/unistd.h>
 #include <utmpx.h>
 #include <mqueue.h>
+#include <pthread.h>
+
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
-#include "error.h"
-
-#include <pthread.h>
+#include "rt-error.h"
 
 #define SYNCMQ_NAME "/syncmsg%d"
 #define TESTMQ_NAME "/testmsg%d"
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index f8f075591f4b..7d4ca97773d6 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -19,11 +19,11 @@
 #include <sys/mman.h>
 #include <linux/unistd.h>
 #include <utmpx.h>
+#include <pthread.h>
+
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
-#include "error.h"
-
-#include <pthread.h>
+#include "rt-error.h"
 
 enum {
 	AFFINITY_UNSPECIFIED,
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 6dcfd6074085..71cde5781499 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -30,9 +30,9 @@
 #include <linux/unistd.h>
 #include <linux/magic.h>
 
-#include <rt-utils.h>
-#include <rt-sched.h>
-#include <error.h>
+#include "rt-utils.h"
+#include "rt-sched.h"
+#include "rt-error.h"
 
 #define _STR(x) #x
 #define STR(x) _STR(x)
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 5427db7f8d85..c34bc994d886 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -31,7 +31,7 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 
-#include "error.h"
+#include "rt-error.h"
 #include "rt-utils.h"
 #include "rt-numa.h"
 
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 7e287bd2424f..f10c24914d4a 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -42,7 +42,7 @@
 
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
-#include "error.h"
+#include "rt-error.h"
 
 enum {
 	AFFINITY_UNSPECIFIED,
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 7388efb3f488..7a298e0dea8c 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -28,9 +28,10 @@
 #include <sys/sem.h>
 #include <sys/time.h>
 #include <sys/mman.h>
+
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
-#include "error.h"
+#include "rt-error.h"
 
 #define SEM_WAIT_FOR_RECEIVER 0
 #define SEM_WAIT_FOR_SENDER 1
-- 
2.30.0

