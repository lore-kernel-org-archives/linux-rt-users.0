Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD8C001E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjHITZE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjHITYq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67983ABB
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7zcAH8y5wG/p+pCNzUkvqrzLpGUxuI7N9d2SB0S8Lo=;
        b=W7KeLXtYsAmGX82sUqg5D/4Ew2LxaglA28p7Go+eM29yRDcoo4jCCNRRapredBiMbtJgZg
        Jliz2d814cIwDOFhIa4sUISkcz2BymscipnDnyRjZD0ce7B9Z2Tf55MMGF5f+h9KQEkNeY
        KMJyZVdI/M2zVaKirWJ0zfYsYZmc+BM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-NCAtXSbSO3iM2NqqlzUKzA-1; Wed, 09 Aug 2023 15:17:19 -0400
X-MC-Unique: NCAtXSbSO3iM2NqqlzUKzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2C34101A5B9
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:18 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C97B040C125C;
        Wed,  9 Aug 2023 19:17:17 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 47/86] rteval: Replace GPL license notice with SPDX tag in version.py
Date:   Wed,  9 Aug 2023 21:15:09 +0200
Message-Id: <20230809191548.359938-48-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in version.py.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 rteval/version.py | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/rteval/version.py b/rteval/version.py
index bedec09..ad7fff8 100644
--- a/rteval/version.py
+++ b/rteval/version.py
@@ -1,26 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 #   Copyright 2015  Clark Williams <williams@redhat.com>
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
 
 RTEVAL_VERSION = '3.6'
-- 
2.39.3

