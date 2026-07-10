Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2BA4266B3
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690753; cv=none; b=A/1kRDexHsUQ7gVXgYPIl3jQn9rhWH9NLWE1GLhm3U6cC8M4L1DJyb6eycfeFWzvhxgBXrKWXf39t2MGh/ZOnR1flkU4DruamocQ/87dZrBpNbn/VqJrTgndsQIFPyaId6XlWRN8aWktU7CWbfqzTsBJcwBDcEFVdc0HJLgf/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690753; c=relaxed/simple;
	bh=m2+Nyi5bDF2iNvV9zLt7V8VbLmZfezSuVQqU/NALgt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK0sm2F/SbxM1mygn8oi0UWsmtgPN0tgCJw8SunwZeF55cdYvoRTJzTVdM80Z0ull7JhtgKXittTkkGX6J99ID2m1uGeWzjoMhwunVk3cbBhhS5t28t/L0Vm5ib/fLwLRr5WPvAeQucRsC860ptETeVXvX+fb4DfZON10RWwt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a58Yxj6b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a58Yxj6b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfNDAx3P7ciKEPNJawjCW6hLyvzGfb+LCKeNPvUER4o=;
	b=a58Yxj6bS2GTMnqzymnrntTRaP/+DPdYcwGD8pCyjkYSTPqVMRwikSOxsKKrDUu5CGX2iJ
	i5fGGrifnXJdcDiQ0gEQA71KLaJk8QCaGCJpnUCPx3pvBcy2sts9Mh9C3uOi3m0uR0NAcj
	fPjhvzYchoP6gz7aNINcqlHkIsAxAbs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-uSzZOj-mNe20tSwgez4ySA-1; Fri,
 10 Jul 2026 09:39:05 -0400
X-MC-Unique: uSzZOj-mNe20tSwgez4ySA-1
X-Mimecast-MFC-AGG-ID: uSzZOj-mNe20tSwgez4ySA_1783690743
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCA8F18005A2;
	Fri, 10 Jul 2026 13:39:03 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D7F0195608E;
	Fri, 10 Jul 2026 13:39:01 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 05/11] tests: fix intermittent starvation_gen readiness failure
Date: Fri, 10 Jul 2026 10:38:04 -0300
Message-ID: <20260710133810.72398-6-wander@redhat.com>
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

The process_alive check in the start_starvation_gen polling loop
uses kill -0, which can occasionally fail even when the process
is running. When this happens before the readiness grep has a
chance to run, the test aborts with a spurious "exited
prematurely" error.

Reorder the loop to check the log file for the ready message
before checking process liveness, so a transient kill -0 failure
does not prevent detection of a process that is already running.
Increase the initial sleep from 0.01s to 0.5s to give
starvation_gen time to start up before the first poll.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 1e3d736..20937a3 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -1267,21 +1267,21 @@ start_starvation_gen() {
 	# starvation_gen prints "ready" after all threads pass the barrier.
 	# Brief initial sleep covers the fast path, then 1-second polling
 	# for slow/loaded systems.
-	sleep 0.01
+	sleep 0.5
 
 	local timeout=10
 	local elapsed=0
 	while [ $elapsed -lt $timeout ]; do
-		if ! process_alive ${STARVE_PID}; then
-			echo "  Log contents:"
-			cat "${STARVE_LOG}"
-			fail "starvation_gen exited prematurely"
-		fi
 		if grep -q "Press Ctrl+C to stop early" "${STARVE_LOG}" 2>/dev/null; then
 			echo "starvation_gen ready (PID ${STARVE_PID})"
 			return 0
 		fi
 		sleep 1
+		if ! process_alive ${STARVE_PID}; then
+			echo "  Log contents:"
+			cat "${STARVE_LOG}"
+			fail "starvation_gen exited prematurely"
+		fi
 		elapsed=$((elapsed + 1))
 	done
 
-- 
2.55.0

