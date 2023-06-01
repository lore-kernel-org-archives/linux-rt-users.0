Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7016C7EE2D
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjFATcP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFATcM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 15:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E6192
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685647843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gw9sb8fMi5aYTmHsNwVlME0TmZSIXxWsDhOkH6wAcw8=;
        b=QwV9GGSuAOwyF2o32ZHNhwqcHMtxFSB+1/Bahx6hm6RAG2rBJTEshv2LXL+vfBdWZT0ll5
        OiRQtemtgluoXePrDbInm8lakZzp7KcbhSXlksRcUE/tcRTnj6EWa09yBYI0pDRAAvsyeT
        K/jofokQwIYHDvAA2bRFSDB1jrUDjnc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-It3itaDmOw-F_5mPxbKeqg-1; Thu, 01 Jun 2023 15:30:41 -0400
X-MC-Unique: It3itaDmOw-F_5mPxbKeqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FE38811E8F
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 19:30:41 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01D6D20296C6;
        Thu,  1 Jun 2023 19:30:40 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 08/10] rteval: Use f-strings in tools.py
Date:   Thu,  1 Jun 2023 15:29:27 -0400
Message-Id: <20230601192928.809434-8-ashelat@redhat.com>
In-Reply-To: <20230601192928.809434-1-ashelat@redhat.com>
References: <20230601192928.809434-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/tools.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/sysinfo/tools.py b/rteval/sysinfo/tools.py
index 3993da413d8a..aa00b3d3eafc 100644
--- a/rteval/sysinfo/tools.py
+++ b/rteval/sysinfo/tools.py
@@ -40,5 +40,5 @@ def getcmdpath(which):
                 pathSave[which] = cmdfile
                 break
         if not pathSave[which]:
-            raise RuntimeError("Command '%s' is unknown on this system" % which)
+            raise RuntimeError(f"Command '{which}' is unknown on this system")
     return pathSave[which]
-- 
2.31.1

