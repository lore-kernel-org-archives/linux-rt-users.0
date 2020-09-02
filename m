Return-Path: <SRS0=5+M/=CL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCDDC433E7
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D480320709
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Sep 2020 08:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBI1o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:27:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBI1g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Sep 2020 04:27:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49E80B656;
        Wed,  2 Sep 2020 08:27:35 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests 3/4] oslat: Streamline usage output and man page
Date:   Wed,  2 Sep 2020 10:27:24 +0200
Message-Id: <20200902082725.20037-4-dwagner@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902082725.20037-1-dwagner@suse.de>
References: <20200902082725.20037-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/oslat/oslat.8 |  2 +-
 src/oslat/oslat.c | 76 +++++++++++++++++++++++------------------------
 2 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/src/oslat/oslat.8 b/src/oslat/oslat.8
index 85f2c5bcdf5c..b481d8d82783 100644
--- a/src/oslat/oslat.8
+++ b/src/oslat/oslat.8
@@ -36,7 +36,7 @@ Total memory usage will be this value multiplies 2*N,
 because there will be src/dst buffers for each thread, and
 N is the number of processors for testing.
 .TP
-.B \-t, \-\-runtime=SEC
+.B \-D, \-\-duration=TIME
 Specify test duration, e.g., 60, 20m, 2H (m/M: minutes, h/H: hours, d/D: days).
 By default the unit is s/second.
 .TP
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index f1a82f2367d2..79d2b6754461 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -507,42 +507,37 @@ static void handle_alarm(int code)
 	g.cmd = STOP;
 }
 
-const char *helpmsg =
-"Usage: %s [options]\n"
-"\n"
-"This is an OS latency detector by running busy loops on specified cores.\n"
-"Please run this tool using root.\n"
-"\n"
-"Available options:\n"
-"\n"
-"  -b, --bucket-size      Specify the number of the buckets (4-1024)\n"
-"  -B, --bias             Add a bias to all the buckets using the estimated mininum\n"
-"  -c, --cpu-list         Specify CPUs to run on, e.g. '1,3,5,7-15'\n"
-"  -C, --cpu-main-thread  Specify which CPU the main thread runs on.  Default is cpu0.\n"
-"  -f, --rtprio           Using SCHED_FIFO priority (1-99)\n"
-"  -m, --workload-mem     Size of the memory to use for the workload (e.g., 4K, 1M).\n"
-"                         Total memory usage will be this value multiplies 2*N,\n"
-"                         because there will be src/dst buffers for each thread, and\n"
-"                         N is the number of processors for testing.\n"
-"  -s, --single-preheat   Use a single thread when measuring latency at preheat stage\n"
-"                         NOTE: please make sure the CPU frequency on all testing cores\n"
-"                         are locked before using this parmater.  If you don't know how\n"
-"                         to lock the freq then please don't use this parameter.\n"
-"  -t, --runtime          Specify test duration, e.g., 60, 20m, 2H\n"
-"                         (m/M: minutes, h/H: hours, d/D: days)\n"
-"  -T, --trace-threshold  Stop the test when threshold triggered (in us),\n"
-"                         print a marker in ftrace and stop ftrace too.\n"
-"  -v, --version          Display the version of the software.\n"
-"  -w, --workload         Specify a kind of workload, default is no workload\n"
-"                         (options: no, memmove)\n"
-"  -z, --zero-omit        Don't display buckets in the output histogram if all zeros.\n"
-"\n"
-;
-
-static void usage(void)
+static void usage(int error)
 {
-	printf(helpmsg, g.app_name);
-	exit(1);
+	printf("oslat V %1.2f\n", VERSION);
+	printf("Usage:\n"
+	       "oslat <options>\n\n"
+	       "This is an OS latency detector by running busy loops on specified cores.\n"
+	       "Please run this tool using root.\n\n"
+	       "Available options:\n\n"
+	       "-b, --bucket-size      Specify the number of the buckets (4-1024)\n"
+	       "-B, --bias             Add a bias to all the buckets using the estimated mininum\n"
+	       "-c, --cpu-list         Specify CPUs to run on, e.g. '1,3,5,7-15'\n"
+	       "-C, --cpu-main-thread  Specify which CPU the main thread runs on.  Default is cpu0.\n"
+	       "-D, --duration         Specify test duration, e.g., 60, 20m, 2H\n"
+	       "                       (m/M: minutes, h/H: hours, d/D: days)\n"
+	       "-f, --rtprio           Using SCHED_FIFO priority (1-99)\n"
+	       "-m, --workload-mem     Size of the memory to use for the workload (e.g., 4K, 1M).\n"
+	       "                       Total memory usage will be this value multiplies 2*N,\n"
+	       "                       because there will be src/dst buffers for each thread, and\n"
+	       "                       N is the number of processors for testing.\n"
+	       "-s, --single-preheat   Use a single thread when measuring latency at preheat stage\n"
+	       "                       NOTE: please make sure the CPU frequency on all testing cores\n"
+	       "                       are locked before using this parmater.  If you don't know how\n"
+	       "                       to lock the freq then please don't use this parameter.\n"
+	       "-T, --trace-threshold  Stop the test when threshold triggered (in us),\n"
+	       "                       print a marker in ftrace and stop ftrace too.\n"
+	       "-v, --version          Display the version of the software.\n"
+	       "-w, --workload         Specify a kind of workload, default is no workload\n"
+	       "                       (options: no, memmove)\n"
+	       "-z, --zero-omit        Don't display buckets in the output histogram if all zeros.\n"
+	       );
+	exit(error);
 }
 
 /* TODO: use libnuma? */
@@ -661,7 +656,7 @@ static void parse_options(int argc, char *argv[])
 			{ "bucket-size", required_argument, NULL, 'b' },
 			{ "cpu-list", required_argument, NULL, 'c' },
 			{ "cpu-main-thread", required_argument, NULL, 'C'},
-			{ "runtime", required_argument, NULL, 't' },
+			{ "duration", required_argument, NULL, 'D' },
 			{ "rtprio", required_argument, NULL, 'f' },
 			{ "help", no_argument, NULL, 'h' },
 			{ "trace-threshold", required_argument, NULL, 'T' },
@@ -673,7 +668,7 @@ static void parse_options(int argc, char *argv[])
 			{ "version", no_argument, NULL, 'v'},
 			{ NULL, 0, NULL, 0 },
 		};
-		int i, c = getopt_long(argc, argv, "b:Bc:C:f:hm:st:w:T:vz",
+		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:sw:T:vz",
 				       options, NULL);
 		long ncores;
 
@@ -704,7 +699,7 @@ static void parse_options(int argc, char *argv[])
 				exit(1);
 			}
 			break;
-		case 't':
+		case 'D':
 			g.runtime = parse_runtime(optarg);
 			if (!g.runtime) {
 				printf("Illegal runtime: %s\n", optarg);
@@ -761,8 +756,11 @@ static void parse_options(int argc, char *argv[])
 		case 'z':
 			g.output_omit_zero_buckets = 1;
 			break;
+		case 'h':
+			usage(0);
+			break;
 		default:
-			usage();
+			usage(1);
 			break;
 		}
 	}
-- 
2.28.0

