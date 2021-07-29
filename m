Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B9C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 22:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED8F60F23
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 22:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhG2WHl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 18:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhG2WHl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jul 2021 18:07:41 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4ABC061765
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jul 2021 15:07:36 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 3so4215346qvd.2
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jul 2021 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCpUjeibQCa1vPSqt+HzhZoML3RWS9DDOT8UINEtchM=;
        b=J6DI8EgJ3nRd1pnHxvcWXRkWcJ5g6Ldq5t/rOCwASMtFh01LzBaHa5Sm99WcCvF4IP
         /Ro8tgWX1g/gyc6dgh9t/l75zX3Knd3/UbKzxjH6krqY0lGTcVAnB5Yvn8PG9GuLWmoP
         GSBfehq0n1NZQ3IsTylVPbbf/Wo2PL3mFl8xUiw0cdDuBKmMI7hxwdwOy4/Dwvansv7y
         zUJ7m3iIBk19Y2l73QjkBErFJ7uU1BzzEaQaxdM3UDf8kXuojXDKJFfzOrHED/xHLnAb
         xo442hdjUrSefNL6I9Xo1uyoMmq5nAEOCiNnUqsKFSE9C36lXQO+vG3x3BDjnqzk1lP9
         Dxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=UCpUjeibQCa1vPSqt+HzhZoML3RWS9DDOT8UINEtchM=;
        b=PbazSlZLZRsREbFx7RO8OSKFEjD6+qONW2bjvl6q8MWldjuJX5BrUWGubg6TwStN82
         SVEDpPkKYFOkzck092GsNcSuPD32++BCp7jVIuLeC6s5cfjXD1433mmqI+ahM3/jj3q+
         +YT04urHvwISwmmCFSe6lUk83XRig3RsO84sR1olL7aWS3LfP3IBCN3Cm6e4n85qinqB
         aIs2z7QxHzGN68Hn+TaRzNH5Goyj+Eku0sQcar2uyqyj3QWa3KR9LDKP0Xwy24u3ENWC
         Du2YSh2aJlAnN1DEksewyKnKBgaZ4Rz54TPnuXmOpQUf64E8bo/GA9MnHQq/4WSIIfM+
         VkYw==
X-Gm-Message-State: AOAM532W28c2Z4Dcf2odwRZGr3Aj+BMCf7crt2+pk31NcyKjGOs1mdIl
        GES37TjqVTe4srwPfmlmVQjtOF+NhjUHOg==
X-Google-Smtp-Source: ABdhPJxwSGk+cyAOXWoA3sXaPihfMcZo/pxPgr/ZFj1eK3i1FZBA+dd5K2R+pJgvz7+tlo3fhdY4+A==
X-Received: by 2002:ad4:4801:: with SMTP id g1mr7554364qvy.34.1627596455414;
        Thu, 29 Jul 2021 15:07:35 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id h10sm1849126qta.74.2021.07.29.15.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:07:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Subject: [PATCH] rteval: Add __contains__ in rtevalConfig
Date:   Thu, 29 Jul 2021 18:07:13 -0400
Message-Id: <20210729220713.822137-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add the __contains__ function to the rtevalCfgSection class  to make "in"
function correctly.

For example in cyclictest.py, self.__cfg is not a dictionary, it is an
instance of the rtevalCfgSection class, therefore
key in self.__cfg
does not work as expected. In order to make sure this is fixed
everywhere, instead of comparing to self.__cfg.keys() everywhere this is
used, implement the __contains__ function so that "in" works as
expected.

This bug was introduced by the commit fd3b732f714d ("rteval: 2to3
transformations")

Reported-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/rtevalConfig.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index 578aaa3ab58f..b6fccc45ab7f 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -126,6 +126,10 @@ class rtevalCfgSection:
             return self.__cfgdata[key]
         return None
 
+    def __contains__(self, key):
+        if key in self.__cfgdata.keys():
+            return self.__cfgdata[key]
+        return None
 
     def items(self):
         return list(self.__cfgdata.items())
-- 
2.31.1

