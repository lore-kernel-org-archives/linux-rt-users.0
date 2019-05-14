Return-Path: <SRS0=5OsI=TO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FA2C04AB4
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3E320862
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfENPgx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 May 2019 11:36:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENPgx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 May 2019 11:36:53 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hQZU0-0005TC-0d; Tue, 14 May 2019 17:36:48 +0200
Date:   Tue, 14 May 2019 17:36:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, minyard@acm.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190514153647.wri6ivffbq7r263y@linutronix.de>
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
 <20190514091219.nesriqe7qplk3476@linutronix.de>
 <20190514121350.GA6050@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514121350.GA6050@minyard.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-05-14 07:13:50 [-0500], Corey Minyard wrote:
> > Corey, would it make any change which waiter is going to be woken up?
> 
> In the application that found this, the wake order probably isn't
> relevant.

what I expected.

> For other applications, I really doubt that very many are using multiple
> waiters.  If so, this bug would have been reported sooner, I think.

most other do either one waiter/waker pair or one waker and multiple
waiter. And then reinit_completion() is used for the next round.

> As you mention, for RT you would want waiter woken by priority and FIFO
> within priority.  I don't think POSIX says anything about FIFO within
> priority, but that's probably a good idea.  That's no longer a simple
> wait queue  The way it is now is probably closer to that than what Peter
> suggested, but not really that close.
> 
> This is heavily used in drivers and fs code, where it probably doesn't
> matter.  I looked through a few users in mm and kernel, and they had
> one waiter or were init/shutdown type things where order is not important.
> 
> So I'm not sure it's important.

Why did you bring POSIX into this? This isn't an API exported to
userland which would fall into that category.

Peter's suggestion for FIFO is that we probably don't want to starve one
thread/waiter if it is always enqueued at the end of the list. As you
said, in your case it does not matter because (I assume) each waiter is
equal and the outcome would be the same.

> -corey

Sebastian
