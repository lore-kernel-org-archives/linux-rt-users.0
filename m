Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48166C001E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjHITUW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjHITUV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 15:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF526B3
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFRdwr5/oPNZ/Kqd2YvFL6V5XD9KgT7KIlqpZjk9ZAk=;
        b=I9Vb9rDQuC7oahc3D4lzhhQZxdT3s9c19TV4Io3vTGJrTJntb6K1Rw8ZXXCIBdirv/qJK1
        GTlb7qlCTeTwC/3kTfbKkqalSURPdT5nT7DAq0qkdFV1h/urfpOp4xHNadKSVHGztP8I4z
        x7idVKwhtuG+7iD2xZUHJgcLZdKmLww=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-_rdBvx5hPd-WHYp4t4hClA-1; Wed, 09 Aug 2023 15:16:12 -0400
X-MC-Unique: _rdBvx5hPd-WHYp4t4hClA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA1C13C0C4B2
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 19:16:11 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.192.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EED8140C125C;
        Wed,  9 Aug 2023 19:16:10 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH 06/86] rteval: Add SPDX-License-Identifier tag to cmdline.py
Date:   Wed,  9 Aug 2023 21:14:28 +0200
Message-Id: <20230809191548.359938-7-ezulian@redhat.com>
In-Reply-To: <20230809191548.359938-1-ezulian@redhat.com>
References: <20230809191548.359938-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the SPDX-License-Identifier tag to cmdline.py.

As this file does not contain direct license references it falls under the project license, i.e., GPL v2 or later.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 rteval/sysinfo/cmdline.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rteval/sysinfo/cmdline.py b/rteval/sysinfo/cmdline.py
index 7e7566a..74d37d3 100644
--- a/rteval/sysinfo/cmdline.py
+++ b/rteval/sysinfo/cmdline.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 import sys, os, readline, libxml2
 from rteval.Log import Log
 
-- 
2.39.3

