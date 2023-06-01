Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B26C77B7E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjFAU2u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFAU2s (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DB18D
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5jojIhgYXpojgeDOl/uB2Vg72JmUsl9GK9YBHbiJRw=;
        b=YgOg1RmRm6dZiI9Zkfuo3hoU1lk+tmK0F4bB/W7pD6vXOjzlCo5dHkCHSt6xGGXatE4wAb
        CKPBs1DA5sGWubsi2m7xyGjFpS9jykC6mmPh07dne/3Q0hdn/tUfK+uNxAc+UZm+a6+Iug
        3Mwk3XwHQ9IAnfrGsQ+bMuy3uGxBER8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-WkBFrDahP5SFTFwe8KyOBg-1; Thu, 01 Jun 2023 16:27:59 -0400
X-MC-Unique: WkBFrDahP5SFTFwe8KyOBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53BDB101A53A
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31348C154D9;
        Thu,  1 Jun 2023 20:27:59 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 02/10] rteval: Use f-strings in rtevalConfig
Date:   Thu,  1 Jun 2023 16:27:28 -0400
Message-Id: <20230601202734.813515-3-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in rtevalConfig.py

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/rtevalConfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index de88924642ca..41f1a567720f 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -115,7 +115,7 @@ class rtevalCfgSection:
         "Simple method for dumping config when object is used as a string"
         if not self.__cfgdata:
             return "# empty"
-        return "\n".join(["%s: %s" % (k, v) for k, v in list(self.__cfgdata.items())]) + "\n"
+        return "\n".join([f"{k}: {v}" for k, v in list(self.__cfgdata.items())]) + "\n"
 
 
     def __setattr__(self, key, val):
-- 
2.31.1

