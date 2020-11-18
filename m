Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01BC64E7C
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E1222228
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgKRTGx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:50254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgKRTGv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E105BB29;
        Wed, 18 Nov 2020 19:06:50 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 10/12] sigwaittest: Move statictic output into print_stat()
Date:   Wed, 18 Nov 2020 20:06:40 +0100
Message-Id: <20201118190642.16006-11-dwagner@suse.de>
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

Also reorder the include headers so that project local headers follow
the system include headers.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sigwaittest/sigwaittest.c | 97 ++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 54 deletions(-)

diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 8a5d73b14fc2..d3be2fd9508c 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -38,10 +38,11 @@
 #include <sys/time.h>
 #include <linux/unistd.h>
 #include <utmpx.h>
+#include <pthread.h>
+
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
-
-#include <pthread.h>
+#include "error.h"
 
 enum {
 	AFFINITY_UNSPECIFIED,
@@ -69,7 +70,6 @@ struct params {
 	struct timeval unblocked, received, diff;
 	pthread_t threadid;
 	struct params *neighbor;
-	char error[MAX_PATH * 2];
 };
 
 static int mustfork;
@@ -184,9 +184,8 @@ void *semathread(void *param)
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
@@ -348,6 +347,39 @@ static void sighand(int sig)
 	mustshutdown = 1;
 }
 
+static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
+		       int verbose, int quiet)
+{
+	int i;
+
+	for (i = 0; i < num_threads; i++) {
+		int receiver_pid, sender_pid;
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
+			printf("#%d -> #%d (not yet ready)\n", i*2+1, i*2);
+		else
+			printf("#%d -> #%d, Min %4d, Cur %4d, Avg %4d, Max %4d\n",
+				i*2+1, i*2,	receiver[i].mindiff,
+				(int) receiver[i].diff.tv_usec,
+				(int) ((receiver[i].sumdiff /
+					receiver[i].samples) + 0.5),
+				receiver[i].maxdiff);
+	}
+}
 
 int main(int argc, char *argv[])
 {
@@ -540,56 +572,14 @@ int main(int argc, char *argv[])
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
-					    i*2+1, i*2,	receiver[i].mindiff,
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
@@ -601,11 +591,10 @@ int main(int argc, char *argv[])
 
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

