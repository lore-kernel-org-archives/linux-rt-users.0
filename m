Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A75CC433FE
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 18:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbhKXSGs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350271AbhKXSGj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5951561075;
        Wed, 24 Nov 2021 18:03:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcC-0027xA-FJ;
        Wed, 24 Nov 2021 13:03:28 -0500
Message-ID: <20211124180328.307061241@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH RT 12/13] irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT
References: <20211124180303.574562279@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.78-rt56-rc3 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On PREEMPT_RT most items are processed as LAZY via softirq context.
Avoid to spin-wait for them because irq_work_sync() could have higher
priority and not allow the irq-work to be completed.

Wait additionally for !IRQ_WORK_HARD_IRQ irq_work items on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211006111852.1514359-5-bigeasy@linutronix.de
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/irq_work.h | 5 +++++
 kernel/irq_work.c        | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index f551ba9c99d4..2c0059340871 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -55,6 +55,11 @@ static inline bool irq_work_is_busy(struct irq_work *work)
 	return atomic_read(&work->flags) & IRQ_WORK_BUSY;
 }
 
+static inline bool irq_work_is_hard(struct irq_work *work)
+{
+	return atomic_read(&work->flags) & IRQ_WORK_HARD_IRQ;
+}
+
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
 
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 03d09d779ee1..cbec10c32ead 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -211,7 +211,8 @@ void irq_work_single(void *arg)
 	flags &= ~IRQ_WORK_PENDING;
 	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
 
-	if (!arch_irq_work_has_interrupt())
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt())
 		rcuwait_wake_up(&work->irqwait);
 }
 
@@ -271,7 +272,8 @@ void irq_work_sync(struct irq_work *work)
 	lockdep_assert_irqs_enabled();
 	might_sleep();
 
-	if (!arch_irq_work_has_interrupt()) {
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt()) {
 		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
 				   TASK_UNINTERRUPTIBLE);
 		return;
-- 
2.33.0
