Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F7EC63699
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Nov 2020 18:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6189E22450
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Nov 2020 18:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKOSlL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:41:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:54468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbgKOSlK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 15 Nov 2020 13:41:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADD48ACA3;
        Sun, 15 Nov 2020 18:41:09 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 3/3] signaltest: Set affintiy on default
Date:   Sun, 15 Nov 2020 19:40:59 +0100
Message-Id: <20201115184059.7286-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115184059.7286-1-dwagner@suse.de>
References: <20201115184059.7286-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Make signaltest a bit more userfriendly and move all threads on the
same CPU the default behavior.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/include/rt-numa.h       |  1 +
 src/lib/rt-numa.c           | 22 ++++++++++++++++++++++
 src/signaltest/signaltest.c |  4 +---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
index ca86a45dab3a..f52de1ca68d7 100644
--- a/src/include/rt-numa.h
+++ b/src/include/rt-numa.h
@@ -15,6 +15,7 @@ int numa_initialize(void);
 int get_available_cpus(struct bitmask *cpumask);
 int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask);
 int cpu_for_thread_ua(int thread_num, int max_cpus);
+int cpu_for_thread(int max_cpus);
 
 int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
 
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 76f8bd2f0ebe..7147ea7ea4b2 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -87,6 +87,28 @@ int cpu_for_thread_ua(int thread_num, int max_cpus)
 	return 0;
 }
 
+int cpu_for_thread(int max_cpus)
+{
+	int res, num_cpus, i, m, cpu;
+	pthread_t thread;
+	cpu_set_t cpuset;
+
+	thread = pthread_self();
+	CPU_ZERO(&cpuset);
+
+	res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
+	if (res != 0)
+		fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
+
+	for (i = 0, cpu = 0; i < max_cpus; i++) {
+		if (CPU_ISSET(i, &cpuset))
+			return i;
+	}
+
+	fprintf(stderr, "Bug in cpu mask handling code.\n");
+	return 0;
+}
+
 /*
  * After this function is called, affinity_mask is the intersection of
  * the user supplied affinity mask and the affinity mask from the run
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index e19877a395ba..5aa0003501b3 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -301,8 +301,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 		if (numa_initialize())
 			fatal("Couldn't initilize libnuma");
 		numa = 1;
-		if (setaffinity == AFFINITY_UNSPECIFIED)
-			setaffinity = AFFINITY_USEALL;
 	}
 
 	if (option_affinity) {
@@ -404,7 +402,7 @@ int main(int argc, char **argv)
 
 		switch (setaffinity) {
 		case AFFINITY_UNSPECIFIED:
-			cpu = -1;
+			cpu = cpu_for_thread(max_cpus);
 			break;
 		case AFFINITY_SPECIFIED:
 			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
-- 
2.29.2

