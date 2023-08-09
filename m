Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F73C04FDF
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjHITSs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjHITSp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E52139
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TI6cf4J4vNLswJ4CIs3EsXgnO34PZwp+vGsln9G7nQU=;
        b=V5yCg5J3SR3x1NotSOPemajuIAfk618iblYKTTau+os/AgovQauKH5avf5EDdzCw+wmnSt
        h25sx6hxBsVN5yWmyv0AF3WyH68wOUunGV+dW0O9OJ9S+bsI/R6rye+TUbhqTDTUUj7RHz
        w1P7cSdJM/QDsiWJrtNfANPLE6uG3KM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-j011EVWPPtWeCTCyPjrtLQ-1; Wed, 09 Aug 2023 15:17:30 -0400
X-MC-Unique: j011EVWPPtWeCTCyPjrtLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBC6685CCE2
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:29 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C844240C6F4E;
        Wed,  9 Aug 2023 19:17:28 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 56/86] rteval: Replace GPL license notice with SPDX tag in argparser.h
Date:   Wed,  9 Aug 2023 21:15:18 +0200
Message-Id: <20230809191548.359938-57-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in argparser.h.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/parser/argparser.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/server/parser/argparser.h b/server/parser/argparser.h
index 53214e1..5325505 100644
--- a/server/parser/argparser.h
+++ b/server/parser/argparser.h
@@ -1,14 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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

