Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB95C7EE23
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjFAU2o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFAU2n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA76128
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IH1I3acNZ/TnBBcb1Ef9K+M/EqDg4dnqPx6vrGJKG/w=;
        b=W44OFfmPdp6wFToCm+rkQJhuDH5UBmNgAzgho2AjXHwkQLS5jo1ERvCfgxWIC8ZlGIrrvs
        ilAsv+7d/e66sByirvsxVogOuDrT6TUxKhW4qnEzUjqjivj9rm/WFOoP+sh2RQXVbpuV9j
        VGbi6brdJ5ZsBVrA8VdR83Nn8vJ3wzk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-QgcG9CjONH6XhNhX9sq9pw-1; Thu, 01 Jun 2023 16:27:55 -0400
X-MC-Unique: QgcG9CjONH6XhNhX9sq9pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2418D1C05152
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:27:55 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 064F1C154D9;
        Thu,  1 Jun 2023 20:27:54 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 01/10] rteval: Use f-strings in rtevalclient.py
Date:   Thu,  1 Jun 2023 16:27:27 -0400
Message-Id: <20230601202734.813515-2-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in rtevalclient.py

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/rtevalclient.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/rtevalclient.py b/rteval/rtevalclient.py
index 26c953005326..7ff7d2700cfc 100644
--- a/rteval/rtevalclient.py
+++ b/rteval/rtevalclient.py
@@ -61,7 +61,7 @@ class rtevalclient:
         cmpr = compr.compress(fbuf.getvalue())
         data = base64.b64encode(cmpr + compr.flush())
         ret = self.srv.SendReport(self.hostname, data)
-        print("rtevalclient::SendReport() - Sent %i bytes (XML document length: %i bytes, compression ratio: %.02f%%)" % (len(data), doclen, (1-(float(len(data)) / float(doclen)))*100 ))
+        print(f"rtevalclient::SendReport() - Sent {len(data)} bytes (XML document length: {doclen} bytes, compression ratio: {(1-(float(len(data)) / float(doclen)))*100}:.2f)")
         return ret
 
     def SendDataAsFile(self, fname, data, decompr = False):
-- 
2.31.1

