Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BAC4742C
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B511223B0
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 12:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxJBlz3R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WrVe6SPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgKBMXe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:23:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgKBMXe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 07:23:34 -0500
Date:   Mon, 2 Nov 2020 13:23:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604319812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgwwUY5/F2HnTzAMH5El6bOrIItG+nZNqxWdOrbFQQ8=;
        b=cxJBlz3RIkKPicwe3sk1tnKoPRoLj2Z8gT2pTQwCbnmc+O7p79jYRfF7ZgEg6NZyxpWPjs
        NjWuN5ptYZzts+070TJz/Jp/cLSCNLC5/BMXMuvKUVKbmWew63t8KRnkgeXpQK43V5hWw8
        9N4R/TW8ci39T6Vo2sQwSgtJOPhZqezktAWCGnKFczOoRoX6QTBPCLwpTWXv7645YCDzAw
        KBMgkKwBjOM9Kx/zMw2JkYyETALtPcxo2yd6q9zevG7bSay0DBhWyZ5baY6YJfuEdoItUl
        yP8jluEPTtLuhq0bLBnwKl1H59r3iFunNCweWNU+pTHYmI1MM/VdkExPqd1tww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604319812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgwwUY5/F2HnTzAMH5El6bOrIItG+nZNqxWdOrbFQQ8=;
        b=WrVe6SPOSZ7eICRe9EyQuREEZldZxfWwngJC3WfarvCfTLaaA6k7ql7B40deeDsTstltCe
        CA8KDmGnVExpytCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 5.10-rt: non-repeatable
 flush_delayed_work()...del_timer_wait_running() ATOMIC_SLEEP splat
Message-ID: <20201102122325.pre6t4qo7bktrru2@linutronix.de>
References: <20201030191853.raabwjou753fk4sh@linutronix.de>
 <17f055aad6788c17dbeb522f2cac4f8bb94f759b.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17f055aad6788c17dbeb522f2cac4f8bb94f759b.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-01 06:23:50 [+0100], Mike Galbraith wrote:
> Apparently, timer ain't ever supposed to be running when you get there
> via flush_delayed_work(), but it was.

The first hunk will always trigger the warning and not just if the
slow/wait path is really used. The second part should fix it.

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7edc9fba34bbd..696bb88d15db2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1372,6 +1372,13 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Can not be used with disabled interrupts on PREEMPT_RT because
+	 * del_timer_wait_running() sleeps.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		WARN_ON(irqs_disabled());
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c71da2a59e127..1ca03051a949f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3187,10 +3187,11 @@ EXPORT_SYMBOL_GPL(cancel_work_sync);
  */
 bool flush_delayed_work(struct delayed_work *dwork)
 {
-	local_irq_disable();
-	if (del_timer_sync(&dwork->timer))
+	if (del_timer_sync(&dwork->timer)) {
+		local_irq_disable();
 		__queue_work(dwork->cpu, dwork->wq, &dwork->work);
-	local_irq_enable();
+		local_irq_enable();
+	}
 	return flush_work(&dwork->work);
 }
 EXPORT_SYMBOL(flush_delayed_work);

Sebastian
