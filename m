Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6803E5EF8
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285706; cv=none; b=R1vAa4crnyD/QrIexyXea27eFcBAmgDX6HZKE0d+ha3+pM5v96uzqNc7VnvSfpIFs2x8mzMGAyEh61z00ZARFj8Hvrx+zsKZzZXQ7ANH20lcFivLQeReLx0p/40nx/RjaXxWT7pl1i3uMgHIF21YzxN/Y3bjRhv4/C44fsbLsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285706; c=relaxed/simple;
	bh=8HPy3QzAGfTIpNn5I2rJu0BtQovQCZSh2cCv6CJsOb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiDPCEMRob0i5gFSa7hCP8hrqE1/1QKZqy2XEfUeLnD+SmizCo2ycjgLz5chntVohQW5JKSczSvB6GL8a373AQDQob9VaXiKautR3JsS5Fu3zIKCyFB8LYghLPNUCsmTOrcl+xVKP7b7sGiCBKnhtLGhfyJ4IAsp52Y+UQXlCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdfP6Ryw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdfP6Ryw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UW4DrrUcmN96P9blYs9kdXdjpW/I02QK5BNf7v+GnRE=;
	b=CdfP6Rywd6thKdtdTeN6RxJP9srXlywRrxk6Rs4bJmTMSZl0lMqBOLMwe4YRctVkrInJUR
	As5xqzmFutyOoqBXOuNB8V2FtyepZHzfkZ9dcgNx/BhSVWOxlvhYQYPajOIlXIOMgr6NaU
	lTXTobLyQRnGlVvjcDGlAsJF9jzw/RI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-OChoxj14P72WeujynG8YDg-1; Wed,
 20 May 2026 10:01:29 -0400
X-MC-Unique: OChoxj14P72WeujynG8YDg-1
X-Mimecast-MFC-AGG-ID: OChoxj14P72WeujynG8YDg_1779285680
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31CF21955F2F;
	Wed, 20 May 2026 14:01:20 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE41A1800465;
	Wed, 20 May 2026 14:01:17 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 02/33] tests: Introduce test_section() helper
Date: Wed, 20 May 2026 11:00:29 -0300
Message-ID: <20260520140104.112142-3-wander@redhat.com>
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

The functional test suite contains over a hundred instances of
repetitive boilerplate for printing section banners. This clutters the
test files and leads to inconsistent logging, with some tests using
standard echo while others use the journal-integrated log function.

Introduce a centralized test_section() helper function in the test
helpers script to standardize section banner formatting. Update all
functional test files to replace the multi-line banner boilerplate
with single-line calls to this new helper.

The helper is exported to ensure it remains available within subshells
used throughout the test suite. This migration standardizes all section
banners to use the journal-integrated log function, improving test
traceability while removing nearly 300 lines of redundant code.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_affinity.sh             | 40 +++------------
 tests/functional/test_backend_selection.sh    | 13 ++---
 tests/functional/test_boost_duration.sh       | 25 ++--------
 tests/functional/test_boost_period.sh         | 35 +++----------
 tests/functional/test_boost_restoration.sh    | 30 +++--------
 tests/functional/test_boost_runtime.sh        | 35 +++----------
 tests/functional/test_cpu_selection.sh        | 18 +++----
 tests/functional/test_deadline_boosting.sh    | 30 +++--------
 tests/functional/test_fifo_boosting.sh        | 30 +++--------
 .../test_fifo_priority_starvation.sh          | 30 +++--------
 tests/functional/test_force_fifo.sh           | 30 +++--------
 tests/functional/test_foreground.sh           |  8 ++-
 tests/functional/test_idle_detection.sh       | 30 +++--------
 tests/functional/test_logging_destinations.sh | 11 ++--
 tests/functional/test_pidfile.sh              | 33 +++---------
 tests/functional/test_runqueue_parsing.sh     | 50 ++++---------------
 tests/functional/test_starvation_detection.sh | 35 +++----------
 tests/functional/test_starvation_threshold.sh | 20 ++------
 tests/functional/test_task_merging.sh         | 25 ++--------
 tests/helpers/test_helpers.sh                 | 11 +++-
 20 files changed, 124 insertions(+), 415 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index 7ecd85f..d745b08 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -70,10 +70,7 @@ CLEANUP_FILES+=("${STALLD_LOG}")
 #=============================================================================
 # Test 1: Default behavior (no -a specified)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Default behavior (no affinity restriction)"
-log "=========================================="
+test_section "Test 1: Default behavior (no affinity restriction)"
 
 start_stalld -f -v -l -t 5
 sleep 2
@@ -93,10 +90,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Single CPU affinity
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Single CPU affinity (-a 0)"
-log "=========================================="
+test_section "Test 2: Single CPU affinity (-a 0)"
 
 STALLD_LOG2="/tmp/stalld_test_affinity_test2_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG2}")
@@ -117,10 +111,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Multi-CPU affinity (CPU list)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Multi-CPU affinity (-a 0,2)"
-log "=========================================="
+test_section "Test 3: Multi-CPU affinity (-a 0,2)"
 
 if [ "$num_cpus" -ge 4 ]; then
     STALLD_LOG3="/tmp/stalld_test_affinity_test3_$$.log"
@@ -147,10 +138,7 @@ fi
 #=============================================================================
 # Test 4: CPU range affinity
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: CPU range affinity (-a 0-2)"
-log "=========================================="
+test_section "Test 4: CPU range affinity (-a 0-2)"
 
 if [ "$num_cpus" -ge 4 ]; then
     STALLD_LOG4="/tmp/stalld_test_affinity_test4_$$.log"
@@ -176,10 +164,7 @@ fi
 #=============================================================================
 # Test 5: Verify stalld actually runs on specified CPU
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Verify stalld threads run on specified CPU"
-log "=========================================="
+test_section "Test 5: Verify stalld threads run on specified CPU"
 
 if [ "$num_cpus" -ge 2 ]; then
     test_cpu=1
@@ -212,10 +197,7 @@ fi
 #=============================================================================
 # Test 6: Combined with CPU monitoring (-c and -a)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 6: Combined affinity and monitoring (-a 0 -c 1)"
-log "=========================================="
+test_section "Test 6: Combined affinity and monitoring (-a 0 -c 1)"
 
 if [ "$num_cpus" -ge 2 ]; then
     STALLD_LOG6="/tmp/stalld_test_affinity_test6_$$.log"
@@ -248,10 +230,7 @@ fi
 #=============================================================================
 # Test 7: Invalid CPU affinity
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 7: Invalid CPU affinity (-a 999)"
-log "=========================================="
+test_section "Test 7: Invalid CPU affinity (-a 999)"
 
 invalid_cpu=999
 INVALID_LOG="/tmp/stalld_test_affinity_invalid_$$.log"
@@ -275,10 +254,7 @@ fi
 #=============================================================================
 # Test 8: Verify affinity persists
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 8: Verify affinity persists over time"
-log "=========================================="
+test_section "Test 8: Verify affinity persists over time"
 
 STALLD_LOG8="/tmp/stalld_test_affinity_test8_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG8}")
diff --git a/tests/functional/test_backend_selection.sh b/tests/functional/test_backend_selection.sh
index 2db8353..049277a 100755
--- a/tests/functional/test_backend_selection.sh
+++ b/tests/functional/test_backend_selection.sh
@@ -57,13 +57,12 @@ test_backend_flag() {
 }
 
 # Test 1: sched_debug backend (full name)
-echo "Test 1: Starting stalld with sched_debug backend"
+test_section "Test 1: Starting stalld with sched_debug backend"
 test_backend_flag "sched_debug" "using sched_debug backend" \
 	"sched_debug backend selected"
 
 # Test 2: queue_track backend (if available)
-echo ""
-echo "Test 2: Check queue_track (BPF) backend"
+test_section "Test 2: Check queue_track (BPF) backend"
 if is_backend_available "queue_track"; then
 	test_backend_flag "queue_track" "using queue_track backend" \
 		"queue_track backend selected"
@@ -74,15 +73,13 @@ else
 fi
 
 # Test 3: Short name 'S' for sched_debug
-echo ""
-echo "Test 3: Testing short name 'S' for sched_debug"
+test_section "Test 3: Testing short name 'S' for sched_debug"
 test_backend_flag "S" "using sched_debug backend" \
 	"Short name 'S' works for sched_debug"
 
 # Test 4: STALLD_TEST_BACKEND environment variable
-echo ""
 if [ -n "${STALLD_TEST_BACKEND}" ]; then
-	echo "Test 4: Testing STALLD_TEST_BACKEND=${STALLD_TEST_BACKEND}"
+	test_section "Test 4: Testing STALLD_TEST_BACKEND=${STALLD_TEST_BACKEND}"
 	# Normalize short names for expected message
 	BACKEND_NORMALIZED="${STALLD_TEST_BACKEND}"
 	case "${STALLD_TEST_BACKEND}" in
@@ -93,7 +90,7 @@ if [ -n "${STALLD_TEST_BACKEND}" ]; then
 		"using ${BACKEND_NORMALIZED} backend" \
 		"STALLD_TEST_BACKEND environment variable respected"
 else
-	echo "Test 4: Skipping (STALLD_TEST_BACKEND not set)"
+	test_section "Test 4: Skipping (STALLD_TEST_BACKEND not set)"
 	TEST_PASSED=$((TEST_PASSED + 1))
 fi
 
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index 83d8355..d677da8 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -51,10 +51,7 @@ fi
 #=============================================================================
 # Test 1: Default duration (should be 3 seconds)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Default boost duration (no -d specified)"
-log "=========================================="
+test_section "Test 1: Default boost duration (no -d specified)"
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default boost duration)"
@@ -80,10 +77,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Short duration (1 second)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Short boost duration of 1 second"
-log "=========================================="
+test_section "Test 2: Short boost duration of 1 second"
 
 short_duration=1
 STALLD_LOG2="/tmp/stalld_test_boost_duration_test2_$$.log"
@@ -111,10 +105,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Long duration (10 seconds)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Long boost duration of 10 seconds"
-log "=========================================="
+test_section "Test 3: Long boost duration of 10 seconds"
 
 long_duration=10
 long_starvation=20
@@ -144,10 +135,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Verify task policy is restored after boost duration
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Verify policy restoration after boost duration"
-log "=========================================="
+test_section "Test 4: Verify policy restoration after boost duration"
 
 threshold=3
 duration=2
@@ -176,10 +164,7 @@ stop_stalld
 #=============================================================================
 # Test 5: Invalid duration values
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Invalid duration values"
-log "=========================================="
+test_section "Test 5: Invalid duration values"
 
 # Test with zero duration
 log "Testing with duration = 0"
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index 3f3ef46..534879f 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -48,10 +48,7 @@ fi
 #=============================================================================
 # Test 1: Default period (should be 1,000,000,000 ns = 1 second)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Default period (no -p specified)"
-log "=========================================="
+test_section "Test 1: Default period (no -p specified)"
 
 threshold=5
 log "Starting stalld with default period"
@@ -84,10 +81,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Custom period (500ms = 500,000,000 ns)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Custom period of 500,000,000 ns (500ms)"
-log "=========================================="
+test_section "Test 2: Custom period of 500,000,000 ns (500ms)"
 
 custom_period=500000000
 rm -f "${STALLD_LOG}"
@@ -113,10 +107,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Very short period (100ms = 100,000,000 ns)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Short period of 200,000,000 ns (200ms)"
-log "=========================================="
+test_section "Test 3: Short period of 200,000,000 ns (200ms)"
 
 short_period=200000000
 rm -f "${STALLD_LOG}"
@@ -142,10 +133,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Very long period (10s = 10,000,000,000 ns)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Long period of 3,000,000,000 ns (3s)"
-log "=========================================="
+test_section "Test 4: Long period of 3,000,000,000 ns (3s)"
 
 long_period=3000000000
 rm -f "${STALLD_LOG}"
@@ -171,10 +159,7 @@ stop_stalld
 #=============================================================================
 # Test 5: Invalid period (0)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Invalid period value (0)"
-log "=========================================="
+test_section "Test 5: Invalid period value (0)"
 
 INVALID_LOG="/tmp/stalld_test_boost_period_invalid_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
@@ -197,10 +182,7 @@ fi
 #=============================================================================
 # Test 6: Negative period
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 6: Invalid period value (negative)"
-log "=========================================="
+test_section "Test 6: Invalid period value (negative)"
 
 INVALID_LOG2="/tmp/stalld_test_boost_period_invalid2_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG2}")
@@ -217,10 +199,7 @@ fi
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Total failures: ${TEST_FAILED}"
 
 end_test
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index bac73ba..0a77945 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -50,10 +50,7 @@ CLEANUP_FILES+=("${STALLD_LOG}")
 #=============================================================================
 # Test 1: Restore SCHED_FIFO Policy (starvation_gen creates SCHED_FIFO threads)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Restore SCHED_FIFO Policy"
-log "=========================================="
+test_section "Test 1: Restore SCHED_FIFO Policy"
 
 threshold=5
 boost_duration=3
@@ -159,10 +156,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Restore Original RT Policy (SCHED_FIFO)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Restore Original SCHED_FIFO Policy"
-log "=========================================="
+test_section "Test 2: Restore Original SCHED_FIFO Policy"
 log "Creating a SCHED_FIFO task that gets starved, verify restoration"
 
 threshold=5
@@ -273,10 +267,7 @@ stop_stalld
 #=============================================================================
 # Test 3: SCHED_OTHER Policy Restoration
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Restore SCHED_OTHER Policy"
-log "=========================================="
+test_section "Test 3: Restore SCHED_OTHER Policy"
 log "Test that SCHED_OTHER tasks are correctly restored after boosting"
 
 threshold=5
@@ -304,10 +295,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Restoration Timing Verification
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Restoration Timing Verification"
-log "=========================================="
+test_section "Test 4: Restoration Timing Verification"
 
 threshold=5
 boost_duration=4  # 4 second boost
@@ -360,10 +348,7 @@ sleep 1
 #=============================================================================
 # Test 5: Task Exit During Boost
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Graceful Handling of Task Exit During Boost"
-log "=========================================="
+test_section "Test 5: Graceful Handling of Task Exit During Boost"
 
 threshold=10
 boost_duration=5  # Task will exit during boost (after 8s, boost is 5s)
@@ -414,10 +399,7 @@ stop_stalld
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Total failures: ${TEST_FAILED}"
 
 end_test
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index 71e25f1..bf22250 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -51,10 +51,7 @@ fi
 #=============================================================================
 # Test 1: Default runtime (should be 20,000 ns = 20 microseconds)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Default runtime (no -r specified)"
-log "=========================================="
+test_section "Test 1: Default runtime (no -r specified)"
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default boost runtime)"
@@ -80,10 +77,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Custom runtime (10,000 ns = 10 microseconds, less than default)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Custom runtime of 10,000 ns (10μs)"
-log "=========================================="
+test_section "Test 2: Custom runtime of 10,000 ns (10μs)"
 
 custom_runtime=10000
 STALLD_LOG2="/tmp/stalld_test_boost_runtime_test2_$$.log"
@@ -111,10 +105,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Larger runtime (100,000 ns = 100 microseconds)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Larger runtime of 100,000 ns (100μs)"
-log "=========================================="
+test_section "Test 3: Larger runtime of 100,000 ns (100μs)"
 
 large_runtime=100000
 STALLD_LOG3="/tmp/stalld_test_boost_runtime_test3_$$.log"
@@ -142,10 +133,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Runtime < period (valid configuration)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Runtime < period (valid)"
-log "=========================================="
+test_section "Test 4: Runtime < period (valid)"
 
 # Default period is 1,000,000,000 ns, so runtime of 500,000 ns should be valid
 valid_runtime=500000
@@ -175,10 +163,7 @@ stop_stalld
 #=============================================================================
 # Test 5: Runtime > period (should error or be rejected)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Runtime > period (invalid)"
-log "=========================================="
+test_section "Test 5: Runtime > period (invalid)"
 
 invalid_runtime=2000000000
 period=1000000000
@@ -204,10 +189,7 @@ fi
 #=============================================================================
 # Test 6: Invalid runtime (0)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 6: Invalid runtime value (0)"
-log "=========================================="
+test_section "Test 6: Invalid runtime value (0)"
 
 INVALID_LOG2="/tmp/stalld_test_boost_runtime_invalid2_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG2}")
@@ -225,10 +207,7 @@ fi
 #=============================================================================
 # Test 7: Negative runtime
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 7: Invalid runtime value (negative)"
-log "=========================================="
+test_section "Test 7: Invalid runtime value (negative)"
 
 INVALID_LOG3="/tmp/stalld_test_boost_runtime_invalid3_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG3}")
diff --git a/tests/functional/test_cpu_selection.sh b/tests/functional/test_cpu_selection.sh
index 99eac44..3fa2128 100755
--- a/tests/functional/test_cpu_selection.sh
+++ b/tests/functional/test_cpu_selection.sh
@@ -35,8 +35,7 @@ fi
 echo "System has $num_cpus CPUs"
 
 # Test 1: Single CPU monitoring
-echo ""
-echo "Test 1: Single CPU monitoring (-c 0)"
+test_section "Test 1: Single CPU monitoring (-c 0)"
 rm -f "${STALLD_LOG}"
 start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 
@@ -51,8 +50,7 @@ stop_stalld
 
 # Test 2: CPU list (comma-separated)
 if [ "$num_cpus" -ge 4 ]; then
-    echo ""
-    echo "Test 2: CPU list monitoring (-c 0,2)"
+    test_section "Test 2: CPU list monitoring (-c 0,2)"
     rm -f "${STALLD_LOG}"
     start_stalld_with_log "${STALLD_LOG}" -f -v -c 0,2 -l -t 5
 
@@ -79,8 +77,7 @@ fi
 
 # Test 3: CPU range
 if [ "$num_cpus" -ge 4 ]; then
-    echo ""
-    echo "Test 3: CPU range monitoring (-c 0-2)"
+    test_section "Test 3: CPU range monitoring (-c 0-2)"
     rm -f "${STALLD_LOG}"
     start_stalld_with_log "${STALLD_LOG}" -f -v -c 0-2 -l -t 5
 
@@ -111,8 +108,7 @@ fi
 
 # Test 4: Combined format (list and range)
 if [ "$num_cpus" -ge 6 ]; then
-    echo ""
-    echo "Test 4: Combined format (-c 0,2-4)"
+    test_section "Test 4: Combined format (-c 0,2-4)"
     rm -f "${STALLD_LOG}"
     start_stalld_with_log "${STALLD_LOG}" -f -v -c 0,2-4 -l -t 5
 
@@ -136,8 +132,7 @@ else
 fi
 
 # Test 5: Invalid CPU number (should handle gracefully)
-echo ""
-echo "Test 5: Invalid CPU number (-c 999)"
+test_section "Test 5: Invalid CPU number (-c 999)"
 invalid_cpu=999
 
 # Create temporary log file for this specific test
@@ -156,8 +151,7 @@ fi
 
 # Test 6: Verify non-selected CPUs are NOT monitored
 if [ "$num_cpus" -ge 2 ]; then
-    echo ""
-    echo "Test 6: Verify non-selected CPUs not monitored (-c 0)"
+    test_section "Test 6: Verify non-selected CPUs not monitored (-c 0)"
     rm -f "${STALLD_LOG}"
     start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 544222a..3fd93c7 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -50,10 +50,7 @@ CLEANUP_FILES+=("${STALLD_LOG}")
 #=============================================================================
 # Test 1: Basic DEADLINE Boost Detection
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Basic DEADLINE Boost Detection"
-log "=========================================="
+test_section "Test 1: Basic DEADLINE Boost Detection"
 
 threshold=5
 log "Starting stalld with ${threshold}s threshold (default DEADLINE boosting)"
@@ -98,10 +95,7 @@ stop_stalld
 #=============================================================================
 # Test 2: DEADLINE Parameters Verification
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: DEADLINE Parameters Verification"
-log "=========================================="
+test_section "Test 2: DEADLINE Parameters Verification"
 
 threshold=5
 # Custom DEADLINE parameters
@@ -163,10 +157,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Task Makes Progress During Boost
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Task Makes Progress During Boost"
-log "=========================================="
+test_section "Test 3: Task Makes Progress During Boost"
 
 threshold=5
 boost_duration=5
@@ -234,10 +225,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Policy Restoration After Boost
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Policy Restoration After Boost"
-log "=========================================="
+test_section "Test 4: Policy Restoration After Boost"
 
 threshold=5
 boost_duration=3
@@ -315,10 +303,7 @@ stop_stalld
 #=============================================================================
 # Test 5: Multiple Simultaneous Boosts
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Multiple Simultaneous Boosts"
-log "=========================================="
+test_section "Test 5: Multiple Simultaneous Boosts"
 
 if [ ${NUM_CPUS} -lt 2 ]; then
     log "⚠ SKIP: Need at least 2 CPUs for this test (have ${NUM_CPUS})"
@@ -385,10 +370,7 @@ fi
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Total failures: ${TEST_FAILED}"
 
 end_test
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index a003deb..d1b65fb 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -47,10 +47,7 @@ CLEANUP_FILES+=("${STALLD_LOG}")
 #=============================================================================
 # Test 1: FIFO Boost with -F Flag
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: FIFO Boost with -F Flag"
-log "=========================================="
+test_section "Test 1: FIFO Boost with -F Flag"
 
 threshold=5
 # Create starvation FIRST (before stalld starts)
@@ -88,10 +85,7 @@ stop_stalld
 #=============================================================================
 # Test 2: FIFO Priority Verification
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: FIFO Priority Verification"
-log "=========================================="
+test_section "Test 2: FIFO Priority Verification"
 
 threshold=5
 rm -f "${STALLD_LOG}"
@@ -144,10 +138,7 @@ stop_stalld
 #=============================================================================
 # Test 3: FIFO Emulation Behavior
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: FIFO Emulation Behavior"
-log "=========================================="
+test_section "Test 3: FIFO Emulation Behavior"
 log "FIFO emulation cycles: boost→sleep(runtime)→restore→sleep(remainder)"
 
 threshold=5
@@ -198,10 +189,7 @@ stop_stalld
 #=============================================================================
 # Test 4: FIFO vs DEADLINE Comparison
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: FIFO vs DEADLINE Effectiveness Comparison"
-log "=========================================="
+test_section "Test 4: FIFO vs DEADLINE Effectiveness Comparison"
 
 threshold=5
 boost_duration=3
@@ -317,10 +305,7 @@ fi
 #=============================================================================
 # Test 5: Single-Threaded Mode Fails with FIFO
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Single-Threaded Mode with FIFO (Should Fail)"
-log "=========================================="
+test_section "Test 5: Single-Threaded Mode with FIFO (Should Fail)"
 
 log "Attempting to start stalld with -F without -A (single-threaded + FIFO)"
 STALLD_LOG_FAIL="/tmp/stalld_test_fifo_fail_$$.log"
@@ -342,10 +327,7 @@ fi
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Total failures: ${TEST_FAILED}"
 
 end_test
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 9554d49..7c401f3 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -51,10 +51,7 @@ CLEANUP_FILES+=("${STALLD_LOG}")
 #=============================================================================
 # Test 1: Basic FIFO-on-FIFO Starvation Detection
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Basic FIFO-on-FIFO Starvation Detection"
-log "=========================================="
+test_section "Test 1: Basic FIFO-on-FIFO Starvation Detection"
 log "Testing: FIFO:10 blocker starves FIFO:5 blockee"
 
 threshold=5
@@ -101,10 +98,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Boosting Effectiveness
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Boosting Allows Progress"
-log "=========================================="
+test_section "Test 2: Boosting Allows Progress"
 log "Verify boosting allows FIFO:5 task to make progress despite FIFO:10 blocker"
 
 rm -f "${STALLD_LOG}"
@@ -168,10 +162,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Starvation Duration Tracking
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Starvation Duration Tracking"
-log "=========================================="
+test_section "Test 3: Starvation Duration Tracking"
 log "Verify duration accumulates correctly (task merging)"
 
 rm -f "${STALLD_LOG}"
@@ -232,10 +223,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Close Priority Gap
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Close Priority Gap (FIFO:6 vs FIFO:5)"
-log "=========================================="
+test_section "Test 4: Close Priority Gap (FIFO:6 vs FIFO:5)"
 log "Testing edge case with only 1 priority difference"
 
 rm -f "${STALLD_LOG}"
@@ -270,10 +258,7 @@ stop_stalld
 #=============================================================================
 # Test 5: Correct Task Boosted
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Verify Correct Task is Boosted"
-log "=========================================="
+test_section "Test 5: Verify Correct Task is Boosted"
 log "Ensure stalld boosts the blockee (FIFO:5), not the blocker (FIFO:10)"
 
 rm -f "${STALLD_LOG}"
@@ -317,10 +302,7 @@ stop_stalld
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Total failures: ${TEST_FAILED}"
 
 if [ -n "${STALLD_TEST_BACKEND}" ] && [ "${STALLD_TEST_BACKEND}" = "queue_track" ]; then
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 4fdb13b..321e2c0 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -44,10 +44,7 @@ fi
 #=============================================================================
 # Test 1: Default behavior (should use SCHED_DEADLINE)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Default behavior (no -F, should use SCHED_DEADLINE)"
-log "=========================================="
+test_section "Test 1: Default behavior (no -F, should use SCHED_DEADLINE)"
 
 threshold=3
 log "Starting stalld with ${threshold}s threshold (default, no -F)"
@@ -82,10 +79,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Force FIFO mode (-F)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Force FIFO mode (-F)"
-log "=========================================="
+test_section "Test 2: Force FIFO mode (-F)"
 
 # Note: Single-threaded mode only works with SCHED_DEADLINE (dies with FIFO)
 # So we need to use aggressive mode (-A) when testing FIFO
@@ -123,10 +117,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Verify FIFO priority setting
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Verify FIFO priority is set"
-log "=========================================="
+test_section "Test 3: Verify FIFO priority is set"
 
 STALLD_LOG3="/tmp/stalld_test_force_fifo_test3_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG3}")
@@ -160,10 +151,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Verify FIFO emulation behavior (sleep runtime, restore, sleep remainder)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: FIFO emulation behavior"
-log "=========================================="
+test_section "Test 4: FIFO emulation behavior"
 
 boost_duration=3
 long_starvation=12
@@ -202,10 +190,7 @@ stop_stalld
 #=============================================================================
 # Test 5: Single-threaded mode with FIFO (should fail/exit)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Single-threaded mode with FIFO (should fail)"
-log "=========================================="
+test_section "Test 5: Single-threaded mode with FIFO (should fail)"
 
 log "Testing single-threaded mode (-O) with -F (should exit)"
 assert_stalld_rejects "Single-threaded mode rejected FIFO" -f -v -c "${TEST_CPU}" -t ${threshold} -F -O
@@ -213,10 +198,7 @@ assert_stalld_rejects "Single-threaded mode rejected FIFO" -f -v -c "${TEST_CPU}
 #=============================================================================
 # Test 6: Compare effectiveness (informational)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 6: FIFO vs DEADLINE comparison (informational)"
-log "=========================================="
+test_section "Test 6: FIFO vs DEADLINE comparison (informational)"
 
 comparison_duration=2
 comparison_starvation=8
diff --git a/tests/functional/test_foreground.sh b/tests/functional/test_foreground.sh
index 8b89d02..e07bee3 100755
--- a/tests/functional/test_foreground.sh
+++ b/tests/functional/test_foreground.sh
@@ -22,7 +22,7 @@ setup_test_environment
 require_root
 
 # Test 1: Without -f flag, stalld should daemonize
-echo "Test 1: stalld daemonizes by default"
+test_section "Test 1: stalld daemonizes by default"
 start_stalld -l -t 5
 sleep 2
 
@@ -46,8 +46,7 @@ fi
 stop_stalld
 
 # Test 2: With -f flag, stalld should stay in foreground
-echo ""
-echo "Test 2: stalld stays in foreground with -f"
+test_section "Test 2: stalld stays in foreground with -f"
 
 # Start stalld in foreground but in background job
 start_stalld -f -l -t 5
@@ -70,8 +69,7 @@ fi
 stop_stalld
 
 # Test 3: With -v flag, foreground mode should be implicit
-echo ""
-echo "Test 3: -v implies foreground mode"
+test_section "Test 3: -v implies foreground mode"
 
 start_stalld -v -l -t 5
 sleep 2
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index 8757d74..cd4e0f3 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -75,10 +75,7 @@ log "Reads: /proc/stat for per-CPU idle time"
 #=============================================================================
 # Test 1: Idle CPUs Skipped (No Parsing)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Idle CPUs Skipped"
-log "=========================================="
+test_section "Test 1: Idle CPUs Skipped"
 log "Idle CPUs should be skipped to reduce overhead"
 
 threshold=5
@@ -110,10 +107,7 @@ stop_stalld
 #=============================================================================
 # Test 2: /proc/stat Parsing
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: /proc/stat Idle Time Parsing"
-log "=========================================="
+test_section "Test 2: /proc/stat Idle Time Parsing"
 
 # Read idle time for test CPU
 idle_time1=$(get_cpu_idle_time ${TEST_CPU})
@@ -143,10 +137,7 @@ fi
 #=============================================================================
 # Test 3: Monitoring Resumes When CPU Becomes Busy
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Monitoring Resumes for Busy CPUs"
-log "=========================================="
+test_section "Test 3: Monitoring Resumes for Busy CPUs"
 
 threshold=5
 rm -f "${STALLD_LOG}"
@@ -181,10 +172,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Idle Detection Overhead Reduction
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Idle Detection Reduces Overhead"
-log "=========================================="
+test_section "Test 4: Idle Detection Reduces Overhead"
 log "Comparing overhead with and without idle detection (informational)"
 
 # This is informational - we can't easily measure overhead in tests
@@ -203,10 +191,7 @@ log "        Function: cpu_had_idle_time() and get_cpu_busy_list()"
 #=============================================================================
 # Test 5: Idle Detection with Multiple CPUs
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Per-CPU Independent Idle Detection"
-log "=========================================="
+test_section "Test 5: Per-CPU Independent Idle Detection"
 
 NUM_CPUS=$(get_num_cpus)
 if [ ${NUM_CPUS} -lt 2 ]; then
@@ -259,10 +244,7 @@ fi
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Idle detection functions:"
 log "  - cpu_had_idle_time() in stalld.c:226-260"
 log "  - get_cpu_busy_list() in stalld.c:262-308"
diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index f05cd00..7b15c68 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -28,7 +28,7 @@ has_stalld_log() {
 }
 
 # Test 1: Verbose mode (-v) logs to stdout/stderr
-echo "Test 1: Verbose mode (-v) logs to stdout"
+test_section "Test 1: Verbose mode (-v) logs to stdout"
 
 LOG_FILE="/tmp/stalld_test_verbose_$$.log"
 CLEANUP_FILES+=("${LOG_FILE}")
@@ -52,8 +52,7 @@ fi
 stop_stalld
 
 # Test 2: Kernel message log (-k)
-echo ""
-echo "Test 2: Kernel message log (-k)"
+test_section "Test 2: Kernel message log (-k)"
 
 # Clear dmesg if possible (requires root)
 if command -v dmesg >/dev/null 2>&1; then
@@ -86,8 +85,7 @@ else
 fi
 
 # Test 3: Syslog (-s, default)
-echo ""
-echo "Test 3: Syslog (-s, default)"
+test_section "Test 3: Syslog (-s, default)"
 
 # Check if syslog is available
 SYSLOG_FILE=""
@@ -144,8 +142,7 @@ else
 fi
 
 # Test 4: Combined logging (-v -k -s)
-echo ""
-echo "Test 4: Combined logging modes"
+test_section "Test 4: Combined logging modes"
 
 LOG_FILE="/tmp/stalld_test_combined_$$.log"
 CLEANUP_FILES+=("${LOG_FILE}")
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 76be14a..6b476cd 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -34,10 +34,7 @@ CLEANUP_FILES+=("${STALLD_LOG}")
 #=============================================================================
 # Test 1: Default pidfile location (no -P specified)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Default behavior (no -P specified)"
-log "=========================================="
+test_section "Test 1: Default behavior (no -P specified)"
 
 start_stalld -l -t 5
 
@@ -71,10 +68,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Custom pidfile location
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Custom pidfile location"
-log "=========================================="
+test_section "Test 2: Custom pidfile location"
 
 custom_pidfile="/tmp/stalld_test_pidfile_custom_$$.pid"
 CLEANUP_FILES+=("${custom_pidfile}")
@@ -105,8 +99,7 @@ else
 fi
 
 # Test 3: Verify pidfile removed on clean shutdown
-log ""
-log "Test 3: Verify pidfile removed on clean shutdown"
+test_section "Test 3: Verify pidfile removed on clean shutdown"
 stop_stalld
 
 if [ ! -f "${custom_pidfile}" ]; then
@@ -119,10 +112,7 @@ fi
 #=============================================================================
 # Test 4: Custom pidfile in /tmp
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Custom pidfile in /tmp directory"
-log "=========================================="
+test_section "Test 4: Custom pidfile in /tmp directory"
 
 tmp_pidfile="/tmp/stalld_test_tmp_$$.pid"
 CLEANUP_FILES+=("${tmp_pidfile}")
@@ -153,10 +143,7 @@ stop_stalld
 #=============================================================================
 # Test 5: Test with foreground mode
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: Pidfile with foreground mode (-f)"
-log "=========================================="
+test_section "Test 5: Pidfile with foreground mode (-f)"
 
 fg_pidfile="/tmp/stalld_test_pidfile_foreground_$$.pid"
 CLEANUP_FILES+=("${fg_pidfile}")
@@ -187,10 +174,7 @@ stop_stalld
 #=============================================================================
 # Test 6: Invalid pidfile path (permission denied)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 6: Invalid pidfile path (permission denied)"
-log "=========================================="
+test_section "Test 6: Invalid pidfile path (permission denied)"
 
 # Use a non-existent parent directory so fopen() fails even as root
 invalid_pidfile="/nonexistent_${$}/stalld.pid"
@@ -220,10 +204,7 @@ chmod 755 "${test_dir}"
 #=============================================================================
 # Test 7: Verify pidfile is readable by other processes
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 7: Verify pidfile is readable"
-log "=========================================="
+test_section "Test 7: Verify pidfile is readable"
 
 readable_pidfile="/tmp/stalld_test_pidfile_readable_$$.pid"
 CLEANUP_FILES+=("${readable_pidfile}")
diff --git a/tests/functional/test_runqueue_parsing.sh b/tests/functional/test_runqueue_parsing.sh
index ac5190e..9aa7471 100755
--- a/tests/functional/test_runqueue_parsing.sh
+++ b/tests/functional/test_runqueue_parsing.sh
@@ -85,10 +85,7 @@ fi
 # Test 1: eBPF Backend Task Extraction
 #=============================================================================
 if [ ${BPF_AVAILABLE} -eq 1 ]; then
-    log ""
-    log "=========================================="
-    log "Test 1: eBPF Backend Task Extraction"
-    log "=========================================="
+    test_section "Test 1: eBPF Backend Task Extraction"
 
     threshold=5
     log "Starting stalld with eBPF backend (queue_track)"
@@ -128,10 +125,7 @@ if [ ${BPF_AVAILABLE} -eq 1 ]; then
     wait ${STARVE_PID} 2>/dev/null
     stop_stalld
 else
-    log ""
-    log "=========================================="
-    log "Test 1: eBPF Backend - SKIPPED"
-    log "=========================================="
+    test_section "Test 1: eBPF Backend - SKIPPED"
     log "eBPF backend not available on this system"
 fi
 
@@ -139,10 +133,7 @@ fi
 # Test 2: sched_debug Backend Task Extraction
 #=============================================================================
 if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
-    log ""
-    log "=========================================="
-    log "Test 2: sched_debug Backend Task Extraction"
-    log "=========================================="
+    test_section "Test 2: sched_debug Backend Task Extraction"
 
     threshold=5
     log "Starting stalld with sched_debug backend"
@@ -187,10 +178,7 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     wait ${STARVE_PID} 2>/dev/null
     stop_stalld
 else
-    log ""
-    log "=========================================="
-    log "Test 2: sched_debug Backend - SKIPPED"
-    log "=========================================="
+    test_section "Test 2: sched_debug Backend - SKIPPED"
     log "sched_debug backend not available on this system"
 fi
 
@@ -198,10 +186,7 @@ fi
 # Test 3: Backend Comparison (Both Should Detect Same Starvation)
 #=============================================================================
 if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
-    log ""
-    log "=========================================="
-    log "Test 3: Backend Comparison"
-    log "=========================================="
+    test_section "Test 3: Backend Comparison"
     log "Testing that both backends detect the same starvation condition"
 
     threshold=5
@@ -261,20 +246,14 @@ if [ ${BPF_AVAILABLE} -eq 1 ] && [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
         fail "One or both backends failed to detect starvation"
     fi
 else
-    log ""
-    log "=========================================="
-    log "Test 3: Backend Comparison - SKIPPED"
-    log "=========================================="
+    test_section "Test 3: Backend Comparison - SKIPPED"
     log "Both backends required for comparison test"
 fi
 
 #=============================================================================
 # Test 4: Verify Task Field Extraction (PID, comm, priority, switches)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Task Field Extraction Verification"
-log "=========================================="
+test_section "Test 4: Task Field Extraction Verification"
 
 # Use whichever backend is available
 if [ ${BPF_AVAILABLE} -eq 1 ]; then
@@ -344,10 +323,7 @@ fi
 # Test 5: Kernel Format Handling (sched_debug backend)
 #=============================================================================
 if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
-    log ""
-    log "=========================================="
-    log "Test 5: Kernel Format Detection (sched_debug)"
-    log "=========================================="
+    test_section "Test 5: Kernel Format Detection (sched_debug)"
 
     threshold=5
     rm -f "${STALLD_LOG_SCHED}"
@@ -394,20 +370,14 @@ if [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ]; then
     wait ${STARVE_PID} 2>/dev/null
     stop_stalld
 else
-    log ""
-    log "=========================================="
-    log "Test 5: Kernel Format Detection - SKIPPED"
-    log "=========================================="
+    test_section "Test 5: Kernel Format Detection - SKIPPED"
     log "sched_debug backend required for format detection tests"
 fi
 
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Backends tested:"
 [ ${BPF_AVAILABLE} -eq 1 ] && log "  - eBPF (queue_track): available"
 [ ${SCHED_DEBUG_AVAILABLE} -eq 1 ] && log "  - sched_debug: available"
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 6ca2121..cd60e27 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -57,10 +57,7 @@ CLEANUP_FILES+=("${STALLD_LOG}")
 #=============================================================================
 # Test 1: Basic Starvation Detection
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Basic Starvation Detection"
-log "=========================================="
+test_section "Test 1: Basic Starvation Detection"
 
 threshold=5
 
@@ -104,10 +101,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Context Switch Count Tracking
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Context Switch Count Tracking"
-log "=========================================="
+test_section "Test 2: Context Switch Count Tracking"
 
 rm -f "${STALLD_LOG}"
 threshold=5
@@ -161,10 +155,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Task Merging (Timestamp Preservation)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Task Merging - Timestamp Preservation"
-log "=========================================="
+test_section "Test 3: Task Merging - Timestamp Preservation"
 
 rm -f "${STALLD_LOG}"
 threshold=3
@@ -224,10 +215,7 @@ wait ${STARVE_PID} 2>/dev/null
 #=============================================================================
 # Test 4: Multiple CPUs Detection
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Multiple CPUs Detection"
-log "=========================================="
+test_section "Test 4: Multiple CPUs Detection"
 
 if [ ${NUM_CPUS} -lt 2 ]; then
     log "⚠ SKIP: Need at least 2 CPUs for this test (have ${NUM_CPUS})"
@@ -297,10 +285,7 @@ fi
 #=============================================================================
 # Test 5: No False Positives (Task Making Progress)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 5: No False Positives"
-log "=========================================="
+test_section "Test 5: No False Positives"
 
 rm -f "${STALLD_LOG}"
 threshold=5
@@ -341,10 +326,7 @@ stop_stalld
 #=============================================================================
 # Test 6: Edge Case - Task Exits During Monitoring
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 6: Task Exits During Monitoring"
-log "=========================================="
+test_section "Test 6: Task Exits During Monitoring"
 
 rm -f "${STALLD_LOG}"
 threshold=10
@@ -379,10 +361,7 @@ stop_stalld
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Total failures: ${TEST_FAILED}"
 
 end_test
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index a2cd420..836f079 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -55,10 +55,7 @@ fi
 #=============================================================================
 # Test 1: Custom threshold (5 seconds)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Custom threshold of 5 seconds"
-log "=========================================="
+test_section "Test 1: Custom threshold of 5 seconds"
 
 threshold=5
 
@@ -91,10 +88,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Verify no detection before threshold
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: No detection before threshold"
-log "=========================================="
+test_section "Test 2: No detection before threshold"
 
 threshold=10
 STALLD_LOG2="/tmp/stalld_test_threshold_test2_$$.log"
@@ -135,10 +129,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Shorter threshold (3 seconds)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: Shorter threshold (3 seconds)"
-log "=========================================="
+test_section "Test 3: Shorter threshold (3 seconds)"
 
 threshold=3
 STALLD_LOG3="/tmp/stalld_test_threshold_test3_$$.log"
@@ -174,10 +165,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Invalid threshold values
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Invalid threshold values"
-log "=========================================="
+test_section "Test 4: Invalid threshold values"
 
 # Test with zero threshold
 log "Testing with threshold = 0"
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index e1a4cc1..305dc4b 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -56,10 +56,7 @@ CLEANUP_FILES+=("${STALLD_LOG}")
 #=============================================================================
 # Test 1: Timestamp Preservation for Non-Progressing Tasks
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 1: Timestamp Preservation Across Cycles"
-log "=========================================="
+test_section "Test 1: Timestamp Preservation Across Cycles"
 log "Task merging: same PID + same ctxsw = preserved timestamp"
 
 threshold=3
@@ -134,10 +131,7 @@ stop_stalld
 #=============================================================================
 # Test 2: Same PID + Same Context Switches = Merged
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 2: Merge Condition Verification"
-log "=========================================="
+test_section "Test 2: Merge Condition Verification"
 log "Merging occurs when: PID matches AND context switches unchanged"
 
 threshold=5
@@ -207,10 +201,7 @@ stop_stalld
 #=============================================================================
 # Test 3: Task Making Progress (No Merge)
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 3: No Merge When Task Makes Progress"
-log "=========================================="
+test_section "Test 3: No Merge When Task Makes Progress"
 log "When context switches change, timestamp should reset"
 
 threshold=5
@@ -262,10 +253,7 @@ stop_stalld
 #=============================================================================
 # Test 4: Multiple CPUs with Independent Task Merging
 #=============================================================================
-log ""
-log "=========================================="
-log "Test 4: Per-CPU Independent Task Merging"
-log "=========================================="
+test_section "Test 4: Per-CPU Independent Task Merging"
 
 NUM_CPUS=$(get_num_cpus)
 if [ ${NUM_CPUS} -lt 2 ]; then
@@ -345,10 +333,7 @@ fi
 #=============================================================================
 # Final Summary
 #=============================================================================
-log ""
-log "=========================================="
-log "Test Summary"
-log "=========================================="
+test_section "Test Summary"
 log "Task merging function: merge_tasks_info() in stalld.c:370-397"
 log "Merge logic: if (PID == PID && ctxsw == ctxsw) preserve timestamp"
 log ""
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 9d49b55..5d61b39 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -105,6 +105,15 @@ end_test() {
 	fi
 }
 
+# Print a section banner for a test sub-section or summary block.
+test_section() {
+	local title="$1"
+	log ""
+	log "=========================================="
+	log "${title}"
+	log "=========================================="
+}
+
 # Record a test pass with a description message.
 #
 # Usage: pass "description"
@@ -1129,7 +1138,7 @@ start_starvation_gen() {
 }
 
 # Export functions for use in tests
-export -f start_test end_test
+export -f start_test end_test test_section
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
-- 
2.54.0

