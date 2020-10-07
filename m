Return-Path: <SRS0=9Yjy=DO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41227C47420
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A1F2083B
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Oct 2020 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgJGI5C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:57:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:57636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgJGI5B (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Oct 2020 04:57:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D87FFB168;
        Wed,  7 Oct 2020 08:56:59 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v2 08/18] pip_stress: Add command line parser
Date:   Wed,  7 Oct 2020 10:56:43 +0200
Message-Id: <20201007085653.11961-9-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007085653.11961-1-dwagner@suse.de>
References: <20201007085653.11961-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a default command line parser to print at least the current
version.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/pi_tests/pip_stress.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index c9dbd992e15d..74cf53dcfa7a 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -67,12 +67,17 @@ struct State *statep;
 const int policy = SCHED_FIFO;
 const int prio_min;	/* Initialized for the minimum priority of policy */
 
-struct option long_options[] = {
-    { "usleep", required_argument, 0, 0 },
-    { 0,        0,                 0, 0 },
-};
+static void usage(int error)
+{
+	printf("pip_stress V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "pip_stress <options>\n"\
+	       "-h	--help                  Show this help menu.\n"
+	       );
+	exit(error);
+}
 
-int main(void)
+int main(int argc, char *argv[])
 {
 	void *mptr;	/* memory pointer */
 	pid_t pid1, pid2;
@@ -80,6 +85,25 @@ int main(void)
 	int res;
 	int *minimum_priority = (int*)&prio_min;
 
+	for (;;) {
+		struct option long_options[] = {
+			{ "help",	no_argument,		NULL,	'h' },
+			{ NULL,		0,			NULL,	0 },
+		};
+
+		int c = getopt_long(argc, argv, "s:h", long_options, NULL);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'h':
+			usage(0);
+			break;
+		default:
+			usage(1);
+			break;
+		};
+	}
+
 	*minimum_priority = sched_get_priority_min(policy);
 
 	if (check_privs())
-- 
2.28.0

