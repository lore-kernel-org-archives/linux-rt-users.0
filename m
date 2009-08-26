From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: cyclictest: add --update_on_max option
Date: Wed, 26 Aug 2009 13:11:33 -0300
Message-ID: <20090826161132.GB5255@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbZHZQLg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Aug 2009 12:11:36 -0400
Received: from int-mx07.intmail.prod.int.phx2.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7QGBcJr023202
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2009 12:11:38 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When running on a machine with not enough bandwidth it can be helpful to
only update the status when a new max is hit.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2b4dc50..8181ff7 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -135,6 +135,7 @@ struct thread_stat {
 	pthread_t thread;
 	int threadstarted;
 	int tid;
+	int new_max;
 	long reduce;
 	long redmax;
 	long cycleofmax;
@@ -147,6 +148,7 @@ static int kernelversion;
 static int verbose = 0;
 static int oscope_reduction = 1;
 static int lockall = 0;
+static int refresh_on_max;
 static int tracetype = NOTRACE;
 static int histogram = 0;
 static int histogram_limit_exceeded = 0;
@@ -685,8 +687,10 @@ void *timerthread(void *param)
 			diff = calcdiff(now, next);
 		if (diff < stat->min)
 			stat->min = diff;
-		if (diff > stat->max)
+		if (diff > stat->max) {
 			stat->max = diff;
+			++stat->new_max;
+		}
 		stat->avg += (double) diff;
 
 		if (duration && (calcdiff(now, stop) >= 0))
@@ -904,6 +908,7 @@ static void process_options (int argc, char *argv[])
 			{"irqsoff", no_argument, NULL, 'I'},
 			{"loops", required_argument, NULL, 'l'},
 			{"mlockall", no_argument, NULL, 'm' },
+			{"refresh_on_max", no_argument, NULL, 'M' },
 			{"nanosleep", no_argument, NULL, 'n'},
 			{"nsecs", no_argument, NULL, 'N'},
 			{"oscope", required_argument, NULL, 'o'},
@@ -923,7 +928,7 @@ static void process_options (int argc, char *argv[])
 			{"traceopt", required_argument, NULL, 'O'},
 			{NULL, 0, NULL, 0}
 		};
-                int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:O:p:Pmqrst::vD:wWTy:",
+                int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:MnNo:O:p:Pmqrst::vD:wWTy:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -974,6 +979,7 @@ static void process_options (int argc, char *argv[])
 		case 'T': strncpy(tracer, optarg, sizeof(tracer)); break;
 		case 'v': verbose = 1; break;
 		case 'm': lockall = 1; break;
+		case 'M': refresh_on_max = 1; break;
 		case 'D': duration = parse_time_string(optarg);
 			break;
                 case 'w': tracetype = WAKEUP; break;
@@ -1124,6 +1130,7 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 			else
                                 fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
 					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
+
                         printf(fmt, index, stat->tid, par->prio, 
                                par->interval, stat->cycles, stat->min, stat->act,
 			       stat->cycles ?
@@ -1271,13 +1278,13 @@ int main(int argc, char **argv)
 
 	while (!shutdown) {
 		char lavg[256];
-		int fd, len, allstopped = 0;
+		int fd, len, allstopped = 0, threads_with_new_max = 0;
 		char *policystr = NULL;
 
 		if (!policystr)
 			policystr = policyname(policy);
 
-		if (!verbose && !quiet) {
+		if (!verbose && !quiet && !refresh_on_max) {
 			fd = open("/proc/loadavg", O_RDONLY, 0666);
 			len = read(fd, &lavg, 255);
 			close(fd);
@@ -1287,8 +1294,13 @@ int main(int argc, char **argv)
 		}
 
 		for (i = 0; i < num_threads; i++) {
-
-			print_stat(&par[i], i, verbose);
+			if (!refresh_on_max || par[i].stats->new_max) {
+				print_stat(&par[i], i, verbose);
+				if (par[i].stats->new_max)
+					--par[i].stats->new_max;
+				threads_with_new_max++;
+			}
+			
 			if(max_cycles && stat[i].cycles >= max_cycles)
 				allstopped++;
 		}
@@ -1296,8 +1308,11 @@ int main(int argc, char **argv)
 		usleep(10000);
 		if (shutdown || allstopped)
 			break;
-		if (!verbose && !quiet)
-			printf("\033[%dA", num_threads + 2);
+		if (!verbose && !quiet && threads_with_new_max) {
+			if (!refresh_on_max)
+				threads_with_new_max += 2;
+			printf("\033[%dA", threads_with_new_max);
+		}
 	}
 	ret = EXIT_SUCCESS;
 
