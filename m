Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705C1C48BE8
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Jun 2021 22:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5321861287
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Jun 2021 22:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhFRWtS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:49:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59600 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhFRWtR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Jun 2021 18:49:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624056424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0dH3VEH9mRkPB+iMMG13Bg8QIpRSqyXaZ7vD6FSJ6Q8=;
        b=EvgI4ThMXq7mw55btOrbvC5XMqBy+62FBj6X7cCE+sM9qHF5Wd6m8w5uIMNyW7MJt7L482
        NLiPaCjdEqFPc5cwtS00du/Q5HP9A1dwKB67axQ8Ig6Rs03wsiI7Z1reoTK0+ZNl/KQUze
        JQFbkUvrS2DeMhw5h5m0wFdopfPKkmFPzsKSlYFzU6XL3m+ilRgeWxJLGmGAPaqVddCMGr
        Tacf56+DP/cGko2g5hLQDgKxCKN2Y3/+OaQS2XCvXcv4O8otqRtrdl5qinu/QY33qLdd5u
        8h/GV+3y4JsJKRjt+Y4bPi0sf/mUuPgZMPfm0wSkAtrqYB+gYTfLq0kod+Ghog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624056424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0dH3VEH9mRkPB+iMMG13Bg8QIpRSqyXaZ7vD6FSJ6Q8=;
        b=J1eYyM5FnvUOfduY5/xCpovdMVbnQQY/6U+oOtSydNL2Txvp6Alw8UltJsFNy9miAWtZlh
        0lZpGx+w9S7zvbAQ==
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 2/2] timers: Make sure irq_work is handled when no pending timers
In-Reply-To: <20210610125945.558872-2-nsaenzju@redhat.com>
References: <20210610125945.558872-1-nsaenzju@redhat.com> <20210610125945.558872-2-nsaenzju@redhat.com>
Date:   Sat, 19 Jun 2021 00:47:04 +0200
Message-ID: <87mtrmeqon.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Nicolas,

On Thu, Jun 10 2021 at 14:59, Nicolas Saenz Julienne wrote:
> PREEMPT_RT systems defer most irq_work handling into the timer softirq.
> This softirq is only triggered when a timer is expired, which adds some
> delay to the irq_work handling. It's a price PREEMPT_RT systems are
> willing to pay in exchange for less IRQ noise.
>
> This works fine for the majority of systems, but there's a catch. What
> if no timer is ever armed after an irq_work is queued. This has been
> observed on nohz_full CPUs while running oslat. The lack of armed timers
> prevents a pending irq_work to run. Which in turn prevents the nohz code
> from fully stopping the tick.
>
> To avoid this situation introduce new logic in run_local_timers(). The
> timer softirq will be triggered when an irq_work is pending but no
> timers have been armed. This situation is only possible in PREEMPT_RT
> systems, so make the code conditional to it.

now I can see the problem you are trying to solve, but unfortunately the
solution is fundamentally wrong.

> NOTE: All in all, this is the best I could think of with my limited
>       timers knowledge. A bigger hammer would be to unanimously trigger
>       the softirq if irq_work_needs_cpu(). But I get the feeling this is
>       something we want to avoid.

Technical decisions based on feelings are not solving anything and they
result in hard to analyse subtle issues:

Q: Assume there is a timer armed to expire 24h from now. What's the
   difference to no timer being armed?

A: None.

   Just because your use case has either no timers armed at all or has
   timers armed with short expiry is no reason to ignore the really
   simple and obvious technical facts.

But that aside, you analyzed the problem pretty good, but then you
stopped short of identifying the root cause and went off to cure the
symptom.

The irq_work deferring on RT to the timer softirq is the root cause of
the problem. It's a sloppy hack and I'm well aware of that. So this
needs to be fixed and not worked around by adding random undocumented
workarounds into the timer code.

Let's take a step back and analyze why this deferring to timer softirq
context exists on RT.

 1) The irq_work callbacks which are deferred on RT cannot be invoked from
    hard interrupt (IPI) context usually - due to spin_lock usage.

 2) Such irq_work has to be delegated to some suitable context and the
    trivial and lazy way out was to just stick into the timer softirq.

That hack survived for a long time and while I was aware of it, it was
not really high on my priority list of cleanups.

The real solution is to delegate this to a suitable context which is
executed independent of any other constraints.

There are two solutions:

  1) Create a IRQ_WORK softirq and raise that

  2) Simply delegate it to a workqueue

So now you might rightfully ask why I did not do that back then:

  #1 is not an option because we don't want to proliferate softirqs for
     various reasons.

  #2 was not feasible because back then queueing work from hard
     interrupt context was not possible.

So yes, I took the sloppy and easy way out and just glued it onto the
timer softirqs. Nobody complained so far.

As we since then made work queues RT aware and it's possible to queue
work from the irq_work IPI context, the obvious solution is to delegate
this to a work queue.

If we do a proper analysis of the affected irq work callbacks then this
probably makes a lot of sense independent of RT. There are only a few
really urgent irq work items which need to be handled immediately in the
IPI.

RT is special, but as we have demonstrated over time it's not _that_
special. It just needs a proper analysis and a real good argument why
something has to be special for RT and does not fit into the common
case. Or to demonstrate that the common case approach of 'do it right
away' is pointless or even harmfull.

Thanks,

        tglx
---
P.S.: I'm not blaming this on you as a newcomer. There are people on
      your team who should have known better.   

 


