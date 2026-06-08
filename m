Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B83E120D
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943596; cv=none; b=RovNtSzaF9zw24otZY/VVRmBvqErznjgLG2FJ/T8BaDaGj0CWrkJbRJcewT8y5E4PKLGzrEr60p607vAzdY2PpiWuiXe46+dJAFfhjaE6r1WZb+acPdSm3IVBlj5zTAa1CsplIYAy7l1iHZ45WgSiE9khUNI4pq2dtRqtE6uaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943596; c=relaxed/simple;
	bh=cQi+Pi7Mn8bc75VUNd74DUnAvHDIW4ujiS6rs+b3gaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIsWruFcrZh4iCKhxsONVuS8yTFrpY0MpPfRimURe5l+GdB1TmXXp7iSFiaJxAqJrQX9vT3bxqtKuuRBxyoDkddtMMT67odmdG388eQNaCpuecV4ihfvuC+MfVst9wfO+qtI+290x2YU2iVb7b9kKXTl7lFl5S675vyLljz1LeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YA85+S0P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA85+S0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaGk+3PDK81tkEf2uYqogclp77/ojTGKDy+TBIkNQek=;
	b=YA85+S0P4ZvJbDy6aPqMKQZZq7yr4Id5hyqpOOBKGejFulH9rWDI5RYXQuLNlfIHW+Yn9I
	ol0tJBQTnOX5Ub8km9gCu67OEyoL3WQeq7KSi0oDBf6m7kYVTBS/qp1lJmfjkBav2WGXag
	EIlTEyIJBj0Yg/RtNUfLJAiXp16dVSk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-CyenUBYeOL612dwFb7sYnQ-1; Mon,
 08 Jun 2026 14:33:07 -0400
X-MC-Unique: CyenUBYeOL612dwFb7sYnQ-1
X-Mimecast-MFC-AGG-ID: CyenUBYeOL612dwFb7sYnQ_1780943586
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CC9D1977031;
	Mon,  8 Jun 2026 18:33:06 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADCCF36927;
	Mon,  8 Jun 2026 18:33:03 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 18/52] tests: Remove weak, redundant, and assertion-free test blocks
Date: Mon,  8 Jun 2026 15:31:28 -0300
Message-ID: <20260608183206.140526-19-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Clean up the functional test suite by removing tests and code blocks
that provide no meaningful verification, duplicate existing coverage,
or contain no enforceable assertions.

Specific cleanups include:
  * Remove tests lacking assertions: Drop blocks that log informational
    messages but pass on all branches, making them impossible to fail
    (e.g., in idle detection, FIFO comparison, and boost restoration).
  * Consolidate duplicate coverage: Remove tests whose verification is
    already handled elsewhere, such as:
    - Runqueue parsing (covered by test_starvation_detection and
      test_backend_selection).
    - SCHED_FIFO restoration and deadline policy restoration.
    - FIFO vs DEADLINE comparison and single-threaded mode rejection
      (already covered and fixed in test_force_fifo).
    - Duplicate task merging tests.
  * Remove dead and broken code: Drop the unused `get_starved_pid()`
    helper, broken relative paths, unused helper functions in idle
    detection, and manual task creation scripts that duplicated
    `starvation_gen`.
  * Refactor redundant checks: Replace informative grep checks that
    follow `wait_for_boost_detected` with standard
    `assert_boost_detected` calls.

This consolidation reduces test suite execution time, removes buggy
legacy code, and ensures all remaining test cases have clear,
enforceable pass/fail criteria.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_affinity.sh             |   7 -
 tests/functional/test_boost_period.sh         |  13 +-
 tests/functional/test_boost_restoration.sh    | 177 +--------
 tests/functional/test_deadline_boosting.sh    |  82 +---
 tests/functional/test_fifo_boosting.sh        | 124 +-----
 tests/functional/test_force_fifo.sh           |  51 +--
 tests/functional/test_idle_detection.sh       | 111 +-----
 tests/functional/test_runqueue_parsing.sh     | 375 ------------------
 tests/functional/test_starvation_detection.sh |  81 +---
 tests/functional/test_task_merging.sh         |  53 +--
 10 files changed, 29 insertions(+), 1045 deletions(-)
 delete mode 100755 tests/functional/test_runqueue_parsing.sh

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index 12b83c9..db832f0 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -183,13 +183,6 @@ if [ "$num_cpus" -ge 2 ]; then
         log "⚠ WARNING: stalld affinity ($affinity) doesn't match requested (0)"
     fi
 
-    # Verify it's monitoring CPU 1 by checking logs
-    if grep -q "cpu 1" "${STALLD_LOG}" || grep -q "monitoring.*1" "${STALLD_LOG}"; then
-        log "ℹ INFO: stalld monitoring CPU 1 as requested"
-    else
-        log "ℹ INFO: CPU 1 monitoring not explicitly confirmed in logs"
-    fi
-
     stop_stalld
 else
     log "⊘ SKIP: Test 6 requires at least 2 CPUs"
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index bdbb03a..1bb4e12 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -27,18 +27,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection and boosting
-if wait_for_boost_detected "${STALLD_LOG}"; then
-    pass "Boosting occurred with default period"
-
-    # Try to find period value in logs
-    if grep -qi "period" "${STALLD_LOG}"; then
-        log "ℹ INFO: Period information found in logs"
-    fi
-else
-    fail "No boosting detected"
-    log "Log contents:"
-    cat "${STALLD_LOG}"
-fi
+assert_boost_detected "${STALLD_LOG}" "Boosting occurred with default period"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 63e2bc3..0a75bb7 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -118,119 +118,9 @@ fi
 cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
-# Test 2: Restore Original RT Policy (SCHED_FIFO)
+# Test 2: SCHED_OTHER Policy Restoration
 #=============================================================================
-test_section "Test 2: Restore Original SCHED_FIFO Policy"
-log "Creating a SCHED_FIFO task that gets starved, verify restoration"
-
-threshold=5
-boost_duration=3
-
-log "Starting stalld"
-rm -f "${STALLD_LOG}"
-start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker"
-
-# Create a SCHED_FIFO task that will starve
-# We'll create our own RT task instead of using starvation_gen
-log "Creating custom SCHED_FIFO task (priority 10) that will starve"
-
-# Start a script that sets itself to FIFO and then loops
-cat > /tmp/fifo_task_$$.sh <<'EOF'
-#!/bin/bash
-# Set self to SCHED_FIFO priority 10
-chrt -f 10 $$ 2>/dev/null || exit 1
-# Bind to specific CPU
-taskset -c $1 $0 "running" &
-exit 0
-EOF
-
-cat > /tmp/fifo_task_running_$$.sh <<'EOF'
-#!/bin/bash
-# This process is now FIFO, just loop
-while true; do
-    sleep 0.01
-done
-EOF
-
-chmod +x /tmp/fifo_task_$$.sh /tmp/fifo_task_running_$$.sh
-CLEANUP_FILES+=("/tmp/fifo_task_$$.sh" "/tmp/fifo_task_running_$$.sh")
-
-# Also create the blocker that will starve our FIFO task
-start_starvation_gen -c ${TEST_CPU} -p 90 -n 1 -d 20
-BLOCKER_PID=${STARVE_PID}
-
-# Start our FIFO task on the same CPU (it will starve)
-bash /tmp/fifo_task_running_$$.sh &
-FIFO_TASK_PID=$!
-CLEANUP_PIDS+=("${FIFO_TASK_PID}")
-
-# Set it to FIFO manually
-if chrt -f -p 10 ${FIFO_TASK_PID} 2>/dev/null; then
-    log "Created FIFO task PID ${FIFO_TASK_PID} with priority 10"
-
-    # Bind to test CPU
-    taskset -cp ${TEST_CPU} ${FIFO_TASK_PID} >/dev/null 2>&1
-
-    # Verify initial RT policy
-    initial_policy=$(get_sched_policy ${FIFO_TASK_PID})
-    initial_prio=$(get_sched_priority ${FIFO_TASK_PID})
-    log "Initial: policy=${initial_policy} (1=FIFO), prio=${initial_prio}"
-
-    if [ "$initial_policy" = "1" ]; then
-        pass "Initial policy is SCHED_FIFO (1)"
-    else
-        log "⚠ WARNING: Could not set FIFO policy (got ${initial_policy})"
-    fi
-
-    # Wait for starvation detection
-    log "Waiting for starvation detection and boost..."
-    wait_for_boost_detected "${STALLD_LOG}"
-
-    # Check if boosted
-    if [ -f "/proc/${FIFO_TASK_PID}/sched" ]; then
-        boosted_policy=$(get_sched_policy ${FIFO_TASK_PID})
-        log "Policy during detection window: ${boosted_policy}"
-
-        if [ "$boosted_policy" = "6" ]; then
-            pass "Task boosted to SCHED_DEADLINE (6)"
-        elif [ "$boosted_policy" = "1" ]; then
-            log "ℹ INFO: Still SCHED_FIFO (may not have starved yet)"
-        fi
-    fi
-
-    # Wait for blocker to complete
-    log "Waiting for starvation test to complete..."
-    wait ${BLOCKER_PID} 2>/dev/null || true
-
-    # Verify policy was restored to original FIFO
-    if [ -f "/proc/${FIFO_TASK_PID}/sched" ]; then
-        final_policy=$(get_sched_policy ${FIFO_TASK_PID})
-        final_prio=$(get_sched_priority ${FIFO_TASK_PID})
-        log "Final: policy=${final_policy}, prio=${final_prio}"
-
-        if [ "$final_policy" = "1" ]; then
-            pass "Policy restored to SCHED_FIFO (1)"
-            log "ℹ INFO: Priority after restoration: ${final_prio}"
-        else
-            log "⚠ INFO: Final policy is ${final_policy}"
-            log "        (may have been downgraded or task exited)"
-        fi
-    else
-        log "ℹ INFO: Task exited before final verification"
-    fi
-
-    kill ${FIFO_TASK_PID} 2>/dev/null || true
-else
-    log "⚠ SKIP: Could not create SCHED_FIFO task (insufficient privileges?)"
-fi
-
-# Cleanup
-cleanup_scenario "${BLOCKER_PID}"
-
-#=============================================================================
-# Test 3: SCHED_OTHER Policy Restoration
-#=============================================================================
-test_section "Test 3: Restore SCHED_OTHER Policy"
+test_section "Test 2: Restore SCHED_OTHER Policy"
 log "Test that SCHED_OTHER tasks are correctly restored after boosting"
 
 threshold=5
@@ -282,60 +172,9 @@ fi
 cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
-# Test 4: Restoration Timing Verification
-#=============================================================================
-test_section "Test 4: Restoration Timing Verification"
-
-threshold=5
-boost_duration=4  # 4 second boost
-
-log "Starting stalld with ${boost_duration}s boost duration"
-rm -f "${STALLD_LOG}"
-start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker"
-
-# Create starvation
-log "Creating starvation"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
-
-# Wait for starvation detection and boosting
-if wait_for_boost_detected "${STALLD_LOG}"; then
-    boost_time=$(date +%s)
-    log "Boost detected at timestamp: ${boost_time}"
-
-    # Wait for expected restoration time
-    expected_restore_time=$((boost_time + boost_duration))
-    log "Expected restoration at timestamp: ${expected_restore_time} (${boost_duration}s later)"
-
-    # Wait for boost duration
-    sleep ${boost_duration}
-
-    actual_time=$(date +%s)
-    time_diff=$((actual_time - expected_restore_time))
-    time_diff=${time_diff#-}  # abs value
-
-    log "Actual time: ${actual_time}"
-    log "Time difference: ${time_diff}s"
-
-    if [ ${time_diff} -le 2 ]; then
-        pass "Restoration timing within acceptable margin (±2s)"
-    else
-        log "ℹ INFO: Restoration timing difference: ${time_diff}s"
-        log "        (may be acceptable depending on system load)"
-    fi
-else
-    log "⚠ WARNING: No boost detected for timing test"
-fi
-
-# Cleanup
-cleanup_scenario "${STARVE_PID}"
-
-# Give stalld time to fully exit before next test
-sleep 1
-
-#=============================================================================
-# Test 5: Task Exit During Boost
+# Test 3: Task Exit During Boost
 #=============================================================================
-test_section "Test 5: Graceful Handling of Task Exit During Boost"
+test_section "Test 3: Graceful Handling of Task Exit During Boost"
 
 threshold=5
 boost_duration=5
@@ -366,14 +205,6 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
         fail "stalld crashed or exited after task died during boost"
     fi
 
-    # Check for error messages
-    if grep -iE "error.*restor|fail.*restor" "${STALLD_LOG}"; then
-        log "ℹ INFO: Restoration errors found (expected when task exits):"
-        grep -iE "error.*restor|fail.*restor" "${STALLD_LOG}"
-        log "        These errors are normal when tasks exit during boost"
-    else
-        pass "No restoration errors (clean handling)"
-    fi
 else
     log "⚠ WARNING: No boost detected in this test run"
 fi
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index e777ea0..51bdc2f 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -2,8 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Test: SCHED_DEADLINE Boosting Mechanism
-# Verify stalld correctly boosts starving tasks using SCHED_DEADLINE,
-# applies correct parameters, and restores policies after boost duration
+# Verify stalld correctly boosts starving tasks using SCHED_DEADLINE
+# and applies correct parameters
 #
 # Copyright (C) 2025 Red Hat Inc
 
@@ -146,11 +146,10 @@ if [ -n "${tracked_pid}" ]; then
 
     # Verify task made progress (context switches increased)
     ctxt_delta=$((ctxt_after - ctxt_before))
-    if [ ${ctxt_delta} -gt 5 ]; then
+    if [ ${ctxt_delta} -gt 0 ]; then
         pass "Task made progress during boost (${ctxt_delta} context switches)"
     else
-        log "⚠ INFO: Limited progress detected (${ctxt_delta} context switches)"
-        log "        This may be acceptable depending on boost parameters"
+        fail "No progress during boost (${ctxt_delta} context switches)"
     fi
 else
     log "⚠ WARNING: Could not track starved task PID for progress verification"
@@ -163,78 +162,9 @@ assert_log_contains "${STALLD_LOG}" "boosted" "Boost occurred as expected"
 cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
-# Test 4: Policy Restoration After Boost
+# Test 4: Multiple Simultaneous Boosts
 #=============================================================================
-test_section "Test 4: Policy Restoration After Boost"
-
-threshold=5
-boost_duration=3
-
-log "Starting stalld with ${boost_duration}s boost duration"
-rm -f "${STALLD_LOG}"
-start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
-
-# Create starvation
-log "Creating starvation on CPU ${TEST_CPU}"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
-
-# Find a starved task and verify initial policy
-sleep 2
-tracked_pid=$(find_starved_child "${STARVE_PID}")
-
-if [ -n "${tracked_pid}" ]; then
-    log "Tracking task PID ${tracked_pid} for policy changes"
-
-    # Verify initial policy is SCHED_OTHER (0)
-    initial_policy=$(get_sched_policy ${tracked_pid})
-    log "Initial policy: ${initial_policy} (0=SCHED_OTHER)"
-
-    if [ "$initial_policy" != "0" ]; then
-        log "⚠ WARNING: Initial policy is not SCHED_OTHER (got ${initial_policy})"
-    fi
-
-    # Wait for starvation detection and boosting
-    wait_for_boost_detected "${STALLD_LOG}"
-
-    # Check if policy changed to DEADLINE during boost
-    boosted_policy=$(get_sched_policy ${tracked_pid})
-    log "Policy during boost window: ${boosted_policy} (6=SCHED_DEADLINE)"
-
-    if [ "$boosted_policy" = "6" ]; then
-        pass "Policy changed to SCHED_DEADLINE during boost"
-    else
-        log "⚠ INFO: Policy is ${boosted_policy} (may have already restored or not yet boosted)"
-    fi
-
-    # Wait for boost duration to expire
-    log "Waiting for boost duration (${boost_duration}s) to expire..."
-    sleep $((boost_duration + 2))
-
-    # Verify policy restored
-    if [ -f "/proc/${tracked_pid}/sched" ]; then
-        restored_policy=$(get_sched_policy ${tracked_pid})
-        log "Policy after boost: ${restored_policy}"
-
-        if [ "$restored_policy" = "0" ]; then
-            pass "Policy restored to SCHED_OTHER (0)"
-        else
-            log "⚠ INFO: Policy is ${restored_policy} after boost"
-            log "        (task may have exited or restoration timing differs)"
-        fi
-    else
-        log "⚠ INFO: Task exited, cannot verify final policy restoration"
-    fi
-else
-    log "⚠ WARNING: Could not track task for policy restoration test"
-fi
-
-# Cleanup
-cleanup_scenario "${STARVE_PID}"
-
-#=============================================================================
-# Test 5: Multiple Simultaneous Boosts
-#=============================================================================
-test_section "Test 5: Multiple Simultaneous Boosts"
+test_section "Test 4: Multiple Simultaneous Boosts"
 
 if [ ${NUM_CPUS} -lt 2 ]; then
     log "⚠ SKIP: Need at least 2 CPUs for this test (have ${NUM_CPUS})"
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 38b0b14..8f70c0a 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -2,8 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Test: SCHED_FIFO Boosting Mechanism
-# Verify stalld correctly boosts starving tasks using SCHED_FIFO with -F flag,
-# implements FIFO emulation, and compares with DEADLINE effectiveness
+# Verify stalld correctly boosts starving tasks using SCHED_FIFO with -F flag
+# and implements FIFO emulation behavior
 #
 # Copyright (C) 2025 Red Hat Inc
 
@@ -139,126 +139,6 @@ fi
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
 
-#=============================================================================
-# Test 4: FIFO vs DEADLINE Comparison
-#=============================================================================
-test_section "Test 4: FIFO vs DEADLINE Effectiveness Comparison"
-
-threshold=5
-boost_duration=3
-
-# Test with DEADLINE first
-log ""
-log "Running with SCHED_DEADLINE boosting..."
-STALLD_LOG_DEADLINE="/tmp/stalld_test_deadline_compare_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG_DEADLINE}")
-
-# Create starvation FIRST
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 15
-deadline_tracked_pid=$(find_starved_child "${STARVE_PID}")
-
-ctxt_before_deadline=0
-if [ -n "${deadline_tracked_pid}" ]; then
-    ctxt_before_deadline=$(get_ctxt_switches ${deadline_tracked_pid})
-fi
-
-# NOW start stalld
-start_stalld_with_log "${STALLD_LOG_DEADLINE}" -f -v -g 1 -N -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
-
-# Wait for boost detection, then let boost run to completion
-log "Waiting for DEADLINE boost detection..."
-wait_for_boost_detected "${STALLD_LOG_DEADLINE}"
-sleep $((boost_duration + 1))
-
-ctxt_after_deadline=0
-if [ -n "${deadline_tracked_pid}" ] && [ -f "/proc/${deadline_tracked_pid}/status" ]; then
-    ctxt_after_deadline=$(get_ctxt_switches ${deadline_tracked_pid})
-fi
-
-deadline_progress=$((ctxt_after_deadline - ctxt_before_deadline))
-log "DEADLINE progress: ${deadline_progress} context switches"
-
-cleanup_scenario "${STARVE_PID}"
-
-# Small delay between tests
-sleep 2
-
-# Test with FIFO
-log ""
-log "Running with SCHED_FIFO boosting..."
-STALLD_LOG_FIFO="/tmp/stalld_test_fifo_compare_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG_FIFO}")
-
-# Create starvation FIRST
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 15
-fifo_tracked_pid=$(find_starved_child "${STARVE_PID}")
-
-ctxt_before_fifo=0
-if [ -n "${fifo_tracked_pid}" ]; then
-    ctxt_before_fifo=$(get_ctxt_switches ${fifo_tracked_pid})
-fi
-
-# NOW start stalld
-start_stalld_with_log "${STALLD_LOG_FIFO}" -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
-
-# Wait for boost detection, then let boost run to completion
-log "Waiting for FIFO boost detection..."
-wait_for_boost_detected "${STALLD_LOG_FIFO}"
-sleep $((boost_duration + 1))
-
-ctxt_after_fifo=0
-if [ -n "${fifo_tracked_pid}" ] && [ -f "/proc/${fifo_tracked_pid}/status" ]; then
-    ctxt_after_fifo=$(get_ctxt_switches ${fifo_tracked_pid})
-fi
-
-fifo_progress=$((ctxt_after_fifo - ctxt_before_fifo))
-log "FIFO progress: ${fifo_progress} context switches"
-
-cleanup_scenario "${STARVE_PID}"
-
-# Compare effectiveness
-log ""
-log "Comparison Results:"
-log "  DEADLINE: ${deadline_progress} context switches"
-log "  FIFO: ${fifo_progress} context switches"
-
-if [ ${deadline_progress} -gt 0 ] && [ ${fifo_progress} -gt 0 ]; then
-    pass "Both DEADLINE and FIFO allowed tasks to make progress"
-
-    # Both should be effective, but exact numbers may vary
-    if [ ${deadline_progress} -gt ${fifo_progress} ]; then
-        log "ℹ INFO: DEADLINE showed more progress than FIFO"
-    elif [ ${fifo_progress} -gt ${deadline_progress} ]; then
-        log "ℹ INFO: FIFO showed more progress than DEADLINE"
-    else
-        log "ℹ INFO: DEADLINE and FIFO showed similar progress"
-    fi
-else
-    log "⚠ WARNING: One or both methods did not show progress (may be timing issue)"
-fi
-
-#=============================================================================
-# Test 5: Single-Threaded Mode Fails with FIFO
-#=============================================================================
-test_section "Test 5: Single-Threaded Mode with FIFO (Should Fail)"
-
-log "Attempting to start stalld with -F without -A (single-threaded + FIFO)"
-STALLD_LOG_FAIL="/tmp/stalld_test_fifo_fail_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG_FAIL}")
-
-# Try to start stalld with -F but without -A (single-threaded mode)
-# This should fail because single-threaded mode only works with DEADLINE
-timeout 5 ${TEST_ROOT}/../stalld -f -v -F -t 5 -c ${TEST_CPU} > "${STALLD_LOG_FAIL}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "stalld rejected FIFO in single-threaded mode"
-elif grep -qiE "single.*thread|falling back|adaptive" "${STALLD_LOG_FAIL}"; then
-    pass "stalld detected incompatibility and fell back to adaptive mode"
-else
-    fail "stalld silently accepted FIFO in single-threaded mode"
-fi
-
 #=============================================================================
 # Final Summary
 #=============================================================================
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 6c21d3e..d2a6281 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -76,18 +76,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-wait_for_boost_detected "${STALLD_LOG3}"
-
-# Check logs for priority information
-if grep -qi "priority\|prio" "${STALLD_LOG3}"; then
-    log "ℹ INFO: Priority information found in logs"
-fi
-
-if grep -q "boost" "${STALLD_LOG3}"; then
-    pass "FIFO boosting with priority setting completed"
-else
-    log "⚠ WARNING: No boosting detected"
-fi
+assert_boost_detected "${STALLD_LOG3}" "FIFO boosting with priority setting completed"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -123,44 +112,6 @@ test_section "Test 5: Single-threaded mode with FIFO (should fail)"
 log "Testing single-threaded mode (-O) with -F (should exit)"
 assert_stalld_rejects "Single-threaded mode rejected FIFO" -f -v -c "${TEST_CPU}" -t ${threshold} -F -O
 
-#=============================================================================
-# Test 6: Compare effectiveness (informational)
-#=============================================================================
-test_section "Test 6: FIFO vs DEADLINE comparison (informational)"
-
-comparison_duration=2
-comparison_starvation=8
-
-# Run with DEADLINE
-STALLD_LOG_DL="/tmp/stalld_test_force_fifo_deadline_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG_DL}")
-
-log "Running comparison test with SCHED_DEADLINE"
-start_stalld_with_log "${STALLD_LOG_DL}" -f -v -c "${TEST_CPU}" -t ${threshold} -d ${comparison_duration}
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${comparison_starvation}
-wait_for_boost_detected "${STALLD_LOG_DL}"
-
-deadline_boosts=$(grep -c "boost" "${STALLD_LOG_DL}" || echo 0)
-log "ℹ INFO: SCHED_DEADLINE boosts: $deadline_boosts"
-
-cleanup_scenario "${STARVE_PID}"
-
-# Run with FIFO
-STALLD_LOG_FIFO="/tmp/stalld_test_force_fifo_comparison_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG_FIFO}")
-
-log "Running comparison test with SCHED_FIFO"
-start_stalld_with_log "${STALLD_LOG_FIFO}" -f -v -c "${TEST_CPU}" -t ${threshold} -F -A -d ${comparison_duration}
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${comparison_starvation}
-wait_for_boost_detected "${STALLD_LOG_FIFO}"
-
-fifo_boosts=$(grep -c "boost" "${STALLD_LOG_FIFO}" || echo 0)
-log "ℹ INFO: SCHED_FIFO boosts: $fifo_boosts"
-
-cleanup_scenario "${STARVE_PID}"
-
-log "ℹ INFO: Comparison complete (DEADLINE: $deadline_boosts, FIFO: $fifo_boosts)"
-
 log ""
 log "All force FIFO tests completed"
 
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index 5647129..20dfea6 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -14,102 +14,12 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-# Helper to get CPU idle time from /proc/stat (test-specific)
-get_cpu_idle_time() {
-    local cpu_id=$1
-    # Field 4 is idle time in /proc/stat (0-indexed from cpu name)
-    # cpu0 user nice system idle ...
-    awk "/^cpu${cpu_id} / {print \$5}" /proc/stat
-}
-
-# Helper to check if CPU is idle (idle time increasing)
-is_cpu_idle() {
-    local cpu_id=$1
-    local idle1=$(get_cpu_idle_time $cpu_id)
-    sleep 1
-    local idle2=$(get_cpu_idle_time $cpu_id)
-
-    if [ "$idle2" -gt "$idle1" ]; then
-        return 0  # Idle (idle time increased)
-    else
-        return 1  # Busy
-    fi
-}
-
 init_functional_test "Idle CPU Detection" "test_idle"
 
-# Check if idle detection is enabled by default
-log ""
-log "Idle detection is enabled by default (config_idle_detection=1)"
-log "Function: cpu_had_idle_time() in stalld.c:226-260"
-log "Reads: /proc/stat for per-CPU idle time"
-
-#=============================================================================
-# Test 1: Idle CPUs Skipped (No Parsing)
-#=============================================================================
-test_section "Test 1: Idle CPUs Skipped"
-log "Idle CPUs should be skipped to reduce overhead"
-
-threshold=5
-log "Starting stalld with verbose logging"
-# Use -g 1 for 1-second granularity
-start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
-
-# Let stalld run while CPU is idle (no load)
-log "CPU ${TEST_CPU} should be idle (no load created)"
-sleep 5
-
-# Check if stalld detected the CPU as idle
-if grep -qi "idle\|skip" "${STALLD_LOG}"; then
-    log "ℹ INFO: Idle-related messages in log:"
-    grep -i "idle\|skip" "${STALLD_LOG}" | head -5
-else
-    log "ℹ INFO: No explicit idle messages (idle detection may be working silently)"
-fi
-
-# Verify CPU is actually idle
-if is_cpu_idle ${TEST_CPU}; then
-    pass "CPU ${TEST_CPU} is currently idle (idle time increasing)"
-else
-    log "⚠ INFO: CPU ${TEST_CPU} appears busy (background activity)"
-fi
-
-stop_stalld
-
-#=============================================================================
-# Test 2: /proc/stat Parsing
-#=============================================================================
-test_section "Test 2: /proc/stat Idle Time Parsing"
-
-# Read idle time for test CPU
-idle_time1=$(get_cpu_idle_time ${TEST_CPU})
-log "CPU ${TEST_CPU} idle time: ${idle_time1} (from /proc/stat field 4)"
-
-# Wait a bit
-sleep 2
-
-idle_time2=$(get_cpu_idle_time ${TEST_CPU})
-log "CPU ${TEST_CPU} idle time after 2s: ${idle_time2}"
-
-if [ -n "${idle_time1}" ] && [ -n "${idle_time2}" ]; then
-    delta=$((idle_time2 - idle_time1))
-    log "Idle time delta: ${delta}"
-
-    if [ ${delta} -gt 0 ]; then
-        pass "Idle time increased (CPU is idle)"
-        log "        stalld would skip this CPU"
-    else
-        pass "Idle time unchanged (CPU is busy)"
-        log "        stalld would parse this CPU"
-    fi
-else
-    fail "Could not read idle time from /proc/stat"
-fi
-
 #=============================================================================
-# Test 3: Monitoring Resumes When CPU Becomes Busy
+# Test 1: Monitoring Resumes When CPU Becomes Busy
 #=============================================================================
-test_section "Test 3: Monitoring Resumes for Busy CPUs"
+test_section "Test 1: Monitoring Resumes for Busy CPUs"
 
 threshold=5
 rm -f "${STALLD_LOG}"
@@ -140,9 +50,9 @@ fi
 cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
-# Test 4: Idle CPUs Are Skipped
+# Test 2: Idle CPUs Are Skipped
 #=============================================================================
-test_section "Test 4: Idle CPUs Are Skipped"
+test_section "Test 2: Idle CPUs Are Skipped"
 
 rm -f "${STALLD_LOG}"
 threshold=3
@@ -157,9 +67,9 @@ assert_log_contains "${STALLD_LOG}" "skipping" "Idle CPU correctly skipped"
 cleanup_scenario
 
 #=============================================================================
-# Test 5: Idle Detection with Multiple CPUs
+# Test 3: Idle Detection with Multiple CPUs
 #=============================================================================
-test_section "Test 5: Per-CPU Independent Idle Detection"
+test_section "Test 3: Per-CPU Independent Idle Detection"
 
 NUM_CPUS=$(get_num_cpus)
 if [ ${NUM_CPUS} -lt 2 ]; then
@@ -211,15 +121,6 @@ fi
 # Final Summary
 #=============================================================================
 test_section "Test Summary"
-log "Idle detection functions:"
-log "  - cpu_had_idle_time() in stalld.c:226-260"
-log "  - get_cpu_busy_list() in stalld.c:262-308"
-log "  - read_proc_stat() in utils.c"
-log ""
-log "Mechanism: Compares idle time in /proc/stat between cycles"
-log "  - Idle time increased = CPU idle (skip parsing)"
-log "  - Idle time unchanged = CPU busy (parse for starvation)"
-log ""
 log "Total failures: ${TEST_FAILED}"
 
 end_test
diff --git a/tests/functional/test_runqueue_parsing.sh b/tests/functional/test_runqueue_parsing.sh
deleted file mode 100755
index a4dc180..0000000
--- a/tests/functional/test_runqueue_parsing.sh
+++ /dev/null
@@ -1,375 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# Test: Runqueue Parsing - Backend Task Extraction
-# Verify both eBPF and sched_debug backends correctly extract task information
-#
-# Copyright (C) 2025 Red Hat Inc
-
-# Load test helpers
-TEST_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
-source "${TEST_ROOT}/helpers/test_helpers.sh"
-
-# Parse command-line options
-parse_test_options "$@" || exit $?
-
-# Helper to check if a backend is available (test-specific)
-backend_available() {
-    local backend=$1
-    ./stalld -b "$backend" -h >/dev/null 2>&1
-    return $?
-}
-
-# Helper to extract task info from stalld verbose log
-# Returns count of detected tasks
-count_detected_tasks() {
-    local log_file=$1
-    grep -c "starved on CPU" "$log_file" 2>/dev/null || echo "0"
-}
-
-start_test "Runqueue Parsing - Backend Task Extraction"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG_BPF="/tmp/stalld_test_parse_bpf_$$.log"
-STALLD_LOG_SCHED="/tmp/stalld_test_parse_sched_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG_BPF}" "${STALLD_LOG_SCHED}")
-
-# Check which backends are available
-BPF_AVAILABLE=0
-SCHED_DEBUG_AVAILABLE=0
-
-if backend_available "queue_track"; then
-    BPF_AVAILABLE=1
-    log "✓ eBPF (queue_track) backend available"
-else
-    log "⚠ eBPF (queue_track) backend not available"
-fi
-
-if backend_available "sched_debug"; then
-    SCHED_DEBUG_AVAILABLE=1
-    log "✓ sched_debug backend available"
-else
-    log "⚠ sched_debug backend not available"
-fi
-
-if [ ${BPF_AVAILABLE} -eq 0 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 0 ]; then
-    echo -e "${YELLOW}SKIP: No backends available for testing${NC}"
-    exit 77
-fi
-
-#=============================================================================
-# Test 1: eBPF Backend Task Extraction
-#=============================================================================
-if [ ${BPF_AVAILABLE} -eq 1 ]; then
-    test_section "Test 1: eBPF Backend Task Extraction"
-
-    threshold=5
-    log "Starting stalld with eBPF backend (queue_track)"
-    # Use -g 1 for 1-second granularity
-    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b queue_track -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_BPF}" 2>&1
-
-    # Create starvation to generate task data
-    starvation_duration=$((threshold + 5))
-    log "Creating starvation for ${starvation_duration}s"
-    start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
-
-    # Wait for starvation detection
-    if wait_for_starvation_detected "${STALLD_LOG_BPF}"; then
-        pass "eBPF backend detected starving tasks"
-
-        # Verify task info is present (PID, comm)
-        if grep -E "starvation_gen.*starved on CPU ${TEST_CPU}" "${STALLD_LOG_BPF}"; then
-            pass "Task name (comm) correctly extracted"
-        else
-            fail "Task name not found in eBPF backend output"
-        fi
-
-        # Verify PID is logged
-        if grep -E "\[[0-9]+\].*starved on CPU" "${STALLD_LOG_BPF}"; then
-            pass "Task PID correctly extracted"
-        else
-            log "⚠ INFO: PID format may have changed"
-        fi
-    else
-        fail "eBPF backend did not detect starvation"
-        log "Log contents:"
-        cat "${STALLD_LOG_BPF}"
-    fi
-
-    # Cleanup
-    cleanup_scenario "${STARVE_PID}"
-else
-    test_section "Test 1: eBPF Backend - SKIPPED"
-    log "eBPF backend not available on this system"
-fi
-
-#=============================================================================
-# Test 2: sched_debug Backend Task Extraction
-#=============================================================================
-if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
-    test_section "Test 2: sched_debug Backend Task Extraction"
-
-    threshold=5
-    log "Starting stalld with sched_debug backend"
-    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
-
-    # Create starvation
-    starvation_duration=$((threshold + 5))
-    log "Creating starvation for ${starvation_duration}s"
-    start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
-
-    # Wait for starvation detection
-    if wait_for_starvation_detected "${STALLD_LOG_SCHED}"; then
-        pass "sched_debug backend detected starving tasks"
-
-        # Verify task info is present
-        if grep -E "starvation_gen.*starved on CPU ${TEST_CPU}" "${STALLD_LOG_SCHED}"; then
-            pass "Task name (comm) correctly extracted"
-        else
-            fail "Task name not found in sched_debug backend output"
-        fi
-
-        # Verify PID is logged
-        if grep -E "\[[0-9]+\].*starved on CPU" "${STALLD_LOG_SCHED}"; then
-            pass "Task PID correctly extracted"
-        else
-            log "⚠ INFO: PID format may have changed"
-        fi
-
-        # Check for format detection message
-        if grep -q "task_format.*detected" "${STALLD_LOG_SCHED}"; then
-            format=$(grep "task_format.*detected" "${STALLD_LOG_SCHED}" | tail -1)
-            log "ℹ INFO: Kernel format detected: $format"
-        fi
-    else
-        fail "sched_debug backend did not detect starvation"
-        log "Log contents:"
-        cat "${STALLD_LOG_SCHED}"
-    fi
-
-    # Cleanup
-    cleanup_scenario "${STARVE_PID}"
-else
-    test_section "Test 2: sched_debug Backend - SKIPPED"
-    log "sched_debug backend not available on this system"
-fi
-
-#=============================================================================
-# Test 3: Backend Comparison (Both Should Detect Same Starvation)
-#=============================================================================
-if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
-    test_section "Test 3: Backend Comparison"
-    log "Testing that both backends detect the same starvation condition"
-
-    threshold=5
-    starvation_duration=$((threshold + 5))
-
-    # Test with eBPF backend
-    log ""
-    log "Running with eBPF backend..."
-    rm -f "${STALLD_LOG_BPF}"
-    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b queue_track -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_BPF}" 2>&1
-
-    start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
-
-    wait_for_starvation_detected "${STALLD_LOG_BPF}"
-    bpf_detections=$(count_detected_tasks "${STALLD_LOG_BPF}")
-    log "eBPF backend detected: ${bpf_detections} starvation events"
-
-    cleanup_scenario "${STARVE_PID}"
-
-    # Small delay between tests
-    sleep 2
-
-    # Test with sched_debug backend
-    log ""
-    log "Running with sched_debug backend..."
-    rm -f "${STALLD_LOG_SCHED}"
-    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
-
-    start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
-
-    wait_for_starvation_detected "${STALLD_LOG_SCHED}"
-    sched_detections=$(count_detected_tasks "${STALLD_LOG_SCHED}")
-    log "sched_debug backend detected: ${sched_detections} starvation events"
-
-    cleanup_scenario "${STARVE_PID}"
-
-    # Compare results
-    log ""
-    if [ ${bpf_detections} -gt 0 ] && [ ${sched_detections} -gt 0 ]; then
-        pass "Both backends detected starvation"
-
-        # Check if detection counts are similar (within reasonable variance)
-        diff=$((bpf_detections - sched_detections))
-        diff=${diff#-}  # absolute value
-
-        if [ ${diff} -le 2 ]; then
-            pass "Detection counts are consistent (eBPF: ${bpf_detections}, sched_debug: ${sched_detections})"
-        else
-            log "⚠ INFO: Detection counts differ (eBPF: ${bpf_detections}, sched_debug: ${sched_detections})"
-            log "        This may be due to timing differences between backends"
-        fi
-    else
-        fail "One or both backends failed to detect starvation"
-    fi
-else
-    test_section "Test 3: Backend Comparison - SKIPPED"
-    log "Both backends required for comparison test"
-fi
-
-#=============================================================================
-# Test 4: Verify Task Field Extraction (PID, comm, priority, switches)
-#=============================================================================
-test_section "Test 4: Task Field Extraction Verification"
-
-# Use whichever backend is available
-if [ ${BPF_AVAILABLE} -eq 1 ]; then
-    test_backend="queue_track"
-    log_file="${STALLD_LOG_BPF}"
-elif [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
-    test_backend="sched_debug"
-    log_file="${STALLD_LOG_SCHED}"
-else
-    log "SKIP: No backend available"
-    test_backend=""
-fi
-
-if [ -n "$test_backend" ]; then
-    threshold=5
-    log "Testing task field extraction with ${test_backend} backend"
-
-    rm -f "${log_file}"
-    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b ${test_backend} -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${log_file}" 2>&1
-
-    # Create starvation with known parameters
-    log "Creating starvation with known task name (starvation_gen)"
-    start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 10 -v
-
-    # Wait for starvation detection
-    wait_for_starvation_detected "${log_file}"
-
-    # Verify fields are present
-    log ""
-    log "Verifying extracted fields in log:"
-
-    # Check for task name (comm field)
-    if grep -q "starvation_gen" "${log_file}"; then
-        pass "Task name (comm) field extracted"
-    else
-        fail "Task name (comm) field not found"
-    fi
-
-    # Check for PID field (format: name-PID or [PID])
-    if grep -qE "(starvation_gen-[0-9]+|\[[0-9]+\])" "${log_file}"; then
-        pass "PID field extracted"
-    else
-        fail "PID field not found"
-    fi
-
-    # Check for CPU ID
-    if grep -q "CPU ${TEST_CPU}" "${log_file}"; then
-        pass "CPU ID field extracted"
-    else
-        fail "CPU ID field not found"
-    fi
-
-    # Check for starvation duration
-    if grep -qE "for [0-9]+ seconds" "${log_file}"; then
-        pass "Starvation duration calculated from context switches/time"
-    else
-        fail "Starvation duration not found"
-    fi
-
-    # Cleanup
-    cleanup_scenario "${STARVE_PID}"
-fi
-
-#=============================================================================
-# Test 5: Kernel Format Handling (sched_debug backend)
-#=============================================================================
-if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
-    test_section "Test 5: Kernel Format Detection (sched_debug)"
-
-    threshold=5
-    rm -f "${STALLD_LOG_SCHED}"
-    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
-
-    # Create brief starvation just to initialize the backend
-    start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 8
-
-    # Wait for starvation detection
-    wait_for_starvation_detected "${STALLD_LOG_SCHED}"
-
-    # Check for format detection messages
-    if grep -q "detect_task_format" "${STALLD_LOG_SCHED}"; then
-        detected_format=$(grep "detect_task_format" "${STALLD_LOG_SCHED}" | grep "detected" | tail -1)
-        pass "Kernel format auto-detection occurred"
-        log "ℹ INFO: ${detected_format}"
-
-        # Check if field offsets were detected
-        if grep -q "found 'task' at word" "${STALLD_LOG_SCHED}"; then
-            pass "Task field offset detected"
-        fi
-        if grep -q "found 'PID' at word" "${STALLD_LOG_SCHED}"; then
-            pass "PID field offset detected"
-        fi
-        if grep -q "found 'switches' at word" "${STALLD_LOG_SCHED}"; then
-            pass "Switches field offset detected"
-        fi
-        if grep -q "found 'prio' at word" "${STALLD_LOG_SCHED}"; then
-            pass "Priority field offset detected"
-        fi
-    else
-        log "⚠ INFO: Format detection messages not in log (may not be verbose enough)"
-    fi
-
-    # Verify the backend still works despite format
-    if grep -q "starved on CPU" "${STALLD_LOG_SCHED}"; then
-        pass "Backend successfully parsed tasks despite kernel format"
-    else
-        log "⚠ INFO: No starvation detected in this test run"
-    fi
-
-    # Cleanup
-    cleanup_scenario "${STARVE_PID}"
-else
-    test_section "Test 5: Kernel Format Detection - SKIPPED"
-    log "sched_debug backend required for format detection tests"
-fi
-
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Backends tested:"
-[ ${BPF_AVAILABLE} -eq 1 ] && log "  - eBPF (queue_track): available"
-[ ${SCHED_DEBUG_AVAILABLE} -eq 1 ] && log "  - sched_debug: available"
-log ""
-log "Total failures: ${TEST_FAILED}"
-
-end_test
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 2d2e9b1..1887d13 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -2,8 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Test: Starvation Detection Logic
-# Verify stalld correctly detects starving tasks, tracks context switches,
-# and implements task merging (timestamp preservation)
+# Verify stalld correctly detects starving tasks and tracks context switches
 #
 # Copyright (C) 2025 Red Hat Inc
 
@@ -14,13 +13,6 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-# Helper to extract starved task PID from stalld logs (test-specific)
-get_starved_pid() {
-    local log_file=$1
-    # Look for pattern like "starvation_gen-12345 starved on CPU"
-    grep "starved on CPU" "$log_file" | tail -1 | sed -E 's/.*\[([0-9]+)\].*/\1/' | head -1
-}
-
 init_functional_test "Starvation Detection Logic" "test_detection"
 
 # Get number of CPUs for multi-CPU tests
@@ -104,68 +96,9 @@ fi
 cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
-# Test 3: Task Merging (Timestamp Preservation)
-#=============================================================================
-test_section "Test 3: Task Merging - Timestamp Preservation"
-
-rm -f "${STALLD_LOG}"
-threshold=3
-
-# Create long starvation to trigger multiple detection cycles
-starvation_duration=15
-log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
-
-log "Starting stalld with ${threshold}s threshold (log-only mode)"
-log "Will monitor for multiple detection cycles to verify timestamp preservation"
-start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
-
-# Wait for first detection cycle
-log "Waiting for first detection cycle..."
-wait_for_starvation_detected "${STALLD_LOG}"
-log "First detection cycle should have occurred"
-# Wait for additional detection cycles
-sleep 4
-log "Second detection cycle should have occurred"
-sleep 4
-log "Third detection cycle should have occurred"
-
-# Stop stalld to flush output buffers before checking log
-stop_stalld
-
-# Check if we see accumulating starvation time in logs
-# Task merging means the timestamp is preserved, so duration increases
-report_count=$(grep -cE "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}")
-if [ "${report_count}" -ge 2 ]; then
-    pass "Multiple starvation reports found (${report_count} reports)"
-
-    # Extract starvation durations from log
-    durations=$(grep -oE "starved on CPU ${TEST_CPU} for [0-9]+" "${STALLD_LOG}" | grep -oE "[0-9]+$")
-    log "Starvation durations observed: $(echo $durations | tr '\n' ' ')"
-
-    # Verify durations are increasing (timestamp preserved = duration accumulates)
-    first_duration=$(echo "$durations" | head -1)
-    last_duration=$(echo "$durations" | tail -1)
-
-    if [ ${last_duration} -gt ${first_duration} ]; then
-        pass "Starvation duration increased (${first_duration}s -> ${last_duration}s)"
-        log "        This confirms task merging preserved the timestamp"
-    else
-        fail "Starvation duration did not increase (timestamp may have been reset)"
-    fi
-else
-    fail "Not enough starvation reports to verify task merging (found ${report_count}, need >= 2)"
-    log "Log contents:"
-    cat "${STALLD_LOG}"
-fi
-
-# Cleanup starvation generator
-cleanup_scenario "${STARVE_PID}"
-
-#=============================================================================
-# Test 4: Multiple CPUs Detection
+# Test 3: Multiple CPUs Detection
 #=============================================================================
-test_section "Test 4: Multiple CPUs Detection"
+test_section "Test 3: Multiple CPUs Detection"
 
 if [ ${NUM_CPUS} -lt 2 ]; then
     log "⚠ SKIP: Need at least 2 CPUs for this test (have ${NUM_CPUS})"
@@ -221,9 +154,9 @@ else
 fi
 
 #=============================================================================
-# Test 5: No False Positives (Task Making Progress)
+# Test 4: No False Positives (Task Making Progress)
 #=============================================================================
-test_section "Test 5: No False Positives"
+test_section "Test 4: No False Positives"
 
 rm -f "${STALLD_LOG}"
 threshold=5
@@ -251,9 +184,9 @@ wait ${BUSY_PID} 2>/dev/null
 stop_stalld
 
 #=============================================================================
-# Test 6: Edge Case - Task Exits During Monitoring
+# Test 5: Edge Case - Task Exits During Monitoring
 #=============================================================================
-test_section "Test 6: Task Exits During Monitoring"
+test_section "Test 5: Task Exits During Monitoring"
 
 rm -f "${STALLD_LOG}"
 threshold=10
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 72f7c63..434114b 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -16,13 +16,6 @@ parse_test_options "$@" || exit $?
 
 init_functional_test "Task Merging Logic" "test_merge"
 
-# Check for DL-server (kernel automatic starvation handling)
-if [ -d "/sys/kernel/debug/sched/fair_server" ]; then
-    echo -e "${YELLOW}SKIP: DL-server detected - kernel handles starvation automatically${NC}"
-    echo "      Task merging cannot be tested when DL-server prevents starvation"
-    exit 77
-fi
-
 #=============================================================================
 # Test 1: Timestamp Preservation for Non-Progressing Tasks
 #=============================================================================
@@ -158,51 +151,9 @@ fi
 cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
-# Test 3: Task Making Progress (No Merge)
-#=============================================================================
-test_section "Test 3: No Merge When Task Makes Progress"
-log "When context switches change, timestamp should reset"
-
-threshold=5
-rm -f "${STALLD_LOG}"
-start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d 2
-
-# Create starvation that will get boosted (allowing progress)
-log "Creating starvation that will be boosted"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
-
-# Find tracked task while it's guaranteed to be starving
-tracked_pid=$(find_starved_child "${STARVE_PID}")
-
-# Wait for starvation detection
-wait_for_starvation_detected "${STALLD_LOG}"
-if [ -n "${tracked_pid}" ]; then
-    # Wait for boost to complete and task to starve again
-    sleep 5
-
-    # If task was boosted, context switches should have changed
-    # meaning timestamp should reset for next starvation period
-    if grep -q "boosted" "${STALLD_LOG}"; then
-        pass "Task was boosted (made progress)"
-
-        # Check if we see a new starvation period starting
-        # (This is harder to verify, but context switches changing = no merge)
-        log "ℹ INFO: When task makes progress (ctxsw changes), timestamp resets"
-        log "        Next starvation detection starts new timing period"
-    else
-        log "ℹ INFO: No boost occurred (may be timing dependent)"
-    fi
-else
-    log "⚠ INFO: Could not track task for progress test"
-fi
-
-# Cleanup
-cleanup_scenario "${STARVE_PID}"
-
-#=============================================================================
-# Test 4: Multiple CPUs with Independent Task Merging
+# Test 3: Multiple CPUs with Independent Task Merging
 #=============================================================================
-test_section "Test 4: Per-CPU Independent Task Merging"
+test_section "Test 3: Per-CPU Independent Task Merging"
 
 NUM_CPUS=$(get_num_cpus)
 if [ ${NUM_CPUS} -lt 2 ]; then
-- 
2.54.0

