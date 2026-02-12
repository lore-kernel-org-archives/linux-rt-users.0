Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DC344D89
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Feb 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894841; cv=none; b=T2vuGfqbbTAehskC6gaXItsziCObg8ib4iaBGwM40v8sy4oyyZqLK6rQihggqe/jglXGbLDLLIibxCOnhgsYV6V8c8oL8i1twhoDjP9Oa6Fl8b2BEEmldCAaKCSOyIAKq+kwxpYGQwih5P7fZEUfrZ7ASd9amjEE9t4wP+nmmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894841; c=relaxed/simple;
	bh=Ua2gxFScM2UbnmItqRWggxJYEuI1vq+a8JYB1NboubU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyrkICqlqyMu6JGxLs5K/VoUo/hrbvzOEgJZpTeFRx8j7g6+B6d0Io2vJ5zyaM/ZIz1YOadq66mRKWBQX7pHn4m8VYMwsTRP0MWWAqsKRmOXp/+A6AIRDsP8/4WR2yP4hBLZNON3md6pNUXVaBJRQj/K+U+x2SKLTm0g3Uksvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HeSVLXTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeSVLXTn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770894838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZQ58pcoY08I4S8npVuOxzxJCwNpGDkFTvLBv9XZW5Ew=;
	b=HeSVLXTnJu7yjpM2Ss6iL+IES4/Lt4CPF/ZWo93Ne4lIb1F0vWGu1+wHIEfwjF6npyioFe
	Q9aCuM/GZRbZbiEJqTfu4Qa/PruqZFxvE0F1j6eAovN+VZD45XuH310v67GuxtGnvSZu7W
	kEkCE4Ri3JRCnEk1Lnsk1GrWsaqBXuA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-LffvU_hiOTSKgik4MT75Hg-1; Thu,
 12 Feb 2026 06:13:57 -0500
X-MC-Unique: LffvU_hiOTSKgik4MT75Hg-1
X-Mimecast-MFC-AGG-ID: LffvU_hiOTSKgik4MT75Hg_1770894836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 607B4195605B
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Feb 2026 11:13:56 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.225.231])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10BDB1800668;
	Thu, 12 Feb 2026 11:13:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-rt-users@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] rt-utils.c: Fix write() return value check
Date: Thu, 12 Feb 2026 12:13:42 +0100
Message-ID: <20260212111342.71398-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The write() return value check in tracemark() is a copy-paste from the
one in tracing_stop() which checks for 2 bytes to be written. As a
result, tracemark() is almost always warning.

Check for the write() return value to be equal to the written length,
which is the value returned if no error occurred.
While at it, add "\n" to the warn messages.

Fixes: 60d60540c009 ("rt-utils.c: Check return values of write()")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 src/lib/rt-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index d800b5f..aa70c78 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -437,8 +437,8 @@ void tracemark(char *fmt, ...)
 
 	/* write the tracemark message */
 	ret = write(tracemark_fd, tracebuf, len);
-	if (ret != 2)
-		warn("trace stop write failed");
+	if (ret != len)
+		warn("trace mark write failed\n");
 }
 
 void tracing_stop(void)
@@ -449,7 +449,7 @@ void tracing_stop(void)
 		return;
 	ret = write(trace_fd, "0\n", 2);
 	if (ret != 2)
-		warn("trace stop write failed");
+		warn("trace stop write failed\n");
 }
 
 void enable_trace_mark(void)

base-commit: 4e68b52f0e0c9777c91088948374c6ee3d4a1f6b
-- 
2.53.0

