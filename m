Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EBFC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 03:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E260EB5
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 03:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhG3DGK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 23:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhG3DGJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jul 2021 23:06:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE2C061765
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jul 2021 20:06:04 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id p38so4489780qvp.11
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jul 2021 20:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAnHdPNEj81uBexFRAP2GbDjMHqOHrCTwyMfvFWrCsk=;
        b=LatzDl/DFJzZPrzD/VajlRroP7/qqNbwPJYd2xVAJ/TFXViwxLo8BwSJMk44yk3pVS
         MDCDLLvPpAfta7Dvd0MJTrtQHOCBILfcsL55jECnVGBgOQzqaOtOhgkr35pEWOUSDjWB
         CGIKfVsqtMy8xA0BLpt0l/moFXyVoLYoykW4W2gxXiNVTCk1Q3GVd9jY2o7iaUSjPCDA
         5r55kK/ZVZfDq/7N3qXgGN+JpzVHMkM4alJE29tpb+BjeRl1o1RaeMHZ1561bQtZbgXi
         RFbwb6/btkq3EKEUT981ttk/xndS+R9X+McQlS5qr/LPVzgiKDhzrNPm+JV120MPz88x
         vgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FAnHdPNEj81uBexFRAP2GbDjMHqOHrCTwyMfvFWrCsk=;
        b=nemLmt8342qMgpET2kvvDCAtXo3H7HTJEQMoXW3adwW9/h0jMt7OYFo6MfVQVO2MSj
         69WlUbZIl7URsBQ5L+oz3I/GDnqDTe1ooDHgMQYXAN/+FxP2ypZRvhOkiIpUFfiMBuPx
         xLal5smBEaPMq/AgN5sT95tNSRRPVAgweEvyUt7w27LEOP+nv2nTAHL9QTIBDX7icwaA
         GIdulDMAESzDt1TqRPAT4mkD4/QatktmSe0/gTvIxB69lwC52IqEPBw2GJoqHYTQZZ3D
         hy34CnYu2EcYhu8br8s8Q9nB/DsCJfhujORBGV6dXxcPiPPsDhuL26lVkUUYvOJgytql
         zyiQ==
X-Gm-Message-State: AOAM532A5R5IBYdXsTL5nOTvW/mgKPEkIn5u5JGQZ1p6toNieaa1R6OK
        qdlgkkuvCo/sJ1sl6TxvVIbHwES6VCJnAA==
X-Google-Smtp-Source: ABdhPJyVdAW9hWAwvwkea0WVqsfPnCiNOvT4zl8jcOR+mZBcHoW/K719rmijjME4BEF1COb4QqMnYw==
X-Received: by 2002:a05:6214:17cb:: with SMTP id cu11mr609178qvb.28.1627614363790;
        Thu, 29 Jul 2021 20:06:03 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id l29sm109398qtn.8.2021.07.29.20.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 20:06:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Jeff Epler <jepler@unpythonic.net>
Subject: [PATCH] rteval: Add __contains__ in rtevalConfig
Date:   Thu, 29 Jul 2021 23:05:40 -0400
Message-Id: <20210730030540.1098438-1-jkacur@redhat.com>
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
Correction
Suggested-by: Jeff Epler <jepler@unpythonic.net>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/rtevalConfig.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index 578aaa3ab58f..56bbc9ee0de6 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -126,6 +126,8 @@ class rtevalCfgSection:
             return self.__cfgdata[key]
         return None
 
+    def __contains__(self, key):
+        return key in self.__cfgdata
 
     def items(self):
         return list(self.__cfgdata.items())
-- 
2.31.1

