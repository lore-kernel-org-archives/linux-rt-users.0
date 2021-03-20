Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81503C433F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010461946
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCTSjI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:51978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhCTSih (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7C44ADE3;
        Sat, 20 Mar 2021 18:38:35 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 14/33] rt-util: Remove superfluous arguments from rt_write_json
Date:   Sat, 20 Mar 2021 19:38:10 +0100
Message-Id: <20210320183829.1318-15-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We copy the command line via the rt_init() API and don't need
the argc, argv arguments for rt_write_json. Remove them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c           |  2 +-
 src/include/rt-utils.h                |  2 +-
 src/lib/rt-utils.c                    | 41 ++-------------------------
 src/oslat/oslat.c                     |  3 +-
 src/pmqtest/pmqtest.c                 |  2 +-
 src/ptsematest/ptsematest.c           |  2 +-
 src/rt-migrate-test/rt-migrate-test.c |  2 +-
 src/sched_deadline/cyclicdeadline.c   |  2 +-
 src/signaltest/signaltest.c           |  2 +-
 src/sigwaittest/sigwaittest.c         |  2 +-
 src/svsematest/svsematest.c           |  2 +-
 11 files changed, 12 insertions(+), 50 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index e817af217952..3f3b91bab53b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2134,7 +2134,7 @@ int main(int argc, char **argv)
 		printf("\033[%dB", num_threads + 2);
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, argc, argv, write_stats, NULL);
+		rt_write_json(outfile, write_stats, NULL);
 
 	if (quiet)
 		quiet = 2;
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 1dbd3f1dd8e3..115791c55185 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -82,7 +82,7 @@ static inline int64_t calctime(struct timespec t)
 
 void rt_init(int argc, char *argv[]);
 
-void rt_write_json(const char *filename, int argc, char *argv[],
+void rt_write_json(const char *filename,
 		   void (*cb)(FILE *, void *),
 		   void *data);
 
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 8f0e0943b137..f736a3449bf7 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -37,7 +37,6 @@ static int trace_fd = -1;
 static int tracemark_fd = -1;
 static __thread char tracebuf[TRACEBUFSIZ];
 static char test_cmdline[MAX_COMMAND_LINE];
-static int rt_init_run;
 
 /*
  * Finds the tracing directory in a mounted debugfs
@@ -513,35 +512,9 @@ void rt_init(int argc, char *argv[])
 
 		offset += len + 1;
 	}
-
-	rt_init_run = 1;
-}
-
-static char *get_cmdline(int argc, char *argv[])
-{
-	char *cmdline;
-	int len, i;
-
-	len = 0;
-	for (i = 0; i < argc; i++)
-		len += strlen(argv[i]) + 1;
-
-	cmdline = malloc(len);
-	if (!cmdline)
-		err_exit(ENOMEM, "Could not copy cmdline");
-
-	memset(cmdline, 0, len);
-	for (i = 0; i < argc;) {
-		cmdline = strcat(cmdline, argv[i]);
-		i++;
-		if (i < argc)
-			cmdline = strcat(cmdline, " ");
-	}
-
-	return cmdline;
 }
 
-void rt_write_json(const char *filename, int argc, char *argv[],
+void rt_write_json(const char *filename,
 		  void (*cb)(FILE *, void *),
 		  void *data)
 {
@@ -550,7 +523,6 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 	struct timeval tv;
 	char tsbuf[64];
 	struct tm *tm;
-	char *cmdline = NULL;
 	FILE *f, *s;
 	time_t t;
 	size_t n;
@@ -564,12 +536,6 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 			err_exit(errno, "Failed to open '%s'\n", filename);
 	}
 
-	if (!rt_init_run) {
-		cmdline = get_cmdline(argc, argv);
-		if (!cmdline)
-			err_exit(ENOMEM, "get_cmdline()");
-	}
-
 	gettimeofday(&tv, NULL);
 	t = tv.tv_sec;
 	tm = localtime(&t);
@@ -589,7 +555,7 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 
 	fprintf(f, "{\n");
 	fprintf(f, "  \"file_version\": 1,\n");
-	fprintf(f, "  \"cmdline:\": \"%s\",\n", rt_init_run? test_cmdline : cmdline);
+	fprintf(f, "  \"cmdline:\": \"%s\",\n", test_cmdline);
 	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
 	fprintf(f, "  \"finished\": \"%s\",\n", tsbuf);
 	fprintf(f, "  \"sysinfo\": {\n");
@@ -605,9 +571,6 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 
 	fprintf(f, "}\n");
 
-	if (!rt_init_run)
-		free(cmdline);
-
 	if (!filename || strcmp("-", filename))
 		fclose(f);
 }
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index da7b25d48384..ac54d05697ef 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -862,8 +862,7 @@ int main(int argc, char *argv[])
 	write_summary(threads);
 
 	if (strlen(g.outfile) != 0)
-		rt_write_json(g.outfile, argc, argv,
-			write_summary_json, threads);
+		rt_write_json(g.outfile, write_summary_json, threads);
 
 	if (g.cpu_list) {
 		free(g.cpu_list);
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index aae3c78f8a0a..f96b3d0bf400 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -651,7 +651,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, argc, argv, write_stats, &ps);
+		rt_write_json(outfile, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index eb7ac4ccc823..a32bfc1698f0 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -519,7 +519,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, argc, argv, write_stats, &ps);
+		rt_write_json(outfile, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index daa876d3e2b2..cdfbfafb200b 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -663,7 +663,7 @@ int main (int argc, char **argv)
 	print_results();
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, argc, argv, write_stats, NULL);
+		rt_write_json(outfile, write_stats, NULL);
 
 	if (stop) {
 		/*
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 13a1812c13b3..e6811838b62d 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1227,7 +1227,7 @@ int main(int argc, char **argv)
 	}
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, argc, argv, write_stats, sched_data);
+		rt_write_json(outfile, write_stats, sched_data);
 
 	if (setcpu_buf)
 		free(setcpu_buf);
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 4da8436e4296..6abf38b7821c 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -558,7 +558,7 @@ int main(int argc, char **argv)
 			free(stat[i].values);
 	}
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, argc, argv, write_stats, par);
+		rt_write_json(outfile, write_stats, par);
 
 	free(stat);
  outpar:
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index a1808409730a..142419f9e315 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -706,7 +706,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, argc, argv, write_stats, &ps);
+		rt_write_json(outfile, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 24e5e7adf494..7c9d21edbab2 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -778,7 +778,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, argc, argv, write_stats, &ps);
+		rt_write_json(outfile, write_stats, &ps);
 	}
 
 nosem:
-- 
2.30.2

