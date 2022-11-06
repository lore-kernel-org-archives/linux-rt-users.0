Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9522CC433FE
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Nov 2022 19:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKFTSL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Nov 2022 14:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKFTSK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Nov 2022 14:18:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56ABC28
        for <linux-rt-users@vger.kernel.org>; Sun,  6 Nov 2022 11:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667762186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNxevjtXBxfpIZr+Ng2g9wyfblOzs4+WLIdp8c813Qw=;
        b=cJn4h0RBTLaEFn83JIc/8BA/rNy5d8ybNSvqsp1ycDJsUBi2qacTmq/Ahrcdb0FjwjdwFL
        7IVg/oe8cE2/FkFxbzgwgJrMHJoE7qYPt3MxhH/W4yEzh2Jb7c017Z52dti1iAl6KDI3nX
        SW3cN4+kD+oNrh+rv44PrGEMh7CSQmY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-6nimhJQvPcyLoOHLUARwlQ-1; Sun, 06 Nov 2022 14:16:19 -0500
X-MC-Unique: 6nimhJQvPcyLoOHLUARwlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F98D29AB413;
        Sun,  6 Nov 2022 19:16:19 +0000 (UTC)
Received: from localhost (unknown [10.22.32.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E49AE1121314;
        Sun,  6 Nov 2022 19:16:18 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 3/4] timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers
Date:   Sun,  6 Nov 2022 16:16:11 -0300
Message-Id: <20221106191612.21730-4-lgoncalv@redhat.com>
In-Reply-To: <20221106191612.21730-1-lgoncalv@redhat.com>
References: <20221106191612.21730-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.298-rt141-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Upstream commit c725dafc95f1b37027840aaeaa8b7e4e9cd20516

PREEMPT_RT does not spin and wait until a running timer completes its
callback but instead it blocks on a sleeping lock to prevent a livelock in
the case that the task waiting for the callback completion preempted the
callback.

This cannot be done for timers flagged with TIMER_IRQSAFE. These timers can
be canceled from an interrupt disabled context even on RT kernels.

The expiry callback of such timers is invoked with interrupts disabled so
there is no need to use the expiry lock mechanism because obviously the
callback cannot be preempted even on RT kernels.

Do not use the timer_base::expiry_lock mechanism when waiting for a running
callback to complete if the timer is flagged with TIMER_IRQSAFE.

Also add a lockdep assertion for RT kernels to validate that the expiry
lock mechanism is always invoked in preemptible context.

[ bigeasy: Dropping that lockdep_assert_preemption_enabled() check in
           backport ]

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201103190937.hga67rqhvknki3tp@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/time/timer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index c112f5edfc5a..a3f229dc75ec 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1255,7 +1255,7 @@ static void del_timer_wait_running(struct timer_list *timer)
 	u32 tf;
 
 	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base = get_timer_base(tf);
 
 		/*
@@ -1339,6 +1339,15 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+#if 0
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		lockdep_assert_preemption_enabled();
+#endif
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
-- 
2.38.1

