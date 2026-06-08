Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D73E3D86
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943688; cv=none; b=UgD2z2gnjm59mV8q0G9o8dMJSI0l/l5BvdsCZEseXmvar1Y07kR2qtXzYjg6/RACt8QX5/aWGxXLCetaC5vGh3/fFNuC8F1gDbvmiUB4v8xGPSfTRkYfy7+2VTIXx0kR9zrF0PK97IxMHKvArPrFBtLCnH33K9ix1r9vnGRGrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943688; c=relaxed/simple;
	bh=pAwPA2Nj2EeJ7Ct7wVISu0gaqv5uVCykx2HvZFI3Mg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+9DaofgKPgDCMx+VNvTa3rNLG+wxDApbLDhB1sW3LgMLIMSn8jZNq7nFdMmzMlia3ha/xU8SG343btEVp3zLJrjGNAc6/GsgvxCO5mv/OMYPJalbR/FFRauSN17lQKdjxk6me3Dgz+/hqos2kMjFMeaJc+8IC+DPmFKbLWhqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEyxV0S/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEyxV0S/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyTH+fgkNe/bcwVAoq+a7VUV84XsK+Hg1s0JBaTOZh4=;
	b=SEyxV0S/HSHhXf5Pl8pEW++hs3HQuhrifa8aXdmTieuVRhBmF1QZz38bFYuD1mG9++JyMp
	9mbFIHpi4PYj/T5Q0uTZy31dLWqC1AsA9ko8pfm1WA+pK/YKztvltoT10qi76Ac64oG1Az
	TuIRTIzyFaBnOdWysRGNUsAe0xG6aW8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-POQmR5lTNhCct2foAbbsqg-1; Mon,
 08 Jun 2026 14:34:35 -0400
X-MC-Unique: POQmR5lTNhCct2foAbbsqg-1
X-Mimecast-MFC-AGG-ID: POQmR5lTNhCct2foAbbsqg_1780943674
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2745A180A8EC;
	Mon,  8 Jun 2026 18:34:34 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1585436928;
	Mon,  8 Jun 2026 18:34:31 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 52/52] stalld: fix format string type mismatch in set_cpu_affinity
Date: Mon,  8 Jun 2026 15:32:02 -0300
Message-ID: <20260608183206.140526-53-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The error message after sched_setaffinity() fails uses %d to print
the result of strerror(), which returns a char pointer. This is
undefined behavior and prints a meaningless integer instead of the
error description. Use %s to format the string correctly.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/utils.c b/src/utils.c
index b3b17dd..1a90b32 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -920,7 +920,7 @@ int set_cpu_affinity(char *cpu_list)
 
 	retval = sched_setaffinity(getpid(), sizeof(set), &set);
 	if (retval == -1) {
-		log_msg("self-affinity: error setting affinity %d", strerror(errno));
+		log_msg("self-affinity: error setting affinity: %s\n", strerror(errno));
 		return -1;
 	}
 
-- 
2.54.0

