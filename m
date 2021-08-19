Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B1CC4320A
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 18:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E606A610A1
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 18:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhHSSVM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhHSSVM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Aug 2021 14:21:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7642E60E76;
        Thu, 19 Aug 2021 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629397235;
        bh=g1ARTIB0d4RGCLz8sySq0S2vLKweYzbiWAo8YlbDzL0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rB5pOGqdeR+P9OGYeVxhbTqpiyc7Kk55Dkl+z/h5l2NNRHkFQNXLMj4hfuVhb2L3B
         096zDubtOxfqbi64Dc4nt37YGZIaqXsQrnqN5niCYX8Y8wJXmuLStAgTB1Kx4TbyD9
         dn2iB5TNSgOoE7bQBu977ru/KVg47kKU/n01rUvDElJ+fu3mwZK2xTH7CRkJiMyXiJ
         x5zpgyQ/kfW6SoxYpDkwkVmydDHzbF+Id22D1FcsB0rzgoP0ruvpdYjasaZ0HWlN8m
         OW2wzwE1Pqf6Pe1kadRycCChwhGKCJqPmgqNS4jtq0KSjH0OnLQX5VLDuRKQyYgQt0
         y6TydT/XaqXNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A9135C0692; Thu, 19 Aug 2021 11:20:35 -0700 (PDT)
Date:   Thu, 19 Aug 2021 11:20:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
 <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
 <20210817144018.nqssoq475vitrqlv@linutronix.de>
 <20210818224651.GY4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210819153927.clqxr4f7qegpflbr@linutronix.de>
 <20210819154708.3efz6jtgwtuhpeds@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819154708.3efz6jtgwtuhpeds@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 19, 2021 at 05:47:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-08-19 17:39:29 [+0200], To Paul E. McKenney wrote:
> > up with following which I can explain:
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 40ef5417d9545..5c8b31b7eff03 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -1432,28 +1432,34 @@ static void rcutorture_one_extend(int *readstate, int newstate,
> >  	/* First, put new protection in place to avoid critical-section gap. */
> >  	if (statesnew & RCUTORTURE_RDR_BH)
> >  		local_bh_disable();
> > +	if (statesnew & RCUTORTURE_RDR_RBH)
> > +		rcu_read_lock_bh();
> >  	if (statesnew & RCUTORTURE_RDR_IRQ)
> >  		local_irq_disable();
> >  	if (statesnew & RCUTORTURE_RDR_PREEMPT)
> >  		preempt_disable();
> > -	if (statesnew & RCUTORTURE_RDR_RBH)
> > -		rcu_read_lock_bh();
> >  	if (statesnew & RCUTORTURE_RDR_SCHED)
> >  		rcu_read_lock_sched();
> >  	if (statesnew & RCUTORTURE_RDR_RCU)
> >  		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
> 
> So the ordering in the enable and disable part regarding BH is
> important. First BH, then preemption or IRQ.
> 
> > -	/* Next, remove old protection, irq first due to bh conflict. */
> > +	/*
> > +	 * Next, remove old protection, in decreasing order of strength
> > +	 * to avoid unlock paths that aren't safe in the stronger
> > +	 * context. Namely: BH can not be enabled with disabled interrupts.
> > +	 * Additionally PREEMPT_RT requires that BH is enabled in preemptible
> > +	 * context.
> > +	 */
> >  	if (statesold & RCUTORTURE_RDR_IRQ)
> >  		local_irq_enable();
> > -	if (statesold & RCUTORTURE_RDR_BH)
> > -		local_bh_enable();
> >  	if (statesold & RCUTORTURE_RDR_PREEMPT)
> >  		preempt_enable();
> > -	if (statesold & RCUTORTURE_RDR_RBH)
> > -		rcu_read_unlock_bh();
> >  	if (statesold & RCUTORTURE_RDR_SCHED)
> >  		rcu_read_unlock_sched();
> > +	if (statesold & RCUTORTURE_RDR_BH)
> > +		local_bh_enable();
> > +	if (statesold & RCUTORTURE_RDR_RBH)
> > +		rcu_read_unlock_bh();
> >  	if (statesold & RCUTORTURE_RDR_RCU) {
> >  		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);
> 
> The same in the unlock part so that BH is unlocked in preemptible
> context.
> Now if you need bh lock/unlock in atomic context (either with disabled
> IRQs or preemption) then I would dig out the atomic-bh part again and
> make !RT only without the preempt_disable() section around about which
> one you did complain.
> 
> > @@ -1496,6 +1502,9 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
> >  	int mask = rcutorture_extend_mask_max();
> >  	unsigned long randmask1 = torture_random(trsp) >> 8;
> >  	unsigned long randmask2 = randmask1 >> 3;
> > +	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> > +	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
> > +	unsigned long bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
> >  
> >  	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
> >  	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
> > @@ -1503,11 +1512,37 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
> >  		mask = mask & randmask2;
> >  	else
> >  		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
> > -	/* Can't enable bh w/irq disabled. */
> > -	if ((mask & RCUTORTURE_RDR_IRQ) &&
> > -	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
> > -	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
> > -		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
> > +
> > +	/*
> > +	 * Can't enable bh w/irq disabled.
> > +	 */
> > +	if (mask & RCUTORTURE_RDR_IRQ)
> > +		mask |= oldmask & bhs;
> > +
> > +	/*
> > +	 * Ideally these sequences would be detected in debug builds
> > +	 * (regardless of RT), but until then don't stop testing
> > +	 * them on non-RT.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		/*
> > +		 * Can't release the outermost rcu lock in an irq disabled
> > +		 * section without preemption also being disabled, if irqs
> > +		 * had ever been enabled during this RCU critical section
> > +		 * (could leak a special flag and delay reporting the qs).
> > +		 */
> > +		if ((oldmask & RCUTORTURE_RDR_RCU) &&
> > +		    (mask & RCUTORTURE_RDR_IRQ) &&
> > +		    !(mask & preempts))
> > +			mask |= RCUTORTURE_RDR_RCU;
> 
> This piece above, I don't understand. I had it running for a while and
> it didn't explode. Let me try TREE01 for 30min without that piece.

This might be historical.  There was a time when interrupts being
disabled across rcu_read_unlock() meant that preemption had to have
been disabled across the entire RCU read-side critical section.

I am not seeing a purpose for it now, but I could easily be missing
something, especially given my tenuous grasp of RT.

Either way, looking forward to the next version!

							Thanx, Paul

> > +		/* Can't modify bh in atomic context */
> > +		if (oldmask & preempts_irq)
> > +			mask &= ~bhs;
> > +		if ((oldmask | mask) & preempts_irq)
> > +			mask |= oldmask & bhs;
> 
> And this is needed because we can't lock/unlock bh while atomic.
> 
> > +	}
> > +
> >  	return mask ?: RCUTORTURE_RDR_RCU;
> >  }
> >  
> 
> Sebastian
