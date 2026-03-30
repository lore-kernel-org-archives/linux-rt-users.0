Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9B347FE1
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899948; cv=none; b=iU2NUz4KFNXfu+aw+mESkTeQkXR39HiRZK8FORhu8rF6XmXKQqagvNaadJyteZ5+pmI4X6upy2u+h9zJXT4j/zZL8Mhtvof8EhPzH2QmAolRIErRRtWSH8h8B/ECbsitV4YMqz5NTbGP1YHlNshgLIm1/ib1dNHvYu29gv0n5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899948; c=relaxed/simple;
	bh=LnMPeg/Z+9k5TYF9mp1/uPIYCxf/l0+POSiEmpAUg1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPQWI3qtF7Ujei38XCzrE1hjrBft5HIcEBe2rsIgd1EilN5MI73/wjCJPC+8LWu7WrDmF/O0bDdnnOLggJVRrrOWNKIGBkQcoyjcxJqem4KpNHFdU0ELvdl7DH1kbj/PynbtxUSDLSQwb5wPsDanmHoVR8ziHBeT1sbWBRDsoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7OQaVyl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7OQaVyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaHPj4aL8BZYgD6W9SJLWit3Pv4ZtNBpnyQtopKwXgA=;
	b=X7OQaVylS9VA9DFgasm4KRyZ0I8tht97UkLjhqC+Mw3H50kT2HnZkafU25qzQgN7gtoQwD
	4aUtcgw2ZA9pdzQPsy7Gfc4nn2SGMZv8qcuTOEiE40YyYT0SsrZNEaciR3FuRIasFzCsuZ
	7elaMsTglD0xM2cracBe06/JkX3m6xc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-jglaXkKePruHOK3dSEBOwA-1; Mon,
 30 Mar 2026 15:45:39 -0400
X-MC-Unique: jglaXkKePruHOK3dSEBOwA-1
X-Mimecast-MFC-AGG-ID: jglaXkKePruHOK3dSEBOwA_1774899938
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78B94195609D;
	Mon, 30 Mar 2026 19:45:38 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 124361954102;
	Mon, 30 Mar 2026 19:45:34 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 19/36] tests/functional: Replace detection sleeps with event-driven helpers
Date: Mon, 30 Mar 2026 16:43:42 -0300
Message-ID: <20260330194410.103953-20-wander@redhat.com>
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

Functional tests wait for stalld to detect starvation or boost tasks
by sleeping a fixed duration then grepping the log. These hardcoded
sleeps add unnecessary latency on fast systems and can be too short
on slow ones, causing flaky results.

Replace the sleep-then-grep pattern with wait_for_starvation_detected()
and wait_for_boost_detected(), which use tail -f internally to return
as soon as the expected log message appears. For tests that combine
detection and boost-expiry waits in a single sleep, split them into
a helper call for detection followed by a duration sleep for expiry.
Sleeps for negative tests, boost expiry, and measurement windows are
intentionally preserved.

Additionally, migrate all start_stalld calls that redirect to a log
file to use start_stalld_with_log(), which provides event-driven
readiness detection and adds -g 1 for faster scan cycles. Without
this, stalld's default 5-second granularity caused detection timeouts
on systems where the starvation window was too short. Fix a pre-existing
bug in test_boost_duration where -d 10 exceeded -t 3, causing stalld
to reject the arguments. Fix a pre-existing bug in test_boost_period
where -p values of 100ms and 10s were rejected by stalld.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_boost_duration.sh       | 42 +++++----------
 tests/functional/test_boost_period.sh         | 46 ++++++----------
 tests/functional/test_boost_restoration.sh    | 28 ++++------
 tests/functional/test_boost_runtime.sh        | 33 +++---------
 tests/functional/test_deadline_boosting.sh    | 52 +++++++------------
 tests/functional/test_fifo_boosting.sh        | 50 +++++++++---------
 .../test_fifo_priority_starvation.sh          | 36 ++++++-------
 tests/functional/test_force_fifo.sh           | 37 +++++--------
 tests/functional/test_idle_detection.sh       | 17 +++---
 tests/functional/test_log_only.sh             |  5 +-
 tests/functional/test_runqueue_parsing.sh     | 31 ++++-------
 tests/functional/test_starvation_detection.sh | 39 +++++---------
 tests/functional/test_starvation_threshold.sh | 25 ++++-----
 tests/functional/test_task_merging.sh         | 28 +++++-----
 14 files changed, 176 insertions(+), 293 deletions(-)

diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index c835fd3..af657db 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -58,20 +58,15 @@ log "=========================================="
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default boost duration)"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l
 
 # Create starvation
 starvation_duration=15
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-wait_time=$((threshold + 2))
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
-
-# Check if boosting occurred (in log-only mode we look for detection messages)
-if grep -qi "detect\|starv" "${STALLD_LOG}"; then
+# Wait for starvation detection
+if wait_for_starvation_detected "${STALLD_LOG}"; then
     log "✓ PASS: Starvation detection occurred with default duration"
 else
     log "✗ FAIL: No starvation detection"
@@ -96,18 +91,14 @@ STALLD_LOG2="/tmp/stalld_test_boost_duration_test2_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG2}")
 
 log "Starting stalld with ${threshold}s threshold and ${short_duration}s boost duration"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_duration} -l > "${STALLD_LOG2}" 2>&1
+start_stalld_with_log "${STALLD_LOG2}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_duration} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-log "Waiting ${wait_time}s for detection"
-sleep ${wait_time}
-
-# Check if detection occurred
-if grep -qi "detect\|starv" "${STALLD_LOG2}"; then
+# Wait for starvation detection
+if wait_for_starvation_detected "${STALLD_LOG2}"; then
     log "✓ PASS: Starvation detection with ${short_duration}s duration"
 else
     log "✗ FAIL: No starvation detection with short duration"
@@ -129,22 +120,19 @@ log "=========================================="
 
 long_duration=10
 long_starvation=20
+threshold=10
 STALLD_LOG3="/tmp/stalld_test_boost_duration_test3_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG3}")
 
 log "Starting stalld with ${threshold}s threshold and ${long_duration}s boost duration"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_duration} -l > "${STALLD_LOG3}" 2>&1
+start_stalld_with_log "${STALLD_LOG3}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_duration} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 
-# Wait for detection
-log "Waiting ${wait_time}s for detection"
-sleep ${wait_time}
-
-# Check if detection occurred
-if grep -qi "detect\|starv" "${STALLD_LOG3}"; then
+# Wait for starvation detection
+if wait_for_starvation_detected "${STALLD_LOG3}"; then
     log "✓ PASS: Starvation detection with ${long_duration}s duration"
 else
     log "✗ FAIL: No starvation detection with long duration"
@@ -164,22 +152,20 @@ log "=========================================="
 log "Test 4: Verify policy restoration after boost duration"
 log "=========================================="
 
+threshold=3
 duration=2
 STALLD_LOG4="/tmp/stalld_test_boost_duration_test4_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG4}")
 
 log "Starting stalld with ${threshold}s threshold and ${duration}s boost duration"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration} -l > "${STALLD_LOG4}" 2>&1
+start_stalld_with_log "${STALLD_LOG4}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration} -l
 
 # Create starvation with a specific task we can track
 log "Creating starvation on CPU ${TEST_CPU} for 15s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
 
-# Wait for detection
-log "Waiting ${wait_time}s for detection"
-sleep ${wait_time}
-
-if grep -qi "detect\|starv" "${STALLD_LOG4}"; then
+# Wait for starvation detection
+if wait_for_starvation_detected "${STALLD_LOG4}"; then
     log "✓ PASS: Starvation detection with ${duration}s boost duration"
 else
     log "✗ FAIL: No starvation detection"
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index aab4436..4838672 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -55,20 +55,15 @@ log "=========================================="
 
 threshold=5
 log "Starting stalld with default period"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -N > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -N
 
 # Create starvation
 starvation_duration=$((threshold + 5))
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-wait_time=$((threshold + 2))
-log "Waiting ${wait_time}s for starvation detection and boosting..."
-sleep ${wait_time}
-
-# Check if boosting occurred
-if grep -q "boost" "${STALLD_LOG}"; then
+# Wait for starvation detection and boosting
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "✓ PASS: Boosting occurred with default period"
 
     # Try to find period value in logs
@@ -98,17 +93,14 @@ log "=========================================="
 custom_period=500000000
 rm -f "${STALLD_LOG}"
 log "Starting stalld with custom period ${custom_period} ns"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $custom_period -N > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $custom_period -N
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-sleep ${wait_time}
-
-# Check if boosting occurred
-if grep -q "boost" "${STALLD_LOG}"; then
+# Wait for starvation detection and boosting
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "✓ PASS: Boosting occurred with custom period ${custom_period} ns"
 else
     log "✗ FAIL: No boosting with custom period"
@@ -125,23 +117,20 @@ stop_stalld
 #=============================================================================
 log ""
 log "=========================================="
-log "Test 3: Very short period of 100,000,000 ns (100ms)"
+log "Test 3: Short period of 200,000,000 ns (200ms)"
 log "=========================================="
 
-short_period=100000000
+short_period=200000000
 rm -f "${STALLD_LOG}"
 log "Starting stalld with short period ${short_period} ns"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $short_period -N > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $short_period -N
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-sleep ${wait_time}
-
-# Check if boosting occurred
-if grep -q "boost" "${STALLD_LOG}"; then
+# Wait for starvation detection and boosting
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "✓ PASS: Boosting occurred with short period ${short_period} ns"
 else
     log "✗ FAIL: No boosting with short period"
@@ -158,23 +147,20 @@ stop_stalld
 #=============================================================================
 log ""
 log "=========================================="
-log "Test 4: Very long period of 10,000,000,000 ns (10s)"
+log "Test 4: Long period of 3,000,000,000 ns (3s)"
 log "=========================================="
 
-long_period=10000000000
+long_period=3000000000
 rm -f "${STALLD_LOG}"
 log "Starting stalld with long period ${long_period} ns"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $long_period -N > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $long_period -N
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-sleep ${wait_time}
-
-# Check if boosting occurred
-if grep -q "boost" "${STALLD_LOG}"; then
+# Wait for starvation detection and boosting
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "✓ PASS: Boosting occurred with long period ${long_period} ns"
 else
     log "✗ FAIL: No boosting with long period"
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index beadf47..fc5a25a 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -60,7 +60,7 @@ boost_duration=3
 
 log "Starting stalld with ${boost_duration}s boost duration"
 # Use -i to ignore kworkers so stalld focuses on our test workload
-start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker" > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker"
 
 # Create starvation (starvation_gen creates SCHED_FIFO blocker prio 80, blockee prio 1)
 log "Creating starvation with SCHED_FIFO tasks (blocker prio 80, blockee prio 1)"
@@ -92,7 +92,7 @@ if [ -n "${tracked_pid}" ]; then
 
     # Wait for starvation detection and boosting
     log "Waiting for starvation detection and boost..."
-    sleep $((threshold + 1))
+    wait_for_boost_detected "${STALLD_LOG}"
 
     # Check policy during boost (should be DEADLINE=6)
     if [ -f "/proc/${tracked_pid}/sched" ]; then
@@ -170,7 +170,7 @@ boost_duration=3
 
 log "Starting stalld"
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker" > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker"
 
 # Create a SCHED_FIFO task that will starve
 # We'll create our own RT task instead of using starvation_gen
@@ -226,7 +226,7 @@ if chrt -f -p 10 ${FIFO_TASK_PID} 2>/dev/null; then
 
     # Wait for starvation detection
     log "Waiting for starvation detection and boost..."
-    sleep $((threshold + 1))
+    wait_for_boost_detected "${STALLD_LOG}"
 
     # Check if boosted
     if [ -f "/proc/${FIFO_TASK_PID}/sched" ]; then
@@ -284,7 +284,7 @@ boost_duration=3
 
 log "Starting stalld"
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker" > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker"
 
 # Use -o flag to create SCHED_OTHER blockees
 log "Creating SCHED_OTHER starvation (RT blocker prio 80, SCHED_OTHER blockee)"
@@ -314,17 +314,14 @@ boost_duration=4  # 4 second boost
 
 log "Starting stalld with ${boost_duration}s boost duration"
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker" > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker"
 
 # Create starvation
 log "Creating starvation"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
-# Wait for starvation detection
-sleep $((threshold + 1))
-
-# Check when boost occurred
-if grep -q "boosted" "${STALLD_LOG}"; then
+# Wait for starvation detection and boosting
+if wait_for_boost_detected "${STALLD_LOG}"; then
     boost_time=$(date +%s)
     log "Boost detected at timestamp: ${boost_time}"
 
@@ -373,7 +370,7 @@ boost_duration=5  # Task will exit during boost (after 8s, boost is 5s)
 
 log "Starting stalld with ${threshold}s threshold, ${boost_duration}s boost (task will exit during boost)"
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker" > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker"
 
 # Create starvation that exits after threshold - 2s (so 8s)
 # This ensures the task exits DURING the boost period
@@ -381,11 +378,8 @@ short_duration=$((threshold - 2))
 log "Creating starvation that will exit after ${short_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d ${short_duration}
 
-# Give stalld time to detect starvation and start boosting
-# Need: threshold (10s) + buffer for detection (2s) = 12s
-sleep $((threshold + 2))
-
-if grep -q "boosted" "${STALLD_LOG}"; then
+# Wait for starvation detection and boosting
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "✓ PASS: Boost occurred"
 
     # At this point (12s), starvation_gen has exited (at 8s) during the boost
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index b8dfd1f..734a6f8 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -58,7 +58,7 @@ log "=========================================="
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default boost runtime)"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l
 
 # Create starvation
 starvation_duration=10
@@ -66,12 +66,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-wait_time=$((threshold + 2))
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
-
-# Check if detection occurred
-if grep -qi "detect\|starv" "${STALLD_LOG}"; then
+if wait_for_starvation_detected "${STALLD_LOG}"; then
     log "✓ PASS: Starvation detection with default runtime"
 else
     log "✗ FAIL: No starvation detection"
@@ -96,18 +91,14 @@ STALLD_LOG2="/tmp/stalld_test_boost_runtime_test2_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG2}")
 
 log "Starting stalld with ${threshold}s threshold and ${custom_runtime}ns runtime"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom_runtime} -l > "${STALLD_LOG2}" 2>&1
+start_stalld_with_log "${STALLD_LOG2}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom_runtime} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
-
-# Check if detection occurred
-if grep -qi "detect\|starv" "${STALLD_LOG2}"; then
+if wait_for_starvation_detected "${STALLD_LOG2}"; then
     log "✓ PASS: Starvation detection with custom runtime ${custom_runtime}ns"
 else
     log "✗ FAIL: No starvation detection with custom runtime"
@@ -132,18 +123,14 @@ STALLD_LOG3="/tmp/stalld_test_boost_runtime_test3_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG3}")
 
 log "Starting stalld with ${threshold}s threshold and ${large_runtime}ns runtime"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_runtime} -l > "${STALLD_LOG3}" 2>&1
+start_stalld_with_log "${STALLD_LOG3}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_runtime} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
-
-# Check if detection occurred
-if grep -qi "detect\|starv" "${STALLD_LOG3}"; then
+if wait_for_starvation_detected "${STALLD_LOG3}"; then
     log "✓ PASS: Starvation detection with large runtime ${large_runtime}ns"
 else
     log "✗ FAIL: No starvation detection with large runtime"
@@ -170,18 +157,14 @@ STALLD_LOG4="/tmp/stalld_test_boost_runtime_test4_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG4}")
 
 log "Starting stalld with runtime ${valid_runtime}ns < period ${period}ns"
-start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_runtime} -p ${period} -l > "${STALLD_LOG4}" 2>&1
+start_stalld_with_log "${STALLD_LOG4}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_runtime} -p ${period} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
-
-# Check if detection occurred
-if grep -qi "detect\|starv" "${STALLD_LOG4}"; then
+if wait_for_starvation_detected "${STALLD_LOG4}"; then
     log "✓ PASS: Starvation detection with runtime < period"
 else
     log "✗ FAIL: No starvation detection when runtime < period"
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index de72100..a5727da 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -58,22 +58,16 @@ log "=========================================="
 threshold=5
 log "Starting stalld with ${threshold}s threshold (default DEADLINE boosting)"
 # Use -g 1 for 1-second granularity to ensure timely detection
-start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Create starvation
 starvation_duration=$((threshold + 8))
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting (threshold + granularity + buffer)
-# With -g 1, stalld checks every 1 second. In worst case, it checks just before
-# threshold is reached, then waits another granularity period.
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for starvation detection and boosting (threshold: ${threshold}s, granularity: 1s)..."
-sleep ${wait_time}
-
-# Verify boosting occurred
-if grep -q "boosted" "${STALLD_LOG}"; then
+# Wait for boosting
+log "Waiting for boost detection..."
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "✓ PASS: Boosting occurred"
 
     # Verify SCHED_DEADLINE was used
@@ -123,18 +117,16 @@ log "  Runtime: ${boost_runtime}ns (50µs)"
 log "  Duration: ${boost_duration}s"
 
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} \
-    -p ${boost_period} -r ${boost_runtime} -d ${boost_duration} \
-    > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} \
+    -p ${boost_period} -r ${boost_runtime} -d ${boost_duration}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
 
-# Wait for boosting (threshold + granularity + buffer)
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for detection..."
-sleep ${wait_time}
+# Wait for boosting
+log "Waiting for boost detection..."
+wait_for_boost_detected "${STALLD_LOG}"
 
 # Try to find the boosted task PID
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
@@ -184,16 +176,15 @@ boost_duration=5
 
 log "Starting stalld with ${boost_duration}s boost duration"
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
-# Wait for starvation detection (threshold + granularity + buffer)
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for detection..."
-sleep ${wait_time}
+# Wait for boosting
+log "Waiting for boost detection..."
+wait_for_boost_detected "${STALLD_LOG}"
 
 # Find a starved task
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
@@ -257,7 +248,7 @@ boost_duration=3
 
 log "Starting stalld with ${boost_duration}s boost duration"
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
@@ -285,10 +276,8 @@ if [ -n "${tracked_pid}" ]; then
         log "⚠ WARNING: Initial policy is not SCHED_OTHER (got ${initial_policy})"
     fi
 
-    # Wait for starvation detection and boosting (threshold + granularity + buffer)
-    wait_time=$((threshold + 1 + 3))
-    log "Waiting ${wait_time}s for detection..."
-    sleep ${wait_time}
+    # Wait for starvation detection and boosting
+    wait_for_boost_detected "${STALLD_LOG}"
 
     # Check if policy changed to DEADLINE during boost
     boosted_policy=$(get_sched_policy ${tracked_pid})
@@ -350,7 +339,7 @@ else
     log "Testing simultaneous boosts on CPU ${CPU0} and CPU ${CPU1}"
 
     rm -f "${STALLD_LOG}"
-    start_stalld -f -v -g 1 -t $threshold -c ${CPU0},${CPU1} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+    start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${CPU0},${CPU1} -a ${STALLD_CPU}
 
     # Create starvation on CPU0
     log "Creating starvation on CPU ${CPU0}"
@@ -362,10 +351,9 @@ else
     start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 15
     STARVE_PID1=${STARVE_PID}
 
-    # Wait for detection and boosting (threshold + granularity + buffer)
-    wait_time=$((threshold + 1 + 3))
-    log "Waiting ${wait_time}s for detection..."
-    sleep ${wait_time}
+    # Wait for boosting on both CPUs
+    log "Waiting for boost detection..."
+    wait_for_boost_detected "${STALLD_LOG}"
 
     # Count boost messages
     boost_count=$(grep -c "boosted" "${STALLD_LOG}")
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index a6168e9..3088141 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -61,15 +61,11 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 log "Starting stalld with -F flag to force SCHED_FIFO boosting"
 # Note: -F requires non-single-threaded mode (aggressive mode)
 # Use -g 1 for 1-second granularity to ensure timely detection
-start_stalld -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
-# Wait for detection and boosting (threshold + granularity + buffer)
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for starvation detection and boosting (threshold: ${threshold}s, granularity: 1s)..."
-sleep ${wait_time}
-
-# Verify FIFO boosting occurred
-if grep -qiE "boosted.*(SCHED_FIFO|FIFO)|FIFO.*boost" "${STALLD_LOG}"; then
+# Wait for boosting
+log "Waiting for boost detection..."
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "✓ PASS: Boosting occurred with -F flag"
 
     # Verify SCHED_FIFO was used
@@ -109,12 +105,11 @@ STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
 log "Starvation generator children PIDs: ${STARVE_CHILDREN}"
 
 log "Starting stalld with -F flag (FIFO boosting)"
-start_stalld -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
-# Wait for boosting (threshold + granularity + buffer)
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for detection..."
-sleep ${wait_time}
+# Wait for boosting
+log "Waiting for boost detection..."
+wait_for_boost_detected "${STALLD_LOG}"
 
 fifo_task_found=0
 for child_pid in ${STARVE_CHILDREN}; do
@@ -175,13 +170,16 @@ rm -f "${STALLD_LOG}"
 log "Creating starvation on CPU ${TEST_CPU}"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
-start_stalld -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} \
-    -d ${boost_duration} -p ${boost_period} -r ${boost_runtime} \
-    > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} \
+    -d ${boost_duration} -p ${boost_period} -r ${boost_runtime}
+
+# Wait for boosting to start
+log "Waiting for boost detection..."
+wait_for_boost_detected "${STALLD_LOG}"
 
-# Wait for boosting to complete (threshold + granularity + boost_duration + buffer)
+# Wait for FIFO emulation cycles to complete (boost_duration + buffer)
 log "Waiting for FIFO emulation cycles to complete..."
-sleep $((threshold + 1 + boost_duration + 2))
+sleep $((boost_duration + 2))
 
 # Count boost events (FIFO emulation creates multiple boosts)
 boost_count=$(grep -c "boosted.*SCHED_FIFO" "${STALLD_LOG}")
@@ -234,10 +232,12 @@ if [ -n "${deadline_tracked_pid}" ]; then
 fi
 
 # NOW start stalld
-start_stalld -f -v -g 1 -N -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} > "${STALLD_LOG_DEADLINE}" 2>&1
+start_stalld_with_log "${STALLD_LOG_DEADLINE}" -f -v -g 1 -N -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
 
-# Wait for detection, boost, and some progress (threshold + granularity + boost_duration)
-sleep $((threshold + 1 + boost_duration))
+# Wait for boost detection, then let boost run to completion
+log "Waiting for DEADLINE boost detection..."
+wait_for_boost_detected "${STALLD_LOG_DEADLINE}"
+sleep $((boost_duration + 1))
 
 ctxt_after_deadline=0
 if [ -n "${deadline_tracked_pid}" ] && [ -f "/proc/${deadline_tracked_pid}/status" ]; then
@@ -277,10 +277,12 @@ if [ -n "${fifo_tracked_pid}" ]; then
 fi
 
 # NOW start stalld
-start_stalld -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} > "${STALLD_LOG_FIFO}" 2>&1
+start_stalld_with_log "${STALLD_LOG_FIFO}" -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
 
-# Wait for detection, boost, and some progress (threshold + granularity + boost_duration)
-sleep $((threshold + 1 + boost_duration))
+# Wait for boost detection, then let boost run to completion
+log "Waiting for FIFO boost detection..."
+wait_for_boost_detected "${STALLD_LOG_FIFO}"
+sleep $((boost_duration + 1))
 
 ctxt_after_fifo=0
 if [ -n "${fifo_tracked_pid}" ] && [ -f "/proc/${fifo_tracked_pid}/status" ]; then
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index cf47971..adb7b44 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -69,13 +69,9 @@ start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 2 -d ${starvation_duration}
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
-# Wait for detection (threshold + small buffer)
-wait_time=$((threshold + 2))
-log "Waiting ${wait_time}s for starvation detection..."
-sleep ${wait_time}
-
-# Verify starvation was detected
-if grep -q "starved on CPU" "${STALLD_LOG}"; then
+# Wait for starvation detection
+log "Waiting for starvation detection..."
+if wait_for_starvation_detected "${STALLD_LOG}"; then
     log "✓ PASS: FIFO-on-FIFO starvation detected"
 
     # Verify correct CPU is logged
@@ -195,12 +191,14 @@ log "Will monitor for multiple detection cycles to verify timestamp preservation
 start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Wait for multiple detection cycles
-log "Waiting for multiple detection cycles..."
-sleep $((threshold + 2))
+log "Waiting for first detection cycle..."
+wait_for_starvation_detected "${STALLD_LOG}"
 log "First detection cycle should have occurred"
-sleep 3
+log "Waiting for second detection cycle..."
+wait_for_starvation_detected "${STALLD_LOG}"
 log "Second detection cycle should have occurred"
-sleep 3
+log "Waiting for third detection cycle..."
+wait_for_starvation_detected "${STALLD_LOG}"
 log "Third detection cycle should have occurred"
 
 # Check if we see accumulating starvation time in logs
@@ -257,11 +255,9 @@ start_starvation_gen -c ${TEST_CPU} -p 6 -b 5 -n 1 -d $((threshold + 5))
 log "Starting stalld with ${threshold}s threshold"
 start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
-# Wait for detection
-sleep $((threshold + 2))
-
-# Verify detection works even with close priorities
-if grep -q "starved on CPU" "${STALLD_LOG}"; then
+# Wait for starvation detection
+log "Waiting for starvation detection..."
+if wait_for_starvation_detected "${STALLD_LOG}"; then
     log "✓ PASS: Starvation detected even with close priority gap (6 vs 5)"
 else
     log "⚠ WARNING: Starvation not detected with close priority gap"
@@ -298,11 +294,9 @@ log "Starvation generator PID: ${STARVE_PID}"
 log "Starting stalld with boosting enabled"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
-# Wait for detection and boosting
-sleep $((threshold + 2))
-
-# Verify boosting occurred
-if grep -q "boosted" "${STALLD_LOG}"; then
+# Wait for boosting
+log "Waiting for boost detection..."
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "✓ PASS: Boosting occurred"
 
     # Try to verify the correct task was boosted
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 4c43101..17bc66e 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -51,7 +51,7 @@ log "=========================================="
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default, no -F)"
-start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -t ${threshold}
 
 # Create starvation
 starvation_duration=10
@@ -59,12 +59,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-wait_time=$((threshold + 2))
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
-
-# Check if boosting occurred and look for DEADLINE mentions
-if grep -q "boost" "${STALLD_LOG}"; then
+if wait_for_boost_detected "${STALLD_LOG}"; then
     log "Boosting occurred"
 
     # Look for SCHED_DEADLINE indicators
@@ -98,18 +93,14 @@ STALLD_LOG2="/tmp/stalld_test_force_fifo_test2_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG2}")
 
 log "Starting stalld with -F flag and aggressive mode (-A)"
-start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F -A > "${STALLD_LOG2}" 2>&1
+start_stalld_with_log "${STALLD_LOG2}" -f -v -c "${TEST_CPU}" -t ${threshold} -F -A
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
-
-# Check if boosting occurred and look for FIFO mentions
-if grep -q "boost" "${STALLD_LOG2}"; then
+if wait_for_boost_detected "${STALLD_LOG2}"; then
     log "Boosting occurred with -F flag"
 
     # Look for SCHED_FIFO indicators
@@ -142,15 +133,14 @@ STALLD_LOG3="/tmp/stalld_test_force_fifo_test3_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG3}")
 
 log "Starting stalld with -F and -A flags"
-start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F -A > "${STALLD_LOG3}" 2>&1
+start_stalld_with_log "${STALLD_LOG3}" -f -v -c "${TEST_CPU}" -t ${threshold} -F -A
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
+wait_for_boost_detected "${STALLD_LOG3}"
 
 # Check logs for priority information
 if grep -qi "priority\|prio" "${STALLD_LOG3}"; then
@@ -182,17 +172,14 @@ STALLD_LOG4="/tmp/stalld_test_force_fifo_test4_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG4}")
 
 log "Starting stalld with -F, -A, and ${boost_duration}s boost duration"
-start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F -A -d ${boost_duration} > "${STALLD_LOG4}" 2>&1
+start_stalld_with_log "${STALLD_LOG4}" -f -v -c "${TEST_CPU}" -t ${threshold} -F -A -d ${boost_duration}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${long_starvation}
 
 # Wait for detection and boosting
-log "Waiting ${wait_time}s for detection and boosting"
-sleep ${wait_time}
-
-if grep -q "boost" "${STALLD_LOG4}"; then
+if wait_for_boost_detected "${STALLD_LOG4}"; then
     log "Boosting detected, waiting for duration cycle"
 
     # Wait for boost duration + buffer to see restoration
@@ -261,9 +248,9 @@ STALLD_LOG_DL="/tmp/stalld_test_force_fifo_deadline_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG_DL}")
 
 log "Running comparison test with SCHED_DEADLINE"
-start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -d ${comparison_duration} > "${STALLD_LOG_DL}" 2>&1
+start_stalld_with_log "${STALLD_LOG_DL}" -f -v -c "${TEST_CPU}" -t ${threshold} -d ${comparison_duration}
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${comparison_starvation}
-sleep $((threshold + 3))
+wait_for_boost_detected "${STALLD_LOG_DL}"
 
 deadline_boosts=$(grep -c "boost" "${STALLD_LOG_DL}" || echo 0)
 log "ℹ INFO: SCHED_DEADLINE boosts: $deadline_boosts"
@@ -277,9 +264,9 @@ STALLD_LOG_FIFO="/tmp/stalld_test_force_fifo_comparison_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG_FIFO}")
 
 log "Running comparison test with SCHED_FIFO"
-start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F -A -d ${comparison_duration} > "${STALLD_LOG_FIFO}" 2>&1
+start_stalld_with_log "${STALLD_LOG_FIFO}" -f -v -c "${TEST_CPU}" -t ${threshold} -F -A -d ${comparison_duration}
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${comparison_starvation}
-sleep $((threshold + 3))
+wait_for_boost_detected "${STALLD_LOG_FIFO}"
 
 fifo_boosts=$(grep -c "boost" "${STALLD_LOG_FIFO}" || echo 0)
 log "ℹ INFO: SCHED_FIFO boosts: $fifo_boosts"
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index 755a4b5..ef1c572 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -84,7 +84,7 @@ log "Idle CPUs should be skipped to reduce overhead"
 threshold=5
 log "Starting stalld with verbose logging"
 # Use -g 1 for 1-second granularity
-start_stalld -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Let stalld run while CPU is idle (no load)
 log "CPU ${TEST_CPU} should be idle (no load created)"
@@ -152,7 +152,7 @@ log "=========================================="
 threshold=5
 rm -f "${STALLD_LOG}"
 log "Starting stalld"
-start_stalld -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Initially idle
 log "CPU ${TEST_CPU} initially idle"
@@ -162,13 +162,11 @@ sleep 3
 log "Creating load on CPU ${TEST_CPU} to make it busy"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 12
 
-# Wait for stalld to detect the busy CPU and starvation (threshold + granularity + buffer)
+# Wait for stalld to detect the busy CPU and starvation
 log "Waiting for stalld to detect busy CPU and starvation..."
-wait_time=$((threshold + 1 + 3))
-sleep ${wait_time}
 
 # Verify stalld detected starvation (meaning it resumed monitoring)
-if grep -q "starved" "${STALLD_LOG}"; then
+if wait_for_starvation_detected "${STALLD_LOG}"; then
     log "✓ PASS: stalld detected starvation on now-busy CPU"
     log "        Monitoring resumed when CPU became busy"
 else
@@ -226,15 +224,14 @@ else
 
     threshold=5
     rm -f "${STALLD_LOG}"
-    start_stalld -f -v -g 1 -l -t $threshold -c ${CPU0},${CPU1} > "${STALLD_LOG}" 2>&1
+    start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${CPU0},${CPU1}
 
     # Create load only on CPU1, leave CPU0 idle
     log "Creating load on CPU ${CPU1} only"
     start_starvation_gen -c ${CPU1} -p 80 -n 2 -d 12
 
-    # Wait for detection (threshold + granularity + buffer)
-    wait_time=$((threshold + 1 + 3))
-    sleep ${wait_time}
+    # Wait for detection
+    wait_for_starvation_detected "${STALLD_LOG}"
 
     # Check which CPU had starvation detected
     cpu0_detections=$(grep -c "starved on CPU ${CPU0}" "${STALLD_LOG}")
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index 93c71cb..655560c 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -76,11 +76,10 @@ fi
 echo "stalld started with PID ${STALLD_PID}"
 
 echo "Starvation generator started (PID ${STARVGEN_PID})"
-echo "Waiting 7 seconds for starvation detection..."
-sleep 7
+echo "Waiting for starvation detection..."
 
 # Check if stalld detected the starvation (should log it)
-if grep -q "starved" "${LOG_FILE}"; then
+if wait_for_starvation_detected "${LOG_FILE}"; then
 	assert_equals "1" "1" "stalld detected and logged starvation"
 else
 	TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_runqueue_parsing.sh b/tests/functional/test_runqueue_parsing.sh
index 7edf936..ccb1982 100755
--- a/tests/functional/test_runqueue_parsing.sh
+++ b/tests/functional/test_runqueue_parsing.sh
@@ -100,12 +100,8 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
     log "Creating starvation for ${starvation_duration}s"
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
-    # Wait for detection (threshold + granularity + buffer)
-    wait_time=$((threshold + 1 + 3))
-    sleep ${wait_time}
-
-    # Verify eBPF backend detected starvation
-    if grep -q "starved on CPU" "${STALLD_LOG_BPF}"; then
+    # Wait for starvation detection
+    if wait_for_starvation_detected "${STALLD_LOG_BPF}"; then
         log "✓ PASS: eBPF backend detected starving tasks"
 
         # Verify task info is present (PID, comm)
@@ -159,12 +155,8 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     log "Creating starvation for ${starvation_duration}s"
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
-    # Wait for detection (threshold + granularity + buffer)
-    wait_time=$((threshold + 1 + 3))
-    sleep ${wait_time}
-
-    # Verify sched_debug backend detected starvation
-    if grep -q "starved on CPU" "${STALLD_LOG_SCHED}"; then
+    # Wait for starvation detection
+    if wait_for_starvation_detected "${STALLD_LOG_SCHED}"; then
         log "✓ PASS: sched_debug backend detected starving tasks"
 
         # Verify task info is present
@@ -227,8 +219,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
 
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
-    wait_time=$((threshold + 1 + 3))
-    sleep ${wait_time}
+    wait_for_starvation_detected "${STALLD_LOG_BPF}"
     bpf_detections=$(count_detected_tasks "${STALLD_LOG_BPF}")
     log "eBPF backend detected: ${bpf_detections} starvation events"
 
@@ -247,8 +238,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
 
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
-    wait_time=$((threshold + 1 + 3))
-    sleep ${wait_time}
+    wait_for_starvation_detected "${STALLD_LOG_SCHED}"
     sched_detections=$(count_detected_tasks "${STALLD_LOG_SCHED}")
     log "sched_debug backend detected: ${sched_detections} starvation events"
 
@@ -314,9 +304,8 @@ if [ -n "$test_backend" ]; then
     log "Creating starvation with known task name (starvation_gen)"
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 10 -v
 
-    # Wait for detection (threshold + granularity + buffer)
-    wait_time=$((threshold + 1 + 3))
-    sleep ${wait_time}
+    # Wait for starvation detection
+    wait_for_starvation_detected "${log_file}"
 
     # Verify fields are present
     log ""
@@ -376,8 +365,8 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     # Create brief starvation just to initialize the backend
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 8
 
-    wait_time=$((threshold + 1 + 3))
-    sleep ${wait_time}
+    # Wait for starvation detection
+    wait_for_starvation_detected "${STALLD_LOG_SCHED}"
 
     # Check for format detection messages
     if grep -q "detect_task_format" "${STALLD_LOG_SCHED}"; then
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 6a1821d..6b7d330 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -72,16 +72,9 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
-# Wait for detection (threshold + granularity + buffer)
-# With -g 1, stalld checks every 1 second. In worst case, it checks just before
-# threshold is reached, then waits another granularity period.
-# So we need: threshold + granularity + buffer for processing
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for starvation detection (threshold: ${threshold}s, granularity: 1s)..."
-sleep ${wait_time}
-
-# Verify starvation was detected
-if grep -qE "starvation_gen.*starved on CPU|starved on CPU.*starvation_gen" "${STALLD_LOG}"; then
+# Wait for starvation detection
+log "Waiting for starvation detection..."
+if wait_for_starvation_detected "${STALLD_LOG}"; then
     log "✓ PASS: Starvation detected"
 
     # Verify correct CPU is logged
@@ -129,10 +122,9 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
-# Wait for detection (threshold + granularity + buffer)
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for detection..."
-sleep ${wait_time}
+# Wait for starvation detection
+log "Waiting for starvation detection..."
+wait_for_starvation_detected "${STALLD_LOG}"
 
 # Try to find the starved task PID from starvation_gen children
 # The blockee thread is what gets starved
@@ -190,16 +182,14 @@ log "Starting stalld with ${threshold}s threshold (log-only mode)"
 log "Will monitor for multiple detection cycles to verify timestamp preservation"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU}
 
-# Wait for multiple detection cycles
-# First detection: threshold + granularity + buffer
+# Wait for first detection cycle
 log "Waiting for first detection cycle..."
-sleep $((threshold + 1 + 3))
+wait_for_starvation_detected "${STALLD_LOG}"
 log "First detection cycle should have occurred"
-# Second detection: wait for another granularity period + buffer
-sleep $((1 + 2))
+# Wait for additional detection cycles
+sleep 4
 log "Second detection cycle should have occurred"
-# Third detection: wait for another granularity period + buffer
-sleep $((1 + 2))
+sleep 4
 log "Third detection cycle should have occurred"
 
 # Stop stalld to flush output buffers before checking log
@@ -287,10 +277,9 @@ else
 
     start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${CPU0},${CPU1} -a ${STALLD_CPU_MULTI}
 
-    # Wait for detection (threshold + granularity + buffer)
-    wait_time=$((threshold + 1 + 3))
-    log "Waiting ${wait_time}s for detection..."
-    sleep ${wait_time}
+    # Wait for starvation detection
+    log "Waiting for starvation detection..."
+    wait_for_starvation_detected "${STALLD_LOG}"
 
     # Check both CPUs detected - specifically look for starvation_gen tasks
     if grep -qE "starvation_gen.*starved on CPU ${CPU0}|starved on CPU ${CPU0}.*starvation_gen" "${STALLD_LOG}"; then
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 45a4679..9b14009 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -69,18 +69,13 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold"
 # Use -i to ignore kernel workers that may starve before our test tasks
-start_stalld -f -v -N -M -g 1 -i "ksoftirqd,kworker" -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -N -M -g 1 -i "ksoftirqd,kworker" -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold}
 
-# Wait for threshold + granularity + buffer time
-# With -g 1, stalld checks every 1 second. In worst case, it checks just before
-# threshold is reached, then waits another granularity period.
-# So we need: threshold + granularity + buffer for processing
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for detection (threshold: ${threshold}s, granularity: 1s)"
-sleep ${wait_time}
+# Wait for starvation detection
+log "Waiting for detection (threshold: ${threshold}s)"
 
 # Check if starvation was detected - specifically look for starvation_gen tasks
-if grep -qE "starvation_gen.*starved on CPU ${TEST_CPU}|starved on CPU ${TEST_CPU}.*starvation_gen" "${STALLD_LOG}"; then
+if wait_for_starvation_detected "${STALLD_LOG}"; then
     log "✓ PASS: Starvation detected after ${threshold}s threshold"
 else
     log "✗ FAIL: Starvation not detected after ${threshold}s threshold"
@@ -113,7 +108,7 @@ log "Creating short starvation (${starvation_duration}s) with threshold of ${thr
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold"
-start_stalld -f -v -N -M -g 1 -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold} > "${STALLD_LOG2}" 2>&1
+start_stalld_with_log "${STALLD_LOG2}" -f -v -N -M -g 1 -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold}
 
 # Wait for starvation duration + small buffer
 sleep 8
@@ -159,15 +154,13 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold"
 # Use -i to ignore kernel workers that may starve before our test tasks
-start_stalld -f -v -N -M -g 1 -i "ksoftirqd,kworker" -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold} > "${STALLD_LOG3}" 2>&1
+start_stalld_with_log "${STALLD_LOG3}" -f -v -N -M -g 1 -i "ksoftirqd,kworker" -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold}
 
-# Wait for threshold + granularity + buffer
-wait_time=$((threshold + 1 + 3))
-log "Waiting ${wait_time}s for detection (threshold: ${threshold}s, granularity: 1s)"
-sleep ${wait_time}
+# Wait for starvation detection
+log "Waiting for detection (threshold: ${threshold}s)"
 
 # Check if starvation_gen was detected
-if grep -qE "starvation_gen.*starved on CPU ${TEST_CPU}|starved on CPU ${TEST_CPU}.*starvation_gen" "${STALLD_LOG3}"; then
+if wait_for_starvation_detected "${STALLD_LOG3}"; then
     log "✓ PASS: Starvation detected with ${threshold}s threshold"
 else
     log "✗ FAIL: Starvation not detected with ${threshold}s threshold"
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 1bea759..5cd6406 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -65,17 +65,16 @@ log "Task merging: same PID + same ctxsw = preserved timestamp"
 threshold=3
 log "Starting stalld with ${threshold}s threshold (log-only, verbose)"
 # Use -g 1 for 1-second granularity
-start_stalld -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Create long starvation to span multiple monitoring cycles
 starvation_duration=18
 log "Creating starvation for ${starvation_duration}s (multiple detection cycles)"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for first detection (threshold + granularity + buffer)
+# Wait for first detection
 log "Waiting for first detection cycle..."
-wait_time=$((threshold + 1 + 3))
-sleep ${wait_time}
+wait_for_starvation_detected "${STALLD_LOG}"
 
 # Extract first starvation duration
 if grep -q "starved.*for [0-9]" "${STALLD_LOG}"; then
@@ -144,15 +143,14 @@ log "Merging occurs when: PID matches AND context switches unchanged"
 
 threshold=5
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Create starvation
 log "Creating starvation"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
-# Wait for detection (threshold + granularity + buffer)
-wait_time=$((threshold + 1 + 3))
-sleep ${wait_time}
+# Wait for starvation detection
+wait_for_starvation_detected "${STALLD_LOG}"
 
 # Find the starved task PID
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
@@ -218,15 +216,14 @@ log "When context switches change, timestamp should reset"
 
 threshold=5
 rm -f "${STALLD_LOG}"
-start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d 2 > "${STALLD_LOG}" 2>&1
+start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d 2
 
 # Create starvation that will get boosted (allowing progress)
 log "Creating starvation that will be boosted"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
-# Wait for first detection and boost (threshold + granularity + buffer)
-wait_time=$((threshold + 1 + 3))
-sleep ${wait_time}
+# Wait for starvation detection
+wait_for_starvation_detected "${STALLD_LOG}"
 
 # Find tracked task
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
@@ -286,7 +283,7 @@ else
     log "Testing task merging on CPU ${CPU0} and CPU ${CPU1} independently"
 
     rm -f "${STALLD_LOG}"
-    start_stalld -f -v -g 1 -l -t $threshold -c ${CPU0},${CPU1} -a ${STALLD_CPU} > "${STALLD_LOG}" 2>&1
+    start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${CPU0},${CPU1} -a ${STALLD_CPU}
 
     # Create starvation on both CPUs
     log "Creating starvation on CPU ${CPU0}"
@@ -297,9 +294,8 @@ else
     start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 15
     STARVE_PID1=${STARVE_PID}
 
-    # Wait for multiple detection cycles (threshold + granularity + buffer, then more)
-    wait_time=$((threshold + 1 + 3))
-    sleep ${wait_time}
+    # Wait for starvation detection on both CPUs
+    wait_for_starvation_detected "${STALLD_LOG}"
     sleep 4
 
     # Check CPU0 starvation accumulation
-- 
2.53.0

