Return-Path: <SRS0=jf0u=5Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB81C2D0F1
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Mar 2020 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7587C212CC
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Mar 2020 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgCaQfQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbgCaQfP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Mar 2020 12:35:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E705520784;
        Tue, 31 Mar 2020 16:35:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jJJr7-002Vfg-QZ; Tue, 31 Mar 2020 12:35:13 -0400
Message-Id: <20200331163513.674653275@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 31 Mar 2020 12:34:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH RT 2/3] irq_work: Fix checking of IRQ_WORK_LAZY flag set on non PREEMPT_RT
References: <20200331163453.805082089@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.106-rt46-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When CONFIG_PREEMPT_RT_FULL is not set, some of the checks for using
lazy_list are not properly made as the IRQ_WORK_LAZY is not checked. There's
two locations that need this update, so a use_lazy_list() helper function is
added and used in both locations.

Link: https://lore.kernel.org/r/20200321230028.GA22058@duo.ucw.cz
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/irq_work.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2940622da5b3..b6d9d35941ac 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -70,6 +70,12 @@ static void __irq_work_queue_local(struct irq_work *work, struct llist_head *lis
 		arch_irq_work_raise();
 }
 
+static inline bool use_lazy_list(struct irq_work *work)
+{
+	return (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+		|| (work->flags & IRQ_WORK_LAZY);
+}
+
 /* Enqueue the irq work @work on the current CPU */
 bool irq_work_queue(struct irq_work *work)
 {
@@ -81,11 +87,10 @@ bool irq_work_queue(struct irq_work *work)
 
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+	if (use_lazy_list(work))
 		list = this_cpu_ptr(&lazy_list);
 	else
 		list = this_cpu_ptr(&raised_list);
-
 	__irq_work_queue_local(work, list);
 	preempt_enable();
 
@@ -106,7 +111,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 
 #else /* CONFIG_SMP: */
 	struct llist_head *list;
-	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
 
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(cpu));
@@ -116,10 +120,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		return false;
 
 	preempt_disable();
-
-	lazy_work = work->flags & IRQ_WORK_LAZY;
-
-	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+	if (use_lazy_list(work))
 		list = &per_cpu(lazy_list, cpu);
 	else
 		list = &per_cpu(raised_list, cpu);
-- 
2.25.1


