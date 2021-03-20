Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D459BC4345D
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF48461930
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCTSjN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhCTSil (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA759AD79;
        Sat, 20 Mar 2021 18:38:40 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 31/33] pi_stress: Add JSON output feature
Date:   Sat, 20 Mar 2021 19:38:27 +0100
Message-Id: <20210320183829.1318-32-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Write the test results as JSON output to a file. This allows to
simplifies any parsing later on.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/pi_tests/pi_stress.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 73f0e6a402e3..3f93d4aadd53 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -99,6 +99,9 @@ int debugging = 0;
 
 int quiet = 0;	/* turn off all prints, default = 0 (off) */
 
+/* filename for JSON output */
+char outfile[MAX_PATH];
+
 /* prompt to start test */
 int prompt = 0;
 
@@ -209,6 +212,7 @@ int create_group(struct group_parameters *group);
 unsigned long total_inversions(void);
 void banner(void);
 void summary(void);
+void write_stats(FILE *f, void *data);
 void wait_for_termination(void);
 int barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
 		 unsigned int count, const char *name);
@@ -235,6 +239,7 @@ int main(int argc, char **argv)
 
 
 	/* process command line arguments */
+	rt_init(argc, argv);
 	process_command_line(argc, argv);
 
 	/* set default sched attributes */
@@ -299,6 +304,7 @@ int main(int argc, char **argv)
 	}
 	/* report */
 	banner();
+	rt_test_start();
 	start = time(NULL);
 
 	/* turn loose the threads */
@@ -335,6 +341,10 @@ int main(int argc, char **argv)
 		kill(0, SIGTERM);
 	finish = time(NULL);
 	summary();
+
+	if (strlen(outfile) != 0)
+		rt_write_json(outfile, retval, write_stats, NULL);
+
 	if (lockall)
 		munlockall();
 	exit(retval);
@@ -983,6 +993,7 @@ void usage(int error)
 	       "-h       --help            print this message\n"
 	       "-i INV   --inversions=INV  number of inversions per group (default is infinite)\n"
 	       "-m       --mlockall        lock current and future memory\n"
+	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
 	       "-p       --prompt          prompt before starting the test\n"
 	       "-q       --quiet           suppress running output\n"
 	       "-r       --rr              use SCHED_RR for test threads [SCHED_FIFO]\n"
@@ -1276,7 +1287,7 @@ int process_sched_line(const char *arg)
 
 enum option_values {
 	OPT_DEBUG=1, OPT_DURATION, OPT_GROUPS, OPT_HELP, OPT_INVERSIONS,
-	OPT_MLOCKALL, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
+	OPT_MLOCKALL, OPT_OUTPUT, OPT_PROMPT, OPT_QUIET, OPT_RR, OPT_SCHED,
 	OPT_UNIPROCESSOR, OPT_VERBOSE, OPT_VERSION,
 };
 
@@ -1290,6 +1301,7 @@ void process_command_line(int argc, char **argv)
 			{"help",		no_argument,		NULL, OPT_HELP},
 			{"inversions",		required_argument,	NULL, OPT_INVERSIONS},
 			{"mlockall",		no_argument,		NULL, OPT_MLOCKALL},
+			{"output",		required_argument,	NULL, OPT_OUTPUT},
 			{"prompt",		no_argument,		NULL, OPT_PROMPT},
 			{"quiet",		no_argument,		NULL, OPT_QUIET},
 			{"rr",			no_argument,		NULL, OPT_RR},
@@ -1336,6 +1348,9 @@ void process_command_line(int argc, char **argv)
 		case 'm':
 			lockall = 1;
 			break;
+		case OPT_OUTPUT:
+			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
+			break;
 		case OPT_PROMPT:
 		case 'p':
 			prompt = 1;
@@ -1439,6 +1454,11 @@ void summary(void)
 	       t->tm_yday, t->tm_hour, t->tm_min, t->tm_sec);
 }
 
+void write_stats(FILE *f, void *data)
+{
+	fprintf(f, "  \"inversion\": %lu\n", total_inversions());
+}
+
 int
 barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
 	     unsigned int count, const char *name)
-- 
2.30.2

