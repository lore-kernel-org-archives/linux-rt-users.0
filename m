Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025DDC4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6CD23B6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbgLRQUO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:20:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:37382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731140AbgLRQUO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:20:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F3ECAE12;
        Fri, 18 Dec 2020 16:18:53 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 09/20] signaltest:  Simplify --smp vs --affinity vs --threads argument logic
Date:   Fri, 18 Dec 2020 17:18:32 +0100
Message-Id: <20201218161843.1764-10-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Allow each command line only to update one variable and do the final
decission at the end of the parsing step. With this the order
of the command line is not important.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 src/signaltest/signaltest.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index e19fc9a740a9..61420fa13347 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -210,7 +210,6 @@ static struct bitmask *affinity_mask = NULL;
 static void process_options(int argc, char *argv[], unsigned int max_cpus)
 {
 	int error = 0;
-	int numa = 0;
 	int smp = 0;
 
 	for (;;) {
@@ -236,10 +235,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 			break;
 		switch (c) {
 		case 'a':
-			/* smp sets AFFINITY_USEALL in OPT_SMP */
-			if (smp)
-				break;
-			numa = 1;
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
 			} else if (optind < argc &&
@@ -261,12 +256,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 		case 'm': lockall = 1; break;
 		case 'p': priority = atoi(optarg); break;
 		case 'q': quiet = 1; break;
-		case 'S':
-			if (numa)
-				fatal("numa and smp options are mutually exclusive\n");
-			smp = 1;
-			num_threads = -1; /* update after parsing */
-			break;
+		case 'S': smp = 1; break;
 		case 't': num_threads = atoi(optarg); break;
 		case 'v': verbose = 1; break;
 		}
@@ -278,15 +268,16 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 	if (priority < 0 || priority > 99)
 		error = 1;
 
-	if (num_threads == -1)
-		num_threads = get_available_cpus(affinity_mask);
+	if (smp) {
+		if (affinity_mask)
+			warn("--affinity overwrites smp mode\n");
+		else
+			num_threads = get_available_cpus(affinity_mask);
+	}
 
 	if (num_threads < 2)
 		error = 1;
 
-	if (smp && affinity_mask)
-		warn("-a ignored due to smp mode\n");
-
 	if (error) {
 		if (affinity_mask)
 			numa_bitmask_free(affinity_mask);
-- 
2.29.2

