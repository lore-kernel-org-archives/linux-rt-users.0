Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E6C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7134721874
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294074;
	bh=n/d8YBsjQqJ6w0oyoxIbnrSObuMo5tHZG4trAepJn3U=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=j+HRNoZjwx9ZnxIb+bIwciehMrWtYs+eu3+hEzMHbWKTXWoT9Am8kLQxabKP34UJh
	 SStXp9eeuob96Tn1VqjXHmJh9ib578mX4USvBvU1fx4dAhoOgUK1UnCbGuIIDSqUhL
	 82jbL0tcR1SlwDvaVA1Culbyyb0iwxkCUKeethTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404408AbfHHTxP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404353AbfHHTxO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:14 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F413218A2;
        Thu,  8 Aug 2019 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293993;
        bh=n/d8YBsjQqJ6w0oyoxIbnrSObuMo5tHZG4trAepJn3U=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=i2blnW+hwOBLPEHL4sOHkP6ZbXOH5XzaCQwV/NlsjBbIuOHPvxOwlL1MDoJfEu64N
         ycZpNnKnmFKDnq8Xv0HvYe2UhKp3bGthdiHhFhzKobtkRDX1r1U0KBbOHEenR4F9Tl
         RQMpiRyNpBx0pcE1ycY2lKs2TIXvI3KPspVDTdiE=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 04/19] genirq: Handle missing work_struct in irq_set_affinity_notifier()
Date:   Thu,  8 Aug 2019 14:52:32 -0500
Message-Id: <908d86a902fda96976e4eb568e9ce86aa8cee750.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit bbc4d2a7d6ff54ba923640d9a42c7bef7185fe98 ]

The backported stable commit
   59c39840f5abf ("genirq: Prevent use-after-free and work list corruption")

added cancel_work_sync() on a work_struct element which is not available
in RT.

Replace cancel_work_sync() with kthread_cancel_work_sync() on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/irq/manage.c
---
 kernel/irq/manage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3d5b33fe874b..071691963f7b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -352,7 +352,9 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	if (old_notify) {
-#ifndef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_BASE
+		kthread_cancel_work_sync(&notify->work);
+#else
 		cancel_work_sync(&old_notify->work);
 #endif
 		kref_put(&old_notify->kref, old_notify->release);
-- 
2.14.1

