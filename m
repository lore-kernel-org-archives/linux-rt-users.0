Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C80C2BBD5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F46D23B6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgLRQU4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:20:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:38184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgLRQUz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:20:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F634AE47;
        Fri, 18 Dec 2020 16:19:03 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 18/20] rt-numa: Remove used max_cpus argument from cpu_for_thread()
Date:   Fri, 18 Dec 2020 17:18:41 +0100
Message-Id: <20201218161843.1764-19-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is no need to pass in the max_cpus anymore. Thus remove the
argument.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c |  2 +-
 src/include/rt-numa.h       |  2 +-
 src/lib/rt-numa.c           | 10 +++++-----
 src/signaltest/signaltest.c |  3 +--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b7de32cf58d0..5d1c08e8b8e0 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1884,7 +1884,7 @@ int main(int argc, char **argv)
 		if (status != 0)
 			fatal("error from pthread_attr_init for thread %d: %s\n", i, strerror(status));
 
-		cpu = cpu_for_thread(i, max_cpus, affinity_mask);
+		cpu = cpu_for_thread(i, affinity_mask);
 		if (verbose)
 			printf("Thread %d using cpu %d.\n", i, cpu);
 
diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
index 446ce54a6ba2..405e57869735 100644
--- a/src/include/rt-numa.h
+++ b/src/include/rt-numa.h
@@ -5,7 +5,7 @@
 #include <numa.h>
 
 int get_available_cpus(struct bitmask *cpumask);
-int cpu_for_thread(int thread_num, int max_cpus, struct bitmask *cpumask);
+int cpu_for_thread(int thread_num, struct bitmask *cpumask);
 
 int parse_cpumask(char *str, struct bitmask **cpumask);
 
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 45d4f1193d5f..04f2e9adb4b1 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -21,7 +21,7 @@ int get_available_cpus(struct bitmask *cpumask)
 	return numa_num_task_cpus();
 }
 
-static int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
+static int cpu_for_thread_sp(int thread_num, struct bitmask *cpumask)
 {
 	unsigned int m, cpu, i, num_cpus;
 
@@ -44,7 +44,7 @@ static int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpuma
 	return 0;
 }
 
-static int cpu_for_thread_ua(int thread_num, int max_cpus)
+static int cpu_for_thread_ua(int thread_num)
 {
 	int res, num_cpus, i, m, cpu;
 	pthread_t thread;
@@ -72,12 +72,12 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
 	return 0;
 }
 
-int cpu_for_thread(int thread_num, int max_cpus, struct bitmask *cpumask)
+int cpu_for_thread(int thread_num, struct bitmask *cpumask)
 {
 	if (cpumask)
-		return cpu_for_thread_sp(thread_num, max_cpus, cpumask);
+		return cpu_for_thread_sp(thread_num, cpumask);
 	else
-		return cpu_for_thread_ua(thread_num, max_cpus);
+		return cpu_for_thread_ua(thread_num);
 }
 
 /*
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 3ca26fb373bb..5427db7f8d85 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -320,7 +320,6 @@ int main(int argc, char **argv)
 	struct thread_stat *stat;
 	int i, ret = -1;
 	int status, cpu;
-	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 	if (numa_available() == -1)
 		fatal("Couldn't initialize libnuma");
@@ -373,7 +372,7 @@ int main(int argc, char **argv)
 			par[i].bufmsk = VALBUF_SIZE - 1;
 		}
 
-		cpu = cpu_for_thread(i, max_cpus, affinity_mask);
+		cpu = cpu_for_thread(i, affinity_mask);
 		if (verbose)
 			printf("Thread %d using cpu %d.\n", i, cpu);
 
-- 
2.29.2

