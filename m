Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958F3C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0A660555
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhIVL3G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhIVL3F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 07:29:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3FC061574;
        Wed, 22 Sep 2021 04:27:35 -0700 (PDT)
Date:   Wed, 22 Sep 2021 13:27:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632310053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZv1FAoayMtDLfu2V7KCrqzRbBVSYCgTHmUKvw7n0TI=;
        b=RpD/ipNJU/V9C8NM3rFlIfTfc8M6xHrRUWi49VqPb3sh6C71LywYxpfd4c/7X9bo/j12F8
        zdfVJHeas6gDOPwHpvsH1kIk7Jg7lgUXm8xFFqjxVvX4CxkbyYryzABeG+SnTEMmaOJNaV
        K68O647TSPE3haj1p6pWz12nF1wdfDtzv1JG8d0dvs+Jna/oXnfsrhU2chW4v1f0D/Gd3z
        6sAlUkZhZH8klmLYYyTEIM9KdrA7rFTfVqxiYqkCmNiuCWhB2oJrx1EA9dLaRplVMYUi9g
        t0HqJK0dkFWEDEJB9w99dGm+SZfXaRF1yWMWAPLeKW1RK3H9RDy7wpFAVmwhQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632310053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZv1FAoayMtDLfu2V7KCrqzRbBVSYCgTHmUKvw7n0TI=;
        b=vgdtmoLl6YC6cvTD52PgjGrxZM3dH+++Cx9uLI+f6wmGz0BblrypMUyshFohdUyDgLH21H
        nTbLXEYftIkFqwDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: rcu/tree: Protect rcu_rdp_is_offloaded() invocations on RT
Message-ID: <20210922112731.dvauvxlhx5suc7qd@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
 <87pmt163al.ffs@tglx>
 <20210921234518.GB100318@lothringen>
 <20210922063208.ltf7sdou4tr5yrnc@linutronix.de>
 <20210922111012.GA106513@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922111012.GA106513@lothringen>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-22 13:10:12 [+0200], Frederic Weisbecker wrote:
> On Wed, Sep 22, 2021 at 08:32:08AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-09-22 01:45:18 [+0200], Frederic Weisbecker wrote:
> > > 
> > > Also while at it, I'm asking again: traditionally softirqs could assume that
> > > manipulating a local state was safe against !irq_count() code fiddling with
> > > the same state on the same CPU.
> > > 
> > > Now with preemptible softirqs, that assumption can be broken anytime. RCU was
> > > fortunate enough to have a warning for that. But who knows how many issues like
> > > this are lurking?
> > 
> > If "local state" is modified then it is safe as long as it is modified
> > within a local_bh_disable() section. And we are in this section while
> > invoking a forced-threaded interrupt. The special part about RCU is
> > that it is used in_irq() as part of core-code.
> 
> But local_bh_disable() was deemed for protecting from interrupting softirqs,
> not the other way around (softirqs being preempted by other tasks). The latter
> semantic is new and nobody had that in mind until softirqs have been made
> preemptible.
> 
> For example:
> 
>                              CPU 0
>           -----------------------------------------------
>           SOFTIRQ                            RANDOM TASK
>           ------                             -----------
>           int *X = &per_cpu(CPUX, 0)         int *X = &per_cpu(CPUX, 0)
>           int A, B;                          WRITE_ONCE(*X, 0);
>                                              WRITE_ONCE(*X, 1);
>           A = READ_ONCE(*X);
>           B = READ_ONCE(*X);
> 
> 
> We used to have the guarantee that A == B. That's not true anymore. Now
> some new explicit local_bh_disable() should be carefully placed on RANDOM_TASK
> where it wasn't necessary before. RCU is not that special in this regard.

The part with rcutree.use_softirq=0 on RT does not make it any better,
right?
So you rely on some implicit behaviour which breaks with RT such as:

                              CPU 0
           -----------------------------------------------
           RANDOM TASK-A                      RANDOM TASK-B
           ------                             -----------
           int *X = &per_cpu(CPUX, 0)         int *X = &per_cpu(CPUX, 0)
           int A, B;                          
					      spin_lock(&D);
           spin_lock(&C);
	   				      WRITE_ONCE(*X, 0);
           A = READ_ONCE(*X);
                                              WRITE_ONCE(*X, 1);
           B = READ_ONCE(*X);

while spinlock C and D are just random locks not related to CPUX but it
just happens that they are held at that time. So for !RT you guarantee
that A == B while it is not the case on RT.

Sebastian
