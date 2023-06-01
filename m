Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E22C77B7E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjFAU2w (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjFAU2u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036F4134
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YODz8Xh2vnjPLXNUN/Kl69VYCg6jX1oU9RSU3IE59qQ=;
        b=Y9r+YRGzZtMDejgr08ScuAS5Zl+LgsRCNWBvsTJDvtD2W9AmUuVqei3Zt6kpXr4fdpdzAy
        97v8u6cJ2v7JNbWY7ngQUlT6XOPmsDhbxMOWvM6tq8Mlhx3o7wbD86jQzjK7dOjAXzVvnk
        b1s8GwOZtGlbV2j5p5hjERNxwRNj3lc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-plvLMV6ENoKcWDTK_6rIwg-1; Thu, 01 Jun 2023 16:27:59 -0400
X-MC-Unique: plvLMV6ENoKcWDTK_6rIwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8178A800BFF
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EEE6C154D9;
        Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 03/10] rteval: Use f-strings in cputopology
Date:   Thu,  1 Jun 2023 16:27:29 -0400
Message-Id: <20230601202734.813515-4-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in cputopology

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/cputopology.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rteval/sysinfo/cputopology.py b/rteval/sysinfo/cputopology.py
index ced7e1f295b7..2bb632312320 100644
--- a/rteval/sysinfo/cputopology.py
+++ b/rteval/sysinfo/cputopology.py
@@ -124,9 +124,7 @@ def unit_test(rootdir):
         x.saveFormatFileEnc('-', 'UTF-8', 1)
 
         print(" ---- getCPUcores() / getCPUscokets() ---- ")
-        print("CPU cores: %i (online: %i) - CPU sockets: %i" % (cputop.cpu_getCores(False),
-                                                                cputop.cpu_getCores(True),
-                                                                cputop.cpu_getSockets()))
+        print(f"CPU cores: {cputop.cpu_getCores(False)} (online: {cputop.cpu_getCores(True)}) - CPU sockets: {cputop.cpu_getSockets()}")
         return 0
     except Exception as e:
         # import traceback
-- 
2.31.1

