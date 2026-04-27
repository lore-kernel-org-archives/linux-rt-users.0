Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3C3B27E5
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288675; cv=none; b=C/WbwDNlvmw3FXVsTMINQvbKWLOGYM8WDnQ1ahtmMVtlUrKe3E29b1lbRn1qRLtOru2w1IhhKASKkiZnczRq6sTSBoImjn1fiukVIgC4SODHC0A3m/9zs0W9XJRr+xbltTGmYFWhhZgQV7GMiLtDOLkuL6J4OdvGA5YAwBkNoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288675; c=relaxed/simple;
	bh=BOXRb5TqNw9hWmHE+109NICAUE9dXJo5QXcHRxDqRR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4SNKy34crtCyVr4nZve28Nv/we4+snpPxCYWkg40Gj8dVoP118bgloqHd2X9rNXqoP9PxufRXDMANeGpwEKJ5wScjngN+ix0Ym/igUEKUZBiuDeENeLrqnt9fr88pKEec9gqEFsJg4hXG0XFQa59F04DPOTNlKpcl4sM+MR3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4bUXAvC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4bUXAvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuPPi56EZJmzHGIFqQ4HUez3FUDU9/popFFWIMotmd4=;
	b=e4bUXAvCQonPQKymyCBKLdQEpjppx+0GC21l8bxVudGYaCunT8kptNSfhYAsCvdXi0znVj
	+uV+dQAFPrMyjsEOwY3ft9RNVObQeEZZOW/MNuqMfWHKU6C/DEorfyF11F5waqE3yRINB7
	u0ywHeWPJv6HVXc0lkAZRGEt6Dcxh0k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-FkZdNsccNMSf7fbvxL0mAQ-1; Mon,
 27 Apr 2026 07:17:51 -0400
X-MC-Unique: FkZdNsccNMSf7fbvxL0mAQ-1
X-Mimecast-MFC-AGG-ID: FkZdNsccNMSf7fbvxL0mAQ_1777288671
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 037FC189F064;
	Mon, 27 Apr 2026 11:17:47 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8FCE1801481;
	Mon, 27 Apr 2026 11:17:42 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 15/23] tests: Add idle CPU skipping assertion
Date: Mon, 27 Apr 2026 08:16:17 -0300
Message-ID: <20260427111632.24500-16-wander@redhat.com>
In-Reply-To: <20260427111632.24500-1-wander@redhat.com>
References: <20260427111632.24500-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Test 4 in the idle detection suite was purely informational,
printing explanatory text about what idle detection does without
any assertions. Replace it with an actual test that starts stalld
on an idle CPU and verifies that "skipping" messages appear in the
log, confirming the idle detection optimization is working.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_idle_detection.sh | 32 +++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index 8017675..f238c7e 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -140,23 +140,25 @@ fi
 cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
-# Test 4: Idle Detection Overhead Reduction
+# Test 4: Idle CPUs Are Skipped
 #=============================================================================
-test_section "Test 4: Idle Detection Reduces Overhead"
-log "Comparing overhead with and without idle detection (informational)"
-
-# This is informational - we can't easily measure overhead in tests
-log "With idle detection (default):"
-log "  - /proc/stat read before parsing"
-log "  - Idle CPUs skipped (no sched_debug/BPF parsing)"
-log "  - Reduces CPU usage when system mostly idle"
-log ""
-log "Without idle detection would:"
-log "  - Always parse all CPUs"
-log "  - Higher overhead even when CPUs idle"
+test_section "Test 4: Idle CPUs Are Skipped"
+
+rm -f "${STALLD_LOG}"
+threshold=3
+
+log "Starting stalld with idle detection on an idle CPU"
+start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
+
+sleep 3
+
+if grep -q "skipping" "${STALLD_LOG}"; then
+    pass "Idle CPU correctly skipped"
+else
+    fail "No skipping messages for idle CPU"
+fi
 
-log "ℹ INFO: Idle detection enabled by default for efficiency"
-log "        Function: cpu_had_idle_time() and get_cpu_busy_list()"
+cleanup_scenario
 
 #=============================================================================
 # Test 5: Idle Detection with Multiple CPUs
-- 
2.53.0

