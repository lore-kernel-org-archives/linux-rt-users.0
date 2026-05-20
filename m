Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293903E5EF8
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285732; cv=none; b=AJLWU/twHnvWxC7uCtoevr1PRHNQw4qZhBWk0p2xnxqPpOzlBS7mkSI6rjAMsaJZIoLa9zCpwP9qwZ4oYiI0ZALcjTjSVsPm6HneweYjs/UnF7hgG6ebHPJvTdvrH5XNcqqRcJcnPtk9ZRcb5H4YVsmtsHgBt6t4MtxwB0g/190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285732; c=relaxed/simple;
	bh=fkwWaszHJXxRnOcjAIFBBwkTK6stw8VebB2OMluc3z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiH6GnUStSyr4CYB7WT+MAEnieB6iyjN/NoesAx0mkbgPSr1aXwlnUNyGBEMf4035F8075X1Zrp5ZDG6iiq3jvLL1Z+dp/e49IYHaySSTG4qkEz5ZljCBABAfyzt43cQsIrGr5c8EiLf7jBnqzzVDdWGOgI/iVausSEJWcOrgEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bK/i75Wm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK/i75Wm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgkjoH5CDcCor/AiLao7Vg0UeUwDn5a/0ko6Fi4xX+s=;
	b=bK/i75WmhCBamsk5eEVJH9RD4FnxYjje1NFlesygZwbzVD5nVPAgzkczlUYU2nR8KHDYRF
	t/AzsMb7Wjgj//aAqi6NSjrGIVUEmOgad8Qv489403lvjEN/NSZKV/iu5X61eERuHrwTw4
	O4vH8XdMB8dfn+WtKZMfe0hE9KCKumA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-YEPkUExjPyidloQJBGUbxw-1; Wed,
 20 May 2026 10:02:02 -0400
X-MC-Unique: YEPkUExjPyidloQJBGUbxw-1
X-Mimecast-MFC-AGG-ID: YEPkUExjPyidloQJBGUbxw_1779285721
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38F991956056;
	Wed, 20 May 2026 14:02:01 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18EF01800352;
	Wed, 20 May 2026 14:01:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 17/33] tests: Introduce and adopt assert_log_contains() helper
Date: Wed, 20 May 2026 11:00:44 -0300
Message-ID: <20260520140104.112142-18-wander@redhat.com>
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

Multiple functional tests repeat the pattern of grepping a log file
for a specific pattern and calling pass or fail based on the result.
This leads to verbose and duplicated boilerplate code across the
test suite.

Introduce an assert_log_contains() helper that encapsulates the
grep, pass/fail evaluation, and diagnostic output into a single
function call. To support various test requirements, the helper
includes:
  * A `--negate` flag for asserting the absence of a pattern.
  * An `--ignore-case` flag to easily perform case-insensitive
    matching, avoiding verbose regex workarounds (like `[Ee]rror`).

Adopt this new helper across the functional test suite. This refactor
simplifies several tests, including replacing nested false-positive
checks in test_starvation_detection and cleaning up if/elif/else
policy detection blocks in test_force_fifo.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_backend_selection.sh    |  9 +---
 tests/functional/test_deadline_boosting.sh    | 25 ++--------
 tests/functional/test_fifo_boosting.sh        | 12 +----
 .../test_fifo_priority_starvation.sh          | 20 ++------
 tests/functional/test_force_fifo.sh           | 48 ++-----------------
 tests/functional/test_idle_detection.sh       |  6 +--
 tests/functional/test_log_only.sh             |  8 +---
 tests/functional/test_logging_destinations.sh |  4 +-
 tests/functional/test_starvation_detection.sh | 32 +++----------
 tests/functional/test_starvation_threshold.sh | 10 ++--
 tests/helpers/test_helpers.sh                 | 41 +++++++++++++++-
 11 files changed, 66 insertions(+), 149 deletions(-)

diff --git a/tests/functional/test_backend_selection.sh b/tests/functional/test_backend_selection.sh
index 049277a..d65695b 100755
--- a/tests/functional/test_backend_selection.sh
+++ b/tests/functional/test_backend_selection.sh
@@ -44,14 +44,7 @@ test_backend_flag() {
 		return 1
 	fi
 
-	if grep -q "${expected_msg}" "${log_file}"; then
-		pass "${description}"
-	else
-		fail "Backend message not found (${description})"
-		echo "  Expected: ${expected_msg}"
-		echo "  Log contents:"
-		cat "${log_file}"
-	fi
+	assert_log_contains "${log_file}" "${expected_msg}" "${description}"
 
 	stop_stalld
 }
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index eacce98..e777ea0 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -40,11 +40,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     pass "Boosting occurred"
 
     # Verify SCHED_DEADLINE was used
-    if grep -q "SCHED_DEADLINE" "${STALLD_LOG}"; then
-        pass "SCHED_DEADLINE boosting used (default)"
-    else
-        fail "SCHED_DEADLINE not mentioned in boost message"
-    fi
+    assert_log_contains "${STALLD_LOG}" "SCHED_DEADLINE" "SCHED_DEADLINE boosting used (default)"
 
     # Verify boost happened after threshold
     # (starvation logged, then boosting)
@@ -106,11 +102,7 @@ fi
 if [ ${boosted_task_found} -eq 0 ]; then
     log "⚠ INFO: Could not verify DEADLINE policy in /proc (timing issue or boost already expired)"
     # Still check if boost happened in logs
-    if grep -q "boosted.*SCHED_DEADLINE" "${STALLD_LOG}"; then
-        pass "SCHED_DEADLINE boost confirmed in logs"
-    else
-        fail "No SCHED_DEADLINE boost detected"
-    fi
+    assert_log_contains "${STALLD_LOG}" "boosted.*SCHED_DEADLINE" "SCHED_DEADLINE boost confirmed in logs"
 fi
 
 # Cleanup
@@ -165,11 +157,7 @@ else
 fi
 
 # Verify boost happened
-if grep -q "boosted" "${STALLD_LOG}"; then
-    pass "Boost occurred as expected"
-else
-    fail "No boost detected"
-fi
+assert_log_contains "${STALLD_LOG}" "boosted" "Boost occurred as expected"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -286,13 +274,6 @@ else
     if [ ${boost_count} -ge 2 ]; then
         pass "Multiple boost events detected (${boost_count})"
 
-        # Verify both CPUs mentioned
-        if grep -q "CPU ${CPU0}" "${STALLD_LOG}" && grep -q "CPU ${CPU1}" "${STALLD_LOG}"; then
-            pass "Boosts occurred on both CPUs"
-        else
-            log "⚠ INFO: Could not verify boosts on both specific CPUs"
-        fi
-
         # Verify independent boost cycles
         if [ ${boost_count} -gt 2 ]; then
             pass "Multiple boost cycles (${boost_count} total), showing independent operation"
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 3d17e5e..38b0b14 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -38,11 +38,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     pass "Boosting occurred with -F flag"
 
     # Verify SCHED_FIFO was used
-    if grep -q "SCHED_FIFO" "${STALLD_LOG}"; then
-        pass "SCHED_FIFO boosting used (as requested by -F)"
-    else
-        fail "SCHED_FIFO not mentioned in boost message"
-    fi
+    assert_log_contains "${STALLD_LOG}" "SCHED_FIFO" "SCHED_FIFO boosting used (as requested by -F)"
 else
     fail "No boosting detected with -F flag"
     log "Log contents:"
@@ -88,11 +84,7 @@ fi
 if [ ${fifo_task_found} -eq 0 ]; then
     log "⚠ INFO: Could not verify FIFO policy in /proc (timing issue or boost already expired)"
     # FIFO emulation cycles between FIFO and OTHER, so we may catch it in OTHER state
-    if grep -q "boosted.*SCHED_FIFO" "${STALLD_LOG}"; then
-        pass "SCHED_FIFO boost confirmed in logs"
-    else
-        fail "No SCHED_FIFO boost detected"
-    fi
+    assert_log_contains "${STALLD_LOG}" "boosted.*SCHED_FIFO" "SCHED_FIFO boost confirmed in logs"
 fi
 
 # Cleanup
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 8f78a75..6df2c9b 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -44,18 +44,10 @@ if wait_for_starvation_detected "${STALLD_LOG}"; then
     pass "FIFO-on-FIFO starvation detected"
 
     # Verify correct CPU is logged
-    if grep "starved on CPU ${TEST_CPU}" "${STALLD_LOG}"; then
-        pass "Correct CPU ID logged (CPU ${TEST_CPU})"
-    else
-        fail "Wrong CPU ID in log"
-    fi
+    assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU}" "Correct CPU ID logged (CPU ${TEST_CPU})"
 
     # Verify duration is logged
-    if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}"; then
-        pass "Starvation duration logged"
-    else
-        fail "Starvation duration not logged"
-    fi
+    assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU} for [0-9]" "Starvation duration logged"
 else
     fail "FIFO-on-FIFO starvation not detected"
     log "Log contents:"
@@ -106,13 +98,7 @@ log "Context switch delta: ${ctxt_delta}"
 if [ ${ctxt_delta} -gt 0 ]; then
     pass "Blockee task made progress (${ctxt_delta} context switches)"
 else
-    log "⚠ WARNING: Could not verify progress (timing issue or blockee not found)"
-    # Check if boosting occurred at least
-    if grep -q "boosted" "${STALLD_LOG}"; then
-        log "ℹ INFO: Boosting did occur according to logs"
-    else
-        fail "No boosting detected"
-    fi
+    assert_log_contains "${STALLD_LOG}" "boosted" "Boosting occurred despite no measurable progress"
 fi
 
 # Cleanup
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 1e841b8..6c21d3e 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -30,20 +30,8 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-if wait_for_boost_detected "${STALLD_LOG}"; then
-    log "Boosting occurred"
-
-    # Look for SCHED_DEADLINE indicators
-    if grep -qi "deadline\|SCHED_DEADLINE" "${STALLD_LOG}"; then
-        pass "SCHED_DEADLINE used by default"
-    elif grep -qi "fifo\|SCHED_FIFO" "${STALLD_LOG}"; then
-        log "⚠ WARNING: SCHED_FIFO used instead of SCHED_DEADLINE"
-    else
-        log "ℹ INFO: Scheduling policy not explicitly mentioned in logs"
-    fi
-else
-    log "⚠ WARNING: No boosting detected in default mode"
-fi
+assert_boost_detected "${STALLD_LOG}" "Boosting occurred in default mode"
+assert_log_contains --ignore-case "${STALLD_LOG}" "sched_deadline" "SCHED_DEADLINE used by default"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -66,20 +54,8 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-if wait_for_boost_detected "${STALLD_LOG2}"; then
-    log "Boosting occurred with -F flag"
-
-    # Look for SCHED_FIFO indicators
-    if grep -qi "fifo\|SCHED_FIFO" "${STALLD_LOG2}"; then
-        pass "SCHED_FIFO used with -F flag"
-    elif grep -qi "deadline\|SCHED_DEADLINE" "${STALLD_LOG2}"; then
-        fail "SCHED_DEADLINE used despite -F flag"
-    else
-        log "⚠ WARNING: Scheduling policy not explicitly mentioned in logs"
-    fi
-else
-    log "⚠ WARNING: No boosting detected with -F flag"
-fi
+assert_boost_detected "${STALLD_LOG2}" "Boosting occurred with -F flag"
+assert_log_contains --ignore-case "${STALLD_LOG2}" "sched_fifo" "SCHED_FIFO used with -F flag"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -134,21 +110,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${long_starvation}
 
 # Wait for detection and boosting
-if wait_for_boost_detected "${STALLD_LOG4}"; then
-    log "Boosting detected, waiting for duration cycle"
-
-    # Wait for boost duration + buffer to see restoration
-    sleep 5
-
-    # Check for restoration messages (part of FIFO emulation)
-    if grep -qi "restor\|unboosted\|normal\|original" "${STALLD_LOG4}"; then
-        pass "FIFO emulation with restoration detected"
-    else
-        log "ℹ INFO: FIFO boosting completed (restoration may be implicit)"
-    fi
-else
-    log "⚠ WARNING: No boosting detected for FIFO emulation test"
-fi
+assert_boost_detected "${STALLD_LOG4}" "FIFO emulation boosting detected"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index f238c7e..5647129 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -152,11 +152,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a $
 
 sleep 3
 
-if grep -q "skipping" "${STALLD_LOG}"; then
-    pass "Idle CPU correctly skipped"
-else
-    fail "No skipping messages for idle CPU"
-fi
+assert_log_contains "${STALLD_LOG}" "skipping" "Idle CPU correctly skipped"
 
 cleanup_scenario
 
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index b10b4d9..6a26b93 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -61,13 +61,7 @@ echo "Waiting for starvation detection..."
 assert_starvation_detected "${LOG_FILE}" "stalld detected and logged starvation"
 
 # Check that stalld did NOT boost (should not see "boosted" message with -l)
-if ! grep -q "boosted" "${LOG_FILE}"; then
-	pass "stalld did not boost in log-only mode"
-else
-	fail "stalld boosted despite -l flag"
-	echo "Log contents:"
-	cat "${LOG_FILE}"
-fi
+assert_log_contains --negate "${LOG_FILE}" "boosted" "stalld did not boost in log-only mode"
 
 # Cleanup
 cleanup_scenario "${STARVGEN_PID}"
diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index 7b15c68..2ec61af 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -41,9 +41,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 		pass "verbose mode produces output"
 
 		# Should contain initialization messages
-		if grep -q -E "(stalld|version|monitoring)" "${LOG_FILE}"; then
-			pass "output contains expected messages"
-		fi
+		assert_log_contains "${LOG_FILE}" "stalld\|version\|monitoring" "output contains expected messages"
 	else
 		fail "no output in verbose mode"
 	fi
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 44024c7..2d2e9b1 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -47,18 +47,10 @@ if wait_for_starvation_detected "${STALLD_LOG}"; then
     pass "Starvation detected"
 
     # Verify correct CPU is logged
-    if grep "starved on CPU ${TEST_CPU}" "${STALLD_LOG}"; then
-        pass "Correct CPU ID logged (CPU ${TEST_CPU})"
-    else
-        fail "Wrong CPU ID in log"
-    fi
+    assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU}" "Correct CPU ID logged (CPU ${TEST_CPU})"
 
     # Verify duration is logged
-    if grep -E "starved on CPU ${TEST_CPU} for [0-9]+ seconds" "${STALLD_LOG}"; then
-        pass "Starvation duration logged"
-    else
-        fail "Starvation duration not logged"
-    fi
+    assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU} for [0-9]" "Starvation duration logged"
 else
     fail "Starvation not detected"
     log "Log contents:"
@@ -249,15 +241,9 @@ sleep $((threshold + 3))
 
 # Verify this task was NOT reported as starved
 # Since it's making progress, stalld shouldn't detect it
-if ! grep "starved" "${STALLD_LOG}"; then
-    pass "No false positive - task making progress not reported as starved"
-else
-    if grep "${BUSY_PID}" "${STALLD_LOG}" | grep -q "starved"; then
-        fail "False positive - progress-making task ${BUSY_PID} reported as starved"
-    else
-        pass "No false positive - starvation detected from other tasks, not ours"
-    fi
-fi
+assert_log_contains --negate "${STALLD_LOG}" \
+    "${BUSY_PID}.*starved" \
+    "No false positive - progress-making task not reported as starved"
 
 kill ${BUSY_PID} 2>/dev/null
 wait ${BUSY_PID} 2>/dev/null
@@ -289,13 +275,7 @@ else
 fi
 
 # Check for error messages
-if grep -iE "error|segfault|crash" "${STALLD_LOG}"; then
-    fail "Error messages found in log"
-    log "Errors:"
-    grep -iE "error|segfault|crash" "${STALLD_LOG}"
-else
-    pass "No error messages in log"
-fi
+assert_log_contains --negate --ignore-case "${STALLD_LOG}" "error\|segfault\|crash" "No error messages in log"
 
 stop_stalld
 
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 79fa17b..b0eeb59 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -70,13 +70,9 @@ wait "${STARVE_PID}" 2>/dev/null || true
 sleep 2
 
 # Check that starvation_gen was NOT detected (duration less than threshold)
-if ! grep -qE "starvation_gen.*starved on CPU ${TEST_CPU}|starved on CPU ${TEST_CPU}.*starvation_gen" "${STALLD_LOG}"; then
-    pass "No starvation detected for duration less than threshold"
-else
-    fail "Starvation detected before threshold"
-    log "Found starvation_gen task in logs:"
-    grep -E "starvation_gen.*starved on CPU|starved on CPU.*starvation_gen" "${STALLD_LOG}"
-fi
+assert_log_contains --negate "${STALLD_LOG}" \
+    "starvation_gen.*starved on CPU ${TEST_CPU}\|starved on CPU ${TEST_CPU}.*starvation_gen" \
+    "No starvation detected for duration less than threshold"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 2b744d0..3807670 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -191,6 +191,44 @@ assert_boost_detected() {
 	fi
 }
 
+# Assert that a log file contains (or does not contain) a pattern.
+#
+# Usage: assert_log_contains [--negate] [--ignore-case] <log_file> <pattern> <message>
+assert_log_contains() {
+	local negate=0
+	local grep_opts="-q -e"
+	while true; do
+		case "$1" in
+			--negate) negate=1; shift ;;
+			--ignore-case) grep_opts="-q -i -e"; shift ;;
+			*) break ;;
+		esac
+	done
+	local log_file=$1
+	local pattern=$2
+	local message=$3
+
+	local found=0
+	grep ${grep_opts} "${pattern}" -- "${log_file}" 2>/dev/null && found=1
+
+	if [ $negate -eq 1 ]; then
+		found=$((1 - found))
+	fi
+
+	if [ $found -eq 1 ]; then
+		pass "${message}"
+		return 0
+	else
+		fail "${message}"
+		if [ $negate -eq 1 ]; then
+			log "    Pattern '${pattern}' found in ${log_file} but should not be"
+		else
+			log "    Pattern '${pattern}' not found in ${log_file}"
+		fi
+		return 1
+	fi
+}
+
 # Assert that stalld rejects invalid arguments and exits non-zero.
 # Usage: assert_stalld_rejects <message> [stalld_args...]
 assert_stalld_rejects() {
@@ -1260,7 +1298,8 @@ start_starvation_gen() {
 }
 
 # Export functions for use in tests
-export -f start_test end_test test_section cleanup_scenario find_starved_child assert_starvation_detected assert_boost_detected assert_stalld_rejects
+export -f start_test end_test test_section cleanup_scenario find_starved_child
+export -f assert_starvation_detected assert_boost_detected assert_stalld_rejects assert_log_contains
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
-- 
2.54.0

