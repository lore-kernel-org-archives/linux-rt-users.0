Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A33B774F
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288651; cv=none; b=atSmSNyO9gD+d5Ue+Uc0YkCfbWL80sG97+tmegKQVf8+ztMtw+3SjCSkJAiCTFo0XYsfbAcB7efg3hI35c/fJvEZkOqi3gSdHeuopzD9pmo6mQizoDM2ymaLvopkaURRBl/UMzGHMZE/D9Tk8vg+D8AeF7LMVK1HkjEvGNmDtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288651; c=relaxed/simple;
	bh=pv6Lkk4nai8PNiVrEZxFbwnn6kJbyy2c5yWtK+SgGiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmhNQa32pJ6/L9iIhUDSCaV6YC6+YSHJ6hA9hxv7LkNzqa0dC9ueRaYklVMard6H5PNCuueflqE7I7noNytE/sU6gA+wgkcw1nsLkw9EjJA3Y8XtPOi3axBhcdyZVVSMJ2ztGRxikeHdpgmWoqnY3po0VPWdNljPuSGc/Uq3OsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoPwX/9a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoPwX/9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=563bYv9L9NoxKBWMgDnpt+ozqgPqDV8GaqR552t1m3M=;
	b=OoPwX/9aXoXUDnLOsaa4xG7ZYzubkM0tcW7vlfUFRy2TcNRMd60SUf0Z9XHEHyrtDqbQvB
	6g7gy78Ddoaf5n3t3aE22QTEAuGsVdzkI3GnDyGYNr35oMtyWyzSBxU5iMFNsfwX2ozVrg
	4gxAxtExvI2LhI1y74XNS6xR+HcplRQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-z-yanFsBPaK7Ocx8Q0AiSA-1; Mon,
 27 Apr 2026 07:17:24 -0400
X-MC-Unique: z-yanFsBPaK7Ocx8Q0AiSA-1
X-Mimecast-MFC-AGG-ID: z-yanFsBPaK7Ocx8Q0AiSA_1777288643
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94CD419560B5;
	Mon, 27 Apr 2026 11:17:23 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E4731800349;
	Mon, 27 Apr 2026 11:17:20 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 07/23] tests: Consolidate and adopt init_functional_test()
Date: Mon, 27 Apr 2026 08:16:09 -0300
Message-ID: <20260427111632.24500-8-wander@redhat.com>
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

Several functional tests use starvation_gen to create controlled
starvation scenarios but do not verify the binary exists before
attempting to run it. Add the existence check to
init_functional_test() so that all tests using the shared
initialization skip gracefully when the binary is missing and
migrate standard tests to init_functional_test().

Additionally, standardize log file management by removing
numbered log variable declarations in favor of reusing a single
STALLD_LOG cleared between test sections. This fixes a broken log
assertion in test_affinity where a numbered variable masked an
unpopulated file.

Finally, move the BACKEND_FLAG construction into
init_functional_test() and export it alongside the other shared
variables. Five test files previously duplicated this block for
direct stalld invocations.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_affinity.sh             | 49 ++-----------
 tests/functional/test_boost_duration.sh       | 67 ++++-------------
 tests/functional/test_boost_period.sh         | 46 +-----------
 tests/functional/test_boost_restoration.sh    | 30 +-------
 tests/functional/test_boost_runtime.sh        | 72 ++++---------------
 tests/functional/test_deadline_boosting.sh    | 30 +-------
 tests/functional/test_fifo_boosting.sh        | 30 +-------
 .../test_fifo_priority_starvation.sh          | 30 +-------
 tests/functional/test_force_fifo.sh           | 28 +-------
 tests/functional/test_idle_detection.sh       | 30 +-------
 tests/functional/test_pidfile.sh              | 39 +---------
 tests/functional/test_starvation_detection.sh | 30 +-------
 tests/functional/test_starvation_threshold.sh | 56 +++------------
 tests/functional/test_task_merging.sh         | 32 +--------
 tests/helpers/test_helpers.sh                 | 13 +++-
 15 files changed, 64 insertions(+), 518 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index d745b08..ec6ff3b 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -35,21 +35,8 @@ check_affinity() {
     fi
 }
 
-start_test "CPU Affinity Option (-a)"
+init_functional_test "CPU Affinity Option (-a)" "test_affinity"
 
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Get number of CPUs
 num_cpus=$(nproc)
 log "System has $num_cpus CPUs"
 
@@ -58,15 +45,10 @@ if [ "$num_cpus" -lt 2 ]; then
     exit 77
 fi
 
-# Check if taskset is available
 if ! command -v taskset > /dev/null 2>&1; then
     log "⚠ WARNING: taskset not found, will use /proc fallback"
 fi
 
-# Setup paths
-STALLD_LOG="/tmp/stalld_test_affinity_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
 #=============================================================================
 # Test 1: Default behavior (no -a specified)
 #=============================================================================
@@ -92,9 +74,6 @@ stop_stalld
 #=============================================================================
 test_section "Test 2: Single CPU affinity (-a 0)"
 
-STALLD_LOG2="/tmp/stalld_test_affinity_test2_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG2}")
-
 start_stalld -f -v -l -t 5 -a 0
 sleep 2
 
@@ -114,9 +93,6 @@ stop_stalld
 test_section "Test 3: Multi-CPU affinity (-a 0,2)"
 
 if [ "$num_cpus" -ge 4 ]; then
-    STALLD_LOG3="/tmp/stalld_test_affinity_test3_$$.log"
-    CLEANUP_FILES+=("${STALLD_LOG3}")
-
     start_stalld -f -v -l -t 5 -a 0,2
     sleep 2
 
@@ -141,9 +117,6 @@ fi
 test_section "Test 4: CPU range affinity (-a 0-2)"
 
 if [ "$num_cpus" -ge 4 ]; then
-    STALLD_LOG4="/tmp/stalld_test_affinity_test4_$$.log"
-    CLEANUP_FILES+=("${STALLD_LOG4}")
-
     start_stalld -f -v -l -t 5 -a 0-2
     sleep 2
 
@@ -168,9 +141,6 @@ test_section "Test 5: Verify stalld threads run on specified CPU"
 
 if [ "$num_cpus" -ge 2 ]; then
     test_cpu=1
-    STALLD_LOG5="/tmp/stalld_test_affinity_test5_$$.log"
-    CLEANUP_FILES+=("${STALLD_LOG5}")
-
     start_stalld -f -v -l -t 5 -a "$test_cpu"
     sleep 2
 
@@ -200,12 +170,10 @@ fi
 test_section "Test 6: Combined affinity and monitoring (-a 0 -c 1)"
 
 if [ "$num_cpus" -ge 2 ]; then
-    STALLD_LOG6="/tmp/stalld_test_affinity_test6_$$.log"
-    CLEANUP_FILES+=("${STALLD_LOG6}")
+    rm -f "${STALLD_LOG}"
 
     # Run stalld on CPU 0, but monitor CPU 1
-    start_stalld -f -v -l -t 5 -a 0 -c 1
-    sleep 2
+    start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0 -c 1
 
     affinity=$(check_affinity "${STALLD_PID}")
 
@@ -216,7 +184,7 @@ if [ "$num_cpus" -ge 2 ]; then
     fi
 
     # Verify it's monitoring CPU 1 by checking logs
-    if grep -q "cpu 1" "${STALLD_LOG6}" || grep -q "monitoring.*1" "${STALLD_LOG6}"; then
+    if grep -q "cpu 1" "${STALLD_LOG}" || grep -q "monitoring.*1" "${STALLD_LOG}"; then
         log "ℹ INFO: stalld monitoring CPU 1 as requested"
     else
         log "ℹ INFO: CPU 1 monitoring not explicitly confirmed in logs"
@@ -236,12 +204,6 @@ invalid_cpu=999
 INVALID_LOG="/tmp/stalld_test_affinity_invalid_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
 
-# Add backend flag for consistency
-BACKEND_FLAG=""
-if [ -n "${STALLD_TEST_BACKEND}" ]; then
-    BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
-fi
-
 timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 -a ${invalid_cpu} > "${INVALID_LOG}" 2>&1
 ret=$?
 
@@ -256,9 +218,6 @@ fi
 #=============================================================================
 test_section "Test 8: Verify affinity persists over time"
 
-STALLD_LOG8="/tmp/stalld_test_affinity_test8_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG8}")
-
 start_stalld -f -v -l -t 5 -a 0
 sleep 2
 
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index d1cdd1e..b0319d2 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -13,40 +13,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "Boost Duration Option (-d)"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_boost_duration_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
-if [ ! -x "${STARVE_GEN}" ]; then
-    echo -e "${YELLOW}SKIP: starvation_gen not found or not executable${NC}"
-    exit 77
-fi
+init_functional_test "Boost Duration Option (-d)" "test_boost_duration"
 
 #=============================================================================
 # Test 1: Default duration (should be 3 seconds)
@@ -74,18 +41,17 @@ cleanup_scenario "${STARVE_PID}"
 test_section "Test 2: Short boost duration of 1 second"
 
 short_duration=1
-STALLD_LOG2="/tmp/stalld_test_boost_duration_test2_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG2}")
+rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${short_duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG2}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${short_duration} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG2}" "Starvation detection with ${short_duration}s duration"
+assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${short_duration}s duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -98,18 +64,17 @@ test_section "Test 3: Long boost duration of 10 seconds"
 long_duration=10
 long_starvation=20
 threshold=10
-STALLD_LOG3="/tmp/stalld_test_boost_duration_test3_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG3}")
+rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${long_duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG3}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${long_duration} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 
 # Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG3}" "Starvation detection with ${long_duration}s duration"
+assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${long_duration}s duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -121,18 +86,17 @@ test_section "Test 4: Verify policy restoration after boost duration"
 
 threshold=3
 duration=2
-STALLD_LOG4="/tmp/stalld_test_boost_duration_test4_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG4}")
+rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${duration}s boost duration"
-start_stalld_with_log "${STALLD_LOG4}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -d ${duration} -l
 
 # Create starvation with a specific task we can track
 log "Creating starvation on CPU ${TEST_CPU} for 15s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 1 -d 15
 
 # Wait for starvation detection
-assert_starvation_detected "${STALLD_LOG4}" "Starvation detection with ${duration}s boost duration"
+assert_starvation_detected "${STALLD_LOG}" "Starvation detection with ${duration}s boost duration"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -147,12 +111,6 @@ log "Testing with duration = 0"
 INVALID_LOG="/tmp/stalld_test_boost_duration_invalid_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
 
-# Add backend flag for consistency
-BACKEND_FLAG=""
-if [ -n "${STALLD_TEST_BACKEND}" ]; then
-    BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
-fi
-
 timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d 0 > "${INVALID_LOG}" 2>&1
 ret=$?
 
@@ -164,10 +122,9 @@ fi
 
 # Test 6: Negative duration
 log "Testing with duration = -5"
-INVALID_LOG2="/tmp/stalld_test_boost_duration_invalid2_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG2}")
+rm -f "${INVALID_LOG}"
 
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d -5 > "${INVALID_LOG2}" 2>&1
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d -5 > "${INVALID_LOG}" 2>&1
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index d7112bb..b4f2339 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -10,40 +10,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "Boost Period Option (-p)"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_boost_period_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
-if [ ! -x "${STARVE_GEN}" ]; then
-    echo -e "${YELLOW}SKIP: starvation_gen not found or not executable${NC}"
-    exit 77
-fi
+init_functional_test "Boost Period Option (-p)" "test_boost_period"
 
 #=============================================================================
 # Test 1: Default period (should be 1,000,000,000 ns = 1 second)
@@ -144,12 +111,6 @@ test_section "Test 5: Invalid period value (0)"
 INVALID_LOG="/tmp/stalld_test_boost_period_invalid_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
 
-# Add backend flag for consistency
-BACKEND_FLAG=""
-if [ -n "${STALLD_TEST_BACKEND}" ]; then
-    BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
-fi
-
 timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p 0 > "${INVALID_LOG}" 2>&1
 ret=$?
 
@@ -164,10 +125,9 @@ fi
 #=============================================================================
 test_section "Test 6: Invalid period value (negative)"
 
-INVALID_LOG2="/tmp/stalld_test_boost_period_invalid2_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG2}")
+rm -f "${INVALID_LOG}"
 
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p -1000000 > "${INVALID_LOG2}" 2>&1
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p -1000000 > "${INVALID_LOG}" 2>&1
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index c2a04f3..09dbb60 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -17,35 +17,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "Policy Restoration After Boosting"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_restoration_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
+init_functional_test "Policy Restoration After Boosting" "test_restoration"
 
 #=============================================================================
 # Test 1: Restore SCHED_FIFO Policy (starvation_gen creates SCHED_FIFO threads)
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index c17ac27..7585e6b 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -13,40 +13,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "Boost Runtime Option (-r)"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_boost_runtime_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
-if [ ! -x "${STARVE_GEN}" ]; then
-    echo -e "${YELLOW}SKIP: starvation_gen not found or not executable${NC}"
-    exit 77
-fi
+init_functional_test "Boost Runtime Option (-r)" "test_boost_runtime"
 
 #=============================================================================
 # Test 1: Default runtime (should be 20,000 ns = 20 microseconds)
@@ -74,18 +41,17 @@ cleanup_scenario "${STARVE_PID}"
 test_section "Test 2: Custom runtime of 10,000 ns (10μs)"
 
 custom_runtime=10000
-STALLD_LOG2="/tmp/stalld_test_boost_runtime_test2_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG2}")
+rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${custom_runtime}ns runtime"
-start_stalld_with_log "${STALLD_LOG2}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom_runtime} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${custom_runtime} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG2}" "Starvation detection with custom runtime ${custom_runtime}ns"
+assert_starvation_detected "${STALLD_LOG}" "Starvation detection with custom runtime ${custom_runtime}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -96,18 +62,17 @@ cleanup_scenario "${STARVE_PID}"
 test_section "Test 3: Larger runtime of 100,000 ns (100μs)"
 
 large_runtime=100000
-STALLD_LOG3="/tmp/stalld_test_boost_runtime_test3_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG3}")
+rm -f "${STALLD_LOG}"
 
 log "Starting stalld with ${threshold}s threshold and ${large_runtime}ns runtime"
-start_stalld_with_log "${STALLD_LOG3}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_runtime} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${large_runtime} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG3}" "Starvation detection with large runtime ${large_runtime}ns"
+assert_starvation_detected "${STALLD_LOG}" "Starvation detection with large runtime ${large_runtime}ns"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -120,18 +85,17 @@ test_section "Test 4: Runtime < period (valid)"
 # Default period is 1,000,000,000 ns, so runtime of 500,000 ns should be valid
 valid_runtime=500000
 period=1000000000
-STALLD_LOG4="/tmp/stalld_test_boost_runtime_test4_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG4}")
+rm -f "${STALLD_LOG}"
 
 log "Starting stalld with runtime ${valid_runtime}ns < period ${period}ns"
-start_stalld_with_log "${STALLD_LOG4}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_runtime} -p ${period} -l
+start_stalld_with_log "${STALLD_LOG}" -f -v -c "${TEST_CPU}" -a ${STALLD_CPU} -t ${threshold} -r ${valid_runtime} -p ${period} -l
 
 # Create starvation
 log "Creating starvation on CPU ${TEST_CPU} for ${starvation_duration}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for detection and boosting
-assert_starvation_detected "${STALLD_LOG4}" "Starvation detection with runtime < period"
+assert_starvation_detected "${STALLD_LOG}" "Starvation detection with runtime < period"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -146,12 +110,6 @@ period=1000000000
 INVALID_LOG="/tmp/stalld_test_boost_runtime_invalid_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
 
-# Add backend flag for consistency
-BACKEND_FLAG=""
-if [ -n "${STALLD_TEST_BACKEND}" ]; then
-    BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
-fi
-
 log "Testing with runtime ${invalid_runtime}ns > period ${period}ns"
 timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r ${invalid_runtime} -p ${period} > "${INVALID_LOG}" 2>&1
 ret=$?
@@ -167,11 +125,10 @@ fi
 #=============================================================================
 test_section "Test 6: Invalid runtime value (0)"
 
-INVALID_LOG2="/tmp/stalld_test_boost_runtime_invalid2_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG2}")
+rm -f "${INVALID_LOG}"
 
 log "Testing with runtime = 0"
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r 0 > "${INVALID_LOG2}" 2>&1
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r 0 > "${INVALID_LOG}" 2>&1
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
@@ -185,11 +142,10 @@ fi
 #=============================================================================
 test_section "Test 7: Invalid runtime value (negative)"
 
-INVALID_LOG3="/tmp/stalld_test_boost_runtime_invalid3_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG3}")
+rm -f "${INVALID_LOG}"
 
 log "Testing with runtime = -5000"
-timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r -5000 > "${INVALID_LOG3}" 2>&1
+timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r -5000 > "${INVALID_LOG}" 2>&1
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index d05daf2..eacce98 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -14,39 +14,11 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "SCHED_DEADLINE Boosting Mechanism"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
+init_functional_test "SCHED_DEADLINE Boosting Mechanism" "test_deadline_boost"
 
 # Get number of CPUs for multi-CPU tests
 NUM_CPUS=$(get_num_cpus)
 
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_deadline_boost_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
 #=============================================================================
 # Test 1: Basic DEADLINE Boost Detection
 #=============================================================================
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index a669fe4..3d17e5e 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -14,35 +14,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "SCHED_FIFO Boosting Mechanism"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_fifo_boost_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
+init_functional_test "SCHED_FIFO Boosting Mechanism" "test_fifo_boost"
 
 #=============================================================================
 # Test 1: FIFO Boost with -F Flag
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 11bcf33..172bc9a 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -18,35 +18,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "FIFO-on-FIFO Priority Starvation Detection"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_fifo_prio_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
+init_functional_test "FIFO-on-FIFO Priority Starvation Detection" "test_fifo_prio"
 
 #=============================================================================
 # Test 1: Basic FIFO-on-FIFO Starvation Detection
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 8ee4f82..1e841b8 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -13,33 +13,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "Force FIFO Option (-F)"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_force_fifo_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
-if [ ! -x "${STARVE_GEN}" ]; then
-    echo -e "${YELLOW}SKIP: starvation_gen not found or not executable${NC}"
-    exit 77
-fi
+init_functional_test "Force FIFO Option (-F)" "test_force_fifo"
 
 #=============================================================================
 # Test 1: Default behavior (should use SCHED_DEADLINE)
diff --git a/tests/functional/test_idle_detection.sh b/tests/functional/test_idle_detection.sh
index a242fca..8017675 100755
--- a/tests/functional/test_idle_detection.sh
+++ b/tests/functional/test_idle_detection.sh
@@ -36,35 +36,7 @@ is_cpu_idle() {
     fi
 }
 
-start_test "Idle CPU Detection"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_idle_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
+init_functional_test "Idle CPU Detection" "test_idle"
 
 # Check if idle detection is enabled by default
 log ""
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 6b476cd..f24c836 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -13,23 +13,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "PID File Option (-P)"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Setup paths
-STALLD_LOG="/tmp/stalld_test_pidfile_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
+init_functional_test "PID File Option (-P)" "test_pidfile"
 
 #=============================================================================
 # Test 1: Default pidfile location (no -P specified)
@@ -76,9 +60,6 @@ CLEANUP_FILES+=("${custom_pidfile}")
 # Ensure pidfile doesn't exist before test
 rm -f "${custom_pidfile}"
 
-STALLD_LOG2="/tmp/stalld_test_pidfile_test2_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG2}")
-
 log "Starting stalld with custom pidfile: ${custom_pidfile}"
 start_stalld -l -t 5 --pidfile "${custom_pidfile}"
 sleep 2
@@ -118,9 +99,6 @@ tmp_pidfile="/tmp/stalld_test_tmp_$$.pid"
 CLEANUP_FILES+=("${tmp_pidfile}")
 rm -f "${tmp_pidfile}"
 
-STALLD_LOG4="/tmp/stalld_test_pidfile_test4_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG4}")
-
 log "Starting stalld with /tmp pidfile: ${tmp_pidfile}"
 start_stalld -l -t 5 --pidfile "${tmp_pidfile}"
 sleep 2
@@ -149,9 +127,6 @@ fg_pidfile="/tmp/stalld_test_pidfile_foreground_$$.pid"
 CLEANUP_FILES+=("${fg_pidfile}")
 rm -f "${fg_pidfile}"
 
-STALLD_LOG5="/tmp/stalld_test_pidfile_test5_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG5}")
-
 log "Starting stalld in foreground mode with pidfile: ${fg_pidfile}"
 start_stalld -f -v -l -t 5 --pidfile "${fg_pidfile}"
 sleep 2
@@ -182,12 +157,6 @@ invalid_pidfile="/nonexistent_${$}/stalld.pid"
 INVALID_LOG="/tmp/stalld_test_pidfile_invalid_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
 
-# Add backend flag for consistency
-BACKEND_FLAG=""
-if [ -n "${STALLD_TEST_BACKEND}" ]; then
-    BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
-fi
-
 log "Testing invalid pidfile path: ${invalid_pidfile}"
 timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 --pidfile "${invalid_pidfile}" > "${INVALID_LOG}" 2>&1
 ret=$?
@@ -198,9 +167,6 @@ else
     fail "stalld did not reject invalid pidfile path"
 fi
 
-# Cleanup
-chmod 755 "${test_dir}"
-
 #=============================================================================
 # Test 7: Verify pidfile is readable by other processes
 #=============================================================================
@@ -210,9 +176,6 @@ readable_pidfile="/tmp/stalld_test_pidfile_readable_$$.pid"
 CLEANUP_FILES+=("${readable_pidfile}")
 rm -f "${readable_pidfile}"
 
-STALLD_LOG7="/tmp/stalld_test_pidfile_test7_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG7}")
-
 log "Starting stalld with readable pidfile: ${readable_pidfile}"
 start_stalld -l -t 5 --pidfile "${readable_pidfile}"
 sleep 2
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 553a7bc..d8f874a 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -21,39 +21,11 @@ get_starved_pid() {
     grep "starved on CPU" "$log_file" | tail -1 | sed -E 's/.*\[([0-9]+)\].*/\1/' | head -1
 }
 
-start_test "Starvation Detection Logic"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
+init_functional_test "Starvation Detection Logic" "test_detection"
 
 # Get number of CPUs for multi-CPU tests
 NUM_CPUS=$(get_num_cpus)
 
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_detection_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
 #=============================================================================
 # Test 1: Basic Starvation Detection
 #=============================================================================
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 62f7420..88d4d4c 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -17,40 +17,7 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "Starvation Threshold Option (-t)"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
-
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_threshold_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
-if [ ! -x "${STARVE_GEN}" ]; then
-    echo -e "${YELLOW}SKIP: starvation_gen not found or not executable${NC}"
-    exit 77
-fi
+init_functional_test "Starvation Threshold Option (-t)" "test_threshold"
 
 #=============================================================================
 # Test 1: Custom threshold (5 seconds)
@@ -82,8 +49,7 @@ cleanup_scenario "${STARVE_PID}"
 test_section "Test 2: No detection before threshold"
 
 threshold=10
-STALLD_LOG2="/tmp/stalld_test_threshold_test2_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG2}")
+rm -f "${STALLD_LOG}"
 
 # Create starvation BEFORE starting stalld (avoid detecting kworker tasks)
 # Create starvation that will last 6 seconds (less than threshold)
@@ -92,7 +58,7 @@ log "Creating short starvation (${starvation_duration}s) with threshold of ${thr
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold"
-start_stalld_with_log "${STALLD_LOG2}" -f -v -N -M -g 1 -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold}
+start_stalld_with_log "${STALLD_LOG}" -f -v -N -M -g 1 -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold}
 
 # Wait for starvation duration + small buffer
 sleep 8
@@ -104,12 +70,12 @@ wait "${STARVE_PID}" 2>/dev/null || true
 sleep 2
 
 # Check that starvation_gen was NOT detected (duration less than threshold)
-if ! grep -qE "starvation_gen.*starved on CPU ${TEST_CPU}|starved on CPU ${TEST_CPU}.*starvation_gen" "${STALLD_LOG2}"; then
+if ! grep -qE "starvation_gen.*starved on CPU ${TEST_CPU}|starved on CPU ${TEST_CPU}.*starvation_gen" "${STALLD_LOG}"; then
     pass "No starvation detected for duration less than threshold"
 else
     fail "Starvation detected before threshold"
     log "Found starvation_gen task in logs:"
-    grep -E "starvation_gen.*starved on CPU|starved on CPU.*starvation_gen" "${STALLD_LOG2}"
+    grep -E "starvation_gen.*starved on CPU|starved on CPU.*starvation_gen" "${STALLD_LOG}"
 fi
 
 # Cleanup
@@ -121,8 +87,7 @@ cleanup_scenario "${STARVE_PID}"
 test_section "Test 3: Shorter threshold (3 seconds)"
 
 threshold=3
-STALLD_LOG3="/tmp/stalld_test_threshold_test3_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG3}")
+rm -f "${STALLD_LOG}"
 
 # Create starvation BEFORE starting stalld (avoid detecting kworker tasks)
 # Create starvation for 8 seconds
@@ -132,13 +97,13 @@ start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold"
 # Use -i to ignore kernel workers that may starve before our test tasks
-start_stalld_with_log "${STALLD_LOG3}" -f -v -N -M -g 1 -i "ksoftirqd,kworker" -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold}
+start_stalld_with_log "${STALLD_LOG}" -f -v -N -M -g 1 -i "ksoftirqd,kworker" -c "${TEST_CPU}" -a "${STALLD_CPU}" -t ${threshold}
 
 # Wait for starvation detection
 log "Waiting for detection (threshold: ${threshold}s)"
 
 # Check if starvation_gen was detected
-assert_starvation_detected "${STALLD_LOG3}" "Starvation detected with ${threshold}s threshold"
+assert_starvation_detected "${STALLD_LOG}" "Starvation detected with ${threshold}s threshold"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
@@ -164,10 +129,9 @@ fi
 
 # Test with negative threshold
 log "Testing with threshold = -5"
-INVALID_LOG2="/tmp/stalld_test_threshold_invalid2_$$.log"
-CLEANUP_FILES+=("${INVALID_LOG2}")
+rm -f "${INVALID_LOG}"
 
-timeout 5 ${TEST_ROOT}/../stalld -f -v -t -5 > "${INVALID_LOG2}" 2>&1
+timeout 5 ${TEST_ROOT}/../stalld -f -v -t -5 > "${INVALID_LOG}" 2>&1
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
diff --git a/tests/functional/test_task_merging.sh b/tests/functional/test_task_merging.sh
index c49499c..72f7c63 100755
--- a/tests/functional/test_task_merging.sh
+++ b/tests/functional/test_task_merging.sh
@@ -14,45 +14,15 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
-start_test "Task Merging Logic"
-
-# Setup test environment
-setup_test_environment
-
-# Require root for this test
-require_root
-
-# Check RT throttling
-if ! check_rt_throttling; then
-    echo -e "${YELLOW}SKIP: RT throttling must be disabled for this test${NC}"
-    exit 77
-fi
-
-# Pick a CPU for testing
-TEST_CPU=$(pick_test_cpu)
-log "Using CPU ${TEST_CPU} for testing"
-
-# Pick a different CPU for stalld to run on (avoid interference)
-STALLD_CPU=0
-if [ ${TEST_CPU} -eq 0 ]; then
-    STALLD_CPU=1
-fi
-log "Stalld will run on CPU ${STALLD_CPU}"
+init_functional_test "Task Merging Logic" "test_merge"
 
 # Check for DL-server (kernel automatic starvation handling)
-# If DL-server is present, the kernel handles starvation automatically,
-# so stalld won't detect starvation and we can't test task merging logic
 if [ -d "/sys/kernel/debug/sched/fair_server" ]; then
     echo -e "${YELLOW}SKIP: DL-server detected - kernel handles starvation automatically${NC}"
     echo "      Task merging cannot be tested when DL-server prevents starvation"
     exit 77
 fi
 
-# Setup paths
-STARVE_GEN="${TEST_ROOT}/helpers/starvation_gen"
-STALLD_LOG="/tmp/stalld_test_merge_$$.log"
-CLEANUP_FILES+=("${STALLD_LOG}")
-
 #=============================================================================
 # Test 1: Timestamp Preservation for Non-Progressing Tasks
 #=============================================================================
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index ced067c..389310b 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -1154,8 +1154,19 @@ init_functional_test() {
 	STALLD_LOG="/tmp/stalld_${log_suffix}_$$.log"
 	CLEANUP_FILES+=("${STALLD_LOG}")
 
+	if [ ! -x "${STARVE_GEN}" ]; then
+		echo -e "${YELLOW}SKIP: starvation_gen not found or not executable${NC}"
+		exit 77
+	fi
+
+	# Build backend flag for direct stalld invocations
+	BACKEND_FLAG=""
+	if [ -n "${STALLD_TEST_BACKEND}" ]; then
+		BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
+	fi
+
 	# Export variables for use in test
-	export TEST_CPU STALLD_CPU STARVE_GEN STALLD_LOG
+	export TEST_CPU STALLD_CPU STARVE_GEN STALLD_LOG BACKEND_FLAG
 }
 
 # Start starvation_gen in background with readiness detection
-- 
2.53.0

