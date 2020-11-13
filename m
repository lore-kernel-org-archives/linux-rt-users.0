Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A8FC63697
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A696122252
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKMVJX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:09:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:39866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMVJW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 16:09:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40E12B019;
        Fri, 13 Nov 2020 21:09:21 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 6/6] oslat: Use parse_cpumask() from rt-numa.h
Date:   Fri, 13 Nov 2020 22:09:10 +0100
Message-Id: <20201113210910.21807-7-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113210910.21807-1-dwagner@suse.de>
References: <20201113210910.21807-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use the common parse_cpumask() helper and use struct bitmask directly
instead transforming it into a CPU_SET first.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/oslat/oslat.c | 55 +++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index b2aa15001be2..5b7e0d5b5d5c 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -42,6 +42,7 @@
 #include <sys/syscall.h>
 
 #include "rt-utils.h"
+#include "rt-numa.h"
 #include "error.h"
 
 #ifdef __GNUC__
@@ -542,37 +543,6 @@ static void usage(int error)
 	exit(error);
 }
 
-/* TODO: use libnuma? */
-static int parse_cpu_list(char *cpu_list, cpu_set_t *cpu_set)
-{
-	struct bitmask *cpu_mask;
-	int i, n_cores;
-
-	n_cores = sysconf(_SC_NPROCESSORS_CONF);
-
-	if (!cpu_list) {
-		for (i = 0; i < n_cores; i++)
-			CPU_SET(i, cpu_set);
-		return n_cores;
-	}
-
-	cpu_mask = numa_parse_cpustring_all(cpu_list);
-	if (cpu_mask) {
-		for (i = 0; i < n_cores; i++) {
-			if (numa_bitmask_isbitset(cpu_mask, i))
-				CPU_SET(i, cpu_set);
-		}
-		numa_bitmask_free(cpu_mask);
-	} else {
-		warn("Unknown cpu-list: %s, using all available cpus\n", cpu_list);
-		for (i = 0; i < n_cores; i++)
-			CPU_SET(i, cpu_set);
-	}
-
-	return n_cores;
-}
-
-
 static int workload_select(char *name)
 {
 	int i = 0;
@@ -745,15 +715,18 @@ int main(int argc, char *argv[])
 {
 	struct thread *threads;
 	int i, n_cores;
-	cpu_set_t cpu_set;
+	struct bitmask *cpu_set = NULL;
+	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 #ifdef FRC_MISSING
 	printf("This architecture is not yet supported. "
 	       "Please implement frc() function first for %s.\n", argv[0]);
 	return 0;
 #endif
-
-	CPU_ZERO(&cpu_set);
+	if (numa_available() == -1) {
+		printf("ERROR: Could not initialize libnuma\n");
+		exit(1);
+	}
 
 	g.app_name = argv[0];
 	g.rtprio = 0;
@@ -768,16 +741,22 @@ int main(int argc, char *argv[])
 
 	TEST(mlockall(MCL_CURRENT | MCL_FUTURE) == 0);
 
-	n_cores = parse_cpu_list(g.cpu_list, &cpu_set);
+	if (!g.cpu_list)
+		g.cpu_list = strdup("all");
+	if (parse_cpumask(g.cpu_list, max_cpus, &cpu_set))
+		exit(1);
+	n_cores = numa_bitmask_weight(cpu_set);
 
-	TEST(threads = calloc(1, CPU_COUNT(&cpu_set) * sizeof(threads[0])));
+	TEST(threads = calloc(1, n_cores * sizeof(threads[0])));
 	for (i = 0; i < n_cores; ++i)
-		if (CPU_ISSET(i, &cpu_set) && move_to_core(i) == 0)
+		if (numa_bitmask_isbitset(cpu_set, i) && move_to_core(i) == 0)
 			threads[g.n_threads_total++].core_i = i;
 
-	if (CPU_ISSET(0, &cpu_set) && g.rtprio)
+	if (numa_bitmask_isbitset(cpu_set, 0) && g.rtprio)
 		printf("WARNING: Running SCHED_FIFO workload on CPU 0 may hang the thread\n");
 
+	numa_bitmask_free(cpu_set);
+
 	TEST(move_to_core(g.cpu_main_thread) == 0);
 
 	signal(SIGALRM, handle_alarm);
-- 
2.29.2

