Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427E3B27E5
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288660; cv=none; b=D4/l0cMpwcQXB+vtOb9/tdLtT+p4YOotR8+OkxctgZXO6a2T/vYG5By53c+3dzk23YfXxmkpKKmfbmxSb9RyaAq6ysklg1UQYdDkcU6R6YVq7a1vaUiXio1Sg1c0iIsbJf5CvDijIIGvAK3eADpQLiaXPGpLhgPNvYXWbi667cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288660; c=relaxed/simple;
	bh=dH0Iq16C58knuK16yX5g+mb7vqQYMVV0UThZ6w3rXAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt1ZXoDMf+3IHBahA1bR1e8PBis8nStVsevAuuskj9tAMON2gUsZR4Mt+uZLIdFABBP0oUpepkPYC41GU3nsfcKERj3+shBGfhFnfwxTIC8pa/9U1wNq+dJd5iVn8HaLXih02N7XFWdIbzC2OTdwds8BJkPjBdXsRE9gYMcV9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYodbalx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYodbalx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPWp6aW4W9e50ePAqa8BWDDEYGmZRZKUM3QB7TClLs0=;
	b=AYodbalx4qFoq4YTWgvL8C07qWgQeBwTv6MMcDdGesQ3wZHVAVF+ltSg3Pnd+V6i0htZF2
	qnfY20zzNSIL9Goxz9kBzyD/tCoxfZSOGQo8lykCjICDqdl7U1QRPNCwHGxEo2jYtrEBYA
	nWt81wMZ+usGnj292iwxC6JxoGt2JTI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-0LWDPoeyPL-whQGUsNTHAw-1; Mon,
 27 Apr 2026 07:17:35 -0400
X-MC-Unique: 0LWDPoeyPL-whQGUsNTHAw-1
X-Mimecast-MFC-AGG-ID: 0LWDPoeyPL-whQGUsNTHAw_1777288654
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A233719560B5;
	Mon, 27 Apr 2026 11:17:33 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 918F0180047F;
	Mon, 27 Apr 2026 11:17:31 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 11/23] tests: Fix repeated log match finding same line
Date: Mon, 27 Apr 2026 08:16:13 -0300
Message-ID: <20260427111632.24500-12-wander@redhat.com>
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

Test 3 in the FIFO priority starvation suite calls
wait_for_starvation_detected three times on the same log file to
wait for three detection cycles. However, the underlying
wait_for_log_message helper uses tail -f -n +1 which reads from
the beginning of the file on every invocation, so all three calls
instantly match the same first line.

Introduce a wait_for_n_log_matches helper that polls grep -c until
the match count reaches the requested threshold, and use it to
replace the repeated calls.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 .../test_fifo_priority_starvation.sh          | 10 +++------
 tests/helpers/test_helpers.sh                 | 21 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index 172bc9a..8f78a75 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -139,13 +139,9 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a $
 # Wait for multiple detection cycles
 log "Waiting for first detection cycle..."
 wait_for_starvation_detected "${STALLD_LOG}"
-log "First detection cycle should have occurred"
-log "Waiting for second detection cycle..."
-wait_for_starvation_detected "${STALLD_LOG}"
-log "Second detection cycle should have occurred"
-log "Waiting for third detection cycle..."
-wait_for_starvation_detected "${STALLD_LOG}"
-log "Third detection cycle should have occurred"
+log "First detection cycle occurred, waiting for additional cycles..."
+wait_for_n_log_matches "starved on CPU" 3 "${STALLD_LOG}"
+log "Multiple detection cycles should have occurred"
 
 # Check if we see accumulating starvation time in logs
 # Task merging means the timestamp is preserved, so duration increases
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 742b15e..757e5e0 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -668,6 +668,25 @@ wait_for_boost_detected() {
 	wait_for_log_message "boosted pid" "${timeout}" "${log_file}"
 }
 
+# Wait until a log file contains at least N matches of a pattern.
+#
+# Usage: wait_for_n_log_matches <pattern> <count> <log_file> [timeout]
+wait_for_n_log_matches() {
+	local pattern=$1
+	local count=$2
+	local log_file=$3
+	local timeout=${4:-30}
+	local end=$((SECONDS + timeout))
+
+	while [ $SECONDS -lt $end ]; do
+		local matches
+		matches=$(grep -c "${pattern}" "${log_file}" 2>/dev/null || true)
+		[ "${matches:-0}" -ge "${count}" ] && return 0
+		sleep 1
+	done
+	return 1
+}
+
 # Get thread scheduling policy
 get_thread_policy() {
 	local pid=$1
@@ -1250,7 +1269,7 @@ export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
 export -f start_stalld stop_stalld kill_existing_stalld cleanup
-export -f wait_for_log_message wait_for_stalld_ready wait_for_starvation_detected wait_for_boost_detected
+export -f wait_for_log_message wait_for_stalld_ready wait_for_starvation_detected wait_for_boost_detected wait_for_n_log_matches
 export -f get_thread_policy get_thread_priority
 export -f create_cpu_load
 export -f detect_default_backend is_backend_available get_available_backends start_stalld_with_backend
-- 
2.53.0

