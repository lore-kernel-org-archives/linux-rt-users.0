Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE733B47EB
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288633; cv=none; b=dYvuOEetNL2fPk+6pXa2nekVBV/23CqczShyZkHO2h7oC1rLDa3OrdtBphXnhtZCpihsxA0+CO7PLpa5n4CT8legY2hjoUnO8aRPf8RSxXS4D2op3ZRiUgj1USgN6BWjPXjItqQTROxjeJkzEOilk8hIx5QVx4ydXlR9/5kjaq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288633; c=relaxed/simple;
	bh=nLx1mujrTo+A8HgmrjFTM75fju7tuPcJBNBYZnTJMfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrgW0S2GUiNLIwBaKawJkx2OhPakGVdTbHjr64hKTAwUbdNySoTnit871InHkbcd5L6hc93G5gA5st94NGdxMNnk4RjX1elge/t27BcuWFQhv76O/DS3lMDbD4H9xk3ExjXdsG8wRQ0DiLcLxe+BfnE644FL1exPb51IyG8ik3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+H2Y7C4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+H2Y7C4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9WfI9emtIP/YYKevLtQVQWDLsQ/gI6OIPRP0IFNSpg=;
	b=i+H2Y7C4+HfMUB2Cl3merkZmIe3o9C5Dh3Ph+oHUf/YRkXcoycLp6eHSEruXvPc9DLZzYe
	u0YtN+OnRKB5YNokAHVBVLyRSblFIFsLZth8XziH0yPdajLuI2/Z0D37svX8kKFERsD0h8
	F8GyMS9ZZ0PNxGOnhJZ6wlJs0atjQhQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-BNLqyyyYOiqBR2Vfyxke-w-1; Mon,
 27 Apr 2026 07:17:08 -0400
X-MC-Unique: BNLqyyyYOiqBR2Vfyxke-w-1
X-Mimecast-MFC-AGG-ID: BNLqyyyYOiqBR2Vfyxke-w_1777288627
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 019F718002C6;
	Mon, 27 Apr 2026 11:17:07 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 814E7180047F;
	Mon, 27 Apr 2026 11:17:04 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 01/23] stalld: Reject --force_fifo in single-threaded mode
Date: Mon, 27 Apr 2026 08:16:03 -0300
Message-ID: <20260427111632.24500-2-wander@redhat.com>
In-Reply-To: <20260427111632.24500-1-wander@redhat.com>
References: <20260427111632.24500-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
2.53.0

