Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03CF398913
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899961; cv=none; b=oq2cQI7l9NNpXBvCYUUuKTnAjtoAFMMl+N9skzf8P/csOyye2JRYlGEcjZf7PIhR4SAsaRyMMAQrmgyguQwjiCselMlFeCD/VuEpejzo/9FDzNqhgaNtD8VWrdE4ww0a6nVUcIYwed+mg8u2f057SeIE2Uy+aEEdOaOTSHGzQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899961; c=relaxed/simple;
	bh=odSwIFFaQJMsrIlq75y5GBau1rGE+kP0c3wROX2VEUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3YAmWuulJ5esfJi4HO8saY+/NHQl73XRQ0wFHtnJME36Brwu8/XLgpDNX+97JtF9U4Aai4LuwpIGgtEU/8P9BVsyB0vhEETgq+UzcLZd+Mz+ZitHTNr+aAQ5+TPjDo0iDz+jfd4Fj+Sr5zyjo3ejid6CSqGEfoj1a8DQolb54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9wEq3Ij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9wEq3Ij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3NTlHHh44QqCSCwT7wR9x5l2BYcC43qGwMghoUog/8=;
	b=Q9wEq3Ijd8BhqEdFSrVrhU2b0R62UM0xiLjncY5vxoiCZX3HosYjjaKzZtT87+qCAZoyJv
	G7WkVH3AJzh9vzjsfEIsvfeg/FNHAP+p2+W9R9d5OEWp8caKrsU4eHx4/kzAMPp7+elzJ0
	X4HGzvUvfqCfZ0wQ31YYxkIZWxJDrLY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-WL1Xe7dBO_66vXg__CQygg-1; Mon,
 30 Mar 2026 15:45:55 -0400
X-MC-Unique: WL1Xe7dBO_66vXg__CQygg-1
X-Mimecast-MFC-AGG-ID: WL1Xe7dBO_66vXg__CQygg_1774899954
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A76E819560A2;
	Mon, 30 Mar 2026 19:45:54 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0BA41954102;
	Mon, 30 Mar 2026 19:45:51 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 24/36] tests/functional: Use start_stalld_with_log() in test_cpu_selection
Date: Mon, 30 Mar 2026 16:43:47 -0300
Message-ID: <20260330194410.103953-25-wander@redhat.com>
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

Replace the local start_stalld_with_output() helper, which
duplicated start_stalld_with_log() functionality, with direct
calls to start_stalld_with_log(). For the invalid CPU test, run
stalld synchronously under timeout instead of backgrounding and
sleeping, and treat unexpected success or timeout as test failures
rather than warnings.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_cpu_selection.sh | 55 ++++++--------------------
 1 file changed, 11 insertions(+), 44 deletions(-)

diff --git a/tests/functional/test_cpu_selection.sh b/tests/functional/test_cpu_selection.sh
index 9d8ac48..7960f6c 100755
--- a/tests/functional/test_cpu_selection.sh
+++ b/tests/functional/test_cpu_selection.sh
@@ -25,24 +25,6 @@ check_rt_throttling
 STALLD_LOG="/tmp/stalld_cpu_selection_$$.log"
 CLEANUP_FILES+=("${STALLD_LOG}")
 
-# Helper to start stalld with output capture
-start_stalld_with_output() {
-    local args="$@"
-
-    # Add backend option if specified
-    if [ -n "${STALLD_TEST_BACKEND}" ]; then
-        args="-b ${STALLD_TEST_BACKEND} ${args}"
-        echo "Using backend: ${STALLD_TEST_BACKEND}"
-    fi
-
-    # Start stalld with output redirected
-    ${TEST_ROOT}/../stalld ${args} > "${STALLD_LOG}" 2>&1 &
-    STALLD_PID=$!
-    CLEANUP_PIDS+=("${STALLD_PID}")
-    sleep 1
-    echo "stalld started with PID ${STALLD_PID}"
-}
-
 # Get available CPUs
 num_cpus=$(nproc)
 if [ "$num_cpus" -lt 2 ]; then
@@ -56,8 +38,7 @@ echo "System has $num_cpus CPUs"
 echo ""
 echo "Test 1: Single CPU monitoring (-c 0)"
 rm -f "${STALLD_LOG}"
-start_stalld_with_output -f -v -c 0 -l -t 5
-sleep 2
+start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 
 # Check that stalld mentions CPU 0
 if grep -q "cpu 0" "$STALLD_LOG"; then
@@ -74,8 +55,7 @@ if [ "$num_cpus" -ge 4 ]; then
     echo ""
     echo "Test 2: CPU list monitoring (-c 0,2)"
     rm -f "${STALLD_LOG}"
-    start_stalld_with_output -f -v -c 0,2 -l -t 5
-    sleep 2
+    start_stalld_with_log "${STALLD_LOG}" -f -v -c 0,2 -l -t 5
 
     # Check for CPU 0 and CPU 2 in output
     cpu0_found=0
@@ -104,8 +84,7 @@ if [ "$num_cpus" -ge 4 ]; then
     echo ""
     echo "Test 3: CPU range monitoring (-c 0-2)"
     rm -f "${STALLD_LOG}"
-    start_stalld_with_output -f -v -c 0-2 -l -t 5
-    sleep 2
+    start_stalld_with_log "${STALLD_LOG}" -f -v -c 0-2 -l -t 5
 
     # Check for CPUs 0, 1, 2 in output
     cpu0_found=0
@@ -138,8 +117,7 @@ if [ "$num_cpus" -ge 6 ]; then
     echo ""
     echo "Test 4: Combined format (-c 0,2-4)"
     rm -f "${STALLD_LOG}"
-    start_stalld_with_output -f -v -c 0,2-4 -l -t 5
-    sleep 2
+    start_stalld_with_log "${STALLD_LOG}" -f -v -c 0,2-4 -l -t 5
 
     # Should monitor CPUs 0, 2, 3, 4
     monitored_cpus=0
@@ -171,24 +149,14 @@ INVALID_LOG="/tmp/stalld_invalid_cpu_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
 
 # Run stalld with invalid CPU and capture output
-"${TEST_ROOT}/../stalld" -f -v -c $invalid_cpu -l -t 5 > "${INVALID_LOG}" 2>&1 &
-INVALID_PID=$!
-
-# Wait a bit to see if it exits or produces error
-sleep 2
+timeout 5 "${TEST_ROOT}/../stalld" -f -v -c $invalid_cpu -l -t 5 > "${INVALID_LOG}" 2>&1
+ret=$?
 
-if ! kill -0 "$INVALID_PID" 2>/dev/null; then
-    # Process exited - check for error message
-    if grep -qi "error\|invalid\|failed" "$INVALID_LOG"; then
-        assert_equals "1" "1" "stalld rejected invalid CPU number with error"
-    else
-        assert_equals "1" "1" "stalld exited when given invalid CPU"
-    fi
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "stalld rejected invalid CPU number"
 else
-    # Process still running - it might have ignored the invalid CPU
-    echo -e "  ${YELLOW}WARNING${NC}: stalld still running with invalid CPU (may have ignored it)"
-    kill -TERM "$INVALID_PID" 2>/dev/null
-    wait "$INVALID_PID" 2>/dev/null
+    log "✗ FAIL: stalld did not reject invalid CPU"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 # Test 6: Verify non-selected CPUs are NOT monitored
@@ -196,8 +164,7 @@ if [ "$num_cpus" -ge 2 ]; then
     echo ""
     echo "Test 6: Verify non-selected CPUs not monitored (-c 0)"
     rm -f "${STALLD_LOG}"
-    start_stalld_with_output -f -v -c 0 -l -t 5
-    sleep 2
+    start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 
     # Check that CPU 1 is NOT mentioned (or mentioned as "not monitoring")
     if ! grep -q "cpu 1" "$STALLD_LOG" || grep -q "not monitoring.*cpu 1" "$STALLD_LOG"; then
-- 
2.53.0

