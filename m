Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F93EB64DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 09:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjF3JW6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjF3JWo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 05:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C343A8B
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688116837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J47Cwegspn/5IUDzU9Pfhu8LTjXAfTcRkBMtXqcteeA=;
        b=CWWQA4rdQp63xhR25cDz7edGJVxVb/E4p6PeBtADyqpD3DJj2vfjaZxadjGoU3HXlWTzqL
        tEaO5EW2i6depUDWtwCZ4djv12vChg6NykWtH+y3mwa271iq6DHqjFW8FdnLDhFEEfwZKg
        TJr7ybrSJOZw7e4KdjtdzVcFmvCNoqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-b8eQJwCRPxe8V3NNqCEzhQ-1; Fri, 30 Jun 2023 05:20:36 -0400
X-MC-Unique: b8eQJwCRPxe8V3NNqCEzhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBCAB1044590
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 09:20:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 290B340C6CCD;
        Fri, 30 Jun 2023 09:20:34 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/6] rteval: Exclude isolcpus from kcompile by default
Date:   Fri, 30 Jun 2023 11:19:04 +0200
Message-ID: <20230630091951.916865-4-tglozar@redhat.com>
In-Reply-To: <20230630091951.916865-1-tglozar@redhat.com>
References: <20230630091951.916865-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Allows correct calculation of make job count that does not include
isolated CPUs, on which the loads won't be scheduled.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/loads/kcompile.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 35ee5cb..30c5965 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -37,6 +37,7 @@ from rteval.systopology import CpuList, SysTopology
 
 expand_cpulist = CpuList.expand_cpulist
 compress_cpulist = CpuList.compress_cpulist
+nonisolated_cpulist = CpuList.nonisolated_cpulist
 
 DEFAULT_KERNEL_PREFIX = "linux-6.1"
 
@@ -55,17 +56,20 @@ class KBuildJob:
         if not os.path.isdir(self.objdir):
             os.mkdir(self.objdir)
 
+        # Exclude isolated CPUs if cpulist not set
+        cpus_available = len(nonisolated_cpulist(self.node.cpus.cpulist))
+
         if os.path.exists('/usr/bin/numactl') and not cpulist:
             # Use numactl
             self.binder = f'numactl --cpunodebind {int(self.node)}'
-            self.jobs = self.calc_jobs_per_cpu() * len(self.node)
+            self.jobs = self.calc_jobs_per_cpu() * cpus_available
         elif cpulist:
             # Use taskset
             self.jobs = self.calc_jobs_per_cpu() * len(cpulist)
             self.binder = f'taskset -c {compress_cpulist(cpulist)}'
         else:
             # Without numactl calculate number of jobs from the node
-            self.jobs = self.calc_jobs_per_cpu() * len(self.node)
+            self.jobs = self.calc_jobs_per_cpu() * cpus_available
 
         self.runcmd = f"make O={self.objdir} -C {self.kdir} -j{self.jobs}"
         self.cleancmd = f"make O={self.objdir} -C {self.kdir} clean allmodconfig"
-- 
2.41.0

