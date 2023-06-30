Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8288EB64DA
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 09:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjF3JXI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjF3JWu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A523C3D
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 02:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688116839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YHtiXHF3x88Mbfh5nqG2rDlSlojNSDSykq5kAPrIG8=;
        b=QaMEcgwSs5E6/dxSTzrJJP+VLHaqEL7p0C6wOO94OzlWpD8zGFBw2cmAJNZast8eTHhH/m
        W3XYKhRh0e7ZxMdEH005w3OUb6LU++WHtKaIakblH6EkOYwyhDsUnvne4RZjCY9PcTlr1R
        /LJqdf5+1rIVPjwFRkET2JOFRvE+WN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-ZK6PFqO1OqKRXgKSc5xfOw-1; Fri, 30 Jun 2023 05:20:38 -0400
X-MC-Unique: ZK6PFqO1OqKRXgKSc5xfOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCD1A185A7A9
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 09:20:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E90E40C6CCD;
        Fri, 30 Jun 2023 09:20:37 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/6] rteval: Fix CPU count calculation for hackbench
Date:   Fri, 30 Jun 2023 11:19:06 +0200
Message-ID: <20230630091951.916865-6-tglozar@redhat.com>
In-Reply-To: <20230630091951.916865-1-tglozar@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use count from cpulist when specified and all CPUs on node excluding
offline ones and isolated ones if not specified.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/loads/hackbench.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index 14e60d1..f5a547e 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -38,6 +38,7 @@ from rteval.Log import Log
 from rteval.systopology import CpuList, SysTopology
 
 expand_cpulist = CpuList.expand_cpulist
+isolated_cpulist = CpuList.isolated_cpulist
 
 class Hackbench(CommandLineLoad):
     def __init__(self, config, logger):
@@ -77,9 +78,12 @@ class Hackbench(CommandLineLoad):
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
                 self.cpus[n] = [c for c in self.cpus[n] if c in expand_cpulist(self.cpulist)]
+            # if a cpulist was not specified, exclude isolated cpus
+            else:
+                self.cpus[n] = CpuList.nonisolated_cpulist(self.cpus[n])
 
             # track largest number of cpus used on a node
-            node_biggest = len(sysTop.getcpus(int(n)))
+            node_biggest = len(self.cpus[n])
             if node_biggest > biggest:
                 biggest = node_biggest
 
-- 
2.41.0

