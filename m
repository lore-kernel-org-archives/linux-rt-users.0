Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3B3E0241
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943557; cv=none; b=R86RWHYrrkRbQjCAyq4Qq3OwIdik0FygV61aCvTbbEdjT8lJYrS1FwPYkawYWHvwgoN4t53e0pVbIsvskxGGQfSpp+qheJ2fzhf+RjEQdQkq7pavU3g3dap7VYIzLesxsYD6S0qy9YtFHh5nir07iFya7g74rBYXYlrhYJO7f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943557; c=relaxed/simple;
	bh=d9ZJkqh/Za2FdoVE2v6wJ2/uyYJpSvPVX8SUNjuMqEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6vdSOK5lONGXxCBB2xF5ENM3ND4OvuM5nBLULNMhhpQEHkuR34azRZM9VQHAnjHcUDI8V7Fir+5UbAtwWBSI+0ERrBnkXYoNVdJqT1qlSErPc1x/Vz02t2m0ByvAk8wtHkDetfVr2w7PoVsKhb2na+7dYRBhHzWWPFFi6+3ciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkPk1XRL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkPk1XRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5n8864/3hSR9f4m+W6T6654Gq9kD34teKrWo2J5evs=;
	b=KkPk1XRLyNw7BvtOG+KIIkNHlJVbLNp/fSLI2rnkCform99HkmxCE+An3opMb59zCXTub+
	J8YF0loSx5uiFWN/c5XvXfE1ZmLDUGwdZ9k1UPMDZLPeykvYw2hHwjLHSwzuX9uoBddWRz
	VlYi09+tuw92ASxII7YyJEpvLESRsok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-EPUtI-FTP9y7o3_rf01hZg-1; Mon,
 08 Jun 2026 14:32:32 -0400
X-MC-Unique: EPUtI-FTP9y7o3_rf01hZg-1
X-Mimecast-MFC-AGG-ID: EPUtI-FTP9y7o3_rf01hZg_1780943551
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F068197702C;
	Mon,  8 Jun 2026 18:32:31 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C13B436927;
	Mon,  8 Jun 2026 18:32:27 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 06/52] tests: Fix task exit timing in test_boost_restoration
Date: Mon,  8 Jun 2026 15:31:16 -0300
Message-ID: <20260608183206.140526-7-wander@redhat.com>
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

Test 5 verifies that stalld handles a task exiting during an active
boost. The starvation duration was set to threshold minus two seconds,
causing the task to exit before the detection threshold was reached.
As a result, the task was never boosted and the test silently passed
without exercising the intended code path.

Lower the threshold and compute the starvation duration as threshold
plus three seconds so that the task survives long enough to be
detected and boosted, then exits mid-boost as originally intended.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_boost_restoration.sh | 10 +++++-----
 tests/functional/test_runqueue_parsing.sh  | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index fb886bd..c2a04f3 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -338,16 +338,16 @@ sleep 1
 #=============================================================================
 test_section "Test 5: Graceful Handling of Task Exit During Boost"
 
-threshold=10
-boost_duration=5  # Task will exit during boost (after 8s, boost is 5s)
+threshold=5
+boost_duration=5
 
 log "Starting stalld with ${threshold}s threshold, ${boost_duration}s boost (task will exit during boost)"
 rm -f "${STALLD_LOG}"
 start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration} -N -i "kworker"
 
-# Create starvation that exits after threshold - 2s (so 8s)
-# This ensures the task exits DURING the boost period
-short_duration=$((threshold - 2))
+# Task must survive past the threshold to be detected and boosted,
+# then exit during the boost window.
+short_duration=$((threshold + 3))
 log "Creating starvation that will exit after ${short_duration}s"
 start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d ${short_duration}
 
diff --git a/tests/functional/test_runqueue_parsing.sh b/tests/functional/test_runqueue_parsing.sh
index f5c2861..a4dc180 100755
--- a/tests/functional/test_runqueue_parsing.sh
+++ b/tests/functional/test_runqueue_parsing.sh
@@ -90,7 +90,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
     threshold=5
     log "Starting stalld with eBPF backend (queue_track)"
     # Use -g 1 for 1-second granularity
-    start_stalld -f -v -g 1 -l -b queue_track -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_BPF}" 2>&1
+    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b queue_track -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_BPF}" 2>&1
 
     # Create starvation to generate task data
     starvation_duration=$((threshold + 5))
@@ -135,7 +135,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
 
     threshold=5
     log "Starting stalld with sched_debug backend"
-    start_stalld -f -v -g 1 -l -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
+    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
 
     # Create starvation
     starvation_duration=$((threshold + 5))
@@ -192,7 +192,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     log ""
     log "Running with eBPF backend..."
     rm -f "${STALLD_LOG_BPF}"
-    start_stalld -f -v -g 1 -l -b queue_track -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_BPF}" 2>&1
+    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b queue_track -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_BPF}" 2>&1
 
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
@@ -209,7 +209,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     log ""
     log "Running with sched_debug backend..."
     rm -f "${STALLD_LOG_SCHED}"
-    start_stalld -f -v -g 1 -l -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
+    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
 
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
@@ -264,7 +264,7 @@ if [ -n "$test_backend" ]; then
     log "Testing task field extraction with ${test_backend} backend"
 
     rm -f "${log_file}"
-    start_stalld -f -v -g 1 -l -b ${test_backend} -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${log_file}" 2>&1
+    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b ${test_backend} -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${log_file}" 2>&1
 
     # Create starvation with known parameters
     log "Creating starvation with known task name (starvation_gen)"
@@ -317,7 +317,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
 
     threshold=5
     rm -f "${STALLD_LOG_SCHED}"
-    start_stalld -f -v -g 1 -l -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
+    start_stalld -f -v -g 1 -N -l -i "kworker,ksoftirqd" -b sched_debug -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} > "${STALLD_LOG_SCHED}" 2>&1
 
     # Create brief starvation just to initialize the backend
     start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 8
-- 
2.54.0

