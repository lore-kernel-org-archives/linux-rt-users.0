Return-Path: <SRS0=wP7i=EN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87803C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 02:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47650221F7
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Nov 2020 02:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgKGCHb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Nov 2020 21:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgKGCHa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Nov 2020 21:07:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63A0217A0;
        Sat,  7 Nov 2020 02:07:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kbDdY-007lwv-I3; Fri, 06 Nov 2020 21:07:28 -0500
Message-ID: <20201107020728.408229413@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 06 Nov 2020 21:06:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Mike Galbraith <efault@gmx.de>, stable-rt@vger.kernel.org
Subject: [PATCH RT 5/6] timers: Dont block on ->expiry_lock for TIMER_IRQSAFE
References: <20201107020636.598338441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.74-rt42-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

PREEMPT_RT does not spin and wait until a running timer completes its
callback but instead it blocks on a sleeping lock to prevent a deadlock.

This blocking can not be done for workqueue's IRQ_SAFE timer which will
be canceled in an IRQ-off region. It has to happen to in IRQ-off region
because changing the PENDING bit and clearing the timer must not be
interrupted to avoid a busy-loop.

The callback invocation of IRQSAFE timer is not preempted on PREEMPT_RT
so there is no need to synchronize on timer_base::expiry_lock.

Don't acquire the timer_base::expiry_lock for TIMER_IRQSAFE flagged
timer.
Add a lockdep annotation to ensure that this function is always invoked
in preemptible context on PREEMPT_RT.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/time/timer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 89078fd848b9..3e9d7f227a5c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1289,7 +1289,7 @@ static void del_timer_wait_running(struct timer_list *timer)
 	u32 tf;
 
 	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base = get_timer_base(tf);
 
 		/*
@@ -1373,6 +1373,13 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		might_sleep();
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
-- 
2.28.0


