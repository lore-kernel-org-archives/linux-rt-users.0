Return-Path: <SRS0=MBx+=6E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83428C3815B
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 16:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE9821473
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 16:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwCb3hs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgDTQ7g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTQ7f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Apr 2020 12:59:35 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625E1C061A0C
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2020 09:59:35 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id q2so2061185qvd.1
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2020 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=G+jaQP+qh901c7gbKp1CZbttrEOmX9P6AErP+Y7nNtw=;
        b=AwCb3hs+gZDmpMtz0j0CWU+a9PVasu7LiZG09U7/DIAoWIjOF1yJL95fCBrZhtJRHJ
         kQU9bbKjzsYSCLanqwp9WqHBKHfyf2KNsKzNPw1ZNDttFMJ+ZJAdPemiqrX2/XHi3Upc
         bNPHr5KewhkM2ZtfUkRwrCXe8jOD96yN6iPt4caes2/6Rwl22PT2x6JIzvzCDYGAYP5h
         fwi7REU7pUMVxOWFeM1cL3MJ4HsoCtPLS+vxtJfu6qBdSeRyxGeh0zLrRoyqQql98wYm
         ycNGXf37DwDpDub/KQa23xALUOWU2+Ax3YwmvI9fyi7eC3YcKM5eKsaHKaZ7pThT5gzs
         U6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=G+jaQP+qh901c7gbKp1CZbttrEOmX9P6AErP+Y7nNtw=;
        b=cwDn9otySJokpUP/56T9ASmHvGbEaZ6X3G6KhTPBxDa5uCJbWf9eGxibp76CcSBUn9
         FLJ6dYgpFzilCYM7IlPH6PcXau0jYIeEUQomvSygZ2JN4QflD1xHHM9KHMeHplyx4lL/
         nMkSBG1xjfH6yN4FK5JbQ2LLXH/qMzEtiO6YbbAPmQ3CMszebp9EwQ8XVtqHYxuKX6Nc
         d6k+ag3Ox+Zf8FGa7beaqj9C6AqlEOXPyq9qBfY2/jn/Jwd38Tlr+c7huVb4ZHgotIXs
         acPX+1S0qXfo1cqepguX/s9TJHINIPnOT9qpCeY9oDI+/+rHSOw/DXW47FIABnrhX5Tq
         66yQ==
X-Gm-Message-State: AGi0PubkulCiIBOtXBamZHYOeopvWaDgvAATqvCwB9TKHZb9qWk009Rd
        ETUFJ+2OVttLy6RuS1ugg5hlXkSrMg8=
X-Google-Smtp-Source: APiQypL3l669k95kGV43rFS1XhM1w+JqF0js6rh46QunzMymKWsWGXehmkttdIrBayn1iSQpZ/SqOg==
X-Received: by 2002:a0c:ba83:: with SMTP id x3mr16482336qvf.83.1587401974098;
        Mon, 20 Apr 2020 09:59:34 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id b19sm58112qkg.72.2020.04.20.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:59:33 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:59:32 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Tom Rix <trix@redhat.com>
cc:     williams@redhat.com, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] Import a new test, jitterz
In-Reply-To: <20200418141449.19293-1-trix@redhat.com>
Message-ID: <alpine.LFD.2.21.2004201255350.4545@planxty>
References: <20200418141449.19293-1-trix@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 18 Apr 2020, trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> jitterz is a program for measuring system jitter.
> 
> It is a rewrite of sysjitter
> https://github.com/alexeiz/sysjitter
> 
> The upstream location of jitterz is
> https://github.com/trixirt/jitterz
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  Makefile              |  10 +-
>  src/jitterz/jitterz.8 |  39 ++++
>  src/jitterz/jitterz.c | 400 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 447 insertions(+), 2 deletions(-)
>  create mode 100644 src/jitterz/jitterz.8
>  create mode 100644 src/jitterz/jitterz.c
> 
> diff --git a/Makefile b/Makefile
> index 05fc5ed..3a88a5f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -17,7 +17,8 @@ sources = cyclictest.c \
>  	  cyclicdeadline.c \
>  	  deadline_test.c \
>  	  queuelat.c \
> -	  ssdd.c
> +	  ssdd.c \
> +	  jitterz.c
>  
>  TARGETS = $(sources:.c=)
>  LIBS	= -lrt -lpthread
> @@ -47,7 +48,8 @@ MANPAGES = src/cyclictest/cyclictest.8 \
>  	   src/queuelat/queuelat.8 \
>  	   src/sched_deadline/deadline_test.8 \
>  	   src/ssdd/ssdd.8 \
> -	   src/sched_deadline/cyclicdeadline.8
> +	   src/sched_deadline/cyclicdeadline.8 \
> +	   src/jitterz/jitterz.8 \
>  
>  ifdef PYLIB
>  	MANPAGES += src/hwlatdetect/hwlatdetect.8
> @@ -96,6 +98,7 @@ VPATH	+= src/hackbench:
>  VPATH	+= src/sched_deadline:
>  VPATH	+= src/queuelat:	
>  VPATH	+= src/ssdd:
> +VPATH	+= src/jitterz:
>  
>  $(OBJDIR)/%.o: %.c | $(OBJDIR)
>  	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
> @@ -163,6 +166,9 @@ queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
>  ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
> +jitterz: $(OBJDIR)/jitterz.o
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
> +
>  %.8.gz: %.8
>  	gzip -nc $< > $@
>  
> diff --git a/src/jitterz/jitterz.8 b/src/jitterz/jitterz.8
> new file mode 100644
> index 0000000..5b85640
> --- /dev/null
> +++ b/src/jitterz/jitterz.8
> @@ -0,0 +1,39 @@
> +.TH JIITERZ 8 "April 1, 2020"
> +.SH NAME
> +jitterz \- inference of stalls by looking for gaps in executing a tight loop
> +.SH SYNOPSIS
> +.B jitterz
> +.RI "<options>"
> +.SH DESCRIPTION
> +In a tight loop, measure the time between iterations.
> +If the time exceeds a theshold, increment a count in a time
> +bucket.  At the end of test print out the buckets.
> +.SH OPTIONS
> +.B \-c NUM,   \-\-cpu=NUM
> +Which cpu to run on
> +.br
> +.TP
> +.B \-\-clock=CLOCK
> +select clock
> +  0 = CLOCK_MONOTONIC (default)
> +  1 = CLOCK_REALTIME
> +.br
> +.TP
> +.B \-d SEC,  \-\-duration=SEC
> +Duration of the test in seconds
> +.br
> +.TP
> +.B \-p PRIO,  \-\-priority=PRIO
> +Priority of highest prio thread
> +.br
> +.TP
> +.B \-\-policy=NAME
> +Policy of measurement thread, where NAME may be one
> +of: other, normal, batch, idle, fifo or rr.
> +.br
> +.TP
> +.B \-h, \-\-help
> +Display usage
> +
> +.SH AUTHOR
> +jitterz was written by Tom Rix <trix@redhat.com>
> diff --git a/src/jitterz/jitterz.c b/src/jitterz/jitterz.c
> new file mode 100644
> index 0000000..35f8d90
> --- /dev/null
> +++ b/src/jitterz/jitterz.c
> @@ -0,0 +1,400 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * jitterz
> + *
> + * Copyright 2019-2020 Tom Rix <trix@redhat.com>
> + *
> + */

Should the manpage mention that the original idea comes from sysjitter?
While I'm asking that, just to play devil's advocate, why are we not just
forking sysjitter and adapting it to our needs? What advantage to we get
by re-implemnting this?

> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <stdint.h>
> +#include <getopt.h>
> +#include <unistd.h>
> +#include <inttypes.h>
> +#include <time.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <pthread.h>
> +#include <sys/time.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <sys/sysinfo.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <math.h>
> +
> +#define CPU_DEFAULT 0
> +static int cpu;
> +static int clocksel;
> +static int policy = SCHED_FIFO;
> +static int priority = 5;
> +
> +#define NUMBER_BUCKETS 16
> +static struct bucket {
> +	uint64_t tick_boundry;
> +	uint64_t count;
> +	uint64_t time_boundry;
> +} b[NUMBER_BUCKETS];
> +
> +static uint64_t accumulated_lost_ticks;
> +static uint64_t delta_time = 500; /* nano sec */
> +static uint64_t delta_tick_min; /* first bucket's tick boundry */
> +#define RUN_TIME_DEFAULT 60
> +static int run_time = RUN_TIME_DEFAULT; /* seconds */
> +/* how close do multiple run's calculated frequency have to be valid */
> +#define FREQUENCY_TOLERNCE 0.01
> +static inline void initialize_buckets(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < NUMBER_BUCKETS; i++) {
> +		b[i].count = 0;
> +		if (i == 0) {
> +			b[i].tick_boundry = delta_tick_min;
> +			b[i].time_boundry = delta_time;
> +		} else {
> +			b[i].tick_boundry = b[i - 1].tick_boundry * 2;
> +			b[i].time_boundry = b[i - 1].time_boundry * 2;
> +		}
> +	}
> +}
> +
> +static inline void update_buckets(uint64_t ticks)
> +{
> +	if (ticks >= delta_tick_min) {
> +		int i;
> +
> +		accumulated_lost_ticks += ticks;
> +		for (i = NUMBER_BUCKETS; i > 0; i--) {
> +			if (ticks >= b[i - 1].tick_boundry) {
> +				b[i - 1].count++;
> +				break;
> +			}
> +		}
> +	}
> +}
> +
> +/* Returns clock ticks */
> +static inline uint64_t time_stamp_counter(void)
> +{
> +	uint64_t ret = -1;
> +#if defined(__i386__) || defined(__x86_64__)
> +	uint32_t l, h;
> +
> +	__asm__ __volatile__("lfence");
> +	__asm__ __volatile__("rdtsc" : "=a"(l), "=d"(h));
> +	ret = ((uint64_t)h << 32) | l;
> +#else
> +	fprintf(stderr,
> +		"Add a time_stamp_counter function for your arch here %s:%d\n",
> +		__FILE__, __LINE__);
> +	exit(1);
> +#endif
> +	return ret;
> +}
> +
> +static inline int move_to_core()
> +{
> +	cpu_set_t cpus;
> +
> +	CPU_ZERO(&cpus);
> +	CPU_SET(cpu, &cpus);
> +	return sched_setaffinity(0, sizeof(cpus), &cpus);
> +}
> +
> +static inline int set_sched(void)
> +{
> +	struct sched_param p = { 0 };
> +
> +	p.sched_priority = priority;
> +	return sched_setscheduler(0, policy, &p);
> +}
> +
> +static inline uint64_t read_cpu_current_frequency()
> +{
> +	uint64_t ret = -1;
> +	char path[256];
> +	struct stat sb;
> +	int i;
> +	char *freq[3] = {
> +		/* scaling_cur_freq is current kernel /sys file */
> +		"scaling_cur_freq"
> +		/* old /sys file is cpuinfo_cur_freq */
> +		"cpuinfo_cur_freq",
> +		/* assumes a busy wait will be run at the max freq */
> +		"cpuinfo_max_freq",
> +	};
> +	for (i = 0; i < 3 && ret == -1; i++) {
> +		snprintf(path, 256, "/sys/devices/system/cpu/cpu%d/cpufreq/%s",
> +			 cpu, freq[i]);
> +		if (!stat(path, &sb)) {
> +			FILE *f = 0;
> +
> +			f = fopen(path, "rt");
> +			if (f) {
> +				fscanf(f, "%" PRIu64, &ret);
> +				/*
> +				 * sysfs interface is in units of KHz
> +				 * convert to Hz
> +				 */
> +				ret *= 1000;
> +				fclose(f);
> +			}
> +		}
> +	}
> +
> +	if (ret == -1) {
> +		printf("Error reading CPU frequency for core %d\n", cpu);
> +		exit(1);
> +	}
> +	return ret;
> +}
> +
> +/* Print usage information */
> +static inline void display_help(int error)
> +{
> +	printf("jitterz\n");
> +	printf("Usage:\n"
> +	       "jitterz <options>\n\n"
> +	       "-c NUM   --cpu=NUM         which cpu to run on\n"
> +	       "         --clock=CLOCK     select clock\n"
> +	       "                           0 = CLOCK_MONOTONIC (default)\n"
> +	       "                           1 = CLOCK_REALTIME\n"
> +	       "-d SEC   --duration=SEC    duration of the test in seconds\n"
> +	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
> +	       "         --policy=NAME     policy of measurement thread, where NAME may be one\n"
> +	       "                           of: other, normal, batch, idle, fifo or rr.\n");
> +	if (error)
> +		exit(EXIT_FAILURE);
> +	exit(EXIT_SUCCESS);
> +}
> +
> +static inline char *policyname()
> +{
> +	char *policystr = "";
> +
> +	switch (policy) {
> +	case SCHED_OTHER:
> +		policystr = "other";
> +		break;
> +	case SCHED_FIFO:
> +		policystr = "fifo";
> +		break;
> +	case SCHED_RR:
> +		policystr = "rr";
> +		break;
> +	case SCHED_BATCH:
> +		policystr = "batch";
> +		break;
> +	case SCHED_IDLE:
> +		policystr = "idle";
> +		break;
> +	}
> +	return policystr;
> +}
> +
> +static inline void handlepolicy(char *polname)
> +{
> +	if (strncasecmp(polname, "other", 5) == 0)
> +		policy = SCHED_OTHER;
> +	else if (strncasecmp(polname, "batch", 5) == 0)
> +		policy = SCHED_BATCH;
> +	else if (strncasecmp(polname, "idle", 4) == 0)
> +		policy = SCHED_IDLE;
> +	else if (strncasecmp(polname, "fifo", 4) == 0)
> +		policy = SCHED_FIFO;
> +	else if (strncasecmp(polname, "rr", 2) == 0)
> +		policy = SCHED_RR;
> +	else /* default policy if we don't recognize the request */
> +		policy = SCHED_OTHER;
> +}
> +
> +enum option_values {
> +	OPT_CPU = 1,
> +	OPT_CLOCK,
> +	OPT_DURATION,
> +	OPT_PRIORITY,
> +	OPT_POLICY,
> +	OPT_HELP,
> +};
> +
> +/* Process commandline options */
> +static inline void process_options(int argc, char *argv[], long max_cpus)
> +{
> +	for (;;) {
> +		int option_index = 0;
> +		/*
> +		 * Options for getopt
> +		 * Ordered alphabetically by single letter name
> +		 */
> +		static const struct option long_options[] = {
> +			{ "clock", required_argument, NULL, OPT_CLOCK },
> +			{ "cpu", required_argument, NULL, OPT_CPU },
> +			{ "duration", required_argument, NULL, OPT_DURATION },
> +			{ "priority", required_argument, NULL, OPT_PRIORITY },
> +			{ "policy", required_argument, NULL, OPT_POLICY },
> +			{ "help", no_argument, NULL, OPT_HELP },
> +			{ NULL, 0, NULL, 0 },
> +		};
> +		int c = getopt_long(argc, argv, "c:d:hp:", long_options,
> +				    &option_index);
> +		if (c == -1)
> +			break;
> +		switch (c) {
> +		case 'c':
> +		case OPT_CPU:
> +			cpu = atoi(optarg);
> +			if (cpu >= max_cpus)
> +				cpu = CPU_DEFAULT;
> +			break;
> +		case OPT_CLOCK:
> +			clocksel = atoi(optarg);
> +			break;
> +		case 'd':
> +		case OPT_DURATION:
> +			run_time = atoi(optarg);
> +			if (run_time <= 0)
> +				run_time = RUN_TIME_DEFAULT;
> +			break;
> +		case 'p':
> +		case OPT_PRIORITY:
> +			priority = atoi(optarg);
> +			if (policy != SCHED_FIFO && policy != SCHED_RR)
> +				policy = SCHED_FIFO;
> +			break;
> +		case '?':
> +		case OPT_HELP:
> +			display_help(0);
> +			break;
> +		case OPT_POLICY:
> +			handlepolicy(optarg);
> +			break;
> +		}
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	long max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	struct timespec tvs, tve;
> +	double real_duration; /* sec */
> +	int i;
> +	uint64_t test_tick_start, test_tick_end;
> +	static uint64_t frequency_start, frequency_run;
> +	double frequency_diff = 0.0; /* unitless */
> +
> +	process_options(argc, argv, max_cpus);
> +
> +	/* return of this function must be tested for success */
> +	if (move_to_core() != 0) {
> +		fprintf(stderr,
> +			"Error while setting thread affinity to cpu %d\n", cpu);
> +		exit(1);
> +	}
> +	if (set_sched() != 0) {
> +		fprintf(stderr, "Error while setting %s policy, priority %d\n",
> +			policyname(), priority);
> +		exit(1);
> +	}
> +
> +	if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0) {
> +		fprintf(stderr, "Error while locking process memory\n");
> +		exit(1);
> +	}
> +
> +	frequency_run = 0;
> +	frequency_start = read_cpu_current_frequency();
> +	/*
> +	 * Start off using the cpu frequency from sysfs
> +	 * After each loop
> +	 *   calculate the real frequency the whole test
> +	 *   run until the real frequency is close enough to the last run
> +	 */
> +	do {
> +	retry:
> +		if (frequency_run)
> +			frequency_start = frequency_run;
> +		delta_tick_min = (delta_time * frequency_start) /
> +				 1000000000; /* ticks/nsec */
> +
> +		accumulated_lost_ticks = 0;
> +		initialize_buckets();
> +
> +		/* record the starting tick and clock time for the test */
> +		test_tick_start = time_stamp_counter();
> +		clock_gettime(CLOCK_MONOTONIC_RAW, &tvs);
> +
> +		/* loop over seconds run time */
> +		for (i = 0; i < run_time; i++) {
> +			uint64_t tick, end_tick, old_tick, tick_overflow;
> +
> +			end_tick = old_tick = tick = time_stamp_counter();
> +			end_tick += frequency_start;
> +			/*
> +			 * Overflow check
> +			 * If end_tick < tick, there will be an overlow
> +			 * Add additional second's worth of ticks so
> +			 * we do not have to check inside the while loop
> +			 * to cover the case that end_tick is close to
> +			 * overflowing.
> +			 */
> +			tick_overflow = end_tick + frequency_start;
> +			if (tick_overflow < tick)
> +				goto retry;
> +
> +			/*
> +			 * Loop until tick >= end_tick
> +			 *
> +			 * If the difference in old and current tick
> +			 * exceed the minimum tick treshold
> +			 *   increment the greatest bucket
> +			 *   accumulate total lost ticks
> +			 *
> +			 * set old_tick to current tick
> +			 */
> +			while (tick < end_tick) {
> +				tick = time_stamp_counter();
> +				if (tick == old_tick)
> +					continue;
> +				update_buckets(tick - old_tick);
> +				old_tick = tick;
> +			}
> +		}
> +		/* Record the test ending tick and clock time */
> +		test_tick_end = time_stamp_counter();
> +		/* overflow */
> +		if (test_tick_end < test_tick_start)
> +			goto retry;
> +		clock_gettime(CLOCK_MONOTONIC_RAW, &tve);
> +		/* sec */
> +		real_duration = tve.tv_sec - tvs.tv_sec +
> +				(tve.tv_nsec - tvs.tv_nsec) / 1e9;
> +		/* tick / sec */
> +		frequency_run =
> +			(test_tick_end - test_tick_start) / (real_duration);
> +		frequency_diff = fabs((frequency_run * 1.) - frequency_start) /
> +				 frequency_start;
> +	} while (frequency_diff > FREQUENCY_TOLERNCE);
> +
> +	fprintf(stdout, "cutoff time (usec) : stall count \n");
> +	for (i = 0; i < NUMBER_BUCKETS; i++) {
> +		double t = b[i].time_boundry / 1000000000.; /* sec */
> +		if (t < real_duration) {
> +			double tb = b[i].time_boundry; /* nsec */
> +			fprintf(stdout, "%.1f : %" PRIu64 "\n", tb / 1000.,
> +				b[i].count);
> +		}
> +	}
> +
> +	printf("Lost time %f out of %d seconds\n",
> +	       (double)accumulated_lost_ticks / (double)frequency_start,
> +	       run_time);
> +
> +	return 0;
> +}
> -- 
> 2.18.1
> 
> 
