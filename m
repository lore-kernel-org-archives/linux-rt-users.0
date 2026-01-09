Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD528C874
	for <linux-rt-users@vger.kernel.org>; Fri,  9 Jan 2026 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993026; cv=none; b=J56flMZD0IdqOgbo2F2pVPHI+1rYX0VBy34QZzCWqlhpNavFPsofBG7VH4Wnr+/3AoUHmU4CTAfk+cgOi7DavnFKHp5B1lGU/hvQVSYlSw7WuFHCcxUz5Pa5yKihJKI1hem7LEBQbe/3quSDwON4u7pUQo6kUDee/oxVkxKzEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993026; c=relaxed/simple;
	bh=BYcai0XXL11lrbtQxmPoVHiIt9gmgn4e/tCqEM74FaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZ8Gi3KGT80tc9Mbg0JouwNPS3IzJCcwEPpckzmayNQp9WCHg4tFIR82kWC08EhKBXY0WNiK153hLNUm9gcqqEqj5s2h2zOknluYTYJD/oBkOpo74v2X2doN9Kr7mmJlIgt//IniaChHomTLufKFa3K/Q2oKooagT+e7evev+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Or05gklt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or05gklt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767993024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rM6d9Z+EOUiMlNV9Q0W59Gb001nzvuEr2fVwxf0Zaic=;
	b=Or05gklteU9Fr/yh9K19yijaAY6B5+w/3uiPHEQt0+AfSJe37WaKeq8xdiTbKR4421mOvD
	OFJ3TriUTOixgKygVp+ndoG6lpsyudTTL9LPR9gy4KnlO7yrYILkSqmzGI3Hlzxv/3r874
	5rJjxxRULRM3rFuY4qjBDsiHMP2+FaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-KZsVl_B0PWe8AL2VQ1SeTA-1; Fri,
 09 Jan 2026 16:10:22 -0500
X-MC-Unique: KZsVl_B0PWe8AL2VQ1SeTA-1
X-Mimecast-MFC-AGG-ID: KZsVl_B0PWe8AL2VQ1SeTA_1767993021
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95CFE1800350;
	Fri,  9 Jan 2026 21:10:21 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D40B1955F66;
	Fri,  9 Jan 2026 21:10:18 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>,
	Wander Lairson Costa <wcosta@redhat.com>
Subject: [stalld PATCH] Makefile: Remove LTO flags from build options
Date: Fri,  9 Jan 2026 18:10:05 -0300
Message-ID: <20260109211005.272868-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Remove the -flto=auto and -ffat-lto-objects flags from the FOPTS
variable. Link-Time Optimization can cause issues with certain
toolchains and adds complexity to the build process without providing
significant benefits for this codebase. The removal simplifies the
build and improves compatibility across different build environments.

Signed-off-by: Wander Lairson Costa <wcosta@redhat.com>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3188d2f..a7d7875 100644
--- a/Makefile
+++ b/Makefile
@@ -52,7 +52,7 @@ FCF_PROTECTION := $(shell echo 'int main(void){return 0;}' | \
 		-o /dev/null 2>/dev/null && \
 		echo '-fcf-protection')
 
-FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
+FOPTS	:=	-fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer \
 		$(strip $(FCF_PROTECTION)) -fpie
 
-- 
2.52.0

