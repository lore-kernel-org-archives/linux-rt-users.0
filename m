Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC53E6DC6
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285737; cv=none; b=P82NI3STXx+5vYKKI/J5lfoHbh3EXfkXNRmlYnywuUX3VAuBvULKuPFIYPphv5LoQA5AHI6c5WKMH3BJ0TDT4sZS+tGSfUwkZizSBYyRQC15b3B5TFTR1YGcp9j8AH3K7fsr8jN81N8ihNgRujgWHmvkcExENNKN1HUWAN81Ksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285737; c=relaxed/simple;
	bh=t1NRlt6tA0usS95urrG86rx7iUri2+0xgLxz5PV5Qkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmandF0yioSj1O7y4mnj0J3gcuYca3qpNNG4+UyndKq4V0sPw9CRMnBbgi6jHUFts6dorYmZDAFowB9NA02yVCYgxxPaLRPKyaYosQXeVb9FHl2GPxnDcZYXKMb1yFJOhlNcbMDjbU5kVlxd7vbydgrtMvoi/b+k3svqHnzyVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xma7CT7f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xma7CT7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUPKfS7N0ythEd1uagHaA8ynzZHHb4D6xdvSuWB6cj0=;
	b=Xma7CT7fGfta80lxoI71TW+rdf7EMe/KZmZHIjdpTzEQ4fRDDWzESp+xEK/daegW5zFmaL
	8OiDEargen6JrnVvI1idF/fobqFzDCRtaWJdIXapGPL64UlhNM5dojs0euYyFDNh5StBlz
	w0VNWi8rcZpjrBnHLrqPDGFLQOaW54g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-iXsFoOGnOzC72GxkJ-KymQ-1; Wed,
 20 May 2026 10:02:09 -0400
X-MC-Unique: iXsFoOGnOzC72GxkJ-KymQ-1
X-Mimecast-MFC-AGG-ID: iXsFoOGnOzC72GxkJ-KymQ_1779285729
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D1B1800616;
	Wed, 20 May 2026 14:02:08 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5C5D1800352;
	Wed, 20 May 2026 14:02:06 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 20/33] tests: Replace wait conditionals with asserts
Date: Wed, 20 May 2026 11:00:47 -0300
Message-ID: <20260520140104.112142-21-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

