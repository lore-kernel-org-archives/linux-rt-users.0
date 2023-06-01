Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9F8C7EE23
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjFAU2y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjFAU2w (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD081189
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axx1XRtQrYGyTMCm6dkt6vCwJ6R10WhsaMgu9FrLrGo=;
        b=MUXanFLNK1ZRq0AWWMIclO4E7P981OJ56Y9rIaN/D9bdU1qlcVr/g5KTh5e+F71cjtMV7Q
        AL8eN1Hk9HH//g1xcPFjNKFLqOGiC0dXbNHfy1uIKhOzFyURKE7axZdy6VGuskxZKClfsk
        g0Tj/YEG9/4XcegHvnolasbWF0ChlWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-OspKPa-7PIexhj7AGDEX4A-1; Thu, 01 Jun 2023 16:28:00 -0400
X-MC-Unique: OspKPa-7PIexhj7AGDEX4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EE97811E7F
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F732C154D9;
        Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 08/10] rteval: Use f-strings in tools.py
Date:   Thu,  1 Jun 2023 16:27:34 -0400
Message-Id: <20230601202734.813515-9-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in tools.py

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

