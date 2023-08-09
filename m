Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4918BC001DE
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjHITYw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjHITYg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C489D1724
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQI4YYjIMHqrjMvZQJyS/x5LQcl0UmF61ZpQL03aiYc=;
        b=RNqI1pke3zS7mJAqA3tM+uAsYpRItcqRNjLumQ+XeiSrUbB4G+9v+fZPYOVpq8FdEAmJMP
        VoM2CfLgSFy4g3KT3PWZ9l4Oup4uPPH6I5iHncTBZl1JLWCIy89R5WCx04tR1pfJKdxsj3
        l+dKC4/Kajx9TJOEVVNbcjemAwccFr4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-I3AL4iWgOF-MbM9AycxO3Q-1; Wed, 09 Aug 2023 15:16:54 -0400
X-MC-Unique: I3AL4iWgOF-MbM9AycxO3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0A778DC665
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:53 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4B1740D2839;
        Wed,  9 Aug 2023 19:16:52 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 40/86] rteval: Replace GPL license notice with SPDX tag in dmi.py
Date:   Wed,  9 Aug 2023 21:15:02 +0200
Message-Id: <20230809191548.359938-41-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace GPL boilerplate with SPDX-License-Identifier tag in dmi.py.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 rteval/sysinfo/dmi.py | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
index 89a7faa..e8285d2 100644
--- a/rteval/sysinfo/dmi.py
+++ b/rteval/sysinfo/dmi.py
@@ -1,28 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 #   Copyright 2009 - 2013   Clark Williams <williams@redhat.com>
 #   Copyright 2009 - 2013   David Sommerseth <davids@redhat.com>
 #   Copyright 2022          John Kacur <jkacur@redhat.com>
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
 """ dmi.py class to wrap DMI Table Information """
 
 import sys
-- 
2.39.3

