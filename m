Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AE5C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5D8610EA
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhJNHPt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJNHPt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A0C061570
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so5034805pjq.0
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6OUXR57gtwUzyorkLcDo+RaaDM9jtOgBawbttgR3Xo=;
        b=STS2hRz9fqRrFNXIFagpvvpxjw2yBvwk6nctR1BACtJdMbHDVjmICBkalJ4goGZaFz
         /0mcETu3lLNLVC8rV8i1bAlqMQCbGRDpS+5x1BQ/kwaK2iedrCS7eg+1oAHsQYTSQHtQ
         pr+lrQDtw9kBtl/nlOSUVJJ7Y+M2Z2+jajcE80115x030qFQw2IdyNNFWxccm8dmlpLY
         k5afVambFTuuFym3j7OREefOQKO+njLHNH6U+Udf71l9tnQlyVR0gI17gwzgozP5+tbo
         6+oD/FRfcpsQFtacSA+8Cd7uVTBP1xMNsPlMDW/GHXto8wqHm57iA2qidJtHBP6RnxV0
         1cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6OUXR57gtwUzyorkLcDo+RaaDM9jtOgBawbttgR3Xo=;
        b=GFiFpY7FDGT/O4mijhubv97CSFHEyTDik/hJVXFdjPfFAN+nsq6EUw8EMCEVzntPX6
         QSo1MztbfzH5ya0CRX3gPz6ZCPpawmKBPwhEwOKSxbjrD3iqlFHwQOmUEFqCZrk8jpqC
         MQhPjTIALRBJks1TJzblPIy/xN1CDUp6czDw8pmwFfejL7gJCi/LnrOfuh+p4N2wLog6
         NME2K7WuPGMJGoXcsd9VBFBNDs5C6up/THrT/QNFpNtO416GC2qnyLPjhfWbOvJFeDmQ
         kV79X+wRktWpxAP+9PNN6x7wUyZ2qLbbMMB+rckTRCTvHT0eL/GDvsBtbqZQcEcvWMk4
         lScw==
X-Gm-Message-State: AOAM533h2VVmO48+CL7HO4wXPRMmqwNE5tkYdyxOV8qtrpPgaJ5OfgS/
        ls//ehhtul7ET081MewTvUI=
X-Google-Smtp-Source: ABdhPJw/1rrcjk/VZCwkW54B7yOcxa43UWuXvwddUTvGSHTXb6V4/b+HJNFxYZhtFrTMop57dLhFFg==
X-Received: by 2002:a17:90b:3749:: with SMTP id ne9mr18879117pjb.192.1634195624375;
        Thu, 14 Oct 2021 00:13:44 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id ls7sm1546572pjb.16.2021.10.14.00.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:13:43 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: [RFC 6/7] rt-tests: cyclictest: Use streaming algorithm to calculate averages
Date:   Thu, 14 Oct 2021 16:12:46 +0900
Message-Id: <20211014071247.4165329-7-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211014071247.4165329-1-punitagrawal@gmail.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

As part of latency evaluation, cyclictest reports the average
latencies observed for the threads. To calculate the average, the
aggregate latency of a thread across all samples is tracked and the
value calcualted at the end when it is reported.

In preparation for adding support to report standard deviation, update
the average calculation to track the streaming average, i.e., averages
of the samples observed so far.

Streaming average can be calculated using -

	  avg = prev_avg + (sample - prev_avg) / #samples

The patch implements this formula and updates the usage of average in
the rest of the code.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 src/cyclictest/cyclictest.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 48a782fe167d..dde8b1625c62 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -616,6 +616,7 @@ static void *timerthread(void *param)
 		uint64_t diff;
 		unsigned long diff_smi = 0;
 		int sigs, ret;
+		double prev_avg;
 
 		/* Wait for next period */
 		switch (par->mode) {
@@ -702,7 +703,6 @@ static void *timerthread(void *param)
 			if (refresh_on_max)
 				pthread_cond_signal(&refresh_on_max_cond);
 		}
-		stat->avg += (double) diff;
 
 		if (trigger && (diff > trigger))
 			trigger_update(par, diff, calctime(now));
@@ -742,6 +742,14 @@ static void *timerthread(void *param)
 
 		stat->cycles++;
 
+		/*
+		 * Calculate the streaming average
+		 *
+		 * avg = avg' + (x - avg') / n
+		 */
+		prev_avg = stat->avg;
+		stat->avg = prev_avg + ((diff - prev_avg) / stat->cycles);
+
 		next.tv_sec += interval.tv_sec;
 		next.tv_nsec += interval.tv_nsec;
 		if (par->mode == MODE_CYCLIC) {
@@ -1429,8 +1437,7 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
 
 			fprintf(fp, fmt, index, stat->tid, par->prio,
 				par->interval, stat->cycles, stat->min,
-				stat->act, stat->cycles ?
-				(long)(stat->avg/stat->cycles) : 0, stat->max);
+				stat->act, (long)stat->avg, stat->max);
 
 			if (smi)
 				fprintf(fp, " SMI:%8ld", stat->smi_count);
@@ -1485,8 +1492,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 
 			dprintf(fd, fmt, index, stat->tid, par->prio,
 				par->interval, stat->cycles, stat->min,
-				stat->act, stat->cycles ?
-				(long)(stat->avg/stat->cycles) : 0, stat->max);
+				stat->act, (long)stat->avg, stat->max);
 
 			if (smi)
 				dprintf(fd, " SMI:%8ld", stat->smi_count);
@@ -1774,7 +1780,7 @@ static void write_stats(FILE *f, void *data)
 		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
 		fprintf(f, "      \"min\": %ld,\n", s->min);
 		fprintf(f, "      \"max\": %ld,\n", s->max);
-		fprintf(f, "      \"avg\": %.2f,\n", s->avg/s->cycles);
+		fprintf(f, "      \"avg\": %.2f,\n", s->avg);
 		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
 		fprintf(f, "      \"node\": %d\n", par[i]->node);
 		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
-- 
2.32.0

