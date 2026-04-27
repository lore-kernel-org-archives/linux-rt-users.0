Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB33B7752
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288652; cv=none; b=rTa5LXRdnI8copxbY0K0pPfwdSMaqt4yn8EgQvx8dPF+APhal+UKdRHQRFAKgki8bonZx5FXcthBfU0flt8Y0rsx2cnejxreHfnqEVmjHpI/gIBnfn+jGp3LzpfKwNrzoA3DjbhkZOEjVrC4grXAt4+LKwWnMIYyL6uWZ0bIhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288652; c=relaxed/simple;
	bh=AvzteIfqxcaHjXg3J5ew+6UyQ/zVU6nWzOfcZqGh+9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7qjwYf4VhM2yE1mbRfz+iHEhuA3S1Wfa3KOJdOyzNbwm2Madr86e1o9yq17cIMzTvCEv0eD2SIVcqrYpcglvbLfriCx8kIR1fXE4AMlak+g0s4PDdklIwrS9yK8U48l+4wpeT74xziWArYtzbvWSVjcdOmoFRI4SQ5R6pvhJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+1G5qsK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+1G5qsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eX5N4DDElVCoRlqtqXJJAi9tvh0s4heYq5YiWFJZvNk=;
	b=b+1G5qsK9/eVqsyKWsimd2ckB3WlyZijO4kLi3CF7qjA36sIxKabmCqvoY8CLImeXO6aMe
	oli7XsqK9Y5ML9oUeh4kz2WLq5z3K9HjvZSjKMqQNQyrn7dzb1VI6q5ST7rh1H9Q2zhUAJ
	MU5viORpIwz08JqwbMlxJ+9Dq26gcL4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-R_fgQZpBPvyyLGbUn_GLEQ-1; Mon,
 27 Apr 2026 07:17:27 -0400
X-MC-Unique: R_fgQZpBPvyyLGbUn_GLEQ-1
X-Mimecast-MFC-AGG-ID: R_fgQZpBPvyyLGbUn_GLEQ_1777288646
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36B4919560B1;
	Mon, 27 Apr 2026 11:17:26 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AE3A180047F;
	Mon, 27 Apr 2026 11:17:23 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 08/23] tests: Introduce assert_stalld_rejects() helper
Date: Mon, 27 Apr 2026 08:16:10 -0300
Message-ID: <20260427111632.24500-9-wander@redhat.com>
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

Tests that verify stalld rejects invalid arguments repeat the same
pattern of invoking stalld under a timeout, capturing the exit code,
and comparing it against zero and the timeout exit code. This block
appears twelve times across seven test files.

Introduce an assert_stalld_rejects() helper that encapsulates the
invocation, exit code check, and temporary log cleanup into a single
function call. The helper automatically includes the backend flag
set by init_functional_test() so that rejection tests run under the
correct backend when the test suite is invoked with an explicit
backend selection.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_affinity.sh             | 13 +-------
 tests/functional/test_boost_duration.sh       | 25 ++------------
 tests/functional/test_boost_period.sh         | 23 ++-----------
 tests/functional/test_boost_runtime.sh        | 33 ++-----------------
 tests/functional/test_cpu_selection.sh        | 14 +-------
 tests/functional/test_pidfile.sh              | 17 ++--------
 tests/functional/test_starvation_threshold.sh | 25 ++------------
 tests/helpers/test_helpers.sh                 | 21 +++++++++++-
 8 files changed, 33 insertions(+), 138 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index ec6ff3b..12b83c9 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -200,18 +200,7 @@ fi
 #=============================================================================
 test_section "Test 7: Invalid CPU affinity (-a 999)"
 
-invalid_cpu=999
-INVALID_LOG="/tmp/stalld_test_affinity_invalid_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG}")
-
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 -a ${invalid_cpu} > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Invalid CPU affinity rejected with error"
-else
-    fail "stalld did not reject invalid CPU affinity"
-fi
+assert_stalld_rejects "Invalid CPU affinity rejected with error" -f -v -l -t 5 -a 999
 
 #=============================================================================
 # Test 8: Verify affinity persists
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index b0319d2..e9a2135 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -106,32 +106,11 @@ cleanup_scenario "${STARVE_PID}"
 #=============================================================================
 test_section "Test 5: Invalid duration values"
 
-# Test with zero duration
 log "Testing with duration = 0"
-INVALID_LOG="/tmp/stalld_test_boost_duration_invalid_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG}")
+assert_stalld_rejects "Zero duration rejected with error" -f -v -t ${threshold} -d 0
 
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d 0 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Zero duration rejected with error"
-else
-    fail "stalld did not reject invalid duration value 0"
-fi
-
-# Test 6: Negative duration
 log "Testing with duration = -5"
-rm -f "${INVALID_LOG}"
-
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d -5 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Negative duration rejected with error"
-else
-    fail "stalld did not reject invalid negative duration"
-fi
+assert_stalld_rejects "Negative duration rejected with error" -f -v -t ${threshold} -d -5
 
 log ""
 log "All boost duration tests completed"
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index b4f2339..bdbb03a 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -108,33 +108,14 @@ cleanup_scenario "${STARVE_PID}"
 #=============================================================================
 test_section "Test 5: Invalid period value (0)"
 
-INVALID_LOG="/tmp/stalld_test_boost_period_invalid_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG}")
-
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p 0 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Zero period rejected with error"
-else
-    fail "stalld did not reject invalid period value 0"
-fi
+assert_stalld_rejects "Zero period rejected with error" -f -v -t $threshold -p 0
 
 #=============================================================================
 # Test 6: Negative period
 #=============================================================================
 test_section "Test 6: Invalid period value (negative)"
 
-rm -f "${INVALID_LOG}"
-
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p -1000000 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Negative period rejected with error"
-else
-    fail "stalld did not reject invalid negative period"
-fi
+assert_stalld_rejects "Negative period rejected with error" -f -v -t $threshold -p -1000000
 
 #=============================================================================
 # Final Summary
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index 7585e6b..dfecccc 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -107,52 +107,25 @@ test_section "Test 5: Runtime > period (invalid)"
 
 invalid_runtime=2000000000
 period=1000000000
-INVALID_LOG="/tmp/stalld_test_boost_runtime_invalid_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG}")
 
 log "Testing with runtime ${invalid_runtime}ns > period ${period}ns"
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r ${invalid_runtime} -p ${period} > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Runtime > period rejected with error"
-else
-    fail "stalld did not reject invalid runtime > period"
-fi
+assert_stalld_rejects "Runtime > period rejected with error" -f -v -t ${threshold} -r ${invalid_runtime} -p ${period}
 
 #=============================================================================
 # Test 6: Invalid runtime (0)
 #=============================================================================
 test_section "Test 6: Invalid runtime value (0)"
 
-rm -f "${INVALID_LOG}"
-
 log "Testing with runtime = 0"
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r 0 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Zero runtime rejected with error"
-else
-    fail "stalld did not reject invalid runtime value 0"
-fi
+assert_stalld_rejects "Zero runtime rejected with error" -f -v -t ${threshold} -r 0
 
 #=============================================================================
 # Test 7: Negative runtime
 #=============================================================================
 test_section "Test 7: Invalid runtime value (negative)"
 
-rm -f "${INVALID_LOG}"
-
 log "Testing with runtime = -5000"
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r -5000 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Negative runtime rejected with error"
-else
-    fail "stalld did not reject invalid negative runtime"
-fi
+assert_stalld_rejects "Negative runtime rejected with error" -f -v -t ${threshold} -r -5000
 
 log ""
 log "All boost runtime tests completed"
diff --git a/tests/functional/test_cpu_selection.sh b/tests/functional/test_cpu_selection.sh
index 3fa2128..32cbe79 100755
--- a/tests/functional/test_cpu_selection.sh
+++ b/tests/functional/test_cpu_selection.sh
@@ -135,19 +135,7 @@ fi
 test_section "Test 5: Invalid CPU number (-c 999)"
 invalid_cpu=999
 
-# Create temporary log file for this specific test
-INVALID_LOG="/tmp/stalld_invalid_cpu_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG}")
-
-# Run stalld with invalid CPU and capture output
-timeout 5 "${TEST_ROOT}/../stalld" -f -v -c $invalid_cpu -l -t 5 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "stalld rejected invalid CPU number"
-else
-    fail "stalld did not reject invalid CPU"
-fi
+assert_stalld_rejects "stalld rejected invalid CPU number" -f -v -c $invalid_cpu -l -t 5
 
 # Test 6: Verify non-selected CPUs are NOT monitored
 if [ "$num_cpus" -ge 2 ]; then
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index f24c836..4509307 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -151,21 +151,8 @@ stop_stalld
 #=============================================================================
 test_section "Test 6: Invalid pidfile path (permission denied)"
 
-# Use a non-existent parent directory so fopen() fails even as root
-invalid_pidfile="/nonexistent_${$}/stalld.pid"
-
-INVALID_LOG="/tmp/stalld_test_pidfile_invalid_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG}")
-
-log "Testing invalid pidfile path: ${invalid_pidfile}"
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 --pidfile "${invalid_pidfile}" > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Invalid pidfile path rejected with error"
-else
-    fail "stalld did not reject invalid pidfile path"
-fi
+log "Testing invalid pidfile path"
+assert_stalld_rejects "Invalid pidfile path rejected with error" -f -v -l -t 5 --pidfile "/nonexistent_$$/stalld.pid"
 
 #=============================================================================
 # Test 7: Verify pidfile is readable by other processes
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 88d4d4c..79fa17b 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -113,32 +113,11 @@ cleanup_scenario "${STARVE_PID}"
 #=============================================================================
 test_section "Test 4: Invalid threshold values"
 
-# Test with zero threshold
 log "Testing with threshold = 0"
-INVALID_LOG="/tmp/stalld_test_threshold_invalid_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG}")
+assert_stalld_rejects "Zero threshold rejected with error" -f -v -t 0
 
-timeout 5 ${TEST_ROOT}/../stalld -f -v -t 0 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Zero threshold rejected with error"
-else
-    fail "stalld did not reject invalid threshold value 0"
-fi
-
-# Test with negative threshold
 log "Testing with threshold = -5"
-rm -f "${INVALID_LOG}"
-
-timeout 5 ${TEST_ROOT}/../stalld -f -v -t -5 > "${INVALID_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "Negative threshold rejected with error"
-else
-    fail "stalld did not reject invalid negative threshold"
-fi
+assert_stalld_rejects "Negative threshold rejected with error" -f -v -t -5
 
 log ""
 log "All starvation threshold tests completed"
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 389310b..742b15e 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -191,6 +191,25 @@ assert_boost_detected() {
 	fi
 }
 
+# Assert that stalld rejects invalid arguments and exits non-zero.
+# Usage: assert_stalld_rejects <message> [stalld_args...]
+assert_stalld_rejects() {
+	local message=$1
+	shift
+
+	local log="/tmp/stalld_reject_$$.log"
+	timeout 5 ${TEST_ROOT}/../stalld ${BACKEND_FLAG} "$@" > "${log}" 2>&1
+	local ret=$?
+	if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+		pass "${message}"
+	else
+		fail "${message}"
+		log "stalld output:"
+		cat "${log}"
+	fi
+	rm -f "${log}"
+}
+
 # Record a test pass with a description message.
 #
 # Usage: pass "description"
@@ -1226,7 +1245,7 @@ start_starvation_gen() {
 }
 
 # Export functions for use in tests
-export -f start_test end_test test_section cleanup_scenario find_starved_child assert_starvation_detected assert_boost_detected
+export -f start_test end_test test_section cleanup_scenario find_starved_child assert_starvation_detected assert_boost_detected assert_stalld_rejects
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
-- 
2.53.0

