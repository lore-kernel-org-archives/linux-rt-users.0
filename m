Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD8C04A68
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jul 2022 20:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiG1UWq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 16:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UWp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Jul 2022 16:22:45 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0D24096
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jul 2022 13:22:44 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i63-20020a638742000000b0041b082610f7so1346863pge.14
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Jul 2022 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Gb5Mf2NqH3U3xVYnQy7iWXpdCNP4TaQlDNvSwu2icgI=;
        b=QB8FJ9v9FW0Jw8q6ZrR7qmQ0eKYXEBIi4yfxAG+JV5j08lPVo4XNbBnpPCIXPcZZsn
         ViEGlsaXP67WNPtO8lJzgoih3Rwp0xbOSKJsfQOMudKDh8UDvOABsc/N4ZTiOwGSCPer
         UI/+v4MC48DUDlLIKcH7LRWc5GJjd1SlbIEJBq6jSM7ZpweqQ4SuzEUK3kacRBBSWJrZ
         eXPMKNSum8j+L63N5w/d6Z9c7jb2usYXUHUDKYgvTFEXs+GISyWFw4JH9clJSe3B7tpr
         WfsC1e4y1cYg3nN6ZMRSD7Awpz8Mavg3ex4TaAKlAlVz4nFenFKMaIs7mOcfE5MkFxW3
         aTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Gb5Mf2NqH3U3xVYnQy7iWXpdCNP4TaQlDNvSwu2icgI=;
        b=6zcS3W/2R0M3o2wo2DseEFSKbTHZpVDkBc/a/GaalF1slieNFave8rTc3xPI/bN+Fk
         5odSERe8LP5nUXefZrj+OV2PgM2LMP3V7BzOYWENGIJLhUQHPNw3OwcPItshtH/w2WKm
         EFUqoDSI0WP6iuxLv45AgH5fUV5xAgt7bZYb44MS0Bs90HfTDhheA9CYQbfUH8+gIGa8
         qKwWYk2fKhDYKi7q3cWrpJmu6QBCtsBbgq9QDRwimNQhZBfP4S4qiWZoVimflMQ761T9
         hArM1AGQjXpck6mliZQ0xccvcCvN87da0gMvL8qGd7oG264WOUA2qE+EwOxA44BU59uV
         6oTQ==
X-Gm-Message-State: ACgBeo2Yh1McsIbkV7zzTJ1D9QcMmbyyZLBkEau75jTOscFF/6OcXBQ6
        dnJpheUOBjzhfpAbpDvg4xSHMVvohKRMIrQyZB31uUqLqkfBg4SXtyqI9whywwX3S4p5oKt06/V
        Hl/r7Ro0yjm5ffDxqlRKL81WfQA3VnD+uFOfxwrfoX6Z7Pfo9PxrcByCIBNNZI5gpn4dbqSgS2A
        ==
X-Google-Smtp-Source: AA6agR5/RlILJtknTerLydqcmXouVu1YriyXuJD6T1QbFSvIYFyF1O/GiQCAHETv3ag3kqy46a0wwrTQIbIO
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:bb09:b0:16d:b1c1:1200 with SMTP id
 im9-20020a170902bb0900b0016db1c11200mr581821plb.75.1659039764049; Thu, 28 Jul
 2022 13:22:44 -0700 (PDT)
Date:   Thu, 28 Jul 2022 20:22:36 +0000
Message-Id: <20220728202236.3998964-1-jstultz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2] cyclictest: Fix threads being affined even when -a isn't set
From:   John Stultz <jstultz@google.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>, John Kacur <jkacur@redhat.com>,
        "Connor O'Brien" <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Using cyclictest without specifying affinity via -a, I was
noticing a strange issue where the rt threads where not
migrating when being blocked.

After lots of debugging in the kernel, I found its actually an
issue with cyclictest.

When using -t there is no behavioral difference between specifying
-a or not specifying -a.

This can be confirmed by adding printf messages around the
pthread_setaffinity_np() call in the threadtest function.

Currently:

root@localhost:~/rt-tests# ./cyclictest -t -a -q -D1
Affining thread 0 to cpu: 0
Affining thread 1 to cpu: 1
Affining thread 2 to cpu: 2
Affining thread 3 to cpu: 3
Affining thread 4 to cpu: 4
Affining thread 5 to cpu: 5
Affining thread 7 to cpu: 7
Affining thread 6 to cpu: 6
T: 0 (15034) P: 0 I:1000 C:   1000 Min:     82 Act:  184 Avg:  180 Max: 705
...

root@localhost:~/rt-tests# ./cyclictest -t -q -D1
Affining thread 0 to cpu: 0
Affining thread 1 to cpu: 1
Affining thread 2 to cpu: 2
Affining thread 3 to cpu: 3
Affining thread 4 to cpu: 4
Affining thread 5 to cpu: 5
Affining thread 6 to cpu: 6
Affining thread 7 to cpu: 7
T: 0 (15044) P: 0 I:1000 C:   1000 Min:     74 Act:  144 Avg:  162 Max: 860
..

This issue seems to come from the logic in process_options():
	/* if smp wasn't requested, test for numa automatically */
	if (!smp) {
		numa = numa_initialize();
		if (setaffinity == AFFINITY_UNSPECIFIED)
			setaffinity = AFFINITY_USEALL;
        }

Here, by setting setaffinity = AFFINITY_USEALL, we effectively
pin each thread to its respective cpu, same as the "-a" option.

This was most recently introduced in commit bdb8350f1b0b
("Revert "cyclictest: Use affinity_mask for steering
thread placement"").

This seems erronious to me, so I wanted to share this patch
which removes the overriding AFFINITY_UNSPECIFIED with
AFFINITY_USEALL by default. Also, some additional tweaks to
preserve the existing numa allocation affinity.

With this patch, we no longer call pthread_setaffinity_np() in the
"./cyclictest -t -q -D1"  case.

Cc: John Kacur <jkacur@redhat.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2: Fixes error passing cpu = -1 to rt_numa_numa_node_of_cpu()
---
 src/cyclictest/cyclictest.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index decea78..82759d1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1270,8 +1270,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
 		numa = numa_initialize();
-		if (setaffinity == AFFINITY_UNSPECIFIED)
-			setaffinity = AFFINITY_USEALL;
 	}
 
 	if (option_affinity) {
@@ -2043,9 +2041,13 @@ int main(int argc, char **argv)
 			void *stack;
 			void *currstk;
 			size_t stksize;
+			int node_cpu = cpu;
+
+			if (node_cpu == -1)
+				node_cpu = cpu_for_thread_ua(i, max_cpus);
 
 			/* find the memory node associated with the cpu i */
-			node = rt_numa_numa_node_of_cpu(cpu);
+			node = rt_numa_numa_node_of_cpu(node_cpu);
 
 			/* get the stack size set for this thread */
 			if (pthread_attr_getstack(&attr, &currstk, &stksize))
@@ -2056,7 +2058,7 @@ int main(int argc, char **argv)
 				stksize = PTHREAD_STACK_MIN * 2;
 
 			/*  allocate memory for a stack on appropriate node */
-			stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
+			stack = rt_numa_numa_alloc_onnode(stksize, node, node_cpu);
 
 			/* touch the stack pages to pre-fault them in */
 			memset(stack, 0, stksize);
-- 
2.37.1.455.g008518b4e5-goog

