Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38572C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jan 2022 18:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiAYSqa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233421AbiAYSq1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jan 2022 13:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643136383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iAbZeSVhhEVBO6mY6W10L9odsWn2Yz3eqpP+pZ5BIb4=;
        b=KaftbCVa3BZ8tbr5/huiDl47sA7O1sNnBMrak3VKCo47pidZH1+x0g+O1RgxuVxCrVSPVL
        9D+awwEYjJYDhPUA/yrGP0g58aN8n6Jn8tXGoiy6oBLD3O2738smwkzA1BMHNPdUf1/AZL
        yb38Xgeai4eImglr2+WR4S8QrvLxzdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-Xoh8xe-lOiy_FVvHNHntYw-1; Tue, 25 Jan 2022 13:46:19 -0500
X-MC-Unique: Xoh8xe-lOiy_FVvHNHntYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97BE4180FD60;
        Tue, 25 Jan 2022 18:46:18 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F3F1CB835;
        Tue, 25 Jan 2022 18:46:18 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 36512416D5CA; Tue, 25 Jan 2022 15:46:00 -0300 (-03)
Date:   Tue, 25 Jan 2022 15:46:00 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] rt-numa: ignore runtime cpumask if -a CPULIST is specified
Message-ID: <YfBFaNrP/1LCgWoN@fuller.cnet>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <YfBEDR4E2dNK8XzK@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBEDR4E2dNK8XzK@fuller.cnet>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

 
When using isolcpus kernel command line option, the CPUs
specified at isolcpus= are not part of the run time environment
cpumask.

This causes "cyclictest -a isolatedcpus" to fail with:

WARN: Couldn't setaffinity in main thread: Invalid argument
FATAL: No allowable cpus to run on
# /dev/cpu_dma_latency set to 0us

To fix this, ignore the runtime cpumask if neither "+", "!"
or "all" are specified in the cpu list string.

Suggested by Sebastian Andrzej Siewior.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v2: fix changelog typo

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

