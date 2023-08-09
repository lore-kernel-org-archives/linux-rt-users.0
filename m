Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AEDC001E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjHITSg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjHITSc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D9E421A
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRbkWQsQDoZhf9dOyvh6zb/21XkhCV2rMlwz+TCiDs8=;
        b=LUb4HaO8S7cNmaXldUrAfKennwC8jamaGu+he+OG7biklymGtQ/uManqmkZRTe+qrbFExj
        KPcrz/oaa7ERV8z0M8iNQ4rX14qeJueMyQrd1MHufpo1gNWgvspIsWQY8HRo/bx4KZMPKn
        WnzG3BkvGT0E8vHokFeVIo0RqFv55/4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-IJur5ITlOSOOjdQ5YlTPNA-1; Wed, 09 Aug 2023 15:16:37 -0400
X-MC-Unique: IJur5ITlOSOOjdQ5YlTPNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56EA43C0C881
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:36 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 607DD40C6E8A;
        Wed,  9 Aug 2023 19:16:35 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 26/86] rteval: Replace GPL license notice with SPDX tag in __init__.py
Date:   Wed,  9 Aug 2023 21:14:48 +0200
Message-Id: <20230809191548.359938-27-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in __init__.py.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 rteval/modules/__init__.py | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 794135d..e7025ce 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -1,26 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 #   Copyright 2012 - 2013   David Sommerseth <davids@redhat.com>
 #
-#   This program is free software; you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#   GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License along
-#   with this program; if not, write to the Free Software Foundation, Inc.,
-#   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-#   For the avoidance of doubt the "preferred form" of this code is one which
-#   is in an open unpatent encumbered format. Where cryptographic key signing
-#   forms part of the process of creating an executable the information
-#   including keys needed to generate an equivalently functional executable
-#   are deemed to be part of the source code.
-#
 
 import time
 from datetime import datetime
-- 
2.39.3

