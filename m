Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C183290A1
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899975; cv=none; b=mRDdkGYuzSPQI/+cw9OE4J3JqD5hX5F20cFyYbmUWzU6Qus8J/0Pd8JECkED6XONEQxgqpm3ZKh/tvND9yaZzs27rv04jdIMkBosXNTMc0Y/3jQ+F6AdPxrHpg99h96hKm3pyluLlZvzmwykqsMPcc5/OMqerUMgfAFcz2anMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899975; c=relaxed/simple;
	bh=BEir2gwNSqdzZERH2KXgBXBq3fMkEaerE8TkOPySQMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/IH9mT5EQFkTn0/6hyjS5qiRvZgkE7skXbSxDz8WbkgNNu+Eo2fEYQSMSbfrnvxUvAlwvg1EL+LxoA3jtHmyIZVwfP0M42vGvmFlBMoQZ0HILA13NdfaiYSUeXKSV5RPIwgwg743vsYLHPV5GnRyJHaXdvAxj5tHVo7sNoHLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XC8EjMX+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC8EjMX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTf8pmhDJWuXazqDF7QZmeoIj2i/r1FqBIHAEzWre3M=;
	b=XC8EjMX+ZIw0olYC3TqDwIGuqc6WcYfcPhMBWgPHHKFllghVfr3WNYG9nHotUQP5qKYgUi
	JJb0r8/skQPnrn0LafusCjeI+ABHqwjAE66UG2MUszdJxUZ8Sd371d0VUU6nJjydyvVMgc
	4+tpytW5kbP1qqx91Gca1Xfn84cs1eE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-cfe352OlPD2_9o52_oayog-1; Mon,
 30 Mar 2026 15:46:08 -0400
X-MC-Unique: cfe352OlPD2_9o52_oayog-1
X-Mimecast-MFC-AGG-ID: cfe352OlPD2_9o52_oayog_1774899967
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D3901944DC5;
	Mon, 30 Mar 2026 19:46:07 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0B491954102;
	Mon, 30 Mar 2026 19:46:04 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 28/36] tests: Add pass() helper and replace assert_equals hack
Date: Mon, 30 Mar 2026 16:43:51 -0300
Message-ID: <20260330194410.103953-29-wander@redhat.com>
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

Tests record pass results by calling assert_equals with identical
expected and actual values, which is non-obvious and misleading.
Add a pass() function that directly increments the pass counter
and logs the result, then replace all 33 occurrences of the hack
across 13 test files.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_affinity.sh             |  2 +-
 tests/functional/test_backend_selection.sh    |  2 +-
 tests/functional/test_boost_duration.sh       |  4 ++--
 tests/functional/test_boost_period.sh         |  4 ++--
 tests/functional/test_boost_runtime.sh        |  6 +++---
 tests/functional/test_cpu_selection.sh        | 12 ++++++------
 tests/functional/test_fifo_boosting.sh        |  2 +-
 tests/functional/test_force_fifo.sh           |  2 +-
 tests/functional/test_foreground.sh           |  8 ++++----
 tests/functional/test_log_only.sh             |  4 ++--
 tests/functional/test_logging_destinations.sh | 14 +++++++-------
 tests/functional/test_pidfile.sh              |  2 +-
 tests/functional/test_starvation_threshold.sh |  4 ++--
 tests/helpers/test_helpers.sh                 | 11 ++++++++++-
 14 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index eac61f5..738822e 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -268,7 +268,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 -a ${invalid_cpu}
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Invalid CPU affinity rejected with error"
+    pass "Invalid CPU affinity rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid CPU affinity"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_backend_selection.sh b/tests/functional/test_backend_selection.sh
index c274025..8a22e0a 100755
--- a/tests/functional/test_backend_selection.sh
+++ b/tests/functional/test_backend_selection.sh
@@ -46,7 +46,7 @@ test_backend_flag() {
 	fi
 
 	if grep -q "${expected_msg}" "${log_file}"; then
-		assert_equals "0" "0" "${description}"
+		pass "${description}"
 	else
 		TEST_FAILED=$((TEST_FAILED + 1))
 		echo -e "  ${RED}FAIL${NC}: Backend message not found (${description})"
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index ff43df3..104f298 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -200,7 +200,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d 0 > "$
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Zero duration rejected with error"
+    pass "Zero duration rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid duration value 0"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -215,7 +215,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -d -5 > "
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Negative duration rejected with error"
+    pass "Negative duration rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid negative duration"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_boost_period.sh b/tests/functional/test_boost_period.sh
index 5b0ef2c..b516350 100755
--- a/tests/functional/test_boost_period.sh
+++ b/tests/functional/test_boost_period.sh
@@ -193,7 +193,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p 0 > "${I
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Zero period rejected with error"
+    pass "Zero period rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid period value 0"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -214,7 +214,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t $threshold -p -1000000
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Negative period rejected with error"
+    pass "Negative period rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid negative period"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index 83e8fc5..d516604 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -200,7 +200,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r ${inva
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Runtime > period rejected with error"
+    pass "Runtime > period rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid runtime > period"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -222,7 +222,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r 0 > "$
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Zero runtime rejected with error"
+    pass "Zero runtime rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid runtime value 0"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -244,7 +244,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -t ${threshold} -r -5000
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Negative runtime rejected with error"
+    pass "Negative runtime rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid negative runtime"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_cpu_selection.sh b/tests/functional/test_cpu_selection.sh
index 7960f6c..2f9875d 100755
--- a/tests/functional/test_cpu_selection.sh
+++ b/tests/functional/test_cpu_selection.sh
@@ -42,7 +42,7 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 
 # Check that stalld mentions CPU 0
 if grep -q "cpu 0" "$STALLD_LOG"; then
-    assert_equals "1" "1" "stalld monitoring CPU 0"
+    pass "stalld monitoring CPU 0"
 else
     TEST_FAILED=$((TEST_FAILED + 1))
     echo -e "  ${RED}FAIL${NC}: stalld not monitoring CPU 0"
@@ -68,7 +68,7 @@ if [ "$num_cpus" -ge 4 ]; then
     fi
 
     if [ "$cpu0_found" -eq 1 ] && [ "$cpu2_found" -eq 1 ]; then
-        assert_equals "1" "1" "stalld monitoring CPUs 0 and 2"
+        pass "stalld monitoring CPUs 0 and 2"
     else
         TEST_FAILED=$((TEST_FAILED + 1))
         echo -e "  ${RED}FAIL${NC}: stalld not monitoring specified CPUs (0: $cpu0_found, 2: $cpu2_found)"
@@ -101,7 +101,7 @@ if [ "$num_cpus" -ge 4 ]; then
     fi
 
     if [ "$cpu0_found" -eq 1 ] && [ "$cpu1_found" -eq 1 ] && [ "$cpu2_found" -eq 1 ]; then
-        assert_equals "1" "1" "stalld monitoring CPUs 0-2"
+        pass "stalld monitoring CPUs 0-2"
     else
         TEST_FAILED=$((TEST_FAILED + 1))
         echo -e "  ${RED}FAIL${NC}: stalld not monitoring specified CPU range (0: $cpu0_found, 1: $cpu1_found, 2: $cpu2_found)"
@@ -128,7 +128,7 @@ if [ "$num_cpus" -ge 6 ]; then
     done
 
     if [ "$monitored_cpus" -eq 4 ]; then
-        assert_equals "1" "1" "stalld monitoring combined CPU specification (0,2-4)"
+        pass "stalld monitoring combined CPU specification (0,2-4)"
     else
         TEST_FAILED=$((TEST_FAILED + 1))
         echo -e "  ${RED}FAIL${NC}: stalld not monitoring all specified CPUs (found $monitored_cpus/4)"
@@ -153,7 +153,7 @@ timeout 5 "${TEST_ROOT}/../stalld" -f -v -c $invalid_cpu -l -t 5 > "${INVALID_LO
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "stalld rejected invalid CPU number"
+    pass "stalld rejected invalid CPU number"
 else
     log "✗ FAIL: stalld did not reject invalid CPU"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -168,7 +168,7 @@ if [ "$num_cpus" -ge 2 ]; then
 
     # Check that CPU 1 is NOT mentioned (or mentioned as "not monitoring")
     if ! grep -q "cpu 1" "$STALLD_LOG" || grep -q "not monitoring.*cpu 1" "$STALLD_LOG"; then
-        assert_equals "1" "1" "stalld not monitoring non-selected CPU 1"
+        pass "stalld not monitoring non-selected CPU 1"
     else
         TEST_FAILED=$((TEST_FAILED + 1))
         echo -e "  ${RED}FAIL${NC}: stalld appears to be monitoring CPU 1 when only CPU 0 selected"
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index dee3250..1da1c09 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -335,7 +335,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v -F -t 5 -c ${TEST_CPU} > "${STALLD_LOG_FA
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "stalld exited as expected"
+    pass "stalld exited as expected"
 else
     log "✗ FAIL: stalld did not reject FIFO in single-threaded mode"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 2c21ddd..f8f7b4c 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -218,7 +218,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F > "${
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "single-threaded mode rejected FIFO"
+    pass "single-threaded mode rejected FIFO"
 else
     log "✗ FAIL: stalld did not reject -F in single-threaded mode"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_foreground.sh b/tests/functional/test_foreground.sh
index c5afbba..2bb0282 100755
--- a/tests/functional/test_foreground.sh
+++ b/tests/functional/test_foreground.sh
@@ -31,12 +31,12 @@ if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 	# Check parent process - should be init (PID 1) or systemd
 	PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
 	if [ "${PARENT_PID}" == "1" ] || [ "${PARENT_PID}" == "2" ]; then
-		assert_equals "1" "1" "stalld daemonized (parent is init/kthreadd)"
+		pass "stalld daemonized (parent is init/kthreadd)"
 	else
 		# On modern systems with session leaders, ppid might not be 1
 		# Just verify it's not our shell's PID
 		if [ "${PARENT_PID}" != "$$" ]; then
-			assert_equals "1" "1" "stalld daemonized (parent is not test shell)"
+			pass "stalld daemonized (parent is not test shell)"
 		else
 			TEST_FAILED=$((TEST_FAILED + 1))
 			echo -e "  ${RED}FAIL${NC}: stalld did not daemonize (parent is test shell)"
@@ -62,7 +62,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running with -f"; th
 	# The parent might be the subshell from start_stalld, not directly our shell
 	# So we just verify it's not PID 1
 	if [ "${PARENT_PID}" != "1" ]; then
-		assert_equals "1" "1" "stalld did not daemonize with -f (parent is not init)"
+		pass "stalld did not daemonize with -f (parent is not init)"
 	else
 		TEST_FAILED=$((TEST_FAILED + 1))
 		echo -e "  ${RED}FAIL${NC}: stalld daemonized even with -f flag"
@@ -82,7 +82,7 @@ if assert_process_running "${STALLD_PID}" "stalld should be running with -v"; th
 	PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
 
 	if [ "${PARENT_PID}" != "1" ]; then
-		assert_equals "1" "1" "-v implies foreground mode"
+		pass "-v implies foreground mode"
 	else
 		TEST_FAILED=$((TEST_FAILED + 1))
 		echo -e "  ${RED}FAIL${NC}: -v should imply foreground mode"
diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index ba72b8e..d6257cf 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -59,7 +59,7 @@ echo "Waiting for starvation detection..."
 
 # Check if stalld detected the starvation (should log it)
 if wait_for_starvation_detected "${LOG_FILE}"; then
-	assert_equals "1" "1" "stalld detected and logged starvation"
+	pass "stalld detected and logged starvation"
 else
 	TEST_FAILED=$((TEST_FAILED + 1))
 	echo -e "  ${RED}FAIL${NC}: stalld did not detect starvation"
@@ -69,7 +69,7 @@ fi
 
 # Check that stalld did NOT boost (should not see "boosted" message with -l)
 if ! grep -q "boosted" "${LOG_FILE}"; then
-	assert_equals "1" "1" "stalld did not boost in log-only mode"
+	pass "stalld did not boost in log-only mode"
 else
 	TEST_FAILED=$((TEST_FAILED + 1))
 	echo -e "  ${RED}FAIL${NC}: stalld boosted despite -l flag"
diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index b44c08d..35470c0 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -38,11 +38,11 @@ start_stalld_with_log "${LOG_FILE}" -f -v -l -t 5
 if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 	# Check that output was written to our log file
 	if [ -s "${LOG_FILE}" ]; then
-		assert_equals "1" "1" "verbose mode produces output"
+		pass "verbose mode produces output"
 
 		# Should contain initialization messages
 		if grep -q -E "(stalld|version|monitoring)" "${LOG_FILE}"; then
-			assert_equals "1" "1" "output contains expected messages"
+			pass "output contains expected messages"
 		fi
 	else
 		TEST_FAILED=$((TEST_FAILED + 1))
@@ -72,7 +72,7 @@ if command -v dmesg >/dev/null 2>&1; then
 		if [ ${DMESG_AFTER} -gt ${DMESG_BEFORE} ]; then
 			# Check if recent dmesg contains stalld messages
 			if dmesg | tail -10 | has_stalld_log; then
-				assert_equals "1" "1" "stalld messages in kernel log"
+				pass "stalld messages in kernel log"
 			else
 				echo -e "  ${YELLOW}SKIP${NC}: cannot verify kernel log messages"
 			fi
@@ -111,7 +111,7 @@ if [ -n "${SYSLOG_FILE}" ]; then
 		if [ ${SYSLOG_AFTER} -gt ${SYSLOG_BEFORE} ]; then
 			# Check for stalld messages in recent syslog
 			if tail -20 "${SYSLOG_FILE}" | has_stalld_log; then
-				assert_equals "1" "1" "stalld messages in syslog"
+				pass "stalld messages in syslog"
 			else
 				echo -e "  ${YELLOW}SKIP${NC}: no stalld messages found in syslog"
 			fi
@@ -131,9 +131,9 @@ elif command -v journalctl >/dev/null 2>&1; then
 	if assert_process_running "${STALLD_PID}" "stalld with -s should be running"; then
 		# Check journalctl for stalld messages
 		if journalctl -u stalld --since "1 minute ago" 2>/dev/null | has_stalld_log; then
-			assert_equals "1" "1" "stalld messages in journalctl"
+			pass "stalld messages in journalctl"
 		elif journalctl --since "1 minute ago" 2>/dev/null | has_stalld_log; then
-			assert_equals "1" "1" "stalld messages in system journal"
+			pass "stalld messages in system journal"
 		else
 			echo -e "  ${YELLOW}SKIP${NC}: no stalld messages in journal (may take time to appear)"
 		fi
@@ -156,7 +156,7 @@ start_stalld_with_log "${LOG_FILE}" -f -v -k -s -l -t 5
 if assert_process_running "${STALLD_PID}" "stalld with combined logging should be running"; then
 	# Verify verbose output
 	if [ -s "${LOG_FILE}" ]; then
-		assert_equals "1" "1" "combined logging produces output"
+		pass "combined logging produces output"
 	else
 		TEST_FAILED=$((TEST_FAILED + 1))
 		echo -e "  ${RED}FAIL${NC}: no output with combined logging"
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 6964c0c..fbdc9fe 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -219,7 +219,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v ${BACKEND_FLAG} -l -t 5 --pidfile "${inva
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Invalid pidfile path rejected with error"
+    pass "Invalid pidfile path rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid pidfile path"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index 709f565..b904867 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -191,7 +191,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v -t 0 > "${INVALID_LOG}" 2>&1
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Zero threshold rejected with error"
+    pass "Zero threshold rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid threshold value 0"
     TEST_FAILED=$((TEST_FAILED + 1))
@@ -206,7 +206,7 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v -t -5 > "${INVALID_LOG2}" 2>&1
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    assert_equals "1" "1" "Negative threshold rejected with error"
+    pass "Negative threshold rejected with error"
 else
     log "✗ FAIL: stalld did not reject invalid negative threshold"
     TEST_FAILED=$((TEST_FAILED + 1))
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 864036d..144114c 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -105,6 +105,15 @@ end_test() {
 	fi
 }
 
+# Record a test pass with a description message.
+#
+# Usage: pass "description"
+pass() {
+	local message=${1:-""}
+	log "✓ PASS: ${message}"
+	TEST_PASSED=$((TEST_PASSED + 1))
+}
+
 # Assert functions
 assert_equals() {
 	local expected=$1
@@ -1121,7 +1130,7 @@ start_starvation_gen() {
 
 # Export functions for use in tests
 export -f start_test end_test
-export -f assert_equals assert_contains assert_not_contains
+export -f pass assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
 export -f start_stalld stop_stalld kill_existing_stalld cleanup
-- 
2.53.0

