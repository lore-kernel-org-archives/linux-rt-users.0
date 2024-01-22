Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F348791
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jan 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961608; cv=none; b=MWNUqlJHWtyh1r0G8m+rVzS3+P3L/8FCzb1LCyAObG/uL7m2ePszv66kDCh2UWwCjzqOOYqdSOPL4ZuUqUUXbuI8hYPiitCFEawYQGxhlF8G5zx0yxsb2pSOqo3AVYbEDmz9uwNZCezRAj2kqebIFpnl+LiLVT8j4r+d9njkBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961608; c=relaxed/simple;
	bh=xW+RTWQDX85fj6TvqqXUjnPMd6PdJROBXIez4R9B7rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjuHfXXQ8PQ+tM6CRHzJvLHRC9igyZUCMcw10o4atwaIm+a0E9NxCy++BiWsKxfoI8zGP1KLV+2YGo97LA+woQ2dzqnfumXzZaBlpH8sssT2EA6rvQfPXHMbH/bz3ks4uiRkkhEAom7iz+efQ33wil5eN6SeB4eOfhUMiqPJvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXpMgRus; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXpMgRus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705961606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLhpYfKsYLYfBvYCexc28NpN6drEb0PWpOeUCl0CudQ=;
	b=PXpMgRusPmp5Atm8SMCMCZWs18ovYktrAtE8h/mQv+IVO+RRhuog261kTAEzDhLonUXifS
	yOMNdByX4akdmDOX8R7fWInH/mP2lcwLdHNLH/5byWBQLgn2tKoKQugxJFr6fOcJNpeW39
	n9iS57MR9+KeqYQr0ZJerkHdhm5cB1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-MhnlhgSqPjitAm9QuUbrmg-1; Mon, 22 Jan 2024 17:13:24 -0500
X-MC-Unique: MhnlhgSqPjitAm9QuUbrmg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7489883538A
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jan 2024 22:13:22 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BCF2492BC6;
	Mon, 22 Jan 2024 22:13:22 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 3/3] rt-tests: cyclicdeadline: Remove dead "verbose" code in print_stat()
Date: Mon, 22 Jan 2024 16:13:21 -0600
Message-ID: <20240122221321.9545-3-crwood@redhat.com>
In-Reply-To: <20240122221321.9545-1-crwood@redhat.com>
References: <20240122221321.9545-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

print_stat() isn't and has never been called with verbose set, and
that codepath doesn't even print anything.  Remove it.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 46 ++++++++++-------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 3cb8f714b788..7525ad136d2c 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -53,7 +53,6 @@ typedef int s32;
 /* Struct for statistics */
 struct thread_stat {
 	unsigned long cycles;
-	unsigned long cyclesread;
 	long min;
 	long max;
 	long act;
@@ -64,8 +63,6 @@ struct thread_stat {
 	int threadstarted;
 	int tid;
 	long reduce;
-	long redmax;
-	long cycleofmax;
 };
 
 struct sched_data {
@@ -775,36 +772,23 @@ static void print_hist(FILE *fp, struct sched_data *sd, int nthreads)
 	fprintf(fp, "\n");
 }
 
-static void print_stat(FILE *fp, struct sched_data *sd, int index, int verbose, int quiet)
+static void print_stat(FILE *fp, struct sched_data *sd, int index, int quiet)
 {
 	struct thread_stat *stat = &sd->stat;
+	char *fmt;
 
-	if (!verbose) {
-		if (quiet != 1) {
-			char *fmt;
-			if (use_nsecs)
-				fmt = "T:%2d (%5d) I:%ld C:%7lu "
-					"Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
-			else
-				fmt = "T:%2d (%5d) I:%ld C:%7lu "
-					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
-			fprintf(fp, fmt, index, stat->tid,
-				sd->deadline_us, stat->cycles, stat->min, stat->act,
-				stat->cycles ?
-				(long)(stat->avg/stat->cycles) : 0, stat->max);
-		}
-	} else {
-		while (stat->cycles != stat->cyclesread) {
-			long diff = stat->values
-			    [stat->cyclesread & sd->bufmsk];
+	if (quiet)
+		return;
 
-			if (diff > stat->redmax) {
-				stat->redmax = diff;
-				stat->cycleofmax = stat->cyclesread;
-			}
-			stat->cyclesread++;
-		}
-	}
+	if (use_nsecs)
+		fmt = "T:%2d (%5d) I:%ld C:%7lu Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
+	else
+		fmt = "T:%2d (%5d) I:%ld C:%7lu Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
+
+	fprintf(fp, fmt, index, stat->tid,
+		sd->deadline_us, stat->cycles, stat->min, stat->act,
+		stat->cycles ?
+		(long)(stat->avg/stat->cycles) : 0, stat->max);
 }
 
 static u64 do_runtime(struct sched_data *sd, u64 period)
@@ -1109,7 +1093,7 @@ static void loop(struct sched_data *sched_data, int nr_threads)
 
 	while (!shutdown) {
 		for (i = 0; i < nr_threads; i++)
-			print_stat(stdout, &sched_data[i], i, 0, quiet);
+			print_stat(stdout, &sched_data[i], i, quiet);
 		usleep(10000);
 		if (!quiet)
 			printf("\033[%dA", nr_threads);
@@ -1119,7 +1103,7 @@ static void loop(struct sched_data *sched_data, int nr_threads)
 		printf("\033[%dB", nr_threads + 2);
 	} else if (!histogram) {
 		for (i = 0; i < nr_threads; ++i)
-			print_stat(stdout, &sched_data[i], i, 0, 0);
+			print_stat(stdout, &sched_data[i], i, 0);
 	}
 
 	if (histogram) {
-- 
2.43.0

