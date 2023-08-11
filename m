Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3D3C41513
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Aug 2023 15:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjHKPnu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjHKPnt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Aug 2023 11:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5809118B
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Aug 2023 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691768584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yhyS5bFTfGZ3aPzrkIHbk0vQbpWG7NZ7cygqGm3TpAY=;
        b=QXGbI7MMxii2ja+1cwJzy2S9D2DJAU01VQi2xI4WtZnJNLWwlLmv1eGCRkrpsJhdlas7hR
        elMI6FydG2ZOZlbup83LNxFuarZ1NZ5JqY8mvNMoHD7sEBv1ErqLVCciPUuzGKLPfolQ6p
        urhAWlivmxCZFE6c0XNthfgc0oI8+Uo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-N2um_AZlNSiS_o-Hq09pOw-1; Fri, 11 Aug 2023 11:43:03 -0400
X-MC-Unique: N2um_AZlNSiS_o-Hq09pOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1B22800C7A
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Aug 2023 15:43:02 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.194.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B6132026D4B;
        Fri, 11 Aug 2023 15:43:01 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com,
        Eder Zulian <ezulian@redhat.com>
Subject: [PATCH v2] rt-tests: cyclictest: Remove warnings due different signedness in comparison
Date:   Fri, 11 Aug 2023 17:42:47 +0200
Message-Id: <20230811154247.481194-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Type casting used to remove compiler warnings due to comparison of
integer expressions of different signedness.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
v2: Cleaned up coding style and addressed review comments

 src/cyclictest/cyclictest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4a7108e..179ae8b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -317,8 +317,10 @@ static int raise_soft_prio(int policy, const struct sched_param *param)
 		return err;
 	}
 
-	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : rlim.rlim_cur;
-	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : rlim.rlim_max;
+	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? (unsigned int)policy_max
+						    : rlim.rlim_cur;
+	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? (unsigned int)policy_max
+						    : rlim.rlim_max;
 
 	if (prio > soft_max && prio <= hard_max) {
 		rlim.rlim_cur = prio;
-- 
2.39.3

