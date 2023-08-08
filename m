Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A1C001DB
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 22:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjHHWzu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 18:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjHHWzu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 18:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309B1982
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691535306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k7On0x41aTMN/qREq2jpmY2i9cWTtcmDlhLkGl/D11I=;
        b=Oj4OJEasJEqDEbm4/LkfNP3Zx6nI0BbaIkWn4CQUg8Yi737AJPC27DT6HOG0Ofht4q5Tmt
        yI+MZdV3p0kBBedH8hKBK7XsZEThqTdiDjnkapN9iF2Yg+QNwMBHNO/41j2xJQ5OVncBn/
        oFTnuPMni02umBsQBEArW9t9saH3vLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-NcLtHNo0NKGW7F4D1HTLMw-1; Tue, 08 Aug 2023 18:55:03 -0400
X-MC-Unique: NcLtHNo0NKGW7F4D1HTLMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78F69801FA0
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 22:55:03 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.194.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C687640C2076;
        Tue,  8 Aug 2023 22:55:02 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH] rt-tests: cyclictest: Remove warnings due different signedness in comparison
Date:   Wed,  9 Aug 2023 00:55:00 +0200
Message-Id: <20230808225500.292257-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Type casting used to remove compiler warnings due to comparison of integer expressions of different signedness.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 src/cyclictest/cyclictest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 7b0f80f..3b47d53 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -317,8 +317,8 @@ static int raise_soft_prio(int policy, const struct sched_param *param)
 		return err;
 	}
 
-	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : rlim.rlim_cur;
-	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : rlim.rlim_max;
+	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? (unsigned)policy_max : rlim.rlim_cur;
+	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? (unsigned)policy_max : rlim.rlim_max;
 
 	if (prio > soft_max && prio <= hard_max) {
 		rlim.rlim_cur = prio;
-- 
2.39.3

