Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14284C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83E32076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx7IK+FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgJ2RlX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgJ2RlW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E0C0613D2
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l2so2687850qkf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+nj8yV7sWGiF2yQNq8JnEMQL9UmPx8G5edovCxTPO0=;
        b=Yx7IK+FTbcnXI1a5hpY8lOOCqEsyxNNEQ39bkU5/YeT6go4Y49ykvNf6XwpYT+4SZY
         v4T/O7e6lnOpa5lT2fY+TKD+p8GuZ0WfNpjk73PCPZfcPJfjhVR0JLqAjRuyKlfIuDQ0
         t8z7e+n2YYsNOCtLF9utfvcmGT7yQnWliwmMLOn6xG1p/zRS5BqKlwsZQJOKElbnwx3Q
         /OPrSdAnI3TY8J4iep0Ou+45hKlAVxUKVQxY/8ryl/8pMM24oeHW/H0u6Ol1f2OihdSh
         imWMVVI+tH2oOewlPQnMrmkG50g+JMP0ltE1+lQo1mrWBemvvaaDovx0ei84odnXNytz
         7qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=s+nj8yV7sWGiF2yQNq8JnEMQL9UmPx8G5edovCxTPO0=;
        b=PNpS2zJDz2Mw6MOanhkBtFkh7w7t/OzwPGHferXRRqTjDeEaJE2wqhctDoPCdfoEDm
         jA6Y8Trd5mIaZ9dLeFqmD7q0OyWNQoYV+AUHKAivsZS9X5l6XiPESWXpFjiDGmsf95He
         Vgp21g9juI/7XfkgDJq4EZeJr6FuhnVUr/ygFTOx/fHcy5hGUMksWBRqAJefqNiEs9Bc
         VhTJYq+n+PTR9CI48UVseseZ8nStzMvPXJcoUi+HjOipj94GrCQ8sDRXclntX7V3T0nA
         0P1i8+lDJgBXN2p8CGQCr9BVAgPLklaDNCjta4B0p9AHI6Bk7GMm6IGJVhxVnDF7plwQ
         LsuQ==
X-Gm-Message-State: AOAM531YxEumppyiEN/OQEomoCXaQj6w0QnprMFjZXYjtcunFjdSMSU7
        vgdHCPG7OQdpHOoiYwbrWqfFYle3Wjdkmw==
X-Google-Smtp-Source: ABdhPJx3I05ZWDLC9PRLk1j1NsstplY6xE48mqLgC36m6sJLQgjG6g8CiptcTyLddVo5geq2rCq2Jg==
X-Received: by 2002:a37:9c46:: with SMTP id f67mr4773974qke.213.1603993281548;
        Thu, 29 Oct 2020 10:41:21 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:21 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 09/16] rt-tests: queuelat.c: Fix various style problems
Date:   Thu, 29 Oct 2020 13:40:50 -0400
Message-Id: <20201029174057.20033-10-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix various style problems such as spaces in indentation instead of
tabs, unsigned long long int, to just unsigned long long, and so on.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/queuelat.c | 58 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index fbe5239ee81e..ead8ee5f4898 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -26,12 +26,12 @@
  * mpps(million-packet-per-sec): million packets per second (float).
  * tsc_freq_mhz: TSC frequency in MHz, as measured by TSC PIT calibration 
  * (search for "Detected XXX MHz processor" in dmesg, and use the integer part).
- * 
+ *
  * How it works
  * ============
  *
  *  The program in essence does:
- * 
+ *
  * 		b = rdtsc();
  * 		memmove(dest, src, n);
  * 		a = rdtsc();
@@ -44,8 +44,8 @@
  *		if (queue_size > max_queue_len)
  *			FAIL();
  *
- * packets_processed is fixed, and is estimated as follows: 
- * n is determined first, so that the stats bucket with highest count 
+ * packets_processed is fixed, and is estimated as follows:
+ * n is determined first, so that the stats bucket with highest count
  * takes max_latency/2.
  * for max_latency/2, we calculate how many packets can be drained
  * in that time (using cycles_per_packet).
@@ -74,17 +74,16 @@ int nr_packets_drain_per_block;
 #define VALS_PER_BUCKET 100
 #define NR_BUCKETS LAST_VAL/VALS_PER_BUCKET
 
-unsigned long long int buckets[NR_BUCKETS+1];
-unsigned long long int total_count;
+unsigned long long buckets[NR_BUCKETS+1];
+unsigned long long total_count;
 
 #define OUTLIER_BUCKET NR_BUCKETS
 
 static int val_to_bucket(unsigned long long val)
 {
 	int bucket_nr = val / VALS_PER_BUCKET;
-	if (bucket_nr >= NR_BUCKETS) {
+	if (bucket_nr >= NR_BUCKETS)
 		return OUTLIER_BUCKET;
-	}
 	return bucket_nr;
 }
 
@@ -100,9 +99,8 @@ static unsigned long long total_samples(void)
 	int i;
 	unsigned long long total = 0;
 
-	for (i = 0; i <= OUTLIER_BUCKET; i++) {
+	for (i = 0; i <= OUTLIER_BUCKET; i++)
 		total += buckets[i];
-	}
 
 	return total;
 }
@@ -151,9 +149,8 @@ static void print_max_bucketsec(void)
 
 		bucket_nr = val_to_bucket(val);
 
-		if (buckets[bucket_nr] != 0) {
+		if (buckets[bucket_nr] != 0)
 			highest_val = val;
-		}
 	}
 
 	bucket_nr = val_to_bucket(highest_val);
@@ -196,7 +193,7 @@ static void print_avg_bucketsec(void)
 
 	for (i = 0; i <= OUTLIER_BUCKET; i++) {
 		unsigned long long val = i*VALS_PER_BUCKET;
-		unsigned long long maxtime; 
+		unsigned long long maxtime;
 
 		bucket_nr = val_to_bucket(val);
 
@@ -236,9 +233,9 @@ static void print_all_buckets_drainlength(void)
 			mindelta = val;
 			maxdelta = val + VALS_PER_BUCKET-1;
 
-                	nr_packets_minfill = mindelta * mpps * 1000000 / NSEC_PER_SEC;
-                	nr_packets_maxfill = maxdelta * mpps * 1000000 / NSEC_PER_SEC;
-			
+			nr_packets_minfill = mindelta * mpps * 1000000 / NSEC_PER_SEC;
+			nr_packets_maxfill = maxdelta * mpps * 1000000 / NSEC_PER_SEC;
+
 			printf("[%lld - %lld] = %lld  packetfillrates=[%d - %d]\n", val, 
 						     val + VALS_PER_BUCKET-1,
 						     buckets[bucket_nr],
@@ -275,11 +272,11 @@ typedef unsigned long long u64;
 
 static inline unsigned long long __rdtscll(void)
 {
-        DECLARE_ARGS(val, low, high);
+	DECLARE_ARGS(val, low, high);
 
-        asm volatile("mfence; rdtsc" : EAX_EDX_RET(val, low, high));
+	asm volatile("mfence; rdtsc" : EAX_EDX_RET(val, low, high));
 
-        return EAX_EDX_VAL(val, low, high);
+	return EAX_EDX_VAL(val, low, high);
 }
 
 #define gettick(val) do { (val) = __rdtscll(); } while (0)
@@ -316,7 +313,7 @@ static int find_highest_count_bucket(void)
 {
 	int i;
 	int max_bucket = 0;
-	unsigned long long int max_val = 0;
+	unsigned long long max_val = 0;
 
 	for (i=0; i <= NR_BUCKETS; i++) {
 		if (buckets[i] > max_val) {
@@ -335,7 +332,7 @@ static void trace_open(void)
 
 	fd = open("/sys/kernel/debug/tracing/trace_marker", O_RDWR);
 
-	if (fd == -1) { 
+	if (fd == -1) {
 		perror("open");
 		exit(0);
 	}
@@ -347,7 +344,7 @@ static void trace_write(char *buf, int len)
 	int ret;
 
 	ret = write(tracing_mark_fd, buf, len);
-	if (ret == -1) { 
+	if (ret == -1) {
 		perror("write");
 		exit(0);
 	}
@@ -487,10 +484,10 @@ void main_loop(void)
 		queue_size += nr_packets_fill;
 
 		/* decrease the queue by the amount of packets
- 		 * processed in maxlatency/2 nanoseconds of
- 		 * full processing.
- 		 */
-	
+		 * processed in maxlatency/2 nanoseconds of
+		 * full processing.
+		 */
+
 		queue_size -= nr_packets_drain_per_block;
 
 		if (queue_size < 0)
@@ -641,9 +638,9 @@ int main(int argc, char **argv)
 	install_signals();
 
 	maxlatency = atoi(mvalue);
-        cycles_per_packet = atoi(cvalue);
-        mpps = atof(pvalue);
-        tsc_freq_mhz = atof(fvalue);
+	cycles_per_packet = atoi(cvalue);
+	mpps = atof(pvalue);
+	tsc_freq_mhz = atof(fvalue);
 
 	if (tvalue) {
 		int alarm_secs;
@@ -651,9 +648,8 @@ int main(int argc, char **argv)
 		alarm(alarm_secs);
 	}
 
-	if (qvalue) {
+	if (qvalue)
 		min_queue_size_to_print = atoi(qvalue);
-	}
 
 	convert_to_ghz(tsc_freq_mhz);
 
-- 
2.26.2

