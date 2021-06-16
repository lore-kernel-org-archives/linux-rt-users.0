Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93321C49EA2
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 23:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF3C611BE
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 23:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhFPXU3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhFPXU2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Jun 2021 19:20:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9447EC061760
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jun 2021 16:18:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id u30so1259245qke.7
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jun 2021 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dhv2YNhYo77dHbtzY+yZl6mZ46YuZ6r9IvT4sa4/wYo=;
        b=i/PTzlKMy+1vbmlvfBQtq177AfMFjml/Z0q5mUl1Cew/z2RSNy0GzL6ZNBFtU3Z7qc
         3uGbBxCMYmtJU1azRCPlPhC5N+azIxXr7WkjlpRvrFcKZfCuu0N0VxravuCU7E5waCLx
         i8RheZypfeRuzLVevsEF7Wu21rtzZ403sYefcoLrzeKQqTQ73VL1rlNzg/zqc7hi4WcN
         hXmFusLjFGLtSTqt9wNqVEr4bRF3402PRKaXRdOoCdrVBDoGlCvExp50wNWYtY5Wu2zI
         4SIgiLj58jBykDnp+zQYY0Y0GiU8z9UIm3teRVbVVWcPl/so9f7PsHlZr7gNU4NtIhyP
         SI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Dhv2YNhYo77dHbtzY+yZl6mZ46YuZ6r9IvT4sa4/wYo=;
        b=KY+7wQcjaPdA+6eiNxMkTg2XiusQVSjmCl+oQiRaQIQhrI8VkeeRNtWHKBXYFnh78S
         wDhO1PNl92lC1Vv0m1GfODxCCbG7RXAjFw5VA7KOUU+q6fgVGURHoeKeyVtqQv3zt6XS
         sxFMOPNRs6B4235d06qBYhvMYlv5bT6HUoSPgAVA7o+So3URkw0smY5i2K9xnvFeWKGc
         1mj9F+U1aYIXHJi6k9YRNMK6VPbof4r2s+B4UerCOgeGaacml9MbuPCJTmdoGsSCRnes
         ekSe1JT4Ev9xFMBbzVb8Sa2PpFknFaBD3FDRXfHqGyKEhmf9oT6Ogsw+jwVoSpAGHSYy
         0A7Q==
X-Gm-Message-State: AOAM5300lhcfFjUCyIwbaWAeA0UFUNs41wXcEluWw7k0lu8p8mNrhxtl
        8x0lTdxtwlu+yaTBMVFM7VqiBgBrqDlVGw==
X-Google-Smtp-Source: ABdhPJxQVluplhlO78zc2sUQGMkociCnxuhbs34r1BqsIdaDg6wfD4jc2rmBYOuYKXxExnphtJATbw==
X-Received: by 2002:a05:620a:715:: with SMTP id 21mr819977qkc.460.1623885499684;
        Wed, 16 Jun 2021 16:18:19 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id bj39sm296588qkb.78.2021.06.16.16.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:18:19 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Jonathan Schwender <schwenderjonathan@gmail.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] rt-tests: cyclictest: Add entry for mainaffinity in the manpage
Date:   Wed, 16 Jun 2021 19:18:00 -0400
Message-Id: <20210616231800.19228-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616231800.19228-1-jkacur@redhat.com>
References: <20210616231800.19228-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add an entry for mainaffinity in the manpage.
Tweek the output in cyclictest for mainaffinity as well.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 | 3 +++
 src/cyclictest/cyclictest.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 4fe42e502535..abc56e8e4970 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -94,6 +94,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
 .B \-\-laptop
 Save battery when running cyclictest. This will give you poorer realtime results, but will not drain your battery so quickly.
 .TP
+.B \-\-mainaffinity=CPUSET
+Run the main thread on CPU #N. This only affects the main thread and not the measurement threads
+.TP
 .B \-m, \-\-mlockall
 Lock current and future memory allocations to prevent being paged out
 .TP
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3477cd137c15..be8285a072b4 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -837,7 +837,8 @@ static void display_help(int error)
 	       "	 --laptop	   Save battery when running cyclictest\n"
 	       "			   This will give you poorer realtime results\n"
 	       "			   but will not drain your battery so quickly\n"
-	       "         --mainaffinity=[CPUSET]  Run the main thread on CPU #N. This only affects\n"
+	       "         --mainaffinity=CPUSET\n"
+	       "			   Run the main thread on CPU #N. This only affects\n"
 	       "                           the main thread and not the measurement threads\n"
 	       "-m       --mlockall        lock current and future memory allocations\n"
 	       "-M       --refresh_on_max  delay updating the screen until a new max\n"
-- 
2.31.1

