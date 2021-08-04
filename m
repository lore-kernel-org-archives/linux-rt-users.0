Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4765BC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6860C41
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhHDQsQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhHDQsP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 12:48:15 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132FC60238;
        Wed,  4 Aug 2021 16:48:01 +0000 (UTC)
Date:   Wed, 4 Aug 2021 12:47:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804124755.21ca7e3d@oasis.local.home>
In-Reply-To: <20210804163119.t4c7bkpdk33byxtx@linutronix.de>
References: <20210804131731.GG8057@worktop.programming.kicks-ass.net>
        <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
        <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
        <20210804153308.oasahcxjmcw7vivo@linutronix.de>
        <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
        <20210804154743.niogqvnladdkfgi2@linutronix.de>
        <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
        <20210804121704.1587c41b@oasis.local.home>
        <20210804162231.rfj5i736lqc4nsio@linutronix.de>
        <20210804122541.741cf858@oasis.local.home>
        <20210804163119.t4c7bkpdk33byxtx@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 4 Aug 2021 18:31:19 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> CPU-local wake-ups just set NEED_RESCHED and wait for preempt_enable()
> to do the magic. Just because the code not perform wake_up() now does
> not mean it will not do so in the future. Also it is here as an example
> which might be copied somewhere else.

Does this mean all local_irq_disable/enable() is audited? What do you do for;

	local_irq_disable();
	[..]
	wakeup_process(x); /* on local CPU */
	[..]
	local_irq_enable();

And if local_irq_disable() is not used anymore, or seldom, what harm
would it be to add a preemption check to that caller? And change
local_irq_enable() that is used internally by other atom functions be
called __local_irq_enable()?

Not to mention that we could just open code that too:

	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
		local_irq_enable();
		preempt_check_resched();
	}

And make it ugly enough that nobody will want to copy it :-)

-- Steve
