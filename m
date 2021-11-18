Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C2DC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Nov 2021 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4961266
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Nov 2021 19:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhKRTTl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 14:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhKRTTk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Nov 2021 14:19:40 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7DC061574
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Nov 2021 11:16:40 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id k1so7625159ilo.7
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Nov 2021 11:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kl51XpomHVBSccQzQucq90VTOWs0T7eKLE7Dr31BFks=;
        b=hsurpbn+cfy54yLaaBkMzdvwOysdIaI9A7Z5hJAJ2AD4E+GpU29mRDtiDVxkQdGd3D
         f270Vw1uf6ttDcJtqqUjWgtUB9d41ac/NIkcDLrNs/RDnzvbLNnmN9ELfwDD/FC54uv7
         4I08FYHVuPUB+y75l5rnA0Pd3xSGQh6p+t2S5iQ6mLqaGoiPT1cpYcCMLy02SwbEvEKs
         YrvsXjYhI+f6nL66Mk9FPc3Mgd4iYeIgFKSYI64C/Dmeayf0Tljvqin+BRvg/75flsIM
         Oxo9t0s+kFwbgVtZuBiFKpSt9BS+Ko9edpd92vAkL6oU6SeCS4mONQPDc47N5XN/+7lr
         0lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Kl51XpomHVBSccQzQucq90VTOWs0T7eKLE7Dr31BFks=;
        b=5Tj7ViiFBhMLS7Xw24dzZoOdBhg4rspYvRieMnjmZFiVuwA7/XDf45xgZO2m6RwHH/
         iV2+n3SkNxmuJiUERl8yre/O3/n3GSBVrpQAp1p53CBu8br/ape76VHB+AQ53hMFw9HC
         0FLEszfsiOj48zmgkGAroKfdCraFVKWibTT0ESQ+92ZqTQ8UZJumDsdmnyPMw3WStgTP
         zrf39Ndd7/WkPy3ApXMO4ER/3agen5UCkyCyGexvbielmEws3txJwpjf8BCU1RGRbUyn
         LsFEIhNPg3kessCUQ9fQ9eB5dBlucjoW7cX9C4fO9+5r9MkW9AC35XaHBQHaha8IdBYj
         t66A==
X-Gm-Message-State: AOAM531FaDqKpjJE45UyGFv2mj3GYC3NVJKHERisL5/fvbG1ycC3G/9U
        oYDI7CsrsQB3tdowf92kElcigPswt3Y=
X-Google-Smtp-Source: ABdhPJwHLJlySSyPVY1i+ZxVC5RWFl0983PdKfWNZvnwSJok7vb05QdrTWTdIkyZIoUGGBFQhrwvSQ==
X-Received: by 2002:a92:ca0b:: with SMTP id j11mr881298ils.289.1637262999819;
        Thu, 18 Nov 2021 11:16:39 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-07-184-147-141-183.dsl.bell.ca. [184.147.141.183])
        by smtp.gmail.com with ESMTPSA id g1sm479590iov.23.2021.11.18.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:16:39 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rt-tests: deadline_test: Fix double mount of cgroups
Date:   Thu, 18 Nov 2021 14:16:29 -0500
Message-Id: <20211118191630.9559-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If /sys/fs/cgroup exists and it is type cgroup2, deadline mounts it a
second time as cgroup.

systemd is creating cgroup2 for logins and this can hang the machine and
not allow logins.

Fix this by:

If /sys/fs/cgroup exists, then use it for deadline_test.

If it exists but the type is not recognized, exit with an error.
Do not simply mount is as type cgroup.

TODO: If the file doesn't exit but cgroups are supported in the kernel,
the file could be created and mounted.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/deadline_test.c | 39 ++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index b7e1e045b57c..11d669025425 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -518,6 +518,32 @@ static int mounted(const char *path, long magic)
 #define CGROUP_PATH "/sys/fs/cgroup"
 #define CPUSET_PATH CGROUP_PATH "/cpuset"
 
+/**
+ * cgroup_mounted - test if the path /sys/fs/cgroup exists
+ * and is a supported type
+ *
+ * Returns -1 if the path does not exist
+ * Returns 0 if the path exists but is not a cgroup type
+ * Returns 1 if the path exists and supports cgroups
+ */
+static int cgroup_mounted(void)
+{
+	int ret;
+
+	ret = mounted(CGROUP_PATH, TMPFS_MAGIC);
+	if (ret == -1)
+		return -1;	/* path doesn't exist */
+	if (ret == 1)
+		return 1;	/* tmpfs */
+	ret = mounted(CGROUP_PATH, CGROUP_SUPER_MAGIC);
+	if (ret == 1)
+		return 1;	/* cgroup v1 */
+	ret = mounted(CGROUP_PATH, CGROUP2_SUPER_MAGIC);
+	if (ret == 1)
+		return 1;
+	return 0;	/* path exists but type is not recognized */
+}
+
 /**
  * open_cpuset - open a file (usually a cpuset file)
  * @path: The path of the directory the file is in
@@ -568,14 +594,13 @@ static int mount_cpuset(void)
 	int fd;
 
 	/* Check if cgroups is already mounted. */
-	ret = mounted(CGROUP_PATH, TMPFS_MAGIC);
-	if (ret < 0)
+	ret = cgroup_mounted();
+	if (ret < 0)	/* /sys/fs/cgroup doesn't exist */
 		return ret;
-	if (!ret) {
-		ret = mount("cgroup_root", CGROUP_PATH, "tmpfs", 0, NULL);
-		if (ret < 0)
-			return ret;
-	}
+
+	if (!ret) /* /sys/fs/cgroup exists, but we don't recognize the type */
+		return -1;
+
 	ret = stat(CPUSET_PATH, &st);
 	if (ret < 0) {
 		ret = mkdir(CPUSET_PATH, 0755);
-- 
2.31.1

