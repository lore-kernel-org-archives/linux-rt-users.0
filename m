Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D5347FE1
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899918; cv=none; b=sMhb+dh4s0AV12QvRBmuma6SvDyArOag0KjFJq7uIkzZsLZ/M7EM+EOfSgcPGjvzNsYlHqVLnlAzLq+ho2sBCmp8rbvi1e7ugyYEL2uPAF8ZyGmRns7c+9oc4vhZC9GdwjBFwbeXufFbLMzQOjdUqbk43shiGFuE36CEGF9QDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899918; c=relaxed/simple;
	bh=VIi2yj8iBCwJKUl0vShWCiPWYhAmgqk+ZkY1FhYb/Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU9wZTYCM5JHzu3OMrPejr7DFvNEqn7RGN88NAmQbw0OIYG0V1BSpt0LTgRSnrPkZROd2eQclRUENXpzfkW45XlRXNsH1u1DLBGs5XN+7DH5Hj+ZQTnXhfslTw4W1AIIcslvVSqlJR0YimemNEAOYJvzw90YI3/K9PHJCcanj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVc9Ui2V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVc9Ui2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxh6uWipIPsvOHzaHBGLhle5UibwvpSuCH8NAd07yFQ=;
	b=YVc9Ui2VHLTbWGBPpwRpG9NGZRMrFOU5oo24TSC/B1B7fdYw6GnB9TjyoZUEVdDBJj0Vwn
	pIu4r2UW0Fmdxz3dIvO6EeAIA6SGHrdY9WGKzdHnqCGCJ5ruEiO8hBiL20OohXo8KVbzyD
	UcbhyODSb3IVv9HT+YE5/qvFviQ+0PM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-Ezi3dSVOMSy299nxMk300Q-1; Mon,
 30 Mar 2026 15:45:12 -0400
X-MC-Unique: Ezi3dSVOMSy299nxMk300Q-1
X-Mimecast-MFC-AGG-ID: Ezi3dSVOMSy299nxMk300Q_1774899911
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74D2218005B3;
	Mon, 30 Mar 2026 19:45:11 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9DBA19539A0;
	Mon, 30 Mar 2026 19:45:08 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 11/36] tests/functional: Fix false positive log matching in test_logging_destinations
Date: Mon, 30 Mar 2026 16:43:34 -0300
Message-ID: <20260330194410.103953-12-wander@redhat.com>
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

The test framework's log() function sends entries to the system
journal tagged with [stalld] via logger -t stalld. The logging
destination tests were using grep "stalld" to verify daemon
output in dmesg, syslog, and journalctl, which also matched
these framework entries and caused false passes.

Add a local has_stalld_log() filter function that matches
"stalld" while excluding lines containing "stalld". Use grep -F
for fixed-string matching throughout to avoid unnecessary regex
interpretation.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_logging_destinations.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index 6fa4907..171be8b 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -21,6 +21,12 @@ setup_test_environment
 # Require root for this test
 require_root
 
+# Filter stdin for stalld daemon messages, excluding the test
+# framework's own log entries tagged with [TEST].
+has_stalld_log() {
+	grep -F "stalld" | grep -Fqv "[TEST]"
+}
+
 # Test 1: Verbose mode (-v) logs to stdout/stderr
 echo "Test 1: Verbose mode (-v) logs to stdout"
 
@@ -74,7 +80,7 @@ if command -v dmesg >/dev/null 2>&1; then
 		# Note: This might not work in all environments
 		if [ ${DMESG_AFTER} -gt ${DMESG_BEFORE} ]; then
 			# Check if recent dmesg contains stalld messages
-			if dmesg | tail -10 | grep -q "stalld"; then
+			if dmesg | tail -10 | has_stalld_log; then
 				assert_equals "1" "1" "stalld messages in kernel log"
 			else
 				echo -e "  ${YELLOW}SKIP${NC}: cannot verify kernel log messages"
@@ -113,7 +119,7 @@ if [ -n "${SYSLOG_FILE}" ]; then
 
 		if [ ${SYSLOG_AFTER} -gt ${SYSLOG_BEFORE} ]; then
 			# Check for stalld messages in recent syslog
-			if tail -20 "${SYSLOG_FILE}" | grep -q "stalld"; then
+			if tail -20 "${SYSLOG_FILE}" | has_stalld_log; then
 				assert_equals "1" "1" "stalld messages in syslog"
 			else
 				echo -e "  ${YELLOW}SKIP${NC}: no stalld messages found in syslog"
@@ -133,9 +139,9 @@ elif command -v journalctl >/dev/null 2>&1; then
 
 	if assert_process_running "${STALLD_PID}" "stalld with -s should be running"; then
 		# Check journalctl for stalld messages
-		if journalctl -u stalld --since "1 minute ago" 2>/dev/null | grep -q "stalld"; then
+		if journalctl -u stalld --since "1 minute ago" 2>/dev/null | has_stalld_log; then
 			assert_equals "1" "1" "stalld messages in journalctl"
-		elif journalctl --since "1 minute ago" 2>/dev/null | grep -q "stalld"; then
+		elif journalctl --since "1 minute ago" 2>/dev/null | has_stalld_log; then
 			assert_equals "1" "1" "stalld messages in system journal"
 		else
 			echo -e "  ${YELLOW}SKIP${NC}: no stalld messages in journal (may take time to appear)"
-- 
2.53.0

