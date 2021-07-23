Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F4C4320A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 10:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9CF60E73
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 10:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhGWJ1u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:27:50 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:34939 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhGWJ1t (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 05:27:49 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 12FCEFB308
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 11:00:55 +0100 (IST)
Received: (qmail 9118 invoked from network); 23 Jul 2021 10:00:54 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 23 Jul 2021 10:00:54 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] preempt: Provide preempt_*_(no)rt variants
Date:   Fri, 23 Jul 2021 11:00:33 +0100
Message-Id: <20210723100034.13353-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210723100034.13353-1-mgorman@techsingularity.net>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT needs a few preempt_disable/enable points which are not necessary
otherwise. Implement variants to avoid #ifdeffery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/preempt.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9881eac0698f..3434f4618178 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -184,7 +184,11 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#define preempt_enable_no_resched() sched_preempt_enable_no_resched()
+#ifdef CONFIG_PREEMPT_RT
+# define preempt_enable_no_resched() sched_preempt_enable_no_resched()
+#else
+# define preempt_enable_no_resched() preempt_enable()
+#endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
@@ -278,6 +282,18 @@ do { \
 		set_preempt_need_resched(); \
 } while (0)
 
+#ifdef CONFIG_PREEMPT_RT
+# define preempt_disable_rt()		preempt_disable()
+# define preempt_enable_rt()		preempt_enable()
+# define preempt_disable_nort()		barrier()
+# define preempt_enable_nort()		barrier()
+#else
+# define preempt_disable_rt()		barrier()
+# define preempt_enable_rt()		barrier()
+# define preempt_disable_nort()		preempt_disable()
+# define preempt_enable_nort()		preempt_enable()
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
 struct preempt_notifier;
-- 
2.26.2

