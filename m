Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB515C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Dec 2020 09:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5D5207CF
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Dec 2020 09:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgLWJYX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Dec 2020 04:24:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:6694 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgLWJYX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Dec 2020 04:24:23 -0500
IronPort-SDR: qvkVRbHh4gAhpP/rXe67yEqTH3voZyEX71BCYwc3iNvy4umwyNisIhoFTRoBrRVzvNI1v83cw2
 /Ncy8WZ2dOZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="172479086"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="172479086"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 01:23:43 -0800
IronPort-SDR: 5iwbK7d1df4bp8bchVG+o/nTH2CaixmSbG30vBBaITHrF3eIDTGG1Jish6xOBrLyyUvzWWplGG
 apcwgR5z85mw==
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="344979070"
Received: from rthomas-desk1.sc.intel.com ([10.3.52.142])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 01:23:42 -0800
From:   ramesh.thomas@intel.com
To:     linux-rt-users@vger.kernel.org
Cc:     Ramesh Thomas <ramesh.thomas@intel.com>, williams@redhat.com,
        frederic@kernel.org, bigeasy@linutronix.de
Subject: [PATCH 1/1] dynticks/preempt_rt: Fix a nohz_full entry failure in preempt_rt
Date:   Wed, 23 Dec 2020 04:20:36 -0500
Message-Id: <20201223092034.528782-2-ramesh.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201223092034.528782-1-ramesh.thomas@intel.com>
References: <20201223092034.528782-1-ramesh.thomas@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Ramesh Thomas <ramesh.thomas@intel.com>

After all conditions to enter nohz_full state are met, if a timer event
is detected in the next period, nohz_full entry is aborted in
tick_nohz_next_event(). In the failure condition, this scenario keeps
repeating. This has been reproduced in preempt_rt kernel, however it may
not be limited to it.

Not bailing out if CONFIG_NO_HZ_FULL is defined, fixes the issue. Since
in NO_HZ_FULL mode, idle state is not entered at tick stoppage, the
pending timer event can be handled where the next timer is programmed in
tick_nohz_stop_tick(). This also simplifies the logic by keeping a
common path to handle the entry/exit of nohz_full state, whether the
tick was already stopped or not.

(The entire check for the presence of a timer event in the next period
can possibly be skipped for NO_HZ_FULL)

Signed-off-by: Ramesh Thomas <ramesh.thomas@intel.com>
---
 kernel/time/tick-sched.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 308a98c28ee8..3798dbc5f082 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -739,10 +739,12 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
 		 */
+#ifndef CONFIG_NO_HZ_FULL
 		if (!ts->tick_stopped) {
 			ts->timer_expires = 0;
-			goto out;
+			return 0;
 		}
+#endif
 	}
 
 	/*
@@ -763,7 +765,6 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 
 	ts->timer_expires = min_t(u64, expires, next_tick);
 
-out:
 	return ts->timer_expires;
 }
 
-- 
2.26.2

