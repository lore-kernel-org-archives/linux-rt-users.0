Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2ACC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Apr 2022 10:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiD1Kkr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiD1Kkp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Apr 2022 06:40:45 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033656A075
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Apr 2022 03:37:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VBaLFN6_1651142248;
Received: from localhost(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0VBaLFN6_1651142248)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Apr 2022 18:37:28 +0800
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 1/2] hackbench: Fix negativity opt checking
Date:   Thu, 28 Apr 2022 18:37:25 +0800
Message-Id: <20220428103726.108597-2-wuyihao@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.604.gb1f3e1269
In-Reply-To: <20220428103726.108597-1-wuyihao@linux.alibaba.com>
References: <20220428103726.108597-1-wuyihao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

It was easy to escape the checking. For example, run

  ./hackbench --datasize 4096 -g -1 -l -1

This patch fixes the checking.

Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
 src/hackbench/hackbench.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 268c232..b9b0af6 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -31,10 +31,10 @@
 #include <setjmp.h>
 #include <sched.h>
 
-static unsigned int datasize = 100;
-static unsigned int loops = 100;
-static unsigned int num_groups = 10;
-static unsigned int num_fds = 20;
+static int datasize = 100;
+static int loops = 100;
+static int num_groups = 10;
+static int num_fds = 20;
 static unsigned int fifo = 0;
 
 /*
@@ -377,7 +377,7 @@ static void process_options(int argc, char *argv[])
 		}
 		switch (c) {
 		case 'f':
-			if (!(argv[optind] && (num_fds = atoi(optarg)) > 0)) {
+			if ((num_fds = atoi(optarg)) <= 0) {
 				fprintf(stderr, "%s: --fds|-f requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
@@ -386,7 +386,7 @@ static void process_options(int argc, char *argv[])
 			fifo = 1;
 			break;
 		case 'g':
-			if (!(argv[optind] && (num_groups = atoi(optarg)) > 0)) {
+			if ((num_groups = atoi(optarg)) <= 0) {
 				fprintf(stderr, "%s: --groups|-g requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
@@ -394,7 +394,7 @@ static void process_options(int argc, char *argv[])
 		case 'h':
 			print_usage_exit(0);
 		case 'l':
-			if (!(argv[optind] && (loops = atoi(optarg)) > 0)) {
+			if ((loops = atoi(optarg)) <= 0) {
 				fprintf(stderr, "%s: --loops|-l requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
@@ -403,7 +403,7 @@ static void process_options(int argc, char *argv[])
 			use_pipes = 1;
 			break;
 		case 's':
-			if (!(argv[optind] && (datasize = atoi(optarg)) > 0)) {
+			if ((datasize = atoi(optarg)) <= 0) {
 				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
-- 
2.18.2

