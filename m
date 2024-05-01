Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252929405
	for <linux-rt-users@vger.kernel.org>; Wed,  1 May 2024 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596592; cv=none; b=jIIUcXbSxRPGcQIIY0xKNi1/pQqkKarN0rDH9xhFw6UHiwTzFb/6utwkQWdOotMdlPxb8bBWn8/NGcxi/QMg4yFKVNe/o/cp5Z4InmTLFT1JfJvVjLtqBgoKMOWjscni3t1swVhnjOv2Q/WtZrBFHJ6WFqncSK4xkdB9cVSBugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596592; c=relaxed/simple;
	bh=7jAmxpIwZ5GEqwQ1ydFOholmYBmXgIfOCzwGpUi4psc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6W1Nd/36k8fkYJv+MVsLorA5akrnoGf0RjZTKIrE9Jyp8NRPw77Hu7rG0w3/9LwxEYlZpqaTai7BP+MKSr+TKAuiHpL5hneHdiffWBCmXx6TJslCTLLEwsU7bWdgF8AENwn69x0Nk75ikTLXET+LA0B0FcLCkIwY/jCi8tgGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5mCVc/1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5mCVc/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714596588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7y97pYch9nNZSga3lad+izWFM3IBDTWC4whaTt35aBg=;
	b=Z5mCVc/1Ihd/WaT+frwQwLsC5JrFGlrlw1zXuuEOB21gBFrywyKNNDptHnH1vmWadpFDs4
	21FoGCRxyXkAqxe3Cha5bmiZeP0zRE0JGTPE2McJ2u9V+s/+mDHrODFKsypdgxnq11s1Qo
	b9STl6c8ANiW0fr2QIDsajvL0ZPk7nk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-4VReh1WUOH28E5ZWjvNNfw-1; Wed, 01 May 2024 16:49:45 -0400
X-MC-Unique: 4VReh1WUOH28E5ZWjvNNfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C91B480591B
	for <linux-rt-users@vger.kernel.org>; Wed,  1 May 2024 20:49:44 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D05F40C6CC1;
	Wed,  1 May 2024 20:49:44 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] rt-tests: cyclics: Omit empty histogram buckets
Date: Wed,  1 May 2024 15:49:44 -0500
Message-ID: <20240501204944.228386-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This makes the output more palatable for human readers, at the expense
of requiring other consumers of the data to be able to handle the missing
lines.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
Don't apply until the below patch has been merged in rteval:
https://lore.kernel.org/linux-rt-users/20240501200922.226347-1-crwood@redhat.com/
---
 src/cyclictest/cyclictest.c         |  6 +++---
 src/include/histogram.h             |  4 ++--
 src/lib/histogram.c                 | 15 ++++++++++++---
 src/sched_deadline/cyclicdeadline.c |  7 +++----
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 8a963392e639..c5c33898c63c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1340,13 +1340,13 @@ static void print_hist(struct thread_param *par[], int nthreads)
 	fprintf(fd, "# Histogram\n");
 	for (i = 0; i < histogram; i++) {
 		unsigned long flags = 0;
+		char buf[64];
 
-		fprintf(fd, "%06d ", i);
+		snprintf(buf, sizeof(buf), "%06d ", i);
 
 		if (histofall)
 			flags |= HSET_PRINT_SUM;
-		hset_print_bucket(&hset, fd, i, flags);
-		fprintf(fd, "\n");
+		hset_print_bucket(&hset, fd, buf, i, flags);
 	}
 	fprintf(fd, "# Min Latencies:");
 	for (j = 0; j < nthreads; j++)
diff --git a/src/include/histogram.h b/src/include/histogram.h
index c7aba68ffb99..31fe2a08eda0 100644
--- a/src/include/histogram.h
+++ b/src/include/histogram.h
@@ -36,7 +36,7 @@ int hist_sample(struct histogram *h, uint64_t sample);
 int hset_init(struct histoset *hs, unsigned long histos, unsigned long bucket_width,
 	      unsigned long num_buckets, unsigned long overflow);
 void hset_destroy(struct histoset *hs);
-void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
-		       unsigned long flags);
+void hset_print_bucket(struct histoset *hs, FILE *f, const char *pre,
+		       unsigned long bucket, unsigned long flags);
 void hist_print_json(struct histogram *h, FILE *f);
 void hist_print_oflows(struct histogram *h, FILE *f);
diff --git a/src/lib/histogram.c b/src/lib/histogram.c
index 35a9d604da86..c21fc49c0a6c 100644
--- a/src/lib/histogram.c
+++ b/src/lib/histogram.c
@@ -114,8 +114,8 @@ void hset_destroy(struct histoset *hs)
 	hs->histos = NULL;
 }
 
-void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
-		       unsigned long flags)
+void hset_print_bucket(struct histoset *hs, FILE *f, const char *pre,
+		       unsigned long bucket, unsigned long flags)
 {
 	unsigned long long sum = 0;
 	unsigned long i;
@@ -123,10 +123,17 @@ void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
 	if (bucket >= hs->num_buckets)
 		return;
 
+	for (i = 0; i < hs->num_histos; i++)
+		sum += hs->histos[i].buckets[bucket];
+
+	if (sum == 0)
+		return;
+	if (pre)
+		fprintf(f, "%s", pre);
+
 	for (i = 0; i < hs->num_histos; i++) {
 		unsigned long val = hs->histos[i].buckets[bucket];
 
-		sum += val;
 		if (i != 0)
 			fprintf(f, "\t");
 		fprintf(f, "%06lu", val);
@@ -134,6 +141,8 @@ void hset_print_bucket(struct histoset *hs, FILE *f, unsigned long bucket,
 
 	if (flags & HSET_PRINT_SUM)
 		fprintf(f, "\t%06llu", sum);
+
+	fprintf(f, "\n");
 }
 
 void hist_print_json(struct histogram *h, FILE *f)
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 7525ad136d2c..631d57ee885e 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -731,11 +731,10 @@ static void print_hist(FILE *fp, struct sched_data *sd, int nthreads)
 	fprintf(fp, "# Histogram\n");
 	for (i = 0; i < histogram; i++) {
 		unsigned long flags = 0;
+		char buf[64];
 
-		fprintf(fp, "%06d ", i);
-
-		hset_print_bucket(&hset, fp, i, flags);
-		fprintf(fp, "\n");
+		snprintf(buf, sizeof(buf), "%06d ", i);
+		hset_print_bucket(&hset, fp, buf, i, flags);
 	}
 	fprintf(fp, "# Min Latencies:");
 	for (i = 0; i < nthreads; i++)
-- 
2.44.0

