Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB03B7771
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288692; cv=none; b=TipdxavKQwF2GQeYKvXDS8u/whlLfsohja3lKzq+ob/eeu6sQcyqNHTyN6MS3NoM76qT7LJxMZc7SkbwnFDsv6wX8Mh+RaJyroA2ibP3jWNIYnCm8Ta7E9Vry9NG7ONAOosksaA3xlFvO8loSjXYGyxPdDBD1iyVozOHeuTrrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288692; c=relaxed/simple;
	bh=qkYPx6SXINeb7DTtdCTqWD0vWxkxMSzJ5D1PKBim8Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDKDVE9sd832wpFcSP5jY+tdf6Rde7NzQKDbVWR1exO3TkBK6b9LEBwh6AnXZy3Hk4FiArMruYRwSzkeICJIYvOb3Ojq1r1newuX2AUsovRCMM91AaPqvS34VK/Sn2rcEsbVYdZ4nWKOkdI0Nqfy2YFW2MygXNrgfvkwSdubRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YW6dDarM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW6dDarM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU2fCmalNnbZfDKlWVVxU8eUUbulecEM+v4gvqD1R8M=;
	b=YW6dDarMpUUk9kqJkKqFDy0fksbFEl/GVbmWMc+mV0NTHM7BzNmk1SZvEVn+tEodJ8eLwk
	6Gp89FUTE9T+/tgdrfTcgzTyQAXcf47fwvVtbauvet88d8bGrmZTuSIPkbgbqjoTR38PKW
	Fx0/J9Xi7krffnus+XJpnvu5xDD7dLA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-se5gZ6i0M66Rmx-qS5kVYQ-1; Mon,
 27 Apr 2026 07:18:08 -0400
X-MC-Unique: se5gZ6i0M66Rmx-qS5kVYQ-1
X-Mimecast-MFC-AGG-ID: se5gZ6i0M66Rmx-qS5kVYQ_1777288687
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DE931800651;
	Mon, 27 Apr 2026 11:18:07 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D58E180047F;
	Mon, 27 Apr 2026 11:18:05 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 22/23] tests: Abort immediately on test failure
Date: Mon, 27 Apr 2026 08:16:24 -0300
Message-ID: <20260427111632.24500-23-wander@redhat.com>
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

This is the third commit in a series introducing fail-fast semantics
to the test suite. By modifying the fail helper to invoke end_test
and exit immediately, tests will now abort on the first failure. This
provides faster feedback and produces much shorter, more focused error
logs rather than cascading failures.

To support exiting directly from the fail helper, diagnostic logging
in seven assert functions is relocated to occur before the failure
is triggered. Dead return statements are removed from all twelve
assert functions since fail never returns and the return after pass
is unnecessary. Additionally, the stalld rejection assertion now
registers its temporary file in the cleanup tracking array to ensure
trap-based exit handlers correctly reap the resource even when the
test aborts prematurely.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/helpers/test_helpers.sh | 41 ++++++++++-------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 49292aa..c51361f 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -164,12 +164,10 @@ assert_starvation_detected() {
 
 	if wait_for_starvation_detected "${log_file}" "${timeout}" "${cpu}"; then
 		pass "${message}"
-		return 0
 	else
-		fail "${message}"
 		log "Log contents:"
 		cat "${log_file}"
-		return 1
+		fail "${message}"
 	fi
 }
 
@@ -182,12 +180,10 @@ assert_boost_detected() {
 
 	if wait_for_boost_detected "${log_file}" "${timeout}"; then
 		pass "${message}"
-		return 0
 	else
-		fail "${message}"
 		log "Log contents:"
 		cat "${log_file}"
-		return 1
+		fail "${message}"
 	fi
 }
 
@@ -217,15 +213,13 @@ assert_log_contains() {
 
 	if [ $found -eq 1 ]; then
 		pass "${message}"
-		return 0
 	else
-		fail "${message}"
 		if [ $negate -eq 1 ]; then
 			log "    Pattern '${pattern}' found in ${log_file} but should not be"
 		else
 			log "    Pattern '${pattern}' not found in ${log_file}"
 		fi
-		return 1
+		fail "${message}"
 	fi
 }
 
@@ -236,14 +230,15 @@ assert_stalld_rejects() {
 	shift
 
 	local log="/tmp/stalld_reject_$$.log"
+	CLEANUP_FILES+=("${log}")
 	timeout 5 ${TEST_ROOT}/../stalld ${BACKEND_FLAG} "$@" > "${log}" 2>&1
 	local ret=$?
 	if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
 		pass "${message}"
 	else
-		fail "${message}"
 		log "stalld output:"
 		cat "${log}"
+		fail "${message}"
 	fi
 	rm -f "${log}"
 }
@@ -273,10 +268,8 @@ assert_success() {
 
 	if [ $success -eq 1 ]; then
 		pass "${message}"
-		return 0
 	else
 		fail "${message}"
-		return 1
 	fi
 }
 
@@ -289,13 +282,15 @@ pass() {
 	TEST_PASSED=$((TEST_PASSED + 1))
 }
 
-# Record a test failure with a description message.
+# Record a test failure and abort the test immediately.
 #
 # Usage: fail "description"
 fail() {
 	local message=${1:-""}
 	log "✗ FAIL: ${message}"
 	TEST_FAILED=$((TEST_FAILED + 1))
+	end_test
+	exit 1
 }
 
 # Assert functions
@@ -306,12 +301,10 @@ assert_equals() {
 
 	if [ "${expected}" == "${actual}" ]; then
 		pass "${message}"
-		return 0
 	else
-		fail "${message}"
 		log "    Expected: ${expected}"
 		log "    Actual:   ${actual}"
-		return 1
+		fail "${message}"
 	fi
 }
 
@@ -322,11 +315,9 @@ assert_contains() {
 
 	if echo "${haystack}" | grep -q "${needle}"; then
 		pass "${message}"
-		return 0
 	else
-		fail "${message}"
 		log "    String '${needle}' not found"
-		return 1
+		fail "${message}"
 	fi
 }
 
@@ -337,11 +328,9 @@ assert_not_contains() {
 
 	if ! echo "${haystack}" | grep -q "${needle}"; then
 		pass "${message}"
-		return 0
 	else
-		fail "${message}"
 		log "    String '${needle}' found but should not be present"
-		return 1
+		fail "${message}"
 	fi
 }
 
@@ -351,10 +340,8 @@ assert_file_exists() {
 
 	if [ -f "${file}" ]; then
 		pass "${message}"
-		return 0
 	else
 		fail "${message}"
-		return 1
 	fi
 }
 
@@ -364,10 +351,8 @@ assert_file_not_exists() {
 
 	if [ ! -f "${file}" ]; then
 		pass "${message}"
-		return 0
 	else
 		fail "${message}"
-		return 1
 	fi
 }
 
@@ -377,10 +362,8 @@ assert_process_running() {
 
 	if kill -0 ${pid} 2>/dev/null; then
 		pass "${message}"
-		return 0
 	else
 		fail "${message}"
-		return 1
 	fi
 }
 
@@ -390,10 +373,8 @@ assert_process_not_running() {
 
 	if ! kill -0 ${pid} 2>/dev/null; then
 		pass "${message}"
-		return 0
 	else
 		fail "${message}"
-		return 1
 	fi
 }
 
-- 
2.53.0

