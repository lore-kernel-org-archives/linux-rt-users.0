Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C5C4320A
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 07:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7504860F39
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 07:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbhHTHLy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 03:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbhHTHLt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Aug 2021 03:11:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B25C061575;
        Fri, 20 Aug 2021 00:11:11 -0700 (PDT)
Date:   Fri, 20 Aug 2021 09:11:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629443468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BhJm6h/KmQ36SxJO/2gjBAj+dUs+SDXHn2zO3h495m8=;
        b=K2TeM8EuBM8nBOJY3cK0mmmmngi+gUFpDslflP36mdX8vF6pgoqRG+miwU8gOMGdLaUNIb
        opDcaK7OjKRkcfOTYZUvPYUdwlHdD15sI5R6wjVNm+VX16jtbv+5eg/lwZOjMNb1+d3fvH
        eLD3i5EskK5qKYvPvVN7J4+vHVVQFSZEF5U5qTN8SC7edfqLiPTZq5ozo6r5msRDeSWhqI
        VHpB12g7EozTrZjbS6O58orAj2lIGLTQs+vElHJLgifE1RAwdI6J1sQf7arJW5HYKwANSP
        y6c6SdiQr9yqjQH3DvndDUc1vP6qqbhnhSnIcnJIrUxJ1UG5gKlqWte9f9CVAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629443468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BhJm6h/KmQ36SxJO/2gjBAj+dUs+SDXHn2zO3h495m8=;
        b=r213p/vK5C55sdc8OCgcBJE1Gu+stAuR47QxNcv6JNxCqBeemj3Z7vx80HSwMGTE4bwi1N
        gZ7Zf7SseYDAQKBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     paulmck@kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [PATCH] rcutorture: Avoid problematic critical section nesting
 on RT
Message-ID: <20210820071106.fba7l6ikgo7aa6xm@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
 <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
 <20210817144018.nqssoq475vitrqlv@linutronix.de>
 <20210818224651.GY4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210819153927.clqxr4f7qegpflbr@linutronix.de>
 <20210819154708.3efz6jtgwtuhpeds@linutronix.de>
 <20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1>
 <561ab28b18c31fbc221f4cb0c4df6db9b0538675.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <561ab28b18c31fbc221f4cb0c4df6db9b0538675.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-19 23:11:12 [-0500], Scott Wood wrote:
> On Thu, 2021-08-19 at 11:20 -0700, Paul E. McKenney wrote:
> > On Thu, Aug 19, 2021 at 05:47:08PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2021-08-19 17:39:29 [+0200], To Paul E. McKenney wrote:
> > > > +	/*
> > > > +	 * Ideally these sequences would be detected in debug builds
> > > > +	 * (regardless of RT), but until then don't stop testing
> > > > +	 * them on non-RT.
> > > > +	 */
> > > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > > +		/*
> > > > +		 * Can't release the outermost rcu lock in an irq disabled
> > > > +		 * section without preemption also being disabled, if irqs
> > > > +		 * had ever been enabled during this RCU critical section
> > > > +		 * (could leak a special flag and delay reporting the qs).
> > > > +		 */
> > > > +		if ((oldmask & RCUTORTURE_RDR_RCU) &&
> > > > +		    (mask & RCUTORTURE_RDR_IRQ) &&
> > > > +		    !(mask & preempts))
> > > > +			mask |= RCUTORTURE_RDR_RCU;
> > > 
> > > This piece above, I don't understand. I had it running for a while and
> > > it didn't explode. Let me try TREE01 for 30min without that piece.
> > 
> > This might be historical.  There was a time when interrupts being
> > disabled across rcu_read_unlock() meant that preemption had to have
> > been disabled across the entire RCU read-side critical section.
> > 
> > I am not seeing a purpose for it now, but I could easily be missing
> > something, especially given my tenuous grasp of RT.
> 
> Yeah, I think this was to deal with not having the irq work stuff in RT
> at the time.

Good. Thank you for the confirmation. 
I run (without the hunk above) 2x 6h of TREE01 and 4x 6h of TREE06 and
it looked good.

> -Scott

Sebastian
