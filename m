Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9F39D6DF
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899997; cv=none; b=MOjcgTFC3zmIasIsAEfb5rrmmHv2Lk6TfwoZKyrzTQg9wg0lM9mdIjRbZWV1luFKGEbNtIb/cm9C0KRXjfyiIQrCGOh7bp02XTE/4BAY44Nxy4SC8tXf4zge/IHM1Xw5/Agqhdw3Yo4KOKqLUxuXx7PGgg25fOQnbwAb9Tnl9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899997; c=relaxed/simple;
	bh=asVZ07tOReWDwfGcwcd50l+AGipaxHrCfE2bamtxkiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McoIlMlIibJmXFRbCAMtvfq1XL7ufxUSCYXt8XPnF+egtROggu0aYr/kT+qbYDi+dNNVMG0b09aNaUeWw/5i1tEP/BrHrr1jVRyOLZ/2UAx68jSO+MzjbVQgTSNUmfGSTGuJQpvhdK4Gz3HFiGe9BRfc6V55P/vfRMdWPYFnK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVXXaS+R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVXXaS+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwIdKhqnEy6jE58SSmemswAWmGcrQpYalvMfidZ8I7M=;
	b=ZVXXaS+R/k4rHX1087DncuqHOrd71q+DTcu5eyi/+FZuXSkC1jYs8qHuSuEjviuYTM01o/
	sP1eGgHajt3YMMDz7SgyiELSRjzqc2WLrCLwuPJWqIBBT03RVWHj4YZEMmqO4Slw6fWEAU
	F7dX6JMHXS1mT2wU6MRuH0te+ezwlKI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-WBVLCVuPOFK8c78GbVSi7w-1; Mon,
 30 Mar 2026 15:46:33 -0400
X-MC-Unique: WBVLCVuPOFK8c78GbVSi7w-1
X-Mimecast-MFC-AGG-ID: WBVLCVuPOFK8c78GbVSi7w_1774899992
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6AC1195609E;
	Mon, 30 Mar 2026 19:46:32 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 611FD1954102;
	Mon, 30 Mar 2026 19:46:28 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 35/36] tests/functional: Fix invalid pidfile test in test_pidfile
Date: Mon, 30 Mar 2026 16:43:58 -0300
Message-ID: <20260330194410.103953-36-wander@redhat.com>
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

The test created a directory with no write permission and expected
stalld to fail writing the pidfile. Since the tests run as root,
the permission restriction has no effect and stalld succeeds. Use
a non-existent parent directory instead so fopen() fails regardless
of privileges.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_pidfile.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 0e4c623..76be14a 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -192,12 +192,8 @@ log "=========================================="
 log "Test 6: Invalid pidfile path (permission denied)"
 log "=========================================="
 
-# Create a directory with no write permissions
-test_dir="/tmp/stalld_test_no_write_$$"
-mkdir -p "${test_dir}"
-chmod 555 "${test_dir}"
-invalid_pidfile="${test_dir}/stalld.pid"
-CLEANUP_FILES+=("${test_dir}")
+# Use a non-existent parent directory so fopen() fails even as root
+invalid_pidfile="/nonexistent_${$}/stalld.pid"
 
 INVALID_LOG="/tmp/stalld_test_pidfile_invalid_$$.log"
 CLEANUP_FILES+=("${INVALID_LOG}")
-- 
2.53.0

