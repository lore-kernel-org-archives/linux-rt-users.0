Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94133E2AD5
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943598; cv=none; b=ghvO5TdO4Z5G1U4hssigfwbUADpN47f3M74cFxZ+Dy+6gHa8RSFCpLKi4B9/bXgZ0f8Qe3eSzSDVkiQsEnO6y2AFHnUeaoFl+Fg6Ucj/Ssd5pS9G1n5lpdYhiYQt25h1FQvkjpbTNAvjy7orInC3tJ/NPhD0xaxgcyo5pELjZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943598; c=relaxed/simple;
	bh=i/c9wDJJpyDSLO0jO1bV8y7Tic+Oiom+Ed23M0Bh1sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9O2fkK++2aWbjmSAJ2ws9nUoZf/jvnLL2sJCzO2ANxY8Bk2zstZS5fEl4ARFWdk/ywhxNZ/LWAfA1LhNSmdMr0LqwqUm9/RPjDayIV8TGGpEBtzL1KvCiPkj0GJ+n9KSKWi5WlkVZsRGF+UK8+QlbrpOCk4+XUnPVoCFW5Kgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inVuIGuA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inVuIGuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQDK7qxWhqOEfMq3W8uzSL7fInt9os8um8BCY0VlDlo=;
	b=inVuIGuA+tL2YWAo98aPhyf1NbT9r3j0SDHpBr2Zbzn23/vPL5G86dDmSMQTMlMWdYgI9A
	mCuzKv/DGbHhScX1KnG9q5xyomDy6b5AeuN8x7+r3t1i7OCP4GtJNaDXfYrS7v/8o4TPp+
	Ft9q4nBM0rih2DTpj3X5mazE0PpXR4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-m3FuLtiTMJqRD1CN_u8a3g-1; Mon,
 08 Jun 2026 14:33:14 -0400
X-MC-Unique: m3FuLtiTMJqRD1CN_u8a3g-1
X-Mimecast-MFC-AGG-ID: m3FuLtiTMJqRD1CN_u8a3g_1780943593
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B01861977035;
	Mon,  8 Jun 2026 18:33:13 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A63CD36927;
	Mon,  8 Jun 2026 18:33:11 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 21/52] tests: Remove if-wrappers around assert calls
Date: Mon,  8 Jun 2026 15:31:31 -0300
Message-ID: <20260608183206.140526-22-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is the second commit in a series introducing fail-fast semantics
to the test suite. Currently, several test scripts wrap assertion calls
in conditional blocks to guard subsequent execution steps.

Since the guarded test logic only makes sense when the initial assertion
passes, these conditional wrappers create unnecessary nesting. Once the
failure mechanism is updated to be immediately fatal in the next commit,
these protective conditional structures will become completely
redundant.

Removing the conditional structures and flattening the code flow across
the foreground, logging, pidfile, and starvation test scripts improves
overall readability and maintainability. Branches handling non-fatal
conditions such as skips or informational warnings have been preserved
in their original form.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_foreground.sh           | 36 +++++++----------
 tests/functional/test_logging_destinations.sh | 20 +++-------
 tests/functional/test_pidfile.sh              | 39 +++++--------------
 tests/functional/test_starvation_detection.sh |  7 +---
 4 files changed, 29 insertions(+), 73 deletions(-)

diff --git a/tests/functional/test_foreground.sh b/tests/functional/test_foreground.sh
index f5de736..792aee0 100755
--- a/tests/functional/test_foreground.sh
+++ b/tests/functional/test_foreground.sh
@@ -26,17 +26,13 @@ test_section "Test 1: stalld daemonizes by default"
 start_stalld -l -t 5
 sleep 2
 
-# Check if stalld is running
-if assert_process_running "${STALLD_PID}" "stalld should be running"; then
-	# Check parent process - should be init (PID 1) or systemd
-	PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
-	if [ "${PARENT_PID}" == "1" ] || [ "${PARENT_PID}" == "2" ]; then
-		pass "stalld daemonized (parent is init/kthreadd)"
-	else
-		# On modern systems with session leaders, ppid might not be 1
-		# Just verify it's not our shell's PID
-		assert_success "stalld daemonized (parent is not test shell)" test "${PARENT_PID}" != "$$"
-	fi
+assert_process_running "${STALLD_PID}" "stalld should be running"
+
+PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
+if [ "${PARENT_PID}" == "1" ] || [ "${PARENT_PID}" == "2" ]; then
+	pass "stalld daemonized (parent is init/kthreadd)"
+else
+	assert_success "stalld daemonized (parent is not test shell)" test "${PARENT_PID}" != "$$"
 fi
 
 stop_stalld
@@ -48,15 +44,10 @@ test_section "Test 2: stalld stays in foreground with -f"
 start_stalld -f -l -t 5
 sleep 2
 
-# Check if stalld is running
-if assert_process_running "${STALLD_PID}" "stalld should be running with -f"; then
-	# With -f, it should NOT daemonize, parent should be our shell
-	PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
+assert_process_running "${STALLD_PID}" "stalld should be running with -f"
 
-	# The parent might be the subshell from start_stalld, not directly our shell
-	# So we just verify it's not PID 1
-	assert_success "stalld did not daemonize with -f (parent is not init)" test "${PARENT_PID}" != "1"
-fi
+PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
+assert_success "stalld did not daemonize with -f (parent is not init)" test "${PARENT_PID}" != "1"
 
 stop_stalld
 
@@ -66,11 +57,10 @@ test_section "Test 3: -v implies foreground mode"
 start_stalld -v -l -t 5
 sleep 2
 
-if assert_process_running "${STALLD_PID}" "stalld should be running with -v"; then
-	PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
+assert_process_running "${STALLD_PID}" "stalld should be running with -v"
 
-	assert_success "-v implies foreground mode" test "${PARENT_PID}" != "1"
-fi
+PARENT_PID=$(ps -o ppid= -p ${STALLD_PID} 2>/dev/null | tr -d ' ')
+assert_success "-v implies foreground mode" test "${PARENT_PID}" != "1"
 
 stop_stalld
 
diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index 5a8cc5b..a25e571 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -35,17 +35,9 @@ CLEANUP_FILES+=("${LOG_FILE}")
 
 start_stalld_with_log "${LOG_FILE}" -f -v -l -t 5
 
-if assert_process_running "${STALLD_PID}" "stalld should be running"; then
-	# Check that output was written to our log file
-	if [ -s "${LOG_FILE}" ]; then
-		pass "verbose mode produces output"
-
-		# Should contain initialization messages
-		assert_log_contains "${LOG_FILE}" "stalld\|version\|monitoring" "output contains expected messages"
-	else
-		fail "no output in verbose mode"
-	fi
-fi
+assert_process_running "${STALLD_PID}" "stalld should be running"
+assert_success "verbose mode produces output" test -s "${LOG_FILE}"
+assert_log_contains "${LOG_FILE}" "stalld\|version\|monitoring" "output contains expected messages"
 
 stop_stalld
 
@@ -147,10 +139,8 @@ CLEANUP_FILES+=("${LOG_FILE}")
 
 start_stalld_with_log "${LOG_FILE}" -f -v -k -s -l -t 5
 
-if assert_process_running "${STALLD_PID}" "stalld with combined logging should be running"; then
-	# Verify verbose output
-	assert_success "combined logging produces output" test -s "${LOG_FILE}"
-fi
+assert_process_running "${STALLD_PID}" "stalld with combined logging should be running"
+assert_success "combined logging produces output" test -s "${LOG_FILE}"
 
 stop_stalld
 
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 23c60e5..75b5359 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -60,16 +60,10 @@ log "Starting stalld with custom pidfile: ${custom_pidfile}"
 start_stalld -l -t 5 --pidfile "${custom_pidfile}"
 sleep 2
 
-# Verify pidfile was created
-if [ -f "${custom_pidfile}" ]; then
-    pass "Custom pidfile created at ${custom_pidfile}"
+assert_file_exists "${custom_pidfile}" "Custom pidfile created at ${custom_pidfile}"
 
-    # Verify content
-    pid_from_file=$(cat "${custom_pidfile}")
-    assert_success "Custom pidfile contains correct PID" test "$pid_from_file" = "${STALLD_PID}"
-else
-    fail "Custom pidfile not created at ${custom_pidfile}"
-fi
+pid_from_file=$(cat "${custom_pidfile}")
+assert_success "Custom pidfile contains correct PID" test "$pid_from_file" = "${STALLD_PID}"
 
 # Test 3: Verify pidfile removed on clean shutdown
 test_section "Test 3: Verify pidfile removed on clean shutdown"
@@ -95,14 +89,10 @@ log "Starting stalld with /tmp pidfile: ${tmp_pidfile}"
 start_stalld -l -t 5 --pidfile "${tmp_pidfile}"
 sleep 2
 
-if [ -f "${tmp_pidfile}" ]; then
-    pass "Pidfile created in /tmp directory"
+assert_file_exists "${tmp_pidfile}" "Pidfile created in /tmp directory"
 
-    pid_from_file=$(cat "${tmp_pidfile}")
-    assert_success "/tmp pidfile contains correct PID" test "$pid_from_file" = "${STALLD_PID}"
-else
-    fail "Pidfile not created in /tmp"
-fi
+pid_from_file=$(cat "${tmp_pidfile}")
+assert_success "/tmp pidfile contains correct PID" test "$pid_from_file" = "${STALLD_PID}"
 
 stop_stalld
 
@@ -151,20 +141,11 @@ log "Starting stalld with readable pidfile: ${readable_pidfile}"
 start_stalld -l -t 5 --pidfile "${readable_pidfile}"
 sleep 2
 
-if [ -f "${readable_pidfile}" ]; then
-    # Try to read the pidfile as a regular user would
-    if cat "${readable_pidfile}" > /dev/null 2>&1; then
-        pass "Pidfile is readable"
+assert_file_exists "${readable_pidfile}" "Pidfile created"
+assert_success "Pidfile is readable" cat "${readable_pidfile}"
 
-        # Check permissions
-        perms=$(stat -c "%a" "${readable_pidfile}" 2>/dev/null || stat -f "%Lp" "${readable_pidfile}" 2>/dev/null)
-        log "ℹ INFO: Pidfile permissions: $perms"
-    else
-        fail "Pidfile not readable"
-    fi
-else
-    fail "Pidfile not created"
-fi
+perms=$(stat -c "%a" "${readable_pidfile}" 2>/dev/null || stat -f "%Lp" "${readable_pidfile}" 2>/dev/null)
+log "ℹ INFO: Pidfile permissions: $perms"
 
 stop_stalld
 
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 1df6bb0..1d43516 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -186,12 +186,7 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 1 -d 3
 # Wait for task to exit
 sleep 5
 
-# Verify stalld is still running (didn't crash)
-if assert_process_running "${STALLD_PID}" "stalld still running after task exit"; then
-    pass "stalld handled task exit gracefully"
-else
-    fail "stalld crashed or exited unexpectedly"
-fi
+assert_process_running "${STALLD_PID}" "stalld still running after task exit"
 
 # Check for error messages
 assert_log_contains --negate --ignore-case "${STALLD_LOG}" "error\|segfault\|crash" "No error messages in log"
-- 
2.54.0

