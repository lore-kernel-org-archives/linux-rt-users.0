Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEA3E6DE3
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285701; cv=none; b=eooeg5u8ZKUC+2X8iQjKGdU8aJ5pO9x7b41HxNw6Km0qmN9QinuP0VJKVIPBV5DipdRe0mV2SUfe9XwZKGxLjtDgMho5Di2q9PJBzekHE9Aa/FOIOFmpOOUAwk81eKtOxRzJanM3OdqLas3iQSz5YwS2DUMPa4latG5Chj/ejmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285701; c=relaxed/simple;
	bh=Pvp1vWamF9h7DNCYnZy0sL/ZttHKYDYQLXQUVT43+7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYBmG3QLKxcXa4QYgAgVwCKHDjTNWlgch5+pjO9waj5U6aRqD1haXPW4ILfEEGlNPHDdo/ATCX10lNGVHhIDWY/h3ruutn0i/sOwdhTDDlf+jPVYvNnFLh2koSbn7/8tlFrp2JHSWtKPxwzfnB9yeA6xsdj/o4n1OVLBxX9FLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILHzBU/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILHzBU/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VK7E14LzLd9IoQqWyip/yy8wqfm8Dr2K1OvIy48TGi0=;
	b=ILHzBU/IO4ocWztIJULKf2g3PojTPpYTGCLRNFQECbSheW44HFI4NKV/PnFQY6nfZ1RSaW
	Aqtk0/4ZQK0Y8OygcXn0LpNB6TRMkha9Fm5QRnAywfKEGaMjl57R7G+r0SPRM4L7DU89X1
	SRf0j6U90GQpn1iAO4RzKWmMjc4hDpQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-gb2EiHUjMma93zDf9EYU5Q-1; Wed,
 20 May 2026 10:01:29 -0400
X-MC-Unique: gb2EiHUjMma93zDf9EYU5Q-1
X-Mimecast-MFC-AGG-ID: gb2EiHUjMma93zDf9EYU5Q_1779285686
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E8931956069;
	Wed, 20 May 2026 14:01:26 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B4F01800465;
	Wed, 20 May 2026 14:01:23 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 04/33] tests: Introduce starvation and boost asserts
Date: Wed, 20 May 2026 11:00:31 -0300
Message-ID: <20260520140104.112142-5-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add assert_starvation_detected() and assert_boost_detected() wrappers
to tests/helpers/test_helpers.sh. These functions wrap the common
pattern of evaluating wait_for_* conditions, logging passes, and
dumping logs on failure into a single function call. Both helpers
return 0 or 1 to match the existing assert_* convention used
throughout the test suite.

Update 6 test files to replace 16 simple if/else evaluation blocks
with the new helpers, reducing boilerplate and yielding a net
reduction of 33 lines. Complex evaluation blocks containing nested
logic are intentionally left intact to preserve their specific
behaviors.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_boost_duration.sh       | 24 ++----------
 tests/functional/test_boost_period.sh         | 18 ++-------
 tests/functional/test_boost_runtime.sh        | 24 ++----------
 tests/functional/test_log_only.sh             |  8 +---
 tests/functional/test_starvation_detection.sh | 12 +-----
 tests/functional/test_starvation_threshold.sh | 17 +-------
 tests/helpers/test_helpers.sh                 | 39 ++++++++++++++++++-
 7 files changed, 54 insertions(+), 88 deletions(-)

diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index 9a4c11c..d1cdd1e 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -63,11 +63,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection
-if wait_for_starvation_detected "${STALLD_LOG}"; then
-    pass "Starvation detection occurred with default duration"
-else
-    fail "No starvation detection"
-fi
+assert_starvation_detected "${STALLD_LOG}" "Starvation detection occurred with default duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -89,11 +85,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection
-if wait_for_starvation_detected "${STALLD_LOG2}"; then
-    pass "Starvation detection with ${short_duration}s duration"
-else
-    fail "No starvation detection with short duration"
-fi
+assert_starvation_detected "${STALLD_LOG2}" "Starvation detection with ${short_duration}s duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -117,11 +109,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 
 # Wait for starvation detection
-if wait_for_starvation_detected "${STALLD_LOG3}"; then
-    pass "Starvation detection with ${long_duration}s duration"
-else
-    fail "No starvation detection with long duration"
-fi
+assert_starvation_detected "${STALLD_LOG3}" "Starvation detection with ${long_duration}s duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -144,11 +132,7 @@ log "Creating starvation on CPU ${TEST_CPU} for 15s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
 
 # Wait for starvation detection
-if wait_for_starvation_detected "${STALLD_LOG4}"; then
-    pass "Starvation detection with ${duration}s boost duration"
-else
-    fail "No starvation detection"
-fi
+assert_starvation_detected "${STALLD_LOG4}" "Starvation detection with ${duration}s boost duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index d7cb75f..d7112bb 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -91,11 +91,7 @@ log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection and boosting
-if wait_for_boost_detected "${STALLD_LOG}"; then
-    pass "Boosting occurred with custom period ${custom_period} ns"
-else
-    fail "No boosting with custom period"
-fi
+assert_boost_detected "${STALLD_LOG}" "Boosting occurred with custom period ${custom_period} ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -115,11 +111,7 @@ log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection and boosting
-if wait_for_boost_detected "${STALLD_LOG}"; then
-    pass "Boosting occurred with short period ${short_period} ns"
-else
-    fail "No boosting with short period"
-fi
+assert_boost_detected "${STALLD_LOG}" "Boosting occurred with short period ${short_period} ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -139,11 +131,7 @@ log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection and boosting
-if wait_for_boost_detected "${STALLD_LOG}"; then
-    pass "Boosting occurred with long period ${long_period} ns"
-else
-    fail "No boosting with long period"
-fi
+assert_boost_detected "${STALLD_LOG}" "Boosting occurred with long period ${long_period} ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index d8dba70..c17ac27 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -63,11 +63,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-if wait_for_starvation_detected "${STALLD_LOG}"; then
-    pass "Starvation detection with default runtime"
-else
-    fail "No starvation detection"
-fi
+assert_starvation_detected "${STALLD_LOG}" "Starvation detection with default runtime"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -89,11 +85,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-if wait_for_starvation_detected "${STALLD_LOG2}"; then
-    pass "Starvation detection with custom runtime ${custom_runtime}ns"
-else
-    fail "No starvation detection with custom runtime"
-fi
+assert_starvation_detected "${STALLD_LOG2}" "Starvation detection with custom runtime ${custom_runtime}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -115,11 +107,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-if wait_for_starvation_detected "${STALLD_LOG3}"; then
-    pass "Starvation detection with large runtime ${large_runtime}ns"
-else
-    fail "No starvation detection with large runtime"
-fi
+assert_starvation_detected "${STALLD_LOG3}" "Starvation detection with large runtime ${large_runtime}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -143,11 +131,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-if wait_for_starvation_detected "${STALLD_LOG4}"; then
-    pass "Starvation detection with runtime < period"
-else
-    fail "No starvation detection when runtime < period"
-fi
+assert_starvation_detected "${STALLD_LOG4}" "Starvation detection with runtime < period"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index 0e6d41b..b10b4d9 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -58,13 +58,7 @@ echo "Starvation generator started (PID ${STARVGEN_PID})"
 echo "Waiting for starvation detection..."
 
 # Check if stalld detected the starvation (should log it)
-if wait_for_starvation_detected "${LOG_FILE}"; then
-	pass "stalld detected and logged starvation"
-else
-	fail "stalld did not detect starvation"
-	echo "Log contents:"
-	cat "${LOG_FILE}"
-fi
+assert_starvation_detected "${LOG_FILE}" "stalld detected and logged starvation"
 
 # Check that stalld did NOT boost (should not see "boosted" message with -l)
 if ! grep -q "boosted" "${LOG_FILE}"; then
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 919148b..3307edb 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -256,18 +256,10 @@ else
 
     # Wait for starvation detection on both CPUs
     log "Waiting for starvation detection on CPU ${CPU0}..."
-    if wait_for_starvation_detected "${STALLD_LOG}" 30 "${CPU0}"; then
-        pass "Starvation detected on CPU ${CPU0}"
-    else
-        fail "Starvation not detected on CPU ${CPU0}"
-    fi
+    assert_starvation_detected "${STALLD_LOG}" "Starvation detected on CPU ${CPU0}" "30" "${CPU0}"
 
     log "Waiting for starvation detection on CPU ${CPU1}..."
-    if wait_for_starvation_detected "${STALLD_LOG}" 30 "${CPU1}"; then
-        pass "Starvation detected on CPU ${CPU1}"
-    else
-        fail "Starvation not detected on CPU ${CPU1}"
-    fi
+    assert_starvation_detected "${STALLD_LOG}" "Starvation detected on CPU ${CPU1}" "30" "${CPU1}"
 
     # Cleanup
     cleanup_scenario "${STARVE_PID0}" "${STARVE_PID1}"
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 8b54b95..62f7420 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -71,14 +71,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -N -M -g 1 -i "ksoftirqd,kworker" -c
 # Wait for starvation detection
 log "Waiting for detection (threshold: ${threshold}s)"
 
-# Check if starvation was detected - specifically look for starvation_gen tasks
-if wait_for_starvation_detected "${STALLD_LOG}"; then
-    pass "Starvation detected after ${threshold}s threshold"
-else
-    fail "Starvation not detected after ${threshold}s threshold"
-    log "Log contents:"
-    cat "${STALLD_LOG}"
-fi
+assert_starvation_detected "${STALLD_LOG}" "Starvation detected after ${threshold}s threshold"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -145,13 +138,7 @@ start_stalld_with_log "${STALLD_LOG3}" -f -v -N -M -g 1 -i "ksoftirqd,kworker" -
 log "Waiting for detection (threshold: ${threshold}s)"
 
 # Check if starvation_gen was detected
-if wait_for_starvation_detected "${STALLD_LOG3}"; then
-    pass "Starvation detected with ${threshold}s threshold"
-else
-    fail "Starvation not detected with ${threshold}s threshold"
-    log "Log contents:"
-    cat "${STALLD_LOG3}"
-fi
+assert_starvation_detected "${STALLD_LOG3}" "Starvation detected with ${threshold}s threshold"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index d4e98f7..fb6c9d1 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -126,6 +126,43 @@ cleanup_scenario() {
 	stop_stalld
 }
 
+# Assert that stalld detects a starving task within the timeout.
+# Usage: assert_starvation_detected <log_file> <message> [timeout] [cpu]
+assert_starvation_detected() {
+	local log_file=$1
+	local message=${2:-"Starvation detected"}
+	local timeout=${3:-30}
+	local cpu=${4:-}
+
+	if wait_for_starvation_detected "${log_file}" "${timeout}" "${cpu}"; then
+		pass "${message}"
+		return 0
+	else
+		fail "${message}"
+		log "Log contents:"
+		cat "${log_file}"
+		return 1
+	fi
+}
+
+# Assert that stalld boosts a starving task within the timeout.
+# Usage: assert_boost_detected <log_file> <message> [timeout]
+assert_boost_detected() {
+	local log_file=$1
+	local message=${2:-"Boost detected"}
+	local timeout=${3:-30}
+
+	if wait_for_boost_detected "${log_file}" "${timeout}"; then
+		pass "${message}"
+		return 0
+	else
+		fail "${message}"
+		log "Log contents:"
+		cat "${log_file}"
+		return 1
+	fi
+}
+
 # Record a test pass with a description message.
 #
 # Usage: pass "description"
@@ -1150,7 +1187,7 @@ start_starvation_gen() {
 }
 
 # Export functions for use in tests
-export -f start_test end_test test_section cleanup_scenario
+export -f start_test end_test test_section cleanup_scenario assert_starvation_detected assert_boost_detected
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
-- 
2.54.0

