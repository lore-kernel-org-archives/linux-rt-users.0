Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5D9C001E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 21:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjHHV2l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjHHV2l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 17:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925EF49D8
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691529407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=69TQMjhWD0QOuig/2t5c5pzajk/nPj5rFAKJGe5VjA4=;
        b=cRF8Ct8aJW/nhAuIP7s4d2ajXxJdMcY2d0yI+LvY2ei2hHk09KvmQV5fyG4NNS9e1OMk1Y
        yS7fPOBgMK8+SXTzOl/4EerurLPVH1LbqtpynEUGzHL4gZEMsZtJ18Xcfy/bQVbOKJWHEn
        Qw9o4NJ+LBXXJ8XLaGEdQU6V/DFrX5E=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-K2BeFZaUNa69YIoMsofzkQ-1; Tue, 08 Aug 2023 17:16:44 -0400
X-MC-Unique: K2BeFZaUNa69YIoMsofzkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FA322834760
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 21:16:44 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.194.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B56BC15BB8;
        Tue,  8 Aug 2023 21:16:43 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH] rt-tests: Add __pycache__/ to .gitignore
Date:   Tue,  8 Aug 2023 23:16:15 +0200
Message-Id: <20230808211615.281193-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add __pycache__/ to .gitignore so that it will be ignored by git.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 61fb49c..7fef7de 100644
--- a/.gitignore
+++ b/.gitignore
@@ -47,3 +47,4 @@ tags
 TAGS
 cscope.*
 src/cyclictest/__pycache__/
+__pycache__/
-- 
2.39.3

