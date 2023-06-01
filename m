Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD9C77B7E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjFAU2z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjFAU2w (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B008D198
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0Z1yVlmIom9I0PFayqN7xLRtdMQMwSaZrgiuOlj0a0=;
        b=bT0x0io/lqof6k+QFsvToUoPnfXKu+OmRKS+nSrousee2oaMmhAHdmjvxUSS0dLW4K8hGi
        yWiztJS9dk9Cgdm3QMJjcGlnJV3XNAeyWWfV129kIk/eyz1FfxXlYUx9GZ5rY3gh/b+IqO
        goq94247KHJ6blDZoN7bBImULWuxmeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-COy9LbF9M22wFVHdGeSu0A-1; Thu, 01 Jun 2023 16:28:00 -0400
X-MC-Unique: COy9LbF9M22wFVHdGeSu0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB270811E85
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAD20C04492;
        Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 05/10] rteval: Use f-strings in memory.py
Date:   Thu,  1 Jun 2023 16:27:31 -0400
Message-Id: <20230601202734.813515-6-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in memory.py

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/memory.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rteval/sysinfo/memory.py b/rteval/sysinfo/memory.py
index 7c5fd6f315cf..cc2fa2cfa4be 100644
--- a/rteval/sysinfo/memory.py
+++ b/rteval/sysinfo/memory.py
@@ -49,7 +49,7 @@ class MemoryInfo:
             if l.startswith('MemTotal:'):
                 parts = l.split()
                 if parts[2].lower() != 'kb':
-                    raise RuntimeError("Units changed from kB! (%s)" % parts[2])
+                    raise RuntimeError(f"Units changed from kB! ({parts[2]})")
                 rawsize = int(parts[1])
                 f.close()
                 break
@@ -76,7 +76,7 @@ class MemoryInfo:
 
         memsize = self.mem_get_size()
         mem_n = libxml2.newNode("memory_size")
-        mem_n.addContent("%.3f" % memsize[0])
+        mem_n.addContent(f"{memsize[0]:.3f}")
         mem_n.newProp("unit", memsize[1])
         rep_n.addChild(mem_n)
 
@@ -88,8 +88,8 @@ def unit_test(rootdir):
     import sys
     try:
         mi = MemoryInfo()
-        print("Numa nodes: %i" % mi.mem_get_numa_nodes())
-        print("Memory: %i %s" % mi.mem_get_size())
+        print(f"Numa nodes: {mi.mem_get_numa_nodes()}")
+        print(f"Memory: {int(mi.mem_get_size()[0])} {mi.mem_get_size()[1]}")
     except Exception as e:
         import traceback
         traceback.print_exc(file=sys.stdout)
-- 
2.31.1

