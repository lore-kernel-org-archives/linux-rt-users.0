Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E83C0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHITSS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHITSQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B32697
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fQ4DLXqVFdOSU9WyjG0aQkVDiLc8aa8D6QmlQ00x9M=;
        b=XPx/Ghz1wZcttPO53esUSDFshRWLDIrCZzYBZtTJZsjmdr/aZzIZqmGO34PkfWfTx9Sp7a
        X3PgowxfxZ9A+WaAucehz37wtT9+sWimP64XkyRJbr1xPL1yv774A1uV3pjVstXPY4fPjZ
        wukSEHedbk0RK4pHtkNAjqt5gAJXaXo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-5BxY_8eXP4-dUxVA5WpZ5g-1; Wed, 09 Aug 2023 15:16:11 -0400
X-MC-Unique: 5BxY_8eXP4-dUxVA5WpZ5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A14911C05133
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:10 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB4FF40C6E8A;
        Wed,  9 Aug 2023 19:16:09 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 05/86] rteval: Add SPDX-License-Identifier tag to rteval_text.xsl
Date:   Wed,  9 Aug 2023 21:14:27 +0200
Message-Id: <20230809191548.359938-6-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the SPDX-License-Identifier tag to rteval_text.xsl.

As this file does not contain direct license references it falls under the project license, i.e., GPL v2 or later.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 rteval/rteval_text.xsl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index 0ef649b..f526526 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -1,4 +1,5 @@
 <?xml version="1.0"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
 <xsl:stylesheet  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>
 
-- 
2.39.3

