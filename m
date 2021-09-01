Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D7DC432BE
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3158060238
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbhIAIJk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbhIAIJi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Sep 2021 04:09:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0F9C061575
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Sep 2021 01:08:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fs6so1330759pjb.4
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Sep 2021 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rybi66JCEbmTmf201Yas6+ICLL081CrzSpc2UjxumtY=;
        b=c9xCk35I/XaRHbvVR987tyZR8hmB512ai3lLB4ErrHoKAMd4vY/hSTCDYzU0MyvwkF
         rWlpr5WzKvloRqD/S508zW18qeJwnW8KbDtloRumZIf8TffuaofWDhiKIEJuosXwEM6/
         o9+InMRxESfcySsp91oWKFDOSSY834W9mo9Wv3mj12dPJLUAZKBms+pOX2WCkLWXPQ2Q
         +pMvY/r6bQdIP0fT9JB5UijE0hn1e7V6P2CmjnCTGP6yRAoVPQLn890gKeNilbfv+qzn
         7NFqiuFVXtSWEBJGWC80Ih6qtN1BNDNUffxrYzhw69mtrltuIkB206gANvXRyNFDcbn5
         utEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rybi66JCEbmTmf201Yas6+ICLL081CrzSpc2UjxumtY=;
        b=ZObZzv6dYnMh1eR7YLIEkocuEWoJACXmxusoOFkleuRklktrsFc1Xj0mnCJ5M6+n5M
         LGArKq7KA2opT0dbKGKyRVy4lwV1TQDiLeddLt/Qhrfg7n7NKmY6q7mI9b3rdK0UOnJi
         Ho2FIL7oV5JQPJDocd6whc4bmrKUs8F/IQkZUW4/kHCFxgWX1LU3LpMcniDLD1IJXEfB
         PI5yRgx8y+9GELKtIk4YeMhVsVVSjDOAZPwO6LVVPI4Lzl8FQbnKARWSEvLkPCODebY2
         FbUyfRWk7z3Go8JiCR2YV5nN0KWTHLoWi/9Gx/o8rzbSVn68vks/zCVuHr5O4SKTHcY1
         N9WQ==
X-Gm-Message-State: AOAM532ElUi6KUPHFsManJd2SZGshdKG/6ZY3BOyvvwCG9AAmETGVBJj
        b6iSGgPI44cLIXzWToFnEDz0wKv9ZSs=
X-Google-Smtp-Source: ABdhPJwvZCYJI8XFg0e+5vBHxIAd+kYILT6MGTNFfyiJL6NnIWi2Ev3r+vkw0N95U2R99ar0GwyfkQ==
X-Received: by 2002:a17:902:74c3:b0:132:287a:c052 with SMTP id f3-20020a17090274c300b00132287ac052mr8564609plt.32.1630483721744;
        Wed, 01 Sep 2021 01:08:41 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id j6sm23584735pgq.0.2021.09.01.01.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:08:41 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     punit1.agrawal@toshiba.co.jp,
        Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 3/5] rteval: kernel.py: Add support for kthreads running with deadline policy
Date:   Wed,  1 Sep 2021 17:08:14 +0900
Message-Id: <20210901080816.721731-4-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210901080816.721731-1-punitagrawal@gmail.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

When running rteval on a system with kthreads running with "deadline"
policy, an exception is encountered when parsing the output of "ps".

    [DEBUG] cmd: /usr/bin/ps -eocommand,pid,policy,rtprio,comm
    Traceback (most recent call last):
    ...
      File "...rteval/rteval/sysinfo/kernel.py", line 60, in kernel_get_kthreads
	ret_kthreads[v[0]] = {'policy' : policies[bytes.decode(v[1])],
      KeyError: 'DLN'

The kernel uses deadline policy for "schedutil" cpufreq governor
threads. Fix the crash in rteval by adding support for "deadline" to
the list of policies.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/sysinfo/kernel.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/sysinfo/kernel.py b/rteval/sysinfo/kernel.py
index 97ad9402b13e..f2e9d72ac2ef 100644
--- a/rteval/sysinfo/kernel.py
+++ b/rteval/sysinfo/kernel.py
@@ -44,7 +44,7 @@ class KernelInfo:
 
 
     def kernel_get_kthreads(self):
-        policies = {'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
+        policies = {'DLN': 'deadline', 'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
         ret_kthreads = {}
         self.__log(Log.DEBUG, "getting kthread status")
         cmd = '%s -eocommand,pid,policy,rtprio,comm' % getcmdpath('ps')
-- 
2.32.0

