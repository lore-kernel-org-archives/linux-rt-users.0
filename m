Return-Path: <SRS0=5OsI=TO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE32C04AB4
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 15:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C3320644
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 15:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfENPZa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 May 2019 11:25:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfENPZa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 May 2019 11:25:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hQZIv-0005IH-9z; Tue, 14 May 2019 17:25:21 +0200
Date:   Tue, 14 May 2019 17:25:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     minyard@acm.org, linux-rt-users@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190514152521.2gz6w2bahhgkxav7@linutronix.de>
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
 <20190514091219.nesriqe7qplk3476@linutronix.de>
 <20190514113538.GL2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514113538.GL2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-05-14 13:35:38 [+0200], Peter Zijlstra wrote:
> On Tue, May 14, 2019 at 11:12:19AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-05-14 10:43:56 [+0200], Peter Zijlstra wrote:
> > > Now.. that will fix it, but I think it is also wrong.
> > > 
> > > The problem being that it violates FIFO, something that might be more
> > > important on -RT than elsewhere.
> > 
> > Wouldn't -RT be more about waking the task with the highest priority
> > instead the one that waited the longest?
> 
> Possibly, but that's a far larger patch. Also, even with that
> completions do not avoid inversions and thus don't really make nice RT
> primitives anyway.

See. So it does not really matter if a particular waiter ends up at the
end of the queue.
Anyway, I don't really think we need this but if you want it, let me add
it.
What about the other question I had regarding completion_done()?

Sebastian
