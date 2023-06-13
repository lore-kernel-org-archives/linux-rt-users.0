Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEBFEB64D0
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Jun 2023 18:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjFMSJR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjFMSJP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jun 2023 14:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4FC19B3
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jun 2023 11:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686679722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kdP/31k7zZmBtOFLfVi5hBuMNSFO6/tqAmpgCZTX1Mw=;
        b=h6aD3nlEZ7dlu+jZmfLqzebSWbltTv3KpQTUsaMAlX2P4ZCZMu5IwHoRlemwVKs9Jg8U/G
        0JZG+EACC4XWMtuDxKORrRNLF8Fz4WrXlvXaVEm6iRSy7bN3ejKvFs0ZtN8K4GY2VtfSc9
        jppFVUltSR+JchtHUjIfCFO2CgkrQP8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-mSWJNGHrMSWy2gkBz4clnw-1; Tue, 13 Jun 2023 14:08:40 -0400
X-MC-Unique: mSWJNGHrMSWy2gkBz4clnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24A2A3850550
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jun 2023 18:08:38 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.11.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0612C40CFD01;
        Tue, 13 Jun 2023 18:08:37 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] rteval-cmd: If no kernel version is provided to -S/--source-download, download default kernel version
Date:   Tue, 13 Jun 2023 14:08:28 -0400
Message-Id: <20230613180828.1235964-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Previously, the usuage was "./rteval-cmd -S [KERNEL_VERSION]", and
rteval-cmd would throw an error if no kernel version was provided.
Now, rteval-cmd will download the default kernel version, as specified
in rteval/modules/loads/kcompile.py.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index cf9326e7dfdd..cbba9cd2e451 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -168,11 +168,13 @@ def parse_options(cfg, parser, cmdargs):
                       help='print rteval version and exit')
     # if the -S/--source-download option doesn't include the version, set version to default
     ind = None
-    if sys.argv.count("-S") > 0: ind = sys.argv.index("-S")
-    elif sys.argv.count("--source-download") > 0: ind = sys.argv.index("--source-download")
+    if sys.argv.count("-S") > 0:
+        ind = sys.argv.index("-S")
+    elif sys.argv.count("--source-download") > 0:
+        ind = sys.argv.index("--source-download")
     if ind != None:
-        if ind+1 == len(sys.argv): 
-            sys.argv.insert(ind+1, ModuleParameters()["source"]["default"].strip(".tar.xz"))
+        if ind+1 == len(sys.argv):
+            sys.argv.insert(ind+1, ModuleParameters()["source"]["default"].replace(".tar.xz", ""))
         cmdargs.append(sys.argv[ind+1])
 
     parser.add_option("-S", "--source-download", dest="rteval___srcdownload",
-- 
2.31.1

