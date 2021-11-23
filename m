Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6399AC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Nov 2021 15:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhKWPlG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhKWPlG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Nov 2021 10:41:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 491B360E95;
        Tue, 23 Nov 2021 15:37:57 +0000 (UTC)
Date:   Tue, 23 Nov 2021 10:37:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Clark Williams <williams@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH RT 09/10] drm/i915/gt: Queue and wait for the irq_work
 item.
Message-ID: <20211123103755.12d4b776@gandalf.local.home>
In-Reply-To: <20211123082500.hprw3gmjzrd3i4ib@linutronix.de>
References: <20211122203847.390551309@goodmis.org>
        <20211122203905.001687595@goodmis.org>
        <20211123082500.hprw3gmjzrd3i4ib@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 23 Nov 2021 09:25:00 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2021-11-22 15:38:56 [-0500], Steven Rostedt wrote:
> > 5.10.78-rt56-rc2 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> I don't mind releasing this as it is but could you please add the
> following irq-work patches:
> 
> * 09089db79859c irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT

Is there something else missing here, as this gives the following rejects in
irq_work.c:

--- kernel/irq_work.c
+++ kernel/irq_work.c
@@ -217,7 +217,8 @@ void irq_work_single(void *arg)
         */
        (void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 
-       if (!arch_irq_work_has_interrupt())
+       if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+           !arch_irq_work_has_interrupt())
                rcuwait_wake_up(&work->irqwait);
 }
 
@@ -277,7 +278,8 @@ void irq_work_sync(struct irq_work *work)
        lockdep_assert_irqs_enabled();
        might_sleep();
 
-       if (!arch_irq_work_has_interrupt()) {
+       if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+           !arch_irq_work_has_interrupt()) {
                rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
                                   TASK_UNINTERRUPTIBLE);
                return;

And there's no test here, and no irq_work_is_hard() in 5.10-rt.

This is why I didn't add them.

-- Steve



> * b4c6f86ec2f64 irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT
> * 810979682ccc9 irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.
> 
> in a follow-up release?
> 
> Sebastian

