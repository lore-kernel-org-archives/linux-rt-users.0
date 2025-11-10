Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E63126C1
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781006; cv=none; b=CAYgsHBlICREJ/gMN7eFuf6YZ4eSX2SWjAYeqF78kh/PdX5Sk7xKwBXtLN1csTTWQJfSk51HpruUsF3YTZmOkOhnzy1ZFGVpxuR2+7wgM7yFS6gZH7pFUehrPefOVI2z0tlEvFh2UZ4666qskLoOI99MfFSCYE7Buop0x3Ccj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781006; c=relaxed/simple;
	bh=70kMuY3QwOih8qFzbmZT+2llZRTsXJ7mTLPsi+ClWkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXxH+c1e4qYXu+MgwBWKrWPSzGTOmTaun+iBd/kdRdNN3AcYfzlF0/f7bqBIb4/L/gUxOy7RHWQ7ZEkr0YVfoDkX6cNdFTE+5P4lxRIoOeXYTBwdd/hHDhyZrk9YhqFWwsNGHF0RukUYQ4SlSeE/aNTtQgCqdQgpb3yxtKNrHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeMTiJK6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeMTiJK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762781004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bITMCfNj7ZlPdcEZT64jqowD0FNkLNEkZ6gx9RoO9Iw=;
	b=EeMTiJK6fXEGFKn9CfMbJIhSKwYoFucNiLLbDVyZmeLMAc4FIggbtXn8JcIzmlk1R12sY3
	1zroZGlR5tDU1393Yeigtv0D66MNiYl1PkhlllGK/3CO+NMdONhdK2nBPYN+PN85zpDg/Z
	fe9WoKj+Kb3WUOIjAxJOiQVEcKx51yk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-fR7RfjPPO9OJkGCpn-7w1w-1; Mon,
 10 Nov 2025 08:23:22 -0500
X-MC-Unique: fR7RfjPPO9OJkGCpn-7w1w-1
X-Mimecast-MFC-AGG-ID: fR7RfjPPO9OJkGCpn-7w1w_1762781002
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BA5D18002C3;
	Mon, 10 Nov 2025 13:23:22 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3A6D196FC8B;
	Mon, 10 Nov 2025 13:23:18 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [stalld v2 4/6] Makefile: Remove redundant GCC version check
Date: Mon, 10 Nov 2025 10:22:39 -0300
Message-ID: <20251110132241.43685-5-wander@redhat.com>
In-Reply-To: <20251110132241.43685-1-wander@redhat.com>
References: <20251110132241.43685-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The minimum GCC version check was introduced to handle the `-fcf-protection`
flag, which was not available in older compiler versions. However, a more
robust method that directly tests for compiler support for this flag has
been implemented.

This commit removes the now-redundant GCC version check, simplifying the
Makefile and relying on the more accurate feature detection.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>
---
 Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Makefile b/Makefile
index 619413f..ba67698 100644
--- a/Makefile
+++ b/Makefile
@@ -14,11 +14,6 @@ GCC_VER=$(shell gcc --version | grep ^gcc | cut -f 3 -d ' ' | cut -f 1 -d '.')
 endif
 $(info GCC_VER=$(GCC_VER))
 
-# Does the current GCC compiler have fcf-protection and c99+ as default?
-MIN_GCC_VER := 8
-IS_MINVER := $(intcmp $(GCC_VER), $(MIN_GCC_VER), false, true, true)
-$(info IS_MINVER=$(IS_MINVER))
-
 USE_BPF := 1
 MTUNE	:= -mtune=generic
 M64	:= -m64
-- 
2.51.1

