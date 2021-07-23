Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97DFC432BE
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86CA60E9C
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhGWSgD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSgC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 14:36:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9038C061575
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 12:16:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a19so2401509qtx.1
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwmaNC18sXscCMtXWmWzOlc9azNKE3E4LfYxFFgg53A=;
        b=qfkW8uZfY/W0s4NLVI8b+3lvmvbuUpFfmST6SaQj0fWmirC1ipLluXRF8JcWkBUY1X
         pNud4r3TP3kqK0r8F1qGSZRDcZRaWmCE2o4wpa2yhd0JY6YHuJ9Z8KGg/QsInmlk3Q15
         k5Pdr3PMyR78Lw2lR6GxuqNHQhlJ8mUL2gz1TDU6yAIsU+pjrzFBUoVNG0BVsBBLQYzz
         XL4D32j9RIFs9EAxebqNJHQDhTGqmsOy9ceFFOsj7fizJNNyYwugTRSNf7HHW1m32yvt
         5ITwdhaa+aOXdMJ9flPLZ2+Ajl9A7dV7d/gmCu8KkR09kW6RkfZ6ofM8WPuwE0VxkPmn
         sc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VwmaNC18sXscCMtXWmWzOlc9azNKE3E4LfYxFFgg53A=;
        b=I4sBjbqFqyRIFrHZeZs8JbLHXGovhsP1EDJI4TL3Hy7kNDTja0DD2PgG3yIKDT3v00
         FtG/wEUdFL6THKCXYgFWwSaIRSfegNIKjnRXX0R0Q9IbXm4kfLzHebF7yjsU+WDqea0M
         d8Ldx0Kkum1DZFsHmea3P/HwiaUnfB+Q8iZR6GQZEYVuvLusvF01SLnEsYXgmAllUnXW
         ugQxi1whZFkAWGykThj68ap3CQsuR7pSa8djKGVpdEq48/x1AWWb3GaKojsiaGpe0KWn
         Bd0DSeS4hI725C02/EIm2yEyY1hSYSrA21gW7kk/mSurGdPGzv5gStWvT2uk8Rxs7ycK
         bAag==
X-Gm-Message-State: AOAM5326fa+xhYzZYcnAHyme3sla9b2HYKPpoIYbggo0Sm8AaqB7KRpT
        B8qDx6/dRX+Tn/zx4YsXPxUxFrBvF5Ld1g==
X-Google-Smtp-Source: ABdhPJx8sH9RI+OYA4f1nRL7sjZBsCSn38xLzimh4xwdpS2HDBNw2ztOoYpJHrXLsrgQRNbgKVh5ww==
X-Received: by 2002:a05:622a:18a:: with SMTP id s10mr5238815qtw.269.1627067794832;
        Fri, 23 Jul 2021 12:16:34 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id a3sm7379274qtx.56.2021.07.23.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:16:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Daniel Bristot de Oliveria <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] sched_deadline: Use HRTICK_DL for sched_deadline tests
Date:   Fri, 23 Jul 2021 15:16:09 -0400
Message-Id: <20210723191609.14072-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723191609.14072-1-jkacur@redhat.com>
References: <20210723191609.14072-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If the HRTICK_DL feature is available, use it for the sched_deadline
tests, otherwise fall back to HRTICK

This code is based on changes in stalld - which in turn was based on
these sched_deadline tests

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 27 ++++++++++++++++++++++-----
 src/sched_deadline/deadline_test.c  | 28 +++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 4a38ec2274c9..4860a40f5e6b 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -278,6 +278,7 @@ static int setup_hr_tick(void)
 	char path[MAX_PATH];
 	char buf[500];
 	static int set = 0;
+	int hrtick_dl = 0;
 	char *p;
 	int ret;
 	int len;
@@ -311,18 +312,34 @@ static int setup_hr_tick(void)
 
 	ret = 1;
 
-	p = strstr(buf, "HRTICK");
-	if (p + 3 >= buf) {
+	p = strstr(buf, "HRTICK_DL");
+	if (p && p - 3 >= buf) {
+		hrtick_dl = 1;
 		p -= 3;
-		if (strncmp(p, "NO_HRTICK", 9) == 0) {
-			ret = write(fd, "HRTICK", 6);
-			if (ret != 6)
+		if (strncmp(p, "NO_HRTICK_DL", 12) == 0) {
+			ret = write(fd, "HRTICK_DL", 9);
+			if (ret != 9)
 				ret = 0;
 			else
 				ret = 1;
 		}
 	}
 
+	/* Backwards compatibility for kernel that only have HRTICK */
+	if (!hrtick_dl) {
+		p = strstr(buf, "HRTICK");
+		if (p && p - 3 >= buf) {
+			p -=3;
+			if (strncmp(p, "NO_HRTICK", 9) == 0) {
+				ret = write(fd, "HRTICK", 6);
+				if (ret != 6)
+					ret = 0;
+				else
+					ret = 1;
+			}
+		}
+	}
+
 	close(fd);
 	return ret;
 }
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index c1e890319895..a48c231c1281 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -427,6 +427,7 @@ static int setup_hr_tick(void)
 	char path[MAX_PATH];
 	char buf[500];
 	static int set = 0;
+	int hrtick_dl = 0;
 	char *p;
 	int ret;
 	int len;
@@ -461,18 +462,35 @@ static int setup_hr_tick(void)
 
 	ret = 1;
 
-	p = strstr(buf, "HRTICK");
-	if (p + 3 >= buf) {
+	p = strstr(buf, "HRTICK_DL");
+	if (p && p - 3 >= buf) {
+		hrtick_dl = 1;
 		p -= 3;
-		if (strncmp(p, "NO_HRTICK", 9) == 0) {
-			ret = write(fd, "HRTICK", 6);
-			if (ret != 6)
+		if (strncmp(p, "NO_HRTICK_DL", 12) == 0) {
+			ret = write(fd, "HRTICK_DL", 9);
+			if (ret != 9)
 				ret = 0;
 			else
 				ret = 1;
 		}
 	}
 
+	/* Backwards compatibility for kernel that only have HRTICK */
+	if (!hrtick_dl) {
+		p = strstr(buf, "HRTICK");
+		if (p && p - 3 >= buf) {
+			p -=3;
+			if (strncmp(p, "NO_HRTICK", 9) == 0) {
+				ret = write(fd, "HRTICK", 6);
+				if (ret != 6)
+					ret = 0;
+				else
+					ret = 1;
+			}
+		}
+	}
+
+
 	close(fd);
 	return ret;
 }
-- 
2.31.1

