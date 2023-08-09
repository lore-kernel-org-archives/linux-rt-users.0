Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBB2C001E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjHITSz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjHITSs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A2326B3
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QMsu0rAZBBTjIN7UHZyqk20hLYvIE9X76JYS44fiUY=;
        b=UWUl0jKiM9NWW1AXwG/lwGX3PhU6ywbEY30vK2AAKnavgVweT/ZkqrinvyqFHapl0+17iM
        eeP2FbBzhgszy7dmBAsVpf9Va35V9JmEJ0+xYMDa76rp1DkDOzlDW5BVDIdoBCCQGF+5B8
        I+5Gjzkpfbt47bQeyevXXt486ac+al4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-xriJJZQ9OSOWRFVJ8j6tPw-1; Wed, 09 Aug 2023 15:17:36 -0400
X-MC-Unique: xriJJZQ9OSOWRFVJ8j6tPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF5068DC671
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:35 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D782400D700;
        Wed,  9 Aug 2023 19:17:34 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 61/86] rteval: Replace GPL license notice with SPDX tag in eurephia_values.c
Date:   Wed,  9 Aug 2023 21:15:23 +0200
Message-Id: <20230809191548.359938-62-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in eurephia_values.c.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/parser/eurephia_values.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/server/parser/eurephia_values.c b/server/parser/eurephia_values.c
index 6112cbd..8f3645a 100644
--- a/server/parser/eurephia_values.c
+++ b/server/parser/eurephia_values.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* eurephia_values.c  --  Generic interface for processing key->value pairs
  *
  * This version is modified to work outside the eurephia project.
@@ -5,19 +6,6 @@
  *  GPLv2 only - Copyright (C) 2008
  *               David Sommerseth <dazo@users.sourceforge.net>
  *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; version 2
- *  of the License.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
 /**
-- 
2.39.3

