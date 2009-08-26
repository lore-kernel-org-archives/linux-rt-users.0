From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2] cyclictest: add --update_on_max option
Date: Wed, 26 Aug 2009 17:31:34 -0300
Message-ID: <20090826203134.GC5255@ghostprotocols.net>
References: <20090826161132.GB5255@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbZHZUbk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Aug 2009 16:31:40 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7QKVgow003476
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2009 16:31:42 -0400
Content-Disposition: inline
In-Reply-To: <20090826161132.GB5255@ghostprotocols.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Note: the previous one sucked rockz, please try this one instead.

When running on a machine with not enough bandwidth it can be helpful to
only update the status when a new max is hit.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2b4dc50..97461e5 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -152,7 +152,10 @@ static int histogram = 0;
 static int histogram_limit_exceeded = 0;
 static int duration = 0;
 static int use_nsecs = 0;
+static int refresh_on_max;
 
+static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
 
 /* Backup of kernel variables that we modify */
 static struct kvars {
@@ -685,8 +688,11 @@ void *timerthread(void *param)
 			diff = calcdiff(now, next);
 		if (diff < stat->min)
 			stat->min = diff;
-		if (diff > stat->max)
+		if (diff > stat->max) {
 			stat->max = diff;
+			if (refresh_on_max)
+				pthread_cond_signal(&refresh_on_max_cond);
+		}
 		stat->avg += (double) diff;
 
 		if (duration && (calcdiff(now, stop) >= 0))
@@ -904,6 +910,7 @@ static void process_options (int argc, char *argv[])
 			{"irqsoff", no_argument, NULL, 'I'},
 			{"loops", required_argument, NULL, 'l'},
 			{"mlockall", no_argument, NULL, 'm' },
+			{"refresh_on_max", no_argument, NULL, 'M' },
 			{"nanosleep", no_argument, NULL, 'n'},
 			{"nsecs", no_argument, NULL, 'N'},
 			{"oscope", required_argument, NULL, 'o'},
@@ -923,8 +930,8 @@ static void process_options (int argc, char *argv[])
 			{"traceopt", required_argument, NULL, 'O'},
 			{NULL, 0, NULL, 0}
 		};
-                int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:O:p:Pmqrst::vD:wWTy:",
-			long_options, &option_index);
+		int c = getopt_long(argc, argv, "a::b:Bc:Cd:Efh:i:Il:MnNo:O:p:Pmqrst::vD:wWTy:",
+				    long_options, &option_index);
 		if (c == -1)
 			break;
 		switch (c) {
@@ -974,6 +981,7 @@ static void process_options (int argc, char *argv[])
 		case 'T': strncpy(tracer, optarg, sizeof(tracer)); break;
 		case 'v': verbose = 1; break;
 		case 'm': lockall = 1; break;
+		case 'M': refresh_on_max = 1; break;
 		case 'D': duration = parse_time_string(optarg);
 			break;
                 case 'w': tracetype = WAKEUP; break;
@@ -1078,6 +1086,8 @@ static int check_timer(void)
 static void sighand(int sig)
 {
 	shutdown = 1;
+	if (refresh_on_max)
+		pthread_cond_signal(&refresh_on_max_cond);
 	if (tracelimit)
 		tracing(0);
 }
@@ -1298,6 +1308,13 @@ int main(int argc, char **argv)
 			break;
 		if (!verbose && !quiet)
 			printf("\033[%dA", num_threads + 2);
+
+		if (refresh_on_max) {
+			pthread_mutex_lock(&refresh_on_max_lock);
+			pthread_cond_wait(&refresh_on_max_cond,
+					  &refresh_on_max_lock);
+			pthread_mutex_unlock(&refresh_on_max_lock);
+		}
 	}
 	ret = EXIT_SUCCESS;
 
