Return-Path: <SRS0=IZRq=DQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A14C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 20:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE2D22261
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 20:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvzjZM36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390957AbgJIUwm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Oct 2020 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbgJIUwl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Oct 2020 16:52:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D50DC0613D2
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Oct 2020 13:52:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 184so12069701lfd.6
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Oct 2020 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jq2YejlSYw4dqMWW5pqQc0yPX1S3LQDMOzXdeVInZGg=;
        b=CvzjZM36IXibvNCmcIZEIv7yOtc2xZYpnlvD71/ceNeSvwBJFjyMpmK6ArPX4lilxg
         /9CngYV3nN4JMjKllPWDrVrz4Gz2sa5I11RVO73ILTEP006fjjWXpCCN3j4M3qwMvAkp
         1eTfwfnhg4cnmU+LtKVcPBvcMqToftJZ0Y8cjfF7yP3buoZsKnuzpRJtYeReeZLMnoz8
         7hnjTjQAY53X38mwQkTVRR25zcDr5eWTwq0CB4AxBtE7a6qtNwm8DN209BBBudrpGz++
         g+L80CmWz9W+vCAxwthR/9UJjCmxBFKM40HLaXt+u4j5W7kc9hvvglkpX3IoC7qhvQ5U
         yxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jq2YejlSYw4dqMWW5pqQc0yPX1S3LQDMOzXdeVInZGg=;
        b=ArRx7WQCb9O3cWd6riaKuaDtcJqdQ9WoVZFmKVWFzKq61LgLIgo5zEhripX7U1UsaY
         uamQcyglqLNkheQkx9WrfZYl/jSFUq6t1P8TR7wI+V920vkzCIkDFqPO9bR866mCQ+3h
         QhZWFQJRJG24rCE+EgjXkhWHlLP48hvySti4aPYwNAaLlfOn46qZt3lmCIE+kAZvnL8W
         8Sg09De70c2jc2RQ+USinn2ioMen+sqbtsmgl/kHpOVMOa5fDh1HC37rQClyxeP1qS11
         XKRhLYZMtqTQ1goM6A10pCfME/bPCmlAo1jPZQTQ62oR06xCYHOX5U2Pmv+yNrJgmnW1
         hLQQ==
X-Gm-Message-State: AOAM533nuEAHk0Vy1FTcurS07ZjxZKftY15XGoDWMYgPFYvwF+lT6xiM
        RucKXtcPSKAYTbVvVUwdWEJQJg==
X-Google-Smtp-Source: ABdhPJyDGR9jDRzjjS0ho1VifOQb/EejiI1L8dGI0OBEwV5xBfwF1GKkzfY3XV5Wdfn5Q/jjhm6Dkw==
X-Received: by 2002:ac2:5982:: with SMTP id w2mr4534194lfn.392.1602276759715;
        Fri, 09 Oct 2020 13:52:39 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id l6sm533607lfk.267.2020.10.09.13.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:52:39 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     williams@redhat.com, jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] Makefile: manpages: only add get_cyclictest_snapshot if PYLIB
Date:   Fri,  9 Oct 2020 22:52:30 +0200
Message-Id: <20201009205230.887524-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Since the installation of get_cyclictest_snapshot.py is done if PYLIB
then we should only install the manpages then as well.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
Hi,

I wasn't sure if this is the correct way for the manpages or if we just
want to remove the "ifdef PYLIB" around the
src/hwlatdetect/hwlatdetect.8 ?

What do you prefer ?

Cheers,
Anders

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c3ebbd7b2a2e..5f34075a4aa1 100644
--- a/Makefile
+++ b/Makefile
@@ -49,10 +49,10 @@ MANPAGES = src/cyclictest/cyclictest.8 \
 	   src/sched_deadline/deadline_test.8 \
 	   src/ssdd/ssdd.8 \
 	   src/sched_deadline/cyclicdeadline.8 \
-	   src/cyclictest/get_cyclictest_snapshot.8 \
 	   src/oslat/oslat.8
 
 ifdef PYLIB
+	MANPAGES += src/cyclictest/get_cyclictest_snapshot.8 \
 	MANPAGES += src/hwlatdetect/hwlatdetect.8
 endif
 
-- 
2.28.0

