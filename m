Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA813876B9
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899925; cv=none; b=jdwP3uGNYHsO3RQouKU32uL5iA01GHuHLQqrK2tzyvfRIa1dEqnr9rs8zCQKoBaiJ5gCz/wlEPxLqnuaTv38Ga1nbTdcRWZ/LT7vhp3BhAt05N+f2OVjWzfOfwArfYxY0+ufU36pY02QK59z2OkJI0D7MwJbKVZxL86e4m2anVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899925; c=relaxed/simple;
	bh=WbrLdH2FUsGyt2vw5Aose/r2K/4S9iUAPEo+/UVjh7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu0A/ioZXW5DqvOLgfy51B7ujGDBRkZVvdzKBpha5Et13xwv9dg9K+e/zP6Syh80cPjeFf7+nFJE1fuVhoTkczVyj1Pr+QoMtEIbEt7QUUWUyw9IsIx4ORIm0fGq7vYRP5e8vM+PoIq/bGsVoj0aHGJ0/x5y/S2ZNFiFTV0gMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H164loQa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H164loQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gBn9AyxvZfqx5CnpQ5tQyrQgjBQwhP3e3upOJBmMqg=;
	b=H164loQaDbaF8qn0t4DabfWXBgeKjwc8cou3RCAqdqgnidGCPfAVYsVX+J1dOAwyqvLKXX
	pUVoJBDuXPBhh+0sQnZjIs/qqzbtrBoC2D+QmJzHePeGjtS7OdwFj9sw3eF02XSMN/R9p7
	f/i9W6SRp31qHgOSRNvxgODOs/+S97w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-E-ehiN9aNuGwAaYpVNEK3g-1; Mon,
 30 Mar 2026 15:45:19 -0400
X-MC-Unique: E-ehiN9aNuGwAaYpVNEK3g-1
X-Mimecast-MFC-AGG-ID: E-ehiN9aNuGwAaYpVNEK3g_1774899918
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3335195606A;
	Mon, 30 Mar 2026 19:45:17 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A7021954102;
	Mon, 30 Mar 2026 19:45:14 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 13/36] tests/helpers: Add wait_for_stalld_ready() and use in start_stalld_with_log()
Date: Mon, 30 Mar 2026 16:43:36 -0300
Message-ID: <20260330194410.103953-14-wander@redhat.com>
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

start_stalld_with_log() checks for a non-empty log file to
determine if stalld has started, but this is a weak signal that
does not guarantee initialization is complete. Backend loading,
boost method detection, and thread setup may still be in progress.

Add wait_for_stalld_ready() that watches for a stalld log message,
which stalld prints at the end of its init sequence after all setup
is complete. Integrate it into start_stalld_with_log() to replace
the non-empty file check, and reuse stop_stalld() in the error path
instead of duplicating the kill logic.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 45 +++++++++++++----------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 08838a2..e4e9b23 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -501,10 +501,8 @@ trap cleanup EXIT
 trap handle_signal INT TERM
 
 # Wait for a specific message to appear in a log file.
-# Uses tail -f piped through grep for instant detection -- returns
-# immediately when the pattern appears instead of sleeping between
-# polling intervals. Replays existing file content so messages
-# written before this function is called are also matched.
+# Returns immediately when the pattern is found, or returns 1
+# after the timeout expires.
 #
 # Usage: wait_for_log_message <pattern> <timeout> <log_file>
 wait_for_log_message() {
@@ -527,6 +525,15 @@ wait_for_log_message() {
 	return $?
 }
 
+# Wait for stalld to complete initialization.
+#
+# Usage: wait_for_stalld_ready <log_file> [timeout]
+wait_for_stalld_ready() {
+	local log_file=$1
+	local timeout=${2:-15}
+	wait_for_log_message "checking cpu\|waiting tasks" "${timeout}" "${log_file}"
+}
+
 # Get thread scheduling policy
 get_thread_policy() {
 	local pid=$1
@@ -958,31 +965,11 @@ start_stalld_with_log() {
 	STALLD_PID=$!
 	CLEANUP_PIDS+=("${STALLD_PID}")
 
-	# Poll for stalld to start writing to the log file rather than
-	# using a fixed sleep. Brief initial sleep covers the fast path,
-	# then 1-second polling for slow systems (e.g. BPF init).
-	sleep 0.01
-	local timeout=15
-	local elapsed=0
-	while [ $elapsed -lt $timeout ]; do
-		if ! kill -0 ${STALLD_PID} 2>/dev/null; then
-			echo -e "${RED}ERROR: stalld exited during startup${NC}"
-			return 1
-		fi
-		if [ -s "${log_file}" ]; then
-			return 0
-		fi
-		sleep 1
-		elapsed=$((elapsed + 1))
-	done
-
-	echo -e "${RED}ERROR: stalld did not produce output within ${timeout}s${NC}"
-	kill ${STALLD_PID} 2>/dev/null
-	sleep 1
-	if kill -0 ${STALLD_PID} 2>/dev/null; then
-		kill -9 ${STALLD_PID} 2>/dev/null
+	if ! wait_for_stalld_ready "${log_file}" 15; then
+		echo -e "${RED}ERROR: stalld did not initialize within 15s${NC}"
+		stop_stalld
+		return 1
 	fi
-	return 1
 }
 
 # Wait for scheduling policy to change to expected value
@@ -1062,7 +1049,7 @@ export -f assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
 export -f start_stalld stop_stalld kill_existing_stalld cleanup
-export -f wait_for_log_message
+export -f wait_for_log_message wait_for_stalld_ready
 export -f get_thread_policy get_thread_priority
 export -f create_cpu_load
 export -f detect_default_backend is_backend_available get_available_backends start_stalld_with_backend
-- 
2.53.0

