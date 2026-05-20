Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469ED3E715E
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285764; cv=none; b=Z4AZhNy01o+mARcMDkwcIsFsNsK4HjvcET6u8GEJW4LthzglOsZPYw1pBXmV7yeEKXX2NufLmO8ZBVDeycmQqbrzNiEX0R7MI5fzvzm8OWOHNsfOoYEwvn2ROSRREWRJyYBCv3p6/L/znvk/awqigXRXlrn2+n1uT80t2bGWlcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285764; c=relaxed/simple;
	bh=FZ1ppjh4nHfUEPwnZgGwBrUjw6g3A9b+6kDUdzQRtkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrG3BUqgLbJhmuACpPIVEcKXP52X9xMDzYmjoI6ZFWh7wBCSxCiigJhKHiYSyfLGAspPCj9o9xsPeTKtpxKokdDMiajUtzzwquV6al0u8Yhrhn2Z1hIorftZDSrN99K5XA2ux2y7OoUkYR6NgweWasGKPu2V2PgNBWufGv70MOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYr5Tiq9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYr5Tiq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lP5Pz5PIKPitYHUXwhy38KoO9TnD8cQmkb/rcSnbgs=;
	b=gYr5Tiq9l1S8RpvVgtSgLP++4zA6/68xOfqPo+nF/ZGhtyvzQWFmcGw62C4u4sAF5SkuL4
	Z1p45lgHaDC+VMu+6OvmR6orEJ9O0E7L+chJWhumlKnCjy8QEhQ7Mr7uNMYjKE7h9y8lKY
	RZynqYRs1/eearh3Y+8BUEI99yOB7Sk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-ImF6QOS6PC2_GWqLPZQYlg-1; Wed,
 20 May 2026 10:02:38 -0400
X-MC-Unique: ImF6QOS6PC2_GWqLPZQYlg-1
X-Mimecast-MFC-AGG-ID: ImF6QOS6PC2_GWqLPZQYlg_1779285757
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEF0D19560AF;
	Wed, 20 May 2026 14:02:36 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4E421800465;
	Wed, 20 May 2026 14:02:34 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 31/33] tests: Reduce timing and replace sleeps with event waits
Date: Wed, 20 May 2026 11:00:58 -0300
Message-ID: <20260520140104.112142-32-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

