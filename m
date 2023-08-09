Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C505C001DE
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjHITS1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHITS0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CAD30DE
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=149hPjijtkCZll34ZAAQt/7+q6vvsdPPZxuvJO//YM8=;
        b=XB6kWF0PUanf8hTuAOX+aJk+hYhhGRnGlnCWgfACxIpgMOStjDS1iof+J29IhUah3HD7kk
        MnAhvbiA7/nBhQCdd5xdhmp5GaC7I3H8XyG7uHpshPAxb1RyoA095Fxi/oMkdpoJOvvpBS
        aHlSWycp9WGWVOLlOykhf/QJobF0IW0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-rgU510-0P0eDTuTYYp05Dg-1; Wed, 09 Aug 2023 15:16:30 -0400
X-MC-Unique: rgU510-0P0eDTuTYYp05Dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 287828DC666
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:30 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E76440C125C;
        Wed,  9 Aug 2023 19:16:29 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 21/86] rteval: Add SPDX-License-Identifier tag to unittest.py
Date:   Wed,  9 Aug 2023 21:14:43 +0200
Message-Id: <20230809191548.359938-22-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the SPDX-License-Identifier tag to unittest.py.

As this file does not contain direct license references it falls under the project license, i.e., GPL v2 or later.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 server/unittest.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/server/unittest.py b/server/unittest.py
index 7dcdef0..73cee9d 100644
--- a/server/unittest.py
+++ b/server/unittest.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 import sys, threading, time, signal, libxml2
 import argparse
 from rteval_testserver import RTevald
-- 
2.39.3

