Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E339DBC5
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899969; cv=none; b=fmQ8Jm0fbaIpoD5PGnaP5Ayd+xv8KKFrFWVl/7EkKt40ml5IynSznDzrxg0jtr65e4FJCBcsdkPWuebzeQ+Mq1SBsLJERY5t9rg2s+8HRkkfVdkeGX5bm37ug1MtAwTeZiugFDALat+S/A7UhpzJs5GAsOZ7DFV1VAuRcHhXlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899969; c=relaxed/simple;
	bh=DYM58I5l6LB09Ys+JTrA4LlzW0oMA4wzYrf63NiBYc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRW82ZNLX9HM1ApPUb9Cii/jS0jnD+M1BL/forDyK+k48z4fOxRqolsESQkHD6Z4fcBuAzdiqIBbRQ8FEJl6h+VZa9sKWZmC8H/gXZ/yIQ29LAy7bM5MOggQn06CgXTM4c6CkcDamO5ggmnPcJ/IHDYLX/2IyyzpnOdCHlNhz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjPFly6o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjPFly6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA3hAE69p00M9zbEQTpzF1d2Y+mjT1pD4zauicyX6/0=;
	b=SjPFly6o6GfTyj3LaP7cwdZ4URlVg5fw+j2AXhjs7DmfumUjd3Vs/Q3iqggO+cimNwUddg
	GW4zcOm4jazrlP8UGNNTZ+OA6wWcYJRFZ0MMc3SW3HVRINDjZuL7WTTarD3xvc5ZWLGVtO
	rMV3GuJ9f4ZdOe1EjYxcfxFCRdvw6Ic=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-f2tgOIqsOJmX2cKEQNvGAw-1; Mon,
 30 Mar 2026 15:46:05 -0400
X-MC-Unique: f2tgOIqsOJmX2cKEQNvGAw-1
X-Mimecast-MFC-AGG-ID: f2tgOIqsOJmX2cKEQNvGAw_1774899964
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BD0A1944EB0;
	Mon, 30 Mar 2026 19:46:04 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C47101954102;
	Mon, 30 Mar 2026 19:46:01 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 27/36] tests/functional: Use timeout for invalid argument tests
Date: Mon, 30 Mar 2026 16:43:50 -0300
Message-ID: <20260330194410.103953-28-wander@redhat.com>
In-Reply-To: <20260330194410.103953-1-wander@redhat.com>
References: <20260330194410.103953-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Invalid argument tests background stalld and sleep 2-3 seconds to
check whether it exited, wasting time on every run since stalld
rejects bad arguments almost instantly. Run stalld synchronously
under timeout instead, and treat unexpected success or timeout as
test failures rather than warnings.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_affinity.sh             | 20 ++----
 tests/functional/test_boost_duration.sh       | 38 ++++--------
 tests/functional/test_boost_period.sh         | 38 ++++--------
 tests/functional/test_boost_runtime.sh        | 62 +++++++------------
 tests/functional/test_fifo_boosting.sh        | 17 ++---
 tests/functional/test_pidfile.sh              | 21 ++-----
 tests/functional/test_starvation_threshold.sh | 36 ++++-------
 7 files changed, 77 insertions(+), 155 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index c3888ba..eac61f5 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -264,22 +264,14 @@ if [ -n "${STALLD_TEST_BACKEND}" ]; then
     BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
 fi
 
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 -a ${invalid_cpu} > "${INVALID_LOG}" 2>&1 &
-invalid_pid=$!
-sleep 2
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 -a ${invalid_cpu} > "${INVALID_LOG}" 2>&1
+ret=$?
 
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    # Process exited
-    if grep -qi "error\|invalid\|failed" "${INVALID_LOG}"; then
-        log "✓ PASS: Invalid CPU affinity rejected with error"
-    else
-        log "ℹ INFO: Invalid CPU affinity caused exit"
-    fi
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Invalid CPU affinity rejected with error"
 else
-    # Process still running - might have been ignored
-    log "⚠ WARNING: stalld accepted invalid CPU affinity"
-    kill -TERM "${invalid_pid}" 2>/dev/null || true
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid CPU affinity"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index af657db..ff43df3 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -196,20 +196,14 @@ if [ -n "${STALLD_TEST_BACKEND}" ]; then
     BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
 fi
 
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d 0 > "${INVALID_LOG}" 2>&1 &
-invalid_pid=$!
-sleep 2
-
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    if grep -qi "error\|invalid" "${INVALID_LOG}"; then
-        log "✓ PASS: Zero duration rejected with error"
-    else
-        log "ℹ INFO: Zero duration caused exit (may have been rejected)"
-    fi
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d 0 > "${INVALID_LOG}" 2>&1
+ret=$?
+
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Zero duration rejected with error"
 else
-    log "⚠ WARNING: stalld accepted zero duration"
-    kill -TERM "${invalid_pid}" 2>/dev/null || true
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid duration value 0"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Test 6: Negative duration
@@ -217,20 +211,14 @@ log "Testing with duration = -5"
 INVALID_LOG2="/tmp/stalld_test_boost_duration_invalid2_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG2}")
 
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d -5 > "${INVALID_LOG2}" 2>&1 &
-invalid_pid=$!
-sleep 2
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d -5 > "${INVALID_LOG2}" 2>&1
+ret=$?
 
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    if grep -qi "error\|invalid" "${INVALID_LOG2}"; then
-        log "✓ PASS: Negative duration rejected with error"
-    else
-        log "ℹ INFO: Negative duration caused exit"
-    fi
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Negative duration rejected with error"
 else
-    log "⚠ WARNING: stalld accepted negative duration"
-    kill -TERM "${invalid_pid}" 2>/dev/null || true
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid negative duration"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 log ""
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index 4838672..5b0ef2c 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -189,20 +189,14 @@ if [ -n "${STALLD_TEST_BACKEND}" ]; then
     BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
 fi
 
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p 0 > "${INVALID_LOG}" 2>&1 &
-invalid_pid=$!
-sleep 2
-
-if ! kill -0 "$invalid_pid" 2>/dev/null; then
-    if grep -qi "error\|invalid" "${INVALID_LOG}"; then
-        log "✓ PASS: Zero period rejected with error"
-    else
-        log "ℹ INFO: Zero period caused exit"
-    fi
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p 0 > "${INVALID_LOG}" 2>&1
+ret=$?
+
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Zero period rejected with error"
 else
-    log "⚠ WARNING: stalld accepted zero period"
-    kill -TERM "$invalid_pid" 2>/dev/null || true
-    wait "$invalid_pid" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid period value 0"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 #=============================================================================
@@ -216,20 +210,14 @@ log "=========================================="
 INVALID_LOG2="/tmp/stalld_test_boost_period_invalid2_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG2}")
 
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p -1000000 > "${INVALID_LOG2}" 2>&1 &
-invalid_pid=$!
-sleep 2
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p -1000000 > "${INVALID_LOG2}" 2>&1
+ret=$?
 
-if ! kill -0 "$invalid_pid" 2>/dev/null; then
-    if grep -qi "error\|invalid" "${INVALID_LOG2}"; then
-        log "✓ PASS: Negative period rejected with error"
-    else
-        log "ℹ INFO: Negative period caused exit"
-    fi
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Negative period rejected with error"
 else
-    log "⚠ WARNING: stalld accepted negative period"
-    kill -TERM "$invalid_pid" 2>/dev/null || true
-    wait "$invalid_pid" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid negative period"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index 734a6f8..83e8fc5 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -196,22 +196,14 @@ if [ -n "${STALLD_TEST_BACKEND}" ]; then
 fi
 
 log "Testing with runtime ${invalid_runtime}ns > period ${period}ns"
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r ${invalid_runtime} -p ${period} > "${INVALID_LOG}" 2>&1 &
-invalid_pid=$!
-sleep 2
-
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    # Process exited - this is expected behavior
-    if grep -qi "error\|invalid\|failed" "${INVALID_LOG}"; then
-        log "✓ PASS: Runtime > period rejected with error"
-    else
-        log "ℹ INFO: Runtime > period caused exit"
-    fi
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r ${invalid_runtime} -p ${period} > "${INVALID_LOG}" 2>&1
+ret=$?
+
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Runtime > period rejected with error"
 else
-    # Process still running - might be accepted or might fail later
-    log "⚠ WARNING: stalld accepted runtime > period"
-    kill -TERM "${invalid_pid}" 2>/dev/null || true
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid runtime > period"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 #=============================================================================
@@ -226,20 +218,14 @@ INVALID_LOG2="/tmp/stalld_test_boost_runtime_invalid2_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG2}")
 
 log "Testing with runtime = 0"
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r 0 > "${INVALID_LOG2}" 2>&1 &
-invalid_pid=$!
-sleep 2
-
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    if grep -qi "error\|invalid" "${INVALID_LOG2}"; then
-        log "✓ PASS: Zero runtime rejected with error"
-    else
-        log "ℹ INFO: Zero runtime caused exit"
-    fi
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r 0 > "${INVALID_LOG2}" 2>&1
+ret=$?
+
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Zero runtime rejected with error"
 else
-    log "⚠ WARNING: stalld accepted zero runtime"
-    kill -TERM "${invalid_pid}" 2>/dev/null || true
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid runtime value 0"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 #=============================================================================
@@ -254,20 +240,14 @@ INVALID_LOG3="/tmp/stalld_test_boost_runtime_invalid3_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG3}")
 
 log "Testing with runtime = -5000"
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r -5000 > "${INVALID_LOG3}" 2>&1 &
-invalid_pid=$!
-sleep 2
-
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    if grep -qi "error\|invalid" "${INVALID_LOG3}"; then
-        log "✓ PASS: Negative runtime rejected with error"
-    else
-        log "ℹ INFO: Negative runtime caused exit"
-    fi
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r -5000 > "${INVALID_LOG3}" 2>&1
+ret=$?
+
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Negative runtime rejected with error"
 else
-    log "⚠ WARNING: stalld accepted negative runtime"
-    kill -TERM "${invalid_pid}" 2>/dev/null || true
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid negative runtime"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 log ""
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 3088141..dee3250 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -331,19 +331,14 @@ CLEANUP_FILES+=("${STALLD_LOG_FAIL}")
 
 # Try to start stalld with -F but without -A (single-threaded mode)
 # This should fail because single-threaded mode only works with DEADLINE
-${TEST_ROOT}/../stalld -f -v -F -t 5 -c ${TEST_CPU} > "${STALLD_LOG_FAIL}" 2>&1 &
-FAIL_PID=$!
+timeout 5 ${TEST_ROOT}/../stalld -f -v -F -t 5 -c ${TEST_CPU} > "${STALLD_LOG_FAIL}" 2>&1
+ret=$?
 
-# Wait a bit for it to fail
-sleep 3
-
-# Check if it's still running (it shouldn't be)
-if ps -p ${FAIL_PID} > /dev/null 2>&1; then
-    log "⚠ WARNING: stalld is still running (should have exited)"
-    kill -TERM ${FAIL_PID} 2>/dev/null
-    wait ${FAIL_PID} 2>/dev/null
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "stalld exited as expected"
 else
-    log "✓ PASS: stalld exited as expected"
+    log "✗ FAIL: stalld did not reject FIFO in single-threaded mode"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Check for error message in log
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 155855e..6964c0c 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -215,23 +215,14 @@ if [ -n "${STALLD_TEST_BACKEND}" ]; then
 fi
 
 log "Testing invalid pidfile path: ${invalid_pidfile}"
-${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 --pidfile "${invalid_pidfile}" > "${INVALID_LOG}" 2>&1 &
-invalid_pid=$!
-sleep 2
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 --pidfile "${invalid_pidfile}" > "${INVALID_LOG}" 2>&1
+ret=$?
 
-# Check if stalld is still running
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    # Process exited
-    if grep -qi "error\|permission\|denied\|failed" "${INVALID_LOG}"; then
-        log "✓ PASS: Invalid pidfile path rejected with error"
-    else
-        log "ℹ INFO: Invalid pidfile path caused exit"
-    fi
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Invalid pidfile path rejected with error"
 else
-    # Process still running - might have accepted it or created elsewhere
-    log "⚠ WARNING: stalld running despite potentially invalid pidfile path"
-    kill -TERM "${invalid_pid}" 2>/dev/null || true
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid pidfile path"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 9b14009..709f565 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -187,20 +187,14 @@ log "Testing with threshold = 0"
 INVALID_LOG="/tmp/stalld_test_threshold_invalid_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
 
-${TEST_ROOT}/../stalld -f -v -t 0 > "${INVALID_LOG}" 2>&1 &
-invalid_pid=$!
-sleep 2
+timeout 5 ${TEST_ROOT}/../stalld -f -v -t 0 > "${INVALID_LOG}" 2>&1
+ret=$?
 
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    if grep -qi "error\|invalid" "${INVALID_LOG}"; then
-        log "✓ PASS: Zero threshold rejected with error"
-    else
-        log "ℹ INFO: Zero threshold caused exit (may have been rejected)"
-    fi
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Zero threshold rejected with error"
 else
-    log "⚠ WARNING: stalld accepted zero threshold"
-    kill -TERM "${invalid_pid}" 2>/dev/null
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid threshold value 0"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Test with negative threshold
@@ -208,20 +202,14 @@ log "Testing with threshold = -5"
 INVALID_LOG2="/tmp/stalld_test_threshold_invalid2_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG2}")
 
-${TEST_ROOT}/../stalld -f -v -t -5 > "${INVALID_LOG2}" 2>&1 &
-invalid_pid=$!
-sleep 2
+timeout 5 ${TEST_ROOT}/../stalld -f -v -t -5 > "${INVALID_LOG2}" 2>&1
+ret=$?
 
-if ! kill -0 "${invalid_pid}" 2>/dev/null; then
-    if grep -qi "error\|invalid" "${INVALID_LOG2}"; then
-        log "✓ PASS: Negative threshold rejected with error"
-    else
-        log "ℹ INFO: Negative threshold caused exit"
-    fi
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "Negative threshold rejected with error"
 else
-    log "⚠ WARNING: stalld accepted negative threshold"
-    kill -TERM "${invalid_pid}" 2>/dev/null
-    wait "${invalid_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject invalid negative threshold"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 log ""
-- 
2.53.0

