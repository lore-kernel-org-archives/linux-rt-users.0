Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B337B02D
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288658; cv=none; b=bkaRZg1GfCBQXCiDw3/Q+HRwFWooP+y29jhDznsIdiT22oTO+BgzuPxhpk51bL0LHinWxLau1jhssAeM8P0f33K5yP/hTDDKZJPLm+Dv8DpycXZ10zY514e2l/WO8t3xj9E4qTU+QH0FTgD4//GVT7/7bUZHXSA/ChN9c7ajz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288658; c=relaxed/simple;
	bh=Na+yeS1r2a4k7AguqHjByvNaOBHHf/ZEwGSGLBtwcHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpsaSiSwaLnZUiQgOiCsE1D3Bw388hGYKg8Xg9YgGNLhVqJjXvk0Ios3LSgO05GT3vyn04qdC4bn3GT+uHWGlC6PdyDMq6ih14fcoLSVM6BlCgcTp8JffXy3TPGxxIJWKJnjrRZjZ7WM8Z9DBwKCEAiqsj5zXM5bkBsets8vjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXX/j2/5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXX/j2/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mK3SWUtuNxCL0oeZZrP2fZblTstO3PV0Gbbb06veJ84=;
	b=QXX/j2/50SHhHlHr4UhZS6SAcT7vcAmzd32+1h+XWLPtLjlWWWGdXf6Ly8S5OeveBlYTM6
	K2B9MBzNCJJNouXsQHHA0sgghubfbiSzXeBfCUcIYmNs8UK3s0fPRIN3s2S7N7dOjJmvy4
	enhZI5nKwaUP3lzGOU1wy8DXSYovJGU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-XH0WnNGFMQW7GBxQuNmJUw-1; Mon,
 27 Apr 2026 07:17:32 -0400
X-MC-Unique: XH0WnNGFMQW7GBxQuNmJUw-1
X-Mimecast-MFC-AGG-ID: XH0WnNGFMQW7GBxQuNmJUw_1777288651
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 304141800473;
	Mon, 27 Apr 2026 11:17:31 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17962180047F;
	Mon, 27 Apr 2026 11:17:28 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 10/23] tests: Fix subshell swallowing test results
Date: Mon, 27 Apr 2026 08:16:12 -0300
Message-ID: <20260427111632.24500-11-wander@redhat.com>
In-Reply-To: <20260427111632.24500-1-wander@redhat.com>
References: <20260427111632.24500-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Test 5 in the starvation detection suite runs its assertions inside
a backgrounded subshell. The pass and fail functions increment the
TEST_PASSED and TEST_FAILED counters, but since those variables are
copied into the subshell, the increments are discarded when the child
exits. The test result is silently lost regardless of outcome.

Remove the subshell wrapper and run the test logic directly in the
main shell. Also replace the else branch, which logged informational
messages but never called pass or fail, with an actual check that
greps for the busy task PID in the starvation log to distinguish
false positives from unrelated starvation events.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_starvation_detection.sh | 35 ++++++++-----------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index d8f874a..44024c7 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -241,31 +241,26 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a $
 # Create a task that gets CPU time but isn't starved
 # Use a SCHED_OTHER task with lower priority that still gets scheduled
 log "Creating a busy task that should NOT be starved"
-(
-    taskset -c ${TEST_CPU} bash -c 'for i in {1..100}; do sleep 0.1; done' &
-    BUSY_PID=$!
+taskset -c ${TEST_CPU} bash -c 'for i in {1..100}; do sleep 0.1; done' &
+BUSY_PID=$!
 
-    # Wait beyond threshold
-    sleep $((threshold + 3))
+# Wait beyond threshold
+sleep $((threshold + 3))
 
-    # Verify this task was NOT reported as starved
-    # Since it's making progress, stalld shouldn't detect it
-    if ! grep "starved" "${STALLD_LOG}"; then
-        pass "No false positive - task making progress not reported as starved"
+# Verify this task was NOT reported as starved
+# Since it's making progress, stalld shouldn't detect it
+if ! grep "starved" "${STALLD_LOG}"; then
+    pass "No false positive - task making progress not reported as starved"
+else
+    if grep "${BUSY_PID}" "${STALLD_LOG}" | grep -q "starved"; then
+        fail "False positive - progress-making task ${BUSY_PID} reported as starved"
     else
-        # Check if our specific task was reported
-        log "Log shows starvation, checking if it's our progress-making task..."
-        log "Log contents:"
-        cat "${STALLD_LOG}"
-        # This is not necessarily a failure - there might be other starved tasks
-        log "⚠ INFO: Starvation detected, but may be from other tasks"
+        pass "No false positive - starvation detected from other tasks, not ours"
     fi
+fi
 
-    kill ${BUSY_PID} 2>/dev/null
-    wait ${BUSY_PID} 2>/dev/null
-) &
-SUBSHELL_PID=$!
-wait ${SUBSHELL_PID}
+kill ${BUSY_PID} 2>/dev/null
+wait ${BUSY_PID} 2>/dev/null
 
 stop_stalld
 
-- 
2.53.0

