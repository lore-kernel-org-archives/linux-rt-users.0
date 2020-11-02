Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0352CC00A89
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5D6223AB
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1yCF3DF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4MNMYTXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgKBRHA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbgKBRG7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 12:06:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75069C0617A6
        for <linux-rt-users@vger.kernel.org>; Mon,  2 Nov 2020 09:06:59 -0800 (PST)
Date:   Mon, 2 Nov 2020 18:06:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604336817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=giXf6UMQ4gUfgwZnJn4UeBhBEhq41V9y3OmUr8vtbAg=;
        b=u1yCF3DFNWUQeTomXS0ikQZ7osxPqvS3D+ANRqFe3mmmN+BfGlwoNMIv7tjHkPKz8itwFD
        zT8z4nUYXY8wKtV8BkTvPxzcPKA/pgumtPbBFdit3cnENdCObhxe7HOLAvl88Q9XNIe+uJ
        ZxGNon4TvLTyy5WW3wPodyxut/gdtqrdTmYpgq338AK3vVwrkUOF1xm4gBBHJF6roDc10F
        yy81YPX+Fij7IMxmtQT7UPBM3TgcSEsyyyGMmfjnIwccw8B65bGdlHHBOhJsjfiUT38I+g
        jggPrP9iN7ncggkzvXLWlnatnfODd6/ODfJEZGMdKljyHBlqKx2otZZq0bepoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604336817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=giXf6UMQ4gUfgwZnJn4UeBhBEhq41V9y3OmUr8vtbAg=;
        b=4MNMYTXqn1TH9IEoIOndHvLOnh+vlvDDW6HUHvdTgofrA6WC3OL3Bdm0rzuWlynGzXE6KT
        6LmwUBvL06dSprDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 5.10-rt: non-repeatable
 flush_delayed_work()...del_timer_wait_running() ATOMIC_SLEEP splat
Message-ID: <20201102170656.iragxgpdsiti2qak@linutronix.de>
References: <20201030191853.raabwjou753fk4sh@linutronix.de>
 <17f055aad6788c17dbeb522f2cac4f8bb94f759b.camel@gmx.de>
 <20201102122325.pre6t4qo7bktrru2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102122325.pre6t4qo7bktrru2@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-02 13:23:32 [+0100], To Mike Galbraith wrote:
> On 2020-11-01 06:23:50 [+0100], Mike Galbraith wrote:
> > Apparently, timer ain't ever supposed to be running when you get there
> > via flush_delayed_work(), but it was.
> 
> The first hunk will always trigger the warning and not just if the
> slow/wait path is really used. The second part should fix it.

After writing a proper changelog I realized that it doesn't fly. So I
made dis:

------->8-----

Subject: [PATCH] timers: Don't block on ->expiry_lock for TIMER_IRQSAFE

PREEMPT_RT does not spin and wait until a running timer completes its
callback but instead it blocks on a sleeping lock to prevent a deadlock.

This blocking can not be done for workqueue's IRQ_SAFE timer which will
be canceled in an IRQ-off region. It has to happen to in IRQ-off region
because changing the PENDING bit and clearing the timer must not be
interrupted to avoid a busy-loop.

For the IRQ_SAFE timer it is guaranteed that the timer callback can not
be preempted on PREEMPT_RT so there is no need to synchronize on
timer_base::expiry_lock.

Add TIMER_IRQSAFE to flags on which the timer_base::expiry_lock must not
the acquired.
Add a lockdep annotation to ensure that this function is always invoked
in preemptible context on PREEMPT_RT.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7edc9fba34bbd..1e2403126ccfe 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1288,7 +1288,7 @@ static void del_timer_wait_running(struct timer_list *timer)
 	u32 tf;
 
 	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base = get_timer_base(tf);
 
 		/*
@@ -1372,6 +1372,13 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		lockdep_assert_preemption_enabled();
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
-- 
2.29.1


Sebastian
