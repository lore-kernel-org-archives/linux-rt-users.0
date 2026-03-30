Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB3397E8C
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899984; cv=none; b=Sv2OATIOaqE4GHZU4yTpknP8Qicd5IqVLTqLIgr0X/JyC71OYYz1e1RpBnZ2bQtvUTZn2QIb3lvHOg1JBv4VI2g0NzJFD9/gH7WJIBtXWI6UDHC768tl9J4BV9sq7Qey1DeaPczzRKaivdiuluNCJG7pIsPDMO4kbu0Ba7msckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899984; c=relaxed/simple;
	bh=bggXKXjDXjHOpxWlOf0N2+zaGOAMy3EUQ/EeGcbevSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC//LcbT3sEMMhh68iDcZL6fTRLM2yj6BjLrYzNZopbG9N6DPjsUksTZjSTMZTIee4t8uecax5Ir8HCJr1psgP5f2eXsmHZTXDB7Bp5yINWRfDng4ac/MrwQyNwMyGprwup3QyuQn9TB2D9xpOP5/sM6D9o/XTscgL8DnOOceos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhwEh1vt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhwEh1vt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=386yHllALBeu6ydMcZsj2eOrWdgAjIaTDfR7rJeuJD0=;
	b=EhwEh1vtlOgiWtthUVkX8vJTglfKvscMGPcH/CYlpVuS28bXrbG+bzQay9MiDIP+OCqtZf
	1Ii+sa9SXVd24m8MBPPGVLNTvd3Y1P6VHT8iM+S+PwbPmNt2ZSlc+cwPX8rjQnv+78uiTV
	/LS3mKMyt5dSyrnHbbs8ZvNMgQmK7rw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Vy60KkClP6GNTX7M63pihg-1; Mon,
 30 Mar 2026 15:46:19 -0400
X-MC-Unique: Vy60KkClP6GNTX7M63pihg-1
X-Mimecast-MFC-AGG-ID: Vy60KkClP6GNTX7M63pihg_1774899978
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C5AC19560A1;
	Mon, 30 Mar 2026 19:46:18 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E533119540C4;
	Mon, 30 Mar 2026 19:46:15 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 31/36] tests/helpers: Use pass()/fail() in assert functions
Date: Mon, 30 Mar 2026 16:43:54 -0300
Message-ID: <20260330194410.103953-32-wander@redhat.com>
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

Refactor all assert functions to delegate to pass() and fail()
instead of duplicating the echo formatting and counter increment
logic. Diagnostic context lines in assert_equals, assert_contains,
and assert_not_contains are changed from echo to log() so they
appear in the journal.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 50 +++++++++++++----------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 20f8a3c..3a7164d 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -130,14 +130,12 @@ assert_equals() {
 	local message=${3:-""}
 
 	if [ "${expected}" == "${actual}" ]; then
-		echo -e "  ${GREEN}PASS${NC}: ${message}"
-		TEST_PASSED=$((TEST_PASSED + 1))
+		pass "${message}"
 		return 0
 	else
-		echo -e "  ${RED}FAIL${NC}: ${message}"
-		echo "    Expected: ${expected}"
-		echo "    Actual:   ${actual}"
-		TEST_FAILED=$((TEST_FAILED + 1))
+		fail "${message}"
+		log "    Expected: ${expected}"
+		log "    Actual:   ${actual}"
 		return 1
 	fi
 }
@@ -148,13 +146,11 @@ assert_contains() {
 	local message=${3:-""}
 
 	if echo "${haystack}" | grep -q "${needle}"; then
-		echo -e "  ${GREEN}PASS${NC}: ${message}"
-		TEST_PASSED=$((TEST_PASSED + 1))
+		pass "${message}"
 		return 0
 	else
-		echo -e "  ${RED}FAIL${NC}: ${message}"
-		echo "    String '${needle}' not found"
-		TEST_FAILED=$((TEST_FAILED + 1))
+		fail "${message}"
+		log "    String '${needle}' not found"
 		return 1
 	fi
 }
@@ -165,13 +161,11 @@ assert_not_contains() {
 	local message=${3:-""}
 
 	if ! echo "${haystack}" | grep -q "${needle}"; then
-		echo -e "  ${GREEN}PASS${NC}: ${message}"
-		TEST_PASSED=$((TEST_PASSED + 1))
+		pass "${message}"
 		return 0
 	else
-		echo -e "  ${RED}FAIL${NC}: ${message}"
-		echo "    String '${needle}' found but should not be present"
-		TEST_FAILED=$((TEST_FAILED + 1))
+		fail "${message}"
+		log "    String '${needle}' found but should not be present"
 		return 1
 	fi
 }
@@ -181,12 +175,10 @@ assert_file_exists() {
 	local message=${2:-"File should exist: ${file}"}
 
 	if [ -f "${file}" ]; then
-		echo -e "  ${GREEN}PASS${NC}: ${message}"
-		TEST_PASSED=$((TEST_PASSED + 1))
+		pass "${message}"
 		return 0
 	else
-		echo -e "  ${RED}FAIL${NC}: ${message}"
-		TEST_FAILED=$((TEST_FAILED + 1))
+		fail "${message}"
 		return 1
 	fi
 }
@@ -196,12 +188,10 @@ assert_file_not_exists() {
 	local message=${2:-"File should not exist: ${file}"}
 
 	if [ ! -f "${file}" ]; then
-		echo -e "  ${GREEN}PASS${NC}: ${message}"
-		TEST_PASSED=$((TEST_PASSED + 1))
+		pass "${message}"
 		return 0
 	else
-		echo -e "  ${RED}FAIL${NC}: ${message}"
-		TEST_FAILED=$((TEST_FAILED + 1))
+		fail "${message}"
 		return 1
 	fi
 }
@@ -211,12 +201,10 @@ assert_process_running() {
 	local message=${2:-"Process ${pid} should be running"}
 
 	if kill -0 ${pid} 2>/dev/null; then
-		echo -e "  ${GREEN}PASS${NC}: ${message}"
-		TEST_PASSED=$((TEST_PASSED + 1))
+		pass "${message}"
 		return 0
 	else
-		echo -e "  ${RED}FAIL${NC}: ${message}"
-		TEST_FAILED=$((TEST_FAILED + 1))
+		fail "${message}"
 		return 1
 	fi
 }
@@ -226,12 +214,10 @@ assert_process_not_running() {
 	local message=${2:-"Process ${pid} should not be running"}
 
 	if ! kill -0 ${pid} 2>/dev/null; then
-		echo -e "  ${GREEN}PASS${NC}: ${message}"
-		TEST_PASSED=$((TEST_PASSED + 1))
+		pass "${message}"
 		return 0
 	else
-		echo -e "  ${RED}FAIL${NC}: ${message}"
-		TEST_FAILED=$((TEST_FAILED + 1))
+		fail "${message}"
 		return 1
 	fi
 }
-- 
2.53.0

