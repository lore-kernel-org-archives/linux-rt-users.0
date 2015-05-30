From: Anna-Maria Gleixner <anna-maria@glx-um.de>
Subject: Re: [patch 3/3] cyclictest: Align measurement threads to the next  full second
Date: Sat, 30 May 2015 13:02:04 +0200
Message-ID: <5eaf25347d63a0cfe593115b30a03b70@tglx.de>
References: <20150526190333.510838769@glx-um.de>
 <20150526190443.715858228@glx-um.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46524 "EHLO Tesla.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932602AbbE3LCG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 May 2015 07:02:06 -0400
In-Reply-To: <20150526190443.715858228@glx-um.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2015-05-26 21:07, anna-maria@glx-um.de wrote:

> +		case OPT_SECALIGNED:
> +			secaligned = 1;
> +			if (optarg != NULL)
> +				offset = atoi(optarg) * 1000;
> +			else if (optind < argc && atoi(argv[optind]))

The conversion to microseconds is missing as well.

> +				offset = atoi(argv[optind]);
> +			else

The patch is fixed.

	Anna-Maria


cyclictest starts the test threads at a random point in time. For
fully reproducible tests it is required to schedule the threads with a
specified offset from the timer tick. The influence of the tick can be
measured by running the test with offset = 0 and offset =
tickinterval/2.

To achieve this we rely on the fact, that the kernel starts the tick
at CLOCK_MONOTONIC time 0. So it's guaranteed that the tick timer
expires always every second (if the interval between the ticks defined
by CONFIG_HZ is a whole-number divider of a second). Setting the
global start time of the test threads to a full second (plus offset)
and the interval to the interval between the ticks, the threads are
scheduled with the specified offset to the tick.

Add a new option --secaligned which select this mode and modify the
--aligned option code to support this. The --secaligned and --aligned
options are mutually exclusive.

Signed-off-by Anna-Maria Gleixner <anna-maria@glx-um.de>
---
  src/cyclictest/cyclictest.c |   39 
++++++++++++++++++++++++++++++++++-----
  1 file changed, 34 insertions(+), 5 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -185,6 +185,7 @@ static int ct_debug;
  static int use_fifo = 0;
  static pthread_t fifo_threadid;
  static int aligned = 0;
+static int secaligned = 0;
  static int offset = 0;
  static int laptop = 0;

@@ -798,14 +799,27 @@ void *timerthread(void *param)
  		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, 
par->prio);

  	/* Get current time */
-	if(aligned){
+	if (aligned || secaligned) {
  		pthread_barrier_wait(&globalt_barr);
-		if(par->tnum==0)
+		if (par->tnum == 0) {
  			clock_gettime(par->clock, &globalt);
+			if (secaligned) {
+				/* Ensure that the thread start timestamp is not
+				   in the past */
+				if (globalt.tv_nsec > 900000000)
+					globalt.tv_sec += 2;
+				else
+					globalt.tv_sec++;
+				globalt.tv_nsec = 0;
+			}
+		}
  		pthread_barrier_wait(&align_barr);
  		now = globalt;
  		if(offset) {
-			now.tv_nsec += offset * par->tnum;
+			if (aligned)
+				now.tv_nsec += offset * par->tnum;
+			else
+				now.tv_nsec += offset;
  			tsnorm(&now);
  		}
  	}
@@ -1056,6 +1070,8 @@ static void display_help(int error)
  	       "-R       --resolution      check clock resolution, calling 
clock_gettime() many\n"
  	       "                           times.  list of clock_gettime() 
values will be\n"
  	       "                           reported with -X\n"
+	       "         --secaligned [USEC] align thread wakeups to the next 
full second,\n"
+	       "                           and apply the optional offset\n"
  	       "-s       --system          use sys_nanosleep and 
sys_setitimer\n"
  	       "-S       --smp             Standard SMP testing: options -a 
-t -n and\n"
  	       "                           same priority of all threads\n"
@@ -1204,7 +1220,7 @@ enum option_values {
  	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM,
  	OPT_SMP, OPT_THREADS, OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, 
OPT_VERBOSE,
  	OPT_WAKEUP, OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, 
OPT_NUMOPTS,
-	OPT_ALIGNED, OPT_LAPTOP,
+	OPT_ALIGNED, OPT_LAPTOP, OPT_SECALIGNED,
  };

  /* Process commandline options */
@@ -1251,6 +1267,7 @@ static void process_options (int argc, c
  			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
  			{"relative",         no_argument,       NULL, OPT_RELATIVE },
  			{"resolution",       no_argument,       NULL, OPT_RESOLUTION },
+			{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
  			{"system",           no_argument,       NULL, OPT_SYSTEM },
  			{"smp",              no_argument,       NULL, OPT_SMP },
  			{"threads",          optional_argument, NULL, OPT_THREADS },
@@ -1391,6 +1408,15 @@ static void process_options (int argc, c
  		case OPT_RESOLUTION:
  			check_clock_resolution = 1; break;
  		case 's':
+		case OPT_SECALIGNED:
+			secaligned = 1;
+			if (optarg != NULL)
+				offset = atoi(optarg) * 1000;
+			else if (optind < argc && atoi(argv[optind]))
+				offset = atoi(argv[optind]) * 1000;
+			else
+				offset = 0;
+			break;
  		case OPT_SYSTEM:
  			use_system = MODE_SYS_OFFSET; break;
  		case 'S':
@@ -1528,7 +1554,10 @@ static void process_options (int argc, c
  	if (num_threads < 1)
  		error = 1;

-	if (aligned) {
+	if (aligned && secaligned)
+		error = 1;
+
+	if (aligned || secaligned) {
  		pthread_barrier_init(&globalt_barr, NULL, num_threads);
  		pthread_barrier_init(&align_barr, NULL, num_threads);
  	}
