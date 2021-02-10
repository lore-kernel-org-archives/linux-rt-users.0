Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC58C433E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9054964E79
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 13:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhBJNgp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 08:36:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:50474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhBJNgT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 08:36:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFEAAAFFD;
        Wed, 10 Feb 2021 13:34:56 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v4 07/16] rt-numa: Add generic cpu_for_thread() helper
Date:   Wed, 10 Feb 2021 14:34:41 +0100
Message-Id: <20210210133450.6991-8-dwagner@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210133450.6991-1-dwagner@suse.de>
References: <20210210133450.6991-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add an simpler wrapper which calls the right implementation depending
on if the cpumask is valid or not.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c |  6 +-----
 src/include/rt-numa.h       |  3 +--
 src/lib/rt-numa.c           | 13 ++++++++++---
 src/signaltest/signaltest.c |  6 +-----
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3c6773c1dbb5..4e30abbe6035 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1882,11 +1882,7 @@ int main(int argc, char **argv)
 		if (status != 0)
 			fatal("error from pthread_attr_init for thread %d: %s\n", i, strerror(status));
 
-		if (affinity_mask)
-			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
-		else
-			cpu = cpu_for_thread_ua(i, max_cpus);
-
+		cpu = cpu_for_thread(i, max_cpus, affinity_mask);
 		if (verbose)
 			printf("Thread %d using cpu %d.\n", i, cpu);
 
diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
index 54f5c3a240e9..189da3a804e1 100644
--- a/src/include/rt-numa.h
+++ b/src/include/rt-numa.h
@@ -5,8 +5,7 @@
 #include <numa.h>
 
 int get_available_cpus(struct bitmask *cpumask);
-int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask);
-int cpu_for_thread_ua(int thread_num, int max_cpus);
+int cpu_for_thread(int thread_num, int max_cpus, struct bitmask *cpumask);
 
 int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
 
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index fa83eae61084..7e99eab60681 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -21,7 +21,7 @@ int get_available_cpus(struct bitmask *cpumask)
 	return numa_num_task_cpus();
 }
 
-int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
+static int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
 {
 	unsigned int m, cpu, i, num_cpus;
 
@@ -44,8 +44,7 @@ int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
 	return 0;
 }
 
-/* cpu_for_thread AFFINITY_USEALL */
-int cpu_for_thread_ua(int thread_num, int max_cpus)
+static int cpu_for_thread_ua(int thread_num, int max_cpus)
 {
 	int res, num_cpus, i, m, cpu;
 	pthread_t thread;
@@ -73,6 +72,14 @@ int cpu_for_thread_ua(int thread_num, int max_cpus)
 	return 0;
 }
 
+int cpu_for_thread(int thread_num, int max_cpus, struct bitmask *cpumask)
+{
+	if (cpumask)
+		return cpu_for_thread_sp(thread_num, max_cpus, cpumask);
+	else
+		return cpu_for_thread_ua(thread_num, max_cpus);
+}
+
 /*
  * After this function is called, affinity_mask is the intersection of
  * the user supplied affinity mask and the affinity mask from the run
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 41ebb2c87a2f..2ea5e6b58946 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -373,11 +373,7 @@ int main(int argc, char **argv)
 			par[i].bufmsk = VALBUF_SIZE - 1;
 		}
 
-		if (affinity_mask)
-			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
-		else
-			cpu = cpu_for_thread_ua(i, max_cpus);
-
+		cpu = cpu_for_thread(i, max_cpus, affinity_mask);
 		if (verbose)
 			printf("Thread %d using cpu %d.\n", i, cpu);
 
-- 
2.30.0

