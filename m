Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6248258CE7
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532281; cv=none; b=QP6XdMVKmidMrBXz9Ib7KyEujRBdyXcjLKFlvfs6NZraqC6v9XgAS8A6hb4tLmaNicrYl5Eq48zgNOxUcfl+HRfWN5I/+cknn2vVMbGXeRhNT6kmUOImV6fDU4qnicPf9mZEZm258sHuGoInnrStMLpfsR5afCRbfUjpQuIOHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532281; c=relaxed/simple;
	bh=VbUAIXEQigOGsh/5Wx7dX8AWV1l2hVkP8XZ661IJVFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiCrFVPw0ys3ik2/YfZJutRr40kq3CTB9ljDfOgMz8Y+WBDtKsJudk6NXZz/1nGX7Jv4Ru1cqQMpkijh9t4HbL/FOGS46jh3AoQ9RB9yFxA1Mz4MR9V6W3QnFvgDZHfaaggMKH04RuamQcrS48WoEbDwDmMEPMicTbhn73fwFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2qVicV7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2qVicV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762532279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2cjhSb1tgaCLOdSETNmopGydhXXnAzgfo1cnITs6Rc=;
	b=E2qVicV7gY+8tAneurNSuedS003Qxf4E4wXARhm+zHySUgnH3I1Na2Bd8Mp02PuZ51tRGF
	9RdLOUryFbplHEYU5Aidi5aLDgmtHby/LrMdtAOPmm34PrO2FNm3H0gZ1XdHqYTk0ujPDZ
	ymJ8PwEJMiy5OvzNtLzY84vPG5dAGpQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-LNWx3B7dOluA-SQZ223q_A-1; Fri,
 07 Nov 2025 11:17:55 -0500
X-MC-Unique: LNWx3B7dOluA-SQZ223q_A-1
X-Mimecast-MFC-AGG-ID: LNWx3B7dOluA-SQZ223q_A_1762532275
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5DC81956094;
	Fri,  7 Nov 2025 16:17:54 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAC3D30044DC;
	Fri,  7 Nov 2025 16:17:51 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH 2/3] Makefile: Improve compiler flag detection for -fcf-protection
Date: Fri,  7 Nov 2025 13:17:27 -0300
Message-ID: <20251107161729.320087-3-wander@redhat.com>
In-Reply-To: <20251107161729.320087-1-wander@redhat.com>
References: <20251107161729.320087-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The previous method of detecting support for -fcf-protection relied on
a minimum GCC version check, which was not always accurate and could
fail on different architectures or compiler toolchains.

This commit replaces the version check with a more robust method that
directly tests if the compiler supports the -fcf-protection flag. This
ensures better portability and avoids compilation errors on systems
where the flag is not available.

This change mirrors the recently added detection logic for the
-mno-omit-leaf-frame-pointer flag.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index d605e60..bc82858 100644
--- a/Makefile
+++ b/Makefile
@@ -20,17 +20,14 @@ IS_MINVER := $(intcmp $(GCC_VER), $(MIN_GCC_VER), false, true, true)
 $(info IS_MINVER=$(IS_MINVER))
 
 USE_BPF := 1
-FCF_PROTECTION := -fcf-protection
 MTUNE	:= -mtune=generic
 M64	:= -m64
 
 ifeq ($(ARCH),aarch64)
-FCF_PROTECTION := "-fcf-protection=none"
 M64	:=
 endif
 ifeq ($(ARCH),i686)
 USE_BPF := 0
-FCF_PROTECTION := "-fcf-protection=branch"
 endif
 ifeq ($(ARCH),s390x)
 MTUNE := -mtune=z13
@@ -43,9 +40,12 @@ ifeq ($(ARCH),powerpc)
 USE_BPF := 0
 MTUNE := -mtune=powerpc
 endif
-ifeq ($(strip $(IS_MINVER)), false)
-FCF_PROTECTION := 
-endif
+
+# Test if compiler supports -fcf-protection
+FCF_PROTECTION := $(shell echo 'int main(void){return 0;}' | \
+		$(CC) -x c -fcf-protection - \
+		-o /dev/null 2>/dev/null && \
+		echo '-fcf-protection')
 
 
 $(info USE_BPF=$(USE_BPF))
-- 
2.51.1

