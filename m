Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6438228E
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899898; cv=none; b=W5e97mdE2+fp81i6MLeMc689Kw0iHLEvApqjHs65LUlHbGqOvYskA3EmYmXTZV5SDzE57cVN1el6moA/g3i56FaXPul0ucUvwHywIcfQ8TBCFQkdXH9PPXoQu006nYob3NMuu4kZJPlkYXUhl92oBW65Xli47bY3JGNymZ8yiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899898; c=relaxed/simple;
	bh=4rlXcPn/BYWxRSTDEQ7Icx3BRrFcxddQyo+StohrDAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAC3Wtutcwe3jCWyzhDXzszuimu0YaHdPZ/ueM/25boN6/bmrPaA9+FDrkTM61q/wHXadBxzq/EpPyM5Thsxy4prpkH0LkGReiuoW4OB1Y70zmwhVSsUs8jOAnDOUjUEIxiHCVaAXXwjir3e61Zkk1TT/AlJPtODjPTGrEdtUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZnoAPTZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZnoAPTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgtUqNgM2foDZhqOJmTkmc37nKEsHQeZyZRbihagNjI=;
	b=eZnoAPTZJCSxi2mx9t0rvU25ifUiUCnO+Tg6ZdM7XMWavstDovvTd+iJe55z0szGKnBYhW
	xOaWJwDdGIR6YrIR0hT+1yIWwTiP9gUWD3f1Rnaalc+yrxt6Z9tPfLCxO3ej5FiWq5Misb
	nRPXlAj6bVQrEq+wgcP8NpCYanom+TE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-afeb7AbRNsW02csmjaFgTQ-1; Mon,
 30 Mar 2026 15:44:54 -0400
X-MC-Unique: afeb7AbRNsW02csmjaFgTQ-1
X-Mimecast-MFC-AGG-ID: afeb7AbRNsW02csmjaFgTQ_1774899892
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44A91195609E;
	Mon, 30 Mar 2026 19:44:52 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 722D21954102;
	Mon, 30 Mar 2026 19:44:49 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 05/36] tests/functional: Fix and refactor test_backend_selection.sh
Date: Mon, 30 Mar 2026 16:43:28 -0300
Message-ID: <20260330194410.103953-6-wander@redhat.com>
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

test_backend_selection.sh fails when invoked by run_tests.sh because
it uses a relative path (../stalld) that resolves incorrectly when the
working directory is not tests/functional/. It also lacks
parse_test_options for backend passthrough from the test runner, does
not track temporary log files for cleanup, and contains four
copy-pasted 30-line blocks that implement the same
start/verify/check/stop pattern.

Extract the repeated pattern into a test_backend_flag() helper
function that starts stalld with a given -b flag, verifies the
expected backend message appears in the log, and calls stop_stalld.
The helper uses $! instead of pgrep for PID capture since stalld
runs in foreground mode. Fix the stalld path to use ${TEST_ROOT},
add parse_test_options and CLEANUP_FILES tracking, and correct the
test numbering.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_backend_selection.sh | 193 +++++++--------------
 1 file changed, 61 insertions(+), 132 deletions(-)

diff --git a/tests/functional/test_backend_selection.sh b/tests/functional/test_backend_selection.sh
index 6227756..5d60072 100755
--- a/tests/functional/test_backend_selection.sh
+++ b/tests/functional/test_backend_selection.sh
@@ -10,6 +10,7 @@
 
 TEST_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
 source "${TEST_ROOT}/helpers/test_helpers.sh"
+parse_test_options "$@" || exit $?
 
 start_test "Backend Selection"
 
@@ -18,155 +19,83 @@ setup_test_environment
 
 require_root
 
-# Test 1: Start stalld with sched_debug backend
-echo "Test 1: Starting stalld with sched_debug backend"
-STALLD_LOG="/tmp/stalld_backend_sched_debug_$$.log"
-# Call stalld directly to capture its actual stderr output
-# IMPORTANT: -v must come BEFORE -b so verbose mode is enabled when backend message is logged
-../stalld -v -f -l -b sched_debug -t 60 > "${STALLD_LOG}" 2>&1 &
-sleep 1
-# Get the actual stalld PID
-STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
-if [ -z "${STALLD_PID}" ]; then
-	TEST_FAILED=$((TEST_FAILED + 1))
-	echo -e "  ${RED}FAIL${NC}: stalld failed to start with sched_debug backend"
-else
+# Helper: start stalld with a specific backend flag, verify the expected
+# backend message appears in the log. This test intentionally bypasses
+# start_stalld_with_log() because it needs to control the -b flag
+# directly rather than inheriting it from STALLD_TEST_BACKEND.
+#
+# Usage: test_backend_flag <backend_flag> <expected_message> <description>
+test_backend_flag() {
+	local backend_flag=$1
+	local expected_msg=$2
+	local description=$3
+	local log_file="/tmp/stalld_backend_${backend_flag}_$$.log"
+
+	CLEANUP_FILES+=("${log_file}")
+
+	"${TEST_ROOT}/../stalld" -v -f -l -b "${backend_flag}" -t 60 \
+		> "${log_file}" 2>&1 &
+	STALLD_PID=$!
 	CLEANUP_PIDS+=("${STALLD_PID}")
 	sleep 1
-	if kill -0 ${STALLD_PID} 2>/dev/null; then
-		# Check if log contains backend message
-		if grep -q "using sched_debug backend" "${STALLD_LOG}"; then
-			assert_equals "0" "0" "sched_debug backend selected"
-		else
-			TEST_FAILED=$((TEST_FAILED + 1))
-			echo -e "  ${RED}FAIL${NC}: Backend message not found in log"
-			echo "  Log contents:"
-			cat "${STALLD_LOG}"
-		fi
-		stop_stalld
+
+	if ! kill -0 ${STALLD_PID} 2>/dev/null; then
+		TEST_FAILED=$((TEST_FAILED + 1))
+		echo -e "  ${RED}FAIL${NC}: stalld failed to start (${description})"
+		return 1
+	fi
+
+	if grep -q "${expected_msg}" "${log_file}"; then
+		assert_equals "0" "0" "${description}"
 	else
 		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: stalld failed to start with sched_debug backend"
+		echo -e "  ${RED}FAIL${NC}: Backend message not found (${description})"
+		echo "  Expected: ${expected_msg}"
+		echo "  Log contents:"
+		cat "${log_file}"
 	fi
-fi
-rm -f "${STALLD_LOG}"
 
+	stop_stalld
+}
+
+# Test 1: sched_debug backend (full name)
+echo "Test 1: Starting stalld with sched_debug backend"
+test_backend_flag "sched_debug" "using sched_debug backend" \
+	"sched_debug backend selected"
+
+# Test 2: queue_track backend (if available)
 echo ""
-echo "=== Test 4: Check queue_track (BPF) backend availability ==="
+echo "Test 2: Check queue_track (BPF) backend"
 if is_backend_available "queue_track"; then
-	echo "Test 2a: Starting stalld with queue_track backend"
-	STALLD_LOG="/tmp/stalld_backend_queue_track_$$.log"
-	# Call stalld directly to capture its actual stderr output
-	# IMPORTANT: -v must come BEFORE -b so verbose mode is enabled when backend message is logged
-	../stalld -v -f -l -b queue_track -t 60 > "${STALLD_LOG}" 2>&1 &
-	sleep 1
-	# Get the actual stalld PID
-	STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
-	if [ -z "${STALLD_PID}" ]; then
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: stalld failed to start with queue_track backend"
-	else
-		CLEANUP_PIDS+=("${STALLD_PID}")
-		sleep 1
-		if kill -0 ${STALLD_PID} 2>/dev/null; then
-			# Check if log contains backend message
-			if grep -q "using queue_track backend" "${STALLD_LOG}"; then
-				assert_equals "0" "0" "queue_track backend selected"
-			else
-				TEST_FAILED=$((TEST_FAILED + 1))
-				echo -e "  ${RED}FAIL${NC}: Backend message not found in log"
-				echo "  Log contents:"
-				cat "${STALLD_LOG}"
-			fi
-			stop_stalld
-		else
-			TEST_FAILED=$((TEST_FAILED + 1))
-			echo -e "  ${RED}FAIL${NC}: stalld failed to start with queue_track backend"
-		fi
-	fi
-	rm -f "${STALLD_LOG}"
+	test_backend_flag "queue_track" "using queue_track backend" \
+		"queue_track backend selected"
 else
-	echo "ℹ queue_track (BPF) backend not available"
-	echo "  (This is expected on i686, powerpc, ppc64le, or kernels ≤3.x)"
+	echo "  queue_track (BPF) backend not available"
+	echo "  (This is expected on i686, powerpc, ppc64le, or kernels <=3.x)"
 	TEST_PASSED=$((TEST_PASSED + 1))
 fi
 
-# Test 3: Test short names (S for sched_debug)
+# Test 3: Short name 'S' for sched_debug
+echo ""
 echo "Test 3: Testing short name 'S' for sched_debug"
-STALLD_LOG="/tmp/stalld_backend_short_S_$$.log"
-# Call stalld directly to capture its actual stderr output
-# IMPORTANT: -v must come BEFORE -b so verbose mode is enabled when backend message is logged
-../stalld -v -f -l -b S -t 60 > "${STALLD_LOG}" 2>&1 &
-sleep 1
-# Get the actual stalld PID
-STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
-if [ -z "${STALLD_PID}" ]; then
-	TEST_FAILED=$((TEST_FAILED + 1))
-	echo -e "  ${RED}FAIL${NC}: stalld failed to start with short name 'S'"
-else
-	CLEANUP_PIDS+=("${STALLD_PID}")
-	sleep 1
-	if kill -0 ${STALLD_PID} 2>/dev/null; then
-		# Check if log contains backend message
-		if grep -q "using sched_debug backend" "${STALLD_LOG}"; then
-			assert_equals "0" "0" "Short name 'S' works for sched_debug"
-		else
-			TEST_FAILED=$((TEST_FAILED + 1))
-			echo -e "  ${RED}FAIL${NC}: Backend message not found for short name"
-			echo "  Log contents:"
-			cat "${STALLD_LOG}"
-		fi
-		stop_stalld
-	else
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: stalld failed to start with short name 'S'"
-	fi
-fi
-rm -f "${STALLD_LOG}"
+test_backend_flag "S" "using sched_debug backend" \
+	"Short name 'S' works for sched_debug"
 
-# Test 4: Test STALLD_TEST_BACKEND environment variable
+# Test 4: STALLD_TEST_BACKEND environment variable
+echo ""
 if [ -n "${STALLD_TEST_BACKEND}" ]; then
 	echo "Test 4: Testing STALLD_TEST_BACKEND=${STALLD_TEST_BACKEND}"
-	STALLD_LOG="/tmp/stalld_backend_env_$$.log"
-	# Call stalld directly to capture its actual stderr output
-	# start_stalld adds -b based on STALLD_TEST_BACKEND, so we mimic that here
-	# IMPORTANT: -v must come BEFORE -b so verbose mode is enabled when backend message is logged
-	../stalld -v -f -l -b "${STALLD_TEST_BACKEND}" -t 60 > "${STALLD_LOG}" 2>&1 &
-	sleep 1
-	# Get the actual stalld PID
-	STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
-	if [ -z "${STALLD_PID}" ]; then
-		TEST_FAILED=$((TEST_FAILED + 1))
-		echo -e "  ${RED}FAIL${NC}: stalld failed to start with STALLD_TEST_BACKEND"
-	else
-		CLEANUP_PIDS+=("${STALLD_PID}")
-		sleep 1
-		if kill -0 ${STALLD_PID} 2>/dev/null; then
-			# Normalize backend name for comparison
-			BACKEND_NORMALIZED="${STALLD_TEST_BACKEND}"
-			case "${STALLD_TEST_BACKEND}" in
-				S) BACKEND_NORMALIZED="sched_debug" ;;
-				Q) BACKEND_NORMALIZED="queue_track" ;;
-			esac
-
-			# Check if log contains backend message
-			if grep -q "using ${BACKEND_NORMALIZED} backend" "${STALLD_LOG}"; then
-				assert_equals "0" "0" "STALLD_TEST_BACKEND environment variable respected"
-			else
-				TEST_FAILED=$((TEST_FAILED + 1))
-				echo -e "  ${RED}FAIL${NC}: Backend ${BACKEND_NORMALIZED} not used from environment"
-				echo "  Log contents:"
-				cat "${STALLD_LOG}"
-			fi
-			stop_stalld
-		else
-			echo "ℹ Could not verify backend in logs (may not be logged)"
-			TEST_PASSED=$((TEST_PASSED + 1))
-		fi
-	fi
-	rm -f "${STALLD_LOG}"
+	# Normalize short names for expected message
+	BACKEND_NORMALIZED="${STALLD_TEST_BACKEND}"
+	case "${STALLD_TEST_BACKEND}" in
+		S) BACKEND_NORMALIZED="sched_debug" ;;
+		Q) BACKEND_NORMALIZED="queue_track" ;;
+	esac
+	test_backend_flag "${STALLD_TEST_BACKEND}" \
+		"using ${BACKEND_NORMALIZED} backend" \
+		"STALLD_TEST_BACKEND environment variable respected"
 else
-	echo "ℹ Skipping queue_track test - backend not available on this system"
+	echo "Test 4: Skipping (STALLD_TEST_BACKEND not set)"
 	TEST_PASSED=$((TEST_PASSED + 1))
 fi
 
-- 
2.53.0

