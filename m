Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C04C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348040AbhKXQPp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 11:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhKXQPm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 11:15:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA7C061574;
        Wed, 24 Nov 2021 08:12:32 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637770350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJ+BmT3IGNYTQ8lsYWOMjMjjhGwCb3LpVGfxgrX771c=;
        b=3sa5RMrtdeDy7EMMbu/6WSiQcVaq9CzXNr6z1hl0YNrqzEqD8B2TRDvuOwRVOeQL41nAXZ
        aWC6gt3R3kkg6uqQ2F5MbG5hyIA2aH3sEHfsN8QCQSSO4BdFoIbro4EXOSGELrv1t341ey
        atbfKJiLme97nYVi0FYdhg6nZWAfHW0STasDMKj5NBgMP6nS63MbOU6f0pnI0oi2IYlZfj
        KAm9yVLlLA/JsmtaJy7ejcKgJ/uHcc5BO5qP1oYZ9tCwWygDS3UjyDCQZ0tqsd4mdXLWFH
        gHs1UXDWlP6hKXG9AE08Cdk6eMoiOzDP3NUTi5SBertZ7VxZemAPKW444CPNcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637770350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJ+BmT3IGNYTQ8lsYWOMjMjjhGwCb3LpVGfxgrX771c=;
        b=0/Pm/ZfqktY4bODxA6qMOuDGWxpiNnsOmriMnoEXzCBYpNCo32Y84xxyBH4Smkyl4SaG1P
        ssgdxL4lhp6g8jAg==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Clark Williams <williams@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        bigeasy@linutronix.de
Subject: [PATCH RT 3/3] irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT
Date:   Wed, 24 Nov 2021 17:12:21 +0100
Message-Id: <20211124161221.2224005-4-bigeasy@linutronix.de>
In-Reply-To: <20211124161221.2224005-1-bigeasy@linutronix.de>
References: <20211123103755.12d4b776@gandalf.local.home>
 <20211124161221.2224005-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On PREEMPT_RT most items are processed as LAZY via softirq context.
Avoid to spin-wait for them because irq_work_sync() could have higher
priority and not allow the irq-work to be completed.

Wait additionally for !IRQ_WORK_HARD_IRQ irq_work items on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211006111852.1514359-5-bigeasy@linutronix=
.de
---
 include/linux/irq_work.h | 5 +++++
 kernel/irq_work.c        | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index f551ba9c99d40..2c0059340871d 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -55,6 +55,11 @@ static inline bool irq_work_is_busy(struct irq_work *wor=
k)
 	return atomic_read(&work->flags) & IRQ_WORK_BUSY;
 }
=20
+static inline bool irq_work_is_hard(struct irq_work *work)
+{
+	return atomic_read(&work->flags) & IRQ_WORK_HARD_IRQ;
+}
+
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
=20
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 03d09d779ee12..cbec10c32eade 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -211,7 +211,8 @@ void irq_work_single(void *arg)
 	flags &=3D ~IRQ_WORK_PENDING;
 	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
=20
-	if (!arch_irq_work_has_interrupt())
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt())
 		rcuwait_wake_up(&work->irqwait);
 }
=20
@@ -271,7 +272,8 @@ void irq_work_sync(struct irq_work *work)
 	lockdep_assert_irqs_enabled();
 	might_sleep();
=20
-	if (!arch_irq_work_has_interrupt()) {
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt()) {
 		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
 				   TASK_UNINTERRUPTIBLE);
 		return;
--=20
2.34.0

