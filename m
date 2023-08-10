Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C144C04E69
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Aug 2023 09:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjHJJCV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjHJJCU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Aug 2023 05:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B22103
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691658092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxOQ0L6srgd3pRlQ1R7yRX3n1t5d9kYr2+nhBYz9rAY=;
        b=VHvPE+sk9gRUSJtgoAt9Ta7PtHdY5hLGtZ3X7KUc7rcvXvRUU08ijwYO+iK8loBgRxYi0Q
        xSJU0oAx5AsGQxGKTvpnWWIB1v5NUG5c36e1ehzuod934Ftsy5k4VQYUSIPwKTLNo/82+K
        HFkgvJa+K7GLpUk+2UFXa07Vcby1osc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-o2aUpVk4PQ6lrKTgRz-rHQ-1; Thu, 10 Aug 2023 05:01:31 -0400
X-MC-Unique: o2aUpVk4PQ6lrKTgRz-rHQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDC3B8DC665
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 09:01:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36667492C13;
        Thu, 10 Aug 2023 09:01:30 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/3] rteval: Support run-on-isolcpus in cyclictest
Date:   Thu, 10 Aug 2023 11:01:23 +0200
Message-ID: <20230810090123.151924-4-tglozar@redhat.com>
In-Reply-To: <20230810090123.151924-1-tglozar@redhat.com>
References: <20230810090123.151924-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If --measurement-run-on-isolcpus is enabled, add isolated CPUs to the
cpumask for the case when --measurement-cpulist is not specified. If
both options are specified, display a warning.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index ace8db4..4d7fcf2 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -214,6 +214,7 @@ class Cyclictest(rtevalModulePrototype):
         self.__cpus = []
         self.__cyclicdata = {}
         self.__sparse = False
+        self.__run_on_isolcpus = bool(self.__cfg.setdefault('run-on-isolcpus', False))
 
         if self.__cfg.cpulist:
             self.__cpulist = self.__cfg.cpulist
@@ -224,14 +225,21 @@ class Cyclictest(rtevalModulePrototype):
             self.__cpulist = collapse_cpulist(self.__cpus)
             self.__cpus = [str(c) for c in self.__cpus]
             self.__sparse = True
+            if self.__run_on_isolcpus:
+                self._log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
         else:
             self.__cpus = SysTopology().online_cpus_str()
             # Get the cpuset from the environment
             cpuset = os.sched_getaffinity(0)
             # Convert the elements to strings
             cpuset = [str(c) for c in cpuset]
-            # Only include cpus that are in the cpuset
-            self.__cpus = [c for c in self.__cpus if c in cpuset]
+            # Get isolated CPU list
+            isolcpus = [str(c) for c in SysTopology().isolated_cpus()]
+            # Only include cpus that are in the cpuset and isolated CPUs if run_on_isolcpus is enabled
+            self.__cpus = [c for c in self.__cpus if c in cpuset or self.__run_on_isolcpus and c in isolcpus]
+            if self.__run_on_isolcpus:
+                self.__sparse = True
+                self.__cpulist = collapse_cpulist(self.__cpus)
 
         # Sort the list of cpus to align with the order reported by cyclictest
         self.__cpus.sort(key=int)
-- 
2.41.0

