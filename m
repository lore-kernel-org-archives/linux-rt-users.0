Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F236C64E8A
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3FD21D1A
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgKRTGx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:50062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgKRTGu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48EB8BB1D;
        Wed, 18 Nov 2020 19:06:48 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 04/12] pmqtest: Move statictic output into print_stat()
Date:   Wed, 18 Nov 2020 20:06:34 +0100
Message-Id: <20201118190642.16006-5-dwagner@suse.de>
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
 src/pmqtest/pmqtest.c | 64 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index a1e487b85d2c..b0a2cbede4a0 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -64,7 +64,6 @@ struct params {
 	char recvsyncmsg[MSG_SIZE];
 	char recvtestmsg[MSG_SIZE];
 	struct params *neighbor;
-	char error[MAX_PATH * 2];
 };
 
 void *pmqthread(void *param)
@@ -192,9 +191,7 @@ void *pmqthread(void *param)
 					write(tracing_enabled, "0", 1);
 					close(tracing_enabled);
 				} else
-					snprintf(par->error, sizeof(par->error),
-					    "Could not access %s\n",
-					    tracing_enabled_file);
+					fatal("Could not access %s\n", tracing_enabled_file);
 				par->shutdown = 1;
 				par->neighbor->shutdown = 1;
 			}
@@ -376,6 +373,27 @@ static void sighand(int sig)
 	shutdown = 1;
 }
 
+static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
+		       int verbose, int quiet)
+{
+	int i;
+
+	for (i = 0; i < num_threads; i++) {
+		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, TO %d, Cycles %d\n",
+			i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
+			receiver[i].delay.tv_nsec / 1000,
+			i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
+			receiver[i].timeoutcount, sender[i].samples);
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
 int main(int argc, char *argv[])
 {
 	int i;
@@ -385,8 +403,6 @@ int main(int argc, char *argv[])
 	sigset_t sigset;
 	int oldsamples = INT_MAX;
 	int oldtimeoutcount = INT_MAX;
-	int first = 1;
-	int errorlines = 0;
 	struct timespec maindelay;
 	int oflag = O_CREAT|O_RDWR;
 	struct mq_attr mqstat;
@@ -489,38 +505,8 @@ int main(int argc, char *argv[])
 
 		if (minsamples > 1 && (shutdown || newsamples > oldsamples ||
 			newtimeoutcount > oldtimeoutcount)) {
-
-			if (!first)
-				printf("\033[%dA", num_threads*2 + errorlines);
-			first = 0;
-
-			for (i = 0; i < num_threads; i++) {
-				printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, TO %d, Cycles %d   \n",
-				    i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
-				    receiver[i].delay.tv_nsec / 1000,
-				    i*2+1, sender[i].tid, sender[i].priority, sender[i].cpu,
-				    receiver[i].timeoutcount, sender[i].samples);
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
-		} else {
-			if (minsamples < 1)
-				printf("Collecting ...\n\033[1A");
+			print_stat(stdout, receiver, sender, 0, 0);
+			printf("\033[%dA", num_threads*2);
 		}
 
 		fflush(NULL);
@@ -539,6 +525,8 @@ int main(int argc, char *argv[])
 
 	} while (!shutdown);
 
+	printf("\033[%dB", num_threads*2 + 2);
+
 	for (i = 0; i < num_threads; i++) {
 		receiver[i].shutdown = 1;
 		sender[i].shutdown = 1;
-- 
2.29.2

