Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76DFC2BBD5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7B423B6C
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgLRQUO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:20:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:37370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbgLRQUN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:20:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF74CADF8;
        Fri, 18 Dec 2020 16:18:52 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 v2 07/20] signaltest: Always use libnuma
Date:   Fri, 18 Dec 2020 17:18:30 +0100
Message-Id: <20201218161843.1764-8-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

libnuma is hard dependency for signaltest. Thus we can always call
numa_initialize(). This allows us to remove the global 'numa' variable
to track if libnuma has been initialized or not.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/signaltest/signaltest.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 918d2ab98f6e..b3a82f8c4f65 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -206,7 +206,6 @@ static int quiet;
 static int lockall;
 static struct bitmask *affinity_mask = NULL;
 static int smp = 0;
-static int numa = 0;
 static int setaffinity = AFFINITY_UNSPECIFIED;
 
 /* Process commandline options */
@@ -214,6 +213,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 {
 	int option_affinity = 0;
 	int error = 0;
+	int numa = 0;
 
 	for (;;) {
 		int option_index = 0;
@@ -242,8 +242,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
-			if (numa_initialize())
-				fatal("Couldn't initialize libnuma");
 			numa = 1;
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
@@ -298,9 +296,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
-		if (numa_initialize())
-			fatal("Couldn't initialize libnuma");
-		numa = 1;
 		if (setaffinity == AFFINITY_UNSPECIFIED)
 			setaffinity = AFFINITY_USEALL;
 	}
@@ -354,6 +349,9 @@ int main(int argc, char **argv)
 	int status, cpu;
 	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
+	if (numa_initialize())
+		fatal("Couldn't initialize libnuma");
+
 	process_options(argc, argv, max_cpus);
 
 	if (check_privs())
-- 
2.29.2

