Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8807C001E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjHIT2p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjHIT2n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDAB2738
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GtcwyEkA/OkF9Q20x/RBeY3L6qtqlHcniuTdm1qf7Y=;
        b=Y1H29oVs6AZbSarseybxQbxAVdqSE4JDTkzxDcrw9WA5nwb1jyxSOKaCTXVCIEV+MLgcM/
        O7EepeUDiupKgtmuzVm6z61+27txG866chVIduYqJ5MRFCKBEPNQb1riBlw0ZRJ5l7hk+E
        3KU+69/9A1/iKuVD0MkEHXaqOckLIxE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-hVdHgNtkP6KcZa471CkJlg-1; Wed, 09 Aug 2023 15:17:56 -0400
X-MC-Unique: hVdHgNtkP6KcZa471CkJlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54D861C07255
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:54 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB5040BC780;
        Wed,  9 Aug 2023 19:17:53 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 76/86] rteval: Replace GPL license notice with SPDX tag in xmlparser.h
Date:   Wed,  9 Aug 2023 21:15:38 +0200
Message-Id: <20230809191548.359938-77-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in xmlparser.h.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/parser/xmlparser.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/server/parser/xmlparser.h b/server/parser/xmlparser.h
index cd7eb63..1aa3977 100644
--- a/server/parser/xmlparser.h
+++ b/server/parser/xmlparser.h
@@ -1,17 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2009 Red Hat Inc.
  *
  * David Sommerseth <davids@redhat.com>
  *
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

