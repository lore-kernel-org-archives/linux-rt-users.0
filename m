Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B171E98EF
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285697; cv=none; b=Rh2HASdIpT8R2iUdl6jQzyctgygYCT2qs+0TobdQcmLzBszu9Etz+BIUwEUi/kIkCOqKE1nS730f/VqzRAAwv5c3ZGlzpjlRMbgyyGdb5CQwIUv6wK3vdq0mtwM0WKO4axIMRAFyP8Gf5R6mmniLeIk0c6cQTqPhArh/GlMjB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285697; c=relaxed/simple;
	bh=d9ZJkqh/Za2FdoVE2v6wJ2/uyYJpSvPVX8SUNjuMqEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl/JeHNRybylurzK6jwz5XtfQ5YcsFQs0PYDIyji4VQmwYdZxE8ol4VbAcQVRviIb0ynnRMQjeic77tpixX0PLtA5DC+doZnd0X0XMrnr7WrqqYR+gyT+FXi2WzK8Cmw6sgUMEmunb+3cAi7S99qlbP7eu3J+3T+wgvg32ylp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoJW6cyC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoJW6cyC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5n8864/3hSR9f4m+W6T6654Gq9kD34teKrWo2J5evs=;
	b=FoJW6cyCiK/wwzND6iEG0KGUlRNSFTj42TN+G3+qtkyNUFepErVXEEOlGCyDd4P24WQOAM
	qOeQTNEa6PE72Flm4FUi5c2Mzol9hLkkxex/mUUdIB27KnZQ3G27Sq8L0G7hEil3uCbEGp
	oo98r+qnkvACazWDnygP9k94+SZVqHU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-2GkmtSyTN7yCKhp1U_K_xA-1; Wed,
 20 May 2026 10:01:33 -0400
X-MC-Unique: 2GkmtSyTN7yCKhp1U_K_xA-1
X-Mimecast-MFC-AGG-ID: 2GkmtSyTN7yCKhp1U_K_xA_1779285692
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03892180060C;
	Wed, 20 May 2026 14:01:32 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4212C1800465;
	Wed, 20 May 2026 14:01:29 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 06/33] tests: Fix task exit timing in test_boost_restoration
Date: Wed, 20 May 2026 11:00:33 -0300
Message-ID: <20260520140104.112142-7-wander@redhat.com>
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

