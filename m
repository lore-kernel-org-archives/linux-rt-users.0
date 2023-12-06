Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEtZegJ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E8CA9
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Dec 2023 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701896112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iXtU7Q9L9stpltxC3vuuY5E3kOFF/vLg/QAM4dXv1U=;
	b=VEtZegJ3v1V6/Ftd+EK0mq5aCtJueenAvSXDmxufrJRkqEDwvv8yrFtLPS8zSGoVh0Sq8u
	e4vVhSVwztXOSEcdOyp5baoUt2Nfe8t7KHa4aIDP6DJOVDmO8L1025ILw+wLNRF4twRbYK
	gQLIKete3B9V5+YXDpEydD++WZ48SVY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-veStV6K3Mb2U6nohqKIMNg-1; Wed,
 06 Dec 2023 15:55:10 -0500
X-MC-Unique: veStV6K3Mb2U6nohqKIMNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C5473C0C49B
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Dec 2023 20:55:10 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.17.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D84F2028CD2;
	Wed,  6 Dec 2023 20:55:10 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/4] rt-tests: cyclictest: Remove histogram totals
Date: Wed,  6 Dec 2023 14:55:06 -0600
Message-ID: <20231206205508.17148-3-crwood@redhat.com>
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

The Total: line does not seem to contribute much value, as it should just
be the number of buckets minus the number of overflows.  Unless someone
complains, remove it to simplify moving to common histogram code.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 src/cyclictest/cyclictest.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index a8039b49feb6..93ce201e9fca 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1407,12 +1407,9 @@ static void print_tids(struct thread_param *par[], int nthreads)
 static void print_hist(struct thread_param *par[], int nthreads)
 {
 	int i, j;
-	unsigned long long int log_entries[nthreads+1];
 	unsigned long maxmax, alloverflows;
 	FILE *fd;
 
-	bzero(log_entries, sizeof(log_entries));
-
 	if (use_histfile) {
 		fd = fopen(histfile, "w");
 		if (!fd) {
@@ -1434,21 +1431,12 @@ static void print_hist(struct thread_param *par[], int nthreads)
 			fprintf(fd, "%06lu", curr_latency);
 			if (j < nthreads - 1)
 				fprintf(fd, "\t");
-			log_entries[j] += curr_latency;
 			allthreads += curr_latency;
 		}
-		if (histofall && nthreads > 1) {
+		if (histofall && nthreads > 1)
 			fprintf(fd, "\t%06llu", allthreads);
-			log_entries[nthreads] += allthreads;
-		}
 		fprintf(fd, "\n");
 	}
-	fprintf(fd, "# Total:");
-	for (j = 0; j < nthreads; j++)
-		fprintf(fd, " %09llu", log_entries[j]);
-	if (histofall && nthreads > 1)
-		fprintf(fd, " %09llu", log_entries[nthreads]);
-	fprintf(fd, "\n");
 	fprintf(fd, "# Min Latencies:");
 	for (j = 0; j < nthreads; j++)
 		fprintf(fd, " %05lu", par[j]->stats->min);
-- 
2.43.0

