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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D770BC433DB
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Feb 2021 09:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A65664E9B
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Feb 2021 09:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhBBJBL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhBBJBK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Feb 2021 04:01:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1710C061573;
        Tue,  2 Feb 2021 01:00:29 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y18so4679962edw.13;
        Tue, 02 Feb 2021 01:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APTYZdEMfCPIjJKgi20Wk5z1jzO4/VjOT2U7HmUAz9w=;
        b=DJyyZI+x/JH38NMDCHkwUCg2hEIRe/NMwGzdI0I+Rr9q4/xMU2dL10Y85NeAWeWrFG
         HQtP+JhtTVKfdQZ4dvC2UgKAQUGOvcvfygQvV0sEM4jpeZaKFNUIuWxoJhZlcJPurVy5
         QY5tlCiXko1C06t7HvSci0pX1kWS5Oyp+35N9nFvxgdIkxA09ARKBz99ZhnMA7WESub8
         yBAAsiNMbeHO93t1IKqpJg2TXLA9ZlwRQmba/9Xs9Tb3gcOgpax/0+Cw9a84RN0zqThI
         9tojyLT7J5ZsDxNHm3RKDkqIZFgwKDq0bvLr3ZEORJRT2M05D9cZE6qOZRv7xwJyGsoQ
         tkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APTYZdEMfCPIjJKgi20Wk5z1jzO4/VjOT2U7HmUAz9w=;
        b=dFyRSJNlwvcvfX+x87c6ZjuBKu0Pv49rFh0efDqErWH6DP22yt6lYrran6xKlTX3Ol
         sPF4jVn7cl60HNhF6c1q36rGVssQNatKfTuGIGi8NNcBFlHyyc3x3BD9Gy1i2x8EkuMn
         uILZ0SPFvcXF3rxGxw22POqbSiLFsD5hTCutZujCKhmSBWiyrRJZCC1jcEWoCRTaJQtt
         G/ft25hLBIOkPFkGoLBtSRFjH0mecc253mOcqj3JR1ps6v1QzXRG4Gd1pBBp4lToeHdm
         cQBQaFIF7YC2HWlIBrab27i3mS9RxZXBEn133rKE2lOg5FFocfVBMpaHK9K1KLWN1omN
         rgzQ==
X-Gm-Message-State: AOAM530GjZssTdl8Ob0c1QIcG8eukdbBqT1fLvNXbmH5761JcRiW9Yqw
        MjiCCF10eHja75kvRh7wayI=
X-Google-Smtp-Source: ABdhPJws/ph5GYtyOV5EjzhlRgcc1T15p6XRDzKtL/O3yFMt7HU9f6KDyZNIJncakH2VS/yvuZ/D1Q==
X-Received: by 2002:a05:6402:c16:: with SMTP id co22mr23706354edb.175.1612256428433;
        Tue, 02 Feb 2021 01:00:28 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-c05c-fc00-7bce-aab1-905d-1976.c22.pool.telefonica.de. [2a01:c22:c05c:fc00:7bce:aab1:905d:1976])
        by smtp.gmail.com with ESMTPSA id bo12sm9046871ejb.93.2021.02.02.01.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:00:27 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [RFC v2] sched/rt: Fix RT (group) throttling with nohz_full
Date:   Tue,  2 Feb 2021 10:00:10 +0100
Message-Id: <20210202090010.5350-1-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201093412.4900-1-schwenderjonathan@gmail.com>
References: <20210201093412.4900-1-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


RFC v2 changes: Fix compile error if CONFIG_SMP is not set, which was
Reported-by: kernel test robot <lkp@intel.com>
I'm now using smp_processor_id() to get the ID of the CPU the timer 
is running on.


If nohz_full is enabled (more precisely HK_FLAG_TIMER is set), then
do_sched_rt_period_timer may be called on a housekeeping CPU,
which would not service the isolated CPU for a non-root cgroup
(requires a kernel with RT_GROUP_SCHEDULING).
This causes RT tasks in a non-root cgroup to get throttled
indefinitely (unless throttling is disabled) once the timer has
been moved to a housekeeping CPU.
To fix this, housekeeping CPUs now service all online CPUs
if HK_FLAG_TIMER (nohz_full) is set.

I'm not really sure how this relates to  Mike Galbraith previous
commit e221d028bb08 ("sched,rt: fix isolated CPUs leaving root_task_group
indefinitely throttled"), (which is dated before the housekeeping changes,)
so I'm posting this as an RFC.

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
---
 kernel/sched/rt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8f720b71d13d..879abb5de023 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -866,9 +866,16 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	 * isolation is really required, the user will turn the throttle
 	 * off to kill the perturbations it causes anyway.  Meanwhile,
 	 * this maintains functionality for boot and/or troubleshooting.
+	 * If nohz_full is active and the timer was offloaded to a
+	 * housekeeping CPU, sched_rt_period_mask() will not contain
+	 * the isolated CPU. To prevent indefinite throttling of tasks
+	 * on isolated CPUs, housekeeping CPUs service all online CPUs.
 	 */
-	if (rt_b == &root_task_group.rt_bandwidth)
+	if (rt_b == &root_task_group.rt_bandwidth
+		|| (housekeeping_enabled(HK_FLAG_TIMER)
+			&& housekeeping_cpu(smp_processor_id(), HK_FLAG_TIMER))) {
 		span = cpu_online_mask;
+	}
 #endif
 	for_each_cpu(i, span) {
 		int enqueue = 0;
-- 
2.29.2

