Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F91DC64E7D
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62242225B
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgKRTGu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:50118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbgKRTGu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D589CBB1E;
        Wed, 18 Nov 2020 19:06:48 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 06/12] ptsematest: Move statictic output into print_stat()
Date:   Wed, 18 Nov 2020 20:06:36 +0100
Message-Id: <20201118190642.16006-7-dwagner@suse.de>
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
 src/ptsematest/ptsematest.c | 65 ++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 9cd5f34509a8..69b4e1221361 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -52,7 +52,6 @@ struct params {
 	struct timeval unblocked, received, diff;
 	pthread_t threadid;
 	struct params *neighbor;
-	char error[MAX_PATH * 2];
 };
 
 void *semathread(void *param)
@@ -121,9 +120,8 @@ void *semathread(void *param)
 					write(tracing_enabled, "0", 1);
 					close(tracing_enabled);
 				} else
-					snprintf(par->error, sizeof(par->error),
-					    "Could not access %s\n",
-					    tracing_enabled_file);
+					fatal("Could not access %s\n",
+					      tracing_enabled_file);
 				par->shutdown = 1;
 				par->neighbor->shutdown = 1;
 			}
@@ -290,6 +288,28 @@ static void sighand(int sig)
 	shutdown = 1;
 }
 
+static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
+		       int verbose, int quiet)
+{
+	int i;
+
+	for (i = 0; i < num_threads; i++) {
+		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
+			i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
+			receiver[i].delay.tv_nsec / 1000,
+			i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
+			sender[i].samples);
+	}
+	for (i = 0; i < num_threads; i++) {
+		printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
+			i*2+1, i*2,
+			receiver[i].mindiff, (int) receiver[i].diff.tv_usec,
+			(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
+			receiver[i].maxdiff);
+	}
+}
+
+
 int main(int argc, char *argv[])
 {
 	int i;
@@ -367,40 +387,13 @@ int main(int argc, char *argv[])
 	maindelay.tv_nsec = 50000000; /* 50 ms */
 
 	while (!shutdown) {
-		int printed;
-		int errorlines = 0;
-
 		for (i = 0; i < num_threads; i++)
 			shutdown |= receiver[i].shutdown | sender[i].shutdown;
 
 		if (receiver[0].samples > oldsamples || shutdown) {
-			for (i = 0; i < num_threads; i++) {
-				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
-				    i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
-				    receiver[i].delay.tv_nsec / 1000,
-				    i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
-				    sender[i].samples);
-			}
-			for (i = 0; i < num_threads; i++) {
-				printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
-					i*2+1, i*2,
-					receiver[i].mindiff, (int) receiver[i].diff.tv_usec,
-					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
-					receiver[i].maxdiff);
-				if (receiver[i].error[0] != '\0') {
-					printf("%s", receiver[i].error);
-					errorlines++;
-					receiver[i].error[0] = '\0';
-				}
-				if (sender[i].error[0] != '\0') {
-					printf("%s", sender[i].error);
-					errorlines++;
-					receiver[i].error[0] = '\0';
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
@@ -411,10 +404,8 @@ int main(int argc, char *argv[])
 
 		sigemptyset(&sigset);
 		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
-
-		if (printed && !shutdown)
-			printf("\033[%dA", num_threads*2 + errorlines);
 	}
+	printf("\033[%dB", num_threads*2 + 2);
 
 	for (i = 0; i < num_threads; i++) {
 		receiver[i].shutdown = 1;
-- 
2.29.2

