Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F63E3168
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943675; cv=none; b=kvxu3t4i4mfdenQ4NeWNK02lRYMt9ywP3YoaOVGBdHNG1HKhsrXk4NvoJqNMfX2HQOT5nskb/mLYTna+AdPn+P6LBZDhCIzqT6k4f5rUWNAVjXhVy+R5cCybfN/9ACmtq+sYI/Cz7sd+JH8hzBV90Y6dpducH8gAttpnGkQ97tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943675; c=relaxed/simple;
	bh=O2UGnibNsXLANPGFz90sBHRfrLoLYeKrx6WNcQefAW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFJZRr8mLgTrJP8x1kzddCO1acPid4MxEJCFgy7E4s1jb7sDazSMrMxQfpvY5d/b/4Fbid8/LBmnwT4npvVqJ8xJ0wZy+Iq0VMCbAxWfVDSNlUWUMq++1UJCy/OCLB9Ug0gXFh/xQjcHW3jzj4aFfv3+Da7/pxsAjTFKEL4STSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEaiUzMQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEaiUzMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MthFApJhtU/D5fmJzWRzzF9LhQK1PVSngmELNYgmHog=;
	b=MEaiUzMQC+igjL/ogdecxtl2RwPpT9jNBzHsirMYDDkVmDibRL8wP52FfYD3EcsygL/9X8
	vyLgVkveKQz+zakbyctpWYZSqlAJSMFKssbXQLXcVNW8RjpR6H7S0lDazRJXPckV/KfF07
	a0fHIsmOco5OA2SR2YCj/HhTfBIqSQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-rOptUpteM7msb0anEEkKDQ-1; Mon,
 08 Jun 2026 14:34:30 -0400
X-MC-Unique: rOptUpteM7msb0anEEkKDQ-1
X-Mimecast-MFC-AGG-ID: rOptUpteM7msb0anEEkKDQ_1780943669
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F169195DE2B;
	Mon,  8 Jun 2026 18:34:29 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C599E36929;
	Mon,  8 Jun 2026 18:34:26 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 50/52] stalld: fix snprintf truncation check in is_runnable
Date: Mon,  8 Jun 2026 15:32:00 -0300
Message-ID: <20260608183206.140526-51-wander@redhat.com>
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

The truncation check after snprintf() uses > instead of >=. When
snprintf() returns exactly sizeof(stat_path) the output was truncated
but the check does not catch it, allowing a truncated path to reach
open().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/sched_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_debug.c b/src/sched_debug.c
index d5fbf6d..5110098 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -309,7 +309,7 @@ static int is_runnable(int pid)
 	if (pid == 0)
 		return 0;
 	retval = snprintf(stat_path, sizeof(stat_path), "/proc/%d/stat", pid);
-	if (retval < 0 || retval > sizeof(stat_path)) {
+	if (retval < 0 || retval >= sizeof(stat_path)) {
 		warn("stat path for task %d too long\n", pid);
 		goto out_error;
 	}
-- 
2.54.0

