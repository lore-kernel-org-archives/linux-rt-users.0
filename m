Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01640C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C718723A6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Jan 2021 19:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbhAOTKW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:10:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:43284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbhAOTKW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jan 2021 14:10:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37796AE87;
        Fri, 15 Jan 2021 19:09:40 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 04/19] cyclictest: Move thread data to struct thread_param
Date:   Fri, 15 Jan 2021 20:09:21 +0100
Message-Id: <20210115190936.26148-5-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115190936.26148-1-dwagner@suse.de>
References: <20210115190936.26148-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Group thread realated data such as thread ID to struct thread_param.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 9225e52aa982..c0e7600b4740 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -113,6 +113,9 @@ static char *policyname(int policy);
 
 /* Struct to transfer parameters to the thread */
 struct thread_param {
+	pthread_t thread;
+	int threadstarted;
+	int tid;
 	int prio;
 	int policy;
 	int mode;
@@ -141,9 +144,6 @@ struct thread_stat {
 	long *smis;
 	long *hist_array;
 	long *outliers;
-	pthread_t thread;
-	int threadstarted;
-	int tid;
 	long reduce;
 	long redmax;
 	long cycleofmax;
@@ -530,7 +530,7 @@ static void *timerthread(void *param)
 	interval.tv_sec = par->interval / USEC_PER_SEC;
 	interval.tv_nsec = (par->interval % USEC_PER_SEC) * 1000;
 
-	stat->tid = gettid();
+	par->tid = gettid();
 
 	sigemptyset(&sigset);
 	sigaddset(&sigset, par->signal);
@@ -539,7 +539,7 @@ static void *timerthread(void *param)
 	if (par->mode == MODE_CYCLIC) {
 		sigev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
 		sigev.sigev_signo = par->signal;
-		sigev.sigev_notify_thread_id = stat->tid;
+		sigev.sigev_notify_thread_id = par->tid;
 		timer_create(par->clock, &sigev, &timer);
 		tspec.it_interval = interval;
 	}
@@ -613,7 +613,7 @@ static void *timerthread(void *param)
 		setitimer(ITIMER_REAL, &itimer, NULL);
 	}
 
-	stat->threadstarted++;
+	par->threadstarted++;
 
 	while (!shutdown) {
 
@@ -719,7 +719,7 @@ static void *timerthread(void *param)
 			shutdown++;
 			pthread_mutex_lock(&break_thread_id_lock);
 			if (break_thread_id == 0) {
-				break_thread_id = stat->tid;
+				break_thread_id = par->tid;
 				tracemark("hit latency threshold (%llu > %d)",
 					  (unsigned long long) diff, tracelimit);
 				break_thread_value = diff;
@@ -795,7 +795,7 @@ static void *timerthread(void *param)
 	/* switch to normal */
 	schedp.sched_priority = 0;
 	sched_setscheduler(0, SCHED_OTHER, &schedp);
-	stat->threadstarted = -1;
+	par->threadstarted = -1;
 
 	return NULL;
 }
@@ -1298,7 +1298,7 @@ static void print_tids(struct thread_param *par[], int nthreads)
 
 	printf("# Thread Ids:");
 	for (i = 0; i < nthreads; i++)
-		printf(" %05d", par[i]->stats->tid);
+		printf(" %05d", par[i]->tid);
 	printf("\n");
 }
 
@@ -1412,7 +1412,7 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
 				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
 				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
 
-			fprintf(fp, fmt, index, stat->tid, par->prio,
+			fprintf(fp, fmt, index, par->tid, par->prio,
 				par->interval, stat->cycles, stat->min,
 				stat->act, stat->cycles ?
 				(long)(stat->avg/stat->cycles) : 0, stat->max);
@@ -1468,7 +1468,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
 				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
 
-			dprintf(fd, fmt, index, stat->tid, par->prio,
+			dprintf(fd, fmt, index, par->tid, par->prio,
 				par->interval, stat->cycles, stat->min,
 				stat->act, stat->cycles ?
 				(long)(stat->avg/stat->cycles) : 0, stat->max);
@@ -1969,9 +1969,9 @@ int main(int argc, char **argv)
 		stat->min = 1000000;
 		stat->max = 0;
 		stat->avg = 0.0;
-		stat->threadstarted = 1;
 		stat->smi_count = 0;
-		status = pthread_create(&stat->thread, &attr, timerthread, par);
+		par->threadstarted = 1;
+		status = pthread_create(&par->thread, &attr, timerthread, par);
 		if (status)
 			fatal("failed to create thread %d: %s\n", i, strerror(status));
 
@@ -2041,10 +2041,10 @@ int main(int argc, char **argv)
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
-		if (statistics[i]->threadstarted > 0)
-			pthread_kill(statistics[i]->thread, SIGTERM);
-		if (statistics[i]->threadstarted) {
-			pthread_join(statistics[i]->thread, NULL);
+		if (parameters[i]->threadstarted > 0)
+			pthread_kill(parameters[i]->thread, SIGTERM);
+		if (parameters[i]->threadstarted) {
+			pthread_join(parameters[i]->thread, NULL);
 			if (quiet && !histogram)
 				print_stat(stdout, parameters[i], i, 0, 0);
 		}
-- 
2.29.2

