Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB43E2AC8
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285736; cv=none; b=UxGGgSv/j95V7d4DeI/6RkkC3YppugSBtBdDgpsUBrQlW9DxYv6vWQuDsch+urKsVgH4ru/PuSiTbl1Vrhwxyo5udI14F9PDS38Pgx/z39ASKsyZhmUmsb8jZlEwAf2LwtYxLrG40DCGz79ZCsqowbHNYY3jRRbM4LtYS5X8jF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285736; c=relaxed/simple;
	bh=xGBuMlxCLxv5o1WvXgr9XdRIFpvFpej7EsDUz49htZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJTvRWGjg0uR7UZW09DBVrkoxHBBqAEw7NMGt3te+BcBmMAjejJeaCtRQ+JI5Ctb/JARLdZ8eIAT4dMY2QX+QHOb0XeqSmzwpYxIpxGPfUAlD4SCtvQJiHVRoz3SUqfl0y0HzW65j+tXNaDODibOtzsL/ArfJsLa4lyJHXzxugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9QlKFjW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9QlKFjW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKqrqUhU0SHreBF179eLPvPTifUUS8p9nSvwcE3mNIk=;
	b=e9QlKFjWhjOAE8kK8gbEwDbVKlHyc/j66/UgJokolAn9t29cuQ/ej/zBf0o68RgdLK/9h3
	aFpgtljFv3MXuWlo28xPTBHWJr6iN8NUVOpgm6Ubl+YkNUDVZqcdOabIUIWEUfwUfmBcMT
	ZP29mdbB+r3sEYGCMKPTB0X6pRlYBJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-NSqEAIIhPBixdajuzAAzCQ-1; Wed,
 20 May 2026 10:02:07 -0400
X-MC-Unique: NSqEAIIhPBixdajuzAAzCQ-1
X-Mimecast-MFC-AGG-ID: NSqEAIIhPBixdajuzAAzCQ_1779285726
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D36F1955F1C;
	Wed, 20 May 2026 14:02:06 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DD2E1800465;
	Wed, 20 May 2026 14:02:03 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 19/33] tests: Introduce and adopt assert_success() helper
Date: Wed, 20 May 2026 11:00:46 -0300
Message-ID: <20260520140104.112142-20-wander@redhat.com>
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

Multiple functional tests repeat a verbose pattern: running a command,
checking its exit status, and conditionally calling pass, fail, or
printing a warning. These if/else blocks are repeated dozens of times
across the test suite. Furthermore, tests that only printed warnings
on failure silently masked real test problems.

Introduce an assert_success() helper that encapsulates command
execution, exit code evaluation, and standardized pass/fail reporting
into a single function call. To support various test requirements,
the helper includes a `--negate` flag for asserting expected command
failures. Crucially, this helper unconditionally calls fail() on
error, eliminating the weak warning-only pattern.

Adopt this new helper across the functional test suite. This refactor:
  * Eliminates over 20 duplicated if/else blocks across the suite.
  * Tightens previously weak assertions (e.g., in test_affinity)
    that only warned on failure to actual test failures.
  * Flattens nested conditional logic into clear, sequential
    assertions (e.g., in test_fifo_priority_starvation).
  * Removes redundant checks that were already covered by existing
    wait_for_boost_detected assertions.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_affinity.sh             | 44 +++----------------
 tests/functional/test_boost_restoration.sh    | 30 +++----------
 tests/functional/test_cpu_selection.sh        | 24 ++--------
 tests/functional/test_deadline_boosting.sh    | 14 +-----
 .../test_fifo_priority_starvation.sh          | 44 +++++--------------
 tests/functional/test_foreground.sh           | 18 ++------
 tests/functional/test_logging_destinations.sh |  6 +--
 tests/functional/test_pidfile.sh              | 24 ++--------
 tests/functional/test_starvation_detection.sh |  6 +--
 tests/helpers/test_helpers.sh                 | 34 +++++++++++++-
 10 files changed, 71 insertions(+), 173 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index db832f0..15a8756 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -60,12 +60,7 @@ sleep 2
 default_affinity=$(check_affinity "${STALLD_PID}")
 log "ℹ INFO: Default affinity: $default_affinity"
 
-# Typically should be all CPUs
-if [ -n "$default_affinity" ]; then
-    pass "stalld has default affinity: $default_affinity"
-else
-    log "⚠ WARNING: Could not determine default affinity"
-fi
+assert_success "stalld has default affinity" test -n "$default_affinity"
 
 stop_stalld
 
@@ -79,11 +74,7 @@ sleep 2
 
 affinity=$(check_affinity "${STALLD_PID}")
 
-if [ "$affinity" = "0" ]; then
-    pass "stalld restricted to CPU 0"
-else
-    fail "stalld affinity ($affinity) doesn't match requested (0)"
-fi
+assert_success "stalld restricted to CPU 0" test "$affinity" = "0"
 
 stop_stalld
 
@@ -99,12 +90,7 @@ if [ "$num_cpus" -ge 4 ]; then
     affinity=$(check_affinity "${STALLD_PID}")
 
     # Accept either "0,2" or "0-2" or "2,0" (different systems may report differently)
-    if echo "$affinity" | grep -qE '^0,2$|^0-2$|^2,0$'; then
-        pass "stalld restricted to CPUs 0,2 (affinity: $affinity)"
-    else
-        log "⚠ WARNING: stalld affinity ($affinity) may not match requested (0,2) - format may vary"
-        # Not failing as different systems may report differently
-    fi
+    assert_success "stalld restricted to CPUs 0,2" test -n "$(echo "$affinity" | grep -E '^0,2$|^0-2$|^2,0$')"
 
     stop_stalld
 else
@@ -123,11 +109,7 @@ if [ "$num_cpus" -ge 4 ]; then
     affinity=$(check_affinity "${STALLD_PID}")
 
     # Accept various formats: "0-2", "0,1,2", etc.
-    if echo "$affinity" | grep -qE '0.*1.*2|0-2'; then
-        pass "stalld restricted to CPU range 0-2 (affinity: $affinity)"
-    else
-        log "⚠ WARNING: stalld affinity ($affinity) may not match requested (0-2) - format may vary"
-    fi
+    assert_success "stalld restricted to CPU range 0-2" test -n "$(echo "$affinity" | grep -E '0.*1.*2|0-2')"
 
     stop_stalld
 else
@@ -153,11 +135,7 @@ if [ "$num_cpus" -ge 2 ]; then
         log "ℹ INFO: Found $child_threads threads for stalld"
     fi
 
-    if [ "$affinity" = "$test_cpu" ]; then
-        pass "stalld process affinity set to CPU $test_cpu"
-    else
-        log "⚠ WARNING: stalld affinity ($affinity) doesn't exactly match CPU $test_cpu"
-    fi
+    assert_success "stalld process affinity set to CPU $test_cpu" test "$affinity" = "$test_cpu"
 
     stop_stalld
 else
@@ -177,11 +155,7 @@ if [ "$num_cpus" -ge 2 ]; then
 
     affinity=$(check_affinity "${STALLD_PID}")
 
-    if [ "$affinity" = "0" ]; then
-        pass "stalld affinity to CPU 0 while monitoring CPU 1"
-    else
-        log "⚠ WARNING: stalld affinity ($affinity) doesn't match requested (0)"
-    fi
+    assert_success "stalld affinity to CPU 0 while monitoring CPU 1" test "$affinity" = "0"
 
     stop_stalld
 else
@@ -212,11 +186,7 @@ sleep 3
 affinity_end=$(check_affinity "${STALLD_PID}")
 log "ℹ INFO: Affinity after 3s: $affinity_end"
 
-if [ "$affinity_start" = "$affinity_end" ]; then
-    pass "CPU affinity persisted over time"
-else
-    log "⚠ WARNING: CPU affinity changed (start: $affinity_start, end: $affinity_end)"
-fi
+assert_success "CPU affinity persisted over time" test "$affinity_start" = "$affinity_end"
 
 stop_stalld
 
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 0a75bb7..32a5a02 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -46,11 +46,7 @@ if [ -n "${tracked_pid}" ]; then
     initial_prio=$(get_sched_priority ${tracked_pid})
     log "Initial policy: ${initial_policy} (expected: 1=SCHED_FIFO), prio: ${initial_prio}"
 
-    if [ "$initial_policy" = "1" ]; then
-        pass "Initial policy is SCHED_FIFO"
-    else
-        log "⚠ WARNING: Initial policy is ${initial_policy}, not SCHED_FIFO (1)"
-    fi
+    assert_success "Initial policy is SCHED_FIFO" test "$initial_policy" = "1"
 
     # Wait for starvation detection and boosting
     log "Waiting for starvation detection and boost..."
@@ -61,11 +57,7 @@ if [ -n "${tracked_pid}" ]; then
         boosted_policy=$(get_sched_policy ${tracked_pid})
         log "Policy during boost: ${boosted_policy}"
 
-        if [ "$boosted_policy" = "6" ]; then
-            pass "Task boosted to SCHED_DEADLINE (6)"
-        else
-            log "ℹ INFO: Policy is ${boosted_policy} (may be between boost cycles)"
-        fi
+        assert_success "Task boosted to SCHED_DEADLINE (6)" test "$boosted_policy" = "6"
     fi
 
     # Wait for boost duration to complete
@@ -102,11 +94,7 @@ if [ -n "${tracked_pid}" ] && [ -f "/proc/${tracked_pid}/sched" ]; then
 
     if [ "$final_policy" = "1" ]; then
         pass "Policy restored to SCHED_FIFO (1)"
-        if [ "$final_prio" = "$initial_prio" ]; then
-            pass "Priority restored to ${initial_prio}"
-        else
-            log "⚠ INFO: Priority is ${final_prio} (initial was ${initial_prio})"
-        fi
+        assert_success "Priority restored to ${initial_prio}" test "$final_prio" = "$initial_prio"
     else
         log "ℹ INFO: Final policy is ${final_policy} (task may have exited)"
     fi
@@ -153,11 +141,7 @@ if [ -n "${tracked_pid}" ]; then
             final_policy=$(get_sched_policy ${tracked_pid})
             log "Policy after boost: ${final_policy}"
 
-            if [ "$final_policy" = "0" ]; then
-                pass "Policy restored to SCHED_OTHER (0)"
-            else
-                fail "Policy not restored to SCHED_OTHER (got ${final_policy})"
-            fi
+            assert_success "Policy restored to SCHED_OTHER (0)" test "$final_policy" = "0"
         else
             log "⚠ INFO: Task exited before restoration check"
         fi
@@ -199,11 +183,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     sleep 1
 
     # Verify stalld is still running and didn't crash after task exit
-    if assert_process_running "${STALLD_PID}" "stalld still running after task exit"; then
-        pass "stalld handled task exit during boost gracefully"
-    else
-        fail "stalld crashed or exited after task died during boost"
-    fi
+    assert_success "stalld handled task exit during boost gracefully" kill -0 ${STALLD_PID}
 
 else
     log "⚠ WARNING: No boost detected in this test run"
diff --git a/tests/functional/test_cpu_selection.sh b/tests/functional/test_cpu_selection.sh
index ff5b879..11d9c45 100755
--- a/tests/functional/test_cpu_selection.sh
+++ b/tests/functional/test_cpu_selection.sh
@@ -68,11 +68,7 @@ if [ "$num_cpus" -ge 4 ]; then
         cpu2_found=1
     fi
 
-    if [ "$cpu0_found" -eq 1 ] && [ "$cpu2_found" -eq 1 ]; then
-        pass "stalld monitoring CPUs 0 and 2"
-    else
-        fail "stalld not monitoring specified CPUs (0: $cpu0_found, 2: $cpu2_found)"
-    fi
+    assert_success "stalld monitoring CPUs 0 and 2" test "$cpu0_found" -eq 1 -a "$cpu2_found" -eq 1
 
     stop_stalld
 else
@@ -99,11 +95,7 @@ if [ "$num_cpus" -ge 4 ]; then
         cpu2_found=1
     fi
 
-    if [ "$cpu0_found" -eq 1 ] && [ "$cpu1_found" -eq 1 ] && [ "$cpu2_found" -eq 1 ]; then
-        pass "stalld monitoring CPUs 0-2"
-    else
-        fail "stalld not monitoring specified CPU range (0: $cpu0_found, 1: $cpu1_found, 2: $cpu2_found)"
-    fi
+    assert_success "stalld monitoring CPUs 0-2" test "$cpu0_found" -eq 1 -a "$cpu1_found" -eq 1 -a "$cpu2_found" -eq 1
 
     stop_stalld
 else
@@ -124,11 +116,7 @@ if [ "$num_cpus" -ge 6 ]; then
         fi
     done
 
-    if [ "$monitored_cpus" -eq 4 ]; then
-        pass "stalld monitoring combined CPU specification (0,2-4)"
-    else
-        fail "stalld not monitoring all specified CPUs (found $monitored_cpus/4)"
-    fi
+    assert_success "stalld monitoring combined CPU specification (0,2-4)" test "$monitored_cpus" -eq 4
 
     stop_stalld
 else
@@ -148,11 +136,7 @@ if [ "$num_cpus" -ge 2 ]; then
     start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 
     # Check that CPU 1 is NOT being monitored
-    if ! is_cpu_monitored 1; then
-        pass "stalld not monitoring non-selected CPU 1"
-    else
-        fail "stalld appears to be monitoring CPU 1 when only CPU 0 selected"
-    fi
+    assert_success --negate "stalld not monitoring non-selected CPU 1" is_cpu_monitored 1
 
     stop_stalld
 fi
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 51bdc2f..5f10b48 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -41,14 +41,6 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
 
     # Verify SCHED_DEADLINE was used
     assert_log_contains "${STALLD_LOG}" "SCHED_DEADLINE" "SCHED_DEADLINE boosting used (default)"
-
-    # Verify boost happened after threshold
-    # (starvation logged, then boosting)
-    if grep -q "starved" "${STALLD_LOG}"; then
-        pass "Starvation detected before boosting"
-    else
-        log "⚠ WARNING: No starvation message before boost"
-    fi
 else
     fail "No boosting detected"
     log "Log contents:"
@@ -146,11 +138,7 @@ if [ -n "${tracked_pid}" ]; then
 
     # Verify task made progress (context switches increased)
     ctxt_delta=$((ctxt_after - ctxt_before))
-    if [ ${ctxt_delta} -gt 0 ]; then
-        pass "Task made progress during boost (${ctxt_delta} context switches)"
-    else
-        fail "No progress during boost (${ctxt_delta} context switches)"
-    fi
+    assert_success "Task made progress during boost" test ${ctxt_delta} -gt 0
 else
     log "⚠ WARNING: Could not track starved task PID for progress verification"
 fi
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 6df2c9b..a8d3a31 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -131,30 +131,18 @@ log "Multiple detection cycles should have occurred"
 
 # Check if we see accumulating starvation time in logs
 # Task merging means the timestamp is preserved, so duration increases
-if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}" | wc -l | grep -q "[2-9]"; then
-    pass "Multiple starvation reports found"
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
-    log "⚠ WARNING: Not enough starvation reports to verify task merging"
-    log "        (May be due to queue_track backend limitation)"
-    if [ -n "${STALLD_TEST_BACKEND}" ] && [ "${STALLD_TEST_BACKEND}" = "queue_track" ]; then
-        log "        NOTE: queue_track backend has known issues with SCHED_FIFO detection"
-    fi
-fi
+assert_success "Multiple starvation reports found" \
+    test -n "$(grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}" | sed -n '2p')"
+
+# Extract starvation durations from log
+durations=$(grep -oE "starved on CPU ${TEST_CPU} for [0-9]+" "${STALLD_LOG}" | grep -oE "[0-9]+$")
+log "Starvation durations observed: $(echo $durations | tr '\n' ' ')"
+
+# Verify durations are increasing (timestamp preserved = duration accumulates)
+first_duration=$(echo "$durations" | head -1)
+last_duration=$(echo "$durations" | tail -1)
+
+assert_success "Starvation duration increased" test "${last_duration}" -gt "${first_duration}"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -215,14 +203,6 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -N -t $threshold -c ${TEST_CPU} -a $
 log "Waiting for boost detection..."
 if wait_for_boost_detected "${STALLD_LOG}"; then
     pass "Boosting occurred"
-
-    # Try to verify the correct task was boosted
-    # stalld logs should show the blockee task name (starvation_gen thread)
-    if grep "boosted.*starvation_gen" "${STALLD_LOG}"; then
-        pass "starvation_gen task was boosted (likely the blockee)"
-    else
-        log "ℹ INFO: Could not verify specific task from logs"
-    fi
 else
     log "⚠ WARNING: No boosting detected in logs"
     log "        (May be due to queue_track backend limitation)"
diff --git a/tests/functional/test_foreground.sh b/tests/functional/test_foreground.sh
index e07bee3..f5de736 100755
--- a/tests/functional/test_foreground.sh
+++ b/tests/functional/test_foreground.sh
@@ -35,11 +35,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 	else
 		# On modern systems with session leaders, ppid might not be 1
 		# Just verify it's not our shell's PID
-		if [ "${PARENT_PID}" != "$$" ]; then
-			pass "stalld daemonized (parent is not test shell)"
-		else
-			fail "stalld did not daemonize (parent is test shell)"
-		fi
+		assert_success "stalld daemonized (parent is not test shell)" test "${PARENT_PID}" != "$$"
 	fi
 fi
 
@@ -59,11 +55,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running with -f"; th
 
 	# The parent might be the subshell from start_stalld, not directly our shell
 	# So we just verify it's not PID 1
-	if [ "${PARENT_PID}" != "1" ]; then
-		pass "stalld did not daemonize with -f (parent is not init)"
-	else
-		fail "stalld daemonized even with -f flag"
-	fi
+	assert_success "stalld did not daemonize with -f (parent is not init)" test "${PARENT_PID}" != "1"
 fi
 
 stop_stalld
@@ -77,11 +69,7 @@ sleep 2
 if assert_process_running "${STALLD_PID}" "stalld should be running with -v"; then
 	PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
 
-	if [ "${PARENT_PID}" != "1" ]; then
-		pass "-v implies foreground mode"
-	else
-		fail "-v should imply foreground mode"
-	fi
+	assert_success "-v implies foreground mode" test "${PARENT_PID}" != "1"
 fi
 
 stop_stalld
diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index 2ec61af..5a8cc5b 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -149,11 +149,7 @@ start_stalld_with_log "${LOG_FILE}" -f -v -k -s -l -t 5
 
 if assert_process_running "${STALLD_PID}" "stalld with combined logging should be running"; then
 	# Verify verbose output
-	if [ -s "${LOG_FILE}" ]; then
-		pass "combined logging produces output"
-	else
-		fail "no output with combined logging"
-	fi
+	assert_success "combined logging produces output" test -s "${LOG_FILE}"
 fi
 
 stop_stalld
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 4509307..23c60e5 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -34,11 +34,7 @@ for pidfile in /var/run/stalld.pid /run/stalld.pid; do
 
         # Verify PID matches
         pid_from_file=$(cat "$pidfile")
-        if [ "$pid_from_file" = "${STALLD_PID}" ]; then
-            pass "Default pidfile contains correct PID"
-        else
-            fail "Default pidfile PID ($pid_from_file) doesn't match stalld PID (${STALLD_PID})"
-        fi
+        assert_success "Default pidfile contains correct PID" test "$pid_from_file" = "${STALLD_PID}"
         break
     fi
 done
@@ -70,11 +66,7 @@ if [ -f "${custom_pidfile}" ]; then
 
     # Verify content
     pid_from_file=$(cat "${custom_pidfile}")
-    if [ "$pid_from_file" = "${STALLD_PID}" ]; then
-        pass "Custom pidfile contains correct PID ($pid_from_file)"
-    else
-        fail "Custom pidfile PID ($pid_from_file) doesn't match stalld PID (${STALLD_PID})"
-    fi
+    assert_success "Custom pidfile contains correct PID" test "$pid_from_file" = "${STALLD_PID}"
 else
     fail "Custom pidfile not created at ${custom_pidfile}"
 fi
@@ -107,11 +99,7 @@ if [ -f "${tmp_pidfile}" ]; then
     pass "Pidfile created in /tmp directory"
 
     pid_from_file=$(cat "${tmp_pidfile}")
-    if [ "$pid_from_file" = "${STALLD_PID}" ]; then
-        pass "/tmp pidfile contains correct PID"
-    else
-        fail "/tmp pidfile has incorrect PID"
-    fi
+    assert_success "/tmp pidfile contains correct PID" test "$pid_from_file" = "${STALLD_PID}"
 else
     fail "Pidfile not created in /tmp"
 fi
@@ -135,11 +123,7 @@ if [ -f "${fg_pidfile}" ]; then
     pass "Pidfile created in foreground mode"
 
     pid_from_file=$(cat "${fg_pidfile}")
-    if [ "$pid_from_file" = "${STALLD_PID}" ]; then
-        pass "Foreground mode pidfile contains correct PID"
-    else
-        fail "Foreground mode pidfile has incorrect PID"
-    fi
+    assert_success "Foreground mode pidfile contains correct PID" test "$pid_from_file" = "${STALLD_PID}"
 else
     log "⚠ WARNING: Pidfile not created in foreground mode (may be expected)"
 fi
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 1887d13..943503b 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -83,11 +83,7 @@ if [ -n "${tracked_pid}" ]; then
     log "Context switches after 2s: ${ctxt_after}"
 
     ctxt_delta=$((ctxt_after - ctxt_before))
-    if [ ${ctxt_delta} -lt 5 ]; then
-        pass "Context switch count remained low (delta: ${ctxt_delta})"
-    else
-        fail "Context switches increased significantly (delta: ${ctxt_delta})"
-    fi
+    assert_success "Context switch count remained low" test ${ctxt_delta} -lt 5
 else
     log "⚠ WARNING: Could not find starved task PIDs to verify context switches"
 fi
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 3807670..49292aa 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -248,6 +248,38 @@ assert_stalld_rejects() {
 	rm -f "${log}"
 }
 
+# Assert that a command exits successfully (or unsuccessfully with --negate).
+#
+# Without --negate the assertion passes when the command returns zero.
+# With --negate the assertion passes when the command returns non-zero.
+#
+# Usage: assert_success <message> <command> [args...]
+#        assert_success --negate <message> <command> [args...]
+assert_success() {
+	local negate=0
+	if [ "$1" = "--negate" ]; then
+		negate=1
+		shift
+	fi
+	local message=$1
+	shift
+
+	"$@" >/dev/null 2>&1
+	local success=$(( $? == 0 ))
+
+	if [ $negate -eq 1 ]; then
+		success=$((1 - success))
+	fi
+
+	if [ $success -eq 1 ]; then
+		pass "${message}"
+		return 0
+	else
+		fail "${message}"
+		return 1
+	fi
+}
+
 # Record a test pass with a description message.
 #
 # Usage: pass "description"
@@ -1299,7 +1331,7 @@ start_starvation_gen() {
 
 # Export functions for use in tests
 export -f start_test end_test test_section cleanup_scenario find_starved_child
-export -f assert_starvation_detected assert_boost_detected assert_stalld_rejects assert_log_contains
+export -f assert_starvation_detected assert_boost_detected assert_stalld_rejects assert_log_contains assert_success
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
-- 
2.54.0

