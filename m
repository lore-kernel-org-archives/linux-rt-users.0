Return-Path: <SRS0=+wOD=6C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3269C38A29
	for <linux-rt-users@archiver.kernel.org>; Sat, 18 Apr 2020 14:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46EB2076A
	for <linux-rt-users@archiver.kernel.org>; Sat, 18 Apr 2020 14:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPW6r10C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgDROPN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:15:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28119 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726086AbgDROPN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 18 Apr 2020 10:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587219310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=iP8Mwz6klW1G1KWFETERidQOUekYGFQdxrMSC/DE77Y=;
        b=QPW6r10CL27I/SLd0Q0fVL/DTUNdWzOaURxPvWnR5JIScngfpUdmHrPKxijN7sqPzCMbyb
        aV5qM4wbyr74fZQGfwS00VtsEbNlj6eTmQ6cLefI/Mso+419TLo25RczPKre1B0Wk4qXID
        m+of4URwx0BAau7jx8ZX8CxCdWACXP8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-g1MGGHi5PUyo5LBil_OqbQ-1; Sat, 18 Apr 2020 10:15:07 -0400
X-MC-Unique: g1MGGHi5PUyo5LBil_OqbQ-1
Received: by mail-qt1-f200.google.com with SMTP id b13so4822433qto.6
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Apr 2020 07:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iP8Mwz6klW1G1KWFETERidQOUekYGFQdxrMSC/DE77Y=;
        b=G/4PjmwWiXZozHVQwRNfMWsFuzWpIJ9AxK/SCGGZ6HQ+MKguh7XV+Y6u3LaG815P3J
         y4Gdk0EmcbnEqeYP/zIldUe7m0zkY4e5i41NboZpiKR+dArSfKH5AvTCMvPVhRTIP/N+
         EazGLTURKRYmnZyJWDMNDIs+1NrBvK0ay4XuYl3js126+3YsWoX/hAdzfGmlKz8Dh1tV
         EygVUXGCPCfQqMu8Fx9/DAMbDEqrjwYyMier53w6xy89EBRBleRqiRZ4mqhLvqNM2B6I
         Y65wZQBTTBuUGDNzsyNN16lUjqWmKX5NYPpTO//pbSsvoInT6I90RQ0Y3uZIfJmGPkft
         0qcw==
X-Gm-Message-State: AGi0PubcNTvFqtiNILgf+RGVPjwiDgMbR7+lo/EtM8l0bZ4XP0zYV70S
        egrTYQcJTetA9ml84J13J6I8HXIG8wuLOpSlBPNtM4bVcHiNXbdeg5hwGkY0V8ce8tPAr/IyOVa
        fwLWjpmjzlW0TugED7Cc1cAwDZLw=
X-Received: by 2002:ac8:66da:: with SMTP id m26mr7860539qtp.342.1587219306587;
        Sat, 18 Apr 2020 07:15:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypKHuW7A353wT+e8Wk2UWioOaMvM3YbGiZr89niL+wk2bgjy64VctsL5RsnPn67OHVzqXQVIKQ==
X-Received: by 2002:ac8:66da:: with SMTP id m26mr7860499qtp.342.1587219306136;
        Sat, 18 Apr 2020 07:15:06 -0700 (PDT)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v23sm10964134qkv.55.2020.04.18.07.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 07:15:05 -0700 (PDT)
From:   trix@redhat.com
To:     williams@redhat.com, jkacur@redhat.com, tglx@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] Import a new test, jitterz
Date:   Sat, 18 Apr 2020 07:14:49 -0700
Message-Id: <20200418141449.19293-1-trix@redhat.com>
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
 Makefile              |  10 +-
 src/jitterz/jitterz.8 |  39 ++++
 src/jitterz/jitterz.c | 400 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 447 insertions(+), 2 deletions(-)
 create mode 100644 src/jitterz/jitterz.8
 create mode 100644 src/jitterz/jitterz.c

diff --git a/Makefile b/Makefile
index 05fc5ed..3a88a5f 100644
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
@@ -47,7 +48,8 @@ MANPAGES = src/cyclictest/cyclictest.8 \
 	   src/queuelat/queuelat.8 \
 	   src/sched_deadline/deadline_test.8 \
 	   src/ssdd/ssdd.8 \
-	   src/sched_deadline/cyclicdeadline.8
+	   src/sched_deadline/cyclicdeadline.8 \
+	   src/jitterz/jitterz.8 \
 
 ifdef PYLIB
 	MANPAGES += src/hwlatdetect/hwlatdetect.8
@@ -96,6 +98,7 @@ VPATH	+= src/hackbench:
 VPATH	+= src/sched_deadline:
 VPATH	+= src/queuelat:	
 VPATH	+= src/ssdd:
+VPATH	+= src/jitterz:
 
 $(OBJDIR)/%.o: %.c | $(OBJDIR)
 	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
@@ -163,6 +166,9 @@ queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
 ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
+jitterz: $(OBJDIR)/jitterz.o
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
+
 %.8.gz: %.8
 	gzip -nc $< > $@
 
diff --git a/src/jitterz/jitterz.8 b/src/jitterz/jitterz.8
new file mode 100644
index 0000000..5b85640
--- /dev/null
+++ b/src/jitterz/jitterz.8
@@ -0,0 +1,39 @@
+.TH JIITERZ 8 "April 1, 2020"
+.SH NAME
+jitterz \- inference of stalls by looking for gaps in executing a tight loop
+.SH SYNOPSIS
+.B jitterz
+.RI "<options>"
+.SH DESCRIPTION
+In a tight loop, measure the time between iterations.
+If the time exceeds a theshold, increment a count in a time
+bucket.  At the end of test print out the buckets.
+.SH OPTIONS
+.B \-c NUM,   \-\-cpu=NUM
+Which cpu to run on
+.br
+.TP
+.B \-\-clock=CLOCK
+select clock
+  0 = CLOCK_MONOTONIC (default)
+  1 = CLOCK_REALTIME
+.br
+.TP
+.B \-d SEC,  \-\-duration=SEC
+Duration of the test in seconds
+.br
+.TP
+.B \-p PRIO,  \-\-priority=PRIO
+Priority of highest prio thread
+.br
+.TP
+.B \-\-policy=NAME
+Policy of measurement thread, where NAME may be one
+of: other, normal, batch, idle, fifo or rr.
+.br
+.TP
+.B \-h, \-\-help
+Display usage
+
+.SH AUTHOR
+jitterz was written by Tom Rix <trix@redhat.com>
diff --git a/src/jitterz/jitterz.c b/src/jitterz/jitterz.c
new file mode 100644
index 0000000..35f8d90
--- /dev/null
+++ b/src/jitterz/jitterz.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * jitterz
+ *
+ * Copyright 2019-2020 Tom Rix <trix@redhat.com>
+ *
+ */
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
+#include <sys/mman.h>
+#include <math.h>
+
+#define CPU_DEFAULT 0
+static int cpu;
+static int clocksel;
+static int policy = SCHED_FIFO;
+static int priority = 5;
+
+#define NUMBER_BUCKETS 16
+static struct bucket {
+	uint64_t tick_boundry;
+	uint64_t count;
+	uint64_t time_boundry;
+} b[NUMBER_BUCKETS];
+
+static uint64_t accumulated_lost_ticks;
+static uint64_t delta_time = 500; /* nano sec */
+static uint64_t delta_tick_min; /* first bucket's tick boundry */
+#define RUN_TIME_DEFAULT 60
+static int run_time = RUN_TIME_DEFAULT; /* seconds */
+/* how close do multiple run's calculated frequency have to be valid */
+#define FREQUENCY_TOLERNCE 0.01
+static inline void initialize_buckets(void)
+{
+	int i;
+
+	for (i = 0; i < NUMBER_BUCKETS; i++) {
+		b[i].count = 0;
+		if (i == 0) {
+			b[i].tick_boundry = delta_tick_min;
+			b[i].time_boundry = delta_time;
+		} else {
+			b[i].tick_boundry = b[i - 1].tick_boundry * 2;
+			b[i].time_boundry = b[i - 1].time_boundry * 2;
+		}
+	}
+}
+
+static inline void update_buckets(uint64_t ticks)
+{
+	if (ticks >= delta_tick_min) {
+		int i;
+
+		accumulated_lost_ticks += ticks;
+		for (i = NUMBER_BUCKETS; i > 0; i--) {
+			if (ticks >= b[i - 1].tick_boundry) {
+				b[i - 1].count++;
+				break;
+			}
+		}
+	}
+}
+
+/* Returns clock ticks */
+static inline uint64_t time_stamp_counter(void)
+{
+	uint64_t ret = -1;
+#if defined(__i386__) || defined(__x86_64__)
+	uint32_t l, h;
+
+	__asm__ __volatile__("lfence");
+	__asm__ __volatile__("rdtsc" : "=a"(l), "=d"(h));
+	ret = ((uint64_t)h << 32) | l;
+#else
+	fprintf(stderr,
+		"Add a time_stamp_counter function for your arch here %s:%d\n",
+		__FILE__, __LINE__);
+	exit(1);
+#endif
+	return ret;
+}
+
+static inline int move_to_core()
+{
+	cpu_set_t cpus;
+
+	CPU_ZERO(&cpus);
+	CPU_SET(cpu, &cpus);
+	return sched_setaffinity(0, sizeof(cpus), &cpus);
+}
+
+static inline int set_sched(void)
+{
+	struct sched_param p = { 0 };
+
+	p.sched_priority = priority;
+	return sched_setscheduler(0, policy, &p);
+}
+
+static inline uint64_t read_cpu_current_frequency()
+{
+	uint64_t ret = -1;
+	char path[256];
+	struct stat sb;
+	int i;
+	char *freq[3] = {
+		/* scaling_cur_freq is current kernel /sys file */
+		"scaling_cur_freq"
+		/* old /sys file is cpuinfo_cur_freq */
+		"cpuinfo_cur_freq",
+		/* assumes a busy wait will be run at the max freq */
+		"cpuinfo_max_freq",
+	};
+	for (i = 0; i < 3 && ret == -1; i++) {
+		snprintf(path, 256, "/sys/devices/system/cpu/cpu%d/cpufreq/%s",
+			 cpu, freq[i]);
+		if (!stat(path, &sb)) {
+			FILE *f = 0;
+
+			f = fopen(path, "rt");
+			if (f) {
+				fscanf(f, "%" PRIu64, &ret);
+				/*
+				 * sysfs interface is in units of KHz
+				 * convert to Hz
+				 */
+				ret *= 1000;
+				fclose(f);
+			}
+		}
+	}
+
+	if (ret == -1) {
+		printf("Error reading CPU frequency for core %d\n", cpu);
+		exit(1);
+	}
+	return ret;
+}
+
+/* Print usage information */
+static inline void display_help(int error)
+{
+	printf("jitterz\n");
+	printf("Usage:\n"
+	       "jitterz <options>\n\n"
+	       "-c NUM   --cpu=NUM         which cpu to run on\n"
+	       "         --clock=CLOCK     select clock\n"
+	       "                           0 = CLOCK_MONOTONIC (default)\n"
+	       "                           1 = CLOCK_REALTIME\n"
+	       "-d SEC   --duration=SEC    duration of the test in seconds\n"
+	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
+	       "         --policy=NAME     policy of measurement thread, where NAME may be one\n"
+	       "                           of: other, normal, batch, idle, fifo or rr.\n");
+	if (error)
+		exit(EXIT_FAILURE);
+	exit(EXIT_SUCCESS);
+}
+
+static inline char *policyname()
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
+static inline void handlepolicy(char *polname)
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
+	OPT_DURATION,
+	OPT_PRIORITY,
+	OPT_POLICY,
+	OPT_HELP,
+};
+
+/* Process commandline options */
+static inline void process_options(int argc, char *argv[], long max_cpus)
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
+			{ "duration", required_argument, NULL, OPT_DURATION },
+			{ "priority", required_argument, NULL, OPT_PRIORITY },
+			{ "policy", required_argument, NULL, OPT_POLICY },
+			{ "help", no_argument, NULL, OPT_HELP },
+			{ NULL, 0, NULL, 0 },
+		};
+		int c = getopt_long(argc, argv, "c:d:hp:", long_options,
+				    &option_index);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'c':
+		case OPT_CPU:
+			cpu = atoi(optarg);
+			if (cpu >= max_cpus)
+				cpu = CPU_DEFAULT;
+			break;
+		case OPT_CLOCK:
+			clocksel = atoi(optarg);
+			break;
+		case 'd':
+		case OPT_DURATION:
+			run_time = atoi(optarg);
+			if (run_time <= 0)
+				run_time = RUN_TIME_DEFAULT;
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
+	long max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	struct timespec tvs, tve;
+	double real_duration; /* sec */
+	int i;
+	uint64_t test_tick_start, test_tick_end;
+	static uint64_t frequency_start, frequency_run;
+	double frequency_diff = 0.0; /* unitless */
+
+	process_options(argc, argv, max_cpus);
+
+	/* return of this function must be tested for success */
+	if (move_to_core() != 0) {
+		fprintf(stderr,
+			"Error while setting thread affinity to cpu %d\n", cpu);
+		exit(1);
+	}
+	if (set_sched() != 0) {
+		fprintf(stderr, "Error while setting %s policy, priority %d\n",
+			policyname(), priority);
+		exit(1);
+	}
+
+	if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0) {
+		fprintf(stderr, "Error while locking process memory\n");
+		exit(1);
+	}
+
+	frequency_run = 0;
+	frequency_start = read_cpu_current_frequency();
+	/*
+	 * Start off using the cpu frequency from sysfs
+	 * After each loop
+	 *   calculate the real frequency the whole test
+	 *   run until the real frequency is close enough to the last run
+	 */
+	do {
+	retry:
+		if (frequency_run)
+			frequency_start = frequency_run;
+		delta_tick_min = (delta_time * frequency_start) /
+				 1000000000; /* ticks/nsec */
+
+		accumulated_lost_ticks = 0;
+		initialize_buckets();
+
+		/* record the starting tick and clock time for the test */
+		test_tick_start = time_stamp_counter();
+		clock_gettime(CLOCK_MONOTONIC_RAW, &tvs);
+
+		/* loop over seconds run time */
+		for (i = 0; i < run_time; i++) {
+			uint64_t tick, end_tick, old_tick, tick_overflow;
+
+			end_tick = old_tick = tick = time_stamp_counter();
+			end_tick += frequency_start;
+			/*
+			 * Overflow check
+			 * If end_tick < tick, there will be an overlow
+			 * Add additional second's worth of ticks so
+			 * we do not have to check inside the while loop
+			 * to cover the case that end_tick is close to
+			 * overflowing.
+			 */
+			tick_overflow = end_tick + frequency_start;
+			if (tick_overflow < tick)
+				goto retry;
+
+			/*
+			 * Loop until tick >= end_tick
+			 *
+			 * If the difference in old and current tick
+			 * exceed the minimum tick treshold
+			 *   increment the greatest bucket
+			 *   accumulate total lost ticks
+			 *
+			 * set old_tick to current tick
+			 */
+			while (tick < end_tick) {
+				tick = time_stamp_counter();
+				if (tick == old_tick)
+					continue;
+				update_buckets(tick - old_tick);
+				old_tick = tick;
+			}
+		}
+		/* Record the test ending tick and clock time */
+		test_tick_end = time_stamp_counter();
+		/* overflow */
+		if (test_tick_end < test_tick_start)
+			goto retry;
+		clock_gettime(CLOCK_MONOTONIC_RAW, &tve);
+		/* sec */
+		real_duration = tve.tv_sec - tvs.tv_sec +
+				(tve.tv_nsec - tvs.tv_nsec) / 1e9;
+		/* tick / sec */
+		frequency_run =
+			(test_tick_end - test_tick_start) / (real_duration);
+		frequency_diff = fabs((frequency_run * 1.) - frequency_start) /
+				 frequency_start;
+	} while (frequency_diff > FREQUENCY_TOLERNCE);
+
+	fprintf(stdout, "cutoff time (usec) : stall count \n");
+	for (i = 0; i < NUMBER_BUCKETS; i++) {
+		double t = b[i].time_boundry / 1000000000.; /* sec */
+		if (t < real_duration) {
+			double tb = b[i].time_boundry; /* nsec */
+			fprintf(stdout, "%.1f : %" PRIu64 "\n", tb / 1000.,
+				b[i].count);
+		}
+	}
+
+	printf("Lost time %f out of %d seconds\n",
+	       (double)accumulated_lost_ticks / (double)frequency_start,
+	       run_time);
+
+	return 0;
+}
-- 
2.18.1

