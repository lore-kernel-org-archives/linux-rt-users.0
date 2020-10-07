Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81FCC41604
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7C12083B
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgJGI47 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:56:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:57534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgJGI46 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:56:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 110FCB158;
        Wed,  7 Oct 2020 08:56:57 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 01/18] rt-util: Move parse_cpumask from cyclictest
Date:   Wed,  7 Oct 2020 10:56:36 +0200
Message-Id: <20201007085653.11961-2-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007085653.11961-1-dwagner@suse.de>
References: <20201007085653.11961-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In order to be reuse the cpumask parsing code, move it to libary.
Several tools implement their own version of this. Let's use one
global one instead.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Makefile                    | 12 +++---
 src/cyclictest/cyclictest.c | 68 +++++++--------------------------
 src/include/rt-utils.h      |  3 ++
 src/lib/rt-utils.c          | 76 +++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 61 deletions(-)

diff --git a/Makefile b/Makefile
index c3ebbd7b2a2e..3627084437c1 100644
--- a/Makefile
+++ b/Makefile
@@ -20,9 +20,14 @@ sources = cyclictest.c \
 	  ssdd.c \
 	  oslat.c
 
+# You have to have libnuma installed, which is fine to do even if you are
+# running on non-numa machines
+CFLAGS += -DNUMA
+NUMA_LIBS = -lnuma
+
 TARGETS = $(sources:.c=)
 LIBS	= -lrt -lpthread
-RTTESTLIB = -lrttest -L$(OBJDIR)
+RTTESTLIB = -lrttest -L$(OBJDIR) $(NUMA_LIBS)
 EXTRA_LIBS ?= -ldl	# for get_cpu
 DESTDIR	?=
 prefix  ?= /usr/local
@@ -79,11 +84,6 @@ ostype := $(lastword $(subst -, ,$(dumpmachine)))
 machinetype := $(shell echo $(dumpmachine)| \
     sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
 
-# You have to have libnuma installed, which is fine to do even if you are
-# running on non-numa machines
-CFLAGS += -DNUMA
-NUMA_LIBS = -lnuma
-
 include src/arch/android/Makefile
 
 VPATH	= src/cyclictest:
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b41d42f13f24..02cb92813fb7 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -908,11 +908,6 @@ static int clocksources[] = {
 	CLOCK_REALTIME,
 };
 
-static unsigned int is_cpumask_zero(const struct bitmask *mask)
-{
-	return (rt_numa_bitmask_count(mask) == 0);
-}
-
 /* Get available cpus according to getaffinity or according to the
  * intersection of getaffinity and the user specified affinity
  * in the case of AFFINITY_SPECIFIED, the function has to be called
@@ -997,52 +992,6 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
 	return 0;
 }
 
-
-/* After this function is called, affinity_mask is the intersection of the user
- * supplied affinity mask and the affinity mask from the run time environment */
-static void use_current_cpuset(const int max_cpus)
-{
-	int i;
-	pid_t pid;
-	struct bitmask *curmask;
-
-	pid = getpid();
-
-	curmask = numa_allocate_cpumask();
-	numa_sched_getaffinity(pid, curmask);
-
-	/* Clear bits that are not set in both the cpuset from the environment,
-	 * and in the user specified affinity for cyclictest */
-	for (i=0; i < max_cpus; i++) {
-		if ((!rt_numa_bitmask_isbitset(affinity_mask, i)) || (!rt_numa_bitmask_isbitset(curmask, i))) {
-			numa_bitmask_clearbit(affinity_mask, i);
-		}
-	}
-
-	numa_bitmask_free(curmask);
-}
-
-static void parse_cpumask(const char *option, const int max_cpus)
-{
-	affinity_mask = rt_numa_parse_cpustring(option, max_cpus);
-	if (affinity_mask) {
-		if (is_cpumask_zero(affinity_mask)) {
-			rt_bitmask_free(affinity_mask);
-			affinity_mask = NULL;
-		} else {
-			use_current_cpuset(max_cpus);
-		}
-
-	}
-	if (!affinity_mask)
-		display_help(1);
-
-	if (verbose) {
-		printf("%s: Using %u cpus.\n", __func__,
-			rt_numa_bitmask_count(affinity_mask));
-	}
-}
-
 static void handlepolicy(char *polname)
 {
 	if (strncasecmp(polname, "other", 5) == 0)
@@ -1176,15 +1125,24 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			if (smp)
 				break;
 			numa_initialize();
-			if (optarg != NULL) {
-				parse_cpumask(optarg, max_cpus);
+			if (optarg) {
+				parse_cpumask(optarg, max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind<argc && (atoi(argv[optind]) || argv[optind][0] == '0' || argv[optind][0] == '!')) {
-				parse_cpumask(argv[optind], max_cpus);
+			} else if (optind < argc &&
+				   (atoi(argv[optind]) ||
+				    argv[optind][0] == '0' ||
+				    argv[optind][0] == '!')) {
+				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
 				setaffinity = AFFINITY_USEALL;
 			}
+
+			if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
+				display_help(1);
+			if (verbose)
+				printf("Using %u cpus.\n",
+					numa_bitmask_weight(affinity_mask));
 			break;
 		case 'A':
 		case OPT_ALIGNED:
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 4ed1cbc53ece..3b97655a20f2 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -3,6 +3,7 @@
 #define __RT_UTILS_H
 
 #include <stdint.h>
+#include <numa.h>
 
 #define _STR(x) #x
 #define STR(x) _STR(x)
@@ -28,6 +29,8 @@ uint32_t string_to_policy(const char *str);
 pid_t gettid(void);
 
 int parse_time_string(char *val);
+int parse_mem_string(char *str, uint64_t *val);
+int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
 
 void enable_trace_mark(void);
 void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index f786588706cd..302b91388df5 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -362,6 +362,82 @@ int parse_time_string(char *val)
 	return t;
 }
 
+int parse_mem_string(char *str, uint64_t *val)
+{
+	char *endptr;
+	int v = strtol(str, &endptr, 10);
+
+	if (!*endptr)
+		return v;
+
+	switch (*endptr) {
+	case 'g':
+	case 'G':
+		v *= 1024;
+	case 'm':
+	case 'M':
+		v *= 1024;
+	case 'k':
+	case 'K':
+		v *= 1024;
+	case 'b':
+	case 'B':
+		break;
+	default:
+		return -1;
+	}
+
+	*val = v;
+
+	return 0;
+}
+
+/*
+ * After this function is called, affinity_mask is the intersection of
+ * the user supplied affinity mask and the affinity mask from the run
+ * time environment
+ */
+static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
+{
+	struct bitmask *curmask;
+	int i;
+
+	curmask = numa_allocate_cpumask();
+	numa_sched_getaffinity(getpid(), curmask);
+
+	/*
+	 * Clear bits that are not set in both the cpuset from the
+	 * environment, and in the user specified affinity.
+	 */
+	for (i = 0; i < max_cpus; i++) {
+		if ((!numa_bitmask_isbitset(cpumask, i)) ||
+		    (!numa_bitmask_isbitset(curmask, i)))
+			numa_bitmask_clearbit(cpumask, i);
+	}
+
+	numa_bitmask_free(curmask);
+}
+
+int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
+{
+	struct bitmask *mask;
+
+	mask = numa_parse_cpustring_all(str);
+	if (!mask)
+		return -ENOMEM;
+
+	if (numa_bitmask_weight(mask) == 0) {
+		numa_bitmask_free(mask);
+		*cpumask = NULL;
+		return 0;
+	}
+
+	use_current_cpuset(max_cpus, mask);
+	*cpumask = mask;
+
+	return 0;
+}
+
 void open_tracemark_fd(void)
 {
 	char path[MAX_PATH];
-- 
2.28.0

