Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404CBC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134EF23B76
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgLRQTd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:19:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:36876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgLRQTc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:19:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D912FAD6A;
        Fri, 18 Dec 2020 16:18:50 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
Date:   Fri, 18 Dec 2020 17:18:24 +0100
Message-Id: <20201218161843.1764-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

libnuma is hard dependency for cyclictest. Thus we can always call
numa_initialize(). This allows us to remove the global 'numa' variable
to track if libnuma has been initialized or not.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 63 +++++++++++++++++--------------------
 src/cyclictest/rt_numa.h    |  2 --
 2 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f38c453f1975..514ed7b20fdb 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1018,9 +1018,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
-			if (numa_initialize())
-				fatal("Couldn't initialize libnuma");
-			numa = 1;
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
@@ -1126,8 +1123,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			use_system = MODE_SYS_OFFSET; break;
 		case 'S':
 		case OPT_SMP: /* SMP testing */
-			if (numa)
-				fatal("numa and smp options are mutually exclusive\n");
 			smp = 1;
 			num_threads = -1; /* update after parsing */
 			setaffinity = AFFINITY_USEALL;
@@ -1201,16 +1196,17 @@ static void process_options(int argc, char *argv[], int max_cpus)
 
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
-		if (numa_initialize())
-			fatal("Couldn't initialize libnuma");
-		numa = 1;
 		if (setaffinity == AFFINITY_UNSPECIFIED)
 			setaffinity = AFFINITY_USEALL;
 	}
 
-	if (option_affinity) {
-		if (smp)
-			warn("-a ignored due to smp mode\n");
+	if (option_affinity && smp) {
+		warn("-a ignored due to smp mode\n");
+		if (affinity_mask) {
+			numa_bitmask_free(affinity_mask);
+			affinity_mask = NULL;
+		}
+		setaffinity = AFFINITY_USEALL;
 	}
 
 	if (smi) {
@@ -1744,6 +1740,12 @@ int main(int argc, char **argv)
 	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i, ret = -1;
 	int status;
+	void *stack;
+	void *currstk;
+	size_t stksize;
+
+	if (numa_initialize())
+		fatal("Couldn't initialize libnuma");
 
 	process_options(argc, argv, max_cpus);
 
@@ -1926,34 +1928,27 @@ int main(int argc, char **argv)
 		default: cpu = -1;
 		}
 
-		node = -1;
-		if (numa) {
-			void *stack;
-			void *currstk;
-			size_t stksize;
+		/* find the memory node associated with the cpu i */
+		node = rt_numa_numa_node_of_cpu(cpu);
 
-			/* find the memory node associated with the cpu i */
-			node = rt_numa_numa_node_of_cpu(cpu);
+		/* get the stack size set for this thread */
+		if (pthread_attr_getstack(&attr, &currstk, &stksize))
+			fatal("failed to get stack size for thread %d\n", i);
 
-			/* get the stack size set for this thread */
-			if (pthread_attr_getstack(&attr, &currstk, &stksize))
-				fatal("failed to get stack size for thread %d\n", i);
+		/* if the stack size is zero, set a default */
+		if (stksize == 0)
+			stksize = PTHREAD_STACK_MIN * 2;
 
-			/* if the stack size is zero, set a default */
-			if (stksize == 0)
-				stksize = PTHREAD_STACK_MIN * 2;
+		/*  allocate memory for a stack on appropriate node */
+		stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
 
-			/*  allocate memory for a stack on appropriate node */
-			stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
+		/* touch the stack pages to pre-fault them in */
+		memset(stack, 0, stksize);
 
-			/* touch the stack pages to pre-fault them in */
-			memset(stack, 0, stksize);
-
-			/* set the thread's stack */
-			if (pthread_attr_setstack(&attr, stack, stksize))
-				fatal("failed to set stack addr for thread %d to 0x%x\n",
-				      i, stack+stksize);
-		}
+		/* set the thread's stack */
+		if (pthread_attr_setstack(&attr, stack, stksize))
+			fatal("failed to set stack addr for thread %d to 0x%x\n",
+				i, stack+stksize);
 
 		/* allocate the thread's parameter block  */
 		parameters[i] = par = threadalloc(sizeof(struct thread_param), node);
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 46690941e0a6..8d02f419ed6d 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -13,8 +13,6 @@
 #include "rt-utils.h"
 #include "error.h"
 
-static int numa = 0;
-
 #include <numa.h>
 
 static void *
-- 
2.29.2

