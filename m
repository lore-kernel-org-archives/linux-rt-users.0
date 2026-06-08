Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A6E3E3142
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943620; cv=none; b=VD78HLSY5U++luK0HwCxN4t5EFA8RHzE4Sf1RHmO/wNIvmBj0OwZ77rcgXz6CwoAXT1ISx0tkOl4CO5qNlTUaAv/7krJZLjeIHv51zjHsYgRhVYH/kDSaATu26se592JrnB1pun+J1Zao8M0rkWketC+iCXjP5PbjHYJINLU6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943620; c=relaxed/simple;
	bh=n4LysnzqRi+fLjtGVmaWOjHR3fdEbX5YORDksHCgp2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrPdvmd8sQrFXsu292JSUrBoA8d5AyIIXFbcdXIuZogG8JSdSk/plSCdD0DzeZ65YdjQJKMU/xrWVEFY21aY6eh/FXswMIwPommKWEl8a9gY5Aw5FEko1WyJ0ql37uTxxbjnhBi50AWgOSn8VHh75NSjfnhMws7wgjPjWra3NWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFjpI3hr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFjpI3hr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld4WASugwo/Ddenlo2Qu+ZJzDlxrD5Fcw143L0N0gQw=;
	b=jFjpI3hrdToG0i7Zl+j7n2SthTSCU2FWBBMSkaWp8LDTMM7m0aGRnkrpLjBvaDLHrklpln
	/5rWsHWcg9kYfisDGazbDzVyISXz4Ei0V2FlyzMlgudLgYDdPn80fQfQku1S2pMY96TmCx
	PGo70gc5udTME0QmC6uPOuUwk1TJqEQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-kAZydAmZNV2xaqgptkiLSA-1; Mon,
 08 Jun 2026 14:33:35 -0400
X-MC-Unique: kAZydAmZNV2xaqgptkiLSA-1
X-Mimecast-MFC-AGG-ID: kAZydAmZNV2xaqgptkiLSA_1780943614
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B76F195DE46;
	Mon,  8 Jun 2026 18:33:34 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30EDC36928;
	Mon,  8 Jun 2026 18:33:31 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 29/52] tests: Drop redundant sleeps in test_pidfile
Date: Mon,  8 Jun 2026 15:31:39 -0300
Message-ID: <20260608183206.140526-30-wander@redhat.com>
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

Remove redundant sleep calls following start_stalld in the pidfile
tests. The start_stalld helper already polls for readiness internally
before returning. It waits for the pidfile to appear when --pidfile
is passed, and uses pgrep retries otherwise. The additional sleeps
were dead wait time and unnecessarily slowed down test execution.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_pidfile.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index a2e5eb0..b5e1159 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -22,9 +22,6 @@ test_section "Test 1: Default behavior (no -P specified)"
 
 start_stalld -l -t 5
 
-# Give stalld time to create pidfile
-sleep 2
-
 # Check common default pidfile locations
 default_found=0
 for pidfile in /var/run/stalld.pid /run/stalld.pid; do
@@ -58,7 +55,6 @@ rm -f "${custom_pidfile}"
 
 log "Starting stalld with custom pidfile: ${custom_pidfile}"
 start_stalld -l -t 5 --pidfile "${custom_pidfile}"
-sleep 2
 
 assert_file_exists "${custom_pidfile}" "Custom pidfile created at ${custom_pidfile}"
 
@@ -87,7 +83,6 @@ rm -f "${tmp_pidfile}"
 
 log "Starting stalld with /tmp pidfile: ${tmp_pidfile}"
 start_stalld -l -t 5 --pidfile "${tmp_pidfile}"
-sleep 2
 
 assert_file_exists "${tmp_pidfile}" "Pidfile created in /tmp directory"
 
@@ -107,7 +102,6 @@ rm -f "${fg_pidfile}"
 
 log "Starting stalld in foreground mode with pidfile: ${fg_pidfile}"
 start_stalld -f -v -l -t 5 --pidfile "${fg_pidfile}"
-sleep 2
 
 if [ -f "${fg_pidfile}" ]; then
     pass "Pidfile created in foreground mode"
@@ -139,7 +133,6 @@ rm -f "${readable_pidfile}"
 
 log "Starting stalld with readable pidfile: ${readable_pidfile}"
 start_stalld -l -t 5 --pidfile "${readable_pidfile}"
-sleep 2
 
 assert_file_exists "${readable_pidfile}" "Pidfile created"
 assert_success "Pidfile is readable" cat "${readable_pidfile}"
-- 
2.54.0

