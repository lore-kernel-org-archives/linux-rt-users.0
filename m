Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC3A3B7768
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288669; cv=none; b=RuQ3tQtNbbtiYZUBwEluaiPbm5cH2Nvd91Pn5sNbcHkf803xQvBWIPJDBYq9T9PAYu1aBUml7i4SPSk2CpfV/eDmTx0Dgr7AZqJuBRF9CpV2ug8F/G6FDqa5ywYEXSg5MssDeoH5QdaBK1WMUj1ALjmtVSlTHie0zETQPNoNO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288669; c=relaxed/simple;
	bh=ED9qVixypJvb5BgfGE9XbBpYdu1IxXs5Aj9Zna1uSgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQ7Pm41LAuvK+ffYBNdNuQQ9Y6eX76x/23gfzMDBNvZ29BoYELr/vZAA38UvYFA0LxTAcVWlg35rFyiGWZzJKuwgpsCWdIIGSO/Q8wItsEYLAPkGrNfVjkZgl8StnSDnNYqFRlE5lqTjkLzEOrgk/sgm6DmgfCHl/tW3paDMc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSggS30u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSggS30u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXVP663avu/P4yuzCSZaJubehMtX58QoOOTjtf+HS0U=;
	b=MSggS30uTQy2tH3A2aRwFQTV+dEG3NygPq7HojEeCnTajbpXreJTrRBPni6rn5g3J6yPZd
	90cIap5N5AG8+5n/CFPmDcLzlAJlkVdg75RKK926JSAIlcBSYkFStzaq5sBRkcEtbnIvY3
	6MldQcOLD7RcDVs9KEaPhnGBmVLRR34=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-LniaDI9OM7S1f1lM98cupg-1; Mon,
 27 Apr 2026 07:17:40 -0400
X-MC-Unique: LniaDI9OM7S1f1lM98cupg-1
X-Mimecast-MFC-AGG-ID: LniaDI9OM7S1f1lM98cupg_1777288659
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F8FB1800578;
	Mon, 27 Apr 2026 11:17:39 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 115AC180154C;
	Mon, 27 Apr 2026 11:17:36 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 13/23] tests: Add assertions to SCHED_OTHER restoration test
Date: Mon, 27 Apr 2026 08:16:15 -0300
Message-ID: <20260427111632.24500-14-wander@redhat.com>
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

Test 3 in the boost restoration suite creates a SCHED_OTHER blockee
but never verifies that the scheduling policy is actually restored
after boosting. It waits for starvation_gen to complete and has a
comment about checking the result, but no pass or fail call exists.

Add proper verification by tracking the starved child PID, waiting
for the boost to occur and expire, then checking that the policy
returns to SCHED_OTHER.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_boost_restoration.sh | 37 +++++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_boost_restoration.sh b/tests/functional/test_boost_restoration.sh
index 09dbb60..63e2bc3 100755
--- a/tests/functional/test_boost_restoration.sh
+++ b/tests/functional/test_boost_restoration.sh
@@ -244,12 +244,39 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -t $threshold -c ${TEST_CPU} -a ${ST
 log "Creating SCHED_OTHER starvation (RT blocker prio 80, SCHED_OTHER blockee)"
 start_starvation_gen -c ${TEST_CPU} -p 80 -o -n 1 -d 20
 
-# Wait for starvation_gen to complete
-log "Waiting for starvation test to complete..."
-wait ${STARVE_PID} 2>/dev/null || true
+# Find the starved SCHED_OTHER task
+tracked_pid=$(find_starved_child "${STARVE_PID}")
+
+if [ -n "${tracked_pid}" ]; then
+    initial_policy=$(get_sched_policy ${tracked_pid})
+    log "Tracking task PID ${tracked_pid}, initial policy: ${initial_policy} (expected: 0=SCHED_OTHER)"
+
+    # Wait for boost
+    log "Waiting for starvation detection and boost..."
+    if wait_for_boost_detected "${STALLD_LOG}"; then
+        pass "SCHED_OTHER task boosted"
+
+        # Wait for boost to expire and policy to be restored
+        sleep $((boost_duration + 1))
 
-# Check if blockee completed (proves SCHED_OTHER → boost → SCHED_OTHER restoration worked)
-# The starvation_gen output will show if blockees completed
+        if [ -f "/proc/${tracked_pid}/sched" ]; then
+            final_policy=$(get_sched_policy ${tracked_pid})
+            log "Policy after boost: ${final_policy}"
+
+            if [ "$final_policy" = "0" ]; then
+                pass "Policy restored to SCHED_OTHER (0)"
+            else
+                fail "Policy not restored to SCHED_OTHER (got ${final_policy})"
+            fi
+        else
+            log "⚠ INFO: Task exited before restoration check"
+        fi
+    else
+        fail "No boost detected for SCHED_OTHER task"
+    fi
+else
+    log "⚠ WARNING: Could not find starved task to track"
+fi
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
-- 
2.53.0

