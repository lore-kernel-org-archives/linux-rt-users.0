Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89AFC433E6
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F7864F59
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCEHfI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:35:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:43740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCEHfH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:35:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45C31AEC2;
        Fri,  5 Mar 2021 07:35:06 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v2 06/14] rt-util: Add return_code to common section of JSON output
Date:   Fri,  5 Mar 2021 08:34:52 +0100
Message-Id: <20210305073500.17926-7-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Many rt-tests return an error code if the test fails. Let's add
this information to the common section.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c           |  2 +-
 src/include/rt-utils.h                |  2 +-
 src/lib/rt-utils.c                    | 11 ++++++++---
 src/oslat/oslat.c                     |  2 +-
 src/pmqtest/pmqtest.c                 |  2 +-
 src/ptsematest/ptsematest.c           |  2 +-
 src/rt-migrate-test/rt-migrate-test.c |  2 +-
 src/sched_deadline/cyclicdeadline.c   |  2 +-
 src/signaltest/signaltest.c           |  2 +-
 src/sigwaittest/sigwaittest.c         |  2 +-
 src/svsematest/svsematest.c           |  2 +-
 11 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 033b95a3a19a..59dda1973b1a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2135,7 +2135,7 @@ int main(int argc, char **argv)
 		printf("\033[%dB", num_threads + 2);
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, write_stats, NULL);
+		rt_write_json(outfile, ret, write_stats, NULL);
 
 	if (quiet)
 		quiet = 2;
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index d83f11930998..5194c239d648 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -84,7 +84,7 @@ void rt_init(int argc, char *argv[]);
 
 void rt_test_start(void);
 
-void rt_write_json(const char *filename,
+void rt_write_json(const char *filename, int return_code,
 		   void (*cb)(FILE *, void *), void *data);
 
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 09d79170c371..69f3b4669c9b 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -534,7 +534,7 @@ void rt_test_start(void)
 	get_timestamp(ts_start);
 }
 
-void rt_write_json(const char *filename,
+void rt_write_json(const char *filename, int return_code,
 		   void (*cb)(FILE *, void *), void *data)
 {
 	unsigned char buf[1];
@@ -571,6 +571,7 @@ void rt_write_json(const char *filename,
 	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
 	fprintf(f, "  \"start_time\": \"%s\",\n", ts_start);
 	fprintf(f, "  \"end_time\": \"%s\",\n", ts_end);
+	fprintf(f, "  \"return_code\": %d,\n", return_code);
 	fprintf(f, "  \"sysinfo\": {\n");
 	fprintf(f, "    \"sysname\": \"%s\",\n", uts.sysname);
 	fprintf(f, "    \"nodename\": \"%s\",\n", uts.nodename);
@@ -578,9 +579,13 @@ void rt_write_json(const char *filename,
 	fprintf(f, "    \"version\": \"%s\",\n", uts.version);
 	fprintf(f, "    \"machine\": \"%s\",\n", uts.machine);
 	fprintf(f, "    \"realtime\": %d\n", rt);
-	fprintf(f, "  },\n");
 
-	(cb)(f, data);
+	if (cb) {
+		fprintf(f, "  },\n");
+		(cb)(f, data);
+	} else {
+		fprintf(f, "  }\n");
+	}
 
 	fprintf(f, "}\n");
 
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 2f02f5399405..37d528f0f7ff 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -863,7 +863,7 @@ int main(int argc, char *argv[])
 	write_summary(threads);
 
 	if (strlen(g.outfile) != 0)
-		rt_write_json(g.outfile, write_summary_json, threads);
+		rt_write_json(g.outfile, 0, write_summary_json, threads);
 
 	if (g.cpu_list) {
 		free(g.cpu_list);
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index adf72c10ce83..af10b416600c 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -652,7 +652,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, write_stats, &ps);
+		rt_write_json(outfile, 0, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 471f1b307c14..70eb79e89635 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -520,7 +520,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, write_stats, &ps);
+		rt_write_json(outfile, 0, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 8f628d347a23..1e0abdd6c0fa 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -664,7 +664,7 @@ int main (int argc, char **argv)
 	print_results();
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, write_stats, NULL);
+		rt_write_json(outfile, check < 0, write_stats, NULL);
 
 	if (stop) {
 		/*
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index a649e5a0fe5e..8d801b4c154a 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1228,7 +1228,7 @@ int main(int argc, char **argv)
 	}
 
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, write_stats, sched_data);
+		rt_write_json(outfile, 0, write_stats, sched_data);
 
 	if (setcpu_buf)
 		free(setcpu_buf);
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 7327d0d0144d..f43920e1a853 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -559,7 +559,7 @@ int main(int argc, char **argv)
 			free(stat[i].values);
 	}
 	if (strlen(outfile) != 0)
-		rt_write_json(outfile, write_stats, par);
+		rt_write_json(outfile, ret, write_stats, par);
 
 	free(stat);
  outpar:
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 6e8bc7b50d5f..fda44724dd62 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -707,7 +707,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, write_stats, &ps);
+		rt_write_json(outfile, 0, write_stats, &ps);
 	}
 
 nomem:
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 7533b1b569cc..9485ab6d95c8 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -779,7 +779,7 @@ int main(int argc, char *argv[])
 			.receiver = receiver,
 			.sender = sender,
 		};
-		rt_write_json(outfile, write_stats, &ps);
+		rt_write_json(outfile, 0, write_stats, &ps);
 	}
 
 nosem:
-- 
2.30.1

