Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1D1C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 14:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D180723AAA
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 14:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgLROUa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:20:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:37662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgLROUa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 09:20:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E619AB1A1;
        Fri, 18 Dec 2020 14:19:47 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 2/6] cyclictest: Use numa API directly
Date:   Fri, 18 Dec 2020 15:19:31 +0100
Message-Id: <20201218141935.24151-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218141935.24151-1-dwagner@suse.de>
References: <20201218141935.24151-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is no need for small libnuma wrappers functions as we always
use libnuma. Remove them and get rid of rt_numa.h, so there is
no confusion with rt-numa.h anymore.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 41 ++++++++--------
 src/cyclictest/rt_numa.h    | 96 -------------------------------------
 2 files changed, 22 insertions(+), 115 deletions(-)
 delete mode 100644 src/cyclictest/rt_numa.h

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 514ed7b20fdb..a5ca764da254 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -33,10 +33,10 @@
 #include <sys/utsname.h>
 #include <sys/mman.h>
 #include <sys/syscall.h>
-#include "rt_numa.h"
 
 #include "rt-utils.h"
 #include "rt-numa.h"
+#include "error.h"
 
 #include <bionic.h>
 
@@ -514,9 +514,9 @@ static void *timerthread(void *param)
 
 	memset(&stop, 0, sizeof(stop));
 
-	/* if we're running in numa mode, set our memory node */
-	if (par->node != -1)
-		rt_numa_set_numa_run_on_node(par->node, par->cpu);
+	if (numa_run_on_node(par->node))
+		warn("Could not set NUMA node %d for thread %d: %s\n",
+				par->node, par->cpu, strerror(errno));
 
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
@@ -1275,7 +1275,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 	}
 	if (error) {
 		if (affinity_mask)
-			rt_bitmask_free(affinity_mask);
+			numa_bitmask_free(affinity_mask);
 		display_help(1);
 	}
 }
@@ -1929,7 +1929,7 @@ int main(int argc, char **argv)
 		}
 
 		/* find the memory node associated with the cpu i */
-		node = rt_numa_numa_node_of_cpu(cpu);
+		node = numa_node_of_cpu(cpu);
 
 		/* get the stack size set for this thread */
 		if (pthread_attr_getstack(&attr, &currstk, &stksize))
@@ -1940,7 +1940,10 @@ int main(int argc, char **argv)
 			stksize = PTHREAD_STACK_MIN * 2;
 
 		/*  allocate memory for a stack on appropriate node */
-		stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
+		stack = numa_alloc_onnode(stksize, node);
+		if (!stack)
+			fatal("failed to allocate %d bytes on node %d for cpu %d\n",
+				stksize, node, cpu);
 
 		/* touch the stack pages to pre-fault them in */
 		memset(stack, 0, stksize);
@@ -1951,13 +1954,13 @@ int main(int argc, char **argv)
 				i, stack+stksize);
 
 		/* allocate the thread's parameter block  */
-		parameters[i] = par = threadalloc(sizeof(struct thread_param), node);
+		parameters[i] = par = numa_alloc_onnode(sizeof(struct thread_param), node);
 		if (par == NULL)
 			fatal("error allocating thread_param struct for thread %d\n", i);
 		memset(par, 0, sizeof(struct thread_param));
 
 		/* allocate the thread's statistics block */
-		statistics[i] = stat = threadalloc(sizeof(struct thread_stat), node);
+		statistics[i] = stat = numa_alloc_onnode(sizeof(struct thread_stat), node);
 		if (stat == NULL)
 			fatal("error allocating thread status struct for thread %d\n", i);
 		memset(stat, 0, sizeof(struct thread_stat));
@@ -1966,8 +1969,8 @@ int main(int argc, char **argv)
 		if (histogram) {
 			int bufsize = histogram * sizeof(long);
 
-			stat->hist_array = threadalloc(bufsize, node);
-			stat->outliers = threadalloc(bufsize, node);
+			stat->hist_array = numa_alloc_onnode(bufsize, node);
+			stat->outliers = numa_alloc_onnode(bufsize, node);
 			if (stat->hist_array == NULL || stat->outliers == NULL)
 				fatal("failed to allocate histogram of size %d on node %d\n",
 				      histogram, i);
@@ -1977,14 +1980,14 @@ int main(int argc, char **argv)
 
 		if (verbose) {
 			int bufsize = VALBUF_SIZE * sizeof(long);
-			stat->values = threadalloc(bufsize, node);
+			stat->values = numa_alloc_onnode(bufsize, node);
 			if (!stat->values)
 				goto outall;
 			memset(stat->values, 0, bufsize);
 			par->bufmsk = VALBUF_SIZE - 1;
 			if (smi) {
 				int bufsize = VALBUF_SIZE * sizeof(long);
-				stat->smis = threadalloc(bufsize, node);
+				stat->smis = numa_alloc_onnode(bufsize, node);
 				if (!stat->smis)
 					goto outall;
 				memset(stat->smis, 0, bufsize);
@@ -2099,7 +2102,7 @@ int main(int argc, char **argv)
 				print_stat(stdout, parameters[i], i, 0, 0);
 		}
 		if (statistics[i]->values)
-			threadfree(statistics[i]->values, VALBUF_SIZE*sizeof(long), parameters[i]->node);
+			numa_free(statistics[i]->values, VALBUF_SIZE*sizeof(long));
 	}
 
 	if (trigger)
@@ -2108,8 +2111,8 @@ int main(int argc, char **argv)
 	if (histogram) {
 		print_hist(parameters, num_threads);
 		for (i = 0; i < num_threads; i++) {
-			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
-			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
+			numa_free(statistics[i]->hist_array, histogram*sizeof(long));
+			numa_free(statistics[i]->outliers, histogram*sizeof(long));
 		}
 	}
 
@@ -2125,14 +2128,14 @@ int main(int argc, char **argv)
 	for (i=0; i < num_threads; i++) {
 		if (!statistics[i])
 			continue;
-		threadfree(statistics[i], sizeof(struct thread_stat), parameters[i]->node);
+		numa_free(statistics[i], sizeof(struct thread_stat));
 	}
 
  outpar:
 	for (i = 0; i < num_threads; i++) {
 		if (!parameters[i])
 			continue;
-		threadfree(parameters[i], sizeof(struct thread_param), parameters[i]->node);
+		numa_free(parameters[i], sizeof(struct thread_param));
 	}
  out:
 	/* close any tracer file descriptors */
@@ -2147,7 +2150,7 @@ int main(int argc, char **argv)
 		close(latency_target_fd);
 
 	if (affinity_mask)
-		rt_bitmask_free(affinity_mask);
+		numa_bitmask_free(affinity_mask);
 
 	/* Remove running status shared memory file if it exists */
 	if (rstat_fd >= 0)
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
deleted file mode 100644
index 8d02f419ed6d..000000000000
--- a/src/cyclictest/rt_numa.h
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * A numa library for cyclictest.
- *
- * (C) 2010 John Kacur <jkacur@redhat.com>
- * (C) 2010 Clark Williams <williams@redhat.com>
- *
- */
-
-#ifndef _RT_NUMA_H
-#define _RT_NUMA_H
-
-#include "rt-utils.h"
-#include "error.h"
-
-#include <numa.h>
-
-static void *
-threadalloc(size_t size, int node)
-{
-	if (node == -1)
-		return malloc(size);
-	return numa_alloc_onnode(size, node);
-}
-
-static void
-threadfree(void *ptr, size_t size, int node)
-{
-	if (node == -1)
-		free(ptr);
-	else
-		numa_free(ptr, size);
-}
-
-static void rt_numa_set_numa_run_on_node(int node, int cpu)
-{
-	int res;
-	res = numa_run_on_node(node);
-	if (res)
-		warn("Could not set NUMA node %d for thread %d: %s\n",
-				node, cpu, strerror(errno));
-	return;
-}
-
-static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
-{
-	void *stack;
-	stack = numa_alloc_onnode(size, node);
-	if (stack == NULL)
-		fatal("failed to allocate %d bytes on node %d for cpu %d\n",
-				size, node, cpu);
-	return stack;
-}
-
-/*
- * Use new bit mask CPU affinity behavior
- */
-static int rt_numa_numa_node_of_cpu(int cpu)
-{
-	int node;
-	node = numa_node_of_cpu(cpu);
-	if (node == -1)
-		fatal("invalid cpu passed to numa_node_of_cpu(%d)\n", cpu);
-	return node;
-}
-
-static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
-	unsigned long i)
-{
-	return numa_bitmask_isbitset(mask,i);
-}
-
-static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
-	int max_cpus)
-{
-	return numa_parse_cpustring_all(s);
-}
-
-static inline void rt_bitmask_free(struct bitmask *mask)
-{
-	numa_bitmask_free(mask);
-}
-
-/** Returns number of bits set in mask. */
-static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
-{
-	unsigned int num_bits = 0, i;
-	for (i = 0; i < mask->size; i++) {
-		if (rt_numa_bitmask_isbitset(mask, i))
-			num_bits++;
-	}
-	/* Could stash this instead of recomputing every time. */
-	return num_bits;
-}
-
-#endif	/* _RT_NUMA_H */
-- 
2.29.2

