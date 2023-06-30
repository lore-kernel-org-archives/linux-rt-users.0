Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C7C001B0
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 09:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF3JXJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjF3JWu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B244BE
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688116840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItCqZdAEvU3sK4cB8FOoCCtgA98EoLT/V3DYj8EOaeo=;
        b=Lx0WAsS3S8D8lVAWaC1tmmXvOmw7HQV2Ur/657bZVTWUicWH1uhbtvsm74eW7w8pdIJO0n
        g/GQrMpQUlAVnh4Wqof7sRfp6Nt6WXKMEf0oG0P59xW25qBD2iEvysAzoznPxWsmtkYljw
        u/HPdboadFnxVhEo4t9peh326wbxmag=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-wiI6A2XHOB-1oqWMtR3y8A-1; Fri, 30 Jun 2023 05:20:37 -0400
X-MC-Unique: wiI6A2XHOB-1oqWMtR3y8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07A513C100C7
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 09:20:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3438140C6CCD;
        Fri, 30 Jun 2023 09:20:36 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/6] rteval: Exclude isolcpus from stressng by default
Date:   Fri, 30 Jun 2023 11:19:05 +0200
Message-ID: <20230630091951.916865-5-tglozar@redhat.com>
In-Reply-To: <20230630091951.916865-1-tglozar@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Note: this has little effect now, because the cpus variables is only
used for removing empty nodes unless a cpulist is specified by the user.
However, this can change in the future.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/loads/stressng.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 85cb473..800fdec 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -9,6 +9,7 @@ from rteval.Log import Log
 from rteval.systopology import CpuList, SysTopology
 
 expand_cpulist = CpuList.expand_cpulist
+nonisolated_cpulist = CpuList.nonisolated_cpulist
 
 class Stressng(CommandLineLoad):
     " This class creates a load module that runs stress-ng "
@@ -69,6 +70,10 @@ class Stressng(CommandLineLoad):
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
                 cpus[n] = [c for c in cpus[n] if c in expand_cpulist(self.cpulist)]
+            # if a cpulist was not specified, exclude isolated cpus
+            else:
+                cpus[n] = CpuList.nonisolated_cpulist(cpus[n])
+
 
         # remove nodes with no cpus available for running
         for node, cpu in cpus.items():
-- 
2.41.0

