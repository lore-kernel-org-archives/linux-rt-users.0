Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945271F09A5
	for <linux-rt-users@vger.kernel.org>; Sat, 10 Jan 2026 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005710; cv=none; b=BkEsFdXYfgZ6PnA0p+QjgBpZ7GrKbXaWYVsLQI8TAHbde/bMJcVyR6WLnWBOjHrxBvktAB7VMnP91SY7kItXoK2ephx9dgoku7NWHWYihhcQEDKwIRKo8JQKQSl46FQIDtwS+JogKATDQ7L4jc0gEj06Ya1y5csnhd2kaR337d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005710; c=relaxed/simple;
	bh=Wsnzdi7rzSxXWEl73H2oG79d2PYYwtKEZMzjPuxE6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMvsHrzN18vd08hPmPv1J6B2y4PlsdXLiXzD8MfZrtZjcyHJjJtj8/rLb9buxm7418i832ePjCmQ6nPCxImBjFwtVCUfkjiFIPwHiU3mAlVsGZInp4fm+n7UiE87jkdIeWpFsL4cbUHiaUk/7FrYEXnbxTunuL0qGTP2T1DHzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INHZkkKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INHZkkKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768005705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=73OM+aaakfLtUtaQLaoaC/HLq3uSm6TFmPGgI2eYois=;
	b=INHZkkKKCc/jEWUgEvyj0FzZ/NaVwTJNxfGLY7oh40AyiwP9ifovxVrYTwnJvS2hReF8QP
	RYsw5ANfULlDJl8Ak1uTTDWFbKSF1hQtbgesbWPBGJ4mmUzzvvudX9GWw3LxWQHzvMKUaB
	2Ir7Fh6+q/XCIojuKHC1M5rW5aDx8OI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-CNks2B0XN8O6aiEm2ByVkA-1; Fri,
 09 Jan 2026 19:41:42 -0500
X-MC-Unique: CNks2B0XN8O6aiEm2ByVkA-1
X-Mimecast-MFC-AGG-ID: CNks2B0XN8O6aiEm2ByVkA_1768005701
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 629081956094;
	Sat, 10 Jan 2026 00:41:41 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3FDF180066A;
	Sat, 10 Jan 2026 00:41:37 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH] Makefile: Remove unnecessary -m64 compiler flag
Date: Fri,  9 Jan 2026 21:41:29 -0300
Message-ID: <20260110004129.357260-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Remove the M64 variable and all related architecture-specific overrides
from the Makefile. The -m64 flag is unnecessary because GCC defaults to
generating code for the native architecture. On 64-bit systems it
produces 64-bit binaries automatically, and on 32-bit systems the flag
causes build failures.

This change fixes builds on i686 and 32-bit powerpc architectures,
which were broken after commit 5bd4be43bc5b ("Makefile: Remove
redhat-specific checks")removed the RPMCFLAGS conditional that previously
allowed RPM builds to override the internal compiler flags. Rather than
adding M64 overrides for each 32-bit architecture, removing the flag
entirely is the cleaner solution since it provides no benefit on any platform.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 Makefile | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index a7d7875..467fc84 100644
--- a/Makefile
+++ b/Makefile
@@ -16,11 +16,7 @@ $(info GCC_VER=$(GCC_VER))
 
 USE_BPF := 1
 MTUNE	:= -mtune=generic
-M64	:= -m64
 
-ifeq ($(ARCH),aarch64)
-M64	:=
-endif
 ifeq ($(ARCH),i686)
 USE_BPF := 0
 endif
@@ -37,7 +33,6 @@ MTUNE := -mtune=powerpc
 endif
 ifeq ($(ARCH),riscv64)
 FCF_PROTECTION := "-fcf-protection=none"
-M64	:=
 MTUNE := -mtune=generic-ooo
 endif
 
@@ -63,7 +58,7 @@ OMIT_LEAF_FP := $(shell echo 'int main(void){return 0;}' | \
 		-o /dev/null 2>/dev/null && \
 		echo '-mno-omit-leaf-frame-pointer')
 
-MOPTS   :=  	$(strip $(MTUNE)) $(strip $(M64)) $(strip $(OMIT_LEAF_FP))
+MOPTS   :=  	$(strip $(MTUNE)) $(strip $(OMIT_LEAF_FP))
 
 WOPTS	:= 	-Wall -Werror=format-security
 
-- 
2.52.0

