Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC4368D60
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943586; cv=none; b=oYvX3O9fZbIw7A7U5tvBFHPczkR6uBFWutcBriQ8EosOvbtR0elxsaKQA+c5UtXKSILW6XX0De9/1zC1akrlowrPqAaG4G9iHTntHcBfIWeLPQIa+GbZRJkcv8EVjAO6TFVp8LjHlzzkbNkUHNTc6bfJGmE91GMoWcsntbi+vPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943586; c=relaxed/simple;
	bh=WaTpPZulu5OUZLDSbZ7123KExoUgbjwDrRPhmiwU7Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iawwioJYWeBpobO0u8IDFdbZ0Sc01oWleaBFRfsrMY07LA9qJMbYm3wvwSYHQx2zVJQfKHrLPD9/p8Z+leMOg456vWe3i8mpvOcxyBi1xMNyJobQh2aNH32z5dn1UdANZsG84YNYCbAwDDGQMtCfVnVb4s0bwKh+vAnEQbcJ9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5aD9nUY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5aD9nUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWmMvvpbBaGVjPqnYWnf3RcKIV+G3rH/pKfDQXkttr8=;
	b=Q5aD9nUY7GhBnXZVs9NMFXv3FczQYZx5KvhhXxo9z6B7EupmVhp+RGsskkzVmTC/e/6nRo
	6TiGAlzLcUjWxHBDwMx7xHcZpAkNeu5sHqw0wI0FhCeB1L+nw0bqyK7srQmYvFauvRAY6r
	ucCRuDvcR7WkJNTWEdLzmUJCBVURwyo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-wDf2mPa4NlqQdoMqAvPeSQ-1; Mon,
 08 Jun 2026 14:33:01 -0400
X-MC-Unique: wDf2mPa4NlqQdoMqAvPeSQ-1
X-Mimecast-MFC-AGG-ID: wDf2mPa4NlqQdoMqAvPeSQ_1780943580
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86A881944D1C;
	Mon,  8 Jun 2026 18:33:00 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73E913692B;
	Mon,  8 Jun 2026 18:32:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 16/52] tests: Remove redundant pkill from cleanup
Date: Mon,  8 Jun 2026 15:31:26 -0300
Message-ID: <20260608183206.140526-17-wander@redhat.com>
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

The cleanup function uses pkill -9 -f starvation_gen to kill all
starvation generator processes system-wide. This is redundant
because the CLEANUP_PIDS array already tracks every spawned
process by PID and terminates them individually.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 757e5e0..2b744d0 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -548,10 +548,6 @@ cleanup() {
 	# Stop stalld
 	stop_stalld
 
-	# Kill any starvation generators first (these often have child processes)
-	# Use pkill which handles process trees better
-	pkill -9 -f starvation_gen 2>/dev/null || true
-
 	# Small delay to let processes terminate
 	sleep 0.2
 
-- 
2.54.0

