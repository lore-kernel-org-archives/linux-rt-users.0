Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B9EC433DB
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AE3224B0
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 15:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbhAGPaI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbhAGPaH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jan 2021 10:30:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78074C0612F5;
        Thu,  7 Jan 2021 07:28:48 -0800 (PST)
Date:   Thu, 7 Jan 2021 16:28:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610033325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ibf4lbjnLQq73uPQIikk1cOLrXZlZFMOQpG5OMPbtCQ=;
        b=d/vq04muIoC7z/4L0G3Wy9fe60DwgKiiaxv/08Uab8lsZiU6APacbuthXtybD+gAtQO1hj
        dM4TtyjJGJ5z+Jec1TpGsdurvydiBFXCKpg+ojBtyQeRhRP7YiG5poLL4U2D3ynBA4k5De
        kCYWL6S+b2ZcCg7j1qn6HG27Qw3NopN43FQsafTOduoesbAvZedGwrvnnsL7BNcR7NYrbc
        ekfWHu+a+pbufoGOIO7olXk/la+rlgLvsBnCuhzbNOXLBhUQNUc8CXcGpD7k5q+2NhqOCk
        Vd9uCoYW+QAS3RWBdp5yAdIG86Bbbu2YLNVtNVK4aWoy391Q0Z20oQNtiDrqHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610033325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ibf4lbjnLQq73uPQIikk1cOLrXZlZFMOQpG5OMPbtCQ=;
        b=1j9L/p/eWYVrdgVFgV+UCsa9ruyNqiFRX3bDJ5y2SAiMQQZnsOqUj5FWwW5L2hEYUwHHbD
        lIcPebTxrDbAhZAA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Message-ID: <20210107152843.gyljmpctkwybfewh@linutronix.de>
References: <20210107091841.19798-1-ran.wang_1@nxp.com>
 <X/bmU4byS7k46zWM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/bmU4byS7k46zWM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-07 11:45:39 [+0100], Peter Zijlstra wrote:
> On Thu, Jan 07, 2021 at 05:18:41PM +0800, Ran Wang wrote:
> > +
> > +			if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > +			    !strncmp(p->comm, "ksoftirqd/", 10))
> > +				schedule_hrtimeout(&to,
> > +					HRTIMER_MODE_REL | HRTIMER_MODE_HARD);
> > +			else
> > +				schedule_hrtimeout(&to, HRTIMER_MODE_REL);
> 
> This is horrific, why did you not self-censor and spare me the mental
> anguish of having to formulate a CoC compliant response?
> 
> It also violates coding style, but given the total lack of any sense,
> that seems like a minor detail.
> 
> Why can't we use HRTIMER_MODE_HARD unconditionally?

I had a similar patch in -RT and dropped it in v5.10-rc7-rt16.
It was added because RT couldn't boot since creating the boot-threads
didn't work before the ksoftirqd was up. This was fixed by commit
   26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")

and live was good again.
tglx (also) suggested to add HRTIMER_MODE_HARD unconditionally (it
looked at SYSTEM_STATE back then) and I was only worried some abuse via
userland.
This sleep can be triggered by ptrace/strace() and with brief testing I
can trigger the sleep there but I don't get it anywhere near where I
would notice it with cyclictest.

Sebastian
