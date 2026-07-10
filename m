Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F244411668
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690747; cv=none; b=KlSW4uFHlvWQmNzK4zSyu+R5p85FXa4MhdMCn7dicAcD1Lk4HZdE+N/ZBN8sgn2vn6OnXb3uBzJyZK6FjS8Wii0OSnD7u/hOfLV+q5aHu3My8bEgq8jMdFCKAUptTdSOWYIVF65AOUi7jYtQ1UZi7JmjzbTrZrjGYfdWOLFOaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690747; c=relaxed/simple;
	bh=RBvZip0p1v0M0PYHc+P8swKmedbVi84W1S2P23aPxlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO55obvtaG+Rx9np5wpqBnjo9vmOn4bsi7YqjOVqcNgXRH39m2iKwsxrBGsJdiuUyTXzIcYmN83Qk+SCWRqSssnoerXpUaJnLAsPnZpwZDHcBuT66cq2/dp0Z6fuzhmPt31rujB0FYmT321gnLKNZjsut/JZOrl3nreRMn622Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpoirUX1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpoirUX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opP/3eqYqwEpvPstY+hHFyUbzUKFaIpBmxrjdSz1hXg=;
	b=CpoirUX1cBefxEUVk6K0Aa2kLrGaYD3V+JsBtAPhygOOZWEtcqQ0wNQmNF4MlvnkgnvAB/
	AusCguRKl7U9aeh2hC5JGiFOgyVJTSLmEy1nTBeoBT6aNS3Zpiso4JWhNPuf6yaLHeEEc2
	bcv96m0BKmmV8zpz2dXXd6veZftyDdk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-NWSRHj8VNX-ayAteyiYBhQ-1; Fri,
 10 Jul 2026 09:38:59 -0400
X-MC-Unique: NWSRHj8VNX-ayAteyiYBhQ-1
X-Mimecast-MFC-AGG-ID: NWSRHj8VNX-ayAteyiYBhQ_1783690738
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 615F51801BDC;
	Fri, 10 Jul 2026 13:38:58 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 025C6195608F;
	Fri, 10 Jul 2026 13:38:55 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 03/11] tests: add --verbose flag for bash trace output
Date: Fri, 10 Jul 2026 10:38:02 -0300
Message-ID: <20260710133810.72398-4-wander@redhat.com>
In-Reply-To: <20260710133810.72398-1-wander@redhat.com>
References: <20260710133810.72398-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a --verbose option to run_tests.sh that passes -vx to bash
when running test scripts, producing trace output in the per-test
log files for debugging test failures.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/run_tests.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index 1fbb3f2..6bfae0f 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -18,6 +18,7 @@ BACKENDS=("sched_debug" "queue_track")  # Backends to test
 THREADING_MODE_MATRIX=0  # Threading mode matrix testing disabled by default (enable with --full-matrix)
 THREADING_MODES=("power" "adaptive" "aggressive")  # Threading modes to test
 THREADING_MODE=""  # Specific threading mode to use (empty = default)
+VERBOSE=0  # Run tests with bash -vx for trace output
 
 # Source test helpers for RT throttling and DL-server management
 source "${TEST_ROOT}/helpers/test_helpers.sh" 2>/dev/null || true
@@ -480,8 +481,13 @@ run_shell_test() {
 		test_log="${RESULTS_DIR}/${backend_mode//:/_}_${test_name}.log"
 	fi
 
+	local bash_flags=""
+	if [ ${VERBOSE} -eq 1 ]; then
+		bash_flags="-vx"
+	fi
+
 	local start_time=$SECONDS
-	if bash "${test_path}" > "${test_log}" 2>&1; then
+	if bash ${bash_flags} "${test_path}" > "${test_log}" 2>&1; then
 		local elapsed=$((SECONDS - start_time))
 		echo -e "${GREEN}PASS${NC} (${elapsed}s)" | tee -a "${LOG_FILE}"
 		PASSED_TESTS=$((PASSED_TESTS + 1))
@@ -599,6 +605,10 @@ while [[ $# -gt 0 ]]; do
 			SPECIFIC_TEST="$2"
 			shift 2
 			;;
+		--verbose)
+			VERBOSE=1
+			shift
+			;;
 		--disable-dl-server)
 			DISABLE_DL_SERVER=1
 			shift
@@ -662,6 +672,7 @@ while [[ $# -gt 0 ]]; do
 			echo "                                aggressive - Aggressive (-A)"
 			echo ""
 			echo "Other Options:"
+			echo "  --verbose            Run tests with bash -vx for trace output"
 			echo "  --disable-dl-server  Disable DL-server before running tests"
 			echo "  -h, --help           Show this help"
 			echo ""
-- 
2.55.0

