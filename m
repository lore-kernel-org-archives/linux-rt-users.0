Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D25C55179
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DED120796
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tli2sjM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgJ2Rl1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbgJ2RlZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5F8C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so2328703qtp.13
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lGETRNWA3vMw8P1n8e22RPQ0f+k+9GI9X3Y+/YYEPx4=;
        b=tli2sjM7T96yYBn9/BD4JaqLPe25AmpA55ohXtDfdeGUdO354a9hVPkKGHwuHACoev
         8tsJQjlgfVpnKVG3raxXIK5Bj95nkmXayzmDt0SPdf2X+pQEEsuYFdkSsXX7VFjfRQSB
         f7+QJyDtXZiBZUkEWcRWBGJrz+ObH4qGuQUyRBOockEqZYOVEM9qKA/GSpcXEGBi3A1d
         Mr+XluHIRsoLwa9wDDQSdT2++OiS8jryHXfLn2NTqcG7Gb5Bbg2CBTaBthXmHWpE2Rth
         izNbADARRJoNDBzdiqQKvWWS7NMaJVno5kiFdIgtgMop/ot43OiW4As6fwkmnrOczoA4
         O4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lGETRNWA3vMw8P1n8e22RPQ0f+k+9GI9X3Y+/YYEPx4=;
        b=IzpT2MJPyoR/cwDrLPgUzFutoIEpXlAQHJAdc97Zv7Kff3q+aNNI+ompgCBpF2Us68
         qZ3dHZic5K8iJxvpz160INwAGJVywtsddZQxRzx2196cr8Q4A7UtQOJd655E8FGoCMZ0
         5/EchbWd3cB8fqz4DU/43GlvCn7xynOeQ3uRxuEPrGBAAnwXJgMXvAQvl94yqK+htgcB
         sY2WS7/gfrIQwsw+SMjG77aBLis12K7elDxZEKw88vXiN4KFm69uUDyBQ9VtL1ST5Pyj
         qTxKrIC+k7Yolu8oI1FmhQy4lBvVB0bDdxYJe/cAzS4lPcNcjHfVmV+MT/hS6QsG8QcK
         gn1A==
X-Gm-Message-State: AOAM530LqlvGIx8cEzxyIKj5RKtNpb9c0qUR5/jEv2tCsz0Z9seSo1r9
        5BOjeneYtU9uBaaY6YVvyGCyhjzc9FRT0Q==
X-Google-Smtp-Source: ABdhPJwXdoI0In5WQrmraYxum9fao/4XdnKF//zJcK1Uvbpqgio5Xn7JHXHyJmkNHWpMQ1V0XfWe9w==
X-Received: by 2002:ac8:1c1b:: with SMTP id a27mr4812171qtk.157.1603993283413;
        Thu, 29 Oct 2020 10:41:23 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:22 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 11/16] rt-tests: cyclicdeadline.c: Fix spacing around commas
Date:   Thu, 29 Oct 2020 13:40:52 -0400
Message-Id: <20201029174057.20033-12-jkacur@redhat.com>
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
 src/sched_deadline/cyclicdeadline.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 5f5cdfa08f14..a6309ded3c52 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -112,7 +112,7 @@ static int find_mount(const char *mount, char *debugfs)
 	char type[100];
 	FILE *fp;
 
-	if ((fp = fopen("/proc/mounts","r")) == NULL)
+	if ((fp = fopen("/proc/mounts", "r")) == NULL)
 		return 0;
 
 	while (fscanf(fp, "%*s %"
@@ -139,7 +139,7 @@ static const char *find_debugfs(void)
 
 	if (!find_mount("debugfs", debugfs))
 		return "";
-	
+
 	debugfs_found = 1;
 
 	return debugfs;
@@ -518,8 +518,8 @@ static const char *make_cpuset(const char *name, const char *cpus,
 		fd = open_cpuset(path, "tasks");
 
 		snprintf(path, MAXPATH - 1, "%s/tasks", CPUSET_PATH);
-		if ((fp = fopen(path,"r")) == NULL) {
-			close (fd);
+		if ((fp = fopen(path, "r")) == NULL) {
+			close(fd);
 			return "opening cpuset tasks";
 		}
 
@@ -565,7 +565,7 @@ static void destroy_cpuset(const char *name, int print)
 
  again:
 	strncat(path, "/tasks", MAXPATH - 1);
-	if ((fp = fopen(path,"r")) == NULL) {
+	if ((fp = fopen(path, "r")) == NULL) {
 		fprintf(stderr, "Failed opening %s\n", path);
 		perror("fopen");
 		return;
@@ -792,7 +792,7 @@ void *run_deadline(void *data)
 
 	sched_yield();
 	period = get_time_us();
-	
+
 	while (!shutdown) {
 		period = do_runtime(tid, sd, period);
 		sched_yield();
@@ -997,19 +997,17 @@ static void loop(struct sched_data *sched_data, int nr_threads)
 	int i;
 
 	while (!shutdown) {
-		for (i = 0; i < nr_threads; i++) {
+		for (i = 0; i < nr_threads; i++)
 			print_stat(stdout, &sched_data[i], i, 0, 0);
-		}
 		usleep(10000);
 		printf("\033[%dA", nr_threads);
 	}
 	usleep(10000);
-	for (i = 0; i < nr_threads; i++) {
+	for (i = 0; i < nr_threads; i++)
 		printf("\n");
-	}
 }
 
-int main (int argc, char **argv)
+int main(int argc, char **argv)
 {
 	struct sched_data *sched_data;
 	struct sched_data *sd;
@@ -1111,9 +1109,8 @@ int main (int argc, char **argv)
 	if (setcpu)
 		make_other_cpu_list(setcpu, &allcpu_buf);
 
-	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
+	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1)
 		perror("mlockall");
-	}
 
 	setup_ftrace_marker();
 
-- 
2.26.2

