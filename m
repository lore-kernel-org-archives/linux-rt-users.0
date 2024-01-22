Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2933EA88
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jan 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961607; cv=none; b=h4gnRRjxQyXng5jCbq2iBLHX2veYqhvIT4Bb2617zg4acGk0CX6Em4DJBjssj+VreBMGShOeQVcgnhk4wrDcgTTo1vRTnF140Y2G1pyN4F3Plz4qe0NFQtbyoG8XWo0hpjNSTYL+R1QgLBa7n+pyA9oaDrol1UXb1UBhzQ0+jf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961607; c=relaxed/simple;
	bh=o7wjQr4+IDIK2uOe9kb/g/RhGNGzJHYcNk2F+eLOMgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iK8CYUEycW2yLpHJRekRMoXr423MJQajMl/ua8vU4OeZQXW98GSDtPrJAV8lHab4LCdbLvL3ES9MdVr2jCec5Dwq5bPRG+cqYjjcx5XI7yUFQqvFzflNdMK8U7uIbytq5tfoewryq1MN12HYX82tANXn+E/kTsXy3hPbn1P6rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DN/8LZBD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DN/8LZBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705961604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=30mCPBuhE3uBUdndRzdf3gHuWyJAslCgR5rzQ119oks=;
	b=DN/8LZBDYpMAkEdAJyPfNqGSZD6Tf4OW+kMc77MDmRd2QpxViejL0Mr9A9yfKciZSXZAGw
	X/YOsHYhSLMu/JyEx9Po+KzNpZI9G9TKx4aT5pSXEAAv3jWgLiLJkN4ewWHVCc2c0n274R
	VYleojQ2VECuA682UTPLDOmVn0qLB2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-KmOECz7VNGKWzpq8gsyC7g-1; Mon, 22 Jan 2024 17:13:22 -0500
X-MC-Unique: KmOECz7VNGKWzpq8gsyC7g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEBBD10651E6
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jan 2024 22:13:21 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 659D9492BC6;
	Mon, 22 Jan 2024 22:13:21 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 1/3] rt-tests: cyclics: Fix json segfault when not using histogram
Date: Mon, 22 Jan 2024 16:13:19 -0600
Message-ID: <20240122221321.9545-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

If we're not generating a histogram, don't call the histogram code with
a NULL pointer.  Also don't print the rest of the histogram json node.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 src/cyclictest/cyclictest.c         | 11 ++++++-----
 src/sched_deadline/cyclicdeadline.c |  9 +++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 6169170fc66d..33fac3b95f5d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1778,12 +1778,13 @@ static void write_stats(FILE *f, void *data __attribute__ ((unused)))
 	fprintf(f, "  \"resolution_in_ns\": %u,\n", use_nsecs);
 	fprintf(f, "  \"thread\": {\n");
 	for (i = 0; i < num_threads; i++) {
-		fprintf(f, "    \"%u\": {\n", i);
-
-		fprintf(f, "      \"histogram\": {");
 		s = par[i]->stats;
-		hist_print_json(par[i]->stats->hist, f);
-		fprintf(f, "      },\n");
+		fprintf(f, "    \"%u\": {\n", i);
+		if (s->hist) {
+			fprintf(f, "      \"histogram\": {");
+			hist_print_json(s->hist, f);
+			fprintf(f, "      },\n");
+		}
 		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
 		fprintf(f, "      \"min\": %ld,\n", s->min);
 		fprintf(f, "      \"max\": %ld,\n", s->max);
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index e449be57870e..b3155547b9bb 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1141,10 +1141,11 @@ static void write_stats(FILE *f, void *data)
 	for (i = 0; i < nr_threads; i++) {
 		s = &sd[i].stat;
 		fprintf(f, "    \"%u\": {\n", i);
-
-		fprintf(f, "      \"histogram\": {");
-		hist_print_json(s->hist, f);
-		fprintf(f, "      },\n");
+		if (s->hist) {
+			fprintf(f, "      \"histogram\": {");
+			hist_print_json(s->hist, f);
+			fprintf(f, "      },\n");
+		}
 		fprintf(f, "      \"cycles\": %ld,\n", s->cycles);
 		fprintf(f, "      \"min\": %ld,\n", s->min);
 		fprintf(f, "      \"max\": %ld,\n", s->max);
-- 
2.43.0

