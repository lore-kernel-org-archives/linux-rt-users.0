Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F213290A1
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899951; cv=none; b=KsJQDvQJb6CePZZrZctHmjAeN2a7rAlbKjX/7cCWqO0I/8TqkaPRFNk6oc7IgaBhVRxiJTsk2hZCYem0pY7hxHx+xRtCi4Dhl9+CVDSM5FrrvVMA1yPf7pr4qLkozVyedFDryeLgPSwVC3Fvdm8Fzj6ySgZoA2gr2bqytPq43ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899951; c=relaxed/simple;
	bh=g7RojqxDcBNTKbG2n8IqA2HZPDNef6q8pNzNX3chMVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzBghGXpwUzY9qvOup4835Gmfys1JZBAVyCPQBYg3dsNAgmke/QzZbLE3wm3CtAKtHATAyoIi0/mKhefvF7TCB1VlERdtP2Cw3atgXV7m2m+ftH1TRwytz39CdKeG5YXhki1E/WULvVBX1TWc4WMvXUU0GxFilUHZ+aC5xJDlxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbqIru6d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbqIru6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5sGilE+1PtcewifOqoNjm0RBasSqp5aQlG2ict6bf4=;
	b=TbqIru6dbhjSZY5UupRSLQBMyfT7IrnsRoi4/8tSvosj0LZMNTkFfRkquUMMoYC3zhcwHD
	K0xOjuSFJuHU2nZSI2XPALBKSYexJVlhrhEbdyEq5dw8Bi9F7hyTt2IsvZ5y7cjLJKjZzk
	pinsLZW696npt+RdJ7GhKrjI3GC3FR4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-WxcVyozPOBGAh2Yxx6H8lQ-1; Mon,
 30 Mar 2026 15:45:46 -0400
X-MC-Unique: WxcVyozPOBGAh2Yxx6H8lQ-1
X-Mimecast-MFC-AGG-ID: WxcVyozPOBGAh2Yxx6H8lQ_1774899945
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 180CD18005B6;
	Mon, 30 Mar 2026 19:45:45 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76E461954102;
	Mon, 30 Mar 2026 19:45:42 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 21/36] tests/functional: Add missing -a flag in test_starvation_detection
Date: Mon, 30 Mar 2026 16:43:44 -0300
Message-ID: <20260330194410.103953-22-wander@redhat.com>
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

The start_stalld_with_log call in Test 3 is missing the -a flag to
pin stalld to a separate CPU, unlike all other invocations in the
same file. Add it for consistency.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_starvation_detection.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_starvation_detection.sh b/tests/functional/test_starvation_detection.sh
index 6b7d330..3c6fd6e 100755
--- a/tests/functional/test_starvation_detection.sh
+++ b/tests/functional/test_starvation_detection.sh
@@ -180,7 +180,7 @@ start_starvation_gen -c ${TEST_CPU} -p 80 -n 2 -d ${starvation_duration}
 
 log "Starting stalld with ${threshold}s threshold (log-only mode)"
 log "Will monitor for multiple detection cycles to verify timestamp preservation"
-start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU}
+start_stalld_with_log "${STALLD_LOG}" -f -v -N -l -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU}
 
 # Wait for first detection cycle
 log "Waiting for first detection cycle..."
-- 
2.53.0

