Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32A3E3141
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285723; cv=none; b=KiTlPeGAcOZLBbaaaXnjPPKhbWS5DdocfBu/7Iqmo3mDyvmaWZL/2yfIFPmMSUWWckdDlbViOMwWZS8CrR71bYVZ4vU6BsuQJI3Wi9mXIBJsGiBLwmRmtMabJutfcuVCZjj2VFf8oAOOIVfOC0wvGtSr4LU13nMw8yyWg257EDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285723; c=relaxed/simple;
	bh=EAkTI22mtG4a9nKnVMsOLg/a3fO+q42pv/VyScmg8tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5GV8GdrPIR9n+v4zt/RYqR3b9rP2KZSnxZahryAngbizCopngUcupDEaUxceLYEcT4WXqu3CoRczM5t71uYnaobijoJapD9elmWMIYsVeFjaNo7EdmV0rXP7D6JyhJC2eje9YNux8t0BxXcE2ThSC1KCM3mSXVTz+rG61lzQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJjRTH6x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJjRTH6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0J72Gzt0591UFQD54S+q8gUZCzf34VeW0g4CSjJY51o=;
	b=iJjRTH6xCIi+EML0/J1m+aCrnO9+9Sl/4p866ex67CMHRG0ebuNFzW+fY1Qw6VCb/4VZJz
	ZTwWvpkTr3hZhHZ6vu+qycsLXkdOimm1rYBjUH/Ds8hIWrZ6zeM4VgnDQZ+1Nmh4MOHrUK
	973OUrhdfBKkbaorUsOvXhX5gAmJsts=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-wfrZueFsN2O9CQ2CUbFBuw-1; Wed,
 20 May 2026 10:01:52 -0400
X-MC-Unique: wfrZueFsN2O9CQ2CUbFBuw-1
X-Mimecast-MFC-AGG-ID: wfrZueFsN2O9CQ2CUbFBuw_1779285710
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9877218002FA;
	Wed, 20 May 2026 14:01:50 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 311891800465;
	Wed, 20 May 2026 14:01:47 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 13/33] tests: Add assertions to SCHED_OTHER restoration test
Date: Wed, 20 May 2026 11:00:40 -0300
Message-ID: <20260520140104.112142-14-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
2.54.0

