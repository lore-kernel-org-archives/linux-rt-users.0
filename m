Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66741166B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690760; cv=none; b=TxOUtIR0U9w4Yx8pDaWx1zL0M+nml2QEsFgifz5yjuLfYX5jNz7NeYsfN9ulhYgZ72xUhVBt0+/843jCcQ+ysVexqwWpaqG24Q8wm715Lb9nxueUI7rlzS3QfZd9grWXhzFHWxD0Bjc6e93+6K95IZ32f58Ot41EYtRZU4rSD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690760; c=relaxed/simple;
	bh=PdtNHKg65BmQww2EbPsyB9U9n8EkiDPZpWeO6gn9HvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWAHwTtgQpdNcAg4aWfuxkFN7EvcT2EBV9u1Y7OUtjjcSVQiml4UmRSx5LBWsApz/XT9eumfi+QRosVqI7L0zAv1HLzf3uM59jUVe7LXGeW/RtEEt1leqjrbomB7TDopM28T8aJH4YB7XBBwtQu4Y2/EP6XgA7g9kcWhK7G6Wgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1HfJkpJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1HfJkpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ssm6OaPqztQIo2tkLjX5sDwzRLbWElJDIfIOCjsxhw=;
	b=G1HfJkpJBSJ9BTMFjxSedeVv1j2vRgzGFaluxIUMlCeuZi2zigai01jomqn7SUQaonl+MK
	v87vnNz+nCnc+xG4F/zAS8OleJAjFQQJPvHhMIUEntD0GU2piZLIunLgXb8GDoZXEMen5B
	ZV6NpjvgEGMRAAWs3y/AxBzRB8fGhk0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-9CfI5AJjMWev9drr8c8FUQ-1; Fri,
 10 Jul 2026 09:39:12 -0400
X-MC-Unique: 9CfI5AJjMWev9drr8c8FUQ-1
X-Mimecast-MFC-AGG-ID: 9CfI5AJjMWev9drr8c8FUQ_1783690751
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A26CA1956074;
	Fri, 10 Jul 2026 13:39:11 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88968195608E;
	Fri, 10 Jul 2026 13:39:09 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 08/11] tests: dump log on start_stalld_with_log failure
Date: Fri, 10 Jul 2026 10:38:07 -0300
Message-ID: <20260710133810.72398-9-wander@redhat.com>
In-Reply-To: <20260710133810.72398-1-wander@redhat.com>
References: <20260710133810.72398-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When stalld fails to initialize within the timeout,
start_stalld_with_log calls fail without first dumping the log file,
making CI failures harder to diagnose.  Add the same log-dump pattern
used by assert_starvation_detected, assert_boost_detected and
assert_log_contains so the file contents appear in the output.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index a2db0a9..85b1805 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -1157,6 +1157,8 @@ start_stalld_with_log() {
 	CLEANUP_PIDS+=("${STALLD_PID}")
 
 	if ! wait_for_stalld_ready "${log_file}" 15; then
+		log "Log contents:"
+		cat "${log_file}"
 		stop_stalld
 		fail "stalld did not initialize within 15s"
 	fi
-- 
2.55.0

