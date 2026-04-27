Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDC3B7771
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288653; cv=none; b=UtkxLnG29L/QQkISvJcs2PZ1BJkw3lit5oQC0zWfsBAEP5u+IfBiw+FCrE6BDM5icPNvyVq9t56arf/PWJxofKz6teXF1MGyWHyd+tiDJHSIMCMUyWGBN4C4cU8XQLeHROAbLkrinism2GE0WYS7L41Re0x4UtFufCtWIlKqpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288653; c=relaxed/simple;
	bh=lgjoguR5MwlRrm4+SeklKtC0xv427T2eZW8SwZZpXwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBs+i6GJeFF32lAWW2QLGAHwwUCHKJeA6Ag3rbbG0QZ/KnplxXaPdRNVT4ENyX6EjJYxj27c5SDuL58NwxhVZxgImMPYrSHHhjRBd6QZfZ8Lf/X3+zw6MaefWIUivN9+qpmdC0kytsVfWw+U1PR9oa6D11aErUkEXSDeVfolPmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF8DYSiy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF8DYSiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqdPnXXtUgXKqXi4YQbA2TfpmexS9lrI4Y5B/D9+2BM=;
	b=dF8DYSiy6NqgmapAoLHcjPWhNMcKv4kEjBHvKOyH66py4Yyj9V251Sbc7u1n5FKijHYw2B
	NK34ggttqv/Pta4JuMogvJKjjS///82MoTZy2CZ7CWA7+x0xFzmos/xVVVNu0kKFZg0+Xz
	0g+H+Wj2vGKidiPD3vQAlW3yKDqkiII=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-l7ROIyfjNCqfxb_1Kud7wA-1; Mon,
 27 Apr 2026 07:17:29 -0400
X-MC-Unique: l7ROIyfjNCqfxb_1Kud7wA-1
X-Mimecast-MFC-AGG-ID: l7ROIyfjNCqfxb_1Kud7wA_1777288649
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1F6019560AA;
	Mon, 27 Apr 2026 11:17:28 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91C6E1800349;
	Mon, 27 Apr 2026 11:17:26 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 09/23] tests: Fix boost verification in runtime and duration tests
Date: Mon, 27 Apr 2026 08:16:11 -0300
Message-ID: <20260427111632.24500-10-wander@redhat.com>
In-Reply-To: <20260427111632.24500-1-wander@redhat.com>
References: <20260427111632.24500-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The boost runtime and duration tests were previously passing the
log-only flag (-l) to stalld. This caused the daemon to detect
starvation but never actually boost tasks. Furthermore, the tests
used assert_starvation_detected, which only verified that starvation
was noticed rather than confirming a successful boost. As a result,
the tests passed trivially without validating the -r and -d options.

Remove the log-only flag so stalld operates in normal mode and
switch the assertions to assert_boost_detected.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_boost_duration.sh | 24 ++++++++++++------------
 tests/functional/test_boost_runtime.sh  | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index e9a2135..aa46e84 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -22,15 +22,15 @@ test_section "Test 1: Default boost duration (no -d specified)"
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default boost duration)"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold}
 
 # Create starvation
 starvation_duration=15
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection occurred with default duration"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with default duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -44,14 +44,14 @@ short_duration=1
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${short_duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_duration}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${short_duration}s duration"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with ${short_duration}s duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -67,14 +67,14 @@ threshold=10
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${long_duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_duration}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 
-# Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${long_duration}s duration"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with ${long_duration}s duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -89,14 +89,14 @@ duration=2
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration}
 
 # Create starvation with a specific task we can track
 log "Creating starvation on CPU ${TEST_CPU} for 15s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
 
-# Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${duration}s boost duration"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with ${duration}s boost duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index dfecccc..caaeb1d 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -22,15 +22,15 @@ test_section "Test 1: Default runtime (no -r specified)"
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default boost runtime)"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold}
 
 # Create starvation
 starvation_duration=10
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with default runtime"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with default runtime"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -44,14 +44,14 @@ custom_runtime=10000
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${custom_runtime}ns runtime"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom_runtime} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom_runtime}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with custom runtime ${custom_runtime}ns"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with custom runtime ${custom_runtime}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -65,14 +65,14 @@ large_runtime=100000
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${large_runtime}ns runtime"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_runtime} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_runtime}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with large runtime ${large_runtime}ns"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with large runtime ${large_runtime}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -88,14 +88,14 @@ period=1000000000
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with runtime ${valid_runtime}ns < period ${period}ns"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_runtime} -p ${period} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_runtime} -p ${period}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with runtime < period"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with runtime ${valid_runtime}ns < period ${period}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
-- 
2.53.0

