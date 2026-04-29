Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEB1E25F9
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Apr 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474177; cv=none; b=nktCpsfHKH12KPuvZ2h17SmcVIixtEykKnnBm3EtbImAPE/ghVWkBmDlEE0n2Tu9xYmmF4nalwFqPW0m+RGsMVaK3J5Iq3irsH6NOsJE5zRHWrh5xf1E9t/asEUfAdNtgQZvbPgSeew5y+4qlVrHoBIeb3F5RwkhLb387orncv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474177; c=relaxed/simple;
	bh=AspO6rsNmUDmlSFe4QcwTMHxdNq0ZnDhpiPdGcSJlh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUpp+AXu+pA17SqpUW8FOruX1ooLN4vLq9kIvXSVgo7nkvjf04/ynDU6TKAHlYahguJ6gNAUtMo/Q2csNpFg7DEQPyACDzFDC2d8bm9mOMJ0vh1FH6uE7kWzfbVLS+r/DfSWtAkEBnmbxgdFa9YGjo91hzhkyAxOmgu8QqwPXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXRqnjEm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXRqnjEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777474175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VGVssg+KpFJ0KuuH5v+QxxBEtohxoearawcXmQQCMnw=;
	b=PXRqnjEmM7vYHD83NUh3QkURN0L3C7eeGSKF1l7dHLwZKmr1NN/iAi+8S5djMid5DREcwl
	RHmvA72q2BE6m4/W98W+MlBMESU01k+jAQ03yQaNkuI86zgemBxHSY6287KWlMndEtr3sw
	rzO46ssAQCw7Wy7lVU1rDV0tRBSvGcA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-Tvh7vSXmNcuyy3KCnSsaGA-1; Wed,
 29 Apr 2026 10:49:29 -0400
X-MC-Unique: Tvh7vSXmNcuyy3KCnSsaGA-1
X-Mimecast-MFC-AGG-ID: Tvh7vSXmNcuyy3KCnSsaGA_1777474168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1975E1800347;
	Wed, 29 Apr 2026 14:49:28 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.64.209])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E3EE1800347;
	Wed, 29 Apr 2026 14:49:25 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] stalld: make syslog logging opt-in by default
Date: Wed, 29 Apr 2026 11:49:21 -0300
Message-ID: <20260429144921.122788-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Previously, stalld enabled syslog output unconditionally with no
mechanism to disable it. Users running the daemon from the command
line with verbose logging directed to standard error would still
generate unwanted syslog traffic.

Change the default behavior to make syslog logging strictly opt-in via
the existing command line flag, aligning it with the opt-in nature of
other logging destinations. Update the systemd service configuration
to explicitly pass this flag, ensuring that default systemd
deployments retain their current logging behavior. Finally, introduce
a functional test to verify that syslog remains silent when the flag
is omitted.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.c                                  |  2 +-
 systemd/stalld.conf                           |  2 +-
 tests/functional/test_logging_destinations.sh | 42 +++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index d95b48f..a6444f5 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -48,7 +48,7 @@ const char *version = VERSION;
  */
 int config_verbose = 0;
 int config_write_kmesg = 0;
-int config_log_syslog = 1;
+int config_log_syslog = 0;
 int config_log_only = 0;
 int config_foreground = 0;
 
diff --git a/systemd/stalld.conf b/systemd/stalld.conf
index a2a6737..a17c360 100644
--- a/systemd/stalld.conf
+++ b/systemd/stalld.conf
@@ -51,7 +51,7 @@ THRESH="-t 20"
 #     --log_syslog
 #     or Nothing (default)
 # ex: LOGONLY=--log_only
-LOGGING=
+LOGGING=--log_syslog
 
 # Run in the foreground
 # ex: FG=--foreground
diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index a25e571..db64760 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -144,4 +144,46 @@ assert_success "combined logging produces output" test -s "${LOG_FILE}"
 
 stop_stalld
 
+# Test 5: No syslog without -s flag
+test_section "Test 5: No syslog without -s flag"
+
+if [ -n "${SYSLOG_FILE}" ]; then
+	SYSLOG_BEFORE=$(wc -l < "${SYSLOG_FILE}")
+
+	start_stalld -f -l -t 5
+	sleep 1
+
+	SYSLOG_AFTER=$(wc -l < "${SYSLOG_FILE}")
+
+	if [ ${SYSLOG_AFTER} -gt ${SYSLOG_BEFORE} ]; then
+		LINES_ADDED=$((SYSLOG_AFTER - SYSLOG_BEFORE))
+		if tail -n "${LINES_ADDED}" "${SYSLOG_FILE}" | has_stalld_log; then
+			fail "stalld messages found in syslog without -s flag"
+		else
+			pass "no stalld messages in syslog without -s flag"
+		fi
+	else
+		pass "no new messages in syslog (stalld stayed quiet)"
+	fi
+
+	stop_stalld
+elif command -v journalctl >/dev/null 2>&1; then
+	log "Using journalctl instead of syslog file"
+
+	START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
+
+	start_stalld -f -l -t 5
+	sleep 1
+
+	if journalctl -t stalld --since "${START_TIME}" 2>/dev/null | has_stalld_log; then
+		fail "stalld messages found in journal without -s flag"
+	else
+		pass "no stalld messages in journal without -s flag"
+	fi
+
+	stop_stalld
+else
+	log "SKIP: neither syslog nor journalctl available"
+fi
+
 end_test
-- 
2.54.0

