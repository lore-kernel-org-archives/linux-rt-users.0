Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52846394492
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899935; cv=none; b=WgKq662ogJ+PeLQM987A9dYyKPS3jXBBFnS92HKVqGjLpViyiAiCGmWTn4Tc+C5FAVCU1lRCQjM/4F86GJ3OxGmAOkmHQRacwKXVwz5aytXAH9sdv12127gEO/5dMSivRW3eAi/ZDJqyDUI7z6eW1TrvTP7sLW4EaE+yDTpdnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899935; c=relaxed/simple;
	bh=ajgaTGDwYkcEKYFNBBjKUxVbfLjEKV8VSI7piN9LL1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyZkF9oMjTN2/cnEHa1o6ohXUalg3QgTHxZeW3w1IeixhSpHbbYQg5HcoOZ5dmQ/stB491cfaDBK/YJ18GaChwtUAZhCEm/zG5n0FZmetGXxlfMCF1r/oy44UuNrqCvZjf7BCoucHe6vabvCMkh98oO/ZyA/UA56LkTnu/+F/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfR5zBuC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfR5zBuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcF7drPMEjk7BEVy5xM2o25Gy0LMXWEC2CqMDgB5pOI=;
	b=GfR5zBuCXz2MBaYvBf02V+KYmRdtiXrNYT3k0e+2PlbEtaU6//sx9eZrOO1G6wnsU56Lv1
	w3o0eTU1YwrCBzHOBxVH5D0sJOs/Gl3K/SLlMPSalhWpIVNvsjvvJucoKK7oSyJIVz2tCF
	nC/nH2cWKmVLkmPxbtvE6uF8fgsfNOA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-1YhGPV7xM4y9G7eQVrUzcw-1; Mon,
 30 Mar 2026 15:45:31 -0400
X-MC-Unique: 1YhGPV7xM4y9G7eQVrUzcw-1
X-Mimecast-MFC-AGG-ID: 1YhGPV7xM4y9G7eQVrUzcw_1774899930
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0C0E1956055;
	Mon, 30 Mar 2026 19:45:30 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25CA01954102;
	Mon, 30 Mar 2026 19:45:27 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 17/36] tests/helpers: Add wait_for_starvation_detected() and wait_for_boost_detected()
Date: Mon, 30 Mar 2026 16:43:40 -0300
Message-ID: <20260330194410.103953-18-wander@redhat.com>
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

Tests that verify starvation detection and boosting currently use
hardcoded sleep calls to wait for stalld to act, making them
timing-dependent and flaky on slow systems. Subsequent commits will
replace ~48 such sleep calls across 10 test files.

Add two event-driven helpers that wrap wait_for_log_message() with
domain-specific patterns matching the log messages emitted by stalld
during starvation detection and task boosting. Both use a default
timeout of 30 seconds and return immediately when the event occurs.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 276ffe8..864036d 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -536,6 +536,24 @@ wait_for_stalld_ready() {
 	wait_for_log_message "checking cpu\|waiting tasks" "${timeout}" "${log_file}"
 }
 
+# Wait for stalld to detect a starving task.
+#
+# Usage: wait_for_starvation_detected <log_file> [timeout]
+wait_for_starvation_detected() {
+	local log_file=$1
+	local timeout=${2:-30}
+	wait_for_log_message "starved on CPU" "${timeout}" "${log_file}"
+}
+
+# Wait for stalld to boost a starving task.
+#
+# Usage: wait_for_boost_detected <log_file> [timeout]
+wait_for_boost_detected() {
+	local log_file=$1
+	local timeout=${2:-30}
+	wait_for_log_message "boosted pid" "${timeout}" "${log_file}"
+}
+
 # Get thread scheduling policy
 get_thread_policy() {
 	local pid=$1
@@ -1107,7 +1125,7 @@ export -f assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
 export -f start_stalld stop_stalld kill_existing_stalld cleanup
-export -f wait_for_log_message wait_for_stalld_ready
+export -f wait_for_log_message wait_for_stalld_ready wait_for_starvation_detected wait_for_boost_detected
 export -f get_thread_policy get_thread_priority
 export -f create_cpu_load
 export -f detect_default_backend is_backend_available get_available_backends start_stalld_with_backend
-- 
2.53.0

