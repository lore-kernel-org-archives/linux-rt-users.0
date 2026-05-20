Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A953E63A6
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285692; cv=none; b=g9IO82oUYpOBVuZbryn+Ea5W1CC1sdhAXHAUNRzhgiZV55Ekbd7qzPdJH5VjVXYJNN4H+8d/K5oYWPvyondLF9Rizcp3L2OIHDBGHAssTWg3AdzDd0VrW8CEOWCbj0r5NQCFWEeFm0IHr6xkaop+mrVOCM1TGB3J4oBUGUwScmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285692; c=relaxed/simple;
	bh=+ZT969U4XX80CHXMQaRw9WBJZC7nadLxiCTPzR/cAIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7q5Dlme1Vcp4sdOsXe5IxqTRsxloPZi8BAz767ux5VgC4HNgV5UQQcc8b4YdqGyPllcrnU20eX3gbUkMkgLZCrEvW53WH90yjM+MXCQMRBs/hEmwjWh3JoMp/49YnwHGHBZvdJr34ARpw7roOTO/x3fXOmLtlLUu1Zm699c7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d93J+fLV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d93J+fLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUgfApUBnK3QWgTOO0hXOVglCH8nrU02BfUL5Apca/s=;
	b=d93J+fLVAOz5/1et5FjERwJDZQJGu3UNBV9S0e2RBb/9iq0bQWdDNaIEH5xaFfNIrR0CYT
	vN+63ThBoZix//amyligMWAQR39EK86C8+4/OUGVljQIjVCRBZKPrDtsabvqSP4jntjKjx
	q7w+0kSAEiu4B72/Bis49087IIpv3TQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-5kNs7JTrN-2lw7Tdw8bA5w-1; Wed,
 20 May 2026 10:01:22 -0400
X-MC-Unique: 5kNs7JTrN-2lw7Tdw8bA5w-1
X-Mimecast-MFC-AGG-ID: 5kNs7JTrN-2lw7Tdw8bA5w_1779285677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4455118005A8;
	Wed, 20 May 2026 14:01:17 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC86B1800352;
	Wed, 20 May 2026 14:01:14 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 01/33] stalld: Reject --force_fifo in single-threaded mode
Date: Wed, 20 May 2026 11:00:28 -0300
Message-ID: <20260520140104.112142-2-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When --force_fifo (-F) was combined with single-threaded mode (-O),
stalld silently fell back to adaptive mode instead of honoring the
requested configuration. This violates the principle of least
surprise since the user explicitly requested single-threaded mode
but gets a different threading model without warning.

Replace the silent fallback with a usage() error that exits
immediately, consistent with the other argument validation checks
in parse_args(). Also fix the corresponding test which was missing
the -O flag and therefore tested adaptive mode instead of
single-threaded mode.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 src/utils.c                         |  9 ++-------
 tests/functional/test_force_fifo.sh | 18 ++----------------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/src/utils.c b/src/utils.c
index 8f1fe92..3dddb0f 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -1182,13 +1182,8 @@ int parse_args(int argc, char **argv)
 	if (config_boost_duration > config_starving_threshold)
 		usage("the boost duration cannot be longer than the starving threshold ");
 
-	if (config_force_fifo && config_single_threaded) {
-		log_msg("-F/--force_fifo does not work in single-threaded mode\n");
-		log_msg("falling back to the adaptive mode\n");
-		config_adaptive_multi_threaded = 1;
-		config_single_threaded = 0;
-		config_aggressive = 0;
-	}
+	if (config_force_fifo && config_single_threaded)
+		usage("--force_fifo does not work in single-threaded mode");
 
 	if (config_reservation && (config_aggressive || config_adaptive_multi_threaded))
 		usage("-R/--reservation only works in the single-threaded mode");
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 239bc37..4fdb13b 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -207,22 +207,8 @@ log "=========================================="
 log "Test 5: Single-threaded mode with FIFO (should fail)"
 log "=========================================="
 
-# Try to run stalld with -F but without -A (single-threaded mode)
-# According to CLAUDE.md, this should die/exit
-FIFO_SINGLE_LOG="/tmp/stalld_test_force_fifo_single_$$.log"
-CLEANUP_FILES+=("${FIFO_SINGLE_LOG}")
-
-log "Testing single-threaded mode with -F (should exit)"
-timeout 5 ${TEST_ROOT}/../stalld -f -v -c "${TEST_CPU}" -t ${threshold} -F > "${FIFO_SINGLE_LOG}" 2>&1
-ret=$?
-
-if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
-    pass "single-threaded mode rejected FIFO"
-elif grep -qiE "single.*thread|falling back|adaptive" "${FIFO_SINGLE_LOG}"; then
-    pass "stalld detected incompatibility and fell back to adaptive mode"
-else
-    fail "stalld silently accepted FIFO in single-threaded mode"
-fi
+log "Testing single-threaded mode (-O) with -F (should exit)"
+assert_stalld_rejects "Single-threaded mode rejected FIFO" -f -v -c "${TEST_CPU}" -t ${threshold} -F -O
 
 #=============================================================================
 # Test 6: Compare effectiveness (informational)
-- 
2.54.0

