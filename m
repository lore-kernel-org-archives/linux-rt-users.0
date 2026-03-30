Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251F397686
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899991; cv=none; b=jzUMVPjMM6hCCTFdwLjSJBlDhpKuRr8zVDmy0ginYhNwCn722sClbJx7tYJuC47B1vqS1/DwoauhiOaB1xf0pW1Sqzz/lAHjrQ2Wph3GwF+LaGG5S602GuA32jocd0UDtIJe1VHuX31uNjlGt2RBA2ERmNkcTBRs1J6Y/SDW0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899991; c=relaxed/simple;
	bh=pvITQQyh1RVmL7AQqloQl6/FbcU9mn5no2XffE5G7y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLxmdO+WwzBpBHhPEu2h8hpcEl4YpEAqdTcnGWKQPtFz4KklxVRKCIsHWtRFMpgY6T3g+mPOmVjW/tJzWbtncs2t2en5K2zrx9zkgueh34K4W3ekLUibrjPutHSqInCbs2igCMCmFJWoNjbxcCo6GffC+T67uQ4shEHBfu6xIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbO4bqTu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbO4bqTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWIL18qL1BDw4wq7mLikTS8y1zs1LnWnSYm2J51Jhuo=;
	b=YbO4bqTuFjFuP2fOl/eXxo8MOOPMPfrPraebM3D4af4oWtCtbvmZOSPTnGiLrTkZ1HalnP
	8MDWfdxKiufbRejyajnYIYw1FacA+8cs0jqUcKYbciPfhFedDRTOcW00za+/33rUqvXQXY
	K23uXkIPTp7jOeacxU64t1Sd6bw3DD4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-RcECE6WhOhi23b_q_ydFZg-1; Mon,
 30 Mar 2026 15:46:26 -0400
X-MC-Unique: RcECE6WhOhi23b_q_ydFZg-1
X-Mimecast-MFC-AGG-ID: RcECE6WhOhi23b_q_ydFZg_1774899984
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B430018002EF;
	Mon, 30 Mar 2026 19:46:24 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 292101954102;
	Mon, 30 Mar 2026 19:46:21 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 33/36] tests/functional: Accept FIFO fallback in test_fifo_boosting
Date: Mon, 30 Mar 2026 16:43:56 -0300
Message-ID: <20260330194410.103953-34-wander@redhat.com>
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

Test 5 expects stalld to exit when given -F without -A, but stalld
prints a warning and falls back to adaptive mode instead. The test
had contradictory results: a FAIL for not exiting and a PASS for
finding the warning message. Accept the fallback as valid behavior
and only fail if stalld silently ignores the incompatibility.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_fifo_boosting.sh | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 50c8d14..a003deb 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -332,20 +332,11 @@ timeout 5 ${TEST_ROOT}/../stalld -f -v -F -t 5 -c ${TEST_CPU} > "${STALLD_LOG_FA
 ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "stalld exited as expected"
+    pass "stalld rejected FIFO in single-threaded mode"
+elif grep -qiE "single.*thread|falling back|adaptive" "${STALLD_LOG_FAIL}"; then
+    pass "stalld detected incompatibility and fell back to adaptive mode"
 else
-    fail "stalld did not reject FIFO in single-threaded mode"
-fi
-
-# Check for error message in log
-if grep -qiE "single.*thread.*fifo|fifo.*single.*thread|can.*only.*deadline" "${STALLD_LOG_FAIL}"; then
-    pass "Error message about FIFO+single-threaded incompatibility found"
-else
-    log "ℹ INFO: Checking exit status or error messages..."
-    if [ -s "${STALLD_LOG_FAIL}" ]; then
-        log "Log contents:"
-        cat "${STALLD_LOG_FAIL}"
-    fi
+    fail "stalld silently accepted FIFO in single-threaded mode"
 fi
 
 #=============================================================================
-- 
2.53.0

