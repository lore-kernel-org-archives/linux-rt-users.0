Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B9BC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D76B61166
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJNHPy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhJNHPy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:54 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F2C061570
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so4651559pgc.12
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgHScnm555Yo9sWc4WQffFMB79OR8lp0orWjBojakUU=;
        b=bqj9YQORbkdRCyTBQIhnayF+W49WKr1gKC+czE6Wp4zy2SYtNO1wHaBwH4JmrIV8iq
         9ac3/JMjA7PHCpjjOQgxh6kwmpQsGxIPmddsmFBsTTkjlwq/tnGDOHrLbeLmDUoy9AWp
         h5CR/qLvbYbKlCMJJzPT47HkHqELmrSD5G3SVaEaAyC/wgbLQmm6RVyPQC1pJaYJIpTm
         KGqNlFINGAGxxBFSCWp8r51VAeapqypA1GwJKPK3dnqC3Qy31fRNZ+IK1CjinBp7AIQN
         bZgg3tQJC3KXlHGFXu5ZygbHMJTN3wlx7lLOPg5Z+dwLsyFaLHq17XoSPUqhkCWk5att
         BNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgHScnm555Yo9sWc4WQffFMB79OR8lp0orWjBojakUU=;
        b=6r6QdjiMlvN0GJRRQtaL9uEpgAMfMVtd8oDI4P0AkZfcPT6jffWXqjdi4NW499XxC+
         DvIGx5H35feiRZr/B8VtsxtsTBXqpi6zo5pF7MRBZUU1akXnas3Kuu0tITVPfseukYsz
         Rew9pdPiFB7RO//VNLwBJeYcBUkTTLN6ukhgNMcPJCEAZiXViUUbjWZppClq+OvZRrvN
         NpvRclXFKZ8us/v99VPsAO7uzZo+jSAfjnLSq3DW3VHXbtdRCglC08aNzQ8mr6YAuenw
         Sncv7E+3JyxhrN9DbWnZGmmMW9UqNtl4j/bBHWr4nGVxDa8VFEeURWWTG1u5KL8iapoR
         9O8w==
X-Gm-Message-State: AOAM532FnMYg5xQs1b8w1mkYMn3ouEonwhv5LJvWe3IJYcggNHcgOOO8
        kAQ0/uqcCYH+ffjK0FbmxwPM2pUIbWM=
X-Google-Smtp-Source: ABdhPJwWxeeUIOzdhn5tIlh04UUbv3OhGVeBlkywkUscs0d0Gnz62EW+y2vFax/wg+WIkZJfqU9JsQ==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr2967269pgt.15.1634195629354;
        Thu, 14 Oct 2021 00:13:49 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id k127sm1530005pfd.1.2021.10.14.00.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:13:48 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: [RFC 7/7] rt-tests: cyclictest: Add support to report standard deviation
Date:   Thu, 14 Oct 2021 16:12:47 +0900
Message-Id: <20211014071247.4165329-8-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211014071247.4165329-1-punitagrawal@gmail.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

For real time systems, the standard deviation is an important metric
to help qualify the suitability for low-latency workloads. Downstream
tools such as rteval calculate the value of the standard deviation
based on the latency histogram but this approach doesn't work in
situations when the max latency exceeds the range of the histogram.

The common formula to calculating standard deviation requires tracking
all samples which is not feasible. But an alternative approach is to
track the streaming standard deviation of the latency samples. With
this it is possible to update the standard deviation using -

         d = d' + (x - avg)(x - avg')

    stddev = sqrt (d / (n - 1))

where 'd' is similar to the variance, 'x' is the current latency
sample, 'n' is the number of samples and prime terms (') refer to the
previous values.

Implement the above algorithm to calculate the standard deviation and
update the reporting to also include standard deviation.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 Makefile                    |  2 +-
 src/cyclictest/cyclictest.c | 43 +++++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index ec5d693436d0..3f08788c0208 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ sources = cyclictest.c \
 	  oslat.c
 
 TARGETS = $(sources:.c=)
-LIBS	= -lrt -lpthread
+LIBS	= -lrt -lpthread -lm
 RTTESTLIB = -lrttest -L$(OBJDIR)
 EXTRA_LIBS ?= -ldl	# for get_cpu
 RTTESTNUMA = -lrttestnuma -lnuma
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dde8b1625c62..2c18013a7643 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -23,6 +23,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <linux/unistd.h>
+#include <math.h>
 
 #include <sys/prctl.h>
 #include <sys/stat.h>
@@ -134,6 +135,7 @@ struct thread_stat {
 	long max;
 	long act;
 	double avg;
+	double var;
 	long *values;
 	long *smis;
 	long *hist_array;
@@ -358,6 +360,16 @@ try_again:
 	return err;
 }
 
+static double calc_stddev(struct thread_stat *stat)
+{
+	/* standard deviation of single samples is 0 */
+	if (stat->cycles <= 1)
+		return 0;
+
+	return sqrt(stat->var / (stat->cycles - 1));
+}
+
+
 #ifdef ARCH_HAS_SMI_COUNTER
 static int open_msr_file(int cpu)
 {
@@ -750,6 +762,17 @@ static void *timerthread(void *param)
 		prev_avg = stat->avg;
 		stat->avg = prev_avg + ((diff - prev_avg) / stat->cycles);
 
+		/*
+		 * Calculate a slight variation on variance - the
+		 * variance multiplied by (n - 1). This allows
+		 * updating the quantity as data becomes available
+		 * without keeping track of all past samples or averages.
+		 *
+		 * (n - 1) * var = var' + (x - avg) * (x - avg')
+		 *
+		 */
+		stat->var += (diff - stat->avg) * (diff - prev_avg);
+
 		next.tv_sec += interval.tv_sec;
 		next.tv_nsec += interval.tv_nsec;
 		if (par->mode == MODE_CYCLIC) {
@@ -1379,6 +1402,10 @@ static void print_hist(struct thread_param *par[], int nthreads)
 		fprintf(fd, " %05lu", par[j]->stats->cycles ?
 		       (long)(par[j]->stats->avg/par[j]->stats->cycles) : 0);
 	fprintf(fd, "\n");
+	fprintf(fd, "# StdDev Latencies:");
+	for (j = 0; j < nthreads; j++)
+		fprintf(fd, " %05lu", (long)calc_stddev(par[j]->stats));
+	fprintf(fd, "\n");
 	fprintf(fd, "# Max Latencies:");
 	maxmax = 0;
 	for (j = 0; j < nthreads; j++) {
@@ -1430,14 +1457,15 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
 			char *fmt;
 			if (use_nsecs)
 				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
-				        "Min:%7ld Act:%8ld Avg:%8ld Max:%8ld";
+				        "Min:%7ld Act:%8ld Avg:%8ld StdDev:%8ld Max:%8ld";
 			else
 				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
-				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
+				        "Min:%7ld Act:%5ld Avg:%5ld StdDev:%5ld Max:%8ld";
 
 			fprintf(fp, fmt, index, stat->tid, par->prio,
 				par->interval, stat->cycles, stat->min,
-				stat->act, (long)stat->avg, stat->max);
+				stat->act, (long)stat->avg, (long)calc_stddev(stat),
+				stat->max);
 
 			if (smi)
 				fprintf(fp, " SMI:%8ld", stat->smi_count);
@@ -1485,14 +1513,15 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 			char *fmt;
 			if (use_nsecs)
 				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
-				        "Min:%7ld Act:%8ld Avg:%8ld Max:%8ld";
+				        "Min:%7ld Act:%8ld Avg:%8ld StdDev:%8ld Max:%8ld";
 			else
 				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
-				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
+				        "Min:%7ld Act:%5ld Avg:%5ld StdDev:%5ld Max:%8ld";
 
 			dprintf(fd, fmt, index, stat->tid, par->prio,
 				par->interval, stat->cycles, stat->min,
-				stat->act, (long)stat->avg, stat->max);
+				stat->act, (long)stat->avg, (long)calc_stddev(stat),
+				stat->max);
 
 			if (smi)
 				dprintf(fd, " SMI:%8ld", stat->smi_count);
@@ -1781,6 +1810,7 @@ static void write_stats(FILE *f, void *data)
 		fprintf(f, "      \"min\": %ld,\n", s->min);
 		fprintf(f, "      \"max\": %ld,\n", s->max);
 		fprintf(f, "      \"avg\": %.2f,\n", s->avg);
+		fprintf(f, "      \"stddev\": %.2f,\n", calc_stddev(s));
 		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
 		fprintf(f, "      \"node\": %d\n", par[i]->node);
 		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
@@ -2091,6 +2121,7 @@ int main(int argc, char **argv)
 		stat->min = 1000000;
 		stat->max = 0;
 		stat->avg = 0.0;
+		stat->var = 0;
 		stat->threadstarted = 1;
 		stat->smi_count = 0;
 		status = pthread_create(&stat->thread, &attr, timerthread, par);
-- 
2.32.0

