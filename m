Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB0136B055
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285697; cv=none; b=BKUxZdxleJVJIvAgi821QRrbPs3tj6RcYi8fLKOtykFs/77HVnf39oB+0G3vHeQuFyS17m+mlTDvai5Wmc8Z5DC2QsZPQhR5QysVTzQRBHpISGcxqnQRCn1k3Y8WQ2N9SIFrKCGQ/y+w5eBj7nqzWTDZtny9kByLsmJbQNMdk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285697; c=relaxed/simple;
	bh=5EKfnBdzMAXt9kiD9S0f03CdBArMx8XTBrcg1wlemYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxrpR6a2kuAkwnds8zUgyLSxY0X9LwoIT/nsEyLIHyW6wPwO6U/pz3+qHKZwtleBUWAAAi0B6I4EwMnUNKEKTGqezuMRc1SwxFVBqzKw9Un+25cIMwLCdNEpS+KNTsXHT6OQTTKth+4e4478PNz5QWtkKHR5fz8t+PwPREbqAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWZ2FmaN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWZ2FmaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=490bEf/83gS/oDMRQ0ChAP14dgKoRuftqec/bgX2CkU=;
	b=hWZ2FmaN5zBG2dFrkh0MeMz5FQyH8/4IhyhQcJy4EnuGcq/740JSJ6YmXGs51l0YlGUwdO
	yNG82BfrQkQZ+GjDPWbHm8LHZ0Rf/ngKGqdDgbtIPxV7zhD52kZ0wMJoTmnrmOe77zP/ge
	9BaqC9LldmSQ2IKDlvHQ4LwYzmBmQlc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-beT5wY1TPH68kqLgOU50mQ-1; Wed,
 20 May 2026 10:01:27 -0400
X-MC-Unique: beT5wY1TPH68kqLgOU50mQ-1
X-Mimecast-MFC-AGG-ID: beT5wY1TPH68kqLgOU50mQ_1779285684
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6FD8195606E;
	Wed, 20 May 2026 14:01:23 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B03E1800352;
	Wed, 20 May 2026 14:01:20 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 03/33] tests: Introduce cleanup_scenario() helper
Date: Wed, 20 May 2026 11:00:30 -0300
Message-ID: <20260520140104.112142-4-wander@redhat.com>
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

Functional tests currently duplicate boilerplate code to terminate
background processes and stop the stalld daemon between test scenarios.
This repetition clutters the test files and occasionally leads to
errors, such as missing wait calls after sending termination signals.

Introduce a variadic cleanup_scenario() helper function in the test
helpers script to consolidate this teardown logic. The function accepts
an arbitrary number of process IDs, safely terminates each one, waits
for them to exit, and then stops the stalld daemon. It is exported via
export -f to ensure availability within subshells.

Applying this helper across the functional test suite removes redundant
cleanup sequences and resolves missing wait calls in the boost
restoration tests.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_boost_duration.sh       | 16 ++++---------
 tests/functional/test_boost_period.sh         | 16 ++++---------
 tests/functional/test_boost_restoration.sh    | 17 ++++---------
 tests/functional/test_boost_runtime.sh        | 16 ++++---------
 tests/functional/test_deadline_boosting.sh    | 22 ++++-------------
 tests/functional/test_fifo_boosting.sh        | 20 ++++------------
 .../test_fifo_priority_starvation.sh          | 20 ++++------------
 tests/functional/test_force_fifo.sh           | 24 +++++--------------
 tests/functional/test_idle_detection.sh       |  8 ++-----
 tests/functional/test_log_only.sh             |  4 +---
 tests/functional/test_runqueue_parsing.sh     | 24 +++++--------------
 tests/functional/test_starvation_detection.sh | 17 ++++---------
 tests/functional/test_starvation_threshold.sh | 12 +++-------
 tests/functional/test_task_merging.sh         | 18 ++++----------
 tests/helpers/test_helpers.sh                 | 14 ++++++++++-
 15 files changed, 71 insertions(+), 177 deletions(-)

diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index d677da8..9a4c11c 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -70,9 +70,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null || true
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Short duration (1 second)
@@ -98,9 +96,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null || true
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Long duration (10 seconds)
@@ -128,9 +124,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null || true
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Verify task policy is restored after boost duration
@@ -157,9 +151,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null || true
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 5: Invalid duration values
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index 534879f..d7cb75f 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -74,9 +74,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null || true
-wait ${STARVE_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Custom period (500ms = 500,000,000 ns)
@@ -100,9 +98,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null || true
-wait ${STARVE_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Very short period (100ms = 100,000,000 ns)
@@ -126,9 +122,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null || true
-wait ${STARVE_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Very long period (10s = 10,000,000,000 ns)
@@ -152,9 +146,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null || true
-wait ${STARVE_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 5: Invalid period (0)
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 0a77945..5dcaeea 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -150,8 +150,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Restore Original RT Policy (SCHED_FIFO)
@@ -261,8 +260,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${BLOCKER_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${BLOCKER_PID}"
 
 #=============================================================================
 # Test 3: SCHED_OTHER Policy Restoration
@@ -289,8 +287,7 @@ wait ${STARVE_PID} 2>/dev/null || true
 # The starvation_gen output will show if blockees completed
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Restoration Timing Verification
@@ -338,9 +335,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null || true
-wait ${STARVE_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 # Give stalld time to fully exit before next test
 sleep 1
@@ -392,9 +387,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null || true
-wait ${STARVE_PID} 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Final Summary
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index bf22250..d8dba70 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -70,9 +70,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null || true
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Custom runtime (10,000 ns = 10 microseconds, less than default)
@@ -98,9 +96,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null || true
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Larger runtime (100,000 ns = 100 microseconds)
@@ -126,9 +122,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null || true
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Runtime < period (valid configuration)
@@ -156,9 +150,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null || true
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 5: Runtime > period (should error or be rejected)
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 3fd93c7..12bbd3e 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -88,9 +88,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: DEADLINE Parameters Verification
@@ -150,9 +148,7 @@ if [ ${boosted_task_found} -eq 0 ]; then
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Task Makes Progress During Boost
@@ -218,9 +214,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Policy Restoration After Boost
@@ -296,9 +290,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 5: Multiple Simultaneous Boosts
@@ -360,11 +352,7 @@ else
     fi
 
     # Cleanup
-    kill -TERM ${STARVE_PID0} 2>/dev/null
-    kill -TERM ${STARVE_PID1} 2>/dev/null
-    wait ${STARVE_PID0} 2>/dev/null
-    wait ${STARVE_PID1} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID0}" "${STARVE_PID1}"
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index d1b65fb..ceac769 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -78,9 +78,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: FIFO Priority Verification
@@ -131,9 +129,7 @@ if [ ${fifo_task_found} -eq 0 ]; then
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: FIFO Emulation Behavior
@@ -182,9 +178,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: FIFO vs DEADLINE Comparison
@@ -232,9 +226,7 @@ fi
 deadline_progress=$((ctxt_after_deadline - ctxt_before_deadline))
 log "DEADLINE progress: ${deadline_progress} context switches"
 
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 # Small delay between tests
 sleep 2
@@ -277,9 +269,7 @@ fi
 fifo_progress=$((ctxt_after_fifo - ctxt_before_fifo))
 log "FIFO progress: ${fifo_progress} context switches"
 
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 # Compare effectiveness
 log ""
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 7c401f3..bf3bfc8 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -91,9 +91,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Boosting Effectiveness
@@ -155,9 +153,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Starvation Duration Tracking
@@ -216,9 +212,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Close Priority Gap
@@ -251,9 +245,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 5: Correct Task Boosted
@@ -295,9 +287,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Final Summary
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 321e2c0..8ee4f82 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -72,9 +72,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Force FIFO mode (-F)
@@ -110,9 +108,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Verify FIFO priority setting
@@ -144,9 +140,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Verify FIFO emulation behavior (sleep runtime, restore, sleep remainder)
@@ -183,9 +177,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 5: Single-threaded mode with FIFO (should fail/exit)
@@ -215,9 +207,7 @@ wait_for_boost_detected "${STALLD_LOG_DL}"
 deadline_boosts=$(grep -c "boost" "${STALLD_LOG_DL}" || echo 0)
 log "ℹ INFO: SCHED_DEADLINE boosts: $deadline_boosts"
 
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 # Run with FIFO
 STALLD_LOG_FIFO="/tmp/stalld_test_force_fifo_comparison_$$.log"
@@ -231,9 +221,7 @@ wait_for_boost_detected "${STALLD_LOG_FIFO}"
 fifo_boosts=$(grep -c "boost" "${STALLD_LOG_FIFO}" || echo 0)
 log "ℹ INFO: SCHED_FIFO boosts: $fifo_boosts"
 
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 log "ℹ INFO: Comparison complete (DEADLINE: $deadline_boosts, FIFO: $fifo_boosts)"
 
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index cd4e0f3..a242fca 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -165,9 +165,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Idle Detection Overhead Reduction
@@ -236,9 +234,7 @@ else
     fi
 
     # Cleanup
-    kill -TERM ${STARVE_PID} 2>/dev/null
-    wait ${STARVE_PID} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID}"
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index 21518a4..0e6d41b 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -76,9 +76,7 @@ else
 fi
 
 # Cleanup
-kill ${STARVGEN_PID} 2>/dev/null
-wait ${STARVGEN_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVGEN_PID}"
 
 echo ""
 echo "Log file contents:"
diff --git a/tests/functional/test_runqueue_parsing.sh b/tests/functional/test_runqueue_parsing.sh
index 9aa7471..f5c2861 100755
--- a/tests/functional/test_runqueue_parsing.sh
+++ b/tests/functional/test_runqueue_parsing.sh
@@ -121,9 +121,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
     fi
 
     # Cleanup
-    kill -TERM ${STARVE_PID} 2>/dev/null
-    wait ${STARVE_PID} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID}"
 else
     test_section "Test 1: eBPF Backend - SKIPPED"
     log "eBPF backend not available on this system"
@@ -174,9 +172,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     fi
 
     # Cleanup
-    kill -TERM ${STARVE_PID} 2>/dev/null
-    wait ${STARVE_PID} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID}"
 else
     test_section "Test 2: sched_debug Backend - SKIPPED"
     log "sched_debug backend not available on this system"
@@ -204,9 +200,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     bpf_detections=$(count_detected_tasks "${STALLD_LOG_BPF}")
     log "eBPF backend detected: ${bpf_detections} starvation events"
 
-    kill -TERM ${STARVE_PID} 2>/dev/null
-    wait ${STARVE_PID} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID}"
 
     # Small delay between tests
     sleep 2
@@ -223,9 +217,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     sched_detections=$(count_detected_tasks "${STALLD_LOG_SCHED}")
     log "sched_debug backend detected: ${sched_detections} starvation events"
 
-    kill -TERM ${STARVE_PID} 2>/dev/null
-    wait ${STARVE_PID} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID}"
 
     # Compare results
     log ""
@@ -314,9 +306,7 @@ if [ -n "$test_backend" ]; then
     fi
 
     # Cleanup
-    kill -TERM ${STARVE_PID} 2>/dev/null
-    wait ${STARVE_PID} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID}"
 fi
 
 #=============================================================================
@@ -366,9 +356,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     fi
 
     # Cleanup
-    kill -TERM ${STARVE_PID} 2>/dev/null
-    wait ${STARVE_PID} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID}"
 else
     test_section "Test 5: Kernel Format Detection - SKIPPED"
     log "sched_debug backend required for format detection tests"
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index cd60e27..919148b 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -94,9 +94,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Context Switch Count Tracking
@@ -148,9 +146,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Task Merging (Timestamp Preservation)
@@ -209,8 +205,7 @@ else
 fi
 
 # Cleanup starvation generator
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Multiple CPUs Detection
@@ -275,11 +270,7 @@ else
     fi
 
     # Cleanup
-    kill -TERM ${STARVE_PID0} 2>/dev/null
-    kill -TERM ${STARVE_PID1} 2>/dev/null
-    wait ${STARVE_PID0} 2>/dev/null
-    wait ${STARVE_PID1} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID0}" "${STARVE_PID1}"
 fi
 
 #=============================================================================
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 836f079..8b54b95 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -81,9 +81,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Verify no detection before threshold
@@ -122,9 +120,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Shorter threshold (3 seconds)
@@ -158,9 +154,7 @@ else
 fi
 
 # Cleanup
-kill -TERM "${STARVE_PID}" 2>/dev/null
-wait "${STARVE_PID}" 2>/dev/null || true
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Invalid threshold values
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 305dc4b..366b89b 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -124,9 +124,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 2: Same PID + Same Context Switches = Merged
@@ -194,9 +192,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 3: Task Making Progress (No Merge)
@@ -246,9 +242,7 @@ else
 fi
 
 # Cleanup
-kill -TERM ${STARVE_PID} 2>/dev/null
-wait ${STARVE_PID} 2>/dev/null
-stop_stalld
+cleanup_scenario "${STARVE_PID}"
 
 #=============================================================================
 # Test 4: Multiple CPUs with Independent Task Merging
@@ -323,11 +317,7 @@ else
     fi
 
     # Cleanup
-    kill -TERM ${STARVE_PID0} 2>/dev/null
-    kill -TERM ${STARVE_PID1} 2>/dev/null
-    wait ${STARVE_PID0} 2>/dev/null
-    wait ${STARVE_PID1} 2>/dev/null
-    stop_stalld
+    cleanup_scenario "${STARVE_PID0}" "${STARVE_PID1}"
 fi
 
 #=============================================================================
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 5d61b39..d4e98f7 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -114,6 +114,18 @@ test_section() {
 	log "=========================================="
 }
 
+# Tear down starvation workloads and stalld between test sections.
+# Usage: cleanup_scenario [PID ...]
+cleanup_scenario() {
+	for pid in "$@"; do
+		if [ -n "$pid" ]; then
+			kill -TERM "$pid" 2>/dev/null || true
+			wait "$pid" 2>/dev/null || true
+		fi
+	done
+	stop_stalld
+}
+
 # Record a test pass with a description message.
 #
 # Usage: pass "description"
@@ -1138,7 +1150,7 @@ start_starvation_gen() {
 }
 
 # Export functions for use in tests
-export -f start_test end_test test_section
+export -f start_test end_test test_section cleanup_scenario
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
-- 
2.54.0

