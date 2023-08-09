Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086F6C0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjHITZD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjHITYq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D827930E2
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az3KD3+HTJt6nT9ygTbdP8C/gVYtMwqkp8jjW0KuUFE=;
        b=e/OKiuylCx1S7aPH6X6mycSlnetRgO4QhYK15Hd1ObJZtGSWPjBIhsRsaoQPb4wmG2kSeu
        CxbUFVxTq6vBfFlMogSnireP7t2sSitK2FwlZ3ZgcTAPlEptP46fXE47u96gAvATPU25YP
        pZsCbFe8b+N6WEbB5gASCWGXNJpGL54=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-0p697kdNMIG7uJ_chPZ2DA-1; Wed, 09 Aug 2023 15:16:31 -0400
X-MC-Unique: 0p697kdNMIG7uJ_chPZ2DA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 590D2857A84
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:31 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA6640C6E8A;
        Wed,  9 Aug 2023 19:16:30 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 22/86] rteval: Add SPDX-License-Identifier tag to setup.py
Date:   Wed,  9 Aug 2023 21:14:44 +0200
Message-Id: <20230809191548.359938-23-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the SPDX-License-Identifier tag to setup.py.

As this file does not contain direct license references it falls under the project license, i.e., GPL v2 or later.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 setup.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.py b/setup.py
index bcf7330..c2695cb 100644
--- a/setup.py
+++ b/setup.py
@@ -1,4 +1,5 @@
 #!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0-or-later
 """ install rteval """
 import sysconfig
 from os.path import relpath
-- 
2.39.3

