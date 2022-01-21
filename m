Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8DC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jan 2022 14:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381004AbiAUOR2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Jan 2022 09:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350707AbiAUORV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Jan 2022 09:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642774640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AgLRKGOnOEF/OCFOBJ3+Ud2VmYfBk+EPtZeqQ/2DNeo=;
        b=BykEJfISLrD+acUd6Yfw8SCt0wm6AF/tcNNc5kRmpYhMF53RCUaz/A4v0DHTkJvxChOVVy
        2OYZaev+e5RwMUQY16kdX1Qu0xTvHNdqIb852AWkC6w+7iG7fqq8d3OJPTu+7jBz3OrpxJ
        1DecWJUfrFbpR/XjR93aqJztzWsjnvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-um-zERa8Ofm271F7W5RGnw-1; Fri, 21 Jan 2022 09:17:19 -0500
X-MC-Unique: um-zERa8Ofm271F7W5RGnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D8348144E6
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jan 2022 14:17:18 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C737798B8;
        Fri, 21 Jan 2022 14:17:18 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 960364171322; Fri, 21 Jan 2022 11:16:59 -0300 (-03)
Date:   Fri, 21 Jan 2022 11:16:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-numa: optionally ignore runtime cpumask
Message-ID: <YerAW90QwEg9yXAb@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


use_current_cpuset() function does:

/*
 * After this function is called, affinity_mask is the intersection of
 * the user supplied affinity mask and the affinity mask from the run
 * time environment
 */
static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)

However, when using isolcpus kernel command line option, the CPUs 
specificied at isolcpus= are not part of the run time environment
cpumask.

This causes "cyclictest -a isolatedcpus" to fail with:

WARN: Couldn't setaffinity in main thread: Invalid argument
FATAL: No allowable cpus to run on
# /dev/cpu_dma_latency set to 0us

To fix this, add an environment variable IGNORE_RUNTIME_CPU_AFFINITY_MASK
that when set to a value other than 0, will override the runtime cpu
affinity mask (retrieved with numa_sched_getaffinity) with a bit set
for each CPU in numa_num_configured_cpus:

numa_num_configured_cpus() returns the number of cpus in the system.
This count includes any cpus that are currently disabled. This count is
derived from the cpu numbers in /sys/devices/system/cpu. If the kernel
is configured without /sys (CONFIG_SYSFS=n) then it falls back to using
the number of online cpus.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index ee5ab99..3106f1e 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <pthread.h>
+#include <stdlib.h>
 
 #include "rt-error.h"
 #include "rt-numa.h"
@@ -99,11 +100,20 @@ int cpu_for_thread_ua(int thread_num, int max_cpus)
 static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
 {
 	struct bitmask *curmask;
+	char *ignore_affinity_mask;
 	int i;
 
 	curmask = numa_allocate_cpumask();
 	numa_sched_getaffinity(getpid(), curmask);
 
+	ignore_affinity_mask = getenv("IGNORE_RUNTIME_CPU_AFFINITY_MASK");
+	if (ignore_affinity_mask && *ignore_affinity_mask != '0') {
+		int conf_cpus = numa_num_configured_cpus();
+
+		for (i = 0; i < conf_cpus; i++)
+			numa_bitmask_setbit(curmask, i);
+	}
+
 	/*
 	 * Clear bits that are not set in both the cpuset from the
 	 * environment, and in the user specified affinity.

