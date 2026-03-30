Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74C394492
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899956; cv=none; b=B3TZxVW1ZlpT8hMHfejGYXGdHXOSFbkaTXR4f2EtqFLsLbB9V4CBWFI/K8GrLV+jrKYc4isMv6AGGYbZkCWaxNL/JIjT+WoazrKxOq89cE6Ytht7xJIIM3rGbpXZhb3tklccR3k7uJmP+9wh99/jY7ApssRnpShtMx3Ko/xp4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899956; c=relaxed/simple;
	bh=AwDg5kfLO8AC84YnWI8ZbbouLpPb0YHz00YNWV0nyDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRuS9XvP3amI14gSx3D5v5Nlm/vO74vRFK/buITbR4LgvB95ot9mHroNlnFSgmpoNmQAVXpHiemqqMx7EW0HH9W7rRLfg70Dv7WXehTgMNept4A4WXoQq8NwVfs9sMdoexKQZ52LCPKllSVym2UR7iop0bBDcz9P2mGR9chBNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMLXFrcC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMLXFrcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6R+lrTD1+yIvsXVY/Fr9slvXDwBctOpHlf67DL7dR8=;
	b=dMLXFrcC13mXuJYlkRziu2EEiUZk/U8Oek0OAaV7/+fGY4blVsUzoHPyxKokW/wsfy8js4
	F4+RTHN347JmWkExByIpFwauFCZ1825AJoNxKpJsIvCCwJOhFb+cz/qtPgYgaULwOB56MI
	PEVsOM/KSWxptU0KU/2fuKFU1ofAAAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-PiqU3u_pPAOJzXEdCmh__g-1; Mon,
 30 Mar 2026 15:45:49 -0400
X-MC-Unique: PiqU3u_pPAOJzXEdCmh__g-1
X-Mimecast-MFC-AGG-ID: PiqU3u_pPAOJzXEdCmh__g_1774899948
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 341D918005B2;
	Mon, 30 Mar 2026 19:45:48 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D1AE1954102;
	Mon, 30 Mar 2026 19:45:45 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 22/36] tests/functional: Use start_stalld_with_log() in test_log_only
Date: Mon, 30 Mar 2026 16:43:45 -0300
Message-ID: <20260330194410.103953-23-wander@redhat.com>
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

Replace manual stalld invocation with start_stalld_with_log(),
which handles backend selection, PID tracking, and event-driven
readiness detection internally.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_log_only.sh | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/tests/functional/test_log_only.sh b/tests/functional/test_log_only.sh
index 655560c..ba72b8e 100755
--- a/tests/functional/test_log_only.sh
+++ b/tests/functional/test_log_only.sh
@@ -52,28 +52,7 @@ STARVGEN_PID=${STARVE_PID}
 
 # Start stalld in log-only mode with verbose output to capture logs
 echo "Starting stalld in log-only mode with 5 second threshold"
-
-# Build stalld command with backend option if specified
-STALLD_ARGS="-f -v -l -t 5 -c ${TEST_CPU} -a ${STALLD_CPU}"
-if [ -n "${STALLD_TEST_BACKEND}" ]; then
-	STALLD_ARGS="-b ${STALLD_TEST_BACKEND} ${STALLD_ARGS}"
-	echo "Using backend: ${STALLD_TEST_BACKEND}"
-fi
-
-${TEST_ROOT}/../stalld ${STALLD_ARGS} > "${LOG_FILE}" 2>&1 &
-STALLD_PID=$!
-CLEANUP_PIDS+=("${STALLD_PID}")
-sleep 2
-
-# Verify stalld is running
-if ! assert_process_running "${STALLD_PID}" "stalld should be running"; then
-	echo "Failed to start stalld, aborting test"
-	echo "Log contents:"
-	cat "${LOG_FILE}"
-	end_test
-	exit 1
-fi
-echo "stalld started with PID ${STALLD_PID}"
+start_stalld_with_log "${LOG_FILE}" -f -v -l -t 5 -c ${TEST_CPU} -a ${STALLD_CPU}
 
 echo "Starvation generator started (PID ${STARVGEN_PID})"
 echo "Waiting for starvation detection..."
-- 
2.53.0

