From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 1/2] cyclictest: code cleanup
Date: Thu, 12 Feb 2009 22:40:22 -0000
Message-ID: <20090212222052.201913705@linutronix.de>
References: <20090212221944.272839206@linutronix.de>
Cc: Clark Williams <williams@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47282 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756980AbZBLWlW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 17:41:22 -0500
Content-Disposition: inline; filename=cyclictest-code-cleanup.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Started to grow whitespace and formatting sloppiness.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 src/cyclictest/cyclictest.c |   44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -278,6 +278,7 @@ static inline void tsnorm(struct timespe
 static inline long calcdiff(struct timespec t1, struct timespec t2)
 {
 	long diff;
+
 	diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
 	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
 	return diff;
@@ -312,7 +313,8 @@ static int settracer(char *tracer)
 
 	/* Make sure tracer is available */
 	strncpy(filename, debugfileprefix, sizeof(filename));
-	strncat(filename, "available_tracers", sizeof(filename) - strlen(debugfileprefix));
+	strncat(filename, "available_tracers",
+		sizeof(filename) - strlen(debugfileprefix));
 
 	fp = fopen(filename, "r");
 	if (!fp)
@@ -337,9 +339,9 @@ static int settracer(char *tracer)
 	return ret;
 }
 
-/* 
+/*
  * parse an input value as a base10 value followed by an optional
- * suffix. The input value is presumed to be in seconds, unless 
+ * suffix. The input value is presumed to be in seconds, unless
  * followed by a modifier suffix: m=minutes, h=hours, d=days
  *
  * the return value is a value in seconds
@@ -586,7 +588,7 @@ void *timerthread(void *param)
 
 		if (duration && (calcdiff(now, stop) >= 0))
 			shutdown++;
-		
+
 		if (!stopped && tracelimit && (diff > tracelimit)) {
 			stopped++;
 			tracing(0);
@@ -597,7 +599,7 @@ void *timerthread(void *param)
 
 		if (par->bufmsk)
 			stat->values[stat->cycles & par->bufmsk] = diff;
-	
+
 		if (histogram && (diff < histogram))
 			stat->hist_array[diff] += 1;
 
@@ -648,7 +650,7 @@ static void display_help(void)
 	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
- 	       "-h H_MAX                   latency histogram size in us default 0 (off)\n"
+	       "-h H_MAX                   latency histogram size in us default 0 (off)\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
@@ -735,8 +737,9 @@ static void process_options (int argc, c
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:Bc:d:fh:i:Il:no:p:Pmqrst::vD:",
-			long_options, &option_index);
+		int c = getopt_long (argc, argv,
+				     "a::b:Bc:d:fh:i:Il:no:p:Pmqrst::vD:",
+				     long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
@@ -758,7 +761,7 @@ static void process_options (int argc, c
 		case 'd': distance = atoi(optarg); break;
 		case 'E': tracetype = EVENTS; break;
 		case 'f': ftrace = 1; break;
- 		case 'h': histogram = atoi(optarg); break;
+		case 'h': histogram = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'I': tracetype = IRQSOFF; break;
 		case 'l': max_cycles = atoi(optarg); break;
@@ -789,8 +792,9 @@ static void process_options (int argc, c
 		if (affinity < 0)
 			error = 1;
 		if (affinity >= max_cpus) {
-			fprintf(stderr, "ERROR: CPU #%d not found, only %d CPUs available\n",
-			    affinity, max_cpus);
+			fprintf(stderr, "ERROR: CPU #%d not found, "
+				"only %d CPUs available\n",
+				affinity, max_cpus);
 			error = 1;
 		}
 	} else if (tracelimit)
@@ -803,7 +807,8 @@ static void process_options (int argc, c
 		error = 1;
 
 	if (oscope_reduction > 1 && !verbose) {
-		fprintf(stderr, "ERROR: -o option only meaningful, if verbose\n");
+		fprintf(stderr,
+			"ERROR: -o option only meaningful, if verbose\n");
 		error = 1;
 	}
 
@@ -867,7 +872,7 @@ static void print_hist(struct thread_par
 	int i, j;
 	unsigned long long log_entries[nthreads];
 	unsigned long max_latency = 0;
-	
+
 	bzero(log_entries, sizeof(log_entries));
 
 	printf("# Histogram\n");
@@ -883,7 +888,6 @@ static void print_hist(struct thread_par
 				max_latency = i;
 		}
 		printf("\n");
-		
 	}
 	printf("# Total:");
 	for (j = 0; j < nthreads; j++)
@@ -915,8 +919,8 @@ static void print_stat(struct thread_par
 				stat->cycleofmax = stat->cyclesread;
 			}
 			if (++stat->reduce == oscope_reduction) {
-				printf("%8d:%8lu:%8ld\n", index, stat->cycleofmax,
-				    stat->redmax);
+				printf("%8d:%8lu:%8ld\n", index,
+				       stat->cycleofmax, stat->redmax);
 				stat->reduce = 0;
 				stat->redmax = 0;
 			}
@@ -971,7 +975,7 @@ int main(int argc, char **argv)
 			perror("mlockall");
 			goto out;
 		}
-		
+
 	kernelversion = check_kernel();
 
 	if (kernelversion == KV_NOT_26)
@@ -1070,9 +1074,7 @@ int main(int argc, char **argv)
 			if(max_cycles && stat[i].cycles >= max_cycles)
 				allstopped++;
 		}
-		if (duration) {
-			
-		}
+
 		usleep(10000);
 		if (shutdown || allstopped)
 			break;
@@ -1100,7 +1102,7 @@ int main(int argc, char **argv)
 
 	if (histogram) {
 		print_hist(par, num_threads);
-		for (i = 0; i < num_threads; i++) 
+		for (i = 0; i < num_threads; i++)
 			free (stat[i].hist_array);
 	}
 


