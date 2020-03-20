Return-Path: <SRS0=7Euv=5F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85260C4332E
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ADE20767
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgCTQ4O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:56:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCTQ4N (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Mar 2020 12:56:13 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jFKwN-0000D6-NA; Fri, 20 Mar 2020 17:56:11 +0100
Date:   Fri, 20 Mar 2020 17:56:11 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] mm/page_alloc: Use migreate_disable() in
 drain_local_pages_wq()
Message-ID: <20200320165611.clg7ynljztcd52fs@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The drain_local_pages_wq() uses preempt_disable() to ensure that there
will be no CPU migration while drain_local_pages() is invoked which
might happen if the CPU is going down.
drain_local_pages() acquires a sleeping lock on RT which can not be
acquired with disabled preemption.

Use migrate_disable() instead of preempt_disable(): On RT it ensures
that the CPU won't go down and on !RT it is replaced with
preempt_disable().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 99a51dfed59c7..7df9930628c2b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2912,9 +2912,9 @@ static void drain_local_pages_wq(struct work_struct *work)
 	 * cpu which is allright but we also have to make sure to not move to
 	 * a different one.
 	 */
-	preempt_disable();
+	migrate_disable();
 	drain_local_pages(drain->zone);
-	preempt_enable();
+	migrate_enable();
 }
 
 /*
-- 
2.26.0.rc2
