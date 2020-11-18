Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56488C64E69
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C7B20B1F
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgKRTGv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:50174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbgKRTGv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EA20BB27;
        Wed, 18 Nov 2020 19:06:49 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 08/12] svsematest: Move statictic output into print_stat()
Date:   Wed, 18 Nov 2020 20:06:38 +0100
Message-Id: <20201118190642.16006-9-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118190642.16006-1-dwagner@suse.de>
References: <20201118190642.16006-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Prepare the code to introduce the quiet command line option by moving
the statistic output code into print_stat(). We follow here the
pattern from cyclictest.

While at it replace the rather sophisticated error printing code with
a fatal(). Just fail if something is not working.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/svsematest/svsematest.c | 101 ++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 56 deletions(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 98efd930e63f..7de20dc65445 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -65,7 +65,6 @@ struct params {
 	struct timeval unblocked, received, diff;
 	pthread_t threadid;
 	struct params *neighbor;
-	char error[MAX_PATH * 2];
 };
 
 static int mustfork;
@@ -95,9 +94,8 @@ void *semathread(void *param)
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
 		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
-			snprintf(par->error, sizeof(par->error),
-			    "WARNING: Could not set CPU affinity "
-			    "to CPU #%d\n", par->cpu);
+			fatal("Could not set CPU affinity "
+			      "to CPU #%d\n", par->cpu);
 	} else {
 		int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
@@ -178,9 +176,8 @@ void *semathread(void *param)
 					write(tracing_enabled, "0", 1);
 					close(tracing_enabled);
 				} else
-					snprintf(par->error, sizeof(par->error),
-					    "Could not access %s\n",
-					    tracing_enabled_file);
+					fatal("Could not access %s\n",
+					      tracing_enabled_file);
 				par->shutdown = 1;
 				neighbor->shutdown = 1;
 			}
@@ -379,6 +376,42 @@ static void sighand(int sig)
 	mustshutdown = 1;
 }
 
+static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
+		       int verbose, int quiet)
+{
+	int i;
+
+	for (i = 0; i < num_threads; i++) {
+		int receiver_pid, sender_pid;
+
+		if (mustfork) {
+			receiver_pid = receiver[i].pid;
+			sender_pid = sender[i].pid;
+		} else {
+			receiver_pid = receiver[i].tid;
+			sender_pid = sender[i].tid;
+		}
+		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
+			i*2, receiver_pid, receiver[i].priority,
+			receiver[i].cpu, receiver[i].delay.tv_nsec /
+			1000, i*2+1, sender_pid, sender[i].priority,
+			sender[i].cpu, sender[i].samples);
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		if (receiver[i].mindiff == -1)
+			printf("#%d -> #%d (not yet ready)\n",
+				i*2+1, i*2);
+		else
+			printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
+				i*2+1, i*2, receiver[i].mindiff,
+				(int) receiver[i].diff.tv_usec,
+				(int) ((receiver[i].sumdiff /
+						receiver[i].samples) + 0.5),
+				receiver[i].maxdiff);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	char *myfile;
@@ -608,57 +641,14 @@ int main(int argc, char *argv[])
 	}
 
 	while (!mustshutdown) {
-		int printed;
-		int errorlines = 0;
-
 		for (i = 0; i < num_threads; i++)
 			mustshutdown |= receiver[i].shutdown |
 			    sender[i].shutdown;
 
 		if (receiver[0].samples > oldsamples || mustshutdown) {
-			for (i = 0; i < num_threads; i++) {
-				int receiver_pid, sender_pid;
-
-				if (mustfork) {
-					receiver_pid = receiver[i].pid;
-					sender_pid = sender[i].pid;
-				} else {
-					receiver_pid = receiver[i].tid;
-					sender_pid = sender[i].tid;
-				}
-				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: "
-				    "ID%d, P%d, CPU%d, Cycles %d\n",
-				    i*2, receiver_pid, receiver[i].priority,
-				    receiver[i].cpu, receiver[i].delay.tv_nsec /
-				    1000, i*2+1, sender_pid, sender[i].priority,
-				    sender[i].cpu, sender[i].samples);
-			}
-			for (i = 0; i < num_threads; i++) {
-				if (receiver[i].mindiff == -1)
-					printf("#%d -> #%d (not yet ready)\n",
-					    i*2+1, i*2);
-				else
-					printf("#%d -> #%d, Min %4d, Cur %4d, "
-					    "Avg %4d, Max %4d\n",
-					    i*2+1, i*2, receiver[i].mindiff,
-					    (int) receiver[i].diff.tv_usec,
-					    (int) ((receiver[i].sumdiff /
-					    receiver[i].samples) + 0.5),
-					    receiver[i].maxdiff);
-				if (receiver[i].error[0] != '\0') {
-					printf("%s", receiver[i].error);
-					receiver[i].error[0] = '\0';
-					errorlines++;
-				}
-				if (sender[i].error[0] != '\0') {
-					printf("%s", sender[i].error);
-					sender[i].error[0] = '\0';
-					errorlines++;
-				}
-			}
-			printed = 1;
-		} else
-			printed = 0;
+			print_stat(stdout, receiver, sender, 0, 0);
+			printf("\033[%dA", num_threads*2);
+		}
 
 		sigemptyset(&sigset);
 		sigaddset(&sigset, SIGTERM);
@@ -670,11 +660,10 @@ int main(int argc, char *argv[])
 
 		sigemptyset(&sigset);
 		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
-
-		if (printed && !mustshutdown)
-			printf("\033[%dA", num_threads*2 + errorlines);
 	}
 
+	printf("\033[%dB", num_threads*2 + 2);
+
 	for (i = 0; i < num_threads; i++) {
 		receiver[i].shutdown = 1;
 		sender[i].shutdown = 1;
-- 
2.29.2

