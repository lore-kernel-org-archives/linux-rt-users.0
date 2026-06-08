Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E853E0C7E
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943624; cv=none; b=ctu1fjgBvWdc0d89b7swlpvgtAjqVCdjDxtzZZU4YN3UjpcvaaQKsMeXwT27mTt2KyjDD+iGz/WOTb+z7I9OEafLXx1t7aNSV75HdRtKM/dLk0HJqUhPopUgVXtWEwNVGDl52EiLR3ILK2UU14MXwLDgt8m0aHQsjZhiWUb5P7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943624; c=relaxed/simple;
	bh=FZ1ppjh4nHfUEPwnZgGwBrUjw6g3A9b+6kDUdzQRtkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NolwmwuBQ8aV+8Lsq3LCAo3+J4j8suzJBjfQqDjtF2/2p5cSdZdNlUMDuLF/4tgmFdjV8ojl/WST6a+pRF1qzM9qy6QqCh8V+fswY/19YIGV4hl6dUpfsa4gCLvS6GOZ9jwEyBMzAPIJJtZ0uXCo9r5nTsQQVsuWoDcZkzwL4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHtUNkTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHtUNkTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lP5Pz5PIKPitYHUXwhy38KoO9TnD8cQmkb/rcSnbgs=;
	b=eHtUNkTlMfxnb7KP60XNWU+A2AKnyxkGOaufsHdISdzIp+BDHEdgGa/Kz3GgCC1Quctg6A
	T/aqw6nPPlzCnJ0U4+Cxx0u7MOnvfpKiWLVIVitzrDcXMvqd9GvULH2+tEJ4Z+AvgvlPbA
	EO5Gnl0gD16JPLlsOSyyT5WMAdL0oeI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-LWRkWq-JMyWG26Mw18yg9A-1; Mon,
 08 Jun 2026 14:33:40 -0400
X-MC-Unique: LWRkWq-JMyWG26Mw18yg9A-1
X-Mimecast-MFC-AGG-ID: LWRkWq-JMyWG26Mw18yg9A_1780943619
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 843151977032;
	Mon,  8 Jun 2026 18:33:39 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6682A36929;
	Mon,  8 Jun 2026 18:33:37 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 31/52] tests: Reduce timing and replace sleeps with event waits
Date: Mon,  8 Jun 2026 15:31:41 -0300
Message-ID: <20260608183206.140526-32-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Lower starvation thresholds, reduce starvation_gen durations, and
replace fixed sleep delays with process-wait and event-driven
synchronization in the functional tests. This reduces test suite
runtime without sacrificing reliability.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_deadline_boosting.sh        | 2 +-
 tests/functional/test_fifo_boosting.sh            | 2 +-
 tests/functional/test_fifo_priority_starvation.sh | 5 +++--
 tests/functional/test_idle_detection.sh           | 2 +-
 tests/functional/test_starvation_detection.sh     | 3 ++-
 tests/functional/test_starvation_threshold.sh     | 5 +----
 tests/functional/test_task_merging.sh             | 9 ++++-----
 7 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 305c641..25d0f0e 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -30,7 +30,7 @@ log "Starting stalld with ${threshold}s threshold (default DEADLINE boosting)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Create starvation
-starvation_duration=$((threshold + 8))
+starvation_duration=$((threshold + 5))
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 57c473d..e489950 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -23,7 +23,7 @@ test_section "Test 1: FIFO Boost with -F Flag"
 
 threshold=5
 # Create starvation FIRST (before stalld starts)
-starvation_duration=$((threshold + 8))
+starvation_duration=$((threshold + 5))
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 66075d4..028b825 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -73,7 +73,8 @@ log "Starting stalld with boosting enabled"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
 
 # Wait for detection and boosting
-sleep $((threshold + boost_duration + 1))
+wait_for_boost_detected "${STALLD_LOG}"
+sleep ${boost_duration}
 
 ctxt_after=0
 if [ -n "${blockee_pid}" ] && [ -f "/proc/${blockee_pid}/status" ]; then
@@ -104,7 +105,7 @@ rm -f "${STALLD_LOG}"
 threshold=3
 
 # Create long starvation to trigger multiple detection cycles
-starvation_duration=15
+starvation_duration=12
 log "Creating long FIFO-on-FIFO starvation for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 2 -d ${starvation_duration}
 
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index 81a9fe1..cafce11 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -60,7 +60,7 @@ threshold=3
 log "Starting stalld with idle detection on an idle CPU"
 start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
-sleep 3
+wait_for_log_message "skipping" 5 "${STALLD_LOG}"
 
 assert_log_contains "${STALLD_LOG}" "skipping" "Idle CPU correctly skipped"
 
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 33bbfed..52031c5 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -184,7 +184,8 @@ log "Creating short-lived starvation (3s, less than ${threshold}s threshold)"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 3
 
 # Wait for task to exit
-sleep 5
+wait "${STARVE_PID}" 2>/dev/null || true
+sleep 1
 
 assert_process_running "${STALLD_PID}" "stalld still running after task exit"
 
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 6e84966..b372a87 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -60,14 +60,11 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 log "Starting stalld with ${threshold}s threshold"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -M -g 1 -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold}
 
-# Wait for starvation duration + small buffer
-sleep 8
-
 # Wait for starvation generator to fully complete
 wait "${STARVE_PID}" 2>/dev/null || true
 
 # Give stalld time to process and log (if it were to detect)
-sleep 2
+sleep 1
 
 # Check that starvation_gen was NOT detected (duration less than threshold)
 assert_log_contains --negate "${STALLD_LOG}" \
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 082f07d..784f0de 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -28,7 +28,7 @@ log "Starting stalld with ${threshold}s threshold (log-only, verbose)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Create long starvation to span multiple monitoring cycles
-starvation_duration=18
+starvation_duration=12
 log "Creating starvation for ${starvation_duration}s (multiple detection cycles)"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
@@ -51,7 +51,7 @@ fi
 
 # Wait for second detection cycle
 log "Waiting for second detection cycle..."
-sleep 4
+wait_for_n_log_matches "starved" 2 "${STALLD_LOG}"
 
 # Extract second starvation duration
 second_duration=$(grep "starved.*for [0-9]" "${STALLD_LOG}" | tail -1 | grep -oE "for [0-9]+" | awk '{print $2}')
@@ -72,7 +72,7 @@ fi
 
 # Wait for third detection to confirm continued accumulation
 log "Waiting for third detection cycle..."
-sleep 4
+wait_for_n_log_matches "starved" 3 "${STALLD_LOG}"
 
 third_duration=$(grep "starved.*for [0-9]" "${STALLD_LOG}" | tail -1 | grep -oE "for [0-9]+" | awk '{print $2}')
 if [ -z "${third_duration}" ]; then
@@ -182,8 +182,7 @@ else
     STARVE_PID1=${STARVE_PID}
 
     # Wait for starvation detection on both CPUs
-    wait_for_starvation_detected "${STALLD_LOG}"
-    sleep 4
+    wait_for_n_log_matches "starved" 2 "${STALLD_LOG}" 10
 
     # Check CPU0 starvation accumulation
     cpu0_detections=$(grep "starved on CPU ${CPU0}" "${STALLD_LOG}" | wc -l)
-- 
2.54.0

