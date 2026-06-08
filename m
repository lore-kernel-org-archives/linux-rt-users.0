Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112F3E2AD5
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943647; cv=none; b=Q3j/TlgfpnqYRs7hzfWj8V3+cWaV454dLErJk5ZWaeh/qSYuatV0qACabdxvPcHB8p20qK3pNUaCPQ1Dmq7wyx2s/C8Pa8zSGNVX8FMIl9wndpqFie4NuPWzT1r/+Kw6u5jgg13xxYEFtStvg4hte52SFgaZZmUI+jFg9qngT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943647; c=relaxed/simple;
	bh=OE4ZrSY9Tj41aoLO+oHFPU3pfg87HxP8mslhl1SS/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJVbSXjlAlb3H2YFo9xMEOJwNImLiV4nGX6WmI8/aDTJ2XNxT3gD1NsaGfIWVibDaMlxOPOgF8e/gyDrEaNVyD9jw3j1NGx976bvc9WpbUgEI0m5rzcOjX1bGbO8r2eQgOFfmZIgnNbg8B7Ad6S2GpNS1uMgKVmGg0viKLgDgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqsJgaFO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqsJgaFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9y4WHE/S03PIr/N7bYv+ABXtl35U4oBiN/JEE/p1QVE=;
	b=dqsJgaFOIrak0KibRNP8WcmtMI9U/WNg/Y6lBG0RyIg6LrcImiBlwE4WJNtimI731r16iP
	1/KL0XkO5UqhCTgM8fXdijOuLcjYGJkHwObGKIC5C6iseGCyfzmQuMVz9nFkTx2n09J2+h
	FhF7LqdsI1udNDLT30AtexA3c/r4/ZE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-yXw0dJKYPeazcjpj8nCIXg-1; Mon,
 08 Jun 2026 14:34:02 -0400
X-MC-Unique: yXw0dJKYPeazcjpj8nCIXg-1
X-Mimecast-MFC-AGG-ID: yXw0dJKYPeazcjpj8nCIXg_1780943641
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1535E1845420;
	Mon,  8 Jun 2026 18:34:01 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DA0536927;
	Mon,  8 Jun 2026 18:33:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 39/52] stalld: check pthread_create return in aggressive_main
Date: Mon,  8 Jun 2026 15:31:49 -0300
Message-ID: <20260608183206.140526-40-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

aggressive_main() ignores the return value of pthread_create(). If
thread creation fails the corresponding pthread_t is never
initialized, so the subsequent pthread_join() operates on an invalid
handle, which is undefined behavior.

Capture the return value and break out of the creation loop on
failure after clearing thread_running and logging a warning. Use a
separate loop counter bounded by the number of threads actually
created so that only valid handles are joined.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index d95b48f..049e5f0 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -825,7 +825,7 @@ static int should_skip_idle_cpus(struct cpu_info *cpus, int nr_cpus, char *busy_
 
 void aggressive_main(struct cpu_info *cpus, int nr_cpus)
 {
-	int i;
+	int i, j, ret;
 
 	for (i = 0; i < nr_cpus; i++) {
 		if (!should_monitor(i))
@@ -833,14 +833,19 @@ void aggressive_main(struct cpu_info *cpus, int nr_cpus)
 
 		cpus[i].id = i;
 		cpus[i].thread_running = 1;
-		pthread_create(&cpus[i].thread, NULL, cpu_main, &cpus[i]);
+		ret = pthread_create(&cpus[i].thread, NULL, cpu_main, &cpus[i]);
+		if (ret) {
+			cpus[i].thread_running = 0;
+			warn("%s: pthread_create() failed: %d\n", __func__, ret);
+			break;
+		}
 	}
 
-	for (i = 0; i < nr_cpus; i++) {
-		if (!should_monitor(i))
+	for (j = 0; j < i; j++) {
+		if (!should_monitor(j))
 			continue;
 
-		join_thread(&cpus[i].thread);
+		join_thread(&cpus[j].thread);
 	}
 }
 
-- 
2.54.0

