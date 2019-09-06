Return-Path: <SRS0=NMSW=XB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53BCC43331
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Sep 2019 19:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981972070C
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Sep 2019 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p58J6olF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfIFTtK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:49:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41389 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfIFTtJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Sep 2019 15:49:09 -0400
Received: by mail-qk1-f196.google.com with SMTP id o11so6844556qkg.8
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Sep 2019 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0sH2oDB3nn665gMJenilI1hH1+pIvScxBsyuGnAOXo=;
        b=p58J6olFRgNWGxynRIBZiiJWFPVHv4G7nohazFP0nYxmskregNl1Tr927JF6jEBXrT
         P2faoGnguPehkTEtrdKhD0sIBN3IYvbWr3yF/xE29uasUSsC9ajRkAP4Ux6IE5KHb7li
         OK0oSaHAHtKaRKI7MmWuOMLEJmo9uPf7COEJhwQlUodRsQ9g1K8WBzNTApxHomi7kAmZ
         Hmd+t95XPvqK0vm4EBi4Q8dR0bX/cAmDGu8k0qdVZOdQD0Gw6R06nbFb18Djx2AjMoPX
         CqnmnLOWBMkWbonjQTn9gOf+KvmJWZPjlJou9HLFwhNu3hkVSePT2Hrm9QHGfi8+FR6r
         ZjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=q0sH2oDB3nn665gMJenilI1hH1+pIvScxBsyuGnAOXo=;
        b=DXAvmrERFV6Z1hzH5NTOKJ/1/snCEnuTlXRTgiyqDcZ5ef4i9lgUNov0o0N+cI386o
         obU8QejkiHzHxXXD0V62odQ0MDV+C5QfYBuvmyu6y6YwsX5ef4MBb9qzGAo//2Jxgfjo
         B5b21V7LEm6+7B+rcdbNLuc/XKR3b3fC3O0kJ0wMVgSQM6hJKa/vsrPd/RzaqkC3o7AQ
         imMbVR/xCULFqy9qorcd6mC3k9geH4zcQKehXH4J+VMnuhPSvTXhOohK3XKF8znpF4Re
         zxc4HxTXkFgJdo3MsUswBwboCch9B4reXpI+4J7NuUmakXXcJRdi3rzL14BJGqucd0/m
         vj/g==
X-Gm-Message-State: APjAAAWs+62rNVBC2scvg7LspHoEcEFxlAZR55aULpBsKcXAAB7oxMVS
        M0wo05TxRkEXBhclRp32M4AY/BzZ
X-Google-Smtp-Source: APXvYqzJSQN9yQteUVqNxKT/qGfpkb+ElYZ8qIU7iwD79FiQKmKM9JS7a+U462nCh7zH1UPdCgGvNQ==
X-Received: by 2002:a05:620a:1486:: with SMTP id w6mr10969998qkj.50.1567799348526;
        Fri, 06 Sep 2019 12:49:08 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id c64sm2985135qkb.21.2019.09.06.12.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 12:49:08 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rt-tests: Set affinity before applying numa
Date:   Fri,  6 Sep 2019 21:48:58 +0200
Message-Id: <20190906194859.24316-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There are three changes here.

1. If affinity is not specified, but numa is available, then numa
implies AFFINITY_USEALL.

2. Move setting affinity before applying numa
We need to set the affinity before applying numa, so that we don't
apply numa settings to cpus we don't intend to run on.

3. Allow a greater number of threads than cpus to run in a round robin
fashion in the case of numa.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index d101e3d14854..52f93da7d074 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1349,8 +1349,12 @@ static void process_options (int argc, char *argv[], int max_cpus)
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
 #ifdef NUMA
-		if (numa_available() != -1)
+		if (numa_available() != -1) {
 			numa = 1;
+			if (setaffinity == AFFINITY_UNSPECIFIED) {
+				setaffinity = AFFINITY_USEALL;
+			}
+		}
 #else
 		warn("cyclictest was not built with the numa option\n");
 		numa = 0;
@@ -1716,6 +1720,7 @@ int main(int argc, char **argv)
 	sigset_t sigset;
 	int signum = SIGALRM;
 	int mode;
+	int cpu;
 	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i, ret = -1;
 	int status;
@@ -1877,6 +1882,16 @@ int main(int argc, char **argv)
 		if (status != 0)
 			fatal("error from pthread_attr_init for thread %d: %s\n", i, strerror(status));
 
+		switch (setaffinity) {
+		case AFFINITY_UNSPECIFIED: cpu = -1; break;
+		case AFFINITY_SPECIFIED:
+			cpu = cpu_for_thread(i, max_cpus);
+			if (verbose)
+				printf("Thread %d using cpu %d.\n", i, cpu);
+			break;
+		case AFFINITY_USEALL: cpu = i % max_cpus; break;
+		}
+
 		node = -1;
 		if (numa) {
 			void *stack;
@@ -1884,7 +1899,7 @@ int main(int argc, char **argv)
 			size_t stksize;
 
 			/* find the memory node associated with the cpu i */
-			node = rt_numa_numa_node_of_cpu(i);
+			node = rt_numa_numa_node_of_cpu(cpu);
 
 			/* get the stack size set for for this thread */
 			if (pthread_attr_getstack(&attr, &currstk, &stksize))
@@ -1895,7 +1910,7 @@ int main(int argc, char **argv)
 				stksize = PTHREAD_STACK_MIN * 2;
 
 			/*  allocate memory for a stack on appropriate node */
-			stack = rt_numa_numa_alloc_onnode(stksize, node, i);
+			stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
 
 			/* touch the stack pages to pre-fault them in */
 			memset(stack, 0, stksize);
@@ -1965,20 +1980,13 @@ int main(int argc, char **argv)
 			interval += distance;
 		if (verbose)
 			printf("Thread %d Interval: %d\n", i, interval);
+
 		par->max_cycles = max_cycles;
 		par->stats = stat;
 		par->node = node;
 		par->tnum = i;
-		switch (setaffinity) {
-		case AFFINITY_UNSPECIFIED: par->cpu = -1; break;
-		case AFFINITY_SPECIFIED:
-			par->cpu = cpu_for_thread(i, max_cpus);
-			if (verbose)
-				printf("Thread %d using cpu %d.\n", i,
-					par->cpu);
-			break;
-		case AFFINITY_USEALL: par->cpu = i % max_cpus; break;
-		}
+		par->cpu = cpu;
+
 		stat->min = 1000000;
 		stat->max = 0;
 		stat->avg = 0.0;
-- 
2.20.1

