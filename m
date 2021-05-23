Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE228C47081
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 May 2021 18:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADEEE61261
	for <linux-rt-users@archiver.kernel.org>; Sun, 23 May 2021 18:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhEWSlu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 23 May 2021 14:41:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhEWSlt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 23 May 2021 14:41:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621795222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iHwiWfmMGsWMbqpg5Sj1iXSZ3Od33cXAGAZSAkdJGC0=;
        b=1pLE1OsMVb8Os3/jMxXQLDd2aaNB5QglXsQwvpSE8QSTZk6ADrFY3UoTC2YZyIh5F/vB/B
        5Oc11FNTQPL9e17LO0l2F2E/cGsVTOCp0T5W/hApoGhb5wgrKD8sYeHZubiZ5stRf8Huuz
        1L/SyxXo7s7btF+BdfexvxF85yGOU7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621795222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iHwiWfmMGsWMbqpg5Sj1iXSZ3Od33cXAGAZSAkdJGC0=;
        b=R+AiayGW+KrhwTvDwQk2v38F/LJcHsNR7MRu7W3YQ+W8T18DYNnDVceSYS9Sa5w5q8AS9Z
        hDN/NmCOPYiMOwCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13EA5AC87;
        Sun, 23 May 2021 18:40:22 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 1/2] cyclicdeadline: Generate ftrace log entries in debug mode only
Date:   Sun, 23 May 2021 20:40:15 +0200
Message-Id: <20210523184016.32314-2-dwagner@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210523184016.32314-1-dwagner@suse.de>
References: <20210523184016.32314-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Introduce a new command line option --debug which enables the ftrace
log entries only if enabled. Currently, cyclicdeadline will log every
start of a cycle to kernel buffer, e.g. "cyclicdeadline -i 5000" gives

start at 30269625044 off=4 (period=30269625040 next=30269630040)
T: 0 (27109) I:5000 C:    230 Min:      2 Act:    2 Avg:    1 Max:       4
start at 30269635041 off=1 (period=30269635040 next=30269640040)
T: 0 (27109) I:5000 C:    232 Min:      1 Act:    1 Avg:    1 Max:       4

in case the kernel log levels are set higher which is usually the case
of CI systems.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 4c81891bbe63..dea9800b6507 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -87,8 +87,9 @@ static int cpu_count;
 static int all_cpus;
 static int nr_threads;
 static int use_nsecs;
-static int mark_fd;
+static int mark_fd = -1;
 static int quiet;
+static int debug_enabled;
 static char jsonfile[MAX_PATH];
 
 static int find_mount(const char *mount, char *debugfs)
@@ -602,6 +603,7 @@ static void usage(int error)
 	       "-D TIME  --duration        Specify a length for the test run.\n"
 	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
 	       "                           days\n"
+	       "         --debug           Enable ftrace logging\n"
 	       "-h       --help            Show this help menu.\n"
 	       "-i INTV  --interval        The shortest deadline for the tasks in us\n"
 	       "                           (default 1000us).\n"
@@ -985,7 +987,7 @@ static void write_stats(FILE *f, void *data)
 }
 
 enum options_valud {
-	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
+	OPT_AFFINITY=1, OPT_DURATION, OPT_DEBUG, OPT_HELP, OPT_INTERVAL,
 	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET
 };
 
@@ -1019,6 +1021,7 @@ int main(int argc, char **argv)
 		static struct option options[] = {
 			{ "affinity",	optional_argument,	NULL,	OPT_AFFINITY },
 			{ "duration",	required_argument,	NULL,	OPT_DURATION },
+			{ "debug",	no_argument,		NULL,	OPT_DEBUG },
 			{ "help",	no_argument,		NULL,	OPT_HELP },
 			{ "interval",	required_argument,	NULL,	OPT_INTERVAL },
 			{ "json",	required_argument,	NULL,	OPT_JSON },
@@ -1062,6 +1065,9 @@ int main(int argc, char **argv)
 		case 'D':
 			duration = parse_time_string(optarg);
 			break;
+	        case OPT_DEBUG:
+			debug_enabled = 1;
+			break;
 		case OPT_QUIET:
 		case 'q':
 			quiet = 1;
@@ -1106,7 +1112,8 @@ int main(int argc, char **argv)
 	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1)
 		warn("mlockall");
 
-	setup_ftrace_marker();
+	if (debug_enabled)
+		setup_ftrace_marker();
 
 	thread = calloc(nr_threads, sizeof(*thread));
 	sched_data = calloc(nr_threads, sizeof(*sched_data));
-- 
2.31.1

