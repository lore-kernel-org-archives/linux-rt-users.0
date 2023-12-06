Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCXsMQ11"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B77135
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Dec 2023 12:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701896112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwK1Vj/hG0okPNo1ESMlQ3O2302ubIPNZqf1FG4aMnY=;
	b=MCXsMQ11xyUmIGqxQfWIijagy0xs5RwICxTTloD8nz6zn8GTFqyChjOv32jQBSKUcNganp
	vpm+nyoebPLpe16m5cxDrvWnZgeGjnlup9w3yjCjnWSlQaibXVQmiwJ6y8gzcmgz172I9e
	w9HXQtD8KBPBkna6Tt772XSfY9hh5UA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-sWYzoMf7NEi7gIr-XTthTg-1; Wed,
 06 Dec 2023 15:55:11 -0500
X-MC-Unique: sWYzoMf7NEi7gIr-XTthTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2E523C0C4A2
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Dec 2023 20:55:10 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.17.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4D3C2026D66;
	Wed,  6 Dec 2023 20:55:10 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 4/4] rt-tests: cyclicdeadline: Add histogram support
Date: Wed,  6 Dec 2023 14:55:08 -0600
Message-ID: <20231206205508.17148-5-crwood@redhat.com>
In-Reply-To: <20231206205508.17148-1-crwood@redhat.com>
References: <20231206205508.17148-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Add support for the --histogram and --histfile options as in cyclictest.
The short -h option is not supported, as cyclicdeadline already uses that
for help.  -H/--histofall is not supported but could be easily added.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
Given the recent request for oslat, do we want to be able to do ns-granularity
histograms?  Or just stick with what cyclictest supports, as that's what rteval
wants?

Is histofall support needed?  rteval doesn't use it.
---
 src/sched_deadline/cyclicdeadline.c | 113 +++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 10 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 097e2e5d4580..f45ec3d6394b 100644
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
@@ -1058,8 +1118,13 @@ static void loop(struct sched_data *sched_data, int nr_threads)
 	if (!quiet) {
 		printf("\033[%dB", nr_threads + 2);
 	} else {
-		for (i = 0; i < nr_threads; ++i)
-			print_stat(stdout, &sched_data[i], i, 0, 0);
+		if (histogram) {
+			FILE *out = histfile ? histfile : stdout;
+			print_hist(out, sched_data, nr_threads);
+		} else {
+			for (i = 0; i < nr_threads; ++i)
+				print_stat(stdout, &sched_data[i], i, 0, 0);
+		}
 	}
 }
 
@@ -1075,10 +1140,14 @@ static void write_stats(FILE *f, void *data)
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
@@ -1088,6 +1157,7 @@ enum options_values {
 	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
 	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET,
 	OPT_BREAKTRACE, OPT_TRACEMARK, OPT_INFO, OPT_DEBUG,
+	OPT_HISTOGRAM, OPT_HISTFILE
 };
 
 int main(int argc, char **argv)
@@ -1130,6 +1200,8 @@ int main(int argc, char **argv)
 			{ "tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
 			{ "verbose",	no_argument,	NULL,	OPT_INFO},
 			{ "debug",	no_argument, 	NULL, 	OPT_DEBUG},
+			{ "histogram",	required_argument, NULL, OPT_HISTOGRAM },
+			{ "histfile",	required_argument, NULL, OPT_HISTFILE },
 			{ NULL,		0,			NULL,	0   },
 		};
 		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
@@ -1188,6 +1260,17 @@ int main(int argc, char **argv)
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
@@ -1233,6 +1316,10 @@ int main(int argc, char **argv)
 	if (!thread || !sched_data)
 		fatal("allocating threads");
 
+	if (histogram && hset_init(&hset, nr_threads, 1, histogram, histogram))
+		fatal("failed to allocate histogram of size %d for %d threads\n",
+		      histogram, nr_threads);
+
 	if (nr_threads > nr_cpus) {
 		/*
 		 * More threads than CPUs, then have the total be
@@ -1262,6 +1349,9 @@ int main(int argc, char **argv)
 		sd->runtime_us = runtime;
 		sd->deadline_us = interval;
 
+		if (histogram)
+			sd->stat.hist = &hset.histos[i];
+
 		info(info_enable, "interval: %lld:%lld\n", sd->runtime_us, sd->deadline_us);
 
 		/* Make sure that we can make our deadlines */
@@ -1356,6 +1446,9 @@ int main(int argc, char **argv)
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

