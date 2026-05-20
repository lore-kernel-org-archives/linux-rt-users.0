Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC073E6385
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285707; cv=none; b=Oe9D/rcdOyYyfoNuVVMJ+VpRAgd2m9apuDsee22c4+pIF6dcB6Mgmodm5pYDubJIQQPjonDoMb9+fomIuGrT9tKxvq4CjD2PPpYeUAv5JTSWeG2A5PZ2Qjzzr4ZYKiefVcST8zwKa3u9OjHMscRMFe5oVK0PexyGJLUt4a+VUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285707; c=relaxed/simple;
	bh=aEmTF3vkCcRYNJi7kxG/nU6JLh8lJol6yrsA03vpS5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUhtPcMIjFrT9jSMuPeuBWqoxu49gTaHLWdZ2XZQi/1mGLzBmKUqnBaPd1J8h8S/UwG0tGMZ+dWE8sXtiKHtaooqGiUAtC4Shc9A+A4ZNotu6FELbwdr1EWys64JSW52QmBL1jtS8EzT/JDEXmOiLlMLe6K6XCB8SD8mUdNUCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsRl4pNR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsRl4pNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9Lw3ikbXeeZND7sbOiy5BblTHruExh93YZoX/4wtTo=;
	b=HsRl4pNRBERR1a0x2VImq5ZorGSDTPuP9AoN6sGN8+B31jhBe4wi5Vpnqb2YuhWVm+MK8t
	cfMtLH+c8SZXPorlDoBNwKdubFmM9iEojRRSGqtFYrzd/lBPqk3NKMUDIWw+XRjXBJ+oM3
	0IToO/ELnM+mXnFOp2pFWK6DGSxbXjM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-NBiYOv9DPi-mRueOfd8F-g-1; Wed,
 20 May 2026 10:01:40 -0400
X-MC-Unique: NBiYOv9DPi-mRueOfd8F-g-1
X-Mimecast-MFC-AGG-ID: NBiYOv9DPi-mRueOfd8F-g_1779285700
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA82A1956059;
	Wed, 20 May 2026 14:01:39 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF9B31800352;
	Wed, 20 May 2026 14:01:37 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 09/33] tests: Fix boost verification in runtime and duration tests
Date: Wed, 20 May 2026 11:00:36 -0300
Message-ID: <20260520140104.112142-10-wander@redhat.com>
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

The boost runtime and duration tests were previously passing the
log-only flag (-l) to stalld. This caused the daemon to detect
starvation but never actually boost tasks. Furthermore, the tests
used assert_starvation_detected, which only verified that starvation
was noticed rather than confirming a successful boost. As a result,
the tests passed trivially without validating the -r and -d options.

Remove the log-only flag so stalld operates in normal mode and
switch the assertions to assert_boost_detected.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_boost_duration.sh | 24 ++++++++++++------------
 tests/functional/test_boost_runtime.sh  | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index e9a2135..aa46e84 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -22,15 +22,15 @@ test_section "Test 1: Default boost duration (no -d specified)"
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default boost duration)"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold}
 
 # Create starvation
 starvation_duration=15
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection occurred with default duration"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with default duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -44,14 +44,14 @@ short_duration=1
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${short_duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_duration}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${short_duration}s duration"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with ${short_duration}s duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -67,14 +67,14 @@ threshold=10
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${long_duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_duration}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 
-# Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${long_duration}s duration"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with ${long_duration}s duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -89,14 +89,14 @@ duration=2
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration}
 
 # Create starvation with a specific task we can track
 log "Creating starvation on CPU ${TEST_CPU} for 15s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
 
-# Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${duration}s boost duration"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with ${duration}s boost duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index dfecccc..caaeb1d 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -22,15 +22,15 @@ test_section "Test 1: Default runtime (no -r specified)"
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default boost runtime)"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold}
 
 # Create starvation
 starvation_duration=10
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with default runtime"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with default runtime"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -44,14 +44,14 @@ custom_runtime=10000
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${custom_runtime}ns runtime"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom_runtime} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom_runtime}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with custom runtime ${custom_runtime}ns"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with custom runtime ${custom_runtime}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -65,14 +65,14 @@ large_runtime=100000
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${large_runtime}ns runtime"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_runtime} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_runtime}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with large runtime ${large_runtime}ns"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with large runtime ${large_runtime}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -88,14 +88,14 @@ period=1000000000
 rm -f "${STALLD_LOG}"
 
 log "Starting stalld with runtime ${valid_runtime}ns < period ${period}ns"
-start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_runtime} -p ${period} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_runtime} -p ${period}
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
-# Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG}" "Starvation detection with runtime < period"
+# Wait for actual boosting
+assert_boost_detected "${STALLD_LOG}" "Boost with runtime ${valid_runtime}ns < period ${period}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
-- 
2.54.0

