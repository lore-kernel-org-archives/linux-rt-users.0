Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D203E275C
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943662; cv=none; b=RFTdFr7vOKRPLTUzAsmMtW6o+nfFo7KgqYyWnUbtoesh3GeLn5eyKt8DYKym/BDjL5ar7YzgbrGwES73pUl4KWte4zjydb/Mi7ZrkZTpWGp5FSkEsyg5a9oehCdGM5zTM6yrOIRD0QEhrbZRDmCmUcBTzf6n0lIgkF4sDhoUss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943662; c=relaxed/simple;
	bh=BYKB2fJCQXrEsdnujZiEgdqXJMgyvlCGb8ZpZ3xGDv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUN15g+/q9JqGVHdOqsj1bdeu8yYMui01DD/al4eS8iQaEykmX51lQfBjNOliJQhnLpnd5j4aNveDv2JZDdBfHZzLs+f+OBrXj0BrnXixRKgaxvvj2J5KOX4ssBcSk4km4X/XwdMDp3mKgoItUagEcWmFWm5nb2JasBcijeIuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDg/CoTm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDg/CoTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO+SdsC6GsOzuuY1zF1gDfjQBcAYgk/v1Gg/L6xH1cM=;
	b=KDg/CoTmVcSmweXHSlV4tZTV8eqP+kMaRFO4GmMIoJo+W902+XU6fVQr0ekAsxRkOuGzeK
	rNKmKL9ib94du+x3PxU7ioTI7zuJg1y+mHgQ9Um1SzBMcKUUiMgQruR/TIaVI92vBAjg29
	XubOiZkh36XxcIzrJhge8ofWuZ5rhE0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-pFPj8QZyMUm0SJ-Jl5GstQ-1; Mon,
 08 Jun 2026 14:34:17 -0400
X-MC-Unique: pFPj8QZyMUm0SJ-Jl5GstQ-1
X-Mimecast-MFC-AGG-ID: pFPj8QZyMUm0SJ-Jl5GstQ_1780943656
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EC1D183AB6A;
	Mon,  8 Jun 2026 18:34:16 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CFA036928;
	Mon,  8 Jun 2026 18:34:14 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 45/52] stalld: fix format string type mismatch for time_t
Date: Mon,  8 Jun 2026 15:31:55 -0300
Message-ID: <20260608183206.140526-46-wander@redhat.com>
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

Several log statements print time_t differences using %d or %llu,
neither of which matches time_t on x86-64 where it is defined as
long. Use %ld throughout to match the actual type and eliminate
undefined behavior from format/argument mismatches.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index 1762033..5fade4f 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -649,7 +649,7 @@ int check_starving_tasks(struct cpu_info *cpu)
 		if ((get_monotonic_time() - task->since) < config_starving_threshold)
 			continue;
 
-		log_msg("%s-%d starved on CPU %d for %d seconds\n",
+		log_msg("%s-%d starved on CPU %d for %ld seconds\n",
 			task->comm, task->pid, cpu->id,
 			(get_monotonic_time() - task->since));
 
@@ -695,7 +695,7 @@ int check_might_starve_tasks(struct cpu_info *cpu)
 
 		if ((get_monotonic_time() - task->since) >= config_starving_threshold/2) {
 
-			log_msg("%s-%d might starve on CPU %d (waiting for %d seconds)\n",
+			log_msg("%s-%d might starve on CPU %d (waiting for %ld seconds)\n",
 				task->comm, task->pid, cpu->id,
 				(get_monotonic_time() - task->since));
 
@@ -944,7 +944,7 @@ int boost_cpu_starving_vector(struct cpu_starving_task_info *vector, int nr_cpus
 		cpu = &cpu_starving_vector[i];
 
 		if (cpu->pid)
-			log_verbose("\t cpu %d: pid: %d starving for %llu\n",
+			log_verbose("\t cpu %d: pid: %d starving for %ld\n",
 				    i, cpu->pid, (now - cpu->since));
 
 		/* Skip if no task or not starving long enough */
@@ -953,7 +953,7 @@ int boost_cpu_starving_vector(struct cpu_starving_task_info *vector, int nr_cpus
 
 		/* Log when task has reached starvation threshold */
 		if ((now - cpu->since) >= config_starving_threshold) {
-			log_msg("%s-%d starved on CPU %d for %d seconds\n",
+			log_msg("%s-%d starved on CPU %d for %ld seconds\n",
 				cpu->task.comm, cpu->pid, i,
 				(now - cpu->since));
 		}
-- 
2.54.0

