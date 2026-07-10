Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B636606E
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690744; cv=none; b=iB56aMP6V8I7+8ERq2lWmoCHyxPF8yojfklyXFRHN+5tiW0/PBL9TtrtZo/Y0sOFlrhfZiyUOGQ0v43059GgR9tWAqbUIwN4JSPSqdEZC3StHQGFkuCqa8WloezDBaJpi5UD9Mymb744dhD0F3omsEwSpp42dKEnrKsD70KwjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690744; c=relaxed/simple;
	bh=AIbNSKnbupBsrTF3sYd7sDvaabvubrtf0ZADWKoKxRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNucAgLB7KMVMRkkayThJm77Ij0hOlGPDz/Q0bbHWmfArff6ec0FfSZkkwoXJiV/hzGBmSRSprqXerg1SnacceK5ENelYxJ9FNeZbEM+ZU31cZoFS4J2CShl3O540wWGpRadxTq61wPgTtAB9eN5FjcP/S72MkD3v9hnUG88rY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZ/61Biz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZ/61Biz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap+SzEwiXM1603+fh9THGZP1uCCK8ZhcTlHfPOPNBVY=;
	b=fZ/61BizCc4KRADZJOhjd6miEGQe7nl0BcRVjQMeHDsB1nKab+ZiBPN5ZWhsh6HaZxLLma
	JwZ/g0kl5BM0gFNBDpvNIAOj6w9GcKK7Z6VsbHnp5E8FNjex9wtamNmgYqz2iOVkm95Y/S
	uwS5A+UpUi5+pM4RrqNa770Zxi+KbKE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-cPl3D9LVMuKWAq0bwV0Gtw-1; Fri,
 10 Jul 2026 09:38:56 -0400
X-MC-Unique: cPl3D9LVMuKWAq0bwV0Gtw-1
X-Mimecast-MFC-AGG-ID: cPl3D9LVMuKWAq0bwV0Gtw_1783690735
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D8621955F1A;
	Fri, 10 Jul 2026 13:38:55 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5708F195608E;
	Fri, 10 Jul 2026 13:38:53 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 02/11] tests: use fail() for error paths in helpers
Date: Fri, 10 Jul 2026 10:38:01 -0300
Message-ID: <20260710133810.72398-3-wander@redhat.com>
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

Replace ad-hoc error reporting in test_helpers.sh with the
framework's fail() function.  Twelve call sites previously used
echo/return 1, but callers never checked the return value, so
errors were silently ignored and tests continued in a broken
state.  fail() calls end_test and exit 1, which terminates the
test immediately on error.

Switch log() from echo to echo -e so the ANSI escape sequences
in the color variables are actually interpreted.  Where fail()
is preceded by cleanup actions (stop_stalld, signal delivery,
log dumps), move those actions before the fail call since it
does not return.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 38 ++++++++++++-----------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 53de276..12b548e 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -45,7 +45,7 @@ log() {
 	local message="$*"
 
 	# Echo to stdout with timestamp
-	echo "${timestamp} ${message}"
+	echo -e "${timestamp} ${message}"
 
 	# Also send to journal with stalld tag for easy correlation
 	# Strip ANSI color codes before sending to journal
@@ -418,8 +418,7 @@ start_stalld() {
 		stalld_bin="../stalld"
 	fi
 	if [ ! -x "${stalld_bin}" ]; then
-		echo -e "${RED}ERROR: stalld binary not found at ${stalld_bin}${NC}"
-		return 1
+		fail "stalld binary not found at ${stalld_bin}"
 	fi
 
 	# Parse arguments to find pidfile if specified
@@ -485,12 +484,10 @@ start_stalld() {
 		if [ -f "$pidfile" ]; then
 			STALLD_PID=$(cat "$pidfile" 2>/dev/null)
 			if [ -z "${STALLD_PID}" ]; then
-				echo -e "${RED}ERROR: pidfile exists but is empty${NC}"
-				return 1
+				fail "pidfile exists but is empty"
 			fi
 		else
-			echo -e "${RED}ERROR: pidfile was not created within ${timeout} seconds${NC}"
-			return 1
+			fail "pidfile was not created within ${timeout} seconds"
 		fi
 	else
 		# No pidfile - use pgrep with retries
@@ -540,13 +537,11 @@ start_stalld() {
 
 	# Verify we found a PID and it's running
 	if [ -z "${STALLD_PID}" ]; then
-		echo -e "${RED}ERROR: Could not determine stalld PID${NC}"
-		return 1
+		fail "could not determine stalld PID"
 	fi
 
 	if ! process_alive ${STALLD_PID}; then
-		echo -e "${RED}ERROR: stalld PID ${STALLD_PID} is not running${NC}"
-		return 1
+		fail "stalld PID ${STALLD_PID} is not running"
 	fi
 
 	CLEANUP_PIDS+=("${STALLD_PID}")
@@ -676,8 +671,7 @@ wait_for_log_message() {
 	local log_file=$3
 
 	if [ -z "${log_file}" ]; then
-		echo -e "${RED}ERROR: wait_for_log_message requires a log file${NC}"
-		return 1
+		fail "wait_for_log_message requires a log file"
 	fi
 
 	# Process substitution runs tail in the background so bash
@@ -930,8 +924,7 @@ disable_dl_server() {
 		echo "Disabled DL-server for ${cpu_count} CPUs"
 		return 0
 	else
-		echo -e "${RED}ERROR: Failed to disable DL-server${NC}"
-		return 1
+		fail "failed to disable DL-server"
 	fi
 }
 
@@ -980,8 +973,7 @@ disable_rt_throttling() {
 			echo "Disabled RT throttling"
 			return 0
 		else
-			echo -e "${RED}ERROR: Failed to disable RT throttling (need root?)${NC}"
-			return 1
+			fail "failed to disable RT throttling (need root?)"
 		fi
 	else
 		echo -e "${YELLOW}WARNING: /proc/sys/kernel/sched_rt_runtime_us not found${NC}"
@@ -1173,9 +1165,8 @@ start_stalld_with_log() {
 	CLEANUP_PIDS+=("${STALLD_PID}")
 
 	if ! wait_for_stalld_ready "${log_file}" 15; then
-		echo -e "${RED}ERROR: stalld did not initialize within 15s${NC}"
 		stop_stalld
-		return 1
+		fail "stalld did not initialize within 15s"
 	fi
 }
 
@@ -1272,8 +1263,7 @@ init_functional_test() {
 start_starvation_gen() {
 	local starve_bin="${TEST_ROOT}/helpers/starvation_gen"
 	if [ ! -x "${starve_bin}" ]; then
-		echo -e "${RED}ERROR: starvation_gen not found at ${starve_bin}${NC}"
-		return 1
+		fail "starvation_gen not found at ${starve_bin}"
 	fi
 
 	STARVE_LOG="/tmp/stalld_starvgen_$$.log"
@@ -1293,10 +1283,9 @@ start_starvation_gen() {
 	local elapsed=0
 	while [ $elapsed -lt $timeout ]; do
 		if ! process_alive ${STARVE_PID}; then
-			echo -e "${RED}ERROR: starvation_gen exited prematurely${NC}"
 			echo "  Log contents:"
 			cat "${STARVE_LOG}"
-			return 1
+			fail "starvation_gen exited prematurely"
 		fi
 		if grep -q "Press Ctrl+C to stop early" "${STARVE_LOG}" 2>/dev/null; then
 			echo "starvation_gen ready (PID ${STARVE_PID})"
@@ -1306,7 +1295,6 @@ start_starvation_gen() {
 		elapsed=$((elapsed + 1))
 	done
 
-	echo -e "${RED}ERROR: starvation_gen did not become ready within ${timeout}s${NC}"
 	echo "  Log contents:"
 	cat "${STARVE_LOG}"
 	send_signal TERM ${STARVE_PID}
@@ -1314,7 +1302,7 @@ start_starvation_gen() {
 	if process_alive ${STARVE_PID}; then
 		send_signal KILL ${STARVE_PID}
 	fi
-	return 1
+	fail "starvation_gen did not become ready within ${timeout}s"
 }
 
 # Export functions for use in tests
-- 
2.55.0

