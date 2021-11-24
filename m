Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D72CC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 18:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350581AbhKXSHE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350241AbhKXSGi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F083B61058;
        Wed, 24 Nov 2021 18:03:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcC-0027w2-3B;
        Wed, 24 Nov 2021 13:03:28 -0500
Message-ID: <20211124180327.927893621@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:13 -0500
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
Subject: [PATCH RT 10/13] irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ
 support.
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

irq_work() triggers instantly an interrupt if supported by the
architecture. Otherwise the work will be processed on the next timer
tick. In worst case irq_work_sync() could spin up to a jiffy.

irq_work_sync() is usually used in tear down context which is fully
preemptible. Based on review irq_work_sync() is invoked from preemptible
context and there is one waiter at a time. This qualifies it to use
rcuwait for synchronisation.

Let irq_work_sync() synchronize with rcuwait if the architecture
processes irqwork via the timer tick.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211006111852.1514359-3-bigeasy@linutronix.de
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/irq_work.h | 10 +++++++++-
 kernel/irq_work.c        | 10 ++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index f941f2d7d71c..3c6d3a96bca0 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -3,6 +3,7 @@
 #define _LINUX_IRQ_WORK_H
 
 #include <linux/smp_types.h>
+#include <linux/rcuwait.h>
 
 /*
  * An entry can be in one of four states:
@@ -22,6 +23,7 @@ struct irq_work {
 		};
 	};
 	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
 };
 
 static inline
@@ -29,13 +31,19 @@ void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 {
 	atomic_set(&work->flags, 0);
 	work->func = func;
+	rcuwait_init(&work->irqwait);
 }
 
 #define DEFINE_IRQ_WORK(name, _f) struct irq_work name = {	\
 		.flags = ATOMIC_INIT(0),			\
-		.func  = (_f)					\
+		.func  = (_f),					\
+		.irqwait = __RCUWAIT_INITIALIZER(irqwait),	\
 }
 
+static inline bool irq_work_is_busy(struct irq_work *work)
+{
+	return atomic_read(&work->flags) & IRQ_WORK_BUSY;
+}
 
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 8183d30e1bb1..8969aff790e2 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -165,6 +165,9 @@ void irq_work_single(void *arg)
 	 */
 	flags &= ~IRQ_WORK_PENDING;
 	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+
+	if (!arch_irq_work_has_interrupt())
+		rcuwait_wake_up(&work->irqwait);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -231,6 +234,13 @@ void irq_work_tick_soft(void)
 void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
+	might_sleep();
+
+	if (!arch_irq_work_has_interrupt()) {
+		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
+				   TASK_UNINTERRUPTIBLE);
+		return;
+	}
 
 	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
 		cpu_relax();
-- 
2.33.0
