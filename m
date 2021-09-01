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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0284FC432BE
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1656103A
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbhIAIJo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbhIAIJn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Sep 2021 04:09:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DFFC061575
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Sep 2021 01:08:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g184so1970034pgc.6
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Sep 2021 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKUc7o3bDVU3KcNOAQzsp2ti0XgiYj19Lp1TllMahIk=;
        b=df2jsUwlkn0K4xJX5xI7auK5mHx5kd0A/5HFClzFJ0DsF2uMUHxTzFScozTKgLmOPW
         eD0p5CiGysEMIAkJwvLFciwjLLI2AHXNB5ODVyKFyToFNOQ3C0VgMLKVmznO0u4fuYuF
         c+DQXbUcGZn3K0cR/A4mAE5ZKSwPKIYLGzrwgdF5d7Llq3IrtzTAm+xGAh+HWdUNiSLE
         voYvEOeVQuz29bEfmfelXYNqBIR2aPaPq78Jp3iFaH2dXZLrX5W2g2C9IqDlLpYJR6ps
         B6jTp6JHpV2wsClENPwAEMgWvZo3SVNIC2+Lcq0UifZ7RIVaWg+beg3TDF/1jWIvR44V
         NktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKUc7o3bDVU3KcNOAQzsp2ti0XgiYj19Lp1TllMahIk=;
        b=edvKTX+k/46n7oDbqICErmufZCz3J2ZbA2F9al1vXsxuFxwDfGpma6GOi+F4TZmgyi
         VnHWvWsOc1+phIECcNGGno9QtBHT99bEjfJVfUFURNiWSggdWfPAtzPWPNc6qj7di58I
         wT3WhufFjaGsRMCsERYX3n018WYU6Wqt8J/dzxhk+nozd2O6MjYtnHbZVTJE5JdVpEnl
         4ssBrZxj5ylWB8gx022Xb7I2tQH8j+djjNuM8VNcgWiYtsL5X2Wbhk1O9Hapa5VrSFyA
         IURzF4Kh4XAZBwWY2OEddqx97lEUWVwsADtFjg5icGu01ejjsoBu4rHb3/wWxwuCHh8E
         TY5A==
X-Gm-Message-State: AOAM530Ty0MjItkVnTWG5MkdJBLHMvX1bKhw5UesPXwDhXo4M/I0/4Ja
        HD9r7I1KmYPZr8vHQSx0k426dHxhrLo=
X-Google-Smtp-Source: ABdhPJwFP6mKxed6aoH51ULAH5xRMZvTBwl2wg+OIlG4qWbcN466rJ5S6/6utist7En53AgsaToCCA==
X-Received: by 2002:a65:4209:: with SMTP id c9mr30963710pgq.399.1630483727023;
        Wed, 01 Sep 2021 01:08:47 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id ds15sm5038120pjb.19.2021.09.01.01.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:08:46 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     punit1.agrawal@toshiba.co.jp,
        Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 4/5] rteval: hackbench.py: Enable running on a system with low memory
Date:   Wed,  1 Sep 2021 17:08:15 +0900
Message-Id: <20210901080816.721731-5-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210901080816.721731-1-punitagrawal@gmail.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

The hackbench workload refues to run on RockPro64, a hexacore 64bit
Arm board with 4GB memory, complaining about insufficient memory
per-core.

On further investigation, it turns out that workload is using an
arbitrary limit of 0.75 GB/core but will quite happily run on much
lower lower memory systems.

Instead of preventing execution, convert the info message to a warning
when the memory is lower than expected but continue execution. This
should enable the workload to be used on a wider range of systems.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/loads/hackbench.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index 3b692070e9d9..ab028c495d8b 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -55,9 +55,8 @@ class Hackbench(CommandLineLoad):
         if ratio >= 0.75:
             mult = float(self._cfg.setdefault('jobspercore', 2))
         else:
-            self._log(Log.INFO, "Low memory system (%f GB/core)! Not running" % ratio)
+            self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
             mult = 0
-            self._donotrun = True
 
         sysTop = SysTopology()
         # get the number of nodes
-- 
2.32.0

