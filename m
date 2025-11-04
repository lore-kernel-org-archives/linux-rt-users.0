Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3F2BE642
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Nov 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265523; cv=none; b=iHWAufVemdiYz4OR7uyr1gmclhq5yZbEjG1eDKHU0co4iL5iIzpwS8jTSThmDKVX/gHxzDIdohfHTKANPlE/Rcd2qTjMyyIrbqnTRy1Uul1DIh7FJoPigLy8ikQNWBAtlhRZaqiwvt+2CV2g5dW6VdhPpq/MLCMcb1i3HUTh/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265523; c=relaxed/simple;
	bh=XYGY3pp8Mg2CB0X/unagCOy0CppYrN1Lt7eWfpyDwdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Blw93zOvVOCYKoPU2unAU3qElSTiA5Q8j7zil3JUI7ntHXEMCA2MEcS2DVted3AZPgyGHtZWGD5yLOLczd+dOtsUXVoBy5PNCHq2gy9WY8/uzfWHUTNNDfDDAIF2AlrhwhiT23vdZuPyNGx40C7/gBjiR6eKj4F4gFlRj9fZBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6tuz9RZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6tuz9RZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762265519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N1qUSgvq3yfnaUuHvNKB0iW6ASJlGofcYyJJQYmsWms=;
	b=B6tuz9RZmYCjeLb6UkmKRxAwNhHJ/IprfQbmep86m6u43z37CPMGZV2rhz7edydBvL7w9v
	QlpCXgL2c+HlRoJ8TL+oToYkPfjB8hB/qgrewuYKICQzwCNLiPMji3tj+XKG2E9dG4XysI
	JN7nkf5UwK2kQlSpgI4NURZ6XnzCoBY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-uzFTvnzcPvS5oBJd6lpOfg-1; Tue,
 04 Nov 2025 09:11:57 -0500
X-MC-Unique: uzFTvnzcPvS5oBJd6lpOfg-1
X-Mimecast-MFC-AGG-ID: uzFTvnzcPvS5oBJd6lpOfg_1762265517
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C615F1800637;
	Tue,  4 Nov 2025 14:11:56 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.65])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E2E630001A1;
	Tue,  4 Nov 2025 14:11:53 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] bpf: Add BPF CO-RE compatibility for older kernels
Date: Tue,  4 Nov 2025 11:11:44 -0300
Message-ID: <20251104141144.31173-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Introduce a `thread_info___legacy` struct to provide BPF CO-RE
compatibility for older kernels (e.g., RHEL 8.x with 4.18) where the
`thread_info` struct lacks the `cpu` field. This allows `bpf_core_field_exists()`
checks to correctly determine the availability of this field at runtime,
preventing build failures on such systems.

The `task_cpu` helper function is updated to utilize this new legacy
struct when accessing the `cpu` field from `thread_info`, ensuring
that the BPF program can adapt to different kernel versions.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>
---
 bpf/stalld.bpf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/bpf/stalld.bpf.c b/bpf/stalld.bpf.c
index b0a62ac..bf55f5b 100644
--- a/bpf/stalld.bpf.c
+++ b/bpf/stalld.bpf.c
@@ -49,6 +49,16 @@ struct {
 #define log_task(p) log_task_prefix("", p)
 #define log_task_error(p) log_task_prefix("error: ", p)
 
+/*
+ * BPF CO-RE compatibility: In older kernels (e.g., RHEL 8.x with 4.18),
+ * thread_info lacks the cpu field. We define it here to enable
+ * bpf_core_field_exists() checks, allowing runtime detection of whether
+ * this field is available on the target kernel.
+ */
+struct thread_info___legacy {
+	int cpu;
+};
+
 /*
  * BPF CO-RE "weak" or "candidate" definition.
  *
@@ -105,10 +115,11 @@ static inline bool task_is_rt(const struct task_struct *p)
 static inline int task_cpu(const struct task_struct *p)
 {
 	const struct task_struct___legacy *lp = (const void *) p;
+	const struct thread_info___legacy *lt = (const void *) &p->thread_info;
 
 	return bpf_core_field_exists(lp->cpu)
 		? BPF_CORE_READ(lp, cpu)
-		: BPF_CORE_READ(p, thread_info.cpu);
+		: BPF_CORE_READ(lt, cpu);
 }
 
 /**
-- 
2.51.1

