Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E7C4332B
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD9B64FE6
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCEHfH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:43718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCEHfG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1FB0AE89;
        Fri,  5 Mar 2021 07:35:05 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 04/14] rt-util: Copy command line before getopt_long() is called
Date:   Fri,  5 Mar 2021 08:34:50 +0100
Message-Id: <20210305073500.17926-5-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

By default, getopt_long() permutes the contents of argv as it scans,
so that eventually all the nonoptions are at the end. This is
confusing in the JSON output, thus copy the command line before we
call getopt_long().

Introduce a rt_init() which copies the command line. This makes also
rt_write_json() function arguments a bit cleaner.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c           |  3 +-
 src/include/rt-utils.h                |  7 +++--
 src/lib/rt-utils.c                    | 45 ++++++++++++---------------
 src/oslat/oslat.c                     |  5 +--
 src/pmqtest/pmqtest.c                 |  3 +-
 src/ptsematest/ptsematest.c           |  3 +-
 src/rt-migrate-test/rt-migrate-test.c |  3 +-
 src/sched_deadline/cyclicdeadline.c   |  4 ++-
 src/signaltest/signaltest.c           |  3 +-
 src/sigwaittest/sigwaittest.c         |  3 +-
 src/svsematest/svsematest.c           |  3 +-
 11 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c43dd7cbbd64..3f3b91bab53b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1778,6 +1778,7 @@ int main(int argc, char **argv)
 	int i, ret = -1;
 	int status;
 
+	rt_init(argc, argv);
 	process_options(argc, argv, max_cpus);
 
 	if (check_privs())
@@ -2133,7 +2134,7 @@ int main(int argc, char **argv)
 		printf("\033[%dB", num_threads + 2);
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, argc, argv, write_stats, NULL);
+		rt_write_json(outfile, write_stats, NULL);
 
 	if (quiet)
 		quiet = 2;
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 36af92b170df..11d69ea7e49a 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -80,8 +80,9 @@ static inline int64_t calctime(struct timespec t)
 	return time;
 }
 
-void rt_write_json(const char *filename, int argc, char *argv[],
-		   void (*cb)(FILE *, void *),
-		   void *data);
+void rt_init(int argc, char *argv[]);
+
+void rt_write_json(const char *filename,
+		   void (*cb)(FILE *, void *), void *data);
 
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 00907c573d6a..9c9d0dee3255 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -29,12 +29,14 @@
 #include "rt-error.h"
 
 #define  TRACEBUFSIZ  1024
+#define  MAX_COMMAND_LINE 4096
 
 static char debugfileprefix[MAX_PATH];
 static char *fileprefix;
 static int trace_fd = -1;
 static int tracemark_fd = -1;
 static __thread char tracebuf[TRACEBUFSIZ];
+static char cmdline[MAX_COMMAND_LINE];
 
 /*
  * Finds the tracing directory in a mounted debugfs
@@ -486,40 +488,40 @@ void disable_trace_mark(void)
 	close_tracemark_fd();
 }
 
-static char *get_cmdline(int argc, char *argv[])
+void rt_init(int argc, char *argv[])
 {
-	char *cmdline;
+	int offset = 0;
 	int len, i;
 
-	len = 0;
-	for (i = 0; i < argc; i++)
-		len += strlen(argv[i]) + 1;
+	cmdline[0] = '\0';
 
-	cmdline = malloc(len);
-	if (!cmdline)
-		err_exit(ENOMEM, "Could not copy cmdline");
-
-	memset(cmdline, 0, len);
+	/*
+	 * getopt_long() permutes the contents of argv as it scans, so
+	 * that eventually all the nonoptions are at the end. Make a
+	 * copy before calling getopt_long().
+	 */
 	for (i = 0; i < argc;) {
-		cmdline = strcat(cmdline, argv[i]);
+		len = strlen(argv[i]);
+		if (offset + len + 1 >= MAX_COMMAND_LINE)
+			break;
+
+		strcat(cmdline, argv[i]);
 		i++;
 		if (i < argc)
-			cmdline = strcat(cmdline, " ");
-	}
+			strcat(cmdline, " ");
 
-	return cmdline;
+		offset += len + 1;
+	}
 }
 
-void rt_write_json(const char *filename, int argc, char *argv[],
-		  void (*cb)(FILE *, void *),
-		  void *data)
+void rt_write_json(const char *filename,
+		   void (*cb)(FILE *, void *), void *data)
 {
 	unsigned char buf[1];
 	struct utsname uts;
 	struct timeval tv;
 	char tsbuf[64];
 	struct tm *tm;
-	char *cmdline;
 	FILE *f, *s;
 	time_t t;
 	size_t n;
@@ -533,11 +535,6 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 			err_exit(errno, "Failed to open '%s'\n", filename);
 	}
 
-	cmdline = get_cmdline(argc, argv);
-	if (!cmdline)
-		err_exit(ENOMEM, "get_cmdline()");
-
-
 	gettimeofday(&tv, NULL);
 	t = tv.tv_sec;
 	tm = localtime(&t);
@@ -573,8 +570,6 @@ void rt_write_json(const char *filename, int argc, char *argv[],
 
 	fprintf(f, "}\n");
 
-	free(cmdline);
-
 	if (!filename || strcmp("-", filename))
 		fclose(f);
 }
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 465a694cdd1d..ac54d05697ef 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -796,6 +796,8 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	rt_init(argc, argv);
+
 	g.app_name = argv[0];
 	g.rtprio = 0;
 	g.bucket_size = BUCKET_SIZE;
@@ -860,8 +862,7 @@ int main(int argc, char *argv[])
 	write_summary(threads);
 
 	if (strlen(g.outfile) != 0)
-		rt_write_json(g.outfile, argc, argv,
-			write_summary_json, threads);
+		rt_write_json(g.outfile, write_summary_json, threads);
 
 	if (g.cpu_list) {
 		free(g.cpu_list);
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index e1f59836ea07..f96b3d0bf400 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -502,6 +502,7 @@ int main(int argc, char *argv[])
 	mqstat.mq_msgsize = 8;
 	mqstat.mq_flags = 0;
 
+	rt_init(argc, argv);
 	process_options(argc, argv);
 
 	if (check_privs())
@@ -650,7 +651,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, argc, argv, write_stats, &ps);
+		rt_write_json(outfile, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 2755bfde5210..a32bfc1698f0 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -401,6 +401,7 @@ int main(int argc, char *argv[])
 	sigset_t sigset;
 	struct timespec maindelay;
 
+	rt_init(argc, argv);
 	process_options(argc, argv);
 
 	if (check_privs())
@@ -518,7 +519,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, argc, argv, write_stats, &ps);
+		rt_write_json(outfile, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 56b7b66ccdf4..cdfbfafb200b 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -535,6 +535,7 @@ int main (int argc, char **argv)
 	struct timespec intv;
 	struct sched_param param;
 
+	rt_init(argc, argv);
 	parse_options(argc, argv);
 
 	signal(SIGINT, stop_log);
@@ -662,7 +663,7 @@ int main (int argc, char **argv)
 	print_results();
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, argc, argv, write_stats, NULL);
+		rt_write_json(outfile, write_stats, NULL);
 
 	if (stop) {
 		/*
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index d7aa9bb5d269..e6811838b62d 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1009,6 +1009,8 @@ int main(int argc, char **argv)
 	int i;
 	int c;
 
+	rt_init(argc, argv);
+
 	cpu_count = sysconf(_SC_NPROCESSORS_CONF);
 	if (cpu_count < 1)
 		err_quit("Can not calculate number of CPUS\n");
@@ -1225,7 +1227,7 @@ int main(int argc, char **argv)
 	}
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, argc, argv, write_stats, sched_data);
+		rt_write_json(outfile, write_stats, sched_data);
 
 	if (setcpu_buf)
 		free(setcpu_buf);
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index e2ffc0bb8693..6abf38b7821c 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -414,6 +414,7 @@ int main(int argc, char **argv)
 	int status, cpu;
 	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
+	rt_init(argc, argv);
 	process_options(argc, argv, max_cpus);
 
 	if (check_privs())
@@ -557,7 +558,7 @@ int main(int argc, char **argv)
 			free(stat[i].values);
 	}
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, argc, argv, write_stats, par);
+		rt_write_json(outfile, write_stats, par);
 
 	free(stat);
  outpar:
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 0cdf30a6a769..142419f9e315 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -473,6 +473,7 @@ int main(int argc, char *argv[])
 	char f_opt[14];
 	struct timespec launchdelay, maindelay;
 
+	rt_init(argc, argv);
 	process_options(argc, argv);
 
 	if (check_privs())
@@ -705,7 +706,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, argc, argv, write_stats, &ps);
+		rt_write_json(outfile, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 23f84bcbd3dc..7c9d21edbab2 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -514,6 +514,7 @@ int main(int argc, char *argv[])
 	if (myfile == NULL)
 		myfile = argv[0];
 
+	rt_init(argc, argv);
 	process_options(argc, argv);
 
 	if (check_privs())
@@ -777,7 +778,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, argc, argv, write_stats, &ps);
+		rt_write_json(outfile, write_stats, &ps);
 	}
 
 nosem:
-- 
2.30.1

