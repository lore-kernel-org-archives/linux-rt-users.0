From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/7] Make use of the new library functions in signaltest.
Date: Mon, 14 Dec 2009 16:58:52 +0100
Message-ID: <1260806336-4691-4-git-send-email-jkacur@redhat.com>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
 <1260806336-4691-2-git-send-email-jkacur@redhat.com>
 <1260806336-4691-3-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <carsten.emde@osadl.org>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44320 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578AbZLNP7Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 10:59:24 -0500
Received: by bwz27 with SMTP id 27so2113635bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 07:59:22 -0800 (PST)
In-Reply-To: <1260806336-4691-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Carsten Emde <carsten.emde@osadl.org>

Signed-off-by: Carsten Emde <carsten.emde@osadl.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                    |    2 +-
 src/signaltest/signaltest.c |   27 ++-------------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 2bb0009..2507a1f 100644
--- a/Makefile
+++ b/Makefile
@@ -23,7 +23,7 @@ all: $(TARGETS)
 cyclictest: src/cyclictest/cyclictest.c $(UTILS)
 	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
 
-signaltest: src/signaltest/signaltest.c
+signaltest: src/signaltest/signaltest.c $(UTILS)
 	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
 
 classic_pi: src/pi_tests/classic_pi.c
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index b637aae..e6016c9 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -27,6 +27,8 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 
+#include "rt-utils.h"
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /* Ugly, but .... */
@@ -306,31 +308,6 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 	}
 }
 
-static int
-check_privs(void)
-{
-	int policy = sched_getscheduler(0);
-	struct sched_param param;
-
-	/* if we're already running a realtime scheduler
-	 * then we *should* be able to change things later
-	 */
-	if (policy == SCHED_FIFO || policy == SCHED_RR)
-		return 0;
-
-	/* try to change to SCHED_FIFO */
-	param.sched_priority = 1;
-	if (sched_setscheduler(0, SCHED_FIFO, &param)) {
-		fprintf(stderr, "Unable to change scheduling policy!\n");
-		fprintf(stderr, "either run as root or join realtime group\n");
-		return 1;
-	}
-
-	/* we're good; change back and return success */
-	sched_setscheduler(0, policy, NULL);
-	return 0;
-}
