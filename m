Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6EFC0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjHITTA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjHITSx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237D530D8
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BV88gFfJ+4JxALa/gbnOeK4jhEyfrkXe3o+KXhjmJlI=;
        b=hgrxmLFk2DcuLfFA76YQOfHRtRSWNeRmNATyoB3pAjhYWApRQZQ36QNMMp/wcYArTp+51Z
        MMwgFOX8SMetxsGeITCc/TKcg/HSZzaY0dbIiBjLjjiRF0TgCs43noJiKPlVgM1g7YYszE
        PR3PrkVWNnAmk7dCGE3sEjvHUynhvRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-vNdBalnBP8-hOqUiFeAHWA-1; Wed, 09 Aug 2023 15:17:50 -0400
X-MC-Unique: vNdBalnBP8-hOqUiFeAHWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1FF88030AC
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:50 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA3C640BC780;
        Wed,  9 Aug 2023 19:17:49 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 73/86] rteval: Replace GPL license notice with SPDX tag in statuses.h
Date:   Wed,  9 Aug 2023 21:15:35 +0200
Message-Id: <20230809191548.359938-74-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in statuses.h.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/parser/statuses.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/server/parser/statuses.h b/server/parser/statuses.h
index 0ac0ac6..a1beef6 100644
--- a/server/parser/statuses.h
+++ b/server/parser/statuses.h
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

