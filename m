Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E5C4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59632076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rb08vBf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgJ2Rl1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgJ2RlZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:25 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4DC0613D2
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:25 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g13so1684923qvu.1
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9oiVSl6mSYYSXlclsIwtpojApqA+RfyCJ6ktBTGLQY=;
        b=rb08vBf6qQXiU3udlPOWL4OIeFXjub2/3BnZQJVndWCUnsNPUw8FUfcUSJ4Ynf4a94
         Ujtg+JC56dLlLACXkQClPMZvfTzO89TN+fMGRlrKZAvQXpdgZnXzrmmXZ+6nIJzluorK
         DN06gnZSzdqAyMsXTWoDN1TXPfIOyjZ1qafqmCE2A2DJcasMlkcwypgKP06TearssS44
         QuhV5/cgxVO0l8R7Gnp3cfNstX4pEZ0F6xZwmgQCxV6hF7hO7G+YscOPITgC21jpAO/K
         cVb9ge2yTP+cFJnky1ihNrQn0Zy9U1AZzMRsaCtWfxpW2Y1RK53sr9Tg/dMy8J+em/XZ
         5E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t9oiVSl6mSYYSXlclsIwtpojApqA+RfyCJ6ktBTGLQY=;
        b=doFAGOyUV++XmBOR9BxJIBnlXmYzWpFbwrT1bNHni0hQIcI1IqQWJPvvhsGsIMJmNh
         tGNEiQNy5q42+9bG1HWP0yUeP7CPNcyK7RGJ5ABfa4d7f93uHfDGKleT77mSykvgl5CM
         nk/Hzl400ZC0tdR0f6K12CFWerEeKo1DaDyyzK7UsYCWtekqH+0aTzwhlo0nPqtzfv5I
         rIwx3f9LL8/9x/1FRuxHZIE9BLQ9gmssD4jkGgDr07yGbXkhiwl2vCX0nBusoEhwRcGH
         OIb1Fg+UqzWrR/TuGS6mGXJt0shrNHZa5Gtnca5FGxiPKub69S7cHX0UXWH1SvoRX05h
         QZFg==
X-Gm-Message-State: AOAM531Ol3kZTyif3mkEL+LValX3vu9eMwn8W5ZRN43mRPYr5fK4gmY4
        ka4TLdxdUSPj3fOWA8epqX/XU+x136Vgew==
X-Google-Smtp-Source: ABdhPJxkeaHExG3BxMrzbQ8ME7P1LQ0NtcG3qWuPO8pAmBJcm/9+DXRBhIoQ+W+fjlbl75Oc1usGZA==
X-Received: by 2002:a05:6214:1541:: with SMTP id t1mr5286739qvw.61.1603993284353;
        Thu, 29 Oct 2020 10:41:24 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:23 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 12/16] rt-tests: deadline_test.c: Fix spacing around commas
Date:   Thu, 29 Oct 2020 13:40:53 -0400
Message-Id: <20201029174057.20033-13-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix spacing around commas and remove unnecessary brackets

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/deadline_test.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 060ac896aef2..395c2370f69a 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -49,7 +49,7 @@
  * @error: Exit error code to be used
  *
  * This is defined here to show peoplde looking at this code how
- * to use this program as well. 
+ * to use this program as well.
  */
 static void usage(int error)
 {
@@ -185,7 +185,7 @@ static int find_mount(const char *mount, char *debugfs)
 	char type[100];
 	FILE *fp;
 
-	if ((fp = fopen("/proc/mounts","r")) == NULL)
+	if ((fp = fopen("/proc/mounts", "r")) == NULL)
 		return 0;
 
 	while (fscanf(fp, "%*s %"
@@ -218,7 +218,7 @@ static const char *find_debugfs(void)
 
 	if (!find_mount("debugfs", debugfs))
 		return "";
-	
+
 	debugfs_found = 1;
 
 	return debugfs;
@@ -705,8 +705,8 @@ static const char *make_cpuset(const char *name, const char *cpus,
 		fd = open_cpuset(path, "tasks");
 
 		snprintf(path, MAXPATH - 1, "%s/tasks", CPUSET_PATH);
-		if ((fp = fopen(path,"r")) == NULL) {
-			close (fd);
+		if ((fp = fopen(path, "r")) == NULL) {
+			close(fd);
 			return "opening cpuset tasks";
 		}
 
@@ -768,7 +768,7 @@ static void destroy_cpuset(const char *name, int print)
 	 * in this cpuset, that must be moved before destroying the cpuset.
 	 */
 	strncat(path, "/tasks", MAXPATH - 1);
-	if ((fp = fopen(path,"r")) == NULL) {
+	if ((fp = fopen(path, "r")) == NULL) {
 		fprintf(stderr, "Failed opening %s\n", path);
 		perror("fopen");
 		return;
@@ -1276,7 +1276,7 @@ void *run_deadline(void *data)
 
 	sched_yield();
 	period = get_time_us();
-	
+
 	while (!done) {
 		period = do_runtime(tid, sched_data, period);
 		sched_yield();
@@ -1335,9 +1335,8 @@ void *run_rt_spin(void *data)
 	if (fail)
 		return NULL;
 
-	while (!done) {
+	while (!done)
 		get_time_us();
-	}
 
 	return NULL;
 }
@@ -1689,7 +1688,7 @@ static u64 calculate_loops_per_ms(u64 *overhead)
 	return loops;
 }
 
-int main (int argc, char **argv)
+int main(int argc, char **argv)
 {
 	struct sched_data *sched_data;
 	struct sched_data *sd;
@@ -1819,9 +1818,8 @@ int main (int argc, char **argv)
 		exit(-1);
 	}
 
-	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
+	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1)
 		perror("mlockall");
-	}
 
 	/*
 	 * Run at prio 99 bound to the last CPU, and try to calculate
@@ -1920,9 +1918,8 @@ int main (int argc, char **argv)
 
 	pthread_barrier_wait(&barrier);
 
-	if (fail) {
+	if (fail)
 		exit(-1);
-	}
 
 	if (!all_cpus) {
 		int *pids;
-- 
2.26.2

