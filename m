Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B514C43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Jan 2021 17:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3CF22BED
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Jan 2021 17:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbhAKRel (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:34:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:50992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389527AbhAKRek (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Jan 2021 12:34:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5741AAE12;
        Mon, 11 Jan 2021 17:33:59 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 3/6] signaltest: Move thread data to struct thread_param
Date:   Mon, 11 Jan 2021 18:33:48 +0100
Message-Id: <20210111173351.4971-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111173351.4971-1-dwagner@suse.de>
References: <20210111173351.4971-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Group thread realated data such as thread ID to struct thread_param.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/signaltest/signaltest.c | 44 ++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index c34bc994d886..dd5633d5fc51 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -40,6 +40,10 @@
 
 /* Struct to transfer parameters to the thread */
 struct thread_param {
+	pthread_t thread;
+	pthread_t tothread;
+	int threadstarted;
+	int tid;
 	int id;
 	int prio;
 	int signal;
@@ -47,6 +51,7 @@ struct thread_param {
 	struct thread_stat *stats;
 	int bufmsk;
 	int cpu;
+	int interrupted;
 };
 
 /* Struct for statistics */
@@ -58,11 +63,6 @@ struct thread_stat {
 	long act;
 	double avg;
 	long *values;
-	pthread_t thread;
-	pthread_t tothread;
-	int threadstarted;
-	int tid;
-	int interrupted;
 };
 
 static int shutdown;
@@ -86,7 +86,7 @@ void *signalthread(void *param)
 	pthread_t thread;
 	cpu_set_t mask;
 
-	stat->tid = gettid();
+	par->tid = gettid();
 
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
@@ -105,7 +105,7 @@ void *signalthread(void *param)
 	schedp.sched_priority = par->prio;
 	sched_setscheduler(0, policy, &schedp);
 
-	stat->threadstarted++;
+	par->threadstarted++;
 
 	clock_gettime(CLOCK_MONOTONIC, &before);
 
@@ -128,7 +128,7 @@ void *signalthread(void *param)
 
 		/* Get current time */
 		clock_gettime(CLOCK_MONOTONIC, &now);
-		pthread_kill(stat->tothread, SIGUSR1);
+		pthread_kill(par->tothread, SIGUSR1);
 
 		/* Skip the first cycle */
 		if (first) {
@@ -148,7 +148,7 @@ void *signalthread(void *param)
 
 		if (!stopped && tracelimit && !par->id  && (diff > tracelimit)) {
 			stat->act = diff;
-			stat->interrupted = 1;
+			par->interrupted = 1;
 			stopped++;
 			shutdown++;
 		}
@@ -167,7 +167,7 @@ void *signalthread(void *param)
 	schedp.sched_priority = 0;
 	sched_setscheduler(0, SCHED_OTHER, &schedp);
 
-	stat->threadstarted = -1;
+	par->threadstarted = -1;
 
 	return NULL;
 }
@@ -298,7 +298,7 @@ static void print_stat(struct thread_param *par, int index, int verbose)
 		if (quiet != 1) {
 			printf("T:%2d (%5d) P:%2d C:%7lu "
 			       "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n",
-			       index, stat->tid, par->prio,
+			       index, par->tid, par->prio,
 			       stat->cycles, stat->min, stat->act,
 			       stat->cycles ?
 			       (long)(stat->avg/stat->cycles) : 0, stat->max);
@@ -389,8 +389,8 @@ int main(int argc, char **argv)
 		stat[i].min = 1000000;
 		stat[i].max = -1000000;
 		stat[i].avg = 0.0;
-		stat[i].threadstarted = 1;
-		status = pthread_create(&stat[i].thread, NULL, signalthread,
+		par[i].threadstarted = 1;
+		status = pthread_create(&par[i].thread, NULL, signalthread,
 					&par[i]);
 		if (status)
 			fatal("failed to create thread %d: %s\n", i,
@@ -401,18 +401,18 @@ int main(int argc, char **argv)
 		int allstarted = 1;
 
 		for (i = 0; i < num_threads; i++) {
-			if (stat[i].threadstarted != 2)
+			if (par[i].threadstarted != 2)
 				allstarted = 0;
 		}
 		if (!allstarted)
 			continue;
 
 		for (i = 0; i < num_threads - 1; i++)
-			stat[i].tothread = stat[i+1].thread;
-		stat[i].tothread = stat[0].thread;
+			par[i].tothread = par[i+1].thread;
+		par[i].tothread = par[0].thread;
 		break;
 	}
-	pthread_kill(stat[0].thread, signum);
+	pthread_kill(par[0].thread, signum);
 
 	while (!shutdown) {
 		char lavg[256];
@@ -443,12 +443,12 @@ int main(int argc, char **argv)
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
-		if (stat[i].threadstarted > 0)
-			pthread_kill(stat[i].thread, SIGUSR1);
-		if (stat[i].interrupted)
+		if (par[i].threadstarted > 0)
+			pthread_kill(par[i].thread, SIGUSR1);
+		if (par[i].interrupted)
 			printf("Thread %d exceeded trace limit.\n", i);
-		if (stat[i].threadstarted) {
-			pthread_join(stat[i].thread, NULL);
+		if (par[i].threadstarted) {
+			pthread_join(par[i].thread, NULL);
 			print_stat(&par[i], i, 0);
 		}
 		if (stat[i].values)
-- 
2.29.2

