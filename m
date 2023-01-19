Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0705FC004D4
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Jan 2023 19:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjASTva (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 14:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjASTv1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Jan 2023 14:51:27 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E5875A0C
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 11:51:26 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z9so2446979qtv.5
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 11:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5gvMjGRJKCHT6sMVRD7W9Vsnom0ogPgXYwOkJZ4gfGY=;
        b=JOJY67G7POZa45N31jNa13D4Pk+NV4QN8CraHWeh1g2XRUCIq1CHdYDpyyAEY/oHTe
         7t9QP3Xjlgoj6LE0924ybI0eamgml4WsBZY6ZX8/hT7+5XeZJE3IlBA0QaPXSGI+ohJZ
         b8P3kVD5Zfmz8+6P33Ua9T/Td6Apm9Dv7H5pO1UFUo1/l9L3QfcgAKVGkTWGID/vUvWf
         kTRanekuPLvrAZrljHOLrAz7jzz2uaC+5XPczA4KXo50Gv+KPZzktAlYCLRe+AVhhZFQ
         Y2bGrPlel7YLJ0h2kBWu9nydX52bQQszIX7UxV5vtbAFHt/mMmBB6RiaTKGS183pe9z4
         eXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gvMjGRJKCHT6sMVRD7W9Vsnom0ogPgXYwOkJZ4gfGY=;
        b=zvmtmmyiJ7S0IllZbbn03cKxBMnkUWi/zAPp0DP6NJFntmakbKaoEUs4+kkUzyK1EJ
         HL0K1A/vZZD5tEtGaAehj+N8M1j35c7gSQPthEbgXI3Xuv96MgDNtYfdoKDDiegqZ66u
         Z2CnY17WqbQxL/5fphjOc3uuYsWKcu1Uz2jNOzpquSiMq+I1gj1pJVmF9fTKwZMMco+6
         FMc3tmvDG8ZQoTHswrV8MdRAFIhiCXakl2p467yLgexBktfhpKTyR91YSs2bfZXINRhF
         IS51NJYEetTNn8vR+N0F9D5pcylMnTw+ZS8NE/mG1Tkq+88LaTZ64T4EGgJallMRYXzt
         q0pg==
X-Gm-Message-State: AFqh2komo7PN3+SlOj7y1uU8FMinq4dxDEunef51eKriiDTyzpQrJ1MG
        9QS+T3QBtJNAzS8gjDoX2asw4x4ONG8=
X-Google-Smtp-Source: AMrXdXtqzIehdYr0AjI2PsoGgs88HrOBw3j5y5hFrY+WFovP3p1myHVs/8nvEQhDx729DhoowaBUCw==
X-Received: by 2002:a05:622a:2484:b0:3a8:2dba:751e with SMTP id cn4-20020a05622a248400b003a82dba751emr58546883qtb.26.1674157884228;
        Thu, 19 Jan 2023 11:51:24 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a424600b00705be892191sm20170828qko.56.2023.01.19.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:51:23 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-numa: Use a reasonable default max CPU value.
Date:   Thu, 19 Jan 2023 14:51:17 -0500
Message-Id: <20230119195117.61460-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

numa_num_task_cpus() returns here > 100 CPUs while the system has only
32 populated. The BIOS assumes that I can probably use larger CPUs (with
more cores) on the socket so the number of "configured CPUs" is rather
high.

It makes sense to use the current affinity instead of looking
at the number of possible CPUs which could be brought online.
It still depends on the affinity of the created threads
if the additional CPUs can be used. In a container setup
this may not be the case.

Use sched_getaffinity() to figure out the number of possible CPUs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
- Edited the commit message to remove reference to -S
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-numa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 3eead80c3b2b..1b09cff8d948 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -35,10 +35,19 @@ int numa_initialize(void)
 
 int get_available_cpus(struct bitmask *cpumask)
 {
+	cpu_set_t cpuset;
+	int ret;
+
 	if (cpumask)
 		return numa_bitmask_weight(cpumask);
 
-	return numa_num_task_cpus();
+	CPU_ZERO(&cpuset);
+
+	ret = sched_getaffinity(0, sizeof(cpu_set_t), &cpuset);
+	if (ret < 0)
+		fatal("sched_getaffinity failed: %m\n");
+
+	return CPU_COUNT(&cpuset);
 }
 
 int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
-- 
2.39.0

