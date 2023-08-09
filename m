Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C996AC04FDF
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjHITY5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjHITYl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB53ABA
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVGdecTfFtBpQb+188LzMp/slnD/1cSfZUkHfWckF/o=;
        b=L41CE2wm9mshZIA0hvp55ZRK8DKNAhno5RIlJCp3vjs+IxsaxjyFBGXymnUz7uv+oHdVnG
        nS6TbKthSBUYRrg+AaqE6mCHneeZ+2t08kYcg7jGYU4wFB6vKFKGpU589cJI4A+Gt6ZN9W
        rmx061j7FyOVTgNPQysYZsW9lvjl1J4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-wHZCEpYuPfuVzIDCIq1yng-1; Wed, 09 Aug 2023 15:17:22 -0400
X-MC-Unique: wHZCEpYuPfuVzIDCIq1yng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79FBB8015AA
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:17:22 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85D0340BC780;
        Wed,  9 Aug 2023 19:17:21 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 50/86] rteval: Replace GPL license notice with SPDX tag in apache-rteval-wsgi.conf.tpl
Date:   Wed,  9 Aug 2023 21:15:12 +0200
Message-Id: <20230809191548.359938-51-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in apache-rteval-wsgi.conf.tpl.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/apache-rteval-wsgi.conf.tpl | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/server/apache-rteval-wsgi.conf.tpl b/server/apache-rteval-wsgi.conf.tpl
index ab5d59f..c6cf00f 100644
--- a/server/apache-rteval-wsgi.conf.tpl
+++ b/server/apache-rteval-wsgi.conf.tpl
@@ -1,29 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # File: apache-rteval.conf
 #
 # Apache config entry to enable the rteval XML-RPC server
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
 
 WSGISocketPrefix /var/run/wsgi
 WSGIDaemonProcess rtevalxmlrpc processes=3 threads=15 python-path={_INSTALLDIR_}
-- 
2.39.3

