Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19190C001DE
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjHITSU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjHITSR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E219E3C21
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiT1dsU9b4JJJD4XDqYu+7xoY1r4grX6uWUKJ8GIXM8=;
        b=SkvrJuyyO5CZxOpKkVkCrnuLOKw3IkA3mokrLHgkpezXz6zhpjTG8LISWxsBjyL3qGRjhl
        Muv0YpPjxhvAqLrZlf70ZNB1v6LbmZL/gaLVdQcu3Z8/VErC2SzEl5tSrm9BN29mosXNLa
        Pdo+IFRnJOqGIVXDMBos37t/OpmI0NU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-ymqIN3-3NnGdG4xv_5Lt_Q-1; Wed, 09 Aug 2023 15:16:05 -0400
X-MC-Unique: ymqIN3-3NnGdG4xv_5Lt_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BA4628EA6F4
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:05 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5525840C125C;
        Wed,  9 Aug 2023 19:16:04 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 01/86] rteval: Add SPDX-License-Identifier tag to Makefile
Date:   Wed,  9 Aug 2023 21:14:23 +0200
Message-Id: <20230809191548.359938-2-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the SPDX-License-Identifier tag to Makefile.

As this file does not contain direct license references it falls under the project license, i.e., GPL v2 or later.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 81ca824..b73e8c1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 HERE	:=	$(shell pwd)
 ifneq (, $(wildcard /usr/bin/python3))
 	PYTHON = python3
-- 
2.39.3

