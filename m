Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88D39A806
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899956; cv=none; b=HYWQvdn5N469Y/Aqv37F+9+GWWJjxZOYq73xT0l7ZEHmSlue73trTnh9k/fdaMQd5cooi4py7/wRCnzWEEI47+O7GFv9vCxhe7b7f+T4LX2LoWWYTrCDRj+FGFFW15eal+CcYOtQYrHOdzyQlS/9RgeJPykgq5BOJT1VNueSmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899956; c=relaxed/simple;
	bh=rXRWDvTZTLx/yX8SCdEGjntrdJ5ds3lgK1auy0XrJkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6D12d61pgd/hde99e7UyG+RQk/ck+J5LvHlc1QbSsK2WSJwEXpIULJSLIDYLgAyb2FwAt1Y3nWTJYp9l3cWVtz1ys8tJqplF8Yz7S5O7Sf/OZJqH+hyLZ7cwcj9Wofkn1U8JZiPRz5rGNrhKYHaXZWlCA6j4j/ROT5/hKDAHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxpRjHVC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxpRjHVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy9TSxO9o45+kBOedb7szoBtBwHgs9kyPBohBCUiX/E=;
	b=XxpRjHVCmhcZZNIY4sPbYpP56SD5oNNnswGqxHjYk/RnOcZ3Jeky6F3dYV6UviS/dv2MhV
	WD9rz2TZCm/ce2ZchEHOQlihL5zpM3Zc4B8uj81uaFrK22JeY+PIjMbxLxIOHBoGqTWbxs
	WPmehlsxD0UeMD7DUNOuXURfuVV99yQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228--hkC7CudPFyU-xIOiJ76Ug-1; Mon,
 30 Mar 2026 15:45:53 -0400
X-MC-Unique: -hkC7CudPFyU-xIOiJ76Ug-1
X-Mimecast-MFC-AGG-ID: -hkC7CudPFyU-xIOiJ76Ug_1774899951
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E88D180049D;
	Mon, 30 Mar 2026 19:45:51 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8DA41954102;
	Mon, 30 Mar 2026 19:45:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 23/36] tests/functional: Use start_stalld_with_log() in test_logging_destinations
Date: Mon, 30 Mar 2026 16:43:46 -0300
Message-ID: <20260330194410.103953-24-wander@redhat.com>
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

Replace direct stalld invocations in Tests 1 and 4 with
start_stalld_with_log(), which handles backend selection, PID
tracking, and readiness detection internally. This also removes
the now-unnecessary BACKEND_FLAG variable.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_logging_destinations.sh | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index 171be8b..b44c08d 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -33,16 +33,7 @@ echo "Test 1: Verbose mode (-v) logs to stdout"
 LOG_FILE="/tmp/stalld_test_verbose_$$.log"
 CLEANUP_FILES+=("${LOG_FILE}")
 
-# Start stalld directly (not using start_stalld helper) to capture output
-# Add backend flag if specified via test runner
-BACKEND_FLAG=""
-if [ -n "${STALLD_TEST_BACKEND}" ]; then
-	BACKEND_FLAG="-b ${STALLD_TEST_BACKEND}"
-fi
-"${TEST_ROOT}/../stalld" -f -v ${BACKEND_FLAG} -l -t 5 > "${LOG_FILE}" 2>&1 &
-STALLD_PID=$!
-CLEANUP_PIDS+=("${STALLD_PID}")
-sleep 2
+start_stalld_with_log "${LOG_FILE}" -f -v -l -t 5
 
 if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 	# Check that output was written to our log file
@@ -160,11 +151,7 @@ echo "Test 4: Combined logging modes"
 LOG_FILE="/tmp/stalld_test_combined_$$.log"
 CLEANUP_FILES+=("${LOG_FILE}")
 
-# Start stalld directly (not using start_stalld helper) to capture output
-"${TEST_ROOT}/../stalld" -f -v -k -s ${BACKEND_FLAG} -l -t 5 > "${LOG_FILE}" 2>&1 &
-STALLD_PID=$!
-CLEANUP_PIDS+=("${STALLD_PID}")
-sleep 2
+start_stalld_with_log "${LOG_FILE}" -f -v -k -s -l -t 5
 
 if assert_process_running "${STALLD_PID}" "stalld with combined logging should be running"; then
 	# Verify verbose output
-- 
2.53.0

