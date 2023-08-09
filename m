Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C7C0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjHITSx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjHITSq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA42D66
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smJ0RAowlov+c0kvciK5Z4gD4TL2CTjorKOp6OCnGBs=;
        b=jDYMOWafnLuu4bB8buIkIDTjl7bdHxfaXJQ9DaAJlRT6dn9C3kN3PhGcyo4vjvVKk7zpl1
        wyYL/DH6JO7xDB5lIp0RYM3aOPXIr8uMlJZ/9Ro82CXQAF6/wYgP9o5LrUR6snQh/UisVh
        U6fKIwiiGusgVD4LxKlvTk/BuM7svDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-h_y3LNK0Pcadq8LoCkVI3Q-1; Wed, 09 Aug 2023 15:17:42 -0400
X-MC-Unique: h_y3LNK0Pcadq8LoCkVI3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A23D185A78F
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:42 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E96940C125C;
        Wed,  9 Aug 2023 19:17:41 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 66/86] rteval: Replace GPL license notice with SPDX tag in log.c
Date:   Wed,  9 Aug 2023 21:15:28 +0200
Message-Id: <20230809191548.359938-67-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in log.c.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/parser/log.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/server/parser/log.c b/server/parser/log.c
index 4d1de16..9a21326 100644
--- a/server/parser/log.c
+++ b/server/parser/log.c
@@ -1,14 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2009 Red Hat Inc.
  *
- * This application is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; version 2.
- *
- * This application is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 /**
-- 
2.39.3

