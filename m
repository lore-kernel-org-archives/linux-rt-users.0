Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631D258CE7
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532277; cv=none; b=EfxOOWpganmUR7k7YihiFzq50o7/xMvxPyndupp1tv87f191uKhNjVaTWD6JmKoOSwdnzOGd4zyGyLleDouTfbEq3MOusd/Qb9R7J3b6e++Gc8os7G1cyBe6x+Tz/TxVJopNlFFqoXAUlIUi/L21rTNRgTby28TlQAuT0silDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532277; c=relaxed/simple;
	bh=YHA+moBXlzKItLWrjTORUJpuJrOnDJ9YltzEk8oEy0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9jf1oHSLbfCupUEFHLuobsFSPqyLldw/W9NdXGJpvgNi8cezFCVSV7XnOv4HjMHEooUbCGzkPhRWeb05jPQm8fBSB+5cAWZZwtQq5glJwbtusUtdA6m14hbj2eYIjJXkQSENMeloNHf5eAIbu8SDlcxg0s/sWbyPOK/RDefkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKI5sku7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKI5sku7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762532274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Go5/mvnCreNntiNJ28ccqooSrPAudoyzKNjms7M8UM=;
	b=QKI5sku7DuKGExxrlYbNkrob8eYImWg+DzbkE8vrbCzAltuspb2kQjQwBkmXgM1E5wfhWa
	8BvyXgXBT1J4Nu0pakIcuHUwLe5d4WkDnn6AConhJLQuwiRHC8O+MgV+NdpnTXs+Yk7+ds
	iLDRBtJGBIYAtsEh6e0aiYk2Pa1Q3fk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-c1mTDaaBNYyezRaXtf1EVA-1; Fri,
 07 Nov 2025 11:17:52 -0500
X-MC-Unique: c1mTDaaBNYyezRaXtf1EVA-1
X-Mimecast-MFC-AGG-ID: c1mTDaaBNYyezRaXtf1EVA_1762532271
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3905419560B2;
	Fri,  7 Nov 2025 16:17:51 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C3593001E83;
	Fri,  7 Nov 2025 16:17:47 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH 1/3] Makefile: Conditionally add -mno-omit-leaf-frame-pointer
Date: Fri,  7 Nov 2025 13:17:26 -0300
Message-ID: <20251107161729.320087-2-wander@redhat.com>
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

