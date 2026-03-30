Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8ED39A7F6
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899895; cv=none; b=DmyQhY/mOYD4OvLuP8z4iFuJvDGRsyUk3kh15MhzRGwy3+/z8oGzLjfQvSuMVcG2GU4lPqOM32Qt8K1IZSyH3PDoup7osSTnb1bnol72rA13wZI/6xPrYVd/tn7zQUFZfcKOfhNjFMuOAWG50iLrMCQJVUDa2/PvP5gnOMyYKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899895; c=relaxed/simple;
	bh=P7vPnVmydp7U85kVtBfKCsr+lLOkDhMqcfRmfSQcaPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgWJIiIgJs13QI8k70WAuYDKC3Hd4YF1d1AxUgFuflheiiduzdQSA8mKsMbVFsjOFoNJo/K0apBIwQqx/bXF+iMMb+XAsNiv2DPje16/RByGr1KJsyc4aabbBA7cSDr5drc6ZDQ5iq8kKIQHfxRPTnmvn4v3MCryPySKocEb/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0gjhMPi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0gjhMPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rk2uYXct16xrXD82DI8l5H9xjqVZ88wtTCOkreMf6Qg=;
	b=Z0gjhMPiPP2THNMY20WQNJWrQB6xg4zU5WMOWQNM0Y/ivEhpPSQeBcFvn4LXWMd4iC3Km2
	XhLGacZzUwpAsvnGeaIP1YBjXrXjEXunOXWlswPQ7GfLrnSQg5pih6E5LN/vBhwzKlkO4o
	6R14krxLBK9+adeb14hMKecYNmfzYM4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-MIc2bWt8NGaVwT4cKmF_Qw-1; Mon,
 30 Mar 2026 15:44:51 -0400
X-MC-Unique: MIc2bWt8NGaVwT4cKmF_Qw-1
X-Mimecast-MFC-AGG-ID: MIc2bWt8NGaVwT4cKmF_Qw_1774899889
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E18841800345;
	Mon, 30 Mar 2026 19:44:48 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 375FD1954102;
	Mon, 30 Mar 2026 19:44:44 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 04/36] tests: Add per-test runtime measurement to run_tests.sh
Date: Mon, 30 Mar 2026 16:43:27 -0300
Message-ID: <20260330194410.103953-5-wander@redhat.com>
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

The test runner provides no visibility into how long individual
tests take or the total suite runtime. This makes it difficult to
identify slow tests and to measure the impact of future
optimizations to test determinism.

Add elapsed time tracking to run_unit_test() and run_shell_test()
using bash's built-in SECONDS variable. Each test result now
includes the elapsed time in its output, changing the format from
"PASS" to "PASS (12s)" for all outcomes (PASS, FAIL, SKIP). The
total suite runtime is also displayed in print_summary().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/run_tests.sh | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index 16b6750..bbb3b16 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -464,8 +464,10 @@ run_unit_test() {
 		test_log="${RESULTS_DIR}/${backend_mode//:/_}_${test_name}.log"
 	fi
 
+	local start_time=$SECONDS
 	if "${test_path}" > "${test_log}" 2>&1; then
-		echo -e "${GREEN}PASS${NC}" | tee -a "${LOG_FILE}"
+		local elapsed=$((SECONDS - start_time))
+		echo -e "${GREEN}PASS${NC} (${elapsed}s)" | tee -a "${LOG_FILE}"
 		PASSED_TESTS=$((PASSED_TESTS + 1))
 		if [ -n "${backend}" ]; then
 			BACKEND_PASSED["${backend}"]=$((BACKEND_PASSED["${backend}"] + 1))
@@ -474,7 +476,8 @@ run_unit_test() {
 			MODE_PASSED["${mode}"]=$((MODE_PASSED["${mode}"] + 1))
 		fi
 	else
-		echo -e "${RED}FAIL${NC}" | tee -a "${LOG_FILE}"
+		local elapsed=$((SECONDS - start_time))
+		echo -e "${RED}FAIL${NC} (${elapsed}s)" | tee -a "${LOG_FILE}"
 		echo "  See ${test_log} for details" | tee -a "${LOG_FILE}"
 		FAILED_TESTS=$((FAILED_TESTS + 1))
 		if [ -n "${backend}" ]; then
@@ -601,8 +604,10 @@ run_shell_test() {
 		test_log="${RESULTS_DIR}/${backend_mode//:/_}_${test_name}.log"
 	fi
 
+	local start_time=$SECONDS
 	if bash "${test_path}" > "${test_log}" 2>&1; then
-		echo -e "${GREEN}PASS${NC}" | tee -a "${LOG_FILE}"
+		local elapsed=$((SECONDS - start_time))
+		echo -e "${GREEN}PASS${NC} (${elapsed}s)" | tee -a "${LOG_FILE}"
 		PASSED_TESTS=$((PASSED_TESTS + 1))
 		if [ -n "${backend}" ]; then
 			BACKEND_PASSED["${backend}"]=$((BACKEND_PASSED["${backend}"] + 1))
@@ -612,9 +617,10 @@ run_shell_test() {
 		fi
 	else
 		local exit_code=$?
+		local elapsed=$((SECONDS - start_time))
 		if [ ${exit_code} -eq 77 ]; then
 			# Exit code 77 = SKIP (autotools convention)
-			echo -e "${YELLOW}SKIP${NC}" | tee -a "${LOG_FILE}"
+			echo -e "${YELLOW}SKIP${NC} (${elapsed}s)" | tee -a "${LOG_FILE}"
 			SKIPPED_TESTS=$((SKIPPED_TESTS + 1))
 			if [ -n "${backend}" ]; then
 				BACKEND_SKIPPED["${backend}"]=$((BACKEND_SKIPPED["${backend}"] + 1))
@@ -623,7 +629,7 @@ run_shell_test() {
 				MODE_SKIPPED["${mode}"]=$((MODE_SKIPPED["${mode}"] + 1))
 			fi
 		else
-			echo -e "${RED}FAIL${NC}" | tee -a "${LOG_FILE}"
+			echo -e "${RED}FAIL${NC} (${elapsed}s)" | tee -a "${LOG_FILE}"
 			echo "  See ${test_log} for details" | tee -a "${LOG_FILE}"
 			FAILED_TESTS=$((FAILED_TESTS + 1))
 			if [ -n "${backend}" ]; then
@@ -644,6 +650,7 @@ print_summary() {
 	echo -e "  ${GREEN}Passed:  ${PASSED_TESTS}${NC}" | tee -a "${LOG_FILE}"
 	echo -e "  ${RED}Failed:  ${FAILED_TESTS}${NC}" | tee -a "${LOG_FILE}"
 	echo -e "  ${YELLOW}Skipped: ${SKIPPED_TESTS}${NC}" | tee -a "${LOG_FILE}"
+	echo "  Time:    $((SECONDS - SUITE_START_TIME))s" | tee -a "${LOG_FILE}"
 
 	# Print per-backend statistics if matrix testing enabled
 	if [ ${BACKEND_MATRIX} -eq 1 ] && [ ${#BACKEND_TOTAL[@]} -gt 0 ]; then
@@ -866,6 +873,8 @@ run_specific_test() {
 
 # Main execution
 main() {
+	SUITE_START_TIME=$SECONDS
+
 	# Export BACKEND and THREADING_MODE for use by test scripts
 	export STALLD_TEST_BACKEND="${BACKEND}"
 	export STALLD_TEST_THREADING_MODE="${THREADING_MODE}"
-- 
2.53.0

