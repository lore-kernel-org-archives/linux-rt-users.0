Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480D0C4320E
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABE660EB0
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhGWSgC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSgB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 14:36:01 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA81C061575
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 12:16:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x3so2384157qkl.6
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNq/B4U2dBc8G6K/XCaGRWYL5akaMP5oc1ffDTFl8Dk=;
        b=qhBkh93rKHU0gPqujA7AP0HQBxTix4ooxhTT1WX0AyJJFHGSKcSqtfVqNlG78LJ75t
         ++rg/1g/wL2qdnDt+Y3sXHbiLd/+f3hMxmKhsqVjpbhX3SNtSueBuiZJjSkIs87u+eYh
         PqpqPJ+LzvETHYJCOmDcLo1JUc9QUBSTKi84wEPcHXDw91GFUSWwrdH1Dk1EikW+crXa
         AKoeHUY3iNTjHrUTq8IRoK9QoNOPZUQIpzBAWAEDK4ZqUackMB48mrIt0Tz0DvtJ4cQB
         kxrCI0HohHkFAWeF328wkMZoKJOYrgQ7P6IFPMQrAazm/rgvwkKDYVc4Dw/dRllyPe5Q
         aGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uNq/B4U2dBc8G6K/XCaGRWYL5akaMP5oc1ffDTFl8Dk=;
        b=EKoU5kgPlfnbBmTvgZ3RCQ2WwOZD3IKpCjmRFrAuSNIAyu4k0Oe+lqULPGnkcTHtEz
         ABIh2WYP64+CzoN1cP6kWnzN95pyup/0Si5C+1VGLvRPQjgoswklORcbPBaV1jRI0ZrZ
         TqPUNEBavq2LcqZcZ1vcj7Lx2f4ewhQ4CDBqDDxEnkBmKhgKc2zjBoqUPL3IECkDoABF
         Vaf8nnYEdPrwVmf0LiG0PgYG/clXxWu23/WzEwAam7ifdnSQjUyCE+8W/+/riWxPcpOT
         YOIMCbIF5mDUqHdY5hsAns+CKwq7zX945aNwV2tFEphWty7gGe/Asudx/tUyE2AkFTR/
         Rjaw==
X-Gm-Message-State: AOAM532Gdws1PcQ4GfUsyBQuucgBmLl3XQ6hl6A+8BZShISHmNQZq48P
        T8Eu0H5HAbK5Qq+lvQYWAwgWqhCQNwSoBQ==
X-Google-Smtp-Source: ABdhPJyvdFl6TiuAZMLju0+4d1iwEBTzrL25netpE39puaqbPxI5DXYhGnJlxzKfXCSI+LbJ2J6h6A==
X-Received: by 2002:a37:44cb:: with SMTP id r194mr6122896qka.436.1627067794107;
        Fri, 23 Jul 2021 12:16:34 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id a3sm7379274qtx.56.2021.07.23.12.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:16:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Daniel Bristot de Oliveria <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] sched_deadline: Accommodate new location of HRTICK file in kernel
Date:   Fri, 23 Jul 2021 15:16:08 -0400
Message-Id: <20210723191609.14072-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723191609.14072-1-jkacur@redhat.com>
References: <20210723191609.14072-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Newer kernels rename /sys/kernel/debug/sched_features to
/sys/kernel/debug/sched/features

Modify sched_deadline tests to look for the new file and if that fails
look for the old file name

These functions are based on ones in stalld, and stalld itself has
functions based on the sched_deadline programs in rt-tests

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 65 ++++++++++++++++++++++-------
 src/sched_deadline/deadline_test.c  | 61 +++++++++++++++++++++------
 2 files changed, 100 insertions(+), 26 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 8447424273ee..4a38ec2274c9 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -230,12 +230,53 @@ found:
 	mark_fd = open(files, O_WRONLY);
 }
 
+/*
+ * Return true if file exists
+ */
+static int check_file_exists(char *path)
+{
+	int ret;
+	struct stat st;
+
+	ret = !stat(path, &st);
+
+	return ret;
+
+}
+
+/*
+ * Return 0 on success
+ */
+
+static int fill_sched_features(char *path)
+{
+	int ret;
+	const char *debugfs;
+
+	debugfs = find_debugfs();
+	if (strlen(debugfs) == 0)
+		return -1;
+
+	snprintf(path, MAX_PATH, "%s/sched/features", debugfs);
+	ret = check_file_exists(path);
+	if (ret)
+		return 0;
+
+	snprintf(path, MAX_PATH, "%s/sched_features", debugfs);
+	ret = check_file_exists(path);
+	if (ret)
+		return 0;
+
+	memset(path, 0, MAX_PATH);
+
+	return ret;
+
+}
+
 static int setup_hr_tick(void)
 {
-	const char *debugfs = find_debugfs();
-	char files[strlen(debugfs) + strlen("/sched_features") + 1];
+	char path[MAX_PATH];
 	char buf[500];
-	struct stat st;
 	static int set = 0;
 	char *p;
 	int ret;
@@ -244,27 +285,23 @@ static int setup_hr_tick(void)
 
 	if (set)
 		return 1;
-
 	set = 1;
 
-	if (strlen(debugfs) == 0)
-		return 0;
-
-	sprintf(files, "%s/sched_features", debugfs);
-	ret = stat(files, &st);
-	if (ret < 0)
+	ret = fill_sched_features(path);
+	if (ret)
 		return 0;
 
-	fd = open(files, O_RDWR);
-	perror(files);
-	if (fd < 0)
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		perror(path);
 		return 0;
+	}
 
 	len = sizeof(buf);
 
 	ret = read(fd, buf, len);
 	if (ret < 0) {
-		perror(files);
+		perror(path);
 		close(fd);
 		return 0;
 	}
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 395c2370f69a..c1e890319895 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -368,6 +368,49 @@ found:
 	mark_fd = open(files, O_WRONLY);
 }
 
+/*
+ * Return true if file exists
+ */
+static int check_file_exists(char *path)
+{
+	int ret;
+	struct stat st;
+
+	ret = !stat(path, &st);
+
+	return ret;
+
+}
+
+/*
+ * Return 0 on success
+ */
+
+static int fill_sched_features(char *path)
+{
+	int ret;
+	const char *debugfs;
+
+	debugfs = find_debugfs();
+	if (strlen(debugfs) == 0)
+		return -1;
+
+	snprintf(path, MAX_PATH, "%s/sched/features", debugfs);
+	ret = check_file_exists(path);
+	if (ret)
+		return 0;
+
+	snprintf(path, MAX_PATH, "%s/sched_features", debugfs);
+	ret = check_file_exists(path);
+	if (ret)
+		return 0;
+
+	memset(path, 0, MAX_PATH);
+
+	return ret;
+
+}
+
 /**
  * setup_hr_tick - Enable the HRTICK in sched_features (if available)
  *
@@ -381,10 +424,8 @@ found:
  */
 static int setup_hr_tick(void)
 {
-	const char *debugfs = find_debugfs();
-	char files[strlen(debugfs) + strlen("/sched_features") + 1];
+	char path[MAX_PATH];
 	char buf[500];
-	struct stat st;
 	static int set = 0;
 	char *p;
 	int ret;
@@ -396,17 +437,13 @@ static int setup_hr_tick(void)
 
 	set = 1;
 
-	if (strlen(debugfs) == 0)
-		return 0;
-
-	sprintf(files, "%s/sched_features", debugfs);
-	ret = stat(files, &st);
-	if (ret < 0)
+	ret = fill_sched_features(path);
+	if (ret)
 		return 0;
 
-	fd = open(files, O_RDWR);
+	fd = open(path, O_RDWR);
 	if (fd < 0) {
-		perror(files);
+		perror(path);
 		return 0;
 	}
 
@@ -414,7 +451,7 @@ static int setup_hr_tick(void)
 
 	ret = read(fd, buf, len);
 	if (ret < 0) {
-		perror(files);
+		perror(path);
 		close(fd);
 		return 0;
 	}
-- 
2.31.1

