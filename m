Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E413397686
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899988; cv=none; b=mEYZc/4lLGQ6BENL4banrRaee5d+YQiov1HB3mRWzNaWXiZixFbZui2uTFJTnvQ+MiYIW7VD+BZugATP6vyOUK4N0aOu2wBDfGnPyxJQT6dxVtodNoHqKMp4CuCbb5QOiJz122cvzjgfSlvYD0SgpjFwHdBQh5vGMIHUrtL+ELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899988; c=relaxed/simple;
	bh=OaT7O2/Gj6qpBuNy8J082lQKNp9QFU5QGQ6BFs4iUaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXOCpHdx8r3TLW2kT4sVb4aVVVT8I3gp+tOCn+NKcT1cBDK+xPFyaRepdSMKfxPITrU+bgjP8225k0f9sW/mZloZN6UO8dNtF7BFWOJ2UtOy+wJrhbDueYG/cgdPvI+C4s7yd+w3bXE1W5X9k/WqPJl3yhc7LnlDo29x1N2W/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MA1rAOos; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MA1rAOos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPNRL/oIifaYj+lBnL1aBAvF1PeZoWTGXG6iDReHyiA=;
	b=MA1rAOosj44qx41UWLy46xDE2Iid9WLB2x74mql7tnlIVagmycOrQtrVnKegVWmbD/Qwvg
	HoblCg0HbMqgIp6c/ByCv5W0nZP1Sz26at87gyzFojidbzDVphemayR5YhCY0Pg/J5q5yR
	zUT+VYCob8NlQhhszHCx11oDyTwmmkc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-nNMWzvcNOGaToLvN07TpAA-1; Mon,
 30 Mar 2026 15:46:22 -0400
X-MC-Unique: nNMWzvcNOGaToLvN07TpAA-1
X-Mimecast-MFC-AGG-ID: nNMWzvcNOGaToLvN07TpAA_1774899981
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9829A195608B;
	Mon, 30 Mar 2026 19:46:21 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D90819540C4;
	Mon, 30 Mar 2026 19:46:18 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 32/36] tests/functional: Fix multi-CPU detection in test_starvation_detection
Date: Mon, 30 Mar 2026 16:43:55 -0300
Message-ID: <20260330194410.103953-33-wander@redhat.com>
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

The multi-CPU test greps for "starvation_gen" in the starvation log,
but stalld might detect other starving tasks on the target CPU, such
as kworker threads. Relax the grep to match any task starving on
the expected CPU. To support this, add an optional cpu parameter to
wait_for_starvation_detected() so the test waits for each CPU
independently.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_starvation_detection.sh | 12 +++++-------
 tests/helpers/test_helpers.sh                 |  9 +++++++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 680cf39..6ca2121 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -271,18 +271,16 @@ else
 
     start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${CPU0},${CPU1} -a ${STALLD_CPU_MULTI}
 
-    # Wait for starvation detection
-    log "Waiting for starvation detection..."
-    wait_for_starvation_detected "${STALLD_LOG}"
-
-    # Check both CPUs detected - specifically look for starvation_gen tasks
-    if grep -qE "starvation_gen.*starved on CPU ${CPU0}|starved on CPU ${CPU0}.*starvation_gen" "${STALLD_LOG}"; then
+    # Wait for starvation detection on both CPUs
+    log "Waiting for starvation detection on CPU ${CPU0}..."
+    if wait_for_starvation_detected "${STALLD_LOG}" 30 "${CPU0}"; then
         pass "Starvation detected on CPU ${CPU0}"
     else
         fail "Starvation not detected on CPU ${CPU0}"
     fi
 
-    if grep -qE "starvation_gen.*starved on CPU ${CPU1}|starved on CPU ${CPU1}.*starvation_gen" "${STALLD_LOG}"; then
+    log "Waiting for starvation detection on CPU ${CPU1}..."
+    if wait_for_starvation_detected "${STALLD_LOG}" 30 "${CPU1}"; then
         pass "Starvation detected on CPU ${CPU1}"
     else
         fail "Starvation not detected on CPU ${CPU1}"
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 3a7164d..6e29a3b 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -542,11 +542,16 @@ wait_for_stalld_ready() {
 
 # Wait for stalld to detect a starving task.
 #
-# Usage: wait_for_starvation_detected <log_file> [timeout]
+# Usage: wait_for_starvation_detected <log_file> [timeout] [cpu]
 wait_for_starvation_detected() {
 	local log_file=$1
 	local timeout=${2:-30}
-	wait_for_log_message "starved on CPU" "${timeout}" "${log_file}"
+	local cpu=${3:-}
+	local pattern="starved on CPU"
+	if [ -n "${cpu}" ]; then
+		pattern="starved on CPU ${cpu}"
+	fi
+	wait_for_log_message "${pattern}" "${timeout}" "${log_file}"
 }
 
 # Wait for stalld to boost a starving task.
-- 
2.53.0

