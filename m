Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE63E0096
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943544; cv=none; b=Jt2TjAD94YObH5CFw4FFepdkvFAvOmEpPg5RATgoh+amnHaleWVevdwBslszlpf9x1vVhohurBYgDyitzb06YukJ9ocgG7Zqfvxuj95iB9BzXngVrWIplAftCzcS51W/xhvr5GyPxGDpYM3TmDefCGksuAUWmwEiJuMclehSanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943544; c=relaxed/simple;
	bh=+ZT969U4XX80CHXMQaRw9WBJZC7nadLxiCTPzR/cAIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOrGJ339GQq4kzJbZtWa1j2z8jZVHnmrWoG/akskceRoB2MaC7y9YalDhJIE8PpBv7wvzSFVlD0StNxtfWUw/e4sZu9lDG6tzd+4z4fOAhZ6OaXsGBXoMh44h0kmc/C2b6FdRpcS0XlUkVwW1wXzCc7lDV5HX2Lm4Hk8V32n2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acos9t4u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acos9t4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUgfApUBnK3QWgTOO0hXOVglCH8nrU02BfUL5Apca/s=;
	b=acos9t4uBrutQU4/gxUf+0ST4CjzzvDk5+lUqHK7dEQHCiSDbLY/+yauwvPIY1vJKzgCGu
	d4wEF/GvffVsb9R1dPLZ3MbBSFtwQ1RX1kXHd4jwjp81ck4+ogs1w872LN8u8HPaiNHWKm
	ZFGA1gGwDM/SOWt55Hjvd7QsXe1Gqj4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-Ntc67BZROCutx_mi87J2zg-1; Mon,
 08 Jun 2026 14:32:18 -0400
X-MC-Unique: Ntc67BZROCutx_mi87J2zg-1
X-Mimecast-MFC-AGG-ID: Ntc67BZROCutx_mi87J2zg_1780943537
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10A4D195DE61;
	Mon,  8 Jun 2026 18:32:17 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F1B0D36928;
	Mon,  8 Jun 2026 18:32:14 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 01/52] stalld: Reject --force_fifo in single-threaded mode
Date: Mon,  8 Jun 2026 15:31:11 -0300
Message-ID: <20260608183206.140526-2-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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

