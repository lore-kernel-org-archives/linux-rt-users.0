Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7193DC0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjHITS5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjHITSt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3D3C31
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jLMAavYtldG4X2h39AIu6pviLOv+zB1HTIpKJqXMKI=;
        b=iQkwHCLAxr9B4pnsqhB535s9Rsd2jKYHu51BV6WrtCWIls7atIHI/JTbDc8SkR+23XBpRo
        oIVazJ4wf8F4ijsRm7JmrSr8TWyBndBBF6yXyx2gTj9h7Z6paSUu+8vuoPqvQhaV0+ptfR
        EimMsOiFjNzUY9UbrA8XP2c+YvcZ9EQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616--khzrBX1M7-Cs-050LPdbQ-1; Wed, 09 Aug 2023 15:17:39 -0400
X-MC-Unique: -khzrBX1M7-Cs-050LPdbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA88D185A791
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:39 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD19740C125C;
        Wed,  9 Aug 2023 19:17:38 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 64/86] rteval: Replace GPL license notice with SPDX tag in eurephia_xml.c
Date:   Wed,  9 Aug 2023 21:15:26 +0200
Message-Id: <20230809191548.359938-65-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in eurephia_xml.c.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/parser/eurephia_xml.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/server/parser/eurephia_xml.c b/server/parser/eurephia_xml.c
index c8c389e..0679956 100644
--- a/server/parser/eurephia_xml.c
+++ b/server/parser/eurephia_xml.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /* eurephia_xml.c  --  Generic helper functions for XML parsing
  *
  * This version is modified to work outside the eurephia project.
@@ -5,20 +6,6 @@
  *  GPLv2 only - Copyright (C) 2008, 2009
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
- *
  */
 
 /**
-- 
2.39.3

