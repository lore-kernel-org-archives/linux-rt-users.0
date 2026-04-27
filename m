Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96C37B02D
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288645; cv=none; b=mmZpGetj4VRHwbJyLFjCrMiob/9Ekx8Z0oPKovb3itHoFyrxY360cGJmGF6gAF3OV51fD2u9NHydYaGk+0eGV2yMNhcTjXFnd9BtqBp08adFrU7SPdJy/Ozo6iUsUrpJBJlcuoqHp6Dhku5/Y3aZ++6NWq5ekJvTmeKmWB2/uLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288645; c=relaxed/simple;
	bh=QBOacoEVALTP3ibDS3f54cUigP8u5R4/U45arEIX2po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jw3upXDuFyzqKto/6eDotjhtuYyGR+dog15/BUcQVqOzqHB3GnFPqlcV/x+NGSoznlWHMA2qAHl/m0FyojkGxHNzDpK/BS9fX0vP4HVGW4ZhiXiNt1yToZLyMq59/TPym7/Ues6sfCrOm0pakNkdbhR9bJLCN+I7W6Js71t8J8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHhSdbC9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHhSdbC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1dC6bfNl88coW6eiq/S5e5dO1GXa/KKofak/Qtp2N8=;
	b=YHhSdbC9hAcKlNG/RVa/jan9UDS0IRgMFFfpesZVvq5roUWvFJiOZfzvMcTvkQ6WI7rULN
	QnPG5mGvZtDrIf+UkXIBz5hNZHMwRbOjCmyv/6bkftzhnPUsm5AqqFKOO0lJjbltU0sNh6
	9i1OPsG4q4gCzypw2G3/L4230Roe8uQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-E1m1B1qoMhu0SdIDu9tVvg-1; Mon,
 27 Apr 2026 07:17:18 -0400
X-MC-Unique: E1m1B1qoMhu0SdIDu9tVvg-1
X-Mimecast-MFC-AGG-ID: E1m1B1qoMhu0SdIDu9tVvg_1777288638
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED260180034F;
	Mon, 27 Apr 2026 11:17:17 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDF9C180047F;
	Mon, 27 Apr 2026 11:17:15 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 05/23] tests: Introduce find_starved_child() helper
Date: Mon, 27 Apr 2026 08:16:07 -0300
Message-ID: <20260427111632.24500-6-wander@redhat.com>
In-Reply-To: <20260427111632.24500-1-wander@redhat.com>
References: <20260427111632.24500-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Multiple test scripts duplicate a pattern of using pgrep and a loop to
identify the child process of starvation_gen that is most likely to be
starving. This duplication clutters the tests and is prone to subtle
errors. Notably, test_fifo_priority_starvation.sh contained a logic
gap where it claimed to check for the lower-priority blockee but
simply grabbed the first child process instead.

Introduce a centralized find_starved_child() helper in test_helpers.sh
and export it for use across the test suite. This function reliably
identifies the starving child by selecting the one with the lowest
scheduling priority, determined by finding the highest kernel priority
value exposed in /proc/PID/sched.

Replace twelve instances of the duplicated search pattern across six
different test files with the new helper. This refactoring resolves
the logic gap in the FIFO priority starvation test and improves test
maintainability while reducing the overall line count.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_boost_restoration.sh    |  9 +---
 tests/functional/test_deadline_boosting.sh    | 51 ++++++-------------
 tests/functional/test_fifo_boosting.sh        | 45 +++++-----------
 .../test_fifo_priority_starvation.sh          | 11 +---
 tests/functional/test_starvation_detection.sh | 41 ++++++---------
 tests/functional/test_task_merging.sh         | 23 ++-------
 tests/helpers/test_helpers.sh                 | 30 ++++++++++-
 7 files changed, 79 insertions(+), 131 deletions(-)

diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 5dcaeea..fb886bd 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -64,14 +64,7 @@ log "Creating starvation with SCHED_FIFO tasks (blocker prio 80, blockee prio 1)
 start_starvation_gen -c ${TEST_CPU} -p 80 -b 1 -n 1 -d 20
 
 # Find the starved task
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-tracked_pid=""
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/sched" ]; then
-        tracked_pid=${child_pid}
-        break
-    fi
-done
+tracked_pid=$(find_starved_child "${STARVE_PID}")
 
 if [ -n "${tracked_pid}" ]; then
     log "Tracking task PID ${tracked_pid}"
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 12bbd3e..d05daf2 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -114,28 +114,22 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
 
+# Try to find the boosted task PID before it gets boosted
+tracked_pid=$(find_starved_child "${STARVE_PID}")
+
 # Wait for boosting
 log "Waiting for boost detection..."
 wait_for_boost_detected "${STALLD_LOG}"
-
-# Try to find the boosted task PID
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-log "Starvation generator children PIDs: ${STARVE_CHILDREN}"
-
 boosted_task_found=0
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/sched" ]; then
-        policy=$(get_sched_policy ${child_pid})
-        log "Child PID ${child_pid} policy: ${policy}"
-
-        # Policy 6 = SCHED_DEADLINE
-        if [ "$policy" = "6" ]; then
-            pass "Task PID ${child_pid} boosted to SCHED_DEADLINE (policy 6)"
-            boosted_task_found=1
-            break
-        fi
+if [ -n "${tracked_pid}" ] && [ -f "/proc/${tracked_pid}/sched" ]; then
+    policy=$(get_sched_policy ${tracked_pid})
+    log "Child PID ${tracked_pid} policy: ${policy}"
+
+    if [ "$policy" = "6" ]; then
+        pass "Task PID ${tracked_pid} boosted to SCHED_DEADLINE (policy 6)"
+        boosted_task_found=1
     fi
-done
+fi
 
 if [ ${boosted_task_found} -eq 0 ]; then
     log "⚠ INFO: Could not verify DEADLINE policy in /proc (timing issue or boost already expired)"
@@ -166,20 +160,12 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
+# Find a starved task before it gets boosted
+tracked_pid=$(find_starved_child "${STARVE_PID}")
+
 # Wait for boosting
 log "Waiting for boost detection..."
 wait_for_boost_detected "${STALLD_LOG}"
-
-# Find a starved task
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-tracked_pid=""
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/status" ]; then
-        tracked_pid=${child_pid}
-        break
-    fi
-done
-
 if [ -n "${tracked_pid}" ]; then
     log "Tracking task PID ${tracked_pid}"
 
@@ -234,14 +220,7 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
 # Find a starved task and verify initial policy
 sleep 2
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-tracked_pid=""
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/sched" ]; then
-        tracked_pid=${child_pid}
-        break
-    fi
-done
+tracked_pid=$(find_starved_child "${STARVE_PID}")
 
 if [ -n "${tracked_pid}" ]; then
     log "Tracking task PID ${tracked_pid} for policy changes"
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index ceac769..a669fe4 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -91,8 +91,7 @@ rm -f "${STALLD_LOG}"
 # Create starvation FIRST
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-log "Starvation generator children PIDs: ${STARVE_CHILDREN}"
+tracked_pid=$(find_starved_child "${STARVE_PID}")
 
 log "Starting stalld with -F flag (FIFO boosting)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
@@ -102,21 +101,17 @@ log "Waiting for boost detection..."
 wait_for_boost_detected "${STALLD_LOG}"
 
 fifo_task_found=0
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/sched" ]; then
-        policy=$(get_sched_policy ${child_pid})
-        log "Child PID ${child_pid} policy: ${policy} (1=SCHED_FIFO)"
-
-        # Policy 1 = SCHED_FIFO
-        if [ "$policy" = "1" ]; then
-            priority=$(get_sched_priority ${child_pid})
-            pass "Task PID ${child_pid} boosted to SCHED_FIFO (policy 1)"
-            log "        Priority: ${priority}"
-            fifo_task_found=1
-            break
-        fi
+if [ -n "${tracked_pid}" ] && [ -f "/proc/${tracked_pid}/sched" ]; then
+    policy=$(get_sched_policy ${tracked_pid})
+    log "Child PID ${tracked_pid} policy: ${policy} (1=SCHED_FIFO)"
+
+    if [ "$policy" = "1" ]; then
+        priority=$(get_sched_priority ${tracked_pid})
+        pass "Task PID ${tracked_pid} boosted to SCHED_FIFO (policy 1)"
+        log "        Priority: ${priority}"
+        fifo_task_found=1
     fi
-done
+fi
 
 if [ ${fifo_task_found} -eq 0 ]; then
     log "⚠ INFO: Could not verify FIFO policy in /proc (timing issue or boost already expired)"
@@ -196,14 +191,7 @@ CLEANUP_FILES+=("${STALLD_LOG_DEADLINE}")
 
 # Create starvation FIRST
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 15
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-deadline_tracked_pid=""
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/status" ]; then
-        deadline_tracked_pid=${child_pid}
-        break
-    fi
-done
+deadline_tracked_pid=$(find_starved_child "${STARVE_PID}")
 
 ctxt_before_deadline=0
 if [ -n "${deadline_tracked_pid}" ]; then
@@ -239,14 +227,7 @@ CLEANUP_FILES+=("${STALLD_LOG_FIFO}")
 
 # Create starvation FIRST
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 15
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-fifo_tracked_pid=""
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/status" ]; then
-        fifo_tracked_pid=${child_pid}
-        break
-    fi
-done
+fifo_tracked_pid=$(find_starved_child "${STARVE_PID}")
 
 ctxt_before_fifo=0
 if [ -n "${fifo_tracked_pid}" ]; then
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index bf3bfc8..11bcf33 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -107,16 +107,7 @@ log "Creating FIFO-on-FIFO starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 1 -d 20
 
 # Find the starved task (blockee) PID
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-blockee_pid=""
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/status" ]; then
-        # Check if it's the lower priority task (blockee)
-        # The blockee should have lower priority than blocker
-        blockee_pid=${child_pid}
-        break
-    fi
-done
+blockee_pid=$(find_starved_child "${STARVE_PID}")
 
 ctxt_before=0
 if [ -n "${blockee_pid}" ]; then
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 3307edb..553a7bc 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -116,31 +116,22 @@ log "Waiting for starvation detection..."
 wait_for_starvation_detected "${STALLD_LOG}"
 
 # Try to find the starved task PID from starvation_gen children
-# The blockee thread is what gets starved
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-if [ -n "${STARVE_CHILDREN}" ]; then
-    # Get context switch count for one of the starved tasks
-    for child_pid in ${STARVE_CHILDREN}; do
-        if [ -f "/proc/${child_pid}/status" ]; then
-            ctxt_before=$(get_ctxt_switches ${child_pid})
-            log "Found starved task PID ${child_pid}, context switches: ${ctxt_before}"
-
-            # Wait a bit
-            sleep 2
-
-            # Check context switches again - should be same or very low change
-            ctxt_after=$(get_ctxt_switches ${child_pid})
-            log "Context switches after 2s: ${ctxt_after}"
-
-            ctxt_delta=$((ctxt_after - ctxt_before))
-            if [ ${ctxt_delta} -lt 5 ]; then
-                pass "Context switch count remained low (delta: ${ctxt_delta})"
-            else
-                fail "Context switches increased significantly (delta: ${ctxt_delta})"
-            fi
-            break
-        fi
-    done
+tracked_pid=$(find_starved_child "${STARVE_PID}")
+if [ -n "${tracked_pid}" ]; then
+    ctxt_before=$(get_ctxt_switches ${tracked_pid})
+    log "Found starved task PID ${tracked_pid}, context switches: ${ctxt_before}"
+
+    sleep 2
+
+    ctxt_after=$(get_ctxt_switches ${tracked_pid})
+    log "Context switches after 2s: ${ctxt_after}"
+
+    ctxt_delta=$((ctxt_after - ctxt_before))
+    if [ ${ctxt_delta} -lt 5 ]; then
+        pass "Context switch count remained low (delta: ${ctxt_delta})"
+    else
+        fail "Context switches increased significantly (delta: ${ctxt_delta})"
+    fi
 else
     log "⚠ WARNING: Could not find starved task PIDs to verify context switches"
 fi
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 366b89b..c49499c 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -144,14 +144,7 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 wait_for_starvation_detected "${STALLD_LOG}"
 
 # Find the starved task PID
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-tracked_pid=""
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/status" ]; then
-        tracked_pid=${child_pid}
-        break
-    fi
-done
+tracked_pid=$(find_starved_child "${STARVE_PID}")
 
 if [ -n "${tracked_pid}" ]; then
     log "Tracking starved task PID ${tracked_pid}"
@@ -208,19 +201,11 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a
 log "Creating starvation that will be boosted"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
+# Find tracked task while it's guaranteed to be starving
+tracked_pid=$(find_starved_child "${STARVE_PID}")
+
 # Wait for starvation detection
 wait_for_starvation_detected "${STALLD_LOG}"
-
-# Find tracked task
-STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
-tracked_pid=""
-for child_pid in ${STARVE_CHILDREN}; do
-    if [ -f "/proc/${child_pid}/status" ]; then
-        tracked_pid=${child_pid}
-        break
-    fi
-done
-
 if [ -n "${tracked_pid}" ]; then
     # Wait for boost to complete and task to starve again
     sleep 5
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index fb6c9d1..ced067c 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -126,6 +126,34 @@ cleanup_scenario() {
 	stop_stalld
 }
 
+# Find the child of a starvation_gen process most likely to be starving.
+# When multiple children exist, selects the one with the lowest scheduling
+# priority (highest kernel prio value) since that task loses the CPU to
+# higher-priority siblings.
+# Usage: tracked_pid=$(find_starved_child <parent_pid>)
+find_starved_child() {
+	local parent_pid=$1
+	local candidate=""
+	local max_prio=-100
+	local prio
+	for child in $(pgrep -P "${parent_pid}" 2>/dev/null); do
+		if [ -d "/proc/${child}" ]; then
+			prio=$(get_sched_priority "${child}" 2>/dev/null)
+			prio=${prio:--1}
+			if [ "${prio}" -gt "${max_prio}" ] 2>/dev/null; then
+				candidate="${child}"
+				max_prio="${prio}"
+			fi
+		fi
+	done
+
+	if [ -n "${candidate}" ]; then
+		echo "${candidate}"
+		return 0
+	fi
+	return 1
+}
+
 # Assert that stalld detects a starving task within the timeout.
 # Usage: assert_starvation_detected <log_file> <message> [timeout] [cpu]
 assert_starvation_detected() {
@@ -1187,7 +1215,7 @@ start_starvation_gen() {
 }
 
 # Export functions for use in tests
-export -f start_test end_test test_section cleanup_scenario assert_starvation_detected assert_boost_detected
+export -f start_test end_test test_section cleanup_scenario find_starved_child assert_starvation_detected assert_boost_detected
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
-- 
2.53.0

