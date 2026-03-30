Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502A397E75
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899883; cv=none; b=dWBHahhRRBPGkwOjSoC4jjaE4AtvedEP/mAudKtotsIYY86ikcuqBe8I2sS80RgXQUMp+UfQ6VioJ8vxsVw3wdN7J2lyqbtKx0DePxQ6V13YGOiS0LI/zC54bWCEZ+EdPC3TGC5CC/Q3iyZSK1jJxvSWYcAKWXhE6o5rUt2BLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899883; c=relaxed/simple;
	bh=Y6KQ8wiIbHNopY4/6uLGU87+uwrHcNvl4P+kl2Q10V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV9QQkWjhf/JFYb2+HiX97Gt3lxVHQl7jBayeIvtVblrBTdjNR0Oq45TogRfuIbjfbUWwB1aM51jwA4W/8TPX3xHUFm4OXPuBEYRsbu5DJJBrvr8SZctlGbu3R6JCA2nl5yPoHT0ouzQJMBn1rD67uxx7ytHI3thk903RV1ad7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIfMaLll; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIfMaLll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90O4AA+o6NwIsOfcXfwXfGaA4KUbXO+4z1CaZF34Vak=;
	b=jIfMaLllOaK+p492NOdCuEfexB5gDrQgzfmEj/e1gXjIsKOZFe+ZDEfc1Hz5tkujY2U0lN
	EDLRNky5J+V4NVPeo+0SrNiSwO3vWNPeyardzBJgDWk99dsRvC+6PruvwKHt/XqzRwB9sx
	HsDCicqkvGVGxVjanIST8bxVbTesqMs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-Nri5zVlmNCWLcpINJKBJ9A-1; Mon,
 30 Mar 2026 15:44:39 -0400
X-MC-Unique: Nri5zVlmNCWLcpINJKBJ9A-1
X-Mimecast-MFC-AGG-ID: Nri5zVlmNCWLcpINJKBJ9A_1774899878
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21037195608E;
	Mon, 30 Mar 2026 19:44:38 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4398D1954102;
	Mon, 30 Mar 2026 19:44:34 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Claude <noreply@anthropic.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 01/36] tests: Add pre-test and post-test cleanup of stalld processes
Date: Mon, 30 Mar 2026 16:43:24 -0300
Message-ID: <20260330194410.103953-2-wander@redhat.com>
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

From: Clark Williams <williams@redhat.com>

Add kill_existing_stalld() function to test_helpers.sh and
kill_existing_stalld_processes() function to run_tests.sh to ensure
no stale stalld processes from previous test runs interfere with new
tests. This prevents orphaned processes from interrupted test runs
from causing false negatives or unexpected behavior.

Changes:
- test_helpers.sh: Add kill_existing_stalld() with graceful then
  forced shutdown, export the function, and call from
  setup_test_environment()
- run_tests.sh: Add kill_existing_stalld_processes() with logging,
  call from init_tests() before tests start, and call from
  cleanup_runner() on exit

This ensures clean test environment initialization and proper cleanup
even when test runs are interrupted.

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>
Assisted-By: git-scm-master (claude-sonnet-4 / 36f1d1f06f2e)
Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 35 ++++++++++++++++++++++++++++-
 tests/run_tests.sh            | 42 +++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 630601a..c42dab3 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -407,6 +407,36 @@ stop_stalld() {
 	fi
 }
 
+# Kill any existing stalld processes (cleanup from previous runs)
+# This ensures a clean slate before starting tests
+kill_existing_stalld() {
+	local pids=$(pgrep -x stalld 2>/dev/null)
+	if [ -n "${pids}" ]; then
+		echo "Killing existing stalld processes: ${pids}"
+		for pid in ${pids}; do
+			# Try graceful shutdown first
+			kill ${pid} 2>/dev/null || true
+		done
+		sleep 0.5
+		# Force kill any remaining
+		pids=$(pgrep -x stalld 2>/dev/null)
+		if [ -n "${pids}" ]; then
+			for pid in ${pids}; do
+				kill -9 ${pid} 2>/dev/null || true
+			done
+			sleep 0.2
+		fi
+		# Verify all killed
+		pids=$(pgrep -x stalld 2>/dev/null)
+		if [ -n "${pids}" ]; then
+			echo -e "${YELLOW}WARNING: Could not kill all stalld processes: ${pids}${NC}"
+			return 1
+		fi
+		echo "All existing stalld processes killed"
+	fi
+	return 0
+}
+
 # Cleanup function (call in trap)
 cleanup() {
 	local exit_code=$?
@@ -712,6 +742,9 @@ disable_dl_server() {
 setup_test_environment() {
 	echo "Setting up test environment..."
 
+	# Kill any existing stalld processes from previous runs
+	kill_existing_stalld
+
 	# Save and disable RT throttling
 	save_rt_throttling
 	disable_rt_throttling
@@ -1022,7 +1055,7 @@ export -f start_test end_test
 export -f assert_equals assert_contains assert_not_contains
 export -f assert_file_exists assert_file_not_exists
 export -f assert_process_running assert_process_not_running
-export -f start_stalld stop_stalld cleanup
+export -f start_stalld stop_stalld kill_existing_stalld cleanup
 export -f wait_for_log_message
 export -f get_thread_policy get_thread_priority
 export -f create_cpu_load
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index c6adc49..16b6750 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -220,6 +220,15 @@ cleanup_runner() {
 	fi
 
 	if [ $EUID -eq 0 ]; then
+		# Kill any remaining stalld processes
+		local pids=$(pgrep -x stalld 2>/dev/null)
+		if [ -n "${pids}" ]; then
+			echo -e "${BLUE}Cleaning up remaining stalld processes: ${pids}${NC}"
+			for pid in ${pids}; do
+				kill -9 ${pid} 2>/dev/null || true
+			done
+		fi
+
 		restore_dl_server_state
 		restore_rt_throttling_state
 	fi
@@ -236,6 +245,34 @@ handle_interrupt() {
 trap cleanup_runner EXIT
 trap handle_interrupt INT TERM
 
+# Kill any existing stalld processes before tests
+kill_existing_stalld_processes() {
+	local pids=$(pgrep -x stalld 2>/dev/null)
+	if [ -n "${pids}" ]; then
+		echo -e "${BLUE}Killing existing stalld processes: ${pids}${NC}" | tee -a "${LOG_FILE}"
+		for pid in ${pids}; do
+			kill ${pid} 2>/dev/null || true
+		done
+		sleep 0.5
+		# Force kill any remaining
+		pids=$(pgrep -x stalld 2>/dev/null)
+		if [ -n "${pids}" ]; then
+			for pid in ${pids}; do
+				kill -9 ${pid} 2>/dev/null || true
+			done
+			sleep 0.2
+		fi
+		# Verify
+		pids=$(pgrep -x stalld 2>/dev/null)
+		if [ -n "${pids}" ]; then
+			echo -e "${YELLOW}WARNING: Could not kill all stalld processes: ${pids}${NC}" | tee -a "${LOG_FILE}"
+		else
+			echo -e "${GREEN}All existing stalld processes killed${NC}" | tee -a "${LOG_FILE}"
+		fi
+		echo "" | tee -a "${LOG_FILE}"
+	fi
+}
+
 # Initialize
 init_tests() {
 	mkdir -p "${RESULTS_DIR}"
@@ -243,6 +280,11 @@ init_tests() {
 	print_banner | tee "${LOG_FILE}"
 	echo "" | tee -a "${LOG_FILE}"
 
+	# Kill any existing stalld processes from previous runs
+	if [ $EUID -eq 0 ]; then
+		kill_existing_stalld_processes
+	fi
+
 	# Save and disable RT throttling if running as root
 	if [ $EUID -eq 0 ]; then
 		save_and_disable_rt_throttling
-- 
2.53.0

