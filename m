Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BE3E835E
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285759; cv=none; b=OBh7YN2/1xKqIS9GK/gUSIcH/BGV5ST3mpQg+haQap7//yD5NgijyNv97YD4JMMYW5aoA5EzIGnTgxyuYVhkJlGCYL6rN2Vn7tYpX3p3dmQ71z44x3K9FaS58Bs5oiA0AKHFgh5ScodYVI38phBBa50O2JWGIePS59UmNZTIMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285759; c=relaxed/simple;
	bh=aaWhdqnEf8wXw4E6IPbFHHIs0l+OCGuuoF0Dj2brSyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buHpXQSyKW5pOXpbwF7DedVU2Gj0GzhuGt5S4+grfupQaVR+5nGQFDVDU8RNL0sCDMDQgjr4eb9n/6J39tlrCzJWrg/SJFPr2Dun6M59o9jWHewtqi1rejV+t91q24caFFn37OR9WqUy0qBPAW3UX42IsxClh1zAYwrK74YneNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjS8fwFx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjS8fwFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rp2ITbUNsCVav/i/s6CTAu0a6p7cF19evgZDpb+OmeA=;
	b=NjS8fwFxYMEQjmT2nwXsDg4kqeF8nWjGk4XtHPK5Wd/jEYn6du+gUMYugGIj/4+wiGdQih
	PUvZb5mGEDmd7WbKrTXYy9/YYk22j5AepMU/zXH7KV6pnTYRWPICj3yW1EKowm6KtojinL
	14gpv5GKaBxIarzmAKDIlPTCPWFMJks=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-yvSyzkjdPw6SaWZI1GOJKQ-1; Wed,
 20 May 2026 10:02:35 -0400
X-MC-Unique: yvSyzkjdPw6SaWZI1GOJKQ-1
X-Mimecast-MFC-AGG-ID: yvSyzkjdPw6SaWZI1GOJKQ_1779285754
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C6F81956053;
	Wed, 20 May 2026 14:02:34 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 722171800352;
	Wed, 20 May 2026 14:02:32 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 30/33] tests: Remove redundant sleeps after start_stalld
Date: Wed, 20 May 2026 11:00:57 -0300
Message-ID: <20260520140104.112142-31-wander@redhat.com>
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

Remove redundant sleep commands from test_foreground.sh and
test_logging_destinations.sh. The start_stalld function already polls
for readiness before returning, rendering these post-return delays
unnecessary.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_foreground.sh           | 3 ---
 tests/functional/test_logging_destinations.sh | 1 -
 2 files changed, 4 deletions(-)

diff --git a/tests/functional/test_foreground.sh b/tests/functional/test_foreground.sh
index 792aee0..7dab793 100755
--- a/tests/functional/test_foreground.sh
+++ b/tests/functional/test_foreground.sh
@@ -24,7 +24,6 @@ require_root
 # Test 1: Without -f flag, stalld should daemonize
 test_section "Test 1: stalld daemonizes by default"
 start_stalld -l -t 5
-sleep 2
 
 assert_process_running "${STALLD_PID}" "stalld should be running"
 
@@ -42,7 +41,6 @@ test_section "Test 2: stalld stays in foreground with -f"
 
 # Start stalld in foreground but in background job
 start_stalld -f -l -t 5
-sleep 2
 
 assert_process_running "${STALLD_PID}" "stalld should be running with -f"
 
@@ -55,7 +53,6 @@ stop_stalld
 test_section "Test 3: -v implies foreground mode"
 
 start_stalld -v -l -t 5
-sleep 2
 
 assert_process_running "${STALLD_PID}" "stalld should be running with -v"
 
diff --git a/tests/functional/test_logging_destinations.sh b/tests/functional/test_logging_destinations.sh
index a25e571..eb06171 100755
--- a/tests/functional/test_logging_destinations.sh
+++ b/tests/functional/test_logging_destinations.sh
@@ -49,7 +49,6 @@ if command -v dmesg >/dev/null 2>&1; then
 	DMESG_BEFORE=$(dmesg | wc -l)
 
 	start_stalld -f -k -l -t 5
-	sleep 2
 
 	if assert_process_running "${STALLD_PID}" "stalld with -k should be running"; then
 		sleep 1
-- 
2.54.0

