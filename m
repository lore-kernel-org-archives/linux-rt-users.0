From: Luis Henriques <henrix@sapo.pt>
Subject: [RFC] cyclictest: Added option for results in nanoseconds
Date: Fri, 20 Mar 2009 19:43:18 +0000
Message-ID: <20090320194318.GA6742@hades.domain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:46866 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755564AbZCTTwP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Mar 2009 15:52:15 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

cyclictest results are presented in microseconds, although internal precision
uses nanosecond unit.  This patch adds a command-line option for keeping the
nanoseconds precision.  man page has also been update.

Signed-off-by: Luis Henriques <henrix@sapo.pt>
---
 src/cyclictest/cyclictest.8 |    3 +++
 src/cyclictest/cyclictest.c |   21 ++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 4b4eedc..a917b45 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -96,6 +96,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 .B \-n, \-\-nanosleep
 Use clock_nanosleep instead of posix interval timers. Setting this option runs the tests with clock_nanosleep instead of posix interval timers.
 .TP
+.B \-N, \-\-nsecs
+Show results in nanoseconds instead of microseconds, which is the default unit.
+.TP
 .B \-o, \-\-oscope=RED
 Oscilloscope mode, reduce verbose output by RED.
 .TP
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 5f49fbb..ed96864 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -139,6 +139,7 @@ static int lockall = 0;
 static int tracetype = NOTRACE;
 static int histogram = 0;
 static int duration = 0;
+static int use_nsecs = 0;
 
 /* Backup of kernel variables that we modify */
 static struct kvars {
@@ -286,6 +287,14 @@ static inline long calcdiff(struct timespec t1, struct timespec t2)
 	return diff;
 }
 
+static inline long calcdiff_ns(struct timespec t1, struct timespec t2)
+{
+	long diff;
+	diff = NSEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
+	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
+	return diff;
+}
+
 void tracing(int on)
 {
 	if (on) {
@@ -580,7 +589,10 @@ void *timerthread(void *param)
 		}
 		clock_gettime(par->clock, &now);
 
-		diff = calcdiff(now, next);
+		if (use_nsecs)
+			diff = calcdiff_ns(now, next);
+		else
+			diff = calcdiff(now, next);
 		if (diff < stat->min)
 			stat->min = diff;
 		if (diff > stat->max)
@@ -657,6 +669,7 @@ static void display_help(void)
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "-m       --mlockall        lock current and future memory allocations\n"
 	       "-n       --nanosleep       use clock_nanosleep\n"
+	       "-N       --nsecs           print results in ns instead of ms (default ms)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
 	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
@@ -726,6 +739,7 @@ static void process_options (int argc, char *argv[])
 			{"loops", required_argument, NULL, 'l'},
 			{"mlockall", no_argument, NULL, 'm' },
 			{"nanosleep", no_argument, NULL, 'n'},
+			{"nsecs", no_argument, NULL, 'N'},
 			{"oscope", required_argument, NULL, 'o'},
 			{"priority", required_argument, NULL, 'p'},
 			{"preemptoff", no_argument, NULL, 'P'},
@@ -738,7 +752,7 @@ static void process_options (int argc, char *argv[])
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:Bc:d:fh:i:Il:no:p:Pmqrst::vD:",
+		int c = getopt_long (argc, argv, "a::b:Bc:d:fh:i:Il:nNo:p:Pmqrst::vD:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -766,6 +780,7 @@ static void process_options (int argc, char *argv[])
 		case 'I': tracetype = IRQSOFF; break;
 		case 'l': max_cycles = atoi(optarg); break;
 		case 'n': use_nanosleep = MODE_CLOCK_NANOSLEEP; break;
+		case 'N': use_nsecs = 1; break;
 		case 'o': oscope_reduction = atoi(optarg); break;
 		case 'p': priority = atoi(optarg); break;
 		case 'P': tracetype = PREEMPTOFF; break;
@@ -908,7 +923,7 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 	if (!verbose) {
 		if (quiet != 1) {
 			printf("T:%2d (%5d) P:%2d I:%ld C:%7lu "
-			       "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n",
+			       "Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n",
 			       index, stat->tid, par->prio, par->interval,
 			       stat->cycles, stat->min, stat->act,
 			       stat->cycles ?
-- 
1.6.2


-- 
Luis Henriques
