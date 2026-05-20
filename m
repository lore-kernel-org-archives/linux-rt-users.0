Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C83E7BC3
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285747; cv=none; b=moS7mhkxAREFJZY4D0uU/Lq9nwiUXw5OEo6j+puaVAgsAxtfAXdTN2TvuMO6eVlqEnnhMgPlq2JSUmFyeaF1FdJKemZov6kc8EdULzHSj6r5d0HGeZsITMPhmALve4a0JF4S6K/9cso71QN6rGia8T7660cP8XwJTSQMZJybVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285747; c=relaxed/simple;
	bh=GYeiLpS/0w2ufUyI9RAIASuGTjSwyNS8iahKjBNjRFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4vhe1s8vFglE08OmI3QB5NwDdn/wqrVU4W9mqApE9IPV2oOaMQ0ZUF3jfyofdNUCXoPTOr+N20NhbgORvqj/9p6pg53qgNkPTpI/xrOAumtAsIoH+dww2jfKGDrYXoJJLTd7dT+fDIxRYm/3/SS9MlqHrRxqOtA7ZEguZatgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2/FlEYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2/FlEYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLXfLSAeeh+oo/dcAj/+giGl7Au42TcGXk+rVrKOrpM=;
	b=R2/FlEYG/WUg7UFsQ/J3YlmxE1bg2WLGaNiiqTumGuzA1Uxi3uwWnJ+oagKHAPwdEex8W3
	0EpSmAwt/UCwnoB2RB3YtmVbYZOtLTWduo3rPeTS1MPbHBvrleIM9GZPPXFYsMgD1w4A3M
	9iLpXkBBebV4WEv3DvEoG7sQSHlu3/k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-YF-0E0KRN366-Cnajs5s1g-1; Wed,
 20 May 2026 10:02:19 -0400
X-MC-Unique: YF-0E0KRN366-Cnajs5s1g-1
X-Mimecast-MFC-AGG-ID: YF-0E0KRN366-Cnajs5s1g_1779285738
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C91521955F12;
	Wed, 20 May 2026 14:02:18 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEACC1800465;
	Wed, 20 May 2026 14:02:16 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 24/33] tests: Introduce and adopt process helpers
Date: Wed, 20 May 2026 11:00:51 -0300
Message-ID: <20260520140104.112142-25-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Raw kill invocations scattered across the test suite obscure the
intent of the code. Using kill with signal zero acts as a liveness
check rather than signal delivery, while best-effort process cleanup
often requires ignoring errors.

This change introduces two dedicated helper functions to make these
patterns self-documenting. The process_alive function wraps the zero
signal check and preserves the exit code for use in conditionals and
loops. The send_signal function wraps standard signal delivery using
named signals like TERM or KILL, operating in a fire-and-forget
manner where failure is acceptable. These functions are kept separate
to distinguish predicates from cleanup actions, and both are exported
via export -f for availability in subshells.

Existing scripts including test_helpers.sh, test_boost_restoration.sh,
run_tests.sh, and test_starvation_detection.sh are updated to use
the new helpers in place of direct kill invocations.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_boost_restoration.sh    |  2 +-
 tests/functional/test_starvation_detection.sh |  2 +-
 tests/helpers/test_helpers.sh                 | 60 +++++++++++--------
 tests/run_tests.sh                            |  6 +-
 4 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index ddf3940..62c37b0 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -183,7 +183,7 @@ if wait_for_boost_detected "${STALLD_LOG}"; then
     sleep 1
 
     # Verify stalld is still running and didn't crash after task exit
-    assert_success "stalld handled task exit during boost gracefully" kill -0 ${STALLD_PID}
+    assert_success "stalld handled task exit during boost gracefully" process_alive ${STALLD_PID}
 
 else
     log "⚠ WARNING: No boost detected in this test run"
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 17d7fe0..9362899 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -164,7 +164,7 @@ assert_log_contains --negate "${STALLD_LOG}" \
     "${BUSY_PID}.*starved" \
     "No false positive - progress-making task not reported as starved"
 
-kill ${BUSY_PID} 2>/dev/null
+send_signal TERM ${BUSY_PID}
 wait ${BUSY_PID} 2>/dev/null
 
 stop_stalld
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index c51361f..7159c19 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -119,7 +119,7 @@ test_section() {
 cleanup_scenario() {
 	for pid in "$@"; do
 		if [ -n "$pid" ]; then
-			kill -TERM "$pid" 2>/dev/null || true
+			send_signal TERM "$pid"
 			wait "$pid" 2>/dev/null || true
 		fi
 	done
@@ -356,11 +356,19 @@ assert_file_not_exists() {
 	fi
 }
 
+process_alive() {
+	kill -0 "$1" 2>/dev/null
+}
+
+send_signal() {
+	kill -"$1" "$2" 2>/dev/null || true
+}
+
 assert_process_running() {
 	local pid=$1
 	local message=${2:-"Process ${pid} should be running"}
 
-	if kill -0 ${pid} 2>/dev/null; then
+	if process_alive ${pid}; then
 		pass "${message}"
 	else
 		fail "${message}"
@@ -371,7 +379,7 @@ assert_process_not_running() {
 	local pid=$1
 	local message=${2:-"Process ${pid} should not be running"}
 
-	if ! kill -0 ${pid} 2>/dev/null; then
+	if ! process_alive ${pid}; then
 		pass "${message}"
 	else
 		fail "${message}"
@@ -476,7 +484,7 @@ start_stalld() {
 
 			# If pgrep didn't find it, fall back to the shell PID
 			if [ -z "${STALLD_PID}" ]; then
-				if kill -0 ${shell_pid} 2>/dev/null; then
+				if process_alive ${shell_pid}; then
 					STALLD_PID=${shell_pid}
 				fi
 			fi
@@ -488,11 +496,11 @@ start_stalld() {
 				sleep 0.5
 
 				# Check if shell_pid has exited (daemonization complete)
-				if ! kill -0 ${shell_pid} 2>/dev/null; then
+				if ! process_alive ${shell_pid}; then
 					# Shell process exited, daemon should be running
 					# Use pgrep -n to find the newest stalld process
 					STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
-					if [ -n "${STALLD_PID}" ] && kill -0 ${STALLD_PID} 2>/dev/null; then
+					if [ -n "${STALLD_PID}" ] && process_alive ${STALLD_PID}; then
 						break
 					fi
 				fi
@@ -514,7 +522,7 @@ start_stalld() {
 		return 1
 	fi
 
-	if ! kill -0 ${STALLD_PID} 2>/dev/null; then
+	if ! process_alive ${STALLD_PID}; then
 		echo -e "${RED}ERROR: stalld PID ${STALLD_PID} is not running${NC}"
 		return 1
 	fi
@@ -530,24 +538,24 @@ start_stalld() {
 # returning so callers do not need post-stop sleeps.
 stop_stalld() {
 	if [ -n "${STALLD_PID}" ]; then
-		if kill -0 ${STALLD_PID} 2>/dev/null; then
+		if process_alive ${STALLD_PID}; then
 			# Try graceful shutdown first (SIGTERM)
-			kill ${STALLD_PID} 2>/dev/null || true
+			send_signal TERM ${STALLD_PID}
 
 			# Poll for graceful exit (up to 5 seconds)
 			local timeout=5
 			local elapsed=0
-			while kill -0 ${STALLD_PID} 2>/dev/null && [ ${elapsed} -lt ${timeout} ]; do
+			while process_alive ${STALLD_PID} && [ ${elapsed} -lt ${timeout} ]; do
 				sleep 1
 				elapsed=$((elapsed + 1))
 			done
 
 			# Escalate to SIGKILL if still running
-			if kill -0 ${STALLD_PID} 2>/dev/null; then
-				kill -9 ${STALLD_PID} 2>/dev/null || true
+			if process_alive ${STALLD_PID}; then
+				send_signal KILL ${STALLD_PID}
 				# Poll for forced termination (up to 5 seconds)
 				elapsed=0
-				while kill -0 ${STALLD_PID} 2>/dev/null && [ ${elapsed} -lt ${timeout} ]; do
+				while process_alive ${STALLD_PID} && [ ${elapsed} -lt ${timeout} ]; do
 					sleep 1
 					elapsed=$((elapsed + 1))
 				done
@@ -565,14 +573,14 @@ kill_existing_stalld() {
 		echo "Killing existing stalld processes: ${pids}"
 		for pid in ${pids}; do
 			# Try graceful shutdown first
-			kill ${pid} 2>/dev/null || true
+			send_signal TERM ${pid}
 		done
 		sleep 0.5
 		# Force kill any remaining
 		pids=$(pgrep -x stalld 2>/dev/null)
 		if [ -n "${pids}" ]; then
 			for pid in ${pids}; do
-				kill -9 ${pid} 2>/dev/null || true
+				send_signal KILL ${pid}
 			done
 			sleep 0.2
 		fi
@@ -607,20 +615,20 @@ cleanup() {
 	for pid in "${CLEANUP_PIDS[@]}"; do
 		if [ -n "${pid}" ] && [ "${pid}" -gt 0 ] 2>/dev/null; then
 			# Check if process exists
-			if kill -0 ${pid} 2>/dev/null; then
-				kill ${pid} 2>/dev/null || true
+			if process_alive ${pid}; then
+				send_signal TERM ${pid}
 
 				local timeout=5
 				local elapsed=0
-				while kill -0 ${pid} 2>/dev/null && [ ${elapsed} -lt ${timeout} ]; do
+				while process_alive ${pid} && [ ${elapsed} -lt ${timeout} ]; do
 					sleep 1
 					elapsed=$((elapsed + 1))
 				done
 
-				if kill -0 ${pid} 2>/dev/null; then
-					kill -9 ${pid} 2>/dev/null || true
+				if process_alive ${pid}; then
+					send_signal KILL ${pid}
 					elapsed=0
-					while kill -0 ${pid} 2>/dev/null && [ ${elapsed} -lt ${timeout} ]; do
+					while process_alive ${pid} && [ ${elapsed} -lt ${timeout} ]; do
 						sleep 1
 						elapsed=$((elapsed + 1))
 					done
@@ -1285,7 +1293,7 @@ start_starvation_gen() {
 	local timeout=10
 	local elapsed=0
 	while [ $elapsed -lt $timeout ]; do
-		if ! kill -0 ${STARVE_PID} 2>/dev/null; then
+		if ! process_alive ${STARVE_PID}; then
 			echo -e "${RED}ERROR: starvation_gen exited prematurely${NC}"
 			echo "  Log contents:"
 			cat "${STARVE_LOG}"
@@ -1302,10 +1310,10 @@ start_starvation_gen() {
 	echo -e "${RED}ERROR: starvation_gen did not become ready within ${timeout}s${NC}"
 	echo "  Log contents:"
 	cat "${STARVE_LOG}"
-	kill ${STARVE_PID} 2>/dev/null
+	send_signal TERM ${STARVE_PID}
 	sleep 1
-	if kill -0 ${STARVE_PID} 2>/dev/null; then
-		kill -9 ${STARVE_PID} 2>/dev/null
+	if process_alive ${STARVE_PID}; then
+		send_signal KILL ${STARVE_PID}
 	fi
 	return 1
 }
@@ -1315,7 +1323,7 @@ export -f start_test end_test test_section cleanup_scenario find_starved_child
 export -f assert_starvation_detected assert_boost_detected assert_stalld_rejects assert_log_contains assert_success
 export -f pass fail assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
-export -f assert_process_running assert_process_not_running
+export -f process_alive send_signal assert_process_running assert_process_not_running
 export -f start_stalld stop_stalld kill_existing_stalld cleanup
 export -f wait_for_log_message wait_for_stalld_ready wait_for_starvation_detected wait_for_boost_detected wait_for_n_log_matches
 export -f get_thread_policy get_thread_priority
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index 63d0624..1fbb3f2 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -224,7 +224,7 @@ cleanup_runner() {
 		if [ -n "${pids}" ]; then
 			echo -e "${BLUE}Cleaning up remaining stalld processes: ${pids}${NC}"
 			for pid in ${pids}; do
-				kill -9 ${pid} 2>/dev/null || true
+				send_signal KILL ${pid}
 			done
 		fi
 
@@ -250,14 +250,14 @@ kill_existing_stalld_processes() {
 	if [ -n "${pids}" ]; then
 		echo -e "${BLUE}Killing existing stalld processes: ${pids}${NC}" | tee -a "${LOG_FILE}"
 		for pid in ${pids}; do
-			kill ${pid} 2>/dev/null || true
+			send_signal TERM ${pid}
 		done
 		sleep 0.5
 		# Force kill any remaining
 		pids=$(pgrep -x stalld 2>/dev/null)
 		if [ -n "${pids}" ]; then
 			for pid in ${pids}; do
-				kill -9 ${pid} 2>/dev/null || true
+				send_signal KILL ${pid}
 			done
 			sleep 0.2
 		fi
-- 
2.54.0

