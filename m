Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C755C7EE2E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 19:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjFATbb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 15:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFATb2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 15:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD4189
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685647841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQ0hh2c8Huh/eKpAsqGhwwpPLifbHs1YpZ5kWxuoRiM=;
        b=SUWAQ4bNMki5awMWCRip5RKD1f2rFBnkUBY5EeedMIpXHGHyXmw0b3D8jpmo3N5uDoUfd+
        rhsn4QRRVks2VhobhjSQIpmSQ6E1wo4OM69EKvGa3Gc2LOLH2T+jIDXuJC71by5Y385bLB
        Zyw0rRCgKqNogmBs/vwZpps6oXTSumg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-r0ys3hbdM1ae4ug5J9KV1w-1; Thu, 01 Jun 2023 15:30:40 -0400
X-MC-Unique: r0ys3hbdM1ae4ug5J9KV1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1440E1C12F83
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 19:30:40 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5894200AE6F;
        Thu,  1 Jun 2023 19:30:39 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 02/10] rteval: Use f-strings in rtevalConfig
Date:   Thu,  1 Jun 2023 15:29:21 -0400
Message-Id: <20230601192928.809434-2-ashelat@redhat.com>
In-Reply-To: <20230601192928.809434-1-ashelat@redhat.com>
References: <20230601192928.809434-1-ashelat@redhat.com>
MIME-Version: 1.0
rteval: Use f-strings in rtevalConfig
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

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

