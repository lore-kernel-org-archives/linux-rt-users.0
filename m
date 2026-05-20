Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581F3E7155
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285742; cv=none; b=CKmuZ4mkUImyP58yeYWMnnQDxV2eogQTHMx8XQeO+879nQrUpUoCeUIHtpC0OKHP1A2tDGxvyLHidvnRUzjagThP9YzAetTWa1LegiFAzEU8p0H0FZME6oSV2qDCFDKWEpLLbBSd2F5pKgbeg7F62vxQrNLPJMxcp/yIFAMN0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285742; c=relaxed/simple;
	bh=bg2rbZIzOTQHneyOq8GQvP6gbtXooF0dTGJOGHeD5i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7Ax1Di5pWKFZDBjaSGAwlOpj50vfOPq16Fbire9DbsQn8Y6EYzjtscRY455P3Fpf45kNDuSR2pcVPdcdceSLj0rp9SS8M0QKqd0K/dFxL5+j3TdYkiajvL2Z19plFcNmGu6gaRBZO9TJDc1vx/kiPmgnqSUtjiz9eLbBJoHOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hj9rX/I9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj9rX/I9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Djw8TQ4pEbwabHnmevo8QvJ+/aZenVMnSw/cZAuLxGg=;
	b=hj9rX/I9/QtrKPbsUJ7lJhQphZLQTV8HvDZdVC4/3yAif6CJs3WG99JReTh/Gg1bcr77H5
	tKRk/OtWDhuxA8HHZFY45ROAXvVZ7wL6JDB04bj6TZYCSQPzYNNgzXal2PjwqFRzXrgien
	wALI7A4KzgTDOMVr72qlmmDliTQzJzY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-KppIfitzPAqb4rvUS0ezKw-1; Wed,
 20 May 2026 10:02:14 -0400
X-MC-Unique: KppIfitzPAqb4rvUS0ezKw-1
X-Mimecast-MFC-AGG-ID: KppIfitzPAqb4rvUS0ezKw_1779285734
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8804195609F;
	Wed, 20 May 2026 14:02:13 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDEFA1800465;
	Wed, 20 May 2026 14:02:11 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 22/33] tests: Abort immediately on test failure
Date: Wed, 20 May 2026 11:00:49 -0300
Message-ID: <20260520140104.112142-23-wander@redhat.com>
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
2.54.0

