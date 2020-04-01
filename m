Return-Path: <SRS0=PGN5=5R=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D4C43331
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Apr 2020 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1220719
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Apr 2020 22:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZCFsVvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbgDAWNZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:13:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732537AbgDAWNZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Apr 2020 18:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585779202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ZrwyEdlC5EwQIM00PnZdXWmmFOvvzbXi+nFbEu+CCfE=;
        b=hZCFsVvPn8tjrJKvdU9T/r5H0xebpA2XFM8o749CFAIRRgfA5NzEGSXS5D93vuf6hLBPoU
        cVJVJ/3apN7Lk0/NQ/dFzt3xZ8903uiw4u7+2RAgw6OTI3CdNnmolBpJ84OJM4k8pPuQ+D
        SXf5gmgTJMk4YejWV3stjpQjb6ux6v8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-_N3SJCblOqiuIBt8kOglCQ-1; Wed, 01 Apr 2020 18:13:19 -0400
X-MC-Unique: _N3SJCblOqiuIBt8kOglCQ-1
Received: by mail-qk1-f199.google.com with SMTP id g13so279468qkk.11
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Apr 2020 15:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZrwyEdlC5EwQIM00PnZdXWmmFOvvzbXi+nFbEu+CCfE=;
        b=jZnW3EUNEGvI5fdN7MC5zaKoY5zP6DP4i6zRQbvfK651AhRaP/qtREybAMpQ0kwQ+K
         e2Ar6uq5NZiMlnZQMeDWultMK6kQBvcMs+6ctkNqWPUb9NzJUHP5ajYYoK8pRHWioV9W
         19/9ruBVRVU5OwlnXKfatvVGjSbS/Dw15T+z/cI+v8lMVpGK5qWClmvV8seNeJApANrD
         wcGht4evrHWFFM08EvZ4yuvcqdvU06kYtElV4cPR2Ndg4K3PiYfrbwhz6czOO2qGH/9x
         lkCX0vOZ5UZUW+KznbG3PaA9EJoFy1Lzsy5B8qGtiKlSgK7spHAfaFg4HbAiZUc9uejR
         cAyQ==
X-Gm-Message-State: AGi0PubobKeWjQwsJ6A19QSa8KeWp2t6tgFAOHxlmPhi+s6fUt8ZxaaT
        ESUMaIQTq6uSRCUVvSzh0NNKiRs8dsIthdDJ5IKJ9Ar07/gV/tOsUOezXvE5WB11x+4OGdI1qp0
        Z9YQT1oXG78ldq7oxctVdEJSo5B8=
X-Received: by 2002:a05:6214:327:: with SMTP id j7mr318685qvu.36.1585779198400;
        Wed, 01 Apr 2020 15:13:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOObPlDRubqi5LQieOUzSYfci6TFfj6b9/s8N9cS65YmqVH02MTvTYZX4nFo/JdLGvF0fPFA==
X-Received: by 2002:a05:6214:327:: with SMTP id j7mr318651qvu.36.1585779198020;
        Wed, 01 Apr 2020 15:13:18 -0700 (PDT)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u15sm2464947qte.91.2020.04.01.15.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 15:13:17 -0700 (PDT)
From:   trix@redhat.com
To:     jkacur@rehat.com, williams@redhat.com, lgoncalv@redhat.com
Cc:     linux-rt-users@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] Import a new test, jitterz
Date:   Wed,  1 Apr 2020 15:13:10 -0700
Message-Id: <20200401221310.7544-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Rix <trix@redhat.com>

jitterz is a program for measuring system jitter.

It is a rewrite of sysjitter
https://github.com/alexeiz/sysjitter

The upstream location of jitterz is
https://github.com/trixirt/jitterz

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Makefile              |   7 +-
 src/jitterz/jitterz.c | 329 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 335 insertions(+), 1 deletion(-)
 create mode 100644 src/jitterz/jitterz.c

diff --git a/Makefile b/Makefile
index 05fc5ed..2059389 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,8 @@ sources = cyclictest.c \
 	  cyclicdeadline.c \
 	  deadline_test.c \
 	  queuelat.c \
-	  ssdd.c
+	  ssdd.c \
+	  jitterz.c
 
 TARGETS = $(sources:.c=)
 LIBS	= -lrt -lpthread
@@ -96,6 +97,7 @@ VPATH	+= src/hackbench:
 VPATH	+= src/sched_deadline:
 VPATH	+= src/queuelat:	
 VPATH	+= src/ssdd:
+VPATH	+= src/jitterz:
 
 $(OBJDIR)/%.o: %.c | $(OBJDIR)
 	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
@@ -163,6 +165,9 @@ queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
 ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
+jitterz: $(OBJDIR)/jitterz.o
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
+
 %.8.gz: %.8
 	gzip -nc $< > $@
 
diff --git a/src/jitterz/jitterz.c b/src/jitterz/jitterz.c
new file mode 100644
index 0000000..d4e650f
--- /dev/null
+++ b/src/jitterz/jitterz.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * jitterz
+ *
+ * Copyright 2019-2020 Tom Rix <trix@redhat.com>
+ *
+ */
+
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <stdint.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <time.h>
+#include <string.h>
+#include <errno.h>
+#include <pthread.h>
+#include <sys/time.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <sys/sysinfo.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <math.h>
+
+static int cpu;
+static int clocksel;
+static int policy = SCHED_FIFO;
+static int priority = 5;
+
+#define CHECK_LOST_TIME()					\
+	do {							\
+		if (d >= dt_min) {				\
+			lt += d;				\
+			for (j = 16; j > 0; j--) {		\
+				if (d >= b[j - 1].s) {		\
+					b[j - 1].c =		\
+						b[j - 1].c + 1;	\
+					break;			\
+				}				\
+			}					\
+		}						\
+	} while (0)						\
+
+static inline uint64_t tsc(void)
+{
+	uint64_t ret = 0;
+	uint32_t l, h;
+
+	__asm__ __volatile__("lfence");
+	__asm__ __volatile__("rdtsc" : "=a"(l), "=d"(h));
+	ret = ((uint64_t)h << 32) | l;
+	return ret;
+}
+
+static int move_to_core(int core_i)
+{
+	cpu_set_t cpus;
+
+	CPU_ZERO(&cpus);
+	CPU_SET(core_i, &cpus);
+	return sched_setaffinity(0, sizeof(cpus), &cpus);
+}
+
+static int set_sched(void)
+{
+	struct sched_param p = { 0 };
+
+	p.sched_priority = priority;
+	return sched_setscheduler(0, policy, &p);
+}
+
+static long read_cpuinfo_cur_freq(int core_i)
+{
+	uint64_t fs = -1;
+	char path[80];
+	struct stat sb;
+	int i;
+	char *freq[2] = {
+		"cpuinfo_cur_freq",
+		/* assumes a busy wait will be run at the max freq */
+		"cpuinfo_max_freq",
+	};
+	for (i = 0; i < 2; i++) {
+		snprintf(path, 80,
+			 "/sys/devices/system/cpu/cpu%d/cpufreq/%s",
+			 core_i, freq[1]);
+		if (!stat(path, &sb)) {
+			FILE *f = 0;
+
+			f = fopen(path, "rt");
+			if (f) {
+				fscanf(f, "%lu", &fs);
+				fclose(f);
+			} else {
+				perror(path);
+			}
+		} else {
+			perror(path);
+		}
+	}
+
+	if (fs == (uint64_t) -1) {
+		printf("Error reading CPU frequency for core %d\n", core_i);
+		exit(1);
+	}
+	return fs;
+}
+
+/* Print usage information */
+static void display_help(int error)
+{
+	printf("jitterz V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "jitterz <options>\n\n"
+	       "-c NUM   --cpu=NUM         which cpu to run on"
+	       "         --clock=CLOCK     select clock\n"
+	       "                           0 = CLOCK_MONOTONIC (default)\n"
+	       "                           1 = CLOCK_REALTIME\n"
+	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
+	       "         --policy=NAME     policy of measurement thread, where NAME may be one\n"
+	       "                           of: other, normal, batch, idle, fifo or rr.\n");
+	if (error)
+		exit(EXIT_FAILURE);
+	exit(EXIT_SUCCESS);
+}
+
+static char *policyname(int policy)
+{
+	char *policystr = "";
+
+	switch (policy) {
+	case SCHED_OTHER:
+		policystr = "other";
+		break;
+	case SCHED_FIFO:
+		policystr = "fifo";
+		break;
+	case SCHED_RR:
+		policystr = "rr";
+		break;
+	case SCHED_BATCH:
+		policystr = "batch";
+		break;
+	case SCHED_IDLE:
+		policystr = "idle";
+		break;
+	}
+	return policystr;
+}
+
+static void handlepolicy(char *polname)
+{
+	if (strncasecmp(polname, "other", 5) == 0)
+		policy = SCHED_OTHER;
+	else if (strncasecmp(polname, "batch", 5) == 0)
+		policy = SCHED_BATCH;
+	else if (strncasecmp(polname, "idle", 4) == 0)
+		policy = SCHED_IDLE;
+	else if (strncasecmp(polname, "fifo", 4) == 0)
+		policy = SCHED_FIFO;
+	else if (strncasecmp(polname, "rr", 2) == 0)
+		policy = SCHED_RR;
+	else /* default policy if we don't recognize the request */
+		policy = SCHED_OTHER;
+}
+
+enum option_values {
+	OPT_CPU = 1,
+	OPT_CLOCK,
+	OPT_PRIORITY,
+	OPT_POLICY,
+	OPT_HELP,
+};
+
+/* Process commandline options */
+static void process_options(int argc, char *argv[], int max_cpus)
+{
+	for (;;) {
+		int option_index = 0;
+		/*
+		 * Options for getopt
+		 * Ordered alphabetically by single letter name
+		 */
+		static const struct option long_options[] = {
+			{ "clock", required_argument, NULL, OPT_CLOCK },
+			{ "cpu", required_argument, NULL, OPT_CPU },
+			{ "priority", required_argument, NULL, OPT_PRIORITY },
+			{ "policy", required_argument, NULL, OPT_POLICY },
+			{ "help", no_argument, NULL, OPT_HELP },
+			{ NULL, 0, NULL, 0 },
+		};
+		int c = getopt_long(argc, argv, "c:hp:", long_options,
+				    &option_index);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'c':
+		case OPT_CPU:
+			cpu = atoi(optarg);
+			break;
+		case OPT_CLOCK:
+			clocksel = atoi(optarg);
+			break;
+		case 'p':
+		case OPT_PRIORITY:
+			priority = atoi(optarg);
+			if (policy != SCHED_FIFO && policy != SCHED_RR)
+				policy = SCHED_FIFO;
+			break;
+		case '?':
+		case OPT_HELP:
+			display_help(0);
+			break;
+		case OPT_POLICY:
+			handlepolicy(optarg);
+			break;
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	struct timespec tvs, tve;
+	double sec;
+	uint64_t fs, fe, fr;
+	unsigned int i, j, rt = 60;
+	uint64_t dt = 1500;
+	struct bucket {
+		uint64_t s;
+		uint64_t c;
+	} b[16];
+	uint64_t frs, fre, lt;
+
+	process_options(argc, argv, max_cpus);
+
+	/* return of this function must be tested for success */
+	if (move_to_core(cpu) != 0) {
+		printf("Error while setting thread affinity to cpu %d!", cpu);
+		exit(1);
+	}
+	if (set_sched() != 0) {
+		printf("Error while setting %s policy, priority %d!",
+		       policyname(policy), priority);
+		exit(1);
+	}
+
+	fr = fs = 0;
+	fe = 1;
+	while (fs != fe) {
+retry:
+		if (!fr) {
+			fs = read_cpuinfo_cur_freq(cpu);
+			fe = 0;
+		} else {
+			fs = fr;
+		}
+		uint64_t dt_min = (dt * fs) / 1000000;
+
+		lt = 0;
+		for (j = 0; j < 16; j++) {
+			b[j].c = 0;
+			if (j == 0)
+				b[j].s = dt_min;
+			else
+				b[j].s = b[j - 1].s * 2;
+		}
+		fs *= 1000;
+
+		frs = tsc();
+		clock_gettime(CLOCK_MONOTONIC_RAW, &tvs);
+
+		for (i = 0; i < rt; i++) {
+			uint64_t s, e, so;
+
+			s = tsc();
+			e = s;
+			e += fs;
+			if (e < s)
+				goto retry;
+			so = s;
+
+			while (1) {
+				uint64_t d;
+
+				s = tsc();
+				if (s == so)
+					continue;
+
+				d = s - so;
+				CHECK_LOST_TIME();
+				if (s >= e)
+					break;
+				so = s;
+			}
+		}
+		fre = tsc();
+		clock_gettime(CLOCK_MONOTONIC_RAW, &tve);
+		sec = tve.tv_sec - tvs.tv_sec +
+		      (tve.tv_nsec - tvs.tv_nsec) / 1e9;
+		if ((fabs(sec - rt) / (double)rt) > 0.01) {
+			if (fre > frs) {
+				fr = (fre - frs) / (1000 * sec);
+				fe = fr * 1000;
+			}
+			goto retry;
+		}
+		if (!fr) {
+			fe = read_cpuinfo_cur_freq(cpu);
+			fe *= 1000;
+		}
+	}
+	for (j = 0; j < 16; j++)
+		printf("%lu\n", b[j].c);
+
+	if (lt != fs) {
+		printf("Lost time %f\n", (double)lt / (double)fs);
+		return 1;
+	}
+
+	return 0;
+}
-- 
2.18.1

