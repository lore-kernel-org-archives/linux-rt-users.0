Return-Path: <SRS0=5OsI=TO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7AAC04AB6
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 09:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D50C20675
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfENJM0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 May 2019 05:12:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJM0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 May 2019 05:12:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hQTTv-00074b-Ee; Tue, 14 May 2019 11:12:19 +0200
Date:   Tue, 14 May 2019 11:12:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     minyard@acm.org, linux-rt-users@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190514091219.nesriqe7qplk3476@linutronix.de>
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-05-14 10:43:56 [+0200], Peter Zijlstra wrote:
> Now.. that will fix it, but I think it is also wrong.
> 
> The problem being that it violates FIFO, something that might be more
> important on -RT than elsewhere.

Wouldn't -RT be more about waking the task with the highest priority
instead the one that waited the longest?

> The regular wait API seems confused/inconsistent when it uses
> autoremove_wake_function and default_wake_function, which doesn't help,
> but we can easily support this with swait -- the problematic thing is
> the custom wake functions, we musn't do that.
> 
> (also, mingo went and renamed a whole bunch of wait_* crap and didn't do
> the same to swait_ so now its named all different :/)
> 
> Something like the below perhaps.

This still violates FIFO because a task can do wait_for_completion(),
not enqueue itself on the list because it noticed a pending wake and
leave. The list order is preserved, we have that.
But this a completion list. We have probably multiple worker waiting for
something to do so all of those should be of equal priority, maybe one
for each core or so. So it shouldn't matter which one we wake up.

Corey, would it make any change which waiter is going to be woken up?

Sebastian
