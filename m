Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516539DBC1
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899993; cv=none; b=Pd95KMv3+r29+xSYvvL/1jNIzTFvR6rPNcISjpJS5+3aSB4qmgzl7PvsBqm+eADTcXCsqQLcWMzxhpNrjsxzPgCdyhWiqkuklkkpq291KfGCvOiq2ZPvQIDghiaxEAZGCdUPt4UNksMKP5jbQgffmnElPvn6MTdYAhtU8E0PHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899993; c=relaxed/simple;
	bh=t4v0E9aL4y5353mMiiYHIHl/x7piP/Q5np4iKYvdeYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR3uvQLwFv/8eLsOFoFKNjT7LxtrnqGh09IGbbUiqfuXDC6s+l3+Ji72TwT/vekvUfEffNHuaOh+lR6a3vkKa7URdYksBtNRa0x4iQIamAkVKcRINE4GslyGih3/ax4ZL55jUICLaGMmQVu0iYLQbB7njl7USGapXwe64Z9KvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcSalllG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcSalllG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UP1pMO0Ix153s2NIOrDBZQ4pE7hQ2pWLgiNYu2S/jnE=;
	b=TcSalllGlgngHbhge9JN/VUHFu722psyS9he9AZSe7C8t0Kt5Sl6uuWfbJZ6t6wXHwTUWv
	CR4KQJqfwFBb734Wy25SfVlEpMsaJSQ5faEmGX/i605qmpL2I5DPfMh34EY/WHzN1GP1un
	Zw+Ye3Eo9Rktw+GNLTjsTylyF9tY/UI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-3lnPh34iMeqwP4CC21EMDQ-1; Mon,
 30 Mar 2026 15:46:28 -0400
X-MC-Unique: 3lnPh34iMeqwP4CC21EMDQ-1
X-Mimecast-MFC-AGG-ID: 3lnPh34iMeqwP4CC21EMDQ_1774899987
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1DB619560B4;
	Mon, 30 Mar 2026 19:46:27 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4513E1954102;
	Mon, 30 Mar 2026 19:46:25 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 34/36] tests/functional: Fix readiness detection and FIFO fallback in test_force_fifo
Date: Mon, 30 Mar 2026 16:43:57 -0300
Message-ID: <20260330194410.103953-35-wander@redhat.com>
In-Reply-To: <20260330194410.103953-1-wander@redhat.com>
References: <20260330194410.103953-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add "skipping" to the wait_for_stalld_ready() pattern to handle
aggressive mode with idle detection, where stalld prints "skipping
next phase" instead of "checking cpu" or "waiting tasks". Also
accept stalld's fallback to adaptive mode when given -F without -A,
matching the fix already applied to test_fifo_boosting.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_force_fifo.sh | 4 +++-
 tests/helpers/test_helpers.sh       | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index ecaa7ac..239bc37 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -218,8 +218,10 @@ ret=$?
 
 if [ $ret -ne 0 ] && [ $ret -ne 124 ]; then
     pass "single-threaded mode rejected FIFO"
+elif grep -qiE "single.*thread|falling back|adaptive" "${FIFO_SINGLE_LOG}"; then
+    pass "stalld detected incompatibility and fell back to adaptive mode"
 else
-    fail "stalld did not reject -F in single-threaded mode"
+    fail "stalld silently accepted FIFO in single-threaded mode"
 fi
 
 #=============================================================================
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 6e29a3b..9d49b55 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -537,7 +537,7 @@ wait_for_log_message() {
 wait_for_stalld_ready() {
 	local log_file=$1
 	local timeout=${2:-15}
-	wait_for_log_message "checking cpu\|waiting tasks" "${timeout}" "${log_file}"
+	wait_for_log_message "checking cpu\|waiting tasks\|skipping" "${timeout}" "${log_file}"
 }
 
 # Wait for stalld to detect a starving task.
-- 
2.53.0

