Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A98826
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Dec 2023 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjo3NjEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702957073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsWmMs/5awSPUPz4Gc6Q768YzO7gvSEDuoxTO3e2EPY=;
	b=fjo3NjEGiE9leNhdN8jZZESZ/djyHo4cAUqwF6wEWoJbpzwgn3nQGP79S1TZuHbJtDSsA8
	Uw8dkcHRV8BhJALnRbce5oVTbTr2OhkNosDtYk5qqpOInMBFM1fJAmUpk5G7nqq6ddaCgL
	o8/ejdc2mnGuyledF8GWXsUI4BGRUkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-R_dXrHGPOOOiqtNyNguogQ-1; Mon, 18 Dec 2023 22:37:51 -0500
X-MC-Unique: R_dXrHGPOOOiqtNyNguogQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56F0A185A781
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Dec 2023 03:37:51 +0000 (UTC)
Received: from p1g2.hsd1.mn.comcast.net (unknown [10.2.16.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E80DA2166B31;
	Tue, 19 Dec 2023 03:37:50 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 1/2] rt-tests: cyclictest: Replace histogram code with library
Date: Mon, 18 Dec 2023 21:37:49 -0600
Message-ID: <20231219033750.334327-2-crwood@redhat.com>
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

The new code is also intended to be used by cyclicdeadline, and possibly
oslat and other tests.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: Fix some checkpatch warnings

 Makefile                    |   3 +-
 src/cyclictest/cyclictest.c |  82 +++++------------
 src/include/histogram.h     |  42 +++++++++
 src/lib/histogram.c         | 172 ++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+), 60 deletions(-)
 create mode 100644 src/include/histogram.h
 create mode 100644 src/lib/histogram.c

diff --git a/Makefile b/Makefile
index ad481a73cf93..9502adea49cf 100644
--- a/Makefile
+++ b/Makefile
@@ -178,7 +178,8 @@ oslat: $(OBJDIR)/oslat.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
 %.8.bz2: %.8
 	bzip2 -c $< > $@
 
-LIBOBJS =$(addprefix $(OBJDIR)/,rt-error.o rt-get_cpu.o rt-sched.o rt-utils.o)
+LIBOBJS =$(addprefix $(OBJDIR)/,rt-error.o rt-get_cpu.o rt-sched.o rt-utils.o \
+	histogram.o)
 $(OBJDIR)/librttest.a: $(LIBOBJS)
 	$(AR) rcs $@ $^
 
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 93ce201e9fca..6169170fc66d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -35,6 +35,7 @@
 #include "rt-utils.h"
 #include "rt-numa.h"
 #include "rt-error.h"
+#include "histogram.h"
 
 #include <bionic.h>
 
@@ -133,16 +134,13 @@ struct thread_stat {
 	double avg;
 	long *values;
 	long *smis;
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
 	unsigned long smi_count;
 };
 
@@ -216,6 +214,7 @@ static char jsonfile[MAX_PATH];
 
 static struct thread_param **parameters;
 static struct thread_stat **statistics;
+static struct histoset hset;
 
 static void print_stat(FILE *fp, struct thread_param *par, int index, int verbose, int quiet);
 static void rstat_print_stat(struct thread_param *par, int index, int verbose, int quiet);
@@ -777,15 +776,8 @@ static void *timerthread(void *param)
 		}
 
 		/* Update the histogram */
-		if (histogram) {
-			if (diff >= histogram) {
-				stat->hist_overflow++;
-				if (stat->num_outliers < histogram)
-					stat->outliers[stat->num_outliers++] = stat->cycles;
-			} else {
-				stat->hist_array[diff]++;
-			}
-		}
+		if (histogram)
+			hist_sample(stat->hist, diff);
 
 		stat->cycles++;
 
@@ -1422,19 +1414,13 @@ static void print_hist(struct thread_param *par[], int nthreads)
 
 	fprintf(fd, "# Histogram\n");
 	for (i = 0; i < histogram; i++) {
-		unsigned long long int allthreads = 0;
+		unsigned long flags = 0;
 
 		fprintf(fd, "%06d ", i);
 
-		for (j = 0; j < nthreads; j++) {
-			unsigned long curr_latency=par[j]->stats->hist_array[i];
-			fprintf(fd, "%06lu", curr_latency);
-			if (j < nthreads - 1)
-				fprintf(fd, "\t");
-			allthreads += curr_latency;
-		}
-		if (histofall && nthreads > 1)
-			fprintf(fd, "\t%06llu", allthreads);
+		if (histofall)
+			flags |= HSET_PRINT_SUM;
+		hset_print_bucket(&hset, fd, i, flags);
 		fprintf(fd, "\n");
 	}
 	fprintf(fd, "# Min Latencies:");
@@ -1459,8 +1445,8 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	fprintf(fd, "# Histogram Overflows:");
 	alloverflows = 0;
 	for (j = 0; j < nthreads; j++) {
-		fprintf(fd, " %05lu", par[j]->stats->hist_overflow);
-		alloverflows += par[j]->stats->hist_overflow;
+		fprintf(fd, " %05lu", par[j]->stats->hist->oflow_count);
+		alloverflows += par[j]->stats->hist->oflow_count;
 	}
 	if (histofall && nthreads > 1)
 		fprintf(fd, " %05lu", alloverflows);
@@ -1468,11 +1454,8 @@ static void print_hist(struct thread_param *par[], int nthreads)
 
 	fprintf(fd, "# Histogram Overflow at cycle number:\n");
 	for (i = 0; i < nthreads; i++) {
-		fprintf(fd, "# Thread %d:", i);
-		for (j = 0; j < par[i]->stats->num_outliers; j++)
-			fprintf(fd, " %05lu", par[i]->stats->outliers[j]);
-		if (par[i]->stats->num_outliers < par[i]->stats->hist_overflow)
-			fprintf(fd, " # %05lu others", par[i]->stats->hist_overflow - par[i]->stats->num_outliers);
+		fprintf(fd, "# Thread %d: ", i);
+		hist_print_oflows(par[i]->stats->hist, fd);
 		fprintf(fd, "\n");
 	}
 	if (smi) {
@@ -1788,8 +1771,7 @@ rstat_err:
 static void write_stats(FILE *f, void *data __attribute__ ((unused)))
 {
 	struct thread_param **par = parameters;
-	int i, j;
-	unsigned comma;
+	int i;
 	struct thread_stat *s;
 
 	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
@@ -1800,15 +1782,7 @@ static void write_stats(FILE *f, void *data __attribute__ ((unused)))
 
 		fprintf(f, "      \"histogram\": {");
 		s = par[i]->stats;
-		for (j = 0, comma = 0; j < histogram; j++) {
-			if (s->hist_array[j] == 0)
-				continue;
-			fprintf(f, "%s", comma ? ",\n" : "\n");
-			fprintf(f, "        \"%u\": %ld", j, s->hist_array[j]);
-			comma = 1;
-		}
-		if (comma)
-			fprintf(f, "\n");
+		hist_print_json(par[i]->stats->hist, f);
 		fprintf(f, "      },\n");
 		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
 		fprintf(f, "      \"min\": %ld,\n", s->min);
@@ -1991,6 +1965,10 @@ int main(int argc, char **argv)
 	/* Set-up shm */
 	rstat_setup();
 
+	if (histogram && hset_init(&hset, num_threads, 1, histogram, histogram))
+		fatal("failed to allocate histogram of size %d for %d threads\n",
+		      histogram, num_threads);
+
 	parameters = calloc(num_threads, sizeof(struct thread_param *));
 	if (!parameters)
 		goto out;
@@ -2066,18 +2044,8 @@ int main(int argc, char **argv)
 			fatal("error allocating thread status struct for thread %d\n", i);
 		memset(stat, 0, sizeof(struct thread_stat));
 
-		/* allocate the histogram if requested */
-		if (histogram) {
-			int bufsize = histogram * sizeof(long);
-
-			stat->hist_array = threadalloc(bufsize, node);
-			stat->outliers = threadalloc(bufsize, node);
-			if (stat->hist_array == NULL || stat->outliers == NULL)
-				fatal("failed to allocate histogram of size %d on node %d\n",
-				      histogram, i);
-			memset(stat->hist_array, 0, bufsize);
-			memset(stat->outliers, 0, bufsize);
-		}
+		if (histogram)
+			stat->hist = &hset.histos[i];
 
 		if (verbose) {
 			int bufsize = VALBUF_SIZE * sizeof(long);
@@ -2215,13 +2183,8 @@ int main(int argc, char **argv)
 	if (trigger)
 		trigger_print();
 
-	if (histogram) {
+	if (histogram)
 		print_hist(parameters, num_threads);
-		for (i = 0; i < num_threads; i++) {
-			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
-			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
-		}
-	}
 
 	if (tracelimit) {
 		print_tids(parameters, num_threads);
@@ -2263,5 +2226,6 @@ int main(int argc, char **argv)
 	if (rstat_fd >= 0)
 		shm_unlink(shm_name);
 
+	hset_destroy(&hset);
 	exit(ret);
 }
diff --git a/src/include/histogram.h b/src/include/histogram.h
new file mode 100644
index 000000000000..c7aba68ffb99
--- /dev/null
+++ b/src/include/histogram.h
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <stdint.h>
+#include <stdio.h>
+
+struct histogram {
+	unsigned long *buckets;
+	unsigned long width;		// interval covered by one bucket
+	unsigned long num;		// number of buckets
+	unsigned long events;		// number of events logged
+
+	unsigned long *oflows;		// events when overflow happened
+	unsigned long oflow_bufsize;	// number of overflows that can be logged
+	unsigned long oflow_count;	// number of events that overflowed
+	uint64_t oflow_magnitude;	// sum of how many buckets overflowed by
+};
+
+struct histoset {
+	struct histogram *histos;	// Group of related histograms (e.g. per cpu)
+	struct histogram *sum;		// Accumulates events from all histos
+	unsigned long num_histos;	// Not including sum
+	unsigned long num_buckets;
+};
+
+#define HIST_OVERFLOW		1
+#define HIST_OVERFLOW_MAG	2
+#define HIST_OVERFLOW_LOG	4
+
+int hist_init(struct histogram *h, unsigned long width, unsigned long num);
+int hist_init_oflow(struct histogram *h, unsigned long num);
+void hist_destroy(struct histogram *h);
+int hist_sample(struct histogram *h, uint64_t sample);
+
+#define HSET_PRINT_SUM		1
+#define HSET_PRINT_JSON		2
+
+int hset_init(struct histoset *hs, unsigned long histos, unsigned long bucket_width,
+	      unsigned long num_buckets, unsigned long overflow);
+void hset_destroy(struct histoset *hs);
+void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
+		       unsigned long flags);
+void hist_print_json(struct histogram *h, FILE *f);
+void hist_print_oflows(struct histogram *h, FILE *f);
diff --git a/src/lib/histogram.c b/src/lib/histogram.c
new file mode 100644
index 000000000000..35a9d604da86
--- /dev/null
+++ b/src/lib/histogram.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Latency histograms
+ *
+ * Copyright 2023 Red Hat Inc.
+ */
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include "histogram.h"
+
+int hist_init(struct histogram *h, unsigned long width, unsigned long num)
+{
+	memset(h, 0, sizeof(*h));
+	h->width = width;
+	h->num = num;
+
+	h->buckets = calloc(num, sizeof(unsigned long));
+	if (!h->buckets)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int hist_init_oflow(struct histogram *h, unsigned long num)
+{
+	h->oflow_bufsize = num;
+	h->oflows = calloc(num, sizeof(unsigned long));
+	if (!h->oflows)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void hist_destroy(struct histogram *h)
+{
+	free(h->oflows);
+	h->oflows = NULL;
+	free(h->buckets);
+	h->buckets = NULL;
+}
+
+int hist_sample(struct histogram *h, uint64_t sample)
+{
+	unsigned long bucket = sample / h->width;
+	unsigned long extra;
+	unsigned long event = h->events++;
+	int ret;
+
+	if (bucket < h->num) {
+		h->buckets[bucket]++;
+		return 0;
+	}
+
+	ret = HIST_OVERFLOW;
+	extra = bucket - h->num;
+	if (h->oflow_magnitude + extra > h->oflow_magnitude)
+		h->oflow_magnitude += extra;
+	else
+		ret |= HIST_OVERFLOW_MAG;
+
+	if (h->oflows) {
+		if (h->oflow_count < h->oflow_bufsize)
+			h->oflows[h->oflow_count] = event;
+		else
+			ret |= HIST_OVERFLOW_LOG;
+	}
+
+	h->oflow_count++;
+	return ret;
+}
+
+int hset_init(struct histoset *hs, unsigned long num_histos,
+	      unsigned long bucket_width, unsigned long num_buckets,
+	      unsigned long overflow)
+{
+	unsigned long i;
+
+	if (num_histos == 0)
+		return -EINVAL;
+
+	hs->num_histos = num_histos;
+	hs->num_buckets = num_buckets;
+	hs->histos = calloc(num_histos, sizeof(struct histogram));
+	if (!hs->histos)
+		return -ENOMEM;
+
+	for (i = 0; i < num_histos; i++) {
+		if (hist_init(&hs->histos[i], bucket_width, num_buckets))
+			goto fail;
+		if (overflow && hist_init_oflow(&hs->histos[i], overflow))
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	hset_destroy(hs);
+	return -ENOMEM;
+}
+
+void hset_destroy(struct histoset *hs)
+{
+	unsigned long i;
+
+	if (hs->histos) {
+		for (i = 0; i < hs->num_histos; i++)
+			hist_destroy(&hs->histos[i]);
+	}
+
+	free(hs->histos);
+	hs->histos = NULL;
+}
+
+void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
+		       unsigned long flags)
+{
+	unsigned long long sum = 0;
+	unsigned long i;
+
+	if (bucket >= hs->num_buckets)
+		return;
+
+	for (i = 0; i < hs->num_histos; i++) {
+		unsigned long val = hs->histos[i].buckets[bucket];
+
+		sum += val;
+		if (i != 0)
+			fprintf(f, "\t");
+		fprintf(f, "%06lu", val);
+	}
+
+	if (flags & HSET_PRINT_SUM)
+		fprintf(f, "\t%06llu", sum);
+}
+
+void hist_print_json(struct histogram *h, FILE *f)
+{
+	unsigned long i;
+	bool comma = false;
+
+	for (i = 0; i < h->num; i++) {
+		unsigned long val = h->buckets[i];
+
+		if (val != 0) {
+			if (comma)
+				fprintf(f, ",");
+			fprintf(f, "\n        \"%lu\": %lu", i, val);
+			comma = true;
+		}
+	}
+
+	fprintf(f, "\n");
+}
+
+void hist_print_oflows(struct histogram *h, FILE *f)
+{
+	unsigned long i;
+
+	for (i = 0; i < h->oflow_count; i++) {
+		if (i >= h->oflow_bufsize)
+			break;
+		if (i != 0)
+			fprintf(f, " ");
+		fprintf(f, "%05lu", h->oflows[i]);
+	}
+
+	if (i >= h->oflow_bufsize)
+		fprintf(f, " # %05lu others", h->oflow_count - h->oflow_bufsize);
+}
-- 
2.43.0

