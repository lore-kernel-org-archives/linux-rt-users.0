Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A737C001E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjHITTA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjHITSx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2272D74
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrRGOEHYA/z1Z26Zr6p0V55V5FL1TDv126NlUP4MADk=;
        b=V3OMIPDEKrI9PV5Sge17LoLrnQMv410O1N9ZjiKr+BsRT9rJB4/HdR6Jry8mwDmY87/HT+
        yIdjVcAyX3Iw+wvVLhzfYEL9cPVm+TAw58Qnp8R+kvmo9oHo8CXZNW5SPAps1NYYHMFXff
        KJPtBnoagCRihtEUk6Urx/vR0VO7N/E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-H4Xm7FsmNEuKpiO1Mc3TbQ-1; Wed, 09 Aug 2023 15:17:47 -0400
X-MC-Unique: H4Xm7FsmNEuKpiO1Mc3TbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A19A8DC666
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:47 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20AF340C6F4E;
        Wed,  9 Aug 2023 19:17:45 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 70/86] rteval: Replace GPL license notice with SPDX tag in pgsql.c
Date:   Wed,  9 Aug 2023 21:15:32 +0200
Message-Id: <20230809191548.359938-71-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in pgsql.c.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/parser/pgsql.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/server/parser/pgsql.c b/server/parser/pgsql.c
index adf97c9..5492d02 100644
--- a/server/parser/pgsql.c
+++ b/server/parser/pgsql.c
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

