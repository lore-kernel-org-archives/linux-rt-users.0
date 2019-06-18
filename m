Return-Path: <SRS0=oonB=UR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCA9C46477
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B837D2080C
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfFRKjr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:39:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfFRKjr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 06:39:47 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hdBWh-0005SS-Qo; Tue, 18 Jun 2019 12:39:44 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 3/6] rt-tests: deadline: Remove duplicated gettid() code
Date:   Tue, 18 Jun 2019 12:38:38 +0200
Message-Id: <20190618103841.27249-4-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618103841.27249-1-kurt@linutronix.de>
References: <20190618103841.27249-1-kurt@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

gettid() is already implemented in the library code. Use that code instead.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 6 ++----
 src/sched_deadline/deadline_test.c  | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 2b83665cab66..17786db45612 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -33,8 +33,6 @@
 #define CPUSET_ALL	"my_cpuset_all"
 #define CPUSET_LOCAL	"my_cpuset"
 
-#define gettid() syscall(__NR_gettid)
-
 typedef unsigned long long u64;
 typedef unsigned int u32;
 typedef int s32;
@@ -755,7 +753,7 @@ void *run_deadline(void *data)
 	attr.sched_runtime = sd->runtime_us * 1000;
 	attr.sched_deadline = sd->deadline_us * 1000;
 
-	printf("thread[%ld] runtime=%lldus deadline=%lldus\n",
+	printf("thread[%d] runtime=%lldus deadline=%lldus\n",
 	       gettid(), sd->runtime_us, sd->deadline_us);
 
 	pthread_barrier_wait(&barrier);
@@ -1195,7 +1193,7 @@ int main (int argc, char **argv)
 		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
 	}
 
-	printf("main thread %ld\n", gettid());
+	printf("main thread %d\n", gettid());
 
 	pthread_barrier_wait(&barrier);
 	printf("fail 2 %d\n", fail);
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index c3b9dceb5209..e2898de328bb 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -51,6 +51,7 @@
 #include <linux/unistd.h>
 #include <linux/magic.h>
 
+#include <rt-utils.h>
 #include <rt-sched.h>
 
 /**
@@ -103,9 +104,6 @@ static void usage(char **argv)
 #define CPUSET_ALL	"my_cpuset_all"
 #define CPUSET_LOCAL	"my_cpuset"
 
-/* Define the system call interfaces */
-#define gettid() syscall(__NR_gettid)
-
 typedef unsigned long long u64;
 typedef unsigned int u32;
 typedef int s32;
@@ -1267,7 +1265,7 @@ void *run_deadline(void *data)
 	attr.sched_runtime = sched_data->runtime_us * 1000;
 	attr.sched_deadline = sched_data->deadline_us * 1000;
 
-	printf("thread[%ld] runtime=%lldus deadline=%lldus loops=%lld\n",
+	printf("thread[%d] runtime=%lldus deadline=%lldus loops=%lld\n",
 	       gettid(), sched_data->runtime_us,
 	       sched_data->deadline_us, sched_data->loops_per_period);
 
-- 
2.11.0

