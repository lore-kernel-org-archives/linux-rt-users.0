Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A52C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6393761262
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 12:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhIOMQN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbhIOMQL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Sep 2021 08:16:11 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C158C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 05:14:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bk29so3097710qkb.8
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFcsddWTkbHGJDFdFq3ylKEJjxLHF33vYwEKXGJH55Q=;
        b=dWlI9JDlxuS1UfqiTI3WsY0R7tdSoERgicSt24bmD9O/h60xzGg2yVWwAJ5/pVhlLn
         0eHhgSyW9RnyveAIETrhwUNNvMLkJZYnmCwl6V+3EA0y67O98AdjMDai4UuU2rcZoMTn
         L0OOUbX3G2zTwg44oy4E/17LCGHA5g1KppYPr/PkJDrFiI+hwWJ73DAXI1DcrPG1KMOs
         +2Y5psPUo6NYZ/iMVoYILWgAzbG/r0xCMD6kMLTfv944w0o6zddsJ7Ko7Mc1MuLZQvF7
         ZwYdAqqkZcJWvjPRri5uFX2BoyMUG2Et9sIpT5sBZ4PyTctD58hir+MUqpZZYvWB3LBt
         7uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cFcsddWTkbHGJDFdFq3ylKEJjxLHF33vYwEKXGJH55Q=;
        b=qDKZuKC5YuBgsxQROJTMqUynAOntActDf6UZ4/IemVMPoE/oZFMUgfDffUHrO/WHdr
         UYUyzoUWUafCHFr07QcwuOrQkchio1qel+LXBC1srjYjskcvswkDM//CUYM2xl5zeJDC
         QQqvP9OiMG7DnMMZKE0iF7zqxuIqxcyZDCJh5Jldkxq90urmLjFMz04uaN354ptByETP
         Q/DIqwHRjp3qs8JNz2FrWmAUQA1Mc3Cp+G2ddBpXSsvdFRAICms6ntv2QzxbPAijxaMK
         6dGGM92FN8xCMSwOw1YyGBs8GxpuqQT9zuT0bCsq7NNo9jYSlrVZlUf125JSsAwQPWp6
         6lnQ==
X-Gm-Message-State: AOAM531EA8Pc7rUKoEGpZ5eh+28Z/AIASKygBV95+WsuvX/MvluUHVwa
        x6uJa1YNh6LBbx4vwXyAKZQ6KcHIT+k=
X-Google-Smtp-Source: ABdhPJxD0zF7mPxy6aCkqx63m95lJALPupPpaO7aupx92V1V6jo1U7j/1KbgeBH2EYQGWHjGHq/udQ==
X-Received: by 2002:a05:620a:2147:: with SMTP id m7mr9826891qkm.117.1631708091688;
        Wed, 15 Sep 2021 05:14:51 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id 9sm7768466qtz.83.2021.09.15.05.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:14:51 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: services: Iterate through items in MakeReport
Date:   Wed, 15 Sep 2021 08:14:30 -0400
Message-Id: <20210915121432.5472-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Iterate through items instead of keys in MakeReport.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/services.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
index 283109b9b234..e5de22efc342 100644
--- a/rteval/sysinfo/services.py
+++ b/rteval/sysinfo/services.py
@@ -111,10 +111,10 @@ class SystemServices:
         rep_n = libxml2.newNode("Services")
         rep_n.newProp("init", self.__init)
 
-        for s in srvs:
+        for service, val in srvs.items():
             srv_n = libxml2.newNode("Service")
-            srv_n.newProp("state", srvs[s])
-            srv_n.addContent(s)
+            srv_n.newProp("state", val)
+            srv_n.addContent(service)
             rep_n.addChild(srv_n)
 
         return rep_n
-- 
2.31.1

