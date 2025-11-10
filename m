Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605E31076A
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781002; cv=none; b=ibIKxLlzrI45q8Mejiay3HmBPkzGcpzQ/cyXa6pS91iEQbQAltrVsDZ9GoK5N3NWlYcUY+b0jDjjx+Wvpc6DWjUsfNIPMUZn8Yyk5L8+nMl7z1JXHxrKSSpkaRGaVeQSMJgqEy7C8pyGx07rNsxG2jWB45YOynJmlAoraVbRXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781002; c=relaxed/simple;
	bh=m6sIljD5bYZ/NkkGkXU31GrRAaLXT4r1396u1YMR9ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk5VNwECcqVlooqIXaxT4qBjc7BnwdUY/3MnIkyK25YogYbouCV0QeSftTcPRS7IVf4Zesbe01o9ZhuNj91Ed9PywQxjd+jGvZAwE464RiCNPcCaVCcCq7caZ4l1Wox9QjOhiGforX/5rrnMb0PEYd81Gji74H3MI9cMyuaaBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTlqUYkX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTlqUYkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762780999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kI7QpdWDIBM+wDXt9oFj5/wITY/g2zg5YYH/Atn9KLU=;
	b=KTlqUYkXR2wxoC/YIJHzKXgzMfW61upHiLftgZt6tyeYmYoa51ueI9644FnvjxDPIgrttP
	8Os3YKO4iXU5jNmCzj9C6MgJiZmwJfKCJ0yVNlnnwBfQ8qf9wx/dmcPtS4XToQdWcGni6t
	uqpvF1zz9L4kvjET5+hU0/4n/r6YKvE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-B6Rp_fkyMXihTlcmd3Dxnw-1; Mon,
 10 Nov 2025 08:23:15 -0500
X-MC-Unique: B6Rp_fkyMXihTlcmd3Dxnw-1
X-Mimecast-MFC-AGG-ID: B6Rp_fkyMXihTlcmd3Dxnw_1762780994
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 771BF180047F;
	Mon, 10 Nov 2025 13:23:14 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF24D196FC8B;
	Mon, 10 Nov 2025 13:23:11 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [stalld v2 2/6] Makefile: Improve compiler flag detection for -fcf-protection
Date: Mon, 10 Nov 2025 10:22:37 -0300
Message-ID: <20251110132241.43685-3-wander@redhat.com>
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
 Makefile | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index d605e60..23e786d 100644
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
@@ -43,23 +40,23 @@ ifeq ($(ARCH),powerpc)
 USE_BPF := 0
 MTUNE := -mtune=powerpc
 endif
-ifeq ($(strip $(IS_MINVER)), false)
-FCF_PROTECTION := 
-endif
-
-
-$(info USE_BPF=$(USE_BPF))
-$(info FCF_PROTECTION=$(FCF_PROTECTION))
-$(info MTUNE=$(MTUNE))
 
 DEBUG	?=	0
 
 INSTALL	=	install
 CC	:=	gcc
+
+# Test if compiler supports -fcf-protection
+FCF_PROTECTION := $(shell echo 'int main(void){return 0;}' | \
+		$(CC) -x c -fcf-protection - \
+		-o /dev/null 2>/dev/null && \
+		echo '-fcf-protection')
+
 FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer \
 		$(strip $(FCF_PROTECTION)) -fpie
 
+
 # Test if compiler supports -mno-omit-leaf-frame-pointer
 OMIT_LEAF_FP := $(shell echo 'int main(void){return 0;}' | \
 		$(CC) -x c -mno-omit-leaf-frame-pointer - \
@@ -74,6 +71,10 @@ DEFS	:=	-DUSE_BPF=$(USE_BPF) -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_S
 
 CFLAGS	:=      -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(DEFS)
 
+$(info USE_BPF=$(USE_BPF))
+$(info FCF_PROTECTION=$(FCF_PROTECTION))
+$(info MTUNE=$(MTUNE))
+
 ifeq ($(DEBUG),0)
 CFLAGS	+=	-g -O2
 else
-- 
2.51.1

