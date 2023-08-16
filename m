Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C5FC41513
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Aug 2023 06:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbjHPG6r (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Aug 2023 02:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242224AbjHPG6l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Aug 2023 02:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5605A1FCE
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Aug 2023 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692169072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSDwTEYC9tk4L9pE6MkNuD7RkHl21TZhSlOz7SbFcjA=;
        b=efARiiVgKT5bOdRswCWhSUKP1gHSr8C+TbmWZ6QVSAARZWVnJ4dc+8zKf8cbIK+Y0NW0z+
        s2NqSYTAuCOC2RT1Ddhu1Y4kpP/EuzeT8e1hXRFgoQbc6xhtRNFJdkTXHKCf7Sq2U0pvLD
        dvI4cO/g7DT9sHh2XDZodMLxBO/RzMQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-u0y2CamHPcmsRnHWqlvfMQ-1; Wed, 16 Aug 2023 02:57:49 -0400
X-MC-Unique: u0y2CamHPcmsRnHWqlvfMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B23A23804528
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Aug 2023 06:57:48 +0000 (UTC)
Received: from fedora.. (unknown [10.43.17.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24FA340C207A;
        Wed, 16 Aug 2023 06:57:48 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/2] rteval: Set higher cyclictest bucket count on non-RT kernels
Date:   Wed, 16 Aug 2023 08:57:40 +0200
Message-ID: <20230816065740.283407-3-tglozar@redhat.com>
In-Reply-To: <20230816065740.283407-1-tglozar@redhat.com>
References: <20230816065740.283407-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Make the default for --cyclictest-buckets 50000 instead of 3500 on
non-RT kernels to make overflowing much less likely.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 50b2e2a..addd8da 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -434,7 +434,8 @@ def ModuleParameters():
                          "default": 100,
                          "metavar": "INTV_US"},
             "buckets":  {"descr": "Histogram width",
-                         "default": 3500,
+                         "default": 3500 if "RT " in os.uname().version else 50000,
+                         "default_text": "3500 when running on a RT kernel, 50000 otherwise",
                          "metavar": "NUM"},
             "priority": {"descr": "Run cyclictest with the given priority",
                          "default": 95,
-- 
2.41.0

