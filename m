Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025C3B7768
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288696; cv=none; b=C5V7IcRx2XieRz06muq7l8XDffUEzjDdPkWpXhMD3mRujy/HjrfxcSa4/v1JW2LX0OSQ9TzbVSAWZjWW6NDYMxegXSsGhL5A/0PJtfKKH1YcnqdHcLEoc048xDgcGRyW6g+XsS8HPi65mRz6sUQ9BD49yXUAxk9IfdlHlUOAPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288696; c=relaxed/simple;
	bh=hCgh8WjRF4EJL4tniu8Jej3Jn24KqjgR3JG0OphNiqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru3UHVOZ2VWSWfl6ohbiST8oqCTY2IC78utbJhyZUw6KjOGfv1nsTktpdRQXl5qsTIQPI9F1jJIBgJGxwEscuB9AM1bah3ICnBktkwM2YgbR+FjbcRByfYUL0J6rONusa/7w617NjPEazQQZqNpfAN2lQC/f+WUvQGna8z5PhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQVkRh/h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQVkRh/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMv/lfKPSr5zzU/vpAprxxQpv13P8L0EYA0i926bD7A=;
	b=eQVkRh/hmSXeUlVLmCgWZVbGRy9UCth+aSFLwYPKkTiSUJ55NkMYlNS6Si8P8yxLEYqenR
	zFNTXJKaSDKI9rg+LSG+r7iNBZmzI1lkDibitAXcrUH7dB6hzFqNTiGDpDT2nNboIn9rMY
	OOmEPvz8QRIAP6vjAAm7P4fAGQYsQP4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-pjTeHcp7M1KEalLEj91aHg-1; Mon,
 27 Apr 2026 07:18:11 -0400
X-MC-Unique: pjTeHcp7M1KEalLEj91aHg-1
X-Mimecast-MFC-AGG-ID: pjTeHcp7M1KEalLEj91aHg_1777288690
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1585A18003FC;
	Mon, 27 Apr 2026 11:18:10 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03C50180047F;
	Mon, 27 Apr 2026 11:18:07 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 23/23] tests: Remove dead code after making fail() fatal
Date: Mon, 27 Apr 2026 08:16:25 -0300
Message-ID: <20260427111632.24500-24-wander@redhat.com>
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

The previous commit making test failures abort immediately rendered
several teardown and reporting mechanisms obsolete. Since any failing
test now exits the script immediately, end-of-run test summaries
reporting the total number of failures will always evaluate to zero
during a successful run. These redundant summary banners and failure
counts have been removed across all multi-section tests.

This cleanup also drops trailing completion messages and empty log
lines that previously cluttered the test output. Unreachable cleanup
steps and return statements situated directly after failure calls are
now safely discarded. Furthermore, unconditional debug log dumps on
success paths have been stripped to keep successful test runs quiet.

Finally, rotting references to specific source code line numbers and
redundant backend limitation notes were purged. The relevant backend
constraints remain appropriately documented inline where they apply.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_affinity.sh                 |  3 ---
 tests/functional/test_backend_selection.sh        |  2 --
 tests/functional/test_boost_duration.sh           |  3 ---
 tests/functional/test_boost_period.sh             |  6 ------
 tests/functional/test_boost_restoration.sh        |  6 ------
 tests/functional/test_boost_runtime.sh            |  3 ---
 tests/functional/test_deadline_boosting.sh        |  6 ------
 tests/functional/test_fifo_boosting.sh            |  6 ------
 tests/functional/test_fifo_priority_starvation.sh | 13 -------------
 tests/functional/test_force_fifo.sh               |  3 ---
 tests/functional/test_idle_detection.sh           |  6 ------
 tests/functional/test_log_only.sh                 |  6 ------
 tests/functional/test_pidfile.sh                  |  3 ---
 tests/functional/test_starvation_detection.sh     |  6 ------
 tests/functional/test_starvation_threshold.sh     |  3 ---
 tests/functional/test_task_merging.sh             |  9 ---------
 16 files changed, 84 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index 15a8756..3faa199 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -190,7 +190,4 @@ assert_success "CPU affinity persisted over time" test "$affinity_start" = "$aff
 
 stop_stalld
 
-log ""
-log "All affinity tests completed"
-
 end_test
diff --git a/tests/functional/test_backend_selection.sh b/tests/functional/test_backend_selection.sh
index d65695b..26654e1 100755
--- a/tests/functional/test_backend_selection.sh
+++ b/tests/functional/test_backend_selection.sh
@@ -40,8 +40,6 @@ test_backend_flag() {
 
 	if ! wait_for_stalld_ready "${log_file}" 15; then
 		fail "stalld failed to start (${description})"
-		stop_stalld
-		return 1
 	fi
 
 	assert_log_contains "${log_file}" "${expected_msg}" "${description}"
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index aa46e84..3d6a823 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -112,7 +112,4 @@ assert_stalld_rejects "Zero duration rejected with error" -f -v -t ${threshold}
 log "Testing with duration = -5"
 assert_stalld_rejects "Negative duration rejected with error" -f -v -t ${threshold} -d -5
 
-log ""
-log "All boost duration tests completed"
-
 end_test
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index 1bb4e12..4b76c6e 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -106,10 +106,4 @@ test_section "Test 6: Invalid period value (negative)"
 
 assert_stalld_rejects "Negative period rejected with error" -f -v -t $threshold -p -1000000
 
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Total failures: ${TEST_FAILED}"
-
 end_test
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 32a5a02..ddf3940 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -192,10 +192,4 @@ fi
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
 
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Total failures: ${TEST_FAILED}"
-
 end_test
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index caaeb1d..dcfd7e7 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -127,7 +127,4 @@ test_section "Test 7: Invalid runtime value (negative)"
 log "Testing with runtime = -5000"
 assert_stalld_rejects "Negative runtime rejected with error" -f -v -t ${threshold} -r -5000
 
-log ""
-log "All boost runtime tests completed"
-
 end_test
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 50e949c..094c146 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -197,10 +197,4 @@ else
     cleanup_scenario "${STARVE_PID0}" "${STARVE_PID1}"
 fi
 
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Total failures: ${TEST_FAILED}"
-
 end_test
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 4da1182..cabc740 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -131,10 +131,4 @@ fi
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
 
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Total failures: ${TEST_FAILED}"
-
 end_test
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index a4e1a65..072c951 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -204,17 +204,4 @@ fi
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
 
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Total failures: ${TEST_FAILED}"
-
-if [ -n "${STALLD_TEST_BACKEND}" ] && [ "${STALLD_TEST_BACKEND}" = "queue_track" ]; then
-    log ""
-    log "NOTE: queue_track backend has known limitations with SCHED_FIFO task detection."
-    log "      For reliable FIFO-on-FIFO testing, use the sched_debug backend:"
-    log "      ./test_fifo_priority_starvation.sh -b sched_debug"
-fi
-
 end_test
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index d2a6281..aa66f77 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -112,7 +112,4 @@ test_section "Test 5: Single-threaded mode with FIFO (should fail)"
 log "Testing single-threaded mode (-O) with -F (should exit)"
 assert_stalld_rejects "Single-threaded mode rejected FIFO" -f -v -c "${TEST_CPU}" -t ${threshold} -F -O
 
-log ""
-log "All force FIFO tests completed"
-
 end_test
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index 20dfea6..81a9fe1 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -117,10 +117,4 @@ else
     cleanup_scenario "${STARVE_PID}"
 fi
 
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Total failures: ${TEST_FAILED}"
-
 end_test
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index 6a26b93..824ef7a 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -66,10 +66,4 @@ assert_log_contains --negate "${LOG_FILE}" "boosted" "stalld did not boost in lo
 # Cleanup
 cleanup_scenario "${STARVGEN_PID}"
 
-echo ""
-echo "Log file contents:"
-echo "=================="
-cat "${LOG_FILE}"
-echo "=================="
-
 end_test
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 75b5359..a2e5eb0 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -149,7 +149,4 @@ log "ℹ INFO: Pidfile permissions: $perms"
 
 stop_stalld
 
-log ""
-log "All pidfile tests completed"
-
 end_test
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 1d43516..17d7fe0 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -193,10 +193,4 @@ assert_log_contains --negate --ignore-case "${STALLD_LOG}" "error\|segfault\|cra
 
 stop_stalld
 
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Total failures: ${TEST_FAILED}"
-
 end_test
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index b0eeb59..6e84966 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -115,7 +115,4 @@ assert_stalld_rejects "Zero threshold rejected with error" -f -v -t 0
 log "Testing with threshold = -5"
 assert_stalld_rejects "Negative threshold rejected with error" -f -v -t -5
 
-log ""
-log "All starvation threshold tests completed"
-
 end_test
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 434114b..5e03622 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -226,13 +226,4 @@ else
     cleanup_scenario "${STARVE_PID0}" "${STARVE_PID1}"
 fi
 
-#=============================================================================
-# Final Summary
-#=============================================================================
-test_section "Test Summary"
-log "Task merging function: merge_tasks_info() in stalld.c:370-397"
-log "Merge logic: if (PID == PID && ctxsw == ctxsw) preserve timestamp"
-log ""
-log "Total failures: ${TEST_FAILED}"
-
 end_test
-- 
2.53.0

