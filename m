Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE48C001B0
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 21:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjHHVjY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjHHVjX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 17:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CBB10C
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691530718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jdMFx2z7qfKLv3/gJkavmaGOlj0hN3d09hF4bUT/EvM=;
        b=KNPAsFDIuURyLgyBRsDxSoF1Yyd0WmR+VXoXVytXDX9Wtdz3ZMIX4WWraruOJCxHnlVgx1
        UVPVgMLZcVD5vXeFFJdnkz6x/ksTomeXIOaljhwAluucRMdtgumkIdzo/xqs4our2UwDtD
        a+rKyCLAH+jnSBjcnGk4R4pIk8k4qwQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-KzU8E46AO0OVZgNHqB1gVw-1; Tue, 08 Aug 2023 17:38:37 -0400
X-MC-Unique: KzU8E46AO0OVZgNHqB1gVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4064E1C05EA6
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 21:38:37 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.32.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D748240C6E8A;
        Tue,  8 Aug 2023 21:38:36 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com,
        Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] rt-error: added conditional to info() and debug()
Date:   Tue,  8 Aug 2023 17:38:06 -0400
Message-Id: <20230808213805.140116-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This change was motivated by the desire to clean up the output of
cyclicdeadline, and include the extra info only when requested.

Instead of having to check if the program is in debugging mode, the
rt-error functions will automatically check by passing in an argument.

The other changes in this patch edit the function calls to debug() and
info() to work with the changes in rt-error.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 src/cyclictest/cyclictest.c         | 13 +++++--------
 src/include/rt-error.h              |  4 ++--
 src/lib/rt-error.c                  | 28 ++++++++++++++++------------
 src/lib/rt-utils.c                  |  2 +-
 src/pi_tests/pi_stress.c            |  4 ++--
 src/sched_deadline/cyclicdeadline.c | 24 ++++++++++++++++++------
 6 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 82759d1cf67b..f5af7a8a2917 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1953,10 +1953,8 @@ int main(int argc, char **argv)
 		for (k=0; k < times; k++)
 			clock_gettime(clock, &time[k]);
 
-		if (ct_debug) {
-			info("For %d consecutive calls to clock_gettime():\n", times);
-			info("time, delta time (nsec)\n");
-		}
+		info(ct_debug, "For %d consecutive calls to clock_gettime():\n", times);
+		info(ct_debug, "time, delta time (nsec)\n");
 
 		prev = time[0];
 		for (k=1; k < times; k++) {
@@ -1967,10 +1965,9 @@ int main(int argc, char **argv)
 			if (diff && (diff < min_non_zero_diff))
 				min_non_zero_diff = diff;
 
-			if (ct_debug)
-				info("%ld.%06ld  %5llu\n",
-				     time[k].tv_sec, time[k].tv_nsec,
-				     (unsigned long long)diff);
+			info(ct_debug, "%ld.%06ld  %5llu\n",
+					time[k].tv_sec, time[k].tv_nsec,
+					(unsigned long long)diff);
 		}
 
 		free(time);
diff --git a/src/include/rt-error.h b/src/include/rt-error.h
index d205e49ff041..7c4a9db55a52 100644
--- a/src/include/rt-error.h
+++ b/src/include/rt-error.h
@@ -11,8 +11,8 @@ void err_exit(int err, char *fmt, ...) __attribute__((noreturn));
 void err_msg(char *fmt, ...);
 void err_msg_n(int err, char *fmt, ...);
 void err_quit(char *fmt, ...) __attribute__((noreturn));
-void debug(char *fmt, ...);
-void info(char *fmt, ...);
+void debug(int enable, char *fmt, ...);
+void info(int enable, char *fmt, ...);
 void warn(char *fmt, ...);
 void fatal(char *fmt, ...) __attribute__((noreturn));
 void err_doit(int err, const char *fmt, va_list ap);
diff --git a/src/lib/rt-error.c b/src/lib/rt-error.c
index 616f70b044e0..9f0827530ccb 100644
--- a/src/lib/rt-error.c
+++ b/src/lib/rt-error.c
@@ -47,24 +47,28 @@ void err_quit(char *fmt, ...)
 	exit(1);
 }
 
-void debug(char *fmt, ...)
+void debug(int enable, char *fmt, ...)
 {
-	va_list ap;
+	if (enable) {
+		va_list ap;
 
-	va_start(ap, fmt);
-	fputs("DEBUG: ", stderr);
-	err_doit(0, fmt, ap);
-	va_end(ap);
+		va_start(ap, fmt);
+		fputs("DEBUG: ", stderr);
+		err_doit(0, fmt, ap);
+		va_end(ap);
+	}
 }
 
-void info(char *fmt, ...)
+void info(int enable, char *fmt, ...)
 {
-	va_list ap;
+	if (enable) {
+		va_list ap;
 
-	va_start(ap, fmt);
-	fputs("INFO: ", stderr);
-	err_doit(0, fmt, ap);
-	va_end(ap);
+		va_start(ap, fmt);
+		fputs("INFO: ", stderr);
+		err_doit(0, fmt, ap);
+		va_end(ap);
+	}
 }
 
 void warn(char *fmt, ...)
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 6c0235d0d2e0..14dac5608037 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -109,7 +109,7 @@ int mount_debugfs(char *path)
 	/* if it's already mounted just return */
 	prefix = get_debugfileprefix();
 	if (strlen(prefix) != 0) {
-		info("debugfs mountpoint: %s\n", prefix);
+		info(1, "debugfs mountpoint: %s\n", prefix);
 		return 0;
 	}
 	if (!mountpoint)
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index cba1ad92ac2d..9ce7d66751da 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -71,9 +71,9 @@
 #define DOWN_ONE "\033[1B"
 
 #define pi_info(fmt, arg...) \
-	do { if (verbose) info(fmt, ## arg); } while (0)
+	do { info(verbose, fmt, ## arg); } while (0)
 #define pi_debug(fmt, arg...) \
-	do { if (debugging) debug(fmt, ## arg); } while (0)
+	do { debug(debugging, fmt, ## arg); } while (0)
 #define pi_error(fmt, arg...) \
 	do { err_msg(fmt, ## arg); have_errors = 1; } while (0)
 
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 39aeeb5d0785..2061b92bbacc 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -80,6 +80,8 @@ struct sched_data {
 };
 
 static int shutdown;
+static int info_enable;
+static int debug_enable;
 static int tracelimit;
 static int trace_marker;
 static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
@@ -698,6 +700,8 @@ static void usage(int error)
 	       "-q       --quiet           print a summary only on exit\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "         --tracemark       write a trace mark when -b latency is exceeded\n"
+		   "		 --debug		   Print debugging info for cyclicdeadline\n"
+		   "		 --verbose		   Print useful information about the test\n"
 	       );
 	exit(error);
 }
@@ -794,7 +798,7 @@ void *run_deadline(void *data)
 	u64 period;
 	int ret;
 
-	printf("deadline thread %ld\n", tid);
+	debug(debug_enable, "deadline thread %ld\n", tid);
 	// set up for each measurment thread
 	stat->tid = tid;
 
@@ -811,7 +815,7 @@ void *run_deadline(void *data)
 	attr.sched_runtime = sd->runtime_us * 1000;
 	attr.sched_deadline = sd->deadline_us * 1000;
 
-	printf("thread[%d] runtime=%lldus deadline=%lldus\n",
+	debug(debug_enable, "thread[%d] runtime=%lldus deadline=%lldus\n",
 	      gettid(), sd->runtime_us, sd->deadline_us);
 
 	ret = sched_setattr(0, &attr, 0);
@@ -1084,7 +1088,7 @@ static void write_stats(FILE *f, void *data)
 enum options_values {
 	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
 	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET,
-	OPT_BREAKTRACE, OPT_TRACEMARK,
+	OPT_BREAKTRACE, OPT_TRACEMARK, OPT_INFO, OPT_DEBUG,
 };
 
 int main(int argc, char **argv)
@@ -1125,6 +1129,8 @@ int main(int argc, char **argv)
 			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
 			{ "breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
 			{ "tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
+			{ "verbose",	no_argument,	NULL,	OPT_INFO},
+			{ "debug",	no_argument, 	NULL, 	OPT_DEBUG},
 			{ NULL,		0,			NULL,	0   },
 		};
 		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
@@ -1177,6 +1183,12 @@ int main(int argc, char **argv)
 		case OPT_TRACEMARK:
 			trace_marker = 1;
 			break;
+		case OPT_INFO:
+			info_enable = 1;
+			break;
+		case OPT_DEBUG:
+			debug_enable = 1;
+			break;
 		default:
 			usage(1);
 		}
@@ -1251,7 +1263,7 @@ int main(int argc, char **argv)
 		sd->runtime_us = runtime;
 		sd->deadline_us = interval;
 
-		printf("interval: %lld:%lld\n", sd->runtime_us, sd->deadline_us);
+		info(info_enable, "interval: %lld:%lld\n", sd->runtime_us, sd->deadline_us);
 
 		/* Make sure that we can make our deadlines */
 		start_period = get_time_us();
@@ -1261,7 +1273,7 @@ int main(int argc, char **argv)
 			fatal("Failed to perform task within runtime: Missed by %lld us\n",
 			      end_period - start_period - sd->runtime_us);
 
-		printf("  Tested at %lldus of %lldus\n",
+		info(info_enable, "  Tested at %lldus of %lldus\n",
 		       end_period - start_period, sd->runtime_us);
 
 		interval += step;
@@ -1304,7 +1316,7 @@ int main(int argc, char **argv)
 		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
 	}
 
-	printf("main thread %d\n", gettid());
+	debug(debug_enable, "main thread %d\n", gettid());
 
 	if (shutdown)
 		fatal("failed to setup child threads at step 2");
-- 
2.39.3

