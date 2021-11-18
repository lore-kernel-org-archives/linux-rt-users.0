Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B992C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Nov 2021 19:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3DD6128A
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Nov 2021 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhKRTTl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 14:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhKRTTl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Nov 2021 14:19:41 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1C8C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Nov 2021 11:16:41 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e8so7634861ilu.9
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Nov 2021 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kBDBMVEErwKc3buNA5SANiHQf/lwBEjjwhQ1Xez/QU=;
        b=HMxyj5bsjd9YS9JWnmvy1c3wbhfyzVYoDPuAXmIJjac+N1Qa+Wa55AorMGmq/E2Z4S
         PKM0uGZOIhG9RttHiE95WNvzRQVhham6csuZ4OoV47C2KMU1EJNHGhzlja3AbZkPZ+JJ
         bvl6ooYZ5piRk3JuN4TMZPzHuRR04xAyuYM5e8f8OToHBJbRBbEWD13OBss7bzSqi6A3
         x3Yn7Th6HtF+C1O8d9nqAtV6P5wiPuAWb4QOPgSOZnopNPyDjMnj5EsQkNbLCmCcogsP
         BJ6cZyi5lBEkktT7Cj2Xl3p1p2wZeFk9C301FH2UanJ5xZ3tg+4rJAMXyg6laKjkkPol
         Zn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/kBDBMVEErwKc3buNA5SANiHQf/lwBEjjwhQ1Xez/QU=;
        b=7OokglhDbrAIi04k0oqssXLzpIG+HH6FAY2/6MlRySBAB+hxIP1cTa7Szd36m1EUSc
         zHKZfaJ1RLq6PjnP3DyWtAg8ZQUjiaodDrxQNKnp+1qSHszT2gaNx0ryiB2UCUWrXNt/
         hI1WPb6uv1Eov+FegL/DcjMJ4RDwJfbdjtn8UsTJpQyhc4IMSZyswjQEq8gRnmwEa+6c
         me+tGKwTHsV7GfUUef6/EAShJfR2Jc2+6oNN7eZ6PdmykesHI+wmcE6i8Tj2hDRoS+YD
         vRHe7+vwbP/8xRi0CeqYGdoh02kjSIh8rZvSbqmgnVwF2SWGjQ++fIxfCZZPY9q6VzQO
         H2Gw==
X-Gm-Message-State: AOAM533PY1r9CeMq4cPQSFne+P7daNaF/1dIgt+JHqnnI5lIykrfGyDz
        uaBAm6WL56l9uvxD+YOBRGr6OV6IPjY=
X-Google-Smtp-Source: ABdhPJxtRc339awLksaLp0gUfKnR84qQ7OLtYYe54D8WZhafahYVaOsxLXQ80T1wHqTxBfLqcZdIWA==
X-Received: by 2002:a05:6e02:1d19:: with SMTP id i25mr986149ila.9.1637263000487;
        Thu, 18 Nov 2021 11:16:40 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-07-184-147-141-183.dsl.bell.ca. [184.147.141.183])
        by smtp.gmail.com with ESMTPSA id g1sm479590iov.23.2021.11.18.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:16:40 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rt-tests: cyclicdeadline: Fix double mount of cgroups
Date:   Thu, 18 Nov 2021 14:16:30 -0500
Message-Id: <20211118191630.9559-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118191630.9559-1-jkacur@redhat.com>
References: <20211118191630.9559-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If /sys/fs/cgroup exists and it is type cgroup2, cyclicdeadline mounts it a
second time as cgroup.

systemd is creating cgroup2 for logins and this can hang the machine and
not allow logins.

Fix this by:

If /sys/fs/cgroup exists, then use it for cyclicdeadline_test.

If it exists but the type is not recognized, exit with an error.
Do not simply mount is as type cgroup.

TODO: If the file doesn't exit but cgroups are supported in the kernel,
the file could be created and mounted.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 39 +++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 4860a40f5e6b..1f9a5df42d4f 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -358,6 +358,32 @@ static int mounted(const char *path, long magic)
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
 static int open_cpuset(const char *path, const char *name)
 {
 	char buf[MAXPATH];
@@ -383,14 +409,13 @@ static int mount_cpuset(void)
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

