Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5993E6385
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285757; cv=none; b=ATSmL6Kfntb14Z3HFIj6R55ow/fpHlzkHofm8quRpNq8a2CmvetXCB0JjXXAiHkTekDufZGaiib++t0tVVsopl5Ei/RC51YBmp6155X+hP0Ag6U5dmzy9OemHjWoKWwOeRb30yPt4G2Uas+nyRqEYt1cWx7LZCJIzVp85vvDrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285757; c=relaxed/simple;
	bh=n4LysnzqRi+fLjtGVmaWOjHR3fdEbX5YORDksHCgp2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awIuW5eUYp8wh3BbNCsKhYmprrpq5g5/gcUu076+vhcc7IT6RBt/ockqe6IYLsIt5pWQv683iZzUvgVa6QDK8YZnTvK5wxkjRSTtpVI5rzJ7bEb3dIiLKBSJfqdM/PmfYuuJRUrd0lGVEqHfhx/qeFtH4KGjJ8BMJmnFSrIGSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzILdn15; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzILdn15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld4WASugwo/Ddenlo2Qu+ZJzDlxrD5Fcw143L0N0gQw=;
	b=bzILdn15E3mj2bKryWw4+PoIVFNSMEu6RqInV7zgZwUeUKJOhE8xR9PrATJ8AMJnBDMUN2
	ENULpdbUl5MUHPma4w0wRh50/AOoZ/4J2PAiPGza5l9Zje4depU9+vKF2D8XbUgjTVOVaA
	vJjRImZaBD7giqap/haWUaJvogH2hJc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-a8OrRnvsNzG_rqB9bPFH5A-1; Wed,
 20 May 2026 10:02:33 -0400
X-MC-Unique: a8OrRnvsNzG_rqB9bPFH5A-1
X-Mimecast-MFC-AGG-ID: a8OrRnvsNzG_rqB9bPFH5A_1779285752
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09CDF18002CF;
	Wed, 20 May 2026 14:02:32 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F04641800465;
	Wed, 20 May 2026 14:02:29 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 29/33] tests: Drop redundant sleeps in test_pidfile
Date: Wed, 20 May 2026 11:00:56 -0300
Message-ID: <20260520140104.112142-30-wander@redhat.com>
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

