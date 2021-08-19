Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8307DC4320A
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624D7601FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 15:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhHSPrs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbhHSPrs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Aug 2021 11:47:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA04C061575;
        Thu, 19 Aug 2021 08:47:11 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:47:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629388030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=knvNMgwNE+JoC00b3FdTwvHM/vMj7bZxqT5/2z2qfU0=;
        b=d1x+TFfAk9PbRnNt9Xo6P4pUUZBVP3KykyqJBuxcic3WJQM5OTaIeqSA83cRDP2VuPlbN0
        Ke1wl7nTloX6oaBXVIpA7OU8b6J7yA/8EjnKQ2KgH+RkU8OetrC0mtbYQ4GCCLYIO6SEtM
        NBL4x/DsWrPlWQcXpPd011IDMzyPUpeV0u5riOtwkLZFBOx9GPaXkH8HFpAYB8CZbZTmNH
        WB0dmiMNIRyJ+555P/Shh0BfD9POO7bItfLwzM06OyVNkCnt3smgr+eT38m+q5QkX0wf1S
        NIybzRjHnNjY2GtJsjpJiDaGU6TaHLk6tzadp6grqDu+P9SxSTDizK3OFL9C5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629388030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=knvNMgwNE+JoC00b3FdTwvHM/vMj7bZxqT5/2z2qfU0=;
        b=rOWUlTZV5PR81FmbofElPlZVdccF+u6kUn4+tce4qslwkHSglLHbG4deW331VGIeuDXqj2
        SGScwMeLFHavrkBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
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
        Mike Galbraith <efault@gmx.de>, Scott Wood <swood@redhat.com>
Subject: Re: [PATCH] rcutorture: Avoid problematic critical section nesting
 on RT
Message-ID: <20210819154708.3efz6jtgwtuhpeds@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
 <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
 <20210817144018.nqssoq475vitrqlv@linutronix.de>
 <20210818224651.GY4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210819153927.clqxr4f7qegpflbr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819153927.clqxr4f7qegpflbr@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-19 17:39:29 [+0200], To Paul E. McKenney wrote:
> up with following which I can explain:
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 40ef5417d9545..5c8b31b7eff03 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1432,28 +1432,34 @@ static void rcutorture_one_extend(int *readstate, int newstate,
>  	/* First, put new protection in place to avoid critical-section gap. */
>  	if (statesnew & RCUTORTURE_RDR_BH)
>  		local_bh_disable();
> +	if (statesnew & RCUTORTURE_RDR_RBH)
> +		rcu_read_lock_bh();
>  	if (statesnew & RCUTORTURE_RDR_IRQ)
>  		local_irq_disable();
>  	if (statesnew & RCUTORTURE_RDR_PREEMPT)
>  		preempt_disable();
> -	if (statesnew & RCUTORTURE_RDR_RBH)
> -		rcu_read_lock_bh();
>  	if (statesnew & RCUTORTURE_RDR_SCHED)
>  		rcu_read_lock_sched();
>  	if (statesnew & RCUTORTURE_RDR_RCU)
>  		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;

So the ordering in the enable and disable part regarding BH is
important. First BH, then preemption or IRQ.

> -	/* Next, remove old protection, irq first due to bh conflict. */
> +	/*
> +	 * Next, remove old protection, in decreasing order of strength
> +	 * to avoid unlock paths that aren't safe in the stronger
> +	 * context. Namely: BH can not be enabled with disabled interrupts.
> +	 * Additionally PREEMPT_RT requires that BH is enabled in preemptible
> +	 * context.
> +	 */
>  	if (statesold & RCUTORTURE_RDR_IRQ)
>  		local_irq_enable();
> -	if (statesold & RCUTORTURE_RDR_BH)
> -		local_bh_enable();
>  	if (statesold & RCUTORTURE_RDR_PREEMPT)
>  		preempt_enable();
> -	if (statesold & RCUTORTURE_RDR_RBH)
> -		rcu_read_unlock_bh();
>  	if (statesold & RCUTORTURE_RDR_SCHED)
>  		rcu_read_unlock_sched();
> +	if (statesold & RCUTORTURE_RDR_BH)
> +		local_bh_enable();
> +	if (statesold & RCUTORTURE_RDR_RBH)
> +		rcu_read_unlock_bh();
>  	if (statesold & RCUTORTURE_RDR_RCU) {
>  		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);

The same in the unlock part so that BH is unlocked in preemptible
context.
Now if you need bh lock/unlock in atomic context (either with disabled
IRQs or preemption) then I would dig out the atomic-bh part again and
make !RT only without the preempt_disable() section around about which
one you did complain.

> @@ -1496,6 +1502,9 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
>  	int mask = rcutorture_extend_mask_max();
>  	unsigned long randmask1 = torture_random(trsp) >> 8;
>  	unsigned long randmask2 = randmask1 >> 3;
> +	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> +	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
> +	unsigned long bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
>  
>  	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
>  	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
> @@ -1503,11 +1512,37 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
>  		mask = mask & randmask2;
>  	else
>  		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
> -	/* Can't enable bh w/irq disabled. */
> -	if ((mask & RCUTORTURE_RDR_IRQ) &&
> -	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
> -	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
> -		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
> +
> +	/*
> +	 * Can't enable bh w/irq disabled.
> +	 */
> +	if (mask & RCUTORTURE_RDR_IRQ)
> +		mask |= oldmask & bhs;
> +
> +	/*
> +	 * Ideally these sequences would be detected in debug builds
> +	 * (regardless of RT), but until then don't stop testing
> +	 * them on non-RT.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		/*
> +		 * Can't release the outermost rcu lock in an irq disabled
> +		 * section without preemption also being disabled, if irqs
> +		 * had ever been enabled during this RCU critical section
> +		 * (could leak a special flag and delay reporting the qs).
> +		 */
> +		if ((oldmask & RCUTORTURE_RDR_RCU) &&
> +		    (mask & RCUTORTURE_RDR_IRQ) &&
> +		    !(mask & preempts))
> +			mask |= RCUTORTURE_RDR_RCU;

This piece above, I don't understand. I had it running for a while and
it didn't explode. Let me try TREE01 for 30min without that piece.

> +		/* Can't modify bh in atomic context */
> +		if (oldmask & preempts_irq)
> +			mask &= ~bhs;
> +		if ((oldmask | mask) & preempts_irq)
> +			mask |= oldmask & bhs;

And this is needed because we can't lock/unlock bh while atomic.

> +	}
> +
>  	return mask ?: RCUTORTURE_RDR_RCU;
>  }
>  

Sebastian
