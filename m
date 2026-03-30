Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976A39B95F
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899900; cv=none; b=EZHl0ilD4ElJSdLXJN7QKXVm5QsYL5TMoEvvCMx+j3jdutNCPjzVWgft7E0x3DdawmANjSwjeBduKzOsos7o+HkrwxL++f5Pj2mtphXwrJyNyhanPL0QGxXbJc0sNA9Uf4XXscJGlhpP+Zo3Qurlb3iAyZ/HyvoNdtiUvpbSgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899900; c=relaxed/simple;
	bh=GUXUPo8o/DJajPUEpCNLdDxn3sKtVhG/YWW/3eAO1Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv/mPq53VgEOnTqokE7MV1PbwXDKXW3ygRbBGjaoe/EoxjgJCWJB/Y94s5EoI/2V7GUimMdj7FMsHY0gH4iQdRmXfrb79MqcJuccabYHtO/xkD1zosqVWwrARXLvh5pDKDOrYVoD1JFEp57o7lkiXIEyuH1ZjUVPXV+kqj9xlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZGC5nFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZGC5nFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yutAgk9XHqpGP82u3qsjh9oMUmCJotih37s5pXI/2pE=;
	b=aZGC5nFiK+0YJ6JRVXAX/q4S9nwLKHUf6pKx0XNyJAed/l87/ORndVoD/aZCNFM98Vxndl
	+SMTnRlRBlsS0eEZKbIOb3sTGNGHe2Cw6ELw3R3mb2Me3ZqFOuFI0cxSlpXXO9XC27efh/
	JQtMpUAWBsmQOUKqJSt1GouOCtJceXs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-M9NxxZ-3Pe-FOITpG_NAyQ-1; Mon,
 30 Mar 2026 15:44:56 -0400
X-MC-Unique: M9NxxZ-3Pe-FOITpG_NAyQ-1
X-Mimecast-MFC-AGG-ID: M9NxxZ-3Pe-FOITpG_NAyQ_1774899895
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61733195608B;
	Mon, 30 Mar 2026 19:44:55 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C83361954102;
	Mon, 30 Mar 2026 19:44:52 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 06/36] tests/functional: Fix test_logging_destinations.sh path and backend
Date: Mon, 30 Mar 2026 16:43:29 -0300
Message-ID: <20260330194410.103953-7-wander@redhat.com>
In-Reply-To: <20260330194410.103953-1-wander@redhat.com>
References: <20260330194410.103953-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Tests 1 and 4 invoke stalld directly to capture its stdout for
verification. They used a relative path (../stalld) that breaks
when run_tests.sh invokes the test from a different working
directory, and used pgrep to find the PID instead of capturing $!
from the background launch. They also lacked backend passthrough
for matrix testing.

Fix the stalld path to use ${TEST_ROOT}, capture the PID via $!,
add BACKEND_FLAG construction and passthrough for the direct
invocations, and remove a redundant rm -f already handled by
CLEANUP_FILES. Tests 2 and 3 use start_stalld and need no changes.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_logging_destinations.sh | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index 1d41464..6fa4907 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -28,12 +28,15 @@ LOG_FILE="/tmp/stalld_test_verbose_$$.log"
 CLEANUP_FILES+=("${LOG_FILE}")
 
 # Start stalld directly (not using start_stalld helper) to capture output
-../stalld -f -v -l -t 5 > "${LOG_FILE}" 2>&1 &
-sleep 2
-STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
-if [ -n "${STALLD_PID}" ]; then
-	CLEANUP_PIDS+=("${STALLD_PID}")
+# Add backend flag if specified via test runner
+BACKEND_FLAG=""
+if [ -n "${STALLD_TEST_BACKEND}" ]; then
+	BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
 fi
+"${TEST_ROOT}/../stalld" -f -v ${BACKEND_FLAG} -l -t 5 > "${LOG_FILE}" 2>&1 &
+STALLD_PID=$!
+CLEANUP_PIDS+=("${STALLD_PID}")
+sleep 2
 
 if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 	# Check that output was written to our log file
@@ -51,7 +54,6 @@ if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 fi
 
 stop_stalld
-rm -f "${LOG_FILE}"
 
 # Test 2: Kernel message log (-k)
 echo ""
@@ -153,12 +155,10 @@ LOG_FILE="/tmp/stalld_test_combined_$$.log"
 CLEANUP_FILES+=("${LOG_FILE}")
 
 # Start stalld directly (not using start_stalld helper) to capture output
-../stalld -f -v -k -s -l -t 5 > "${LOG_FILE}" 2>&1 &
+"${TEST_ROOT}/../stalld" -f -v -k -s ${BACKEND_FLAG} -l -t 5 > "${LOG_FILE}" 2>&1 &
+STALLD_PID=$!
+CLEANUP_PIDS+=("${STALLD_PID}")
 sleep 2
-STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
-if [ -n "${STALLD_PID}" ]; then
-	CLEANUP_PIDS+=("${STALLD_PID}")
-fi
 
 if assert_process_running "${STALLD_PID}" "stalld with combined logging should be running"; then
 	# Verify verbose output
-- 
2.53.0

