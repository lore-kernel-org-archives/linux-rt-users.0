Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214283E1216
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943615; cv=none; b=nLXHvAKHpCsy6a/PJMCj7bDBHu8IAOlyL35Fy0fYv7jXaRPBpkVWMF5NiU9fee8z0Sd4q5vn0dDi/vzJc2OEdEsbofVUqMev9FIfhjHYCREJLu4bPDscvd+XWL1d421aPh0tdPp4ar07kke8cziU4fufnQNZxJ2HqOJtNs9wy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943615; c=relaxed/simple;
	bh=Va+G0dF+wvpH+Ld3c8sk86uvjdXRKE6cSUbzES5Mru8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlcCEhr8GnX5rQjb8IPbxZNisaQoQDfc7wakahvvDpPqGUToXZQiErrqgBG2qTiAtAdzdqrSN8D/9J9lwfjO2SQJVXffR6erCVTwq6gKlGY0wEJX0P+iphJwc/fDYqJkLNu95ihOpxOqTcaUKtuTnDVBCZnPnzoPpBLkO9Po3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCaU14Oq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCaU14Oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wr4BZuQ7q0yyEZY4QfDU8AaY+3QdUNw6CbSHNZeW8yg=;
	b=dCaU14OqZY3A23f7cKW1DVKqgGVx7sbYi+Xq6Urs2rf7H/tLVLAh6EwXtfc3pUGNbbpnGE
	5TfIzqaXDPh2MWT9+iv/AorD8vRgKa68tnfvg7mM9M4h6l35RjuqjyYPzURAkxksoNdPHn
	GyoUPREgr2EMzrJtfmJDRLx+PAqK3UU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-MUIslbysPMudnND9_dFjHg-1; Mon,
 08 Jun 2026 14:33:29 -0400
X-MC-Unique: MUIslbysPMudnND9_dFjHg-1
X-Mimecast-MFC-AGG-ID: MUIslbysPMudnND9_dFjHg_1780943608
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D52591977039;
	Mon,  8 Jun 2026 18:33:28 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD31936927;
	Mon,  8 Jun 2026 18:33:26 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 27/52] tests: Reduce starvation_gen durations
Date: Mon,  8 Jun 2026 15:31:37 -0300
Message-ID: <20260608183206.140526-28-wander@redhat.com>
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

Reduce starvation_gen durations across eight functional test files to
eliminate unnecessary wait times. The generator runs for its full
duration regardless of whether test assertions have already completed,
meaning the previous literal values of 20 and 15 seconds wasted up to
10 seconds per test section. Across the full suite, this accumulated
into significant idle time.

With a typical threshold of 5 seconds, the generator only needs to run
long enough for detection plus a safety margin. Applying a formula of
threshold plus boost duration plus a 4-second margin yields an optimal
12 seconds for standard tests. For detection-only tests lacking a
boost, a 10-second duration provides ample margin.

Update seven instances of 20-second durations to 12 seconds and nine
instances of 15-second durations to 10 seconds, along with two
corresponding log messages. Values already optimized at 12 or 3
seconds, as well as variable-based durations computed directly from
thresholds, remain unchanged since they already scale proportionally.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_boost_duration.sh           | 4 ++--
 tests/functional/test_boost_restoration.sh        | 4 ++--
 tests/functional/test_deadline_boosting.sh        | 8 ++++----
 tests/functional/test_fifo_boosting.sh            | 4 ++--
 tests/functional/test_fifo_priority_starvation.sh | 4 ++--
 tests/functional/test_log_only.sh                 | 4 ++--
 tests/functional/test_starvation_detection.sh     | 2 +-
 tests/functional/test_task_merging.sh             | 6 +++---
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index 821dffe..d754977 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -92,8 +92,8 @@ log "Starting stalld with ${threshold}s threshold and ${duration}s boost duratio
 start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration}
 
 # Create starvation with a specific task we can track
-log "Creating starvation on CPU ${TEST_CPU} for 15s"
-start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
+log "Creating starvation on CPU ${TEST_CPU} for 10s"
+start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 10
 
 # Wait for actual boosting
 assert_boost_detected "${STALLD_LOG}" "Boost with ${duration}s boost duration"
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 62c37b0..6a71644 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -33,7 +33,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${ST
 
 # Create starvation (starvation_gen creates SCHED_FIFO blocker prio 80, blockee prio 1)
 log "Creating starvation with SCHED_FIFO tasks (blocker prio 80, blockee prio 1)"
-start_starvation_gen -c ${TEST_CPU} -p 80 -b 1 -n 1 -d 20
+start_starvation_gen -c ${TEST_CPU} -p 80 -b 1 -n 1 -d 12
 
 # Find the starved task
 tracked_pid=$(find_starved_child "${STARVE_PID}")
@@ -120,7 +120,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${ST
 
 # Use -o flag to create SCHED_OTHER blockees
 log "Creating SCHED_OTHER starvation (RT blocker prio 80, SCHED_OTHER blockee)"
-start_starvation_gen -c ${TEST_CPU} -p 80 -o -n 1 -d 20
+start_starvation_gen -c ${TEST_CPU} -p 80 -o -n 1 -d 12
 
 # Find the starved SCHED_OTHER task
 tracked_pid=$(find_starved_child "${STARVE_PID}")
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 094c146..305c641 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -64,7 +64,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 10
 
 # Try to find the boosted task PID before it gets boosted
 tracked_pid=$(find_starved_child "${STARVE_PID}")
@@ -106,7 +106,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -t $threshold -c ${TEST_CPU} -a
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 12
 
 # Find a starved task before it gets boosted
 tracked_pid=$(find_starved_child "${STARVE_PID}")
@@ -165,12 +165,12 @@ else
 
     # Create starvation on CPU0
     log "Creating starvation on CPU ${CPU0}"
-    start_starvation_gen -c ${CPU0} -p 80 -n 1 -d 15
+    start_starvation_gen -c ${CPU0} -p 80 -n 1 -d 10
     STARVE_PID0=${STARVE_PID}
 
     # Create starvation on CPU1
     log "Creating starvation on CPU ${CPU1}"
-    start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 15
+    start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 10
     STARVE_PID1=${STARVE_PID}
 
     # Wait for boosting on both CPUs
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index cabc740..57c473d 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -50,7 +50,7 @@ rm -f "${STALLD_LOG}"
 
 # Create starvation FIRST
 log "Creating starvation on CPU ${TEST_CPU}"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 10
 tracked_pid=$(find_starved_child "${STARVE_PID}")
 
 log "Starting stalld with -F flag (FIFO boosting)"
@@ -103,7 +103,7 @@ rm -f "${STALLD_LOG}"
 
 # Create starvation FIRST
 log "Creating starvation on CPU ${TEST_CPU}"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 12
 
 start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -N -F -A -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} \
     -d ${boost_duration} -p ${boost_period} -r ${boost_runtime}
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 072c951..66075d4 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -58,7 +58,7 @@ threshold=5
 boost_duration=3
 
 log "Creating FIFO-on-FIFO starvation on CPU ${TEST_CPU}"
-start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 1 -d 20
+start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 1 -d 12
 
 # Find the starved task (blockee) PID
 blockee_pid=$(find_starved_child "${STARVE_PID}")
@@ -180,7 +180,7 @@ rm -f "${STALLD_LOG}"
 threshold=5
 
 log "Creating FIFO-on-FIFO starvation"
-start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 2 -d 20 -v
+start_starvation_gen -c ${TEST_CPU} -p 10 -b 5 -n 2 -d 12 -v
 
 # Extract blocker and blockee PIDs from starvation_gen output
 # The output shows "Blocker TID: <pid>" and "Blockee N TID: <pid>"
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index 824ef7a..b38db70 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -44,10 +44,10 @@ echo "Stalld will run on CPU ${STALLD_CPU}"
 LOG_FILE="/tmp/stalld_test_log_only_$$.log"
 CLEANUP_FILES+=("${LOG_FILE}")
 
-echo "Creating starvation on CPU ${TEST_CPU} (will run for 15 seconds)"
+echo "Creating starvation on CPU ${TEST_CPU} (will run for 10 seconds)"
 
 # Start starvation generator BEFORE stalld to ensure CPU is busy from the start
-start_starvation_gen -c ${TEST_CPU} -p 10 -n 1 -d 15
+start_starvation_gen -c ${TEST_CPU} -p 10 -n 1 -d 10
 STARVGEN_PID=${STARVE_PID}
 
 # Start stalld in log-only mode with verbose output to capture logs
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 9362899..33bbfed 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -52,7 +52,7 @@ threshold=5
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU}"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 15
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 10
 
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index 5e03622..082f07d 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -101,7 +101,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -l -t $threshold -c ${TEST_CPU}
 
 # Create starvation
 log "Creating starvation"
-start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 20
+start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 12
 
 # Wait for starvation detection
 wait_for_starvation_detected "${STALLD_LOG}"
@@ -174,11 +174,11 @@ else
 
     # Create starvation on both CPUs
     log "Creating starvation on CPU ${CPU0}"
-    start_starvation_gen -c ${CPU0} -p 80 -n 1 -d 15
+    start_starvation_gen -c ${CPU0} -p 80 -n 1 -d 10
     STARVE_PID0=${STARVE_PID}
 
     log "Creating starvation on CPU ${CPU1}"
-    start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 15
+    start_starvation_gen -c ${CPU1} -p 80 -n 1 -d 10
     STARVE_PID1=${STARVE_PID}
 
     # Wait for starvation detection on both CPUs
-- 
2.54.0

