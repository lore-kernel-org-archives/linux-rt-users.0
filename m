Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08275C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 May 2022 15:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiEWPzY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 May 2022 11:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbiEWPzW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 May 2022 11:55:22 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9F74B846
        for <linux-rt-users@vger.kernel.org>; Mon, 23 May 2022 08:55:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VECzIAz_1653321317;
Received: from localhost(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0VECzIAz_1653321317)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 May 2022 23:55:17 +0800
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v3] hackbench: Add af_inet mode besides af_unix and pipe
Date:   Mon, 23 May 2022 23:55:15 +0800
Message-Id: <20220523155515.3649-1-wuyihao@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.604.gb1f3e1269
In-Reply-To: <c5a3d153-0fe5-4155-9115-a636dea35af2@linux.alibaba.com>
References: <c5a3d153-0fe5-4155-9115-a636dea35af2@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We observerved strange performance regression with hackbench, but only with
its default mode instead of pipe mode. It turned out it was unix domain
socket to blame rather than the scheduler. Because on older kernels, there
was a big lock. And modifications to the scheduler made the contension
worse.

However pipe mode is much different from the default af_unix mode. So it's
hard to prove it's really the case. So we think it might be a good idea to
have af_inet mode for hackbench.

After implementing it, we compare these three modes. And the result shows
as what we expect, that only af_unix mode has regression, the others don't.
This proves adding af_inet mode is valuable.

Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
v1->v2: Drop the first patch
v2->v3: Fix EOLs in the commit log

 src/hackbench/hackbench.c | 57 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 268c232..18c9284 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -20,11 +20,14 @@
 #include <string.h>
 #include <errno.h>
 #include <unistd.h>
+#include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include <sys/time.h>
 #include <sys/poll.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
 #include <limits.h>
 #include <getopt.h>
 #include <signal.h>
@@ -46,6 +49,7 @@ static unsigned int fifo = 0;
 static unsigned int process_mode = PROCESS_MODE;
 
 static int use_pipes = 0;
+static int use_inet = 0;
 
 struct sender_context {
 	unsigned int num_fds;
@@ -99,6 +103,7 @@ static void print_usage_exit(int error)
 	       "-h       --help            print this message\n"
 	       "-l       --loops=LOOPS     how many message should be send\n"
 	       "-p       --pipe            send data via a pipe\n"
+	       "-i       --inet            send data via a inet tcp connection\n"
 	       "-s       --datasize=SIZE   message size\n"
 	       "-T       --threads         use POSIX threads\n"
 	       "-P       --process         use fork (default)\n"
@@ -106,11 +111,52 @@ static void print_usage_exit(int error)
 	exit(error);
 }
 
+static int inet_socketpair(int fds[2])
+{
+	int s1, s2;
+	struct sockaddr_in sin;
+	unsigned long ul = 1;
+
+	if ((s1 = socket(AF_INET, SOCK_STREAM, 0)) < 0)
+		barf("socket");
+	if ((s2 = socket(AF_INET, SOCK_STREAM, 0)) < 0)
+		barf("socket");
+
+	socklen_t len = sizeof(sin);
+	bzero(&sin, len);
+	sin.sin_family = AF_INET;
+	sin.sin_port = 0;
+	sin.sin_addr.s_addr = inet_addr("127.0.0.1");
+
+	if (bind(s1, &sin, len) < 0)
+		barf("bind");
+	getsockname(s1, &sin, &len);
+	if (listen(s1, 10) < 0)
+		barf("listen");
+	if (ioctl(s2, FIONBIO, &ul) < 0)
+		barf("ioctl");
+	if (ioctl(s1, FIONBIO, &ul) < 0)
+		barf("ioctl");
+	connect(s2, &sin, len);
+	if ((fds[0] = accept(s1, &sin, &len)) < 0)
+		barf("accept");
+	ul = 0;
+	if (ioctl(s2, FIONBIO, &ul) < 0)
+		barf("ioctl");
+	fds[1] = s2;
+	close(s1);
+
+	return 0;
+}
+
 static void fdpair(int fds[2])
 {
 	if (use_pipes) {
 		if (pipe(fds) == 0)
 			return;
+	} else if (use_inet) {
+		if (inet_socketpair(fds) == 0)
+			return;
 	} else {
 		if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
 			return;
@@ -364,13 +410,14 @@ static void process_options(int argc, char *argv[])
 			{"help",	no_argument,		NULL, 'h'},
 			{"loops",	required_argument,	NULL, 'l'},
 			{"pipe",	no_argument,		NULL, 'p'},
+			{"inet",	no_argument,		NULL, 'i'},
 			{"datasize",	required_argument,	NULL, 's'},
 			{"threads",	no_argument,		NULL, 'T'},
 			{"processes",	no_argument,		NULL, 'P'},
 			{NULL, 0, NULL, 0}
 		};
 
-		int c = getopt_long(argc, argv, "f:Fg:hl:ps:TP",
+		int c = getopt_long(argc, argv, "f:Fg:hl:pis:TP",
 				    longopts, &optind);
 		if (c == -1) {
 			break;
@@ -402,6 +449,9 @@ static void process_options(int argc, char *argv[])
 		case 'p':
 			use_pipes = 1;
 			break;
+		case 'i':
+			use_inet = 1;
+			break;
 		case 's':
 			if (!(argv[optind] && (datasize = atoi(optarg)) > 0)) {
 				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
@@ -418,6 +468,11 @@ static void process_options(int argc, char *argv[])
 			print_usage_exit(1);
 		}
 	}
+
+	if (use_pipes && use_inet) {
+		fprintf(stderr, "%s: --pipe|-p and --inet|-i cannot be used together\n", argv[0]);
+		print_usage_exit(1);
+	}
 }
 
 void sigcatcher(int sig) {
-- 
2.32.0.604.gb1f3e1269

