Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30113806A3
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899942; cv=none; b=sAfACcjlAPcZO5Q24hPXPLE0STeWVHSrXzYhC+RmAj78UiljJhYDdPgEMibYYVkvxZ09WPzUVepRV5v9GZkRRU1Ra/GJ8CUrKgWY6u31atJtJzzE4VLMNllyKz5ldcNrN6paXyAbtylmJo2fwN+zJuZ5cSWdE2PSCXkces9TDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899942; c=relaxed/simple;
	bh=IUtqvEoc8Z5Gk4S7LGaiK4nUGWUq9587lbEIJh3/GMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqL3+nTAuFqrXPllqYxqlz7NtRWGXuMCTwvNO/E35QBcjD45K2NTFBsLa0wzu65c10Qm+S+Rrcilce1zEUJqA8JPEXoHn7NWSiD+RJPpJfc6ZdtuOhgZY6DUUOlyUsQp2L1jP9aWHmNRe0Vro8TLxzlH97stg3dKY+fHG/PNqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYNOw27g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYNOw27g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C77tJoOjsf+9E4ntHW3sWXHs3G0kdAUvtUNhI4J7hKc=;
	b=TYNOw27gvCAqv3Hvo6oSe63O1sr6gvA4woT6ON7jqXS1Bi1cgxLT9Oj4BkLMK0AxKx3xS0
	pAWnuuQ5IdVJ61LYN6F5H67FEiZe/5zcJpy+vsSO0kJMgO2th8/8KFteRdWZCdWaiNCPl4
	7pVSS7iPNQWMUTlak3mTBXPDBLbeBMc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-gqNPzH-wMpW9RsWfsO4BRQ-1; Mon,
 30 Mar 2026 15:45:35 -0400
X-MC-Unique: gqNPzH-wMpW9RsWfsO4BRQ-1
X-Mimecast-MFC-AGG-ID: gqNPzH-wMpW9RsWfsO4BRQ_1774899934
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80D0A19560A6;
	Mon, 30 Mar 2026 19:45:34 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 424F81954102;
	Mon, 30 Mar 2026 19:45:30 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 18/36] tests/functional: Use start_starvation_gen() helper
Date: Mon, 30 Mar 2026 16:43:41 -0300
Message-ID: <20260330194410.103953-19-wander@redhat.com>
In-Reply-To: <20260330194410.103953-1-wander@redhat.com>
References: <20260330194410.103953-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Every functional test that creates starvation scenarios launches
starvation_gen manually: backgrounding the process, capturing the
PID, registering it for cleanup, and sleeping 1-3 seconds to wait
for startup. This duplicated boilerplate is fragile because the
sleep duration is an arbitrary guess that may be too short on slow
systems or too long on fast ones.

Replace all raw starvation_gen invocations across 14 test files
with the start_starvation_gen() helper introduced in Phase B. The
helper handles process management internally and uses event-driven
readiness detection instead of a fixed sleep, returning only after
starvation_gen confirms all threads are running. For tests that
need multiple simultaneous instances or use alternate PID variable
names, the global STARVE_PID is aliased immediately after the call.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_boost_duration.sh       | 16 ++------
 tests/functional/test_boost_period.sh         | 16 ++------
 tests/functional/test_boost_restoration.sh    | 24 +++---------
 tests/functional/test_boost_runtime.sh        | 16 ++------
 tests/functional/test_deadline_boosting.sh    | 26 ++++---------
 tests/functional/test_fifo_boosting.sh        | 35 +++---------------
 .../test_fifo_priority_starvation.sh          | 35 +++---------------
 tests/functional/test_force_fifo.sh           | 24 +++---------
 tests/functional/test_idle_detection.sh       |  8 +---
 tests/functional/test_log_only.sh             |  8 +---
 tests/functional/test_runqueue_parsing.sh     | 24 +++---------
 tests/functional/test_starvation_detection.sh | 37 ++++---------------
 tests/functional/test_starvation_threshold.sh | 21 ++---------
 tests/functional/test_task_merging.sh         | 22 ++++-------
 14 files changed, 70 insertions(+), 242 deletions(-)

diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index 4df5489..c835fd3 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -63,9 +63,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l > "${STA
 # Create starvation
 starvation_duration=15
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 wait_time=$((threshold + 2))
@@ -102,9 +100,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 log "Waiting ${wait_time}s for detection"
@@ -141,9 +137,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_d
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 
 # Wait for detection
 log "Waiting ${wait_time}s for detection"
@@ -179,9 +173,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${durati
 
 # Create starvation with a specific task we can track
 log "Creating starvation on CPU ${TEST_CPU} for 15s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 1 -d 15 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
 
 # Wait for detection
 log "Waiting ${wait_time}s for detection"
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index 97e0427..aab4436 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -60,9 +60,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -N > "${STALL
 # Create starvation
 starvation_duration=$((threshold + 5))
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 wait_time=$((threshold + 2))
@@ -104,9 +102,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $custom_pe
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 sleep ${wait_time}
@@ -139,9 +135,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $short_per
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 sleep ${wait_time}
@@ -174,9 +168,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t $threshold -p $long_peri
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 sleep ${wait_time}
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 1b8f809..beadf47 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -64,12 +64,9 @@ start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_dura
 
 # Create starvation (starvation_gen creates SCHED_FIFO blocker prio 80, blockee prio 1)
 log "Creating starvation with SCHED_FIFO tasks (blocker prio 80, blockee prio 1)"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -b 1 -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -b 1 -n 1 -d 20
 
 # Find the starved task
-sleep 2
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
 tracked_pid=""
 for child_pid in ${STARVE_CHILDREN}; do
@@ -201,11 +198,8 @@ chmod +x /tmp/fifo_task_$$.sh /tmp/fifo_task_running_$$.sh
 CLEANUP_FILES+=("/tmp/fifo_task_$$.sh" "/tmp/fifo_task_running_$$.sh")
 
 # Also create the blocker that will starve our FIFO task
-"${STARVE_GEN}" -c ${TEST_CPU} -p 90 -n 1 -d 20 &
-BLOCKER_PID=$!
-CLEANUP_PIDS+=("${BLOCKER_PID}")
-
-sleep 1
+start_starvation_gen -c ${TEST_CPU} -p 90 -n 1 -d 20
+BLOCKER_PID=${STARVE_PID}
 
 # Start our FIFO task on the same CPU (it will starve)
 bash /tmp/fifo_task_running_$$.sh &
@@ -294,9 +288,7 @@ start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_dura
 
 # Use -o flag to create SCHED_OTHER blockees
 log "Creating SCHED_OTHER starvation (RT blocker prio 80, SCHED_OTHER blockee)"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -o -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -o -n 1 -d 20
 
 # Wait for starvation_gen to complete
 log "Waiting for starvation test to complete..."
@@ -326,9 +318,7 @@ start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_dura
 
 # Create starvation
 log "Creating starvation"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
 # Wait for starvation detection
 sleep $((threshold + 1))
@@ -389,9 +379,7 @@ start_stalld -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_dura
 # This ensures the task exits DURING the boost period
 short_duration=$((threshold - 2))
 log "Creating starvation that will exit after ${short_duration}s"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d ${short_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d ${short_duration}
 
 # Give stalld time to detect starvation and start boosting
 # Need: threshold (10s) + buffer for detection (2s) = 12s
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index 0475da5..b8dfd1f 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -63,9 +63,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l > "${STA
 # Create starvation
 starvation_duration=10
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 wait_time=$((threshold + 2))
@@ -102,9 +100,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 log "Waiting ${wait_time}s for detection and boosting"
@@ -140,9 +136,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 log "Waiting ${wait_time}s for detection and boosting"
@@ -180,9 +174,7 @@ start_stalld -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 log "Waiting ${wait_time}s for detection and boosting"
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index d715186..de72100 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -63,9 +63,7 @@ start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALL
 # Create starvation
 starvation_duration=$((threshold + 8))
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting (threshold + granularity + buffer)
 # With -g 1, stalld checks every 1 second. In worst case, it checks just before
@@ -131,9 +129,7 @@ start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} \
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 15 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
 
 # Wait for boosting (threshold + granularity + buffer)
 wait_time=$((threshold + 1 + 3))
@@ -192,9 +188,7 @@ start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
 # Wait for starvation detection (threshold + granularity + buffer)
 wait_time=$((threshold + 1 + 3))
@@ -267,9 +261,7 @@ start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
 # Find a starved task and verify initial policy
 sleep 2
@@ -362,15 +354,13 @@ else
 
     # Create starvation on CPU0
     log "Creating starvation on CPU ${CPU0}"
-    "${STARVE_GEN}" -c ${CPU0} -p 80 -n 1 -d 15 &
-    STARVE_PID0=$!
-    CLEANUP_PIDS+=("${STARVE_PID0}")
+    start_starvation_gen -c ${CPU0} -p 80 -n 1 -d 15
+    STARVE_PID0=${STARVE_PID}
 
     # Create starvation on CPU1
     log "Creating starvation on CPU ${CPU1}"
-    "${STARVE_GEN}" -c ${CPU1} -p 80 -n 1 -d 15 &
-    STARVE_PID1=$!
-    CLEANUP_PIDS+=("${STARVE_PID1}")
+    start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 15
+    STARVE_PID1=${STARVE_PID}
 
     # Wait for detection and boosting (threshold + granularity + buffer)
     wait_time=$((threshold + 1 + 3))
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 7fbe297..a6168e9 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -56,12 +56,7 @@ threshold=5
 # Create starvation FIRST (before stalld starts)
 starvation_duration=$((threshold + 8))
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start and create actual starvation
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with -F flag to force SCHED_FIFO boosting"
 # Note: -F requires non-single-threaded mode (aggressive mode)
@@ -109,12 +104,7 @@ rm -f "${STALLD_LOG}"
 
 # Create starvation FIRST
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 15 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start and get child PIDs while they exist
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
 log "Starvation generator children PIDs: ${STARVE_CHILDREN}"
 
@@ -183,12 +173,7 @@ rm -f "${STALLD_LOG}"
 
 # Create starvation FIRST
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
 start_stalld -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} \
     -d ${boost_duration} -p ${boost_period} -r ${boost_runtime} \
@@ -233,12 +218,7 @@ STALLD_LOG_DEADLINE="/tmp/stalld_test_deadline_compare_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG_DEADLINE}")
 
 # Create starvation FIRST
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d 15 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Find a starved task and capture context switches immediately
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 15
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
 deadline_tracked_pid=""
 for child_pid in ${STARVE_CHILDREN}; do
@@ -281,12 +261,7 @@ STALLD_LOG_FIFO="/tmp/stalld_test_fifo_compare_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG_FIFO}")
 
 # Create starvation FIRST
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d 15 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Find a starved task and capture context switches immediately
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 15
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
 fifo_tracked_pid=""
 for child_pid in ${STARVE_CHILDREN}; do
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 3459f3c..cf47971 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -64,12 +64,7 @@ starvation_duration=$((threshold + 5))
 log "Creating FIFO-on-FIFO starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 log "  Blocker: SCHED_FIFO priority 10"
 log "  Blockee: SCHED_FIFO priority 5"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 10 -b 5 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start and pin to CPU
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
@@ -124,12 +119,7 @@ threshold=5
 boost_duration=3
 
 log "Creating FIFO-on-FIFO starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 10 -b 5 -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 1 -d 20
 
 # Find the starved task (blockee) PID
 STARVE_CHILDREN=$(pgrep -P ${STARVE_PID} 2>/dev/null)
@@ -198,12 +188,7 @@ threshold=3
 # Create long starvation to trigger multiple detection cycles
 starvation_duration=15
 log "Creating long FIFO-on-FIFO starvation for ${starvation_duration}s"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 10 -b 5 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 log "Will monitor for multiple detection cycles to verify timestamp preservation"
@@ -267,12 +252,7 @@ threshold=5
 log "Creating FIFO-on-FIFO starvation with close priorities"
 log "  Blocker: SCHED_FIFO priority 6"
 log "  Blockee: SCHED_FIFO priority 5"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 6 -b 5 -n 1 -d $((threshold + 5)) &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 6 -b 5 -n 1 -d $((threshold + 5))
 
 log "Starting stalld with ${threshold}s threshold"
 start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
@@ -309,12 +289,7 @@ rm -f "${STALLD_LOG}"
 threshold=5
 
 log "Creating FIFO-on-FIFO starvation"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 10 -b 5 -n 2 -d 20 -v &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start and print PIDs
-sleep 3
+start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 2 -d 20 -v
 
 # Extract blocker and blockee PIDs from starvation_gen output
 # The output shows "Blocker TID: <pid>" and "Blockee N TID: <pid>"
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index cab8003..4c43101 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -56,9 +56,7 @@ start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} > "${STALLD_LOG}" 2>&1
 # Create starvation
 starvation_duration=10
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 wait_time=$((threshold + 2))
@@ -104,9 +102,7 @@ start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F -A > "${STALLD_LOG2}" 2>&
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 log "Waiting ${wait_time}s for detection and boosting"
@@ -150,9 +146,7 @@ start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F -A > "${STALLD_LOG3}" 2>&
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
 log "Waiting ${wait_time}s for detection and boosting"
@@ -192,9 +186,7 @@ start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F -A -d ${boost_duration} >
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${long_starvation}
 
 # Wait for detection and boosting
 log "Waiting ${wait_time}s for detection and boosting"
@@ -270,9 +262,7 @@ CLEANUP_FILES+=("${STALLD_LOG_DL}")
 
 log "Running comparison test with SCHED_DEADLINE"
 start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -d ${comparison_duration} > "${STALLD_LOG_DL}" 2>&1
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${comparison_starvation} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${comparison_starvation}
 sleep $((threshold + 3))
 
 deadline_boosts=$(grep -c "boost" "${STALLD_LOG_DL}" || echo 0)
@@ -288,9 +278,7 @@ CLEANUP_FILES+=("${STALLD_LOG_FIFO}")
 
 log "Running comparison test with SCHED_FIFO"
 start_stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F -A -d ${comparison_duration} > "${STALLD_LOG_FIFO}" 2>&1
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${comparison_starvation} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${comparison_starvation}
 sleep $((threshold + 3))
 
 fifo_boosts=$(grep -c "boost" "${STALLD_LOG_FIFO}" || echo 0)
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index c3aa565..755a4b5 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -160,9 +160,7 @@ sleep 3
 
 # Now create load to make CPU busy
 log "Creating load on CPU ${TEST_CPU} to make it busy"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d 12 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 12
 
 # Wait for stalld to detect the busy CPU and starvation (threshold + granularity + buffer)
 log "Waiting for stalld to detect busy CPU and starvation..."
@@ -232,9 +230,7 @@ else
 
     # Create load only on CPU1, leave CPU0 idle
     log "Creating load on CPU ${CPU1} only"
-    "${STARVE_GEN}" -c ${CPU1} -p 80 -n 2 -d 12 &
-    STARVE_PID=$!
-    CLEANUP_PIDS+=("${STARVE_PID}")
+    start_starvation_gen -c ${CPU1} -p 80 -n 2 -d 12
 
     # Wait for detection (threshold + granularity + buffer)
     wait_time=$((threshold + 1 + 3))
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index cfd1b93..93c71cb 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -47,12 +47,8 @@ CLEANUP_FILES+=("${LOG_FILE}")
 echo "Creating starvation on CPU ${TEST_CPU} (will run for 15 seconds)"
 
 # Start starvation generator BEFORE stalld to ensure CPU is busy from the start
-${TEST_ROOT}/helpers/starvation_gen -c ${TEST_CPU} -p 10 -n 1 -d 15 &
-STARVGEN_PID=$!
-CLEANUP_PIDS+=("${STARVGEN_PID}")
-
-# Give the starvation generator time to start and monopolize the CPU
-sleep 1
+start_starvation_gen -c ${TEST_CPU} -p 10 -n 1 -d 15
+STARVGEN_PID=${STARVE_PID}
 
 # Start stalld in log-only mode with verbose output to capture logs
 echo "Starting stalld in log-only mode with 5 second threshold"
diff --git a/tests/functional/test_runqueue_parsing.sh b/tests/functional/test_runqueue_parsing.sh
index 2f23910..7edf936 100755
--- a/tests/functional/test_runqueue_parsing.sh
+++ b/tests/functional/test_runqueue_parsing.sh
@@ -98,9 +98,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
     # Create starvation to generate task data
     starvation_duration=$((threshold + 5))
     log "Creating starvation for ${starvation_duration}s"
-    "${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-    STARVE_PID=$!
-    CLEANUP_PIDS+=("${STARVE_PID}")
+    start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
     # Wait for detection (threshold + granularity + buffer)
     wait_time=$((threshold + 1 + 3))
@@ -159,9 +157,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     # Create starvation
     starvation_duration=$((threshold + 5))
     log "Creating starvation for ${starvation_duration}s"
-    "${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-    STARVE_PID=$!
-    CLEANUP_PIDS+=("${STARVE_PID}")
+    start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
     # Wait for detection (threshold + granularity + buffer)
     wait_time=$((threshold + 1 + 3))
@@ -229,9 +225,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     rm -f "${STALLD_LOG_BPF}"
     start_stalld -f -v -g 1 -l -b queue_track -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_BPF}" 2>&1
 
-    "${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-    STARVE_PID=$!
-    CLEANUP_PIDS+=("${STARVE_PID}")
+    start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
     wait_time=$((threshold + 1 + 3))
     sleep ${wait_time}
@@ -251,9 +245,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     rm -f "${STALLD_LOG_SCHED}"
     start_stalld -f -v -g 1 -l -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
 
-    "${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-    STARVE_PID=$!
-    CLEANUP_PIDS+=("${STARVE_PID}")
+    start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
     wait_time=$((threshold + 1 + 3))
     sleep ${wait_time}
@@ -320,9 +312,7 @@ if [ -n "$test_backend" ]; then
 
     # Create starvation with known parameters
     log "Creating starvation with known task name (starvation_gen)"
-    "${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 10 -v &
-    STARVE_PID=$!
-    CLEANUP_PIDS+=("${STARVE_PID}")
+    start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 10 -v
 
     # Wait for detection (threshold + granularity + buffer)
     wait_time=$((threshold + 1 + 3))
@@ -384,9 +374,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     start_stalld -f -v -g 1 -l -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
 
     # Create brief starvation just to initialize the backend
-    "${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 8 &
-    STARVE_PID=$!
-    CLEANUP_PIDS+=("${STARVE_PID}")
+    start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 8
 
     wait_time=$((threshold + 1 + 3))
     sleep ${wait_time}
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 89901d3..6a1821d 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -67,12 +67,7 @@ threshold=5
 # Create starvation BEFORE starting stalld to avoid idle detection race
 starvation_duration=$((threshold + 5))
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start and pin to CPU
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
@@ -129,12 +124,7 @@ threshold=5
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 15 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
 
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
@@ -194,12 +184,7 @@ threshold=3
 # Create long starvation to trigger multiple detection cycles
 starvation_duration=15
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start
-sleep 2
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 log "Will monitor for multiple detection cycles to verify timestamp preservation"
@@ -292,18 +277,13 @@ else
 
     # Create starvation on CPU0
     log "Creating starvation on CPU ${CPU0}"
-    "${STARVE_GEN}" -c ${CPU0} -p 80 -n 1 -d 12 &
-    STARVE_PID0=$!
-    CLEANUP_PIDS+=("${STARVE_PID0}")
+    start_starvation_gen -c ${CPU0} -p 80 -n 1 -d 12
+    STARVE_PID0=${STARVE_PID}
 
     # Create starvation on CPU1
     log "Creating starvation on CPU ${CPU1}"
-    "${STARVE_GEN}" -c ${CPU1} -p 80 -n 1 -d 12 &
-    STARVE_PID1=$!
-    CLEANUP_PIDS+=("${STARVE_PID1}")
-
-    # Give starvation generators time to start
-    sleep 2
+    start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 12
+    STARVE_PID1=${STARVE_PID}
 
     start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${CPU0},${CPU1} -a ${STALLD_CPU_MULTI}
 
@@ -394,8 +374,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a $
 
 # Create short-lived starvation that exits before threshold
 log "Creating short-lived starvation (3s, less than ${threshold}s threshold)"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 3 &
-STARVE_PID=$!
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 3
 
 # Wait for task to exit
 sleep 5
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 41a2cca..45a4679 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -65,12 +65,7 @@ threshold=5
 # Create starvation BEFORE starting stalld (avoid detecting kworker tasks)
 starvation_duration=10
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start and create actual starvation
-sleep 2
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold"
 # Use -i to ignore kernel workers that may starve before our test tasks
@@ -115,12 +110,7 @@ CLEANUP_FILES+=("${STALLD_LOG2}")
 # Create starvation that will last 6 seconds (less than threshold)
 starvation_duration=6
 log "Creating short starvation (${starvation_duration}s) with threshold of ${threshold}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start and create actual starvation
-sleep 2
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold"
 start_stalld -f -v -N -M -g 1 -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold} > "${STALLD_LOG2}" 2>&1
@@ -165,12 +155,7 @@ CLEANUP_FILES+=("${STALLD_LOG3}")
 # Create starvation for 8 seconds
 starvation_duration=8
 log "Creating starvation for ${starvation_duration}s with threshold of ${threshold}s"
-"${STARVE_GEN}" -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
-
-# Give starvation generator time to start and create actual starvation
-sleep 2
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold"
 # Use -i to ignore kernel workers that may starve before our test tasks
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 053c648..1bea759 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -70,9 +70,7 @@ start_stalld -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${ST
 # Create long starvation to span multiple monitoring cycles
 starvation_duration=18
 log "Creating starvation for ${starvation_duration}s (multiple detection cycles)"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration} &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for first detection (threshold + granularity + buffer)
 log "Waiting for first detection cycle..."
@@ -150,9 +148,7 @@ start_stalld -f -v -g 1 -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${ST
 
 # Create starvation
 log "Creating starvation"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
 # Wait for detection (threshold + granularity + buffer)
 wait_time=$((threshold + 1 + 3))
@@ -226,9 +222,7 @@ start_stalld -f -v -g 1 -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d 2 > "${
 
 # Create starvation that will get boosted (allowing progress)
 log "Creating starvation that will be boosted"
-"${STARVE_GEN}" -c ${TEST_CPU} -p 80 -n 1 -d 20 &
-STARVE_PID=$!
-CLEANUP_PIDS+=("${STARVE_PID}")
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
 
 # Wait for first detection and boost (threshold + granularity + buffer)
 wait_time=$((threshold + 1 + 3))
@@ -296,14 +290,12 @@ else
 
     # Create starvation on both CPUs
     log "Creating starvation on CPU ${CPU0}"
-    "${STARVE_GEN}" -c ${CPU0} -p 80 -n 1 -d 15 &
-    STARVE_PID0=$!
-    CLEANUP_PIDS+=("${STARVE_PID0}")
+    start_starvation_gen -c ${CPU0} -p 80 -n 1 -d 15
+    STARVE_PID0=${STARVE_PID}
 
     log "Creating starvation on CPU ${CPU1}"
-    "${STARVE_GEN}" -c ${CPU1} -p 80 -n 1 -d 15 &
-    STARVE_PID1=$!
-    CLEANUP_PIDS+=("${STARVE_PID1}")
+    start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 15
+    STARVE_PID1=${STARVE_PID}
 
     # Wait for multiple detection cycles (threshold + granularity + buffer, then more)
     wait_time=$((threshold + 1 + 3))
-- 
2.53.0

