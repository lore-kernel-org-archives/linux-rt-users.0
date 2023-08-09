Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD50C0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjHIT2i (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjHIT2h (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B33735B5
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Da+DtvRkSbO27NO+5aMPklL8ud7XwJ5PlG0ARcfYFHs=;
        b=Eo3NQVI8KX5x2eW8L2GZz14kLVJTSQKhwK/g3VHm7QNIRd9khX4zu52hWq2oEQK6cr9+tg
        QI5v1B4Mmic30PtZQmIg+lEAPWd/qBk+dEGb8ab8sckczuvAWKKhlO2ROzVIwkxfSahuTI
        ffgSwge2xxeBOGUHIc5Ukj4/vNg2aBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-lXebByqYOVi_gy_N1ThSSA-1; Wed, 09 Aug 2023 15:18:00 -0400
X-MC-Unique: lXebByqYOVi_gy_N1ThSSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B205101AA78
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:18:00 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9345C40C6F4E;
        Wed,  9 Aug 2023 19:17:59 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 81/86] rteval: Replace GPL license notice with SPDX tag in rteval_xmlrpc.wsgi
Date:   Wed,  9 Aug 2023 21:15:43 +0200
Message-Id: <20230809191548.359938-82-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in rteval_xmlrpc.wsgi.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/rteval_xmlrpc.wsgi | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/server/rteval_xmlrpc.wsgi b/server/rteval_xmlrpc.wsgi
index 37f1665..1bf6661 100644
--- a/server/rteval_xmlrpc.wsgi
+++ b/server/rteval_xmlrpc.wsgi
@@ -1,29 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 #   rteval_xmlrpc.wsgi
 #   XML-RPC handler for the rteval server, using mod_wsgi
 #
 #   Copyright 2011 - 2013   David Sommerseth <davids@redhat.com>
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
 
 from wsgiref.simple_server import make_server
 import types
-- 
2.39.3

