Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB960C3526B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25CA23B6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbgLRQUQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:20:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:37400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbgLRQUP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:20:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3390AE2E;
        Fri, 18 Dec 2020 16:19:01 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 13/20] rt-numa: Remove max_cpus argument from parse_cpusmask
Date:   Fri, 18 Dec 2020 17:18:36 +0100
Message-Id: <20201218161843.1764-14-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove usused max_cpus argument from parse_cpumask().

Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 4 ++--
 src/include/rt-numa.h       | 2 +-
 src/lib/rt-numa.c           | 6 +++---
 src/oslat/oslat.c           | 3 +--
 src/signaltest/signaltest.c | 4 ++--
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 092534abb709..9e138c812fc8 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1013,12 +1013,12 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case 'a':
 		case OPT_AFFINITY:
 			if (optarg) {
-				parse_cpumask(optarg, max_cpus, &affinity_mask);
+				parse_cpumask(optarg, &affinity_mask);
 			} else if (optind < argc &&
 				   (atoi(argv[optind]) ||
 				    argv[optind][0] == '0' ||
 				    argv[optind][0] == '!')) {
-				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
+				parse_cpumask(argv[optind], &affinity_mask);
 			}
 			break;
 		case 'A':
diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
index 189da3a804e1..446ce54a6ba2 100644
--- a/src/include/rt-numa.h
+++ b/src/include/rt-numa.h
@@ -7,6 +7,6 @@
 int get_available_cpus(struct bitmask *cpumask);
 int cpu_for_thread(int thread_num, int max_cpus, struct bitmask *cpumask);
 
-int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
+int parse_cpumask(char *str, struct bitmask **cpumask);
 
 #endif
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 1918f93b74eb..fc7adb4d467a 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -85,7 +85,7 @@ int cpu_for_thread(int thread_num, int max_cpus, struct bitmask *cpumask)
  * the user supplied affinity mask and the affinity mask from the run
  * time environment
  */
-static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
+static void use_current_cpuset(struct bitmask *cpumask)
 {
 	struct bitmask *curmask;
 	int i;
@@ -106,7 +106,7 @@ static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
 	numa_bitmask_free(curmask);
 }
 
-int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
+int parse_cpumask(char *str, struct bitmask **cpumask)
 {
 	struct bitmask *mask;
 
@@ -120,7 +120,7 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
 		return 0;
 	}
 
-	use_current_cpuset(max_cpus, mask);
+	use_current_cpuset(mask);
 	*cpumask = mask;
 
 	return 0;
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 5b7e0d5b5d5c..0811079d9f04 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -716,7 +716,6 @@ int main(int argc, char *argv[])
 	struct thread *threads;
 	int i, n_cores;
 	struct bitmask *cpu_set = NULL;
-	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 #ifdef FRC_MISSING
 	printf("This architecture is not yet supported. "
@@ -743,7 +742,7 @@ int main(int argc, char *argv[])
 
 	if (!g.cpu_list)
 		g.cpu_list = strdup("all");
-	if (parse_cpumask(g.cpu_list, max_cpus, &cpu_set))
+	if (parse_cpumask(g.cpu_list, &cpu_set))
 		exit(1);
 	n_cores = numa_bitmask_weight(cpu_set);
 
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 2ea5e6b58946..0d189483753d 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -236,12 +236,12 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 		switch (c) {
 		case 'a':
 			if (optarg) {
-				parse_cpumask(optarg, max_cpus, &affinity_mask);
+				parse_cpumask(optarg, &affinity_mask);
 			} else if (optind < argc &&
 				   (atoi(argv[optind]) ||
 				    argv[optind][0] == '0' ||
 				    argv[optind][0] == '!')) {
-				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
+				parse_cpumask(argv[optind], &affinity_mask);
 			}
 
 			if (verbose)
-- 
2.29.2

