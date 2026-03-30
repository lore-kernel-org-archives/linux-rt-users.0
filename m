Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646C39DBD4
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899981; cv=none; b=T9nRDMcEzfPTvWkRe9DThhwfKJOV053ypnN/DNxsE75YHIxMlKpKxEsFP6VDKXbqEWpOYfFsPKmSySxJH2sLzY0VykeWAaGXUMiXwB2fD+fWnM9C5+mmD8Y94fY1ptJSWUP2KO0IfZssM0JNQEIMIrWfEusrIU6i8JCA2ZK+d7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899981; c=relaxed/simple;
	bh=fmse/YGOrljEKMyroD4+Y8bmsh67JMHq+/rTnsK2l8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMixr1UCBJqSX90Uhnr1TzGG9/V9o9dgLaLPwWdc1DiPHYfvTatT80JVCMZ1PkQurjBNGobTILLzE2QmyFLfCzUsQdDAMy/UK9+Hm7wDpIcowCIjgW+goPMLQFnQlzsp/nc7NInPFooyY7Em2yJWbjxz83nrCCUdAC9F+kM8s/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMp1juNG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMp1juNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2O8FNjA6eeNsF/6xd9MasP1cfL4XwiZ16XHCYagZy0=;
	b=NMp1juNG7sRwnOAnNJxJfXzbSCg57XPAmtRmJ/jPDBAJEp1hyP3CD4P3T7l0PK9tvT2Mp8
	6mMYNqR7YgXxqa0LvP+5eii6JJFxJkVQjoldBdpfHL4axvwubp1D5oAPNNV0x7xbQvRrNl
	Urz1ve6bfT4PktjU9lGfxAyJTTvsI7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-AwdGrTibP8yfDv6Y5vjcBA-1; Mon,
 30 Mar 2026 15:46:16 -0400
X-MC-Unique: AwdGrTibP8yfDv6Y5vjcBA-1
X-Mimecast-MFC-AGG-ID: AwdGrTibP8yfDv6Y5vjcBA_1774899975
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AF2218005B0;
	Mon, 30 Mar 2026 19:46:15 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49E691954102;
	Mon, 30 Mar 2026 19:46:12 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 30/36] tests: Add fail() helper and use for all test failures
Date: Mon, 30 Mar 2026 16:43:53 -0300
Message-ID: <20260330194410.103953-31-wander@redhat.com>
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

Add a fail() function that mirrors pass(), logging a failure
message and incrementing the failure counter. Replace all manual
fail patterns across the test suite, including both the log-based
and echo-based variants.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_affinity.sh             |  6 ++--
 tests/functional/test_backend_selection.sh    |  6 ++--
 tests/functional/test_boost_duration.sh       | 18 ++++-------
 tests/functional/test_boost_period.sh         | 18 ++++-------
 tests/functional/test_boost_restoration.sh    |  3 +-
 tests/functional/test_boost_runtime.sh        | 21 +++++--------
 tests/functional/test_cpu_selection.sh        | 18 ++++-------
 tests/functional/test_deadline_boosting.sh    | 12 +++-----
 tests/functional/test_fifo_boosting.sh        | 12 +++-----
 .../test_fifo_priority_starvation.sh          | 15 ++++------
 tests/functional/test_force_fifo.sh           |  6 ++--
 tests/functional/test_foreground.sh           |  9 ++----
 tests/functional/test_idle_detection.sh       |  3 +-
 tests/functional/test_log_only.sh             |  6 ++--
 tests/functional/test_logging_destinations.sh |  6 ++--
 tests/functional/test_pidfile.sh              | 27 ++++++-----------
 tests/functional/test_runqueue_parsing.sh     | 27 ++++++-----------
 tests/functional/test_starvation_detection.sh | 30 +++++++------------
 tests/functional/test_starvation_threshold.sh | 15 ++++------
 tests/functional/test_task_merging.sh         |  3 +-
 tests/helpers/test_helpers.sh                 | 11 ++++++-
 21 files changed, 97 insertions(+), 175 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index b74886d..7ecd85f 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -109,8 +109,7 @@ affinity=$(check_affinity "${STALLD_PID}")
 if [ "$affinity" = "0" ]; then
     pass "stalld restricted to CPU 0"
 else
-    log "✗ FAIL: stalld affinity ($affinity) doesn't match requested (0)"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld affinity ($affinity) doesn't match requested (0)"
 fi
 
 stop_stalld
@@ -270,8 +269,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Invalid CPU affinity rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid CPU affinity"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid CPU affinity"
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_backend_selection.sh b/tests/functional/test_backend_selection.sh
index 8a22e0a..2db8353 100755
--- a/tests/functional/test_backend_selection.sh
+++ b/tests/functional/test_backend_selection.sh
@@ -39,8 +39,7 @@ test_backend_flag() {
 	CLEANUP_PIDS+=("${STALLD_PID}")
 
 	if ! wait_for_stalld_ready "${log_file}" 15; then
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: stalld failed to start (${description})"
+		fail "stalld failed to start (${description})"
 		stop_stalld
 		return 1
 	fi
@@ -48,8 +47,7 @@ test_backend_flag() {
 	if grep -q "${expected_msg}" "${log_file}"; then
 		pass "${description}"
 	else
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: Backend message not found (${description})"
+		fail "Backend message not found (${description})"
 		echo "  Expected: ${expected_msg}"
 		echo "  Log contents:"
 		cat "${log_file}"
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index 61218e9..83d8355 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -69,8 +69,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_starvation_detected "${STALLD_LOG}"; then
     pass "Starvation detection occurred with default duration"
 else
-    log "✗ FAIL: No starvation detection"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No starvation detection"
 fi
 
 # Cleanup
@@ -101,8 +100,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_starvation_detected "${STALLD_LOG2}"; then
     pass "Starvation detection with ${short_duration}s duration"
 else
-    log "✗ FAIL: No starvation detection with short duration"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No starvation detection with short duration"
 fi
 
 # Cleanup
@@ -135,8 +133,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 if wait_for_starvation_detected "${STALLD_LOG3}"; then
     pass "Starvation detection with ${long_duration}s duration"
 else
-    log "✗ FAIL: No starvation detection with long duration"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No starvation detection with long duration"
 fi
 
 # Cleanup
@@ -168,8 +165,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
 if wait_for_starvation_detected "${STALLD_LOG4}"; then
     pass "Starvation detection with ${duration}s boost duration"
 else
-    log "✗ FAIL: No starvation detection"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No starvation detection"
 fi
 
 # Cleanup
@@ -202,8 +198,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Zero duration rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid duration value 0"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid duration value 0"
 fi
 
 # Test 6: Negative duration
@@ -217,8 +212,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Negative duration rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid negative duration"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid negative duration"
 fi
 
 log ""
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index 671f7cb..3f3ef46 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -71,10 +71,9 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
         log "ℹ INFO: Period information found in logs"
     fi
 else
-    log "✗ FAIL: No boosting detected"
+    fail "No boosting detected"
     log "Log contents:"
     cat "${STALLD_LOG}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
@@ -103,8 +102,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_boost_detected "${STALLD_LOG}"; then
     pass "Boosting occurred with custom period ${custom_period} ns"
 else
-    log "✗ FAIL: No boosting with custom period"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No boosting with custom period"
 fi
 
 # Cleanup
@@ -133,8 +131,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_boost_detected "${STALLD_LOG}"; then
     pass "Boosting occurred with short period ${short_period} ns"
 else
-    log "✗ FAIL: No boosting with short period"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No boosting with short period"
 fi
 
 # Cleanup
@@ -163,8 +160,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_boost_detected "${STALLD_LOG}"; then
     pass "Boosting occurred with long period ${long_period} ns"
 else
-    log "✗ FAIL: No boosting with long period"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No boosting with long period"
 fi
 
 # Cleanup
@@ -195,8 +191,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Zero period rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid period value 0"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid period value 0"
 fi
 
 #=============================================================================
@@ -216,8 +211,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Negative period rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid negative period"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid negative period"
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 024d869..bac73ba 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -391,8 +391,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     if assert_process_running "${STALLD_PID}" "stalld still running after task exit"; then
         pass "stalld handled task exit during boost gracefully"
     else
-        log "✗ FAIL: stalld crashed or exited after task died during boost"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "stalld crashed or exited after task died during boost"
     fi
 
     # Check for error messages
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index b624fc9..71e25f1 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -69,8 +69,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_starvation_detected "${STALLD_LOG}"; then
     pass "Starvation detection with default runtime"
 else
-    log "✗ FAIL: No starvation detection"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No starvation detection"
 fi
 
 # Cleanup
@@ -101,8 +100,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_starvation_detected "${STALLD_LOG2}"; then
     pass "Starvation detection with custom runtime ${custom_runtime}ns"
 else
-    log "✗ FAIL: No starvation detection with custom runtime"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No starvation detection with custom runtime"
 fi
 
 # Cleanup
@@ -133,8 +131,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_starvation_detected "${STALLD_LOG3}"; then
     pass "Starvation detection with large runtime ${large_runtime}ns"
 else
-    log "✗ FAIL: No starvation detection with large runtime"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No starvation detection with large runtime"
 fi
 
 # Cleanup
@@ -167,8 +164,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 if wait_for_starvation_detected "${STALLD_LOG4}"; then
     pass "Starvation detection with runtime < period"
 else
-    log "✗ FAIL: No starvation detection when runtime < period"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No starvation detection when runtime < period"
 fi
 
 # Cleanup
@@ -202,8 +198,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Runtime > period rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid runtime > period"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid runtime > period"
 fi
 
 #=============================================================================
@@ -224,8 +219,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Zero runtime rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid runtime value 0"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid runtime value 0"
 fi
 
 #=============================================================================
@@ -246,8 +240,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Negative runtime rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid negative runtime"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid negative runtime"
 fi
 
 log ""
diff --git a/tests/functional/test_cpu_selection.sh b/tests/functional/test_cpu_selection.sh
index 2f9875d..99eac44 100755
--- a/tests/functional/test_cpu_selection.sh
+++ b/tests/functional/test_cpu_selection.sh
@@ -44,8 +44,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 if grep -q "cpu 0" "$STALLD_LOG"; then
     pass "stalld monitoring CPU 0"
 else
-    TEST_FAILED=$((TEST_FAILED + 1))
-    echo -e "  ${RED}FAIL${NC}: stalld not monitoring CPU 0"
+    fail "stalld not monitoring CPU 0"
 fi
 
 stop_stalld
@@ -70,8 +69,7 @@ if [ "$num_cpus" -ge 4 ]; then
     if [ "$cpu0_found" -eq 1 ] && [ "$cpu2_found" -eq 1 ]; then
         pass "stalld monitoring CPUs 0 and 2"
     else
-        TEST_FAILED=$((TEST_FAILED + 1))
-        echo -e "  ${RED}FAIL${NC}: stalld not monitoring specified CPUs (0: $cpu0_found, 2: $cpu2_found)"
+        fail "stalld not monitoring specified CPUs (0: $cpu0_found, 2: $cpu2_found)"
     fi
 
     stop_stalld
@@ -103,8 +101,7 @@ if [ "$num_cpus" -ge 4 ]; then
     if [ "$cpu0_found" -eq 1 ] && [ "$cpu1_found" -eq 1 ] && [ "$cpu2_found" -eq 1 ]; then
         pass "stalld monitoring CPUs 0-2"
     else
-        TEST_FAILED=$((TEST_FAILED + 1))
-        echo -e "  ${RED}FAIL${NC}: stalld not monitoring specified CPU range (0: $cpu0_found, 1: $cpu1_found, 2: $cpu2_found)"
+        fail "stalld not monitoring specified CPU range (0: $cpu0_found, 1: $cpu1_found, 2: $cpu2_found)"
     fi
 
     stop_stalld
@@ -130,8 +127,7 @@ if [ "$num_cpus" -ge 6 ]; then
     if [ "$monitored_cpus" -eq 4 ]; then
         pass "stalld monitoring combined CPU specification (0,2-4)"
     else
-        TEST_FAILED=$((TEST_FAILED + 1))
-        echo -e "  ${RED}FAIL${NC}: stalld not monitoring all specified CPUs (found $monitored_cpus/4)"
+        fail "stalld not monitoring all specified CPUs (found $monitored_cpus/4)"
     fi
 
     stop_stalld
@@ -155,8 +151,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "stalld rejected invalid CPU number"
 else
-    log "✗ FAIL: stalld did not reject invalid CPU"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid CPU"
 fi
 
 # Test 6: Verify non-selected CPUs are NOT monitored
@@ -170,8 +165,7 @@ if [ "$num_cpus" -ge 2 ]; then
     if ! grep -q "cpu 1" "$STALLD_LOG" || grep -q "not monitoring.*cpu 1" "$STALLD_LOG"; then
         pass "stalld not monitoring non-selected CPU 1"
     else
-        TEST_FAILED=$((TEST_FAILED + 1))
-        echo -e "  ${RED}FAIL${NC}: stalld appears to be monitoring CPU 1 when only CPU 0 selected"
+        fail "stalld appears to be monitoring CPU 1 when only CPU 0 selected"
     fi
 
     stop_stalld
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 86ca0f1..544222a 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -74,8 +74,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     if grep -q "SCHED_DEADLINE" "${STALLD_LOG}"; then
         pass "SCHED_DEADLINE boosting used (default)"
     else
-        log "✗ FAIL: SCHED_DEADLINE not mentioned in boost message"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "SCHED_DEADLINE not mentioned in boost message"
     fi
 
     # Verify boost happened after threshold
@@ -86,10 +85,9 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
         log "⚠ WARNING: No starvation message before boost"
     fi
 else
-    log "✗ FAIL: No boosting detected"
+    fail "No boosting detected"
     log "Log contents:"
     cat "${STALLD_LOG}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
@@ -153,8 +151,7 @@ if [ ${boosted_task_found} -eq 0 ]; then
     if grep -q "boosted.*SCHED_DEADLINE" "${STALLD_LOG}"; then
         pass "SCHED_DEADLINE boost confirmed in logs"
     else
-        log "✗ FAIL: No SCHED_DEADLINE boost detected"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "No SCHED_DEADLINE boost detected"
     fi
 fi
 
@@ -226,8 +223,7 @@ fi
 if grep -q "boosted" "${STALLD_LOG}"; then
     pass "Boost occurred as expected"
 else
-    log "✗ FAIL: No boost detected"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "No boost detected"
 fi
 
 # Cleanup
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index df26483..50c8d14 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -72,14 +72,12 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     if grep -q "SCHED_FIFO" "${STALLD_LOG}"; then
         pass "SCHED_FIFO boosting used (as requested by -F)"
     else
-        log "✗ FAIL: SCHED_FIFO not mentioned in boost message"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "SCHED_FIFO not mentioned in boost message"
     fi
 else
-    log "✗ FAIL: No boosting detected with -F flag"
+    fail "No boosting detected with -F flag"
     log "Log contents:"
     cat "${STALLD_LOG}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
@@ -134,8 +132,7 @@ if [ ${fifo_task_found} -eq 0 ]; then
     if grep -q "boosted.*SCHED_FIFO" "${STALLD_LOG}"; then
         pass "SCHED_FIFO boost confirmed in logs"
     else
-        log "✗ FAIL: No SCHED_FIFO boost detected"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "No SCHED_FIFO boost detected"
     fi
 fi
 
@@ -337,8 +334,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "stalld exited as expected"
 else
-    log "✗ FAIL: stalld did not reject FIFO in single-threaded mode"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject FIFO in single-threaded mode"
 fi
 
 # Check for error message in log
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 3776e6b..9554d49 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -78,22 +78,19 @@ if wait_for_starvation_detected "${STALLD_LOG}"; then
     if grep "starved on CPU ${TEST_CPU}" "${STALLD_LOG}"; then
         pass "Correct CPU ID logged (CPU ${TEST_CPU})"
     else
-        log "✗ FAIL: Wrong CPU ID in log"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Wrong CPU ID in log"
     fi
 
     # Verify duration is logged
     if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}"; then
         pass "Starvation duration logged"
     else
-        log "✗ FAIL: Starvation duration not logged"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Starvation duration not logged"
     fi
 else
-    log "✗ FAIL: FIFO-on-FIFO starvation not detected"
+    fail "FIFO-on-FIFO starvation not detected"
     log "Log contents:"
     cat "${STALLD_LOG}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
@@ -159,8 +156,7 @@ else
     if grep -q "boosted" "${STALLD_LOG}"; then
         log "ℹ INFO: Boosting did occur according to logs"
     else
-        log "✗ FAIL: No boosting detected"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "No boosting detected"
     fi
 fi
 
@@ -218,8 +214,7 @@ if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}" | wc
         pass "Starvation duration increased (${first_duration}s -> ${last_duration}s)"
         log "        This confirms task merging preserved the timestamp"
     else
-        log "✗ FAIL: Starvation duration did not increase (timestamp may have been reset)"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Starvation duration did not increase (timestamp may have been reset)"
     fi
 else
     log "⚠ WARNING: Not enough starvation reports to verify task merging"
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index fec2e00..ecaa7ac 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -107,8 +107,7 @@ if wait_for_boost_detected "${STALLD_LOG2}"; then
     if grep -qi "fifo\|SCHED_FIFO" "${STALLD_LOG2}"; then
         pass "SCHED_FIFO used with -F flag"
     elif grep -qi "deadline\|SCHED_DEADLINE" "${STALLD_LOG2}"; then
-        log "✗ FAIL: SCHED_DEADLINE used despite -F flag"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "SCHED_DEADLINE used despite -F flag"
     else
         log "⚠ WARNING: Scheduling policy not explicitly mentioned in logs"
     fi
@@ -220,8 +219,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "single-threaded mode rejected FIFO"
 else
-    log "✗ FAIL: stalld did not reject -F in single-threaded mode"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject -F in single-threaded mode"
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_foreground.sh b/tests/functional/test_foreground.sh
index 2bb0282..8b89d02 100755
--- a/tests/functional/test_foreground.sh
+++ b/tests/functional/test_foreground.sh
@@ -38,8 +38,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 		if [ "${PARENT_PID}" != "$$" ]; then
 			pass "stalld daemonized (parent is not test shell)"
 		else
-			TEST_FAILED=$((TEST_FAILED + 1))
-			echo -e "  ${RED}FAIL${NC}: stalld did not daemonize (parent is test shell)"
+			fail "stalld did not daemonize (parent is test shell)"
 		fi
 	fi
 fi
@@ -64,8 +63,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running with -f"; th
 	if [ "${PARENT_PID}" != "1" ]; then
 		pass "stalld did not daemonize with -f (parent is not init)"
 	else
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: stalld daemonized even with -f flag"
+		fail "stalld daemonized even with -f flag"
 	fi
 fi
 
@@ -84,8 +82,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running with -v"; th
 	if [ "${PARENT_PID}" != "1" ]; then
 		pass "-v implies foreground mode"
 	else
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: -v should imply foreground mode"
+		fail "-v should imply foreground mode"
 	fi
 fi
 
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index af4d7a4..8757d74 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -137,8 +137,7 @@ if [ -n "${idle_time1}" ] && [ -n "${idle_time2}" ]; then
         log "        stalld would parse this CPU"
     fi
 else
-    log "✗ FAIL: Could not read idle time from /proc/stat"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "Could not read idle time from /proc/stat"
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index d6257cf..21518a4 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -61,8 +61,7 @@ echo "Waiting for starvation detection..."
 if wait_for_starvation_detected "${LOG_FILE}"; then
 	pass "stalld detected and logged starvation"
 else
-	TEST_FAILED=$((TEST_FAILED + 1))
-	echo -e "  ${RED}FAIL${NC}: stalld did not detect starvation"
+	fail "stalld did not detect starvation"
 	echo "Log contents:"
 	cat "${LOG_FILE}"
 fi
@@ -71,8 +70,7 @@ fi
 if ! grep -q "boosted" "${LOG_FILE}"; then
 	pass "stalld did not boost in log-only mode"
 else
-	TEST_FAILED=$((TEST_FAILED + 1))
-	echo -e "  ${RED}FAIL${NC}: stalld boosted despite -l flag"
+	fail "stalld boosted despite -l flag"
 	echo "Log contents:"
 	cat "${LOG_FILE}"
 fi
diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index 35470c0..f05cd00 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -45,8 +45,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 			pass "output contains expected messages"
 		fi
 	else
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: no output in verbose mode"
+		fail "no output in verbose mode"
 	fi
 fi
 
@@ -158,8 +157,7 @@ if assert_process_running "${STALLD_PID}" "stalld with combined logging should b
 	if [ -s "${LOG_FILE}" ]; then
 		pass "combined logging produces output"
 	else
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: no output with combined logging"
+		fail "no output with combined logging"
 	fi
 fi
 
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index fd4fedc..0e4c623 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -56,8 +56,7 @@ for pidfile in /var/run/stalld.pid /run/stalld.pid; do
         if [ "$pid_from_file" = "${STALLD_PID}" ]; then
             pass "Default pidfile contains correct PID"
         else
-            log "✗ FAIL: Default pidfile PID ($pid_from_file) doesn't match stalld PID (${STALLD_PID})"
-            TEST_FAILED=$((TEST_FAILED + 1))
+            fail "Default pidfile PID ($pid_from_file) doesn't match stalld PID (${STALLD_PID})"
         fi
         break
     fi
@@ -99,12 +98,10 @@ if [ -f "${custom_pidfile}" ]; then
     if [ "$pid_from_file" = "${STALLD_PID}" ]; then
         pass "Custom pidfile contains correct PID ($pid_from_file)"
     else
-        log "✗ FAIL: Custom pidfile PID ($pid_from_file) doesn't match stalld PID (${STALLD_PID})"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Custom pidfile PID ($pid_from_file) doesn't match stalld PID (${STALLD_PID})"
     fi
 else
-    log "✗ FAIL: Custom pidfile not created at ${custom_pidfile}"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "Custom pidfile not created at ${custom_pidfile}"
 fi
 
 # Test 3: Verify pidfile removed on clean shutdown
@@ -145,12 +142,10 @@ if [ -f "${tmp_pidfile}" ]; then
     if [ "$pid_from_file" = "${STALLD_PID}" ]; then
         pass "/tmp pidfile contains correct PID"
     else
-        log "✗ FAIL: /tmp pidfile has incorrect PID"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "/tmp pidfile has incorrect PID"
     fi
 else
-    log "✗ FAIL: Pidfile not created in /tmp"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "Pidfile not created in /tmp"
 fi
 
 stop_stalld
@@ -181,8 +176,7 @@ if [ -f "${fg_pidfile}" ]; then
     if [ "$pid_from_file" = "${STALLD_PID}" ]; then
         pass "Foreground mode pidfile contains correct PID"
     else
-        log "✗ FAIL: Foreground mode pidfile has incorrect PID"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Foreground mode pidfile has incorrect PID"
     fi
 else
     log "⚠ WARNING: Pidfile not created in foreground mode (may be expected)"
@@ -221,8 +215,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Invalid pidfile path rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid pidfile path"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid pidfile path"
 fi
 
 # Cleanup
@@ -256,12 +249,10 @@ if [ -f "${readable_pidfile}" ]; then
         perms=$(stat -c "%a" "${readable_pidfile}" 2>/dev/null || stat -f "%Lp" "${readable_pidfile}" 2>/dev/null)
         log "ℹ INFO: Pidfile permissions: $perms"
     else
-        log "✗ FAIL: Pidfile not readable"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Pidfile not readable"
     fi
 else
-    log "✗ FAIL: Pidfile not created"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "Pidfile not created"
 fi
 
 stop_stalld
diff --git a/tests/functional/test_runqueue_parsing.sh b/tests/functional/test_runqueue_parsing.sh
index fc69fa0..ac5190e 100755
--- a/tests/functional/test_runqueue_parsing.sh
+++ b/tests/functional/test_runqueue_parsing.sh
@@ -108,8 +108,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
         if grep -E "starvation_gen.*starved on CPU ${TEST_CPU}" "${STALLD_LOG_BPF}"; then
             pass "Task name (comm) correctly extracted"
         else
-            log "✗ FAIL: Task name not found in eBPF backend output"
-            TEST_FAILED=$((TEST_FAILED + 1))
+            fail "Task name not found in eBPF backend output"
         fi
 
         # Verify PID is logged
@@ -119,10 +118,9 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
             log "⚠ INFO: PID format may have changed"
         fi
     else
-        log "✗ FAIL: eBPF backend did not detect starvation"
+        fail "eBPF backend did not detect starvation"
         log "Log contents:"
         cat "${STALLD_LOG_BPF}"
-        TEST_FAILED=$((TEST_FAILED + 1))
     fi
 
     # Cleanup
@@ -163,8 +161,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
         if grep -E "starvation_gen.*starved on CPU ${TEST_CPU}" "${STALLD_LOG_SCHED}"; then
             pass "Task name (comm) correctly extracted"
         else
-            log "✗ FAIL: Task name not found in sched_debug backend output"
-            TEST_FAILED=$((TEST_FAILED + 1))
+            fail "Task name not found in sched_debug backend output"
         fi
 
         # Verify PID is logged
@@ -180,10 +177,9 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
             log "ℹ INFO: Kernel format detected: $format"
         fi
     else
-        log "✗ FAIL: sched_debug backend did not detect starvation"
+        fail "sched_debug backend did not detect starvation"
         log "Log contents:"
         cat "${STALLD_LOG_SCHED}"
-        TEST_FAILED=$((TEST_FAILED + 1))
     fi
 
     # Cleanup
@@ -262,8 +258,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
             log "        This may be due to timing differences between backends"
         fi
     else
-        log "✗ FAIL: One or both backends failed to detect starvation"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "One or both backends failed to detect starvation"
     fi
 else
     log ""
@@ -315,32 +310,28 @@ if [ -n "$test_backend" ]; then
     if grep -q "starvation_gen" "${log_file}"; then
         pass "Task name (comm) field extracted"
     else
-        log "✗ FAIL: Task name (comm) field not found"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Task name (comm) field not found"
     fi
 
     # Check for PID field (format: name-PID or [PID])
     if grep -qE "(starvation_gen-[0-9]+|\[[0-9]+\])" "${log_file}"; then
         pass "PID field extracted"
     else
-        log "✗ FAIL: PID field not found"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "PID field not found"
     fi
 
     # Check for CPU ID
     if grep -q "CPU ${TEST_CPU}" "${log_file}"; then
         pass "CPU ID field extracted"
     else
-        log "✗ FAIL: CPU ID field not found"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "CPU ID field not found"
     fi
 
     # Check for starvation duration
     if grep -qE "for [0-9]+ seconds" "${log_file}"; then
         pass "Starvation duration calculated from context switches/time"
     else
-        log "✗ FAIL: Starvation duration not found"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Starvation duration not found"
     fi
 
     # Cleanup
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 6d4d7c5..680cf39 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -81,22 +81,19 @@ if wait_for_starvation_detected "${STALLD_LOG}"; then
     if grep "starved on CPU ${TEST_CPU}" "${STALLD_LOG}"; then
         pass "Correct CPU ID logged (CPU ${TEST_CPU})"
     else
-        log "✗ FAIL: Wrong CPU ID in log"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Wrong CPU ID in log"
     fi
 
     # Verify duration is logged
     if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}"; then
         pass "Starvation duration logged"
     else
-        log "✗ FAIL: Starvation duration not logged"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Starvation duration not logged"
     fi
 else
-    log "✗ FAIL: Starvation not detected"
+    fail "Starvation not detected"
     log "Log contents:"
     cat "${STALLD_LOG}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
@@ -147,8 +144,7 @@ if [ -n "${STARVE_CHILDREN}" ]; then
             if [ ${ctxt_delta} -lt 5 ]; then
                 pass "Context switch count remained low (delta: ${ctxt_delta})"
             else
-                log "✗ FAIL: Context switches increased significantly (delta: ${ctxt_delta})"
-                TEST_FAILED=$((TEST_FAILED + 1))
+                fail "Context switches increased significantly (delta: ${ctxt_delta})"
             fi
             break
         fi
@@ -213,14 +209,12 @@ if [ "${report_count}" -ge 2 ]; then
         pass "Starvation duration increased (${first_duration}s -> ${last_duration}s)"
         log "        This confirms task merging preserved the timestamp"
     else
-        log "✗ FAIL: Starvation duration did not increase (timestamp may have been reset)"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Starvation duration did not increase (timestamp may have been reset)"
     fi
 else
-    log "✗ FAIL: Not enough starvation reports to verify task merging (found ${report_count}, need >= 2)"
+    fail "Not enough starvation reports to verify task merging (found ${report_count}, need >= 2)"
     log "Log contents:"
     cat "${STALLD_LOG}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup starvation generator
@@ -285,15 +279,13 @@ else
     if grep -qE "starvation_gen.*starved on CPU ${CPU0}|starved on CPU ${CPU0}.*starvation_gen" "${STALLD_LOG}"; then
         pass "Starvation detected on CPU ${CPU0}"
     else
-        log "✗ FAIL: Starvation not detected on CPU ${CPU0}"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Starvation not detected on CPU ${CPU0}"
     fi
 
     if grep -qE "starvation_gen.*starved on CPU ${CPU1}|starved on CPU ${CPU1}.*starvation_gen" "${STALLD_LOG}"; then
         pass "Starvation detected on CPU ${CPU1}"
     else
-        log "✗ FAIL: Starvation not detected on CPU ${CPU1}"
-        TEST_FAILED=$((TEST_FAILED + 1))
+        fail "Starvation not detected on CPU ${CPU1}"
     fi
 
     # Cleanup
@@ -372,16 +364,14 @@ sleep 5
 if assert_process_running "${STALLD_PID}" "stalld still running after task exit"; then
     pass "stalld handled task exit gracefully"
 else
-    log "✗ FAIL: stalld crashed or exited unexpectedly"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld crashed or exited unexpectedly"
 fi
 
 # Check for error messages
 if grep -iE "error|segfault|crash" "${STALLD_LOG}"; then
-    log "✗ FAIL: Error messages found in log"
+    fail "Error messages found in log"
     log "Errors:"
     grep -iE "error|segfault|crash" "${STALLD_LOG}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 else
     pass "No error messages in log"
 fi
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index a35f898..a2cd420 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -78,10 +78,9 @@ log "Waiting for detection (threshold: ${threshold}s)"
 if wait_for_starvation_detected "${STALLD_LOG}"; then
     pass "Starvation detected after ${threshold}s threshold"
 else
-    log "✗ FAIL: Starvation not detected after ${threshold}s threshold"
+    fail "Starvation not detected after ${threshold}s threshold"
     log "Log contents:"
     cat "${STALLD_LOG}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
@@ -123,10 +122,9 @@ sleep 2
 if ! grep -qE "starvation_gen.*starved on CPU ${TEST_CPU}|starved on CPU ${TEST_CPU}.*starvation_gen" "${STALLD_LOG2}"; then
     pass "No starvation detected for duration less than threshold"
 else
-    log "✗ FAIL: Starvation detected before threshold"
+    fail "Starvation detected before threshold"
     log "Found starvation_gen task in logs:"
     grep -E "starvation_gen.*starved on CPU|starved on CPU.*starvation_gen" "${STALLD_LOG2}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
@@ -163,10 +161,9 @@ log "Waiting for detection (threshold: ${threshold}s)"
 if wait_for_starvation_detected "${STALLD_LOG3}"; then
     pass "Starvation detected with ${threshold}s threshold"
 else
-    log "✗ FAIL: Starvation not detected with ${threshold}s threshold"
+    fail "Starvation not detected with ${threshold}s threshold"
     log "Log contents:"
     cat "${STALLD_LOG3}"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Cleanup
@@ -193,8 +190,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Zero threshold rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid threshold value 0"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid threshold value 0"
 fi
 
 # Test with negative threshold
@@ -208,8 +204,7 @@ ret=$?
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "Negative threshold rejected with error"
 else
-    log "✗ FAIL: stalld did not reject invalid negative threshold"
-    TEST_FAILED=$((TEST_FAILED + 1))
+    fail "stalld did not reject invalid negative threshold"
 fi
 
 log ""
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index b89230e..e1a4cc1 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -106,9 +106,8 @@ if [ "${second_duration}" -gt "${first_duration}" ]; then
     pass "Starvation duration increased by ${delta}s"
     log "        Timestamp preserved across monitoring cycles"
 else
-    log "✗ FAIL: Duration did not increase (${first_duration}s -> ${second_duration}s)"
+    fail "Duration did not increase (${first_duration}s -> ${second_duration}s)"
     log "        Timestamp may have been reset (task merging failed)"
-    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Wait for third detection to confirm continued accumulation
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 144114c..20f8a3c 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -114,6 +114,15 @@ pass() {
 	TEST_PASSED=$((TEST_PASSED + 1))
 }
 
+# Record a test failure with a description message.
+#
+# Usage: fail "description"
+fail() {
+	local message=${1:-""}
+	log "✗ FAIL: ${message}"
+	TEST_FAILED=$((TEST_FAILED + 1))
+}
+
 # Assert functions
 assert_equals() {
 	local expected=$1
@@ -1130,7 +1139,7 @@ start_starvation_gen() {
 
 # Export functions for use in tests
 export -f start_test end_test
-export -f pass assert_equals assert_contains assert_not_contains
+export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
 export -f start_stalld stop_stalld kill_existing_stalld cleanup
-- 
2.53.0

