From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/7] Make use of the library functions in cyclic test.
Date: Mon, 14 Dec 2009 16:58:51 +0100
Message-ID: <1260806336-4691-3-git-send-email-jkacur@redhat.com>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
 <1260806336-4691-2-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <carsten.emde@osadl.org>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47045 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559AbZLNP7X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 10:59:23 -0500
Received: by bwz27 with SMTP id 27so2113610bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 07:59:21 -0800 (PST)
In-Reply-To: <1260806336-4691-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Carsten Emde <carsten.emde@osadl.org>

Signed-off-by: Carsten Emde <carsten.emde@osadl.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                    |    6 ++-
 src/cyclictest/cyclictest.c |   84 ++++++------------------------------------
 2 files changed, 16 insertions(+), 74 deletions(-)

diff --git a/Makefile b/Makefile
index d0c4da0..2bb0009 100644
--- a/Makefile
+++ b/Makefile
@@ -8,17 +8,19 @@ prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man/man8
 
-CFLAGS = -Wall -Wno-nonnull
+CFLAGS = -Wall -Wno-nonnull -Isrc/lib
 ifndef DEBUG
 	CFLAGS	+= -O2
 else
 	CFLAGS	+= -O0 -g
 endif
 
+UTILS	= src/lib/rt-utils.o
+
 .PHONY: all
 all: $(TARGETS)
 
-cyclictest: src/cyclictest/cyclictest.c
+cyclictest: src/cyclictest/cyclictest.c $(UTILS)
 	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
 
 signaltest: src/signaltest/signaltest.c
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 24d4d83..811ce9f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -33,6 +33,8 @@
 #include <sys/utsname.h>
 #include <sys/mman.h>
 
+#include "rt-utils.h"
+
 #ifndef SCHED_IDLE
 #define SCHED_IDLE 5
 #endif
@@ -166,12 +168,7 @@ static struct kvars {
 	char value[KVALUELEN];
 } kv[KVARS];
 
-#define _STR(x) #x
-#define STR(x) _STR(x)
-#define MAX_PATH 256
-
 static char *procfileprefix = "/proc/sys/kernel/";
-static char debugfileprefix[MAX_PATH];
 static char *fileprefix;
 static char tracer[MAX_PATH];
 static char **traceptr;
@@ -193,38 +190,6 @@ enum {
 static char functiontracer[MAX_PATH];
 static char traceroptions[MAX_PATH];
 
-/*
- * Finds the tracing directory in a mounted debugfs
- */
-static int set_debugfileprefix(void)
-{
-	char type[100];
-	FILE *fp;
-	int size;
-
-	if ((fp = fopen("/proc/mounts","r")) == NULL)
-		return ERROR_GENERAL;
-
-	while (fscanf(fp, "%*s %"
-		      STR(MAX_PATH)
-		      "s %99s %*s %*d %*d\n",
-		      debugfileprefix, type) == 2) {
-		if (strcmp(type, "debugfs") == 0)
-			break;
-	}
-	fclose(fp);
-
-	if (strcmp(type, "debugfs") != 0)
-		return ERROR_NOTFOUND;
-
-	size = strlen(debugfileprefix);
-	size = MAX_PATH - size;
-
-	strncat(debugfileprefix, "/tracing/", size);
-
-	return 0;
-}
-
 static int kernvar(int mode, const char *name, char *value, size_t sizeofvalue)
 {
 	char filename[128];
@@ -370,11 +335,12 @@ static int settracer(char *tracer)
 	int ret = -1;
 	int len;
 	const char *delim = " \t\n";
+	char *prefix = get_debugfileprefix();
 
 	/* Make sure tracer is available */
-	strncpy(filename, debugfileprefix, sizeof(filename));
+	strncpy(filename, prefix, sizeof(filename));
 	strncat(filename, "available_tracers", 
-		sizeof(filename) - strlen(debugfileprefix));
+		sizeof(filename) - strlen(prefix));
 
 	fp = fopen(filename, "r");
 	if (!fp)
@@ -410,10 +376,8 @@ static void setup_tracer(void)
 	if (kernelversion == KV_26_CURR) {
 		char testname[MAX_PATH];
 
-		set_debugfileprefix();
-		fileprefix = debugfileprefix;
-
-		strcpy(testname, debugfileprefix);
+		fileprefix = get_debugfileprefix();
+		strcpy(testname, fileprefix);
 		strcat(testname, "tracing_enabled");
 		if (access(testname, R_OK)) {
 			fprintf(stderr, "ERROR: %s not found\n"
@@ -436,7 +400,7 @@ static void setup_tracer(void)
 			setkernvar("ftrace_enabled", "1");
 		else
 			setkernvar("ftrace_enabled", "0");
-		fileprefix = debugfileprefix;
+		fileprefix = get_debugfileprefix;
 
 		switch (tracetype) {
 		case NOTRACE:
@@ -758,11 +722,13 @@ out:
 static void display_help(int error)
 {
 	char tracers[MAX_PATH];
+	char *prefix;
 
-	if (set_debugfileprefix())
+	prefix = get_debugfileprefix();
+	if (prefix[0] == '\0')
 		strcpy(tracers, "unavailable (debugfs not mounted)");
 	else {
-		fileprefix = debugfileprefix;
+		fileprefix = prefix;
 		if (kernvar(O_RDONLY, "available_tracers", tracers, sizeof(tracers)))
 			strcpy(tracers, "none");
 	}
@@ -1176,32 +1142,6 @@ static void print_stat(struct thread_param *par, int index, int verbose)
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
-	param.sched_priority = 0;
-	sched_setscheduler(0, policy, &param);
-	return 0;
-}
