Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E65C4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D05A20796
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA/Ynozi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgJ2RlU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgJ2RlT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE2C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id 63so1674661qva.7
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7jzHq9bPBFbNPcWdQmAQy1FpY+UgbdjuV27KpQTUWq8=;
        b=SA/YnozinHRS+q3Ivsz2Xh/nRGUK6kP6k5Yhv3OghVRKXwOLRL5YIOvjrKCTOqsHFf
         NLCgsvbrObQ+9vVLOHapGOQvrd7sJ2lLjtRmBl1SUHkIiVmhQrYiDFDrlfFI3nIbDa2L
         hyDPenw56Gp6GMHPe1O6FhRDnPhmv3Elz17huGp++ni7GDgUYsDcE+fnl9R9RnHGyMws
         Zm4QWxIT0DxOwYQ4rFwzzvUgy2Xj1d9zg4o68Oxpimr4rCBwKWZBKZ6ZuxzbCFujOOHw
         o0XGSlLIu0VrcGggjMoGzn5vLGE3JFODaNsewhoIiM+Mt9gfjq/9uPW/dmT8YBCrXVVd
         gx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7jzHq9bPBFbNPcWdQmAQy1FpY+UgbdjuV27KpQTUWq8=;
        b=T8NM3HAA7J8B1ngidiEmGqOGVtnjy7w7xM6/u+QZkHkj+ihYkBN7y7zRiOwTxx5xOh
         dXeT8F0lgXq4/wpfLnLvM6WrQlIyRBuhtbGDKdGl9JC6PbVZpQB7xT+HmpaktUCTmlWM
         7WEepCjVRplgiAfSzOXDiSUY1CgwONKaPmjJdoNUJu+x49INLO3ONGHHholZYqNaVe9B
         x0gLgzDXdolRNoaLlV490vXO6YJy2i8W3Lf3E+Y4UmjHx9cnOBHhoRIoBLLm6MyTBOL1
         XqFlGtCOGz3kr+n8p0GFIXZPuPYgPAIQnMu7LsBduqEF9DDn17rZi5VAHErM2egotU11
         9hdQ==
X-Gm-Message-State: AOAM532Y2ARj8mlVcy7y2G96qWJ4jyik+e0oAMwgP/zjbzBl2m4kX0eP
        Z67qhctVf56X+brMCVg52ACy7Yix7u+hVA==
X-Google-Smtp-Source: ABdhPJzJ/aZGL5GdDQb2Yu2Zjt1vu/76xYTUpE2YsZ2Cpn4W2Ru6MYHcKevGnChRhkxV8SZXV9P5Yg==
X-Received: by 2002:a0c:f38b:: with SMTP id i11mr5502510qvk.41.1603993278335;
        Thu, 29 Oct 2020 10:41:18 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:17 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 06/16] rt-tests: pip_stress.c: Remove unnecessary brackets
Date:   Thu, 29 Oct 2020 13:40:47 -0400
Message-Id: <20201029174057.20033-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove unnecessary brackets as suggested by checkpatch.pl

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pip_stress.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 74cf53dcfa7a..4583aa40a6b8 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -216,9 +216,8 @@ void high(pid_t pid)
 	Pthread_mutex_lock(resource);
 	Pthread_mutex_lock(statep->mutex);
 		statep->high_owns_resource = 1;
-		if (!statep->low_owns_resource || !statep->medium_started) {
+		if (!statep->low_owns_resource || !statep->medium_started)
 			statep->inversion = 0;
-		}
 	Pthread_mutex_unlock(statep->mutex);
 	Pthread_mutex_unlock(resource);
 	kill(pid, SIGKILL);	/* kill the medium thread */
@@ -228,9 +227,8 @@ void high(pid_t pid)
 
 	if (statep->inversion)
 		printf("Successfully used priority inheritance to handle an inversion\n");
-	else {
+	else
 		printf("No inversion incurred\n");
-	}
 	Pthread_mutex_unlock(statep->mutex);
 }
 
-- 
2.26.2

