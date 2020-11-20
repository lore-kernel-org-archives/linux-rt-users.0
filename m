Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C366C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 21:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880AE2240A
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 21:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvk8zC2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgKTVpD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgKTVpC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Nov 2020 16:45:02 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB3C0613CF
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2020 13:45:02 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d28so10367373qka.11
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2020 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eQ13q0LkUZzAcoYG6GK01zMU2bkflzlecVCVjdFhUYg=;
        b=Pvk8zC2XGtvI1wljjrWvQTxzhQlhFmik0Ug4ojZ1KP201hteWonKBqMNAN7Nf2YN9i
         ZBUn9m46+BRJQnjockxTna37QVouCdmhmNFiSuKsk0+yQxwjYjGsiMCdiKmaPXGGGfg8
         jHhuTHo9xvatifyA6UvAB4YJxrdx7pQu2DdgVDmUDhBcRqgWVmjaj8+AHTV9oRjZjObA
         Jq1mCxWHfgf+XLBYM5ybu5ImLipMBLqgFqsnTP7N7QHDQJ0LMG5GvqdWurofVqB+mGOJ
         V2W4t2ExgY4CP/zUvLppZMcu5nq7bRQy6Nzd3aXgd+YJIs4pHo0oHWSaiS/oTJyE5uHP
         1t6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=eQ13q0LkUZzAcoYG6GK01zMU2bkflzlecVCVjdFhUYg=;
        b=gp1tlbJ5qXYN5mjZoziB9X3ERwvjub9Kwpi6yyWZ44xoHXF1XJrvAbAmah3kGCusxi
         gFL0/rPaYHZZI78PC2zsohC/Neb/K8/NoCe9uIIn57ZOZjj671WVea4+LwMN79M8kITr
         IW22/DEOeItfVyvHcdXP7SuMZwcdgp/lKyFq51KOe/geI7Ow/dWlGzuuG/YHjCnt/eR+
         FCosv1OeJXVUInk9XPMt5oUWB8C05HP4e0xACCUrexRKUfD35pCOpkW49x8XReUDbXl0
         qXlpsoUK6MGfRu8YVCjwVPgideKWCkLpkQzO5LyRlQuCfCc1+ApHMc5ZVeGVrUZkxC4Q
         eMmw==
X-Gm-Message-State: AOAM5323JGz2/yEBaNXDvrmqhJaYL24elDpAVIR63uqmCWx5yaidSIAV
        M3krztmzCd6i5T4gM6c0cXU=
X-Google-Smtp-Source: ABdhPJx0Ztfotp9NbnZ3KozOqQJT8R6w8yuSkE7FXU2pad2G1gxuwM6b1UGg2W3pGDHj0GY8VDP+qA==
X-Received: by 2002:a37:e311:: with SMTP id y17mr19285898qki.260.1605908701134;
        Fri, 20 Nov 2020 13:45:01 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id b18sm1278841qtr.84.2020.11.20.13.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:45:00 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 20 Nov 2020 16:44:59 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rt-tests v1 2/3] signaltest: Implement thread placing
In-Reply-To: <20201115184059.7286-3-dwagner@suse.de>
Message-ID: <24fc91b8-651e-6498-3bb8-c4214d213d16@redhat.com>
References: <20201115184059.7286-1-dwagner@suse.de> <20201115184059.7286-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sun, 15 Nov 2020, Daniel Wagner wrote:

> Without setting the thread affinity, the scheduler will move the
> threads around which will lead to spikes. Since any proper realtime
> application will use thread affinity, let's pin down the threads to
> CPUs.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  Makefile                    |   4 +-
>  src/signaltest/signaltest.8 |  22 ++++++-
>  src/signaltest/signaltest.c | 116 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 133 insertions(+), 9 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 3afdfd4d53a7..a410cb24cf34 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -127,8 +127,8 @@ cyclicdeadline: $(OBJDIR)/cyclicdeadline.o $(OBJDIR)/librttest.a
>  deadline_test: $(OBJDIR)/deadline_test.o $(OBJDIR)/librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
> -signaltest: $(OBJDIR)/signaltest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> +signaltest: $(OBJDIR)/signaltest.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(RTTESTNUMA)
>  
>  pi_stress: $(OBJDIR)/pi_stress.o $(OBJDIR)/librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
> index dc3eaab2293a..5ce119b54461 100644
> --- a/src/signaltest/signaltest.8
> +++ b/src/signaltest/signaltest.8
> @@ -1,15 +1,28 @@
>  .\"
> -.TH SIGNALTEST 8 "September 18, 2020"
> +.TH SIGNALTEST 8 "November 15, 2020"
>  .\" Please adjust this date whenever updating this manpage
>  .SH NAME
>  signaltest \- signal roundtrip test software
>  .SH SYNOPSIS
>  .LP
> -signaltest [ -b|--backtrace USEC ] [-D|--duration TIME] [-h|--help] [-l|--loops LOOPS ] [-p|--prio PRIO] [-q|--quiet] [-t|--threads NUM] [-m|--mlockall ] [-v|--verbose ]
> +signaltest [ -a|--affinity NUM] [ -b|--backtrace USEC ] [-D|--duration TIME] [-h|--help] [-l|--loops LOOPS ] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads NUM] [-m|--mlockall ] [-v|--verbose ]
>  .SH OPTIONS
>  These programs follow the usual GNU command line syntax, with long options
>  starting with two dashes ('\-\-').
>  .TP
> +.B \-a, \-\-affinity[=PROC-SET]
> +Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
> +specified, all processors will be used.  Threads will be assigned to processors
> +in the set in numeric order, in a round\-robin fashion.
> +.br
> +The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.
> +The ! character can be used to negate a set.  For example, !B-D means to use all
> +available CPUs except B through D.  The cpu numbers are the same as shown in the
> +.I processor
> +field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets.
> +* Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET,
> +if specified, must be a single CPU number.
> +.TP
>  .B \-b, \-\-breaktrace=USEC
>  Send break trace command when latency > USEC
>  .TP
> @@ -31,6 +44,11 @@ Priority of highest priority thread
>  .B \-q, \-\-quiet
>  print a summary only on exit
>  .TP
> +.B \\-S, \-\-smp
> +Set options for standard testing on SMP systems. Equivalent to using
> +the options: "\-t \-a" as well keeping any specified priority
> +equal across all threads
> +.TP
>  .B \-t, \-\-threads=NUM
>  number of threads: default=2
>  .TP
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index dacaa63673c4..e19877a395ba 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -20,6 +20,8 @@
>  #include <string.h>
>  #include <time.h>
>  #include <unistd.h>
> +#include <errno.h>
> +#include <sched.h>
>  
>  #include <linux/unistd.h>
>  
> @@ -31,6 +33,7 @@
>  
>  #include "error.h"
>  #include "rt-utils.h"
> +#include "rt-numa.h"
>  
>  /* Must be power of 2 ! */
>  #define VALBUF_SIZE		16384
> @@ -43,6 +46,7 @@ struct thread_param {
>  	unsigned long max_cycles;
>  	struct thread_stat *stats;
>  	int bufmsk;
> +	int cpu;
>  };
>  
>  /* Struct for statistics */
> @@ -79,9 +83,20 @@ void *signalthread(void *param)
>  	int policy = par->prio ? SCHED_FIFO : SCHED_OTHER;
>  	int stopped = 0;
>  	int first = 1;
> +	pthread_t thread;
> +	cpu_set_t mask;
>  
>  	stat->tid = gettid();
>  
> +	if (par->cpu != -1) {
> +		CPU_ZERO(&mask);
> +		CPU_SET(par->cpu, &mask);
> +		thread = pthread_self();
> +		if (pthread_setaffinity_np(thread, sizeof(mask), &mask) != 0)
> +			warn("Could not set CPU affinity to CPU #%d\n",
> +			     par->cpu);
> +	}
> +
>  	sigemptyset(&sigset);
>  	sigaddset(&sigset, par->signal);
>  	sigprocmask(SIG_BLOCK, &sigset, NULL);
> @@ -164,6 +179,8 @@ static void display_help(int error)
>  	printf("signaltest V %1.2f\n", VERSION);
>  	printf("Usage:\n"
>  		"signaltest <options>\n\n"
> +		"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
> +		"                           with NUM pin all threads to the processor NUM\n"
>  		"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
>  		"-D       --duration=TIME   specify a length for the test run.\n"
>  		"                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
> @@ -187,16 +204,22 @@ static int duration;
>  static int verbose;
>  static int quiet;
>  static int lockall;
> +static struct bitmask *affinity_mask = NULL;
> +static int smp = 0;
> +static int numa = 0;
> +static int setaffinity = AFFINITY_UNSPECIFIED;
>  
>  /* Process commandline options */
> -static void process_options(int argc, char *argv[])
> +static void process_options(int argc, char *argv[], unsigned int max_cpus)
>  {
> +	int option_affinity = 0;
>  	int error = 0;
>  
>  	for (;;) {
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> +			{"affinity",		optional_argument,	NULL, 'a'},
>  			{"breaktrace",		required_argument,	NULL, 'b'},
>  			{"duration",		required_argument,	NULL, 'D'},
>  			{"help",		no_argument,		NULL, 'h'},
> @@ -204,15 +227,43 @@ static void process_options(int argc, char *argv[])
>  			{"mlockall",		no_argument,		NULL, 'm'},
>  			{"priority",		required_argument,	NULL, 'p'},
>  			{"quiet",		no_argument,		NULL, 'q'},
> +			{"smp",			no_argument,		NULL, 'S'},
>  			{"threads",		required_argument,	NULL, 't'},
>  			{"verbose",		no_argument,		NULL, 'v'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long(argc, argv, "b:D:hl:mp:qt:v",
> +		int c = getopt_long(argc, argv, "a::b:D:hl:mp:qSt:v",
>  				long_options, &option_index);
>  		if (c == -1)
>  			break;
>  		switch (c) {
> +		case 'a':
> +			option_affinity = 1;
> +			/* smp sets AFFINITY_USEALL in OPT_SMP */
> +			if (smp)
> +				break;
> +			if (numa_initialize())
> +				fatal("Couldn't initilize libnuma");
> +			numa = 1;
> +			if (optarg) {
> +				parse_cpumask(optarg, max_cpus, &affinity_mask);
> +				setaffinity = AFFINITY_SPECIFIED;
> +			} else if (optind < argc &&
> +				   (atoi(argv[optind]) ||
> +				    argv[optind][0] == '0' ||
> +				    argv[optind][0] == '!')) {
> +				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
> +				setaffinity = AFFINITY_SPECIFIED;
> +			} else {
> +				setaffinity = AFFINITY_USEALL;
> +			}
> +
> +			if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
> +				display_help(1);
> +			if (verbose)
> +				printf("Using %u cpus.\n",
> +					numa_bitmask_weight(affinity_mask));
> +			break;
>  		case 'b': tracelimit = atoi(optarg); break;
>  		case 'D': duration = parse_time_string(optarg); break;
>  		case '?':
> @@ -221,6 +272,13 @@ static void process_options(int argc, char *argv[])
>  		case 'm': lockall = 1; break;
>  		case 'p': priority = atoi(optarg); break;
>  		case 'q': quiet = 1; break;
> +		case 'S':
> +			if (numa)
> +				fatal("numa and smp options are mutually exclusive\n");
> +			smp = 1;
> +			num_threads = -1; /* update after parsing */
> +			setaffinity = AFFINITY_USEALL;
> +			break;
>  		case 't': num_threads = atoi(optarg); break;
>  		case 'v': verbose = 1; break;
>  		}
> @@ -232,11 +290,31 @@ static void process_options(int argc, char *argv[])
>  	if (priority < 0 || priority > 99)
>  		error = 1;
>  
> +	if (num_threads == -1)
> +		num_threads = get_available_cpus(affinity_mask);
> +
>  	if (num_threads < 2)
>  		error = 1;
>  
> -	if (error)
> +	/* if smp wasn't requested, test for numa automatically */
> +	if (!smp) {
> +		if (numa_initialize())
> +			fatal("Couldn't initilize libnuma");
> +		numa = 1;
> +		if (setaffinity == AFFINITY_UNSPECIFIED)
> +			setaffinity = AFFINITY_USEALL;
> +	}
> +
> +	if (option_affinity) {
> +		if (smp)
> +			warn("-a ignored due to smp mode\n");
> +	}
> +
> +	if (error) {
> +		if (affinity_mask)
> +			numa_bitmask_free(affinity_mask);
>  		display_help(error);
> +	}
>  }
>  
>  static void sighand(int sig)
> @@ -273,9 +351,10 @@ int main(int argc, char **argv)
>  	struct thread_param *par;
>  	struct thread_stat *stat;
>  	int i, ret = -1;
> -	int status;
> +	int status, cpu;
> +	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  
> -	process_options(argc, argv);
> +	process_options(argc, argv, max_cpus);
>  
>  	if (check_privs())
>  		exit(1);
> @@ -287,6 +366,16 @@ int main(int argc, char **argv)
>  			goto out;
>  		}
>  
> +	/* Restrict the main pid to the affinity specified by the user */
> +	if (affinity_mask != NULL) {
> +		int res;
> +
> +		errno = 0;
> +		res = numa_sched_setaffinity(getpid(), affinity_mask);
> +		if (res != 0)
> +			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
> +	}
> +
>  	sigemptyset(&sigset);
>  	sigaddset(&sigset, signum);
>  	sigprocmask(SIG_BLOCK, &sigset, NULL);
> @@ -313,6 +402,22 @@ int main(int argc, char **argv)
>  			par[i].bufmsk = VALBUF_SIZE - 1;
>  		}
>  
> +		switch (setaffinity) {
> +		case AFFINITY_UNSPECIFIED:
> +			cpu = -1;
> +			break;
> +		case AFFINITY_SPECIFIED:
> +			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
> +			if (verbose)
> +				printf("Thread %d using cpu %d.\n", i, cpu);
> +			break;
> +		case AFFINITY_USEALL:
> +			cpu = cpu_for_thread_ua(i, max_cpus);
> +			break;
> +		default:
> +			cpu = -1;
> +		}
> +
>  		par[i].id = i;
>  		par[i].prio = priority;
>  #if 0
> @@ -322,6 +427,7 @@ int main(int argc, char **argv)
>  		par[i].signal = signum;
>  		par[i].max_cycles = max_cycles;
>  		par[i].stats = &stat[i];
> +		par[i].cpu = cpu;
>  		stat[i].min = 1000000;
>  		stat[i].max = -1000000;
>  		stat[i].avg = 0.0;
> -- 
> 2.29.2
> 
> 
    - Fixed spelling of "initialize" in the code
    Signed-off-by: John Kacur <jkacur@redhat.com>

