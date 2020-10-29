Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9843C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E5C20796
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy8FI8Jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgJ2Rl3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJ2Rl2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:28 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A9C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:28 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id de3so1676849qvb.5
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6zT/NK7ENrVpkoAC1cidgRL7wUpNHJ+OABss1svSxc=;
        b=dy8FI8JosgNfedyNoeP1zbq9dE2qZNhyRiIoi5REyJPPPwbsE/pX4+nHTGsj8fbj2D
         yg4gJCB4uVQ5jNnebKVc/o5mXWx07bOoFINPLjs2gm0XYbdnYbZYQIgquJINqIJxVHSx
         hrCOLNbxeOI8ku4krW/5yTzC7mQpdmPZA/0Dz3jIzu3H2a3eLSQIapBMh7Q3efUJFI8M
         h0sbl5Kpq0EuQaizvcbZL5hBqIOXvk1VH/8EhCShfEs7UC9DTEL7eMK3pBsNBSxbMs4C
         U7tEdGDLd4Mpg2tyFzXD+RSni3TfTGEmw3ORWzJCQGY6axFvkDTvrrDWjPvwH7XANf16
         TGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l6zT/NK7ENrVpkoAC1cidgRL7wUpNHJ+OABss1svSxc=;
        b=KqwyfQj+feC/lbQIzkHFkArY3d8CUWM/xFwVS7nPSK3V6oVH+GvflGTHzOQZykT4XE
         CzghvP5s962f87DjSYWwa4JG/BU3eqs5lG96UGXJgUcVsJ0CpJqx/VXlw0gGb3pBcAbz
         z2xcPRLwWO0RIl9rqc8jd3IIBXUVGQSf9AYYcmzpLKO+gILb/qx1IHK5uJn5aeKiY6aN
         +eqGEEj9XGL/riJcqi7apQz5JIb6wNy8PXKBK3y2GPSf/lfrM/mw620ImKiEpxA1MPHS
         S3fd3bIs4rFuvgiqLg3xHPNLfNzJTrEbyiOao3qGAfpPOFGkLTuG4uZcGCPQ8EFoOJLn
         xGbg==
X-Gm-Message-State: AOAM53073CdTgu7XAG05t7T5tyY0hOg/xX0Ko1+SlvLTlrBboKFWjfqB
        vfqAEusxTfBqGRX5DorCld4NmJuqadeijg==
X-Google-Smtp-Source: ABdhPJz03nI3AAYk31Rb5thNWLOAud0Os7z4MPYO4OfCXNwzPlwS4Mq1dj2LmQwldkqN32PFW8kbJg==
X-Received: by 2002:a05:6214:11b3:: with SMTP id u19mr5641659qvv.51.1603993287333;
        Thu, 29 Oct 2020 10:41:27 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 15/16] rt-tests: ssdd.c: Remove unncessary "else"
Date:   Thu, 29 Oct 2020 13:40:56 -0400
Message-Id: <20201029174057.20033-16-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

remove unnecessary "else" and also fix function header.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ssdd/ssdd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 66d6009dc572..9fa61f39f6e3 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -147,7 +147,7 @@ static pid_t parent;
 static int nforks = 10;
 static int nsteps = 10000;
 
-static void sigchld(int sig, unused siginfo_t * info, unused void *arg)
+static void sigchld(int sig, unused siginfo_t *info, unused void *arg)
 {
 	got_sigchld = 1;
 }
@@ -218,7 +218,7 @@ static int forktests(int testid)
 		       ret_sig);
 		exit(1);
 	}
-	else if (!check_sigchld()) {
+	if (!check_sigchld()) {
 		printf("forktest#%d/%d: EXITING, ERROR: "
 		       "wait on PTRACE_ATTACH saw a SIGCHLD count of %d, should be 1\n",
 		       testid, getpid(), got_sigchld);
-- 
2.26.2

