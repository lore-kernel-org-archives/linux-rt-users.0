Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34215C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E30960F94
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbhHDQ6H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbhHDQ6G (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 12:58:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46D6C0613D5;
        Wed,  4 Aug 2021 09:57:53 -0700 (PDT)
Date:   Wed, 4 Aug 2021 18:57:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628096272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEU04sMLn2XAxbcar2dz/MSQvx8xXtoduoODOnXIeZw=;
        b=B71AnKWQUvI2QH3W1ya76U7laqh9/gKbT95g0MDX+NKnLpvVOv+FzNAbCDYYbHOFpWZMBW
        HgqJgaKJQJSJ/7Ldqe2XOS5x1MkJBmvIBzKx8O/wkbwu7GGe5WZuRw/e9vL6WkJyEIB3JF
        PvWy11CE3LP3UlHLFH82dRpofEHezkFkr00yL31Xla1YBMc0thatngUN9A4mysOWAjonKJ
        I3+0RK7jNTeKfs8C0YgqBBaLPqV//NsR5og4eTSh9HgFgzhZ4vHKYFbphRjnqGrsaIn74M
        8Zkbgf2UXv1L5FGuKXJsZMAJ+7RQjZaZH82s3OR097ng5lSyYNmgY7+I/Wwu8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628096272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEU04sMLn2XAxbcar2dz/MSQvx8xXtoduoODOnXIeZw=;
        b=Efcr+yMJaqvetBjdEzabDUQTx1/yASGSLz7EatnRZdFJ+fCtv3J4P6IKbL/I10QLYOBSpz
        TZmKe7+IY+QKlrBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804165751.ifppsn3eqjnvfgqs@linutronix.de>
References: <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804121704.1587c41b@oasis.local.home>
 <20210804162231.rfj5i736lqc4nsio@linutronix.de>
 <20210804122541.741cf858@oasis.local.home>
 <20210804163119.t4c7bkpdk33byxtx@linutronix.de>
 <20210804124755.21ca7e3d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804124755.21ca7e3d@oasis.local.home>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-04 12:47:55 [-0400], Steven Rostedt wrote:
> On Wed, 4 Aug 2021 18:31:19 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > CPU-local wake-ups just set NEED_RESCHED and wait for preempt_enable()
> > to do the magic. Just because the code not perform wake_up() now does
> > not mean it will not do so in the future. Also it is here as an example
> > which might be copied somewhere else.
> 
> Does this mean all local_irq_disable/enable() is audited? What do you do for;
> 
> 	local_irq_disable();
> 	[..]
> 	wakeup_process(x); /* on local CPU */
> 	[..]
> 	local_irq_enable();

I hunted and fixed a few of those. I still have few
preempt_check_resched_rt() which I want fix other than what is in RT.

> And if local_irq_disable() is not used anymore, or seldom, what harm
> would it be to add a preemption check to that caller? And change
> local_irq_enable() that is used internally by other atom functions be
> called __local_irq_enable()?
> 
> Not to mention that we could just open code that too:
> 
> 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> 		local_irq_enable();
> 		preempt_check_resched();
> 	}
> 
> And make it ugly enough that nobody will want to copy it :-)

I remember that the amount of enthusiasm was quite low when it was
suggested that local_irq_enable() gets additionally the preempt-check.
Maybe was due to the people involved :)
But we managed to work around it for most callers. Therefore we I
wouldn't suggest local_irq_disable_rt(). We had it in -RT, we had a
bunch of users and all of them were fixed in a different way.

Same goes btw. for preempt_disable_rt() which has been reduced to vmstat
and had previously more users :)

> -- Steve

Sebastian
