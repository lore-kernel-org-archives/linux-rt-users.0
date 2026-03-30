Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDD39A070
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899932; cv=none; b=oGOJ5oPvNqwgdWrdPoQaHRXkNXlf7y1jWKabUdmhX0zX7XiSutkQkZRBGNXSVfjeQh6Gn4GR/kCKSzPN/gaDUoALx7jV4qwStPZoB94x7c1n9oYWb2RiG4nUdlYZ3eV+DruN/co+dZKkDEQy6GNrg1zT5TX6CppP9qEiJryblkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899932; c=relaxed/simple;
	bh=lQCrM2tjyrhXU7e1fQfvJLM3InmwFpJwF+kp3T/kXF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eF0K9KyE8r2nyiIR+T25Za7YATRb8hTAbXRAxbMk9xSq/5D2g+aJKatl5KITiFKmoxzF8b5OO1MzLy/ii+c5rTPJwppFFN+cBk0OPiGDrQElsEC8NQW2hsIXMlnrRjVOfX9fOY5BGT7kttUk/9NcdyfrGDYcp2JPorBc3uCa6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7I9Wv2W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7I9Wv2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsYXpp+DUzNUOqpjVXWBo3OPXRFD4n09HWLrewWQuN8=;
	b=h7I9Wv2WP9CAaKs0Da9yX3f7Ig8QJtsmadycpNTh6d+XE9wNvNJWUQBjkPZaAl/+4aJy5d
	rrj5hKBMCVrKCBgYy7HNARbYSFUDoMB+l+/er5eiOozYper8IzNsiwsQ+zKvCJ4vkGyKYV
	c/0YXXSUjSjocp4ctzB9bQ1mr3OGOnk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-OqLT_SH5P7CoEGIAhloaPA-1; Mon,
 30 Mar 2026 15:45:28 -0400
X-MC-Unique: OqLT_SH5P7CoEGIAhloaPA-1
X-Mimecast-MFC-AGG-ID: OqLT_SH5P7CoEGIAhloaPA_1774899927
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94E18180049D;
	Mon, 30 Mar 2026 19:45:27 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E18E119540C4;
	Mon, 30 Mar 2026 19:45:24 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 16/36] tests/helpers: Add start_starvation_gen() helper function
Date: Mon, 30 Mar 2026 16:43:39 -0300
Message-ID: <20260330194410.103953-17-wander@redhat.com>
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

Tests currently launch starvation_gen in the background and sleep
1-2 seconds hoping all threads are created and pinned. This is
non-deterministic and wastes time.

Add start_starvation_gen() that redirects starvation_gen stdout to
a log file and polls for the "Press Ctrl+C to stop early\n" message
emitted after all threads pass the pthread barrier. A brief initial
sleep covers the fast path, then the function falls back to
1-second polling with a 10-second timeout. On timeout, the process
is killed with SIGTERM and escalated to SIGKILL if it does not exit
within one second. The function sets STARVE_PID and STARVE_LOG for
test use and tracks both in CLEANUP_PIDS and CLEANUP_FILES.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 58 ++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 06c0471..276ffe8 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -1045,6 +1045,62 @@ init_functional_test() {
 	export TEST_CPU STALLD_CPU STARVE_GEN STALLD_LOG
 }
 
+# Start starvation_gen in background with readiness detection
+# Launches starvation_gen, redirects its stdout to a log file, and polls
+# for the "ready" message that starvation_gen prints after all threads
+# have passed the pthread barrier and are actively running/starving.
+#
+# Usage: start_starvation_gen [starvation_gen_args...]
+# Sets: STARVE_PID, STARVE_LOG
+# Example: start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d 15
+start_starvation_gen() {
+	local starve_bin="${TEST_ROOT}/helpers/starvation_gen"
+	if [ ! -x "${starve_bin}" ]; then
+		echo -e "${RED}ERROR: starvation_gen not found at ${starve_bin}${NC}"
+		return 1
+	fi
+
+	STARVE_LOG="/tmp/stalld_starvgen_$$.log"
+	CLEANUP_FILES+=("${STARVE_LOG}")
+
+	"${starve_bin}" "$@" > "${STARVE_LOG}" 2>&1 &
+	STARVE_PID=$!
+	CLEANUP_PIDS+=("${STARVE_PID}")
+
+	# Poll for "ready" message with timeout
+	# starvation_gen prints "ready" after all threads pass the barrier.
+	# Brief initial sleep covers the fast path, then 1-second polling
+	# for slow/loaded systems.
+	sleep 0.01
+
+	local timeout=10
+	local elapsed=0
+	while [ $elapsed -lt $timeout ]; do
+		if ! kill -0 ${STARVE_PID} 2>/dev/null; then
+			echo -e "${RED}ERROR: starvation_gen exited prematurely${NC}"
+			echo "  Log contents:"
+			cat "${STARVE_LOG}"
+			return 1
+		fi
+		if grep -q "Press Ctrl+C to stop early" "${STARVE_LOG}" 2>/dev/null; then
+			echo "starvation_gen ready (PID ${STARVE_PID})"
+			return 0
+		fi
+		sleep 1
+		elapsed=$((elapsed + 1))
+	done
+
+	echo -e "${RED}ERROR: starvation_gen did not become ready within ${timeout}s${NC}"
+	echo "  Log contents:"
+	cat "${STARVE_LOG}"
+	kill ${STARVE_PID} 2>/dev/null
+	sleep 1
+	if kill -0 ${STARVE_PID} 2>/dev/null; then
+		kill -9 ${STARVE_PID} 2>/dev/null
+	fi
+	return 1
+}
+
 # Export functions for use in tests
 export -f start_test end_test
 export -f assert_equals assert_contains assert_not_contains
@@ -1061,5 +1117,5 @@ export -f save_dl_server restore_dl_server disable_dl_server
 export -f setup_test_environment
 export -f get_num_cpus get_online_cpus pick_test_cpu
 export -f log get_sched_policy get_sched_priority get_nice_value get_ctxt_switches
-export -f start_stalld_with_log wait_for_policy_change
+export -f start_stalld_with_log start_starvation_gen wait_for_policy_change
 export -f calculate_detection_timeout init_functional_test
-- 
2.53.0

