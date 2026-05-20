Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E23E2AC8
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285722; cv=none; b=cI2r2TXXK4Vyccm0RPnT6C8wdmFJz05wrCjQh8ZTwMxUYMePPDCjkesjNLIdcfu+su3bRyUFKAKCPi+eImdu7Q/22PDKgoFAY4OFekiTCCCV5nuVV7IaR5HgegZ8+td3c5Vu7Fewq1mwayMU/3xqIM8TXmKCa56ncpeqBivNeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285722; c=relaxed/simple;
	bh=VEVHcyEw8UHae4w2jaBPJ2nhPY+l2wdqC+iVwo2WlXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CckZQeakKqTLMIXJOzwFEqEJ/1+X0h+b8NRqOb92Pl2n8kUn1qtwp6Anm7yvMl0n5IwRnf4l8SmKrKlLH6i3+E+nDz5kzTEUrsmrJmUQwUGvOkyYTk0A2skX/PtNI9S0RiFBjtHQAK79KxQ5WlGgVRDksQfS4UsDOlxElvricL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNCrcKac; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNCrcKac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmH1zI4kP5NgOlVrvn9NEFKZ1W7pvG1nH6PAzKZOw0Y=;
	b=fNCrcKacXOn53EjoXtEmUZOAh0mPruKNrtlCJ1C6C5mXPIPvdM3xCI5Szm0xSGOVKywFx2
	JbEF5lnKJKRDzQlRvfW5zvYZW2GJOPVx/uG9IlZAJvqWIESsgXGFgU25mWaygcL+DItJRx
	XDktX5kMQOEZ14JCumawbr1NkDT4H+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-Ach9k_nlPqiSipfk04Rl_Q-1; Wed,
 20 May 2026 10:01:57 -0400
X-MC-Unique: Ach9k_nlPqiSipfk04Rl_Q-1
X-Mimecast-MFC-AGG-ID: Ach9k_nlPqiSipfk04Rl_Q_1779285716
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 241AF18005B2;
	Wed, 20 May 2026 14:01:56 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC74A1800576;
	Wed, 20 May 2026 14:01:53 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 15/33] tests: Add idle CPU skipping assertion
Date: Wed, 20 May 2026 11:00:42 -0300
Message-ID: <20260520140104.112142-16-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
2.54.0

