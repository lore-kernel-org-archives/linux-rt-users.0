Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575863101C5
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780998; cv=none; b=t8JOn4JlwHpg/dWvq4PoS7vu5ZRWFpp70eLYg5cT3APTN5aP3E9U6l0ZlNbnvEMPxGaq08IKrj+ScHiWvTI1zrq7fm/fOhE5E/ygp5WXAmtQ6bpUr8m8iX1JozY0LZhLsPoWU23vgJJlLyElj80/BLm5v0v/zpfbst5h9YmZ9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780998; c=relaxed/simple;
	bh=YHA+moBXlzKItLWrjTORUJpuJrOnDJ9YltzEk8oEy0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0C06lMxja5mbFKo+fhU35oSSqTWhMyW3kbSWe6FMj8wZW1Ls6cOg2PfaE+OxZ67mVN6zPgJCDx29HfJt1cZQ2EL8aM3BcJ8Yq9/0W8tfHBhLjC6w+VLa+Hgp2fvLu9WzuTjFiteEo2vhxcG4X5wNfWb76e7CTtZJn71soEvBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KppaU4cn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KppaU4cn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762780995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Go5/mvnCreNntiNJ28ccqooSrPAudoyzKNjms7M8UM=;
	b=KppaU4cnh2m/Lj1ywRF9SpJVdqVLTIBR32Ag4r/oHBunCsKgjT3YNIS2geR0g5eLsd+LWz
	Ts3xb4Qt7ipSciWBdNaX1DKiljNHmrq74CtKEaznUnr6Vq5YOKDBvqxxvld7eAkaLS0vF2
	g3Mw4nTOKIomJ8qCbuI6Q/X7dC1oizE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-om0N2MrJM2eGtZ99dvxB7g-1; Mon,
 10 Nov 2025 08:23:12 -0500
X-MC-Unique: om0N2MrJM2eGtZ99dvxB7g-1
X-Mimecast-MFC-AGG-ID: om0N2MrJM2eGtZ99dvxB7g_1762780991
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 272AC1800357;
	Mon, 10 Nov 2025 13:23:11 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28D4C196FC8B;
	Mon, 10 Nov 2025 13:23:07 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [stalld v2 1/6] Makefile: Conditionally add -mno-omit-leaf-frame-pointer
Date: Mon, 10 Nov 2025 10:22:36 -0300
Message-ID: <20251110132241.43685-2-wander@redhat.com>
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

The -mno-omit-leaf-frame-pointer option is not available on all
architectures (e.g., s390x) or with older compiler versions. To avoid
compilation errors on such systems, this change adds a check to ensure
the option is only used when the compiler supports it.

This approach is similar to the existing check for -fcf-protection.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>
---
 Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c19e0bd..d605e60 100644
--- a/Makefile
+++ b/Makefile
@@ -60,7 +60,13 @@ FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer \
 		$(strip $(FCF_PROTECTION)) -fpie
 
-MOPTS   :=  	$(strip $(MTUNE)) $(strip $(M64)) -mno-omit-leaf-frame-pointer
+# Test if compiler supports -mno-omit-leaf-frame-pointer
+OMIT_LEAF_FP := $(shell echo 'int main(void){return 0;}' | \
+		$(CC) -x c -mno-omit-leaf-frame-pointer - \
+		-o /dev/null 2>/dev/null && \
+		echo '-mno-omit-leaf-frame-pointer')
+
+MOPTS   :=  	$(strip $(MTUNE)) $(strip $(M64)) $(strip $(OMIT_LEAF_FP))
 
 WOPTS	:= 	-Wall -Werror=format-security
 
-- 
2.51.1

