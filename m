Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1539C000
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899981; cv=none; b=ZsumrslOcVfxa4CB6DQkGVfm+JwQwWPQU30wg73KiI8Y3Z8o1t3JytzB3sTFrAxo0Ac40YMBrb2xo+rJV6NBSNwDg5wUlwMdf2PTGWzxwpJ9T3e0eheKXxKY0/op+ta/f5wPJJOzmOwQzqV5rpTDOBqpTDW1TO6gjyfQiX2cfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899981; c=relaxed/simple;
	bh=DUa9WYMFTLcKERvWv2qTJQENSky0ikxqOMSCOscUF9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxZcx7Fq3k25hsGJ7+c9ZWf4tbfDhu7iTFFwGFsk5H0EtBSaxCKyQt6xtMTcSOI/z6ik0uBvSOCp8EBXTZMoJwv4Fq0AoXJPrFo+XS5dnkU9+MZ9bWJZF/S4Bgswt4TwvF2k3p9ZSY1vHucSrahf4c3Z+orsieBB52TCxoODXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyWFz1R5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyWFz1R5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nFYjhf1NqW8x7khSp137RkWt2x6IsUeUtHuWhXH6vk=;
	b=OyWFz1R5g6QoQqspzq9GQd7Db4Ka47BvQTrBcLoMUSOxtWia53wVHGt6Vc1zrRKSthn9wB
	Q9Hf9G6/F50PAgIrLGJOiZP4hzALalLZlbEnTQYVUwHKJAh+ZJjfRkacrGfq63fukZhg2Q
	YCuIhTWX8ZilzLc12VCUVw2EpQmmKpY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-dLrRRasRPUeg67n0m_24dA-1; Mon,
 30 Mar 2026 15:46:12 -0400
X-MC-Unique: dLrRRasRPUeg67n0m_24dA-1
X-Mimecast-MFC-AGG-ID: dLrRRasRPUeg67n0m_24dA_1774899971
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B887F19560B4;
	Mon, 30 Mar 2026 19:46:11 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9866D19540C4;
	Mon, 30 Mar 2026 19:46:07 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 29/36] tests/functional: Use pass() for all test pass reporting
Date: Mon, 30 Mar 2026 16:43:52 -0300
Message-ID: <20260330194410.103953-30-wander@redhat.com>
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

Replace inline log statements that manually format pass messages
with calls to the pass() helper introduced in the previous commit.
This ensures all pass results are consistently logged with the
journal and counted by the test framework.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_affinity.sh             | 14 ++++----
 tests/functional/test_boost_duration.sh       |  8 ++---
 tests/functional/test_boost_period.sh         |  8 ++---
 tests/functional/test_boost_restoration.sh    | 24 ++++++-------
 tests/functional/test_boost_runtime.sh        |  8 ++---
 tests/functional/test_deadline_boosting.sh    | 24 ++++++-------
 tests/functional/test_fifo_boosting.sh        | 14 ++++----
 .../test_fifo_priority_starvation.sh          | 18 +++++-----
 tests/functional/test_force_fifo.sh           |  8 ++---
 tests/functional/test_idle_detection.sh       | 12 +++----
 tests/functional/test_pidfile.sh              | 18 +++++-----
 tests/functional/test_runqueue_parsing.sh     | 36 +++++++++----------
 tests/functional/test_starvation_detection.sh | 22 ++++++------
 tests/functional/test_starvation_threshold.sh |  6 ++--
 tests/functional/test_task_merging.sh         | 16 ++++-----
 15 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index 738822e..b74886d 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -83,7 +83,7 @@ log "ℹ INFO: Default affinity: $default_affinity"
 
 # Typically should be all CPUs
 if [ -n "$default_affinity" ]; then
-    log "✓ PASS: stalld has default affinity: $default_affinity"
+    pass "stalld has default affinity: $default_affinity"
 else
     log "⚠ WARNING: Could not determine default affinity"
 fi
@@ -107,7 +107,7 @@ sleep 2
 affinity=$(check_affinity "${STALLD_PID}")
 
 if [ "$affinity" = "0" ]; then
-    log "✓ PASS: stalld restricted to CPU 0"
+    pass "stalld restricted to CPU 0"
 else
     log "✗ FAIL: stalld affinity ($affinity) doesn't match requested (0)"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -134,7 +134,7 @@ if [ "$num_cpus" -ge 4 ]; then
 
     # Accept either "0,2" or "0-2" or "2,0" (different systems may report differently)
     if echo "$affinity" | grep -qE '^0,2$|^0-2$|^2,0$'; then
-        log "✓ PASS: stalld restricted to CPUs 0,2 (affinity: $affinity)"
+        pass "stalld restricted to CPUs 0,2 (affinity: $affinity)"
     else
         log "⚠ WARNING: stalld affinity ($affinity) may not match requested (0,2) - format may vary"
         # Not failing as different systems may report differently
@@ -164,7 +164,7 @@ if [ "$num_cpus" -ge 4 ]; then
 
     # Accept various formats: "0-2", "0,1,2", etc.
     if echo "$affinity" | grep -qE '0.*1.*2|0-2'; then
-        log "✓ PASS: stalld restricted to CPU range 0-2 (affinity: $affinity)"
+        pass "stalld restricted to CPU range 0-2 (affinity: $affinity)"
     else
         log "⚠ WARNING: stalld affinity ($affinity) may not match requested (0-2) - format may vary"
     fi
@@ -200,7 +200,7 @@ if [ "$num_cpus" -ge 2 ]; then
     fi
 
     if [ "$affinity" = "$test_cpu" ]; then
-        log "✓ PASS: stalld process affinity set to CPU $test_cpu"
+        pass "stalld process affinity set to CPU $test_cpu"
     else
         log "⚠ WARNING: stalld affinity ($affinity) doesn't exactly match CPU $test_cpu"
     fi
@@ -229,7 +229,7 @@ if [ "$num_cpus" -ge 2 ]; then
     affinity=$(check_affinity "${STALLD_PID}")
 
     if [ "$affinity" = "0" ]; then
-        log "✓ PASS: stalld affinity to CPU 0 while monitoring CPU 1"
+        pass "stalld affinity to CPU 0 while monitoring CPU 1"
     else
         log "⚠ WARNING: stalld affinity ($affinity) doesn't match requested (0)"
     fi
@@ -298,7 +298,7 @@ affinity_end=$(check_affinity "${STALLD_PID}")
 log "ℹ INFO: Affinity after 3s: $affinity_end"
 
 if [ "$affinity_start" = "$affinity_end" ]; then
-    log "✓ PASS: CPU affinity persisted over time"
+    pass "CPU affinity persisted over time"
 else
     log "⚠ WARNING: CPU affinity changed (start: $affinity_start, end: $affinity_end)"
 fi
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index 104f298..61218e9 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -67,7 +67,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection
 if wait_for_starvation_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Starvation detection occurred with default duration"
+    pass "Starvation detection occurred with default duration"
 else
     log "✗ FAIL: No starvation detection"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -99,7 +99,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection
 if wait_for_starvation_detected "${STALLD_LOG2}"; then
-    log "✓ PASS: Starvation detection with ${short_duration}s duration"
+    pass "Starvation detection with ${short_duration}s duration"
 else
     log "✗ FAIL: No starvation detection with short duration"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -133,7 +133,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 
 # Wait for starvation detection
 if wait_for_starvation_detected "${STALLD_LOG3}"; then
-    log "✓ PASS: Starvation detection with ${long_duration}s duration"
+    pass "Starvation detection with ${long_duration}s duration"
 else
     log "✗ FAIL: No starvation detection with long duration"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -166,7 +166,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
 
 # Wait for starvation detection
 if wait_for_starvation_detected "${STALLD_LOG4}"; then
-    log "✓ PASS: Starvation detection with ${duration}s boost duration"
+    pass "Starvation detection with ${duration}s boost duration"
 else
     log "✗ FAIL: No starvation detection"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index b516350..671f7cb 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -64,7 +64,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection and boosting
 if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Boosting occurred with default period"
+    pass "Boosting occurred with default period"
 
     # Try to find period value in logs
     if grep -qi "period" "${STALLD_LOG}"; then
@@ -101,7 +101,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection and boosting
 if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Boosting occurred with custom period ${custom_period} ns"
+    pass "Boosting occurred with custom period ${custom_period} ns"
 else
     log "✗ FAIL: No boosting with custom period"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -131,7 +131,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection and boosting
 if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Boosting occurred with short period ${short_period} ns"
+    pass "Boosting occurred with short period ${short_period} ns"
 else
     log "✗ FAIL: No boosting with short period"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -161,7 +161,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection and boosting
 if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Boosting occurred with long period ${long_period} ns"
+    pass "Boosting occurred with long period ${long_period} ns"
 else
     log "✗ FAIL: No boosting with long period"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index fc5a25a..024d869 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -85,7 +85,7 @@ if [ -n "${tracked_pid}" ]; then
     log "Initial policy: ${initial_policy} (expected: 1=SCHED_FIFO), prio: ${initial_prio}"
 
     if [ "$initial_policy" = "1" ]; then
-        log "✓ PASS: Initial policy is SCHED_FIFO"
+        pass "Initial policy is SCHED_FIFO"
     else
         log "⚠ WARNING: Initial policy is ${initial_policy}, not SCHED_FIFO (1)"
     fi
@@ -100,7 +100,7 @@ if [ -n "${tracked_pid}" ]; then
         log "Policy during boost: ${boosted_policy}"
 
         if [ "$boosted_policy" = "6" ]; then
-            log "✓ PASS: Task boosted to SCHED_DEADLINE (6)"
+            pass "Task boosted to SCHED_DEADLINE (6)"
         else
             log "ℹ INFO: Policy is ${boosted_policy} (may be between boost cycles)"
         fi
@@ -117,7 +117,7 @@ if [ -n "${tracked_pid}" ]; then
         log "Policy after boost: ${post_boost_policy}, prio: ${post_boost_prio}"
 
         if [ "$post_boost_policy" = "1" ]; then
-            log "✓ PASS: Policy restored to SCHED_FIFO (1) during boost cycle"
+            pass "Policy restored to SCHED_FIFO (1) during boost cycle"
         elif [ "$post_boost_policy" = "6" ]; then
             log "ℹ INFO: Still in boost (DEADLINE), will check final restoration"
         else
@@ -139,9 +139,9 @@ if [ -n "${tracked_pid}" ] && [ -f "/proc/${tracked_pid}/sched" ]; then
     log "Final policy: ${final_policy}, prio: ${final_prio}"
 
     if [ "$final_policy" = "1" ]; then
-        log "✓ PASS: Policy restored to SCHED_FIFO (1)"
+        pass "Policy restored to SCHED_FIFO (1)"
         if [ "$final_prio" = "$initial_prio" ]; then
-            log "✓ PASS: Priority restored to ${initial_prio}"
+            pass "Priority restored to ${initial_prio}"
         else
             log "⚠ INFO: Priority is ${final_prio} (initial was ${initial_prio})"
         fi
@@ -219,7 +219,7 @@ if chrt -f -p 10 ${FIFO_TASK_PID} 2>/dev/null; then
     log "Initial: policy=${initial_policy} (1=FIFO), prio=${initial_prio}"
 
     if [ "$initial_policy" = "1" ]; then
-        log "✓ PASS: Initial policy is SCHED_FIFO (1)"
+        pass "Initial policy is SCHED_FIFO (1)"
     else
         log "⚠ WARNING: Could not set FIFO policy (got ${initial_policy})"
     fi
@@ -234,7 +234,7 @@ if chrt -f -p 10 ${FIFO_TASK_PID} 2>/dev/null; then
         log "Policy during detection window: ${boosted_policy}"
 
         if [ "$boosted_policy" = "6" ]; then
-            log "✓ PASS: Task boosted to SCHED_DEADLINE (6)"
+            pass "Task boosted to SCHED_DEADLINE (6)"
         elif [ "$boosted_policy" = "1" ]; then
             log "ℹ INFO: Still SCHED_FIFO (may not have starved yet)"
         fi
@@ -251,7 +251,7 @@ if chrt -f -p 10 ${FIFO_TASK_PID} 2>/dev/null; then
         log "Final: policy=${final_policy}, prio=${final_prio}"
 
         if [ "$final_policy" = "1" ]; then
-            log "✓ PASS: Policy restored to SCHED_FIFO (1)"
+            pass "Policy restored to SCHED_FIFO (1)"
             log "ℹ INFO: Priority after restoration: ${final_prio}"
         else
             log "⚠ INFO: Final policy is ${final_policy}"
@@ -340,7 +340,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     log "Time difference: ${time_diff}s"
 
     if [ ${time_diff} -le 2 ]; then
-        log "✓ PASS: Restoration timing within acceptable margin (±2s)"
+        pass "Restoration timing within acceptable margin (±2s)"
     else
         log "ℹ INFO: Restoration timing difference: ${time_diff}s"
         log "        (may be acceptable depending on system load)"
@@ -380,7 +380,7 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d ${short_duration}
 
 # Wait for starvation detection and boosting
 if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Boost occurred"
+    pass "Boost occurred"
 
     # At this point (12s), starvation_gen has exited (at 8s) during the boost
     # stalld should still be running despite the task exiting during boost
@@ -389,7 +389,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
 
     # Verify stalld is still running and didn't crash after task exit
     if assert_process_running "${STALLD_PID}" "stalld still running after task exit"; then
-        log "✓ PASS: stalld handled task exit during boost gracefully"
+        pass "stalld handled task exit during boost gracefully"
     else
         log "✗ FAIL: stalld crashed or exited after task died during boost"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -401,7 +401,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
         grep -iE "error.*restor|fail.*restor" "${STALLD_LOG}"
         log "        These errors are normal when tasks exit during boost"
     else
-        log "✓ PASS: No restoration errors (clean handling)"
+        pass "No restoration errors (clean handling)"
     fi
 else
     log "⚠ WARNING: No boost detected in this test run"
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index d516604..b624fc9 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -67,7 +67,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 if wait_for_starvation_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Starvation detection with default runtime"
+    pass "Starvation detection with default runtime"
 else
     log "✗ FAIL: No starvation detection"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -99,7 +99,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 if wait_for_starvation_detected "${STALLD_LOG2}"; then
-    log "✓ PASS: Starvation detection with custom runtime ${custom_runtime}ns"
+    pass "Starvation detection with custom runtime ${custom_runtime}ns"
 else
     log "✗ FAIL: No starvation detection with custom runtime"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -131,7 +131,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 if wait_for_starvation_detected "${STALLD_LOG3}"; then
-    log "✓ PASS: Starvation detection with large runtime ${large_runtime}ns"
+    pass "Starvation detection with large runtime ${large_runtime}ns"
 else
     log "✗ FAIL: No starvation detection with large runtime"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -165,7 +165,7 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 if wait_for_starvation_detected "${STALLD_LOG4}"; then
-    log "✓ PASS: Starvation detection with runtime < period"
+    pass "Starvation detection with runtime < period"
 else
     log "✗ FAIL: No starvation detection when runtime < period"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index a5727da..86ca0f1 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -68,11 +68,11 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 # Wait for boosting
 log "Waiting for boost detection..."
 if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Boosting occurred"
+    pass "Boosting occurred"
 
     # Verify SCHED_DEADLINE was used
     if grep -q "SCHED_DEADLINE" "${STALLD_LOG}"; then
-        log "✓ PASS: SCHED_DEADLINE boosting used (default)"
+        pass "SCHED_DEADLINE boosting used (default)"
     else
         log "✗ FAIL: SCHED_DEADLINE not mentioned in boost message"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -81,7 +81,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     # Verify boost happened after threshold
     # (starvation logged, then boosting)
     if grep -q "starved" "${STALLD_LOG}"; then
-        log "✓ PASS: Starvation detected before boosting"
+        pass "Starvation detected before boosting"
     else
         log "⚠ WARNING: No starvation message before boost"
     fi
@@ -140,7 +140,7 @@ for child_pid in ${STARVE_CHILDREN}; do
 
         # Policy 6 = SCHED_DEADLINE
         if [ "$policy" = "6" ]; then
-            log "✓ PASS: Task PID ${child_pid} boosted to SCHED_DEADLINE (policy 6)"
+            pass "Task PID ${child_pid} boosted to SCHED_DEADLINE (policy 6)"
             boosted_task_found=1
             break
         fi
@@ -151,7 +151,7 @@ if [ ${boosted_task_found} -eq 0 ]; then
     log "⚠ INFO: Could not verify DEADLINE policy in /proc (timing issue or boost already expired)"
     # Still check if boost happened in logs
     if grep -q "boosted.*SCHED_DEADLINE" "${STALLD_LOG}"; then
-        log "✓ PASS: SCHED_DEADLINE boost confirmed in logs"
+        pass "SCHED_DEADLINE boost confirmed in logs"
     else
         log "✗ FAIL: No SCHED_DEADLINE boost detected"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -213,7 +213,7 @@ if [ -n "${tracked_pid}" ]; then
     # Verify task made progress (context switches increased)
     ctxt_delta=$((ctxt_after - ctxt_before))
     if [ ${ctxt_delta} -gt 5 ]; then
-        log "✓ PASS: Task made progress during boost (${ctxt_delta} context switches)"
+        pass "Task made progress during boost (${ctxt_delta} context switches)"
     else
         log "⚠ INFO: Limited progress detected (${ctxt_delta} context switches)"
         log "        This may be acceptable depending on boost parameters"
@@ -224,7 +224,7 @@ fi
 
 # Verify boost happened
 if grep -q "boosted" "${STALLD_LOG}"; then
-    log "✓ PASS: Boost occurred as expected"
+    pass "Boost occurred as expected"
 else
     log "✗ FAIL: No boost detected"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -284,7 +284,7 @@ if [ -n "${tracked_pid}" ]; then
     log "Policy during boost window: ${boosted_policy} (6=SCHED_DEADLINE)"
 
     if [ "$boosted_policy" = "6" ]; then
-        log "✓ PASS: Policy changed to SCHED_DEADLINE during boost"
+        pass "Policy changed to SCHED_DEADLINE during boost"
     else
         log "⚠ INFO: Policy is ${boosted_policy} (may have already restored or not yet boosted)"
     fi
@@ -299,7 +299,7 @@ if [ -n "${tracked_pid}" ]; then
         log "Policy after boost: ${restored_policy}"
 
         if [ "$restored_policy" = "0" ]; then
-            log "✓ PASS: Policy restored to SCHED_OTHER (0)"
+            pass "Policy restored to SCHED_OTHER (0)"
         else
             log "⚠ INFO: Policy is ${restored_policy} after boost"
             log "        (task may have exited or restoration timing differs)"
@@ -360,18 +360,18 @@ else
     log "Number of boost events: ${boost_count}"
 
     if [ ${boost_count} -ge 2 ]; then
-        log "✓ PASS: Multiple boost events detected (${boost_count})"
+        pass "Multiple boost events detected (${boost_count})"
 
         # Verify both CPUs mentioned
         if grep -q "CPU ${CPU0}" "${STALLD_LOG}" && grep -q "CPU ${CPU1}" "${STALLD_LOG}"; then
-            log "✓ PASS: Boosts occurred on both CPUs"
+            pass "Boosts occurred on both CPUs"
         else
             log "⚠ INFO: Could not verify boosts on both specific CPUs"
         fi
 
         # Verify independent boost cycles
         if [ ${boost_count} -gt 2 ]; then
-            log "✓ PASS: Multiple boost cycles (${boost_count} total), showing independent operation"
+            pass "Multiple boost cycles (${boost_count} total), showing independent operation"
         fi
     else
         log "⚠ INFO: Only ${boost_count} boost event(s) detected"
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 1da1c09..df26483 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -66,11 +66,11 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -N -F -A -t $threshold -c ${TES
 # Wait for boosting
 log "Waiting for boost detection..."
 if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Boosting occurred with -F flag"
+    pass "Boosting occurred with -F flag"
 
     # Verify SCHED_FIFO was used
     if grep -q "SCHED_FIFO" "${STALLD_LOG}"; then
-        log "✓ PASS: SCHED_FIFO boosting used (as requested by -F)"
+        pass "SCHED_FIFO boosting used (as requested by -F)"
     else
         log "✗ FAIL: SCHED_FIFO not mentioned in boost message"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -120,7 +120,7 @@ for child_pid in ${STARVE_CHILDREN}; do
         # Policy 1 = SCHED_FIFO
         if [ "$policy" = "1" ]; then
             priority=$(get_sched_priority ${child_pid})
-            log "✓ PASS: Task PID ${child_pid} boosted to SCHED_FIFO (policy 1)"
+            pass "Task PID ${child_pid} boosted to SCHED_FIFO (policy 1)"
             log "        Priority: ${priority}"
             fifo_task_found=1
             break
@@ -132,7 +132,7 @@ if [ ${fifo_task_found} -eq 0 ]; then
     log "⚠ INFO: Could not verify FIFO policy in /proc (timing issue or boost already expired)"
     # FIFO emulation cycles between FIFO and OTHER, so we may catch it in OTHER state
     if grep -q "boosted.*SCHED_FIFO" "${STALLD_LOG}"; then
-        log "✓ PASS: SCHED_FIFO boost confirmed in logs"
+        pass "SCHED_FIFO boost confirmed in logs"
     else
         log "✗ FAIL: No SCHED_FIFO boost detected"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -186,7 +186,7 @@ boost_count=$(grep -c "boosted.*SCHED_FIFO" "${STALLD_LOG}")
 log "Number of FIFO boost events: ${boost_count}"
 
 if [ ${boost_count} -gt 1 ]; then
-    log "✓ PASS: Multiple FIFO boost events (${boost_count}) - emulation cycling detected"
+    pass "Multiple FIFO boost events (${boost_count}) - emulation cycling detected"
     log "        (FIFO emulation boosts, sleeps, restores, repeats)"
 else
     log "⚠ INFO: Only ${boost_count} FIFO boost event(s)"
@@ -303,7 +303,7 @@ log "  DEADLINE: ${deadline_progress} context switches"
 log "  FIFO: ${fifo_progress} context switches"
 
 if [ ${deadline_progress} -gt 0 ] && [ ${fifo_progress} -gt 0 ]; then
-    log "✓ PASS: Both DEADLINE and FIFO allowed tasks to make progress"
+    pass "Both DEADLINE and FIFO allowed tasks to make progress"
 
     # Both should be effective, but exact numbers may vary
     if [ ${deadline_progress} -gt ${fifo_progress} ]; then
@@ -343,7 +343,7 @@ fi
 
 # Check for error message in log
 if grep -qiE "single.*thread.*fifo|fifo.*single.*thread|can.*only.*deadline" "${STALLD_LOG_FAIL}"; then
-    log "✓ PASS: Error message about FIFO+single-threaded incompatibility found"
+    pass "Error message about FIFO+single-threaded incompatibility found"
 else
     log "ℹ INFO: Checking exit status or error messages..."
     if [ -s "${STALLD_LOG_FAIL}" ]; then
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 886357e..3776e6b 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -72,11 +72,11 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a $
 # Wait for starvation detection
 log "Waiting for starvation detection..."
 if wait_for_starvation_detected "${STALLD_LOG}"; then
-    log "✓ PASS: FIFO-on-FIFO starvation detected"
+    pass "FIFO-on-FIFO starvation detected"
 
     # Verify correct CPU is logged
     if grep "starved on CPU ${TEST_CPU}" "${STALLD_LOG}"; then
-        log "✓ PASS: Correct CPU ID logged (CPU ${TEST_CPU})"
+        pass "Correct CPU ID logged (CPU ${TEST_CPU})"
     else
         log "✗ FAIL: Wrong CPU ID in log"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -84,7 +84,7 @@ if wait_for_starvation_detected "${STALLD_LOG}"; then
 
     # Verify duration is logged
     if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}"; then
-        log "✓ PASS: Starvation duration logged"
+        pass "Starvation duration logged"
     else
         log "✗ FAIL: Starvation duration not logged"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -152,7 +152,7 @@ ctxt_delta=$((ctxt_after - ctxt_before))
 log "Context switch delta: ${ctxt_delta}"
 
 if [ ${ctxt_delta} -gt 0 ]; then
-    log "✓ PASS: Blockee task made progress (${ctxt_delta} context switches)"
+    pass "Blockee task made progress (${ctxt_delta} context switches)"
 else
     log "⚠ WARNING: Could not verify progress (timing issue or blockee not found)"
     # Check if boosting occurred at least
@@ -204,7 +204,7 @@ log "Third detection cycle should have occurred"
 # Check if we see accumulating starvation time in logs
 # Task merging means the timestamp is preserved, so duration increases
 if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}" | wc -l | grep -q "[2-9]"; then
-    log "✓ PASS: Multiple starvation reports found"
+    pass "Multiple starvation reports found"
 
     # Extract starvation durations from log
     durations=$(grep -oE "starved on CPU ${TEST_CPU} for [0-9]+" "${STALLD_LOG}" | grep -oE "[0-9]+$")
@@ -215,7 +215,7 @@ if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}" | wc
     last_duration=$(echo "$durations" | tail -1)
 
     if [ ${last_duration} -gt ${first_duration} ]; then
-        log "✓ PASS: Starvation duration increased (${first_duration}s -> ${last_duration}s)"
+        pass "Starvation duration increased (${first_duration}s -> ${last_duration}s)"
         log "        This confirms task merging preserved the timestamp"
     else
         log "✗ FAIL: Starvation duration did not increase (timestamp may have been reset)"
@@ -258,7 +258,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a $
 # Wait for starvation detection
 log "Waiting for starvation detection..."
 if wait_for_starvation_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Starvation detected even with close priority gap (6 vs 5)"
+    pass "Starvation detected even with close priority gap (6 vs 5)"
 else
     log "⚠ WARNING: Starvation not detected with close priority gap"
     log "        (May be due to queue_track backend limitation)"
@@ -297,12 +297,12 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -N -t $threshold -c ${TEST_CPU} -a $
 # Wait for boosting
 log "Waiting for boost detection..."
 if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Boosting occurred"
+    pass "Boosting occurred"
 
     # Try to verify the correct task was boosted
     # stalld logs should show the blockee task name (starvation_gen thread)
     if grep "boosted.*starvation_gen" "${STALLD_LOG}"; then
-        log "✓ PASS: starvation_gen task was boosted (likely the blockee)"
+        pass "starvation_gen task was boosted (likely the blockee)"
     else
         log "ℹ INFO: Could not verify specific task from logs"
     fi
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index f8f7b4c..fec2e00 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -64,7 +64,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
 
     # Look for SCHED_DEADLINE indicators
     if grep -qi "deadline\|SCHED_DEADLINE" "${STALLD_LOG}"; then
-        log "✓ PASS: SCHED_DEADLINE used by default"
+        pass "SCHED_DEADLINE used by default"
     elif grep -qi "fifo\|SCHED_FIFO" "${STALLD_LOG}"; then
         log "⚠ WARNING: SCHED_FIFO used instead of SCHED_DEADLINE"
     else
@@ -105,7 +105,7 @@ if wait_for_boost_detected "${STALLD_LOG2}"; then
 
     # Look for SCHED_FIFO indicators
     if grep -qi "fifo\|SCHED_FIFO" "${STALLD_LOG2}"; then
-        log "✓ PASS: SCHED_FIFO used with -F flag"
+        pass "SCHED_FIFO used with -F flag"
     elif grep -qi "deadline\|SCHED_DEADLINE" "${STALLD_LOG2}"; then
         log "✗ FAIL: SCHED_DEADLINE used despite -F flag"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -148,7 +148,7 @@ if grep -qi "priority\|prio" "${STALLD_LOG3}"; then
 fi
 
 if grep -q "boost" "${STALLD_LOG3}"; then
-    log "✓ PASS: FIFO boosting with priority setting completed"
+    pass "FIFO boosting with priority setting completed"
 else
     log "⚠ WARNING: No boosting detected"
 fi
@@ -187,7 +187,7 @@ if wait_for_boost_detected "${STALLD_LOG4}"; then
 
     # Check for restoration messages (part of FIFO emulation)
     if grep -qi "restor\|unboosted\|normal\|original" "${STALLD_LOG4}"; then
-        log "✓ PASS: FIFO emulation with restoration detected"
+        pass "FIFO emulation with restoration detected"
     else
         log "ℹ INFO: FIFO boosting completed (restoration may be implicit)"
     fi
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index ef1c572..af4d7a4 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -100,7 +100,7 @@ fi
 
 # Verify CPU is actually idle
 if is_cpu_idle ${TEST_CPU}; then
-    log "✓ PASS: CPU ${TEST_CPU} is currently idle (idle time increasing)"
+    pass "CPU ${TEST_CPU} is currently idle (idle time increasing)"
 else
     log "⚠ INFO: CPU ${TEST_CPU} appears busy (background activity)"
 fi
@@ -130,10 +130,10 @@ if [ -n "${idle_time1}" ] && [ -n "${idle_time2}" ]; then
     log "Idle time delta: ${delta}"
 
     if [ ${delta} -gt 0 ]; then
-        log "✓ PASS: Idle time increased (CPU is idle)"
+        pass "Idle time increased (CPU is idle)"
         log "        stalld would skip this CPU"
     else
-        log "✓ PASS: Idle time unchanged (CPU is busy)"
+        pass "Idle time unchanged (CPU is busy)"
         log "        stalld would parse this CPU"
     fi
 else
@@ -167,7 +167,7 @@ log "Waiting for stalld to detect busy CPU and starvation..."
 
 # Verify stalld detected starvation (meaning it resumed monitoring)
 if wait_for_starvation_detected "${STALLD_LOG}"; then
-    log "✓ PASS: stalld detected starvation on now-busy CPU"
+    pass "stalld detected starvation on now-busy CPU"
     log "        Monitoring resumed when CPU became busy"
 else
     log "⚠ INFO: No starvation detected"
@@ -241,9 +241,9 @@ else
     log "CPU ${CPU1} detections: ${cpu1_detections} (should be >0, it's busy)"
 
     if [ ${cpu0_detections} -eq 0 ] && [ ${cpu1_detections} -gt 0 ]; then
-        log "✓ PASS: Idle CPU skipped, busy CPU monitored"
+        pass "Idle CPU skipped, busy CPU monitored"
     elif [ ${cpu1_detections} -gt 0 ]; then
-        log "✓ PASS: Busy CPU ${CPU1} monitored"
+        pass "Busy CPU ${CPU1} monitored"
         if [ ${cpu0_detections} -gt 0 ]; then
             log "⚠ INFO: CPU ${CPU0} also had detections (may have background activity)"
         fi
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index fbdc9fe..fd4fedc 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -54,7 +54,7 @@ for pidfile in /var/run/stalld.pid /run/stalld.pid; do
         # Verify PID matches
         pid_from_file=$(cat "$pidfile")
         if [ "$pid_from_file" = "${STALLD_PID}" ]; then
-            log "✓ PASS: Default pidfile contains correct PID"
+            pass "Default pidfile contains correct PID"
         else
             log "✗ FAIL: Default pidfile PID ($pid_from_file) doesn't match stalld PID (${STALLD_PID})"
             TEST_FAILED=$((TEST_FAILED + 1))
@@ -92,12 +92,12 @@ sleep 2
 
 # Verify pidfile was created
 if [ -f "${custom_pidfile}" ]; then
-    log "✓ PASS: Custom pidfile created at ${custom_pidfile}"
+    pass "Custom pidfile created at ${custom_pidfile}"
 
     # Verify content
     pid_from_file=$(cat "${custom_pidfile}")
     if [ "$pid_from_file" = "${STALLD_PID}" ]; then
-        log "✓ PASS: Custom pidfile contains correct PID ($pid_from_file)"
+        pass "Custom pidfile contains correct PID ($pid_from_file)"
     else
         log "✗ FAIL: Custom pidfile PID ($pid_from_file) doesn't match stalld PID (${STALLD_PID})"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -113,7 +113,7 @@ log "Test 3: Verify pidfile removed on clean shutdown"
 stop_stalld
 
 if [ ! -f "${custom_pidfile}" ]; then
-    log "✓ PASS: Pidfile removed on clean shutdown"
+    pass "Pidfile removed on clean shutdown"
 else
     log "⚠ WARNING: Pidfile still exists after shutdown (may be expected)"
     # Not failing - some implementations keep pidfile
@@ -139,11 +139,11 @@ start_stalld -l -t 5 --pidfile "${tmp_pidfile}"
 sleep 2
 
 if [ -f "${tmp_pidfile}" ]; then
-    log "✓ PASS: Pidfile created in /tmp directory"
+    pass "Pidfile created in /tmp directory"
 
     pid_from_file=$(cat "${tmp_pidfile}")
     if [ "$pid_from_file" = "${STALLD_PID}" ]; then
-        log "✓ PASS: /tmp pidfile contains correct PID"
+        pass "/tmp pidfile contains correct PID"
     else
         log "✗ FAIL: /tmp pidfile has incorrect PID"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -175,11 +175,11 @@ start_stalld -f -v -l -t 5 --pidfile "${fg_pidfile}"
 sleep 2
 
 if [ -f "${fg_pidfile}" ]; then
-    log "✓ PASS: Pidfile created in foreground mode"
+    pass "Pidfile created in foreground mode"
 
     pid_from_file=$(cat "${fg_pidfile}")
     if [ "$pid_from_file" = "${STALLD_PID}" ]; then
-        log "✓ PASS: Foreground mode pidfile contains correct PID"
+        pass "Foreground mode pidfile contains correct PID"
     else
         log "✗ FAIL: Foreground mode pidfile has incorrect PID"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -250,7 +250,7 @@ sleep 2
 if [ -f "${readable_pidfile}" ]; then
     # Try to read the pidfile as a regular user would
     if cat "${readable_pidfile}" > /dev/null 2>&1; then
-        log "✓ PASS: Pidfile is readable"
+        pass "Pidfile is readable"
 
         # Check permissions
         perms=$(stat -c "%a" "${readable_pidfile}" 2>/dev/null || stat -f "%Lp" "${readable_pidfile}" 2>/dev/null)
diff --git a/tests/functional/test_runqueue_parsing.sh b/tests/functional/test_runqueue_parsing.sh
index ccb1982..fc69fa0 100755
--- a/tests/functional/test_runqueue_parsing.sh
+++ b/tests/functional/test_runqueue_parsing.sh
@@ -102,11 +102,11 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
 
     # Wait for starvation detection
     if wait_for_starvation_detected "${STALLD_LOG_BPF}"; then
-        log "✓ PASS: eBPF backend detected starving tasks"
+        pass "eBPF backend detected starving tasks"
 
         # Verify task info is present (PID, comm)
         if grep -E "starvation_gen.*starved on CPU ${TEST_CPU}" "${STALLD_LOG_BPF}"; then
-            log "✓ PASS: Task name (comm) correctly extracted"
+            pass "Task name (comm) correctly extracted"
         else
             log "✗ FAIL: Task name not found in eBPF backend output"
             TEST_FAILED=$((TEST_FAILED + 1))
@@ -114,7 +114,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
 
         # Verify PID is logged
         if grep -E "\[[0-9]+\].*starved on CPU" "${STALLD_LOG_BPF}"; then
-            log "✓ PASS: Task PID correctly extracted"
+            pass "Task PID correctly extracted"
         else
             log "⚠ INFO: PID format may have changed"
         fi
@@ -157,11 +157,11 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
 
     # Wait for starvation detection
     if wait_for_starvation_detected "${STALLD_LOG_SCHED}"; then
-        log "✓ PASS: sched_debug backend detected starving tasks"
+        pass "sched_debug backend detected starving tasks"
 
         # Verify task info is present
         if grep -E "starvation_gen.*starved on CPU ${TEST_CPU}" "${STALLD_LOG_SCHED}"; then
-            log "✓ PASS: Task name (comm) correctly extracted"
+            pass "Task name (comm) correctly extracted"
         else
             log "✗ FAIL: Task name not found in sched_debug backend output"
             TEST_FAILED=$((TEST_FAILED + 1))
@@ -169,7 +169,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
 
         # Verify PID is logged
         if grep -E "\[[0-9]+\].*starved on CPU" "${STALLD_LOG_SCHED}"; then
-            log "✓ PASS: Task PID correctly extracted"
+            pass "Task PID correctly extracted"
         else
             log "⚠ INFO: PID format may have changed"
         fi
@@ -249,14 +249,14 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     # Compare results
     log ""
     if [ ${bpf_detections} -gt 0 ] && [ ${sched_detections} -gt 0 ]; then
-        log "✓ PASS: Both backends detected starvation"
+        pass "Both backends detected starvation"
 
         # Check if detection counts are similar (within reasonable variance)
         diff=$((bpf_detections - sched_detections))
         diff=${diff#-}  # absolute value
 
         if [ ${diff} -le 2 ]; then
-            log "✓ PASS: Detection counts are consistent (eBPF: ${bpf_detections}, sched_debug: ${sched_detections})"
+            pass "Detection counts are consistent (eBPF: ${bpf_detections}, sched_debug: ${sched_detections})"
         else
             log "⚠ INFO: Detection counts differ (eBPF: ${bpf_detections}, sched_debug: ${sched_detections})"
             log "        This may be due to timing differences between backends"
@@ -313,7 +313,7 @@ if [ -n "$test_backend" ]; then
 
     # Check for task name (comm field)
     if grep -q "starvation_gen" "${log_file}"; then
-        log "✓ PASS: Task name (comm) field extracted"
+        pass "Task name (comm) field extracted"
     else
         log "✗ FAIL: Task name (comm) field not found"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -321,7 +321,7 @@ if [ -n "$test_backend" ]; then
 
     # Check for PID field (format: name-PID or [PID])
     if grep -qE "(starvation_gen-[0-9]+|\[[0-9]+\])" "${log_file}"; then
-        log "✓ PASS: PID field extracted"
+        pass "PID field extracted"
     else
         log "✗ FAIL: PID field not found"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -329,7 +329,7 @@ if [ -n "$test_backend" ]; then
 
     # Check for CPU ID
     if grep -q "CPU ${TEST_CPU}" "${log_file}"; then
-        log "✓ PASS: CPU ID field extracted"
+        pass "CPU ID field extracted"
     else
         log "✗ FAIL: CPU ID field not found"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -337,7 +337,7 @@ if [ -n "$test_backend" ]; then
 
     # Check for starvation duration
     if grep -qE "for [0-9]+ seconds" "${log_file}"; then
-        log "✓ PASS: Starvation duration calculated from context switches/time"
+        pass "Starvation duration calculated from context switches/time"
     else
         log "✗ FAIL: Starvation duration not found"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -371,21 +371,21 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     # Check for format detection messages
     if grep -q "detect_task_format" "${STALLD_LOG_SCHED}"; then
         detected_format=$(grep "detect_task_format" "${STALLD_LOG_SCHED}" | grep "detected" | tail -1)
-        log "✓ PASS: Kernel format auto-detection occurred"
+        pass "Kernel format auto-detection occurred"
         log "ℹ INFO: ${detected_format}"
 
         # Check if field offsets were detected
         if grep -q "found 'task' at word" "${STALLD_LOG_SCHED}"; then
-            log "✓ PASS: Task field offset detected"
+            pass "Task field offset detected"
         fi
         if grep -q "found 'PID' at word" "${STALLD_LOG_SCHED}"; then
-            log "✓ PASS: PID field offset detected"
+            pass "PID field offset detected"
         fi
         if grep -q "found 'switches' at word" "${STALLD_LOG_SCHED}"; then
-            log "✓ PASS: Switches field offset detected"
+            pass "Switches field offset detected"
         fi
         if grep -q "found 'prio' at word" "${STALLD_LOG_SCHED}"; then
-            log "✓ PASS: Priority field offset detected"
+            pass "Priority field offset detected"
         fi
     else
         log "⚠ INFO: Format detection messages not in log (may not be verbose enough)"
@@ -393,7 +393,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
 
     # Verify the backend still works despite format
     if grep -q "starved on CPU" "${STALLD_LOG_SCHED}"; then
-        log "✓ PASS: Backend successfully parsed tasks despite kernel format"
+        pass "Backend successfully parsed tasks despite kernel format"
     else
         log "⚠ INFO: No starvation detected in this test run"
     fi
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 3c6fd6e..6d4d7c5 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -75,11 +75,11 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -
 # Wait for starvation detection
 log "Waiting for starvation detection..."
 if wait_for_starvation_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Starvation detected"
+    pass "Starvation detected"
 
     # Verify correct CPU is logged
     if grep "starved on CPU ${TEST_CPU}" "${STALLD_LOG}"; then
-        log "✓ PASS: Correct CPU ID logged (CPU ${TEST_CPU})"
+        pass "Correct CPU ID logged (CPU ${TEST_CPU})"
     else
         log "✗ FAIL: Wrong CPU ID in log"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -87,7 +87,7 @@ if wait_for_starvation_detected "${STALLD_LOG}"; then
 
     # Verify duration is logged
     if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}"; then
-        log "✓ PASS: Starvation duration logged"
+        pass "Starvation duration logged"
     else
         log "✗ FAIL: Starvation duration not logged"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -145,7 +145,7 @@ if [ -n "${STARVE_CHILDREN}" ]; then
 
             ctxt_delta=$((ctxt_after - ctxt_before))
             if [ ${ctxt_delta} -lt 5 ]; then
-                log "✓ PASS: Context switch count remained low (delta: ${ctxt_delta})"
+                pass "Context switch count remained low (delta: ${ctxt_delta})"
             else
                 log "✗ FAIL: Context switches increased significantly (delta: ${ctxt_delta})"
                 TEST_FAILED=$((TEST_FAILED + 1))
@@ -199,7 +199,7 @@ stop_stalld
 # Task merging means the timestamp is preserved, so duration increases
 report_count=$(grep -cE "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}")
 if [ "${report_count}" -ge 2 ]; then
-    log "✓ PASS: Multiple starvation reports found (${report_count} reports)"
+    pass "Multiple starvation reports found (${report_count} reports)"
 
     # Extract starvation durations from log
     durations=$(grep -oE "starved on CPU ${TEST_CPU} for [0-9]+" "${STALLD_LOG}" | grep -oE "[0-9]+$")
@@ -210,7 +210,7 @@ if [ "${report_count}" -ge 2 ]; then
     last_duration=$(echo "$durations" | tail -1)
 
     if [ ${last_duration} -gt ${first_duration} ]; then
-        log "✓ PASS: Starvation duration increased (${first_duration}s -> ${last_duration}s)"
+        pass "Starvation duration increased (${first_duration}s -> ${last_duration}s)"
         log "        This confirms task merging preserved the timestamp"
     else
         log "✗ FAIL: Starvation duration did not increase (timestamp may have been reset)"
@@ -283,14 +283,14 @@ else
 
     # Check both CPUs detected - specifically look for starvation_gen tasks
     if grep -qE "starvation_gen.*starved on CPU ${CPU0}|starved on CPU ${CPU0}.*starvation_gen" "${STALLD_LOG}"; then
-        log "✓ PASS: Starvation detected on CPU ${CPU0}"
+        pass "Starvation detected on CPU ${CPU0}"
     else
         log "✗ FAIL: Starvation not detected on CPU ${CPU0}"
         TEST_FAILED=$((TEST_FAILED + 1))
     fi
 
     if grep -qE "starvation_gen.*starved on CPU ${CPU1}|starved on CPU ${CPU1}.*starvation_gen" "${STALLD_LOG}"; then
-        log "✓ PASS: Starvation detected on CPU ${CPU1}"
+        pass "Starvation detected on CPU ${CPU1}"
     else
         log "✗ FAIL: Starvation not detected on CPU ${CPU1}"
         TEST_FAILED=$((TEST_FAILED + 1))
@@ -330,7 +330,7 @@ log "Creating a busy task that should NOT be starved"
     # Verify this task was NOT reported as starved
     # Since it's making progress, stalld shouldn't detect it
     if ! grep "starved" "${STALLD_LOG}"; then
-        log "✓ PASS: No false positive - task making progress not reported as starved"
+        pass "No false positive - task making progress not reported as starved"
     else
         # Check if our specific task was reported
         log "Log shows starvation, checking if it's our progress-making task..."
@@ -370,7 +370,7 @@ sleep 5
 
 # Verify stalld is still running (didn't crash)
 if assert_process_running "${STALLD_PID}" "stalld still running after task exit"; then
-    log "✓ PASS: stalld handled task exit gracefully"
+    pass "stalld handled task exit gracefully"
 else
     log "✗ FAIL: stalld crashed or exited unexpectedly"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -383,7 +383,7 @@ if grep -iE "error|segfault|crash" "${STALLD_LOG}"; then
     grep -iE "error|segfault|crash" "${STALLD_LOG}"
     TEST_FAILED=$((TEST_FAILED + 1))
 else
-    log "✓ PASS: No error messages in log"
+    pass "No error messages in log"
 fi
 
 stop_stalld
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index b904867..a35f898 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -76,7 +76,7 @@ log "Waiting for detection (threshold: ${threshold}s)"
 
 # Check if starvation was detected - specifically look for starvation_gen tasks
 if wait_for_starvation_detected "${STALLD_LOG}"; then
-    log "✓ PASS: Starvation detected after ${threshold}s threshold"
+    pass "Starvation detected after ${threshold}s threshold"
 else
     log "✗ FAIL: Starvation not detected after ${threshold}s threshold"
     log "Log contents:"
@@ -121,7 +121,7 @@ sleep 2
 
 # Check that starvation_gen was NOT detected (duration less than threshold)
 if ! grep -qE "starvation_gen.*starved on CPU ${TEST_CPU}|starved on CPU ${TEST_CPU}.*starvation_gen" "${STALLD_LOG2}"; then
-    log "✓ PASS: No starvation detected for duration less than threshold"
+    pass "No starvation detected for duration less than threshold"
 else
     log "✗ FAIL: Starvation detected before threshold"
     log "Found starvation_gen task in logs:"
@@ -161,7 +161,7 @@ log "Waiting for detection (threshold: ${threshold}s)"
 
 # Check if starvation_gen was detected
 if wait_for_starvation_detected "${STALLD_LOG3}"; then
-    log "✓ PASS: Starvation detected with ${threshold}s threshold"
+    pass "Starvation detected with ${threshold}s threshold"
 else
     log "✗ FAIL: Starvation not detected with ${threshold}s threshold"
     log "Log contents:"
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 5cd6406..b89230e 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -103,7 +103,7 @@ log "Second detection: task starved for ${second_duration}s"
 # Verify timestamp was preserved (duration increased)
 if [ "${second_duration}" -gt "${first_duration}" ]; then
     delta=$((second_duration - first_duration))
-    log "✓ PASS: Starvation duration increased by ${delta}s"
+    pass "Starvation duration increased by ${delta}s"
     log "        Timestamp preserved across monitoring cycles"
 else
     log "✗ FAIL: Duration did not increase (${first_duration}s -> ${second_duration}s)"
@@ -122,7 +122,7 @@ fi
 log "Third detection: task starved for ${third_duration}s"
 
 if [ "${third_duration}" -gt "${second_duration}" ]; then
-    log "✓ PASS: Duration continues to accumulate (${third_duration}s total)"
+    pass "Duration continues to accumulate (${third_duration}s total)"
 else
     log "⚠ INFO: Duration did not increase in third cycle"
 fi
@@ -179,7 +179,7 @@ if [ -n "${tracked_pid}" ]; then
 
         delta=$((ctxsw_after - ctxsw_before))
         if [ ${delta} -lt 5 ]; then
-            log "✓ PASS: Context switches remained low (delta: ${delta})"
+            pass "Context switches remained low (delta: ${delta})"
             log "        Task meeting merge criteria (same PID, same ctxsw)"
         else
             log "⚠ INFO: Context switches increased by ${delta}"
@@ -191,7 +191,7 @@ if [ -n "${tracked_pid}" ]; then
         log "Total starvation detections: ${detections}"
 
         if [ ${detections} -ge 2 ]; then
-            log "✓ PASS: Multiple detections indicate task merging across cycles"
+            pass "Multiple detections indicate task merging across cycles"
         fi
     else
         log "⚠ WARNING: Task exited before second check"
@@ -242,7 +242,7 @@ if [ -n "${tracked_pid}" ]; then
     # If task was boosted, context switches should have changed
     # meaning timestamp should reset for next starvation period
     if grep -q "boosted" "${STALLD_LOG}"; then
-        log "✓ PASS: Task was boosted (made progress)"
+        pass "Task was boosted (made progress)"
 
         # Check if we see a new starvation period starting
         # (This is harder to verify, but context switches changing = no merge)
@@ -311,7 +311,7 @@ else
         log "CPU ${CPU0}: ${cpu0_first}s -> ${cpu0_last}s"
 
         if [ "${cpu0_last}" -gt "${cpu0_first}" ]; then
-            log "✓ PASS: CPU ${CPU0} task merging working (timestamp preserved)"
+            pass "CPU ${CPU0} task merging working (timestamp preserved)"
         fi
     fi
 
@@ -327,12 +327,12 @@ else
         log "CPU ${CPU1}: ${cpu1_first}s -> ${cpu1_last}s"
 
         if [ "${cpu1_last}" -gt "${cpu1_first}" ]; then
-            log "✓ PASS: CPU ${CPU1} task merging working (timestamp preserved)"
+            pass "CPU ${CPU1} task merging working (timestamp preserved)"
         fi
     fi
 
     if [ ${cpu0_detections} -ge 2 ] && [ ${cpu1_detections} -ge 2 ]; then
-        log "✓ PASS: Independent task merging on both CPUs"
+        pass "Independent task merging on both CPUs"
     fi
 
     # Cleanup
-- 
2.53.0

