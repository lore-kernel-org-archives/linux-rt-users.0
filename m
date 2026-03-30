Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA019394492
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899967; cv=none; b=Uf6wcwpr0nJXtP+hxEjp6/YM5j/tQgKZ6J1bwPA1lwcv8ZvlsF/44CKQ5sq+JMVVNXPHah/cWsneAzhzn9271mLnkQE0+8Nv2GxGAd3q81q691+h15EjUpDXyvlPNS+kn92Alk7FNt8mVNFgPaS3IHBVsUomfFFFOwi4g9q+kmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899967; c=relaxed/simple;
	bh=yt1KdXvxcw0/IMDc6XHq5AXOBjGGrwtclkGJKWYO9Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZC1VKPNEGqc8YT43nCIbl47yP8rV4diPZinlBBVpc98p9IyVhRIbiA0LvNY0763VcyVIL5wGsL5loJ8+9EK/INSBxR3q3mP2rIFJlXEtpH2rq1gUxoMlVASHLKXSAdl+uVit1XBCM3b55KKgb49On8MSvKy0YBtoUyG5XHQgVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlRP5+fO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlRP5+fO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbTW3oD9AwrZ04uAIbXKOOBAaH7BpzeLM+Dz7FYPpzo=;
	b=SlRP5+fO77A5b3u6th/uS/7HKx+ds+RU6Z9RY1wsIeU0veFaiWn7P03Bo1h0YrTtyQiRj6
	srL9Q5woz6pqtxtFMOs1rR9FZD4WYzcenpdfyXsDaOlWkDyXhqtqv40H/q4hwp+FO8L+yV
	SJ5P9nXiww88ZJsd9UDnB7F+t/tZrBc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-PeCiBTKKPS-mZrKEC5piPQ-1; Mon,
 30 Mar 2026 15:46:02 -0400
X-MC-Unique: PeCiBTKKPS-mZrKEC5piPQ-1
X-Mimecast-MFC-AGG-ID: PeCiBTKKPS-mZrKEC5piPQ_1774899961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F74218005B9;
	Mon, 30 Mar 2026 19:46:01 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A74F41954102;
	Mon, 30 Mar 2026 19:45:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 26/36] tests/functional: Use timeout for error path in test_force_fifo
Date: Mon, 30 Mar 2026 16:43:49 -0300
Message-ID: <20260330194410.103953-27-wander@redhat.com>
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

The single-threaded FIFO rejection test backgrounds stalld and
sleeps 3 seconds to check if it exited. Run it synchronously
under timeout instead, and treat unexpected success or timeout as
test failures rather than warnings.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_force_fifo.sh | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 17bc66e..2c21ddd 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -214,22 +214,14 @@ FIFO_SINGLE_LOG="/tmp/stalld_test_force_fifo_single_$$.log"
 CLEANUP_FILES+=("${FIFO_SINGLE_LOG}")
 
 log "Testing single-threaded mode with -F (should exit)"
-${TEST_ROOT}/../stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F > "${FIFO_SINGLE_LOG}" 2>&1 &
-fifo_pid=$!
-sleep 3
-
-if ! kill -0 "${fifo_pid}" 2>/dev/null; then
-    # Process exited - this is expected
-    if grep -qi "error\|single.*thread\|not.*support" "${FIFO_SINGLE_LOG}"; then
-        log "✓ PASS: Single-threaded mode rejected FIFO with error message"
-    else
-        log "✓ PASS: Single-threaded mode with FIFO caused exit (as expected)"
-    fi
+timeout 5 ${TEST_ROOT}/../stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F > "${FIFO_SINGLE_LOG}" 2>&1
+ret=$?
+
+if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
+    assert_equals "1" "1" "single-threaded mode rejected FIFO"
 else
-    # Process still running - unexpected
-    log "⚠ WARNING: Single-threaded mode accepted FIFO (may have switched to multi-threaded)"
-    kill -TERM "${fifo_pid}" 2>/dev/null
-    wait "${fifo_pid}" 2>/dev/null || true
+    log "✗ FAIL: stalld did not reject -F in single-threaded mode"
+    TEST_FAILED=$((TEST_FAILED + 1))
 fi
 
 #=============================================================================
-- 
2.53.0

