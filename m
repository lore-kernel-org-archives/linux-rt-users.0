Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253D3E2767
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943597; cv=none; b=oJAk400sPdx2KFv8LxMktb4OG5el+ptLhyqlWgfW6Nh0mcktYulZLBiU5O/yxiNCWWJW5xnspbHmIZXUk/Y3bDFeZ9gBWRYwK1Pvsqam6L4QGrUgq0ERZY01uxOoqlS3Cm80jMcqL+piwIJbThG9ZwQ1wUGrhIKKoTgVVsxtv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943597; c=relaxed/simple;
	bh=t1NRlt6tA0usS95urrG86rx7iUri2+0xgLxz5PV5Qkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsayVZIwyUQ0CjfTILDukfufFEIgsetWYO4yhL7Imwwx0hoFZWiqG7b0g6dYagQCNd3BRy1yKJTF9+XwbqplDJ/mRgJITA72WD/aI4TaL7N25O2swcW2eBjpBxepoSEkSreXutdBJFprFvXvIehltAY4OGk7IJ7TWTmmuFbd29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cjm8obqd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cjm8obqd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUPKfS7N0ythEd1uagHaA8ynzZHHb4D6xdvSuWB6cj0=;
	b=Cjm8obqdvdeSTR7ZyDbpNlFjPqrV44fm0D0Ov+48q6478x3+8IpVH6qMLyw6neiXSu+QHo
	VTACdSasv54J1seLgPkoi2hRAeA5BVKxXt2+nu2wLl0x8a9/oYrXA5kytdirwPglkbDsRL
	u/Ubndgg5WT3i3Qa78GJHqGmSlccILE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-qjJGavLPM3eHbEIH1uwFLg-1; Mon,
 08 Jun 2026 14:33:12 -0400
X-MC-Unique: qjJGavLPM3eHbEIH1uwFLg-1
X-Mimecast-MFC-AGG-ID: qjJGavLPM3eHbEIH1uwFLg_1780943591
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D0B6195DE32;
	Mon,  8 Jun 2026 18:33:11 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34DD236927;
	Mon,  8 Jun 2026 18:33:08 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 20/52] tests: Replace wait conditionals with asserts
Date: Mon,  8 Jun 2026 15:31:30 -0300
Message-ID: <20260608183206.140526-21-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Several test files currently use custom conditional blocks to wait for
starvation or boost detection, manually handling success and failure
logging. Replace these verbose conditionals with flat calls to the
existing assert_starvation_detected and assert_boost_detected
helpers. The previously nested log assertions are subsequently moved
to the top level. The assert helpers provide identical behavior by
passing on success or failing and dumping the log on error.

Flattening these blocks deduplicates logic already encapsulated in
the test helpers and removes unnecessary nesting. This refactoring
is a direct prerequisite for introducing fail-fast semantics to the
test framework, where calling fail will immediately terminate the
test.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
---
 tests/functional/test_deadline_boosting.sh       | 12 ++----------
 tests/functional/test_fifo_boosting.sh           | 12 ++----------
 .../functional/test_fifo_priority_starvation.sh  | 16 +++-------------
 tests/functional/test_starvation_detection.sh    | 16 +++-------------
 4 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/tests/functional/test_deadline_boosting.sh b/tests/functional/test_deadline_boosting.sh
index 5f10b48..50e949c 100755
--- a/tests/functional/test_deadline_boosting.sh
+++ b/tests/functional/test_deadline_boosting.sh
@@ -36,16 +36,8 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 # Wait for boosting
 log "Waiting for boost detection..."
-if wait_for_boost_detected "${STALLD_LOG}"; then
-    pass "Boosting occurred"
-
-    # Verify SCHED_DEADLINE was used
-    assert_log_contains "${STALLD_LOG}" "SCHED_DEADLINE" "SCHED_DEADLINE boosting used (default)"
-else
-    fail "No boosting detected"
-    log "Log contents:"
-    cat "${STALLD_LOG}"
-fi
+assert_boost_detected "${STALLD_LOG}" "Boosting occurred"
+assert_log_contains "${STALLD_LOG}" "SCHED_DEADLINE" "SCHED_DEADLINE boosting used (default)"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_fifo_boosting.sh b/tests/functional/test_fifo_boosting.sh
index 8f70c0a..4da1182 100755
--- a/tests/functional/test_fifo_boosting.sh
+++ b/tests/functional/test_fifo_boosting.sh
@@ -34,16 +34,8 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -g 1 -N -F -A -t $threshold -c ${TES
 
 # Wait for boosting
 log "Waiting for boost detection..."
-if wait_for_boost_detected "${STALLD_LOG}"; then
-    pass "Boosting occurred with -F flag"
-
-    # Verify SCHED_FIFO was used
-    assert_log_contains "${STALLD_LOG}" "SCHED_FIFO" "SCHED_FIFO boosting used (as requested by -F)"
-else
-    fail "No boosting detected with -F flag"
-    log "Log contents:"
-    cat "${STALLD_LOG}"
-fi
+assert_boost_detected "${STALLD_LOG}" "Boosting occurred with -F flag"
+assert_log_contains "${STALLD_LOG}" "SCHED_FIFO" "SCHED_FIFO boosting used (as requested by -F)"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index a8d3a31..a4e1a65 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -40,19 +40,9 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -l -t $threshold -c ${TEST_CPU} -a $
 
 # Wait for starvation detection
 log "Waiting for starvation detection..."
-if wait_for_starvation_detected "${STALLD_LOG}"; then
-    pass "FIFO-on-FIFO starvation detected"
-
-    # Verify correct CPU is logged
-    assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU}" "Correct CPU ID logged (CPU ${TEST_CPU})"
-
-    # Verify duration is logged
-    assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU} for [0-9]" "Starvation duration logged"
-else
-    fail "FIFO-on-FIFO starvation not detected"
-    log "Log contents:"
-    cat "${STALLD_LOG}"
-fi
+assert_starvation_detected "${STALLD_LOG}" "FIFO-on-FIFO starvation detected"
+assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU}" "Correct CPU ID logged (CPU ${TEST_CPU})"
+assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU} for [0-9]" "Starvation duration logged"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 943503b..1df6bb0 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -35,19 +35,9 @@ start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -
 
 # Wait for starvation detection
 log "Waiting for starvation detection..."
-if wait_for_starvation_detected "${STALLD_LOG}"; then
-    pass "Starvation detected"
-
-    # Verify correct CPU is logged
-    assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU}" "Correct CPU ID logged (CPU ${TEST_CPU})"
-
-    # Verify duration is logged
-    assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU} for [0-9]" "Starvation duration logged"
-else
-    fail "Starvation not detected"
-    log "Log contents:"
-    cat "${STALLD_LOG}"
-fi
+assert_starvation_detected "${STALLD_LOG}" "Starvation detected"
+assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU}" "Correct CPU ID logged (CPU ${TEST_CPU})"
+assert_log_contains "${STALLD_LOG}" "starved on CPU ${TEST_CPU} for [0-9]" "Starvation duration logged"
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
-- 
2.54.0

