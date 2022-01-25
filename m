Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A9C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jan 2022 18:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiAYSmi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233046AbiAYSlr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jan 2022 13:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643136102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyqTaNe7ZLQNGnEdmlH1BdAYZ6Hyzm1SaLqfep3f8Yo=;
        b=dzirxZosW313I5VP+scujxcLDQLIKDSrNe3xDJ9QYv8HJf2SePR/VD+gkOYrl1e7aoh5YB
        MNKeKmpOXic6YA1REs+EqQJEWH6lkAF1IIhuwrTIg1PhbGD7XFhxqe5bcJKakQBlOc9Vmg
        8L6PZGCZGIjsFTOMT2375Mh3987HpzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-HWfftRYMNL2rk8RqqQ1lNQ-1; Tue, 25 Jan 2022 13:41:38 -0500
X-MC-Unique: HWfftRYMNL2rk8RqqQ1lNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 040DD1083F69;
        Tue, 25 Jan 2022 18:41:38 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACC7C838DA;
        Tue, 25 Jan 2022 18:41:37 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id CB25E4188583; Tue, 25 Jan 2022 15:40:13 -0300 (-03)
Date:   Tue, 25 Jan 2022 15:40:13 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] rt-numa: ignore runtime cpumask if -a CPULIST is specified
Message-ID: <YfBEDR4E2dNK8XzK@fuller.cnet>
References: <YerAW90QwEg9yXAb@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YerAW90QwEg9yXAb@fuller.cnet>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


When using isolcpus kernel command line option, the CPUs
specificied at isolcpus= are not part of the run time environment
cpumask.

This causes "cyclictest -a isolatedcpus" to fail with:

WARN: Couldn't setaffinity in main thread: Invalid argument
FATAL: No allowable cpus to run on
# /dev/cpu_dma_latency set to 0us

To fix this, ignore the runtime cpumask if neither "+", "!"
or "all" are specified in the cpu list string.

Suggested by Sebastian Andrzej Siewior.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index ee5ab99..d887355 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <pthread.h>
+#include <stdlib.h>
 
 #include "rt-error.h"
 #include "rt-numa.h"
@@ -96,13 +97,21 @@ int cpu_for_thread_ua(int thread_num, int max_cpus)
  * the user supplied affinity mask and the affinity mask from the run
  * time environment
  */
-static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
+static void use_current_cpuset(char *str, int max_cpus, struct bitmask *cpumask)
 {
 	struct bitmask *curmask;
 	int i;
 
 	curmask = numa_allocate_cpumask();
-	numa_sched_getaffinity(getpid(), curmask);
+
+	if (strchr(str, '!') == NULL && strchr(str, '+') == NULL &&
+	    strstr(str, "all") == NULL) {
+		int conf_cpus = numa_num_configured_cpus();
+
+		for (i = 0; i < conf_cpus; i++)
+			numa_bitmask_setbit(curmask, i);
+	} else
+		numa_sched_getaffinity(getpid(), curmask);
 
 	/*
 	 * Clear bits that are not set in both the cpuset from the
@@ -131,7 +140,7 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
 		return 0;
 	}
 
-	use_current_cpuset(max_cpus, mask);
+	use_current_cpuset(str, max_cpus, mask);
 	*cpumask = mask;
 
 	return 0;

