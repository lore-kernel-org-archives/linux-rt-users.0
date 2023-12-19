Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25DC881E
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Dec 2023 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7NdH0fO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702957073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qCHtQN9k2pSS0Fx5Z75sts/MUa73yWvvfx9pLiV3Qc=;
	b=L7NdH0fOp4FKLFJiKBsGtDv0eyIFn7xDEHiu6ZRzLXSFz8yKVs1LUjtAOcyfojSNt1skx3
	ppHWoQ7mbHnt5xD0PSX2X/2xjXF1CGulF7amN77EudtbtdgHsVq8egTqO3uxdZ5B+lPVpl
	Z0yYpUjODpLxas2N8HuNf+zu2MvQJU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-QuzQY6nPOFqLlTN8dBYd2Q-1; Mon, 18 Dec 2023 22:37:52 -0500
X-MC-Unique: QuzQY6nPOFqLlTN8dBYd2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2915830F2F
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Dec 2023 03:37:51 +0000 (UTC)
Received: from p1g2.hsd1.mn.comcast.net (unknown [10.2.16.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F2662166B31;
	Tue, 19 Dec 2023 03:37:51 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/2] rt-tests: cyclicdeadline: Add histogram support
Date: Mon, 18 Dec 2023 21:37:50 -0600
Message-ID: <20231219033750.334327-3-crwood@redhat.com>
In-Reply-To: <20231219033750.334327-1-crwood@redhat.com>
References: <20231219033750.334327-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Add support for the --histogram and --histfile options as in cyclictest.
The short -h option is not supported, as cyclicdeadline already uses that
for help.  -H/--histofall is not supported but could be easily added.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: Fix a checkpatch warning

 src/sched_deadline/cyclicdeadline.c | 114 +++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 10 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 097e2e5d4580..e449be57870e 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -33,6 +33,7 @@
 #include "rt-utils.h"
 #include "rt-sched.h"
 #include "rt-error.h"
+#include "histogram.h"
 
 #define _STR(x) #x
 #define STR(x) _STR(x)
@@ -40,6 +41,8 @@
 #define MAXPATH 1024
 #endif
 
+#define HIST_MAX	1000000
+
 #define CPUSET_ALL	"my_cpuset_all"
 #define CPUSET_LOCAL	"my_cpuset"
 
@@ -56,16 +59,13 @@ struct thread_stat {
 	long act;
 	double avg;
 	long *values;
-	long *hist_array;
-	long *outliers;
+	struct histogram *hist;
 	pthread_t thread;
 	int threadstarted;
 	int tid;
 	long reduce;
 	long redmax;
 	long cycleofmax;
-	long hist_overflow;
-	long num_outliers;
 };
 
 struct sched_data {
@@ -84,6 +84,8 @@ static int info_enable;
 static int debug_enable;
 static int tracelimit;
 static int trace_marker;
+static int histogram;
+static FILE *histfile;
 static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
 static pid_t break_thread_id;
 static uint64_t break_thread_value;
@@ -97,6 +99,8 @@ static int mark_fd;
 static int quiet;
 static char jsonfile[MAX_PATH];
 
+static struct histoset hset;
+
 static int find_mount(const char *mount, char *debugfs)
 {
 	char type[100];
@@ -691,6 +695,10 @@ static void usage(int error)
 	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
 	       "                           days\n"
 	       "-h       --help            Show this help menu.\n"
+	       "         --histogram=US    dump a latency histogram to stdout after the run\n"
+	       "                           US is the max latency time to be tracked in microseconds\n"
+	       "			   This option runs all threads at the same priority.\n"
+	       "	 --histfile=<path> dump the latency histogram to <path> instead of stdout\n"
 	       "-i INTV  --interval        The shortest deadline for the tasks in us\n"
 	       "                           (default 1000us).\n"
 	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
@@ -718,6 +726,55 @@ static u64 get_time_us(void)
 	return time;
 }
 
+static void print_hist(FILE *fp, struct sched_data *sd, int nthreads)
+{
+	int i;
+	unsigned long maxmax, alloverflows;
+
+	fprintf(fp, "# Histogram\n");
+	for (i = 0; i < histogram; i++) {
+		unsigned long flags = 0;
+
+		fprintf(fp, "%06d ", i);
+
+		hset_print_bucket(&hset, fp, i, flags);
+		fprintf(fp, "\n");
+	}
+	fprintf(fp, "# Min Latencies:");
+	for (i = 0; i < nthreads; i++)
+		fprintf(fp, " %05lu", sd[i].stat.min);
+	fprintf(fp, "\n");
+	fprintf(fp, "# Avg Latencies:");
+	for (i = 0; i < nthreads; i++)
+		fprintf(fp, " %05lu", sd[i].stat.cycles ?
+		       (long)(sd[i].stat.avg/sd[i].stat.cycles) : 0);
+	fprintf(fp, "\n");
+	fprintf(fp, "# Max Latencies:");
+	maxmax = 0;
+	for (i = 0; i < nthreads; i++) {
+		fprintf(fp, " %05lu", sd[i].stat.max);
+		if (sd[i].stat.max > maxmax)
+			maxmax = sd[i].stat.max;
+	}
+	fprintf(fp, "\n");
+	fprintf(fp, "# Histogram Overflows:");
+	alloverflows = 0;
+	for (i = 0; i < nthreads; i++) {
+		fprintf(fp, " %05lu", sd[i].stat.hist->oflow_count);
+		alloverflows += sd[i].stat.hist->oflow_count;
+	}
+	fprintf(fp, "\n");
+
+	fprintf(fp, "# Histogram Overflow at cycle number:\n");
+	for (i = 0; i < nthreads; i++) {
+		fprintf(fp, "# Thread %d: ", i);
+		hist_print_oflows(sd[i].stat.hist, fp);
+		fprintf(fp, "\n");
+	}
+
+	fprintf(fp, "\n");
+}
+
 static void print_stat(FILE *fp, struct sched_data *sd, int index, int verbose, int quiet)
 {
 	struct thread_stat *stat = &sd->stat;
@@ -784,6 +841,9 @@ static u64 do_runtime(struct sched_data *sd, u64 period)
 	stat->act = diff;
 	stat->avg += (double) diff;
 
+	if (histogram)
+		hist_sample(stat->hist, diff);
+
 	stat->cycles++;
 
 	return next_period;
@@ -1058,8 +1118,14 @@ static void loop(struct sched_data *sched_data, int nr_threads)
 	if (!quiet) {
 		printf("\033[%dB", nr_threads + 2);
 	} else {
-		for (i = 0; i < nr_threads; ++i)
-			print_stat(stdout, &sched_data[i], i, 0, 0);
+		if (histogram) {
+			FILE *out = histfile ? histfile : stdout;
+
+			print_hist(out, sched_data, nr_threads);
+		} else {
+			for (i = 0; i < nr_threads; ++i)
+				print_stat(stdout, &sched_data[i], i, 0, 0);
+		}
 	}
 }
 
@@ -1075,10 +1141,14 @@ static void write_stats(FILE *f, void *data)
 	for (i = 0; i < nr_threads; i++) {
 		s = &sd[i].stat;
 		fprintf(f, "    \"%u\": {\n", i);
-		fprintf(f, "	 \"cycles\": %ld,\n", s->cycles);
-		fprintf(f, "	 \"min\": %ld,\n", s->min);
-		fprintf(f, "	 \"max\": %ld,\n", s->max);
-		fprintf(f, "	 \"avg\": %.2f\n", s->avg/s->cycles);
+
+		fprintf(f, "      \"histogram\": {");
+		hist_print_json(s->hist, f);
+		fprintf(f, "      },\n");
+		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
+		fprintf(f, "      \"min\": %ld,\n", s->min);
+		fprintf(f, "      \"max\": %ld,\n", s->max);
+		fprintf(f, "      \"avg\": %.2f\n", s->avg/s->cycles);
 		fprintf(f, "    }%s\n", i == nr_threads - 1 ? "" : ",");
 	}
 	fprintf(f, "  }\n");
@@ -1088,6 +1158,7 @@ enum options_values {
 	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
 	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET,
 	OPT_BREAKTRACE, OPT_TRACEMARK, OPT_INFO, OPT_DEBUG,
+	OPT_HISTOGRAM, OPT_HISTFILE
 };
 
 int main(int argc, char **argv)
@@ -1130,6 +1201,8 @@ int main(int argc, char **argv)
 			{ "tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
 			{ "verbose",	no_argument,	NULL,	OPT_INFO},
 			{ "debug",	no_argument, 	NULL, 	OPT_DEBUG},
+			{ "histogram",	required_argument, NULL, OPT_HISTOGRAM },
+			{ "histfile",	required_argument, NULL, OPT_HISTFILE },
 			{ NULL,		0,			NULL,	0   },
 		};
 		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
@@ -1188,6 +1261,17 @@ int main(int argc, char **argv)
 		case OPT_DEBUG:
 			debug_enable = 1;
 			break;
+		case OPT_HISTOGRAM:
+			histogram = atoi(optarg);
+			if (histogram <= 0 || histogram > HIST_MAX)
+				usage(1);
+			break;
+		case OPT_HISTFILE:
+			histfile = fopen(optarg, "w");
+			if (!histfile)
+				fatal("Couldn\'t open histfile %s: %s\n",
+				      optarg, strerror(errno));
+			break;
 		default:
 			usage(1);
 		}
@@ -1233,6 +1317,10 @@ int main(int argc, char **argv)
 	if (!thread || !sched_data)
 		fatal("allocating threads");
 
+	if (histogram && hset_init(&hset, nr_threads, 1, histogram, histogram))
+		fatal("failed to allocate histogram of size %d for %d threads\n",
+		      histogram, nr_threads);
+
 	if (nr_threads > nr_cpus) {
 		/*
 		 * More threads than CPUs, then have the total be
@@ -1262,6 +1350,9 @@ int main(int argc, char **argv)
 		sd->runtime_us = runtime;
 		sd->deadline_us = interval;
 
+		if (histogram)
+			sd->stat.hist = &hset.histos[i];
+
 		info(info_enable, "interval: %lld:%lld\n", sd->runtime_us, sd->deadline_us);
 
 		/* Make sure that we can make our deadlines */
@@ -1356,6 +1447,9 @@ int main(int argc, char **argv)
 		free(setcpu_buf);
 	free(thread);
 	free(sched_data);
+	if (histfile)
+		fclose(histfile);
+	hset_destroy(&hset);
 
 	return 0;
 }
-- 
2.43.0

