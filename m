Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E706C636C8
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 02:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43952610CB
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 02:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhGSCgL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 18 Jul 2021 22:36:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:26468 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhGSCgK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 18 Jul 2021 22:36:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="198242718"
X-IronPort-AV: E=Sophos;i="5.84,250,1620716400"; 
   d="scan'208";a="198242718"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 19:33:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,250,1620716400"; 
   d="scan'208";a="499564030"
Received: from sysdebug.bj.intel.com ([10.240.193.56])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 19:33:08 -0700
From:   chao.qin@intel.com
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de,
        john.ogness@linutronix.de, rostedt@goodmis.org
Cc:     mgross@linux.intel.com, paul.mei@intel.com, lili.li@intel.com
Subject: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msleep in pr_flush()
Date:   Mon, 19 Jul 2021 10:26:50 +0800
Message-Id: <20210719022649.3444072-1-chao.qin@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Chao Qin <chao.qin@intel.com>

There is msleep in pr_flush(). If call WARN() in the early boot
stage such as in early_initcall, pr_flush() will run into msleep
when process scheduler is not ready yet. And then the system will
sleep forever.

Before the system_state is SYSTEM_RUNNING, make sure DO NOT sleep
in pr_flush().

Fixes: 63cf1e4b564a ("printk: add pr_flush()")

Signed-off-by: Chao Qin <chao.qin@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
---
 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 209d2392f0d8..a9b3afbdac39 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3620,7 +3620,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 	u64 diff;
 	u64 seq;
 
-	may_sleep = (preemptible() && !in_softirq());
+	may_sleep = (preemptible() && !in_softirq()
+			&& (system_state >= SYSTEM_RUNNING));
 
 	seq = prb_next_seq(prb);
 

base-commit: 7e175e6b59975c8901ad370f7818937f68de45c1
-- 
2.25.1

