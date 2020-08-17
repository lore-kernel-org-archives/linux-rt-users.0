Return-Path: <SRS0=mgec=B3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F6EC433ED
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 21:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0329D2072E
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 21:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzES+pKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgHQVzS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:55:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729014AbgHQVzP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Aug 2020 17:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597701313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OO0jc348ZLxLp/9NwPInOFiOSJWyTgXgfsF1upl2RII=;
        b=LzES+pKJXlvHmzxlm4luNjPqOiW8Xj6fmNnRfdv82VF3N/uWCMOSsq6RnPbXsc69fh1aYy
        eu1nqaEzrxfd2FLsOC0thyfxWgC4FMq8oLXZQ20hid747+7S4Zi5jIYZHcvnyMTBPmOYoe
        hyNVymL8EXPD4BejeJ17jo9l9Crvyf4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-UTwGryddMI6CB4Qmid22bQ-1; Mon, 17 Aug 2020 17:55:11 -0400
X-MC-Unique: UTwGryddMI6CB4Qmid22bQ-1
Received: by mail-qv1-f69.google.com with SMTP id i4so11880454qvv.4
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2020 14:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OO0jc348ZLxLp/9NwPInOFiOSJWyTgXgfsF1upl2RII=;
        b=rCLSKnvLkUcBaP6SXIw7BioC5zxFvGNN1NabIo/0yQdDoxEGWPW6KCXcf29obNTDaZ
         nlw0RuzG9qgz+/T83Toigz5Sr+JnXtF4tnknvB9Eo5zqOY1JWnDwazTQefilomxzbX5U
         eUCtxmsH/kDb1+eKzr/ANTlmxTpD//lpQfJWbKn0TAOIKcXYscrWfOFAIvMJoPoKdnoC
         C+MWgEx8tthTG437Zwq10uCAmx3TW0Smdx0UL5WhKtCBB7EgBZxfaaQ4KaB1Uv10XGds
         HWGnku6spphkSduQ/ExIBmNNEuhk6m7fj1jZV0qb20jrMEZifoZisapeDOKsLKyUIkQx
         XqNA==
X-Gm-Message-State: AOAM531Qx9+ScK3SilOU/JzLT31t/VID0bneB7lvJW0/6qmZv2DWE8+O
        DLuY9hsxf+GNrYJf31mSUuV2xKQnMAOSBP2ml1nazlJhbIOIBuHyStcY5cWFoyVJeynsGlo1KAZ
        eDifnCUjCO4Vg4tiaNrFJG1cmLvo=
X-Received: by 2002:a05:620a:9db:: with SMTP id y27mr14008312qky.179.1597701310643;
        Mon, 17 Aug 2020 14:55:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG4aw7CJ26yb47c7qgnR9OUUCtZ6s8BXtTtr214gNioWyI9nR0hIt7zzPN0H5a0T/zwxH5tQ==
X-Received: by 2002:a05:620a:9db:: with SMTP id y27mr14008292qky.179.1597701310270;
        Mon, 17 Aug 2020 14:55:10 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id d57sm21399826qte.91.2020.08.17.14.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:55:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, peterx@redhat.com,
        Andrew Theurer <atheurer@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 1/2] rt-tests: cyclictest: Move ftrace helpers into rt-utils.[ch]
Date:   Mon, 17 Aug 2020 17:55:04 -0400
Message-Id: <20200817215505.227046-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817215505.227046-1-peterx@redhat.com>
References: <20200817215505.227046-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Then they can be further used by other programs too.

Two trivial things to mention.

Firstly, move trace_marker out of enable_trace_mark().  No functional change.

Secondly, remove the fileprefix setting in process_options(), because if
tracelimit is non-zero, fileprefix will be after all replaced by a further call
to get_debugfileprefix() in debugfs_prepare().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 src/cyclictest/cyclictest.c | 90 +------------------------------------
 src/include/rt-utils.h      |  3 ++
 src/lib/rt-utils.c          | 82 +++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 89 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index eb61be3..dd41893 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -219,8 +219,6 @@ static pthread_barrier_t align_barr;
 static pthread_barrier_t globalt_barr;
 static struct timespec globalt;
 
-static char *procfileprefix = "/proc/sys/kernel/";
-static char *fileprefix;
 static char fifopath[MAX_PATH];
 static char histfile[MAX_PATH];
 
@@ -330,89 +328,6 @@ static inline int64_t calctime(struct timespec t)
 	return time;
 }
 
-static int trace_file_exists(char *name)
-{
-       struct stat sbuf;
-       char *tracing_prefix = get_debugfileprefix();
-       char path[MAX_PATH];
-       strcat(strcpy(path, tracing_prefix), name);
-       return stat(path, &sbuf) ? 0 : 1;
-}
-
-#define TRACEBUFSIZ 1024
-static __thread char tracebuf[TRACEBUFSIZ];
-
-static void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
-static void tracemark(char *fmt, ...)
-{
-	va_list ap;
-	int len;
-
-	/* bail out if we're not tracing */
-	/* or if the kernel doesn't support trace_mark */
-	if (tracemark_fd < 0 || trace_fd < 0)
-		return;
-
-	va_start(ap, fmt);
-	len = vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
-	va_end(ap);
-
-	/* write the tracemark message */
-	write(tracemark_fd, tracebuf, len);
-
-	/* now stop any trace */
-	write(trace_fd, "0\n", 2);
-}
-
-static void open_tracemark_fd(void)
-{
-	char path[MAX_PATH];
-
-	/*
-	 * open the tracemark file if it's not already open
-	 */
-	if (tracemark_fd < 0) {
-		sprintf(path, "%s/%s", fileprefix, "trace_marker");
-		tracemark_fd = open(path, O_WRONLY);
-		if (tracemark_fd < 0) {
-			warn("unable to open trace_marker file: %s\n", path);
-			return;
-		}
-	}
-
-	/*
-	 * if we're not tracing and the tracing_on fd is not open,
-	 * open the tracing_on file so that we can stop the trace
-	 * if we hit a breaktrace threshold
-	 */
-	if (trace_fd < 0) {
-		sprintf(path, "%s/%s", fileprefix, "tracing_on");
-		if ((trace_fd = open(path, O_WRONLY)) < 0)
-			warn("unable to open tracing_on file: %s\n", path);
-	}
-}
-
-static void debugfs_prepare(void)
-{
-	if (mount_debugfs(NULL))
-		fatal("could not mount debugfs");
-
-	fileprefix = get_debugfileprefix();
-	if (!trace_file_exists("tracing_enabled") &&
-	    !trace_file_exists("tracing_on"))
-		warn("tracing_enabled or tracing_on not found\n"
-		     "debug fs not mounted");
-}
-
-static void enable_trace_mark(void)
-{
-	if (!trace_marker)
-		return;
-
-	debugfs_prepare();
-	open_tracemark_fd();
-}
-
 /*
  * Raise the soft priority limit up to prio, if that is less than or equal
  * to the hard limit
@@ -1498,9 +1413,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			      "on this processor\n");
 	}
 
-	if (tracelimit)
-		fileprefix = procfileprefix;
-
 	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
 		error = 1;
 
@@ -2065,7 +1977,7 @@ int main(int argc, char **argv)
 	/* use the /dev/cpu_dma_latency trick if it's there */
 	set_latency_target();
 
-	if (tracelimit)
+	if (tracelimit && trace_marker)
 		enable_trace_mark();
 
 	if (check_timer())
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 6ec2b20..51489b4 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -27,4 +27,7 @@ pid_t gettid(void);
 
 int parse_time_string(char *val);
 
+void enable_trace_mark(void);
+void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 1998a32..f786588 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -24,7 +24,13 @@
 #include "rt-sched.h"
 #include "error.h"
 
+#define  TRACEBUFSIZ  1024
+
 static char debugfileprefix[MAX_PATH];
+static char *fileprefix;
+static int trace_fd = -1;
+static int tracemark_fd = -1;
+static __thread char tracebuf[TRACEBUFSIZ];
 
 /*
  * Finds the tracing directory in a mounted debugfs
@@ -355,3 +361,79 @@ int parse_time_string(char *val)
 	}
 	return t;
 }
+
+void open_tracemark_fd(void)
+{
+	char path[MAX_PATH];
+
+	/*
+	 * open the tracemark file if it's not already open
+	 */
+	if (tracemark_fd < 0) {
+		sprintf(path, "%s/%s", fileprefix, "trace_marker");
+		tracemark_fd = open(path, O_WRONLY);
+		if (tracemark_fd < 0) {
+			warn("unable to open trace_marker file: %s\n", path);
+			return;
+		}
+	}
+
+	/*
+	 * if we're not tracing and the tracing_on fd is not open,
+	 * open the tracing_on file so that we can stop the trace
+	 * if we hit a breaktrace threshold
+	 */
+	if (trace_fd < 0) {
+		sprintf(path, "%s/%s", fileprefix, "tracing_on");
+		if ((trace_fd = open(path, O_WRONLY)) < 0)
+			warn("unable to open tracing_on file: %s\n", path);
+	}
+}
+
+int trace_file_exists(char *name)
+{
+       struct stat sbuf;
+       char *tracing_prefix = get_debugfileprefix();
+       char path[MAX_PATH];
+       strcat(strcpy(path, tracing_prefix), name);
+       return stat(path, &sbuf) ? 0 : 1;
+}
+
+void debugfs_prepare(void)
+{
+	if (mount_debugfs(NULL))
+		fatal("could not mount debugfs");
+
+	fileprefix = get_debugfileprefix();
+	if (!trace_file_exists("tracing_enabled") &&
+	    !trace_file_exists("tracing_on"))
+		warn("tracing_enabled or tracing_on not found\n"
+		     "debug fs not mounted");
+}
+
+void tracemark(char *fmt, ...)
+{
+	va_list ap;
+	int len;
+
+	/* bail out if we're not tracing */
+	/* or if the kernel doesn't support trace_mark */
+	if (tracemark_fd < 0 || trace_fd < 0)
+		return;
+
+	va_start(ap, fmt);
+	len = vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
+	va_end(ap);
+
+	/* write the tracemark message */
+	write(tracemark_fd, tracebuf, len);
+
+	/* now stop any trace */
+	write(trace_fd, "0\n", 2);
+}
+
+void enable_trace_mark(void)
+{
+	debugfs_prepare();
+	open_tracemark_fd();
+}
-- 
2.26.2

