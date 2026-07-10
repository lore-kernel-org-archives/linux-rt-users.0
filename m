Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6243313E00
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690766; cv=none; b=iuOBAe3txUOYEl0SqfbDoXr4EOmdC20pETBPZjhjNRY1kjcIY2edodfGMSJJPd0XlPUIPgJ8TOzG8+/jW11W1JBnDmhrOPLCV3XKUIW1lD39jgSsuUCbKKwY2HoFITEnlwHT6czhZtroMT2cparYY/tI0DnlbTKy5WsXwJ1WZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690766; c=relaxed/simple;
	bh=kSgjzg9Ywszba++2EXz50r5Sg45ZIKyzNFH+knYgOHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+vfaPggALvaC+CSu3quxmRmVa2H7LW55Sacj0tH+KvfjTSodXtv8EKw5dOtEy5KBFq+xxASWZttNcdpTAhN8ISPVjvrdUqqI7XKX0mv4fr4YPYHdjQdmMPLOfrS3Fb4GF3gd+MRxUDe3og419ga3AERWxY/gaYGz3b+ODLZSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rf8WOCbs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf8WOCbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4iB4FqdVxkvYA3PzAeyDuO6GPQfcdEWLTRfK7ZZrbw=;
	b=Rf8WOCbsK5+dLi6nxeWB0WqUgbXQGUOaCmm1x3rtRp9QCZI4O00U3nR4mxaulPZqsHg+20
	HbN5RILfM4dTPuLmOEhAiehU9xl8QXZtK/YWZMLyaaFMD2YBVltd+6y6mc1ZkKD3cnBCuI
	vBsPV7LS7+QypXFlqNzphcPKj4C70sU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-Fy_jJ5McNDWrvDH77xxfxQ-1; Fri,
 10 Jul 2026 09:39:18 -0400
X-MC-Unique: Fy_jJ5McNDWrvDH77xxfxQ-1
X-Mimecast-MFC-AGG-ID: Fy_jJ5McNDWrvDH77xxfxQ_1783690756
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A62C318009C8;
	Fri, 10 Jul 2026 13:39:16 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92840195608E;
	Fri, 10 Jul 2026 13:39:14 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 10/11] tests: add startup timing to stalld launch helpers
Date: Fri, 10 Jul 2026 10:38:09 -0300
Message-ID: <20260710133810.72398-11-wander@redhat.com>
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

Instrument start_stalld and start_stalld_with_log to measure and log
the elapsed time from process launch to readiness.  Both functions
capture nanosecond timestamps via date +%s%N before and after the
startup sequence, compute the elapsed seconds with awk, and report
the result through log().

The echo in start_stalld is converted to log() for consistency with
the rest of the test framework.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 85b1805..9222d07 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -459,6 +459,8 @@ start_stalld() {
 		esac
 	fi
 
+	local start_ns=$(date +%s%N)
+
 	${stalld_bin} ${args} &
 	local shell_pid=$!
 
@@ -537,7 +539,9 @@ start_stalld() {
 	fi
 
 	CLEANUP_PIDS+=("${STALLD_PID}")
-	echo "stalld started with PID ${STALLD_PID}"
+	local end_ns=$(date +%s%N)
+	local elapsed=$(awk "BEGIN {printf \"%.3f\", (${end_ns} - ${start_ns}) / 1000000000}")
+	log "stalld started with PID ${STALLD_PID} (startup: ${elapsed}s)"
 	return 0
 }
 
@@ -1152,6 +1156,8 @@ start_stalld_with_log() {
 
 	# Start stalld with line-buffered output so tail -f can detect
 	# readiness immediately instead of waiting for the buffer to fill.
+	local start_ns=$(date +%s%N)
+
 	stdbuf -oL ${TEST_ROOT}/../stalld ${stalld_args} > "${log_file}" 2>&1 &
 	STALLD_PID=$!
 	CLEANUP_PIDS+=("${STALLD_PID}")
@@ -1162,6 +1168,10 @@ start_stalld_with_log() {
 		stop_stalld
 		fail "stalld did not initialize within 15s"
 	fi
+
+	local end_ns=$(date +%s%N)
+	local elapsed=$(awk "BEGIN {printf \"%.3f\", (${end_ns} - ${start_ns}) / 1000000000}")
+	log "stalld ready (PID ${STALLD_PID}, startup: ${elapsed}s)"
 }
 
 # Wait for scheduling policy to change to expected value
-- 
2.55.0

