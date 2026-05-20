Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04D3E8665
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285759; cv=none; b=duKYN5ADOp9ri609vZVco0j0LPlOn8e4t5Kw8hnsLlLtjNIBM2CpRtpH/MpIUVjORhbBPPzJPf0919Wd733NTxC9F9HFexyUXWWuAzGUrzgab7MWWO/VKGdH+zyWqwKAhsxi4rVKiSgpQqD2skEdPijA7I7kG0lB6l1IfbeiBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285759; c=relaxed/simple;
	bh=Xts9B/b5Hb4LeDImpXadxS4cDJXpI9vRmcFpVLQ6L44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+5HXbeWNLKXyeEpQV63QQ1zJ1y8jz58gulbaJEq17IO3TJKEr+g0p6AcGq4WAy0siVXFfbFyOWE8r+ErlxMqU+PeqHPjurefD3v/UoFibSZa8LHK6Eq3wHxLPalo3Sq+cwuxmpSoB9o3yETcYWXw4rqwaditwLi2wGP8V4E+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfnRaUZV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfnRaUZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXQH5/EeL0wJrfvEBXFRhQ5x9PFozRAe72ZG/KjN2nc=;
	b=cfnRaUZV138fIime4kj9pTYHezDNLGmEUiGV1K8j3ld7A/ZkQMusExPQXW+HTPfEYv/cwL
	I3o/zQlIAUwb081f3XD0m4LcAagHypqexp2No7nrsGoPRBiJ4s1jBkh5YOEM9Rmeh/F7l1
	tkPI/Ty7Yc38o5w+nxO9beEy8DTWzdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-s-KLcqeqMJqzuEW0e0aUjA-1; Wed,
 20 May 2026 10:02:30 -0400
X-MC-Unique: s-KLcqeqMJqzuEW0e0aUjA-1
X-Mimecast-MFC-AGG-ID: s-KLcqeqMJqzuEW0e0aUjA_1779285749
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E0951956053;
	Wed, 20 May 2026 14:02:29 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D2A41800465;
	Wed, 20 May 2026 14:02:27 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 28/33] tests: Replace init sleeps in test_affinity
Date: Wed, 20 May 2026 11:00:55 -0300
Message-ID: <20260520140104.112142-29-wander@redhat.com>
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

Replace start_stalld followed by a fixed two-second sleep with
start_stalld_with_log in test_affinity.sh. The helper uses event-driven
wait_for_stalld_ready internally, returning as soon as the daemon logs
its first monitoring message rather than waiting a fixed interval.
Since stalld typically initializes in under half a second, this saves
approximately nine seconds across the six modified test sections.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_affinity.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index 3faa199..43ab912 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -54,8 +54,8 @@ fi
 #=============================================================================
 test_section "Test 1: Default behavior (no affinity restriction)"
 
-start_stalld -f -v -l -t 5
-sleep 2
+rm -f "${STALLD_LOG}"
+start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5
 
 default_affinity=$(check_affinity "${STALLD_PID}")
 log "ℹ INFO: Default affinity: $default_affinity"
@@ -69,8 +69,8 @@ stop_stalld
 #=============================================================================
 test_section "Test 2: Single CPU affinity (-a 0)"
 
-start_stalld -f -v -l -t 5 -a 0
-sleep 2
+rm -f "${STALLD_LOG}"
+start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0
 
 affinity=$(check_affinity "${STALLD_PID}")
 
@@ -84,8 +84,8 @@ stop_stalld
 test_section "Test 3: Multi-CPU affinity (-a 0,2)"
 
 if [ "$num_cpus" -ge 4 ]; then
-    start_stalld -f -v -l -t 5 -a 0,2
-    sleep 2
+    rm -f "${STALLD_LOG}"
+    start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0,2
 
     affinity=$(check_affinity "${STALLD_PID}")
 
@@ -103,8 +103,8 @@ fi
 test_section "Test 4: CPU range affinity (-a 0-2)"
 
 if [ "$num_cpus" -ge 4 ]; then
-    start_stalld -f -v -l -t 5 -a 0-2
-    sleep 2
+    rm -f "${STALLD_LOG}"
+    start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0-2
 
     affinity=$(check_affinity "${STALLD_PID}")
 
@@ -123,8 +123,8 @@ test_section "Test 5: Verify stalld threads run on specified CPU"
 
 if [ "$num_cpus" -ge 2 ]; then
     test_cpu=1
-    start_stalld -f -v -l -t 5 -a "$test_cpu"
-    sleep 2
+    rm -f "${STALLD_LOG}"
+    start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a "$test_cpu"
 
     # Check affinity
     affinity=$(check_affinity "${STALLD_PID}")
@@ -174,8 +174,8 @@ assert_stalld_rejects "Invalid CPU affinity rejected with error" -f -v -l -t 5 -
 #=============================================================================
 test_section "Test 8: Verify affinity persists over time"
 
-start_stalld -f -v -l -t 5 -a 0
-sleep 2
+rm -f "${STALLD_LOG}"
+start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0
 
 affinity_start=$(check_affinity "${STALLD_PID}")
 log "ℹ INFO: Initial affinity: $affinity_start"
-- 
2.54.0

