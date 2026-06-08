Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF7368D60
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943611; cv=none; b=INq4FdCVJS/qrEwK77sSHttC/caW+6F8bYgzieMshX6a4yzd97Wq0I2Gpnw5mCCLEzrcXJhhvmo5yY0ejIk3y0dJHiXk6GsL3GJ3RS8ydH+oFf9ceOoYN1cEZFkqrvvy3POcqQS8ds/8OcT7VZQ4xQR3ncpoxm1TNf+JJtabNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943611; c=relaxed/simple;
	bh=m+iwD+q3Nolup0VH8V8DhKmQfMxOwR9l8MaTCnyQi7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubHV+hdHeON0ydLzaOJhhYnivH1HwNwixa7lgjctwGAefRADDfPjjNYKF0YZHN8CYanMRnwz29MnGXpMcrxkCMFwrQvoOfnl5APa5gqsGXoCHUGuWTQkOP9BYadGeA3tg8rOksn/Cl4zgOyu9bfqTYFGn4VTG61PS5BGD1uVt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzxUvDHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzxUvDHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeieRf2CizMAxa3MsgTWaf+YVyO285uuynS3l59ss6M=;
	b=fzxUvDHbOwskj1ZNIIHV7IXGipMTOl5sLk1TpZJzAaUGiwnntH7mlik4NJ4ah7bc69qaUA
	E6p06hHv2mbZbkW1W1wS65L9GVBiuSnpXRsk59l8qxph5ECqOR8GEPdTswXzGwF5qwa5VB
	ibxlEYDeRIaNlNcN6SCGHWlU/uYKdvs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-8yKux_S0N0OiP5RSqwcTgA-1; Mon,
 08 Jun 2026 14:33:24 -0400
X-MC-Unique: 8yKux_S0N0OiP5RSqwcTgA-1
X-Mimecast-MFC-AGG-ID: 8yKux_S0N0OiP5RSqwcTgA_1780943604
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E81311833483;
	Mon,  8 Jun 2026 18:33:23 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBA3336928;
	Mon,  8 Jun 2026 18:33:21 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 25/52] tests: Extract wait_for_process_exit helper
Date: Mon,  8 Jun 2026 15:31:35 -0300
Message-ID: <20260608183206.140526-26-wander@redhat.com>
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

The SIGTERM-poll-SIGKILL-poll termination sequence is currently
duplicated in both stop_stalld() and cleanup() with identical inline
polling loops. This refactors the teardown sequence by extracting the
polling logic into a new wait_for_process_exit() helper.

The new helper polls process_alive() at 0.1 second intervals, returning
0 on successful exit or 1 upon timeout. Utilizing this helper
eliminates the duplicated logic, removes a redundant sleep in cleanup(),
and accelerates test teardown by checking process state more frequently
than the previous one second intervals, all while maintaining the
existing five second total timeout. Furthermore, stop_stalld() is
simplified with an early return guard to reduce nesting. The helper is
explicitly exported to ensure availability across the test environment.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 85 +++++++++++++++++------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 7159c19..5187f0f 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -360,6 +360,28 @@ process_alive() {
 	kill -0 "$1" 2>/dev/null
 }
 
+# Poll for a process to exit within a timeout.
+# Returns 0 if the process exits, 1 if still alive after timeout.
+#
+# Usage: wait_for_process_exit <pid> <timeout_seconds>
+wait_for_process_exit() {
+	local pid="$1"
+	local timeout="$2"
+	local elapsed=0
+
+	while process_alive "${pid}" && [ ${elapsed} -lt ${timeout} ]; do
+		for i in $(seq 1 10); do
+			sleep 0.1
+			if ! process_alive "${pid}"; then
+				return 0
+			fi
+		done
+		elapsed=$((elapsed + 1))
+	done
+
+	! process_alive "${pid}"
+}
+
 send_signal() {
 	kill -"$1" "$2" 2>/dev/null || true
 }
@@ -537,32 +559,23 @@ start_stalld() {
 # SIGKILL if needed. Guarantees the process is dead before
 # returning so callers do not need post-stop sleeps.
 stop_stalld() {
-	if [ -n "${STALLD_PID}" ]; then
-		if process_alive ${STALLD_PID}; then
-			# Try graceful shutdown first (SIGTERM)
-			send_signal TERM ${STALLD_PID}
-
-			# Poll for graceful exit (up to 5 seconds)
-			local timeout=5
-			local elapsed=0
-			while process_alive ${STALLD_PID} && [ ${elapsed} -lt ${timeout} ]; do
-				sleep 1
-				elapsed=$((elapsed + 1))
-			done
+	if [ -z "${STALLD_PID}" ]; then
+		return
+	fi
+
+	if process_alive ${STALLD_PID}; then
+		# Try graceful shutdown first (SIGTERM)
+		send_signal TERM ${STALLD_PID}
 
+		# Poll for graceful exit (up to 5 seconds)
+		if ! wait_for_process_exit ${STALLD_PID} 5; then
 			# Escalate to SIGKILL if still running
-			if process_alive ${STALLD_PID}; then
-				send_signal KILL ${STALLD_PID}
-				# Poll for forced termination (up to 5 seconds)
-				elapsed=0
-				while process_alive ${STALLD_PID} && [ ${elapsed} -lt ${timeout} ]; do
-					sleep 1
-					elapsed=$((elapsed + 1))
-				done
-			fi
+			send_signal KILL ${STALLD_PID}
+			# Poll for forced termination (up to 5 seconds)
+			wait_for_process_exit ${STALLD_PID} 5
 		fi
-		STALLD_PID=""
 	fi
+	STALLD_PID=""
 }
 
 # Kill any existing stalld processes (cleanup from previous runs)
@@ -607,31 +620,17 @@ cleanup() {
 	# Stop stalld
 	stop_stalld
 
-	# Small delay to let processes terminate
-	sleep 0.2
-
 	# Kill any tracked processes
 	# Use SIGKILL (-9) and ignore EPERM errors (process may have different privileges)
 	for pid in "${CLEANUP_PIDS[@]}"; do
 		if [ -n "${pid}" ] && [ "${pid}" -gt 0 ] 2>/dev/null; then
 			# Check if process exists
-			if process_alive ${pid}; then
-				send_signal TERM ${pid}
-
-				local timeout=5
-				local elapsed=0
-				while process_alive ${pid} && [ ${elapsed} -lt ${timeout} ]; do
-					sleep 1
-					elapsed=$((elapsed + 1))
-				done
-
-				if process_alive ${pid}; then
-					send_signal KILL ${pid}
-					elapsed=0
-					while process_alive ${pid} && [ ${elapsed} -lt ${timeout} ]; do
-						sleep 1
-						elapsed=$((elapsed + 1))
-					done
+			if process_alive "${pid}"; then
+				send_signal TERM "${pid}"
+
+				if ! wait_for_process_exit "${pid}" 5; then
+					send_signal KILL "${pid}"
+					wait_for_process_exit "${pid}" 5
 				fi
 			fi
 		fi
@@ -1323,7 +1322,7 @@ export -f start_test end_test test_section cleanup_scenario find_starved_child
 export -f assert_starvation_detected assert_boost_detected assert_stalld_rejects assert_log_contains assert_success
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
-export -f process_alive send_signal assert_process_running assert_process_not_running
+export -f process_alive wait_for_process_exit send_signal assert_process_running assert_process_not_running
 export -f start_stalld stop_stalld kill_existing_stalld cleanup
 export -f wait_for_log_message wait_for_stalld_ready wait_for_starvation_detected wait_for_boost_detected wait_for_n_log_matches
 export -f get_thread_policy get_thread_priority
-- 
2.54.0

