From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [rt-tests][PATCH] align thread wakeup times
Date: Mon, 9 Sep 2013 09:29:48 +0200
Message-ID: <20130909072948.GA1967@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, C.Emde@osadl.org,
	tglx@linutronix.de, andi@opentech.at
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:48711 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab3IIHlN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Sep 2013 03:41:13 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi !

  This patch provides and additional -A/--align flag to cyclictest to align
 thread wakeup times of all threads as closly defined as possible.

  When running multiple threads in cyclictest (-S or -t # option) the threads
 are launched in an unsynchronized manner. Basically the creation order and
 time for thread creation determines the start time. For provoking a maximum
 congestion situation (e.g. cache evictions) and to improve reproducibility
 or run conditions the start time should be defined distances appart. The 
 well defined distance is implemented as a offset parameter to -A/--align
 and will offset each threads start time by the parameter * the sequentially
 assigned thread number (par->tnum), together with the -d0 (distance in the
 intervals of the individual threads) this alignment option allows to get 
 the thread wakeup times as closely synchronized as possible.

  The method to sync is simply that the thread with par->tnum == 0 is chosen
 to set a globally shared timestamp, and all other threads use this timestamp
 as their starting time rather than each calling clock_gettime() at startup.
 To ensure synchronization of the thread startup the setting of the global
 time is guarded by pthread_barriers.



Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
Reviewed-by: Andreas Platschek <andreas.platschek@opentech.at>
---
 src/cyclictest/cyclictest.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index abf3e8b..96edda5 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -138,6 +138,7 @@ struct thread_param {
 	unsigned long interval;
 	int cpu;
 	int node;
+	int tnum;
 };
 
 /* Struct for statistics */
@@ -178,6 +179,8 @@ static int force_sched_other;
 static int priospread = 0;
 static int check_clock_resolution;
 static int ct_debug;
+static int aligned = 0;
+static int disaligned = 0;
 
 static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
@@ -186,6 +189,10 @@ static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
 static pid_t break_thread_id = 0;
 static uint64_t break_thread_value = 0;
 
+static pthread_barrier_t align_barr;
+static pthread_barrier_t globalt_barr;
+static struct timespec globalt;
+
 /* Backup of kernel variables that we modify */
 static struct kvars {
 	char name[KVARNAMELEN];
@@ -758,7 +765,20 @@ void *timerthread(void *param)
 		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par->prio);
 
 	/* Get current time */
-	clock_gettime(par->clock, &now);
+	if(aligned){
+		pthread_barrier_wait(&globalt_barr);
+		if(par->tnum==0){
+			clock_gettime(par->clock, &globalt);
+		}
+		pthread_barrier_wait(&align_barr); 
+		now = globalt;
+		if(disaligned){
+			now.tv_nsec += disaligned * par->tnum;
+			tsnorm(&now);
+		}
+	} else {
+		clock_gettime(par->clock, &now);
+	}
 
 	next = now;
 	next.tv_sec += interval.tv_sec;
@@ -951,6 +971,7 @@ static void display_help(int error)
 	       "cyclictest <options>\n\n"
 	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
 	       "                           with NUM pin all threads to the processor NUM\n"
+	       "-A USEC  --aligned=USEC     allign threads wakeup to a specific offset"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
@@ -1093,6 +1114,7 @@ static void process_options (int argc, char *argv[])
 		 */
 		static struct option long_options[] = {
 			{"affinity",         optional_argument, NULL, 'a'},
+			{"aligned",           optional_argument, NULL, 'A'},
 			{"breaktrace",       required_argument, NULL, 'b'},
 			{"preemptirqs",      no_argument,       NULL, 'B'},
 			{"clock",            required_argument, NULL, 'c'},
@@ -1133,7 +1155,7 @@ static void process_options (int argc, char *argv[])
 			{"help",             no_argument,       NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long(argc, argv, "a::b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqQrRsSt::uUvD:wWXT:y:",
+		int c = getopt_long(argc, argv, "a::A:b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqQrRsSt::uUvD:wWXT:y:",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
@@ -1152,6 +1174,10 @@ static void process_options (int argc, char *argv[])
 				setaffinity = AFFINITY_USEALL;
 			}
 			break;
+		case 'A': aligned=1; 
+			if (optarg != NULL)
+				disaligned = atoi(optarg);
+ 			break;
 		case 'b': tracelimit = atoi(optarg); break;
 		case 'B': tracetype = PREEMPTIRQSOFF; break;
 		case 'c': clocksel = atoi(optarg); break;
@@ -1318,6 +1344,11 @@ static void process_options (int argc, char *argv[])
 	if (num_threads < 1)
 		error = 1;
 
+	if (aligned){
+		pthread_barrier_init (&globalt_barr, NULL, num_threads);
+		pthread_barrier_init (&align_barr, NULL, num_threads);
+	}
+
 	if (error)
 		display_help(1);
 }
@@ -1744,6 +1775,7 @@ int main(int argc, char **argv)
 		par->max_cycles = max_cycles;
 		par->stats = stat;
 		par->node = node;
+		par->tnum = i;
 		switch (setaffinity) {
 		case AFFINITY_UNSPECIFIED: par->cpu = -1; break;
 		case AFFINITY_SPECIFIED: par->cpu = affinity; break;
-- 
1.7.2.5

