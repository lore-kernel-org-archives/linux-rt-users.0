Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8937DC0015E
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjHITSc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjHITSa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4493E359B
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rr0f7DDoUZuHIVOHjSUS7gtAEWHtVDY61uk8tMGHm8=;
        b=IKsdpy1e9QFxfGZCGKqVqaZHPeS6rdgELAvVUexBX+YxYPjiU1qBoeXh9CRy6JKGPu/SEH
        4wB5tKDVtaYhO06qVfEKa35Zhz8EWN16Rk2kbc3tkr1wMBWmxwwMItb+5Cqm1u6fvwvLzI
        tusOsD/U3oDyyzJG54K/26c2zy6B0k4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-vqNzSPdONoyqBv0RBpktBg-1; Wed, 09 Aug 2023 15:16:46 -0400
X-MC-Unique: vqNzSPdONoyqBv0RBpktBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B8428DC671
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:46 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5139040D2839;
        Wed,  9 Aug 2023 19:16:45 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 34/86] rteval: Replace GPL license notice with SPDX tag in rtevalMailer.py
Date:   Wed,  9 Aug 2023 21:14:56 +0200
Message-Id: <20230809191548.359938-35-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in rtevalMailer.py.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 rteval/rtevalMailer.py | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/rteval/rtevalMailer.py b/rteval/rtevalMailer.py
index f8f84d1..ef3b571 100644
--- a/rteval/rtevalMailer.py
+++ b/rteval/rtevalMailer.py
@@ -1,28 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 #   rtevalmailer.py - module for sending e-mails
 #
 #   Copyright 2009 - 2013   David Sommerseth <davids@redhat.com>
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
 
 import smtplib
 import email
-- 
2.39.3

