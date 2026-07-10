Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0E39447C
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690765; cv=none; b=e38SqRSdu+uP8x73AtNEsT8QPy3sPPFqZ3g23vc17246NzaljsCc/foamSzUsQmkWTc901V1pxTC22DuEQ0DTKNjwk+VWsPUuBgL7dvZaBqdNECOERHbngwzK3pt7EXTROkkh7DRRBYwAjE3XYy9kYcExcglr41hszyRhWaC4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690765; c=relaxed/simple;
	bh=lAf7t5lAxHcA7OTVTaOiyhLdMN6eOD2gzAb/vnEdGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1wLlBytCzGUWUjTk3PVTAW00kbxoIY8pgfGWrfW669RBepJLKDFWnYWNOWqfoZnKnRhvDAikmp/u/B7Aji7BvbnR1I75neMRnFwq4cMMZ3VvZ4MYEDv3dgqA2Pll+27RJ5pZAumCLZT4MKT11CLoKuDwDs/V/oXufAP2KpsSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjGIlIHZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjGIlIHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/AS+XEpO/2XHUBizOsG+vJMnCWO9XODKgIZWIcZZrY=;
	b=BjGIlIHZPBbQ2VkgbwfiBh1yYaZRmP4AgDDQQ9Hx41JBiSx15yzhMzVPtV/P+iV3KMkFFT
	DNBP8KaNc8vP/PXokWx/0zDKyv60dlbtERcY6/sIHDvqaHUlgp9c1bXjGHTqVz8oB9eioi
	ptycZik+wIoQjRy66mR+95sLExBvdjY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-nX9i_GcMNji9vkIVPc4mew-1; Fri,
 10 Jul 2026 09:39:20 -0400
X-MC-Unique: nX9i_GcMNji9vkIVPc4mew-1
X-Mimecast-MFC-AGG-ID: nX9i_GcMNji9vkIVPc4mew_1783690759
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EF4E1801379;
	Fri, 10 Jul 2026 13:39:19 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B021195608F;
	Fri, 10 Jul 2026 13:39:16 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 11/11] tests: increase stalld initialization timeout to 240s
Date: Fri, 10 Jul 2026 10:38:10 -0300
Message-ID: <20260710133810.72398-12-wander@redhat.com>
In-Reply-To: <20260710133810.72398-1-wander@redhat.com>
References: <20260710133810.72398-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On PREEMPT_RT systems with large CPU counts (32+), BPF tracepoint
attachment triggers SRCU synchronization that can take well over
15 seconds, causing spurious test failures. Raise the
wait_for_stalld_ready timeout from 15s to 240s in
start_stalld_with_log and test_backend_selection.

This does not affect happy-path latency: the underlying grep -m1
returns as soon as "monitoring started" appears in the log.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_backend_selection.sh | 2 +-
 tests/helpers/test_helpers.sh              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_backend_selection.sh b/tests/functional/test_backend_selection.sh
index 26654e1..e6924ff 100755
--- a/tests/functional/test_backend_selection.sh
+++ b/tests/functional/test_backend_selection.sh
@@ -38,7 +38,7 @@ test_backend_flag() {
 	STALLD_PID=$!
 	CLEANUP_PIDS+=("${STALLD_PID}")
 
-	if ! wait_for_stalld_ready "${log_file}" 15; then
+	if ! wait_for_stalld_ready "${log_file}" 240; then
 		fail "stalld failed to start (${description})"
 	fi
 
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 9222d07..e06ff8b 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -1162,11 +1162,11 @@ start_stalld_with_log() {
 	STALLD_PID=$!
 	CLEANUP_PIDS+=("${STALLD_PID}")
 
-	if ! wait_for_stalld_ready "${log_file}" 15; then
+	if ! wait_for_stalld_ready "${log_file}" 240; then
 		log "Log contents:"
 		cat "${log_file}"
 		stop_stalld
-		fail "stalld did not initialize within 15s"
+		fail "stalld did not initialize within 240s"
 	fi
 
 	local end_ns=$(date +%s%N)
-- 
2.55.0

