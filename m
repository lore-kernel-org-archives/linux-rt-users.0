Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903ADC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 22:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C80760F3A
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 22:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhHTWLg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhHTWLf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Aug 2021 18:11:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DFD660232;
        Fri, 20 Aug 2021 22:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629497457;
        bh=1smIaCVltxpgS+a3hHbmjML7XtWQjkKdSxjd/HTTFME=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FihF8xykt8FA4kSOXlkCUHdc131GGlTHM1xsBmmB7CJsGXhvtlAhmlgvqb8C/CtHe
         OLjBmh5DLrD88hLGR7gUMOu9vo/IPhaW3inCFWc8CWVNFpgfZqDo+yAHfjr0INqAJZ
         +PfGqE2bq8RgduyvY6eohoZvxf/n6gjDLfWz70It2fr1c4JGQhUosg33dwsUdUQSeX
         4aLkWKjoXmiDIbaaeXtT+sbzLc7qTP3NBhv9y7rImh+liSbkYOmQRyphBmrCUtQo7y
         e6ssNTfHbJt2bVyOzTT//mSf6FMeoM7kY/kBRx20XyyXFdz7hRseq/tlQaBUCbP4r6
         w9Rn/X81e76Rg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E39EB5C0399; Fri, 20 Aug 2021 15:10:56 -0700 (PDT)
Date:   Fri, 20 Aug 2021 15:10:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Scott Wood <swood@redhat.com>,
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
Subject: Re: [PATCH v2] rcutorture: Avoid problematic critical section
 nesting on PREEMPT_RT
Message-ID: <20210820221056.GL4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
 <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
 <20210817144018.nqssoq475vitrqlv@linutronix.de>
 <20210818224651.GY4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210819153927.clqxr4f7qegpflbr@linutronix.de>
 <20210819154708.3efz6jtgwtuhpeds@linutronix.de>
 <20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1>
 <561ab28b18c31fbc221f4cb0c4df6db9b0538675.camel@redhat.com>
 <20210820074236.2zli4nje7bof62rh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820074236.2zli4nje7bof62rh@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Aug 20, 2021 at 09:42:36AM +0200, Sebastian Andrzej Siewior wrote:
> From: "From: Scott Wood" <swood@redhat.com>
> 
> rcutorture is generating some nesting scenarios that are not compatible on PREEMPT_RT.
> For example:
> 	preempt_disable();
> 	rcu_read_lock_bh();
> 	preempt_enable();
> 	rcu_read_unlock_bh();
> 
> The problem here is that on PREEMPT_RT the bottom halves have to be
> disabled and enabled in preemptible context.
> 
> Reorder locking: start with BH locking and continue with then with
> disabling preemption or interrupts. In the unlocking do it reverse by
> first enabling interrupts and preemption and BH at the very end.
> Ensure that on PREEMPT_RT BH locking remains unchanged if in
> non-preemptible context.
> 
> Link: https://lkml.kernel.org/r/20190911165729.11178-6-swood@redhat.com
> Link: https://lkml.kernel.org/r/20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1
> Signed-off-by: Scott Wood <swood@redhat.com>
> [bigeasy: Drop ATOM_BH, make it only about changing BH in atomic
> context. Allow enabling RCU in IRQ-off section. Reword commit message.]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Looks plausible.  ;-)

I have queued this for testing and further review.  If all goes well,
perhaps the v5.16 merge window.

							Thanx, Paul

> ---
> v1…v2:
>   - Drop the ATOM_BH* bits. There don't seem to be needed, Paul did not
>     ant the preempt-disable around enabling/disabling BH as it might fix
>     things that RCU should take care.
> 
>   - Allow enabling RCU with disabled interrupts on RT. Scott confirmed
>     that it was needed but might no longer be needed. Paul said that it
>     might have been required at some point. It survived multiple 6h long
>     TREE01 and TREE06 testing.
> 
>  kernel/rcu/rcutorture.c | 48 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 40ef5417d9545..d2ef535530b10 100644
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
>  
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
>  
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
> @@ -1503,11 +1512,26 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
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
> +		/* Can't modify BH in atomic context */
> +		if (oldmask & preempts_irq)
> +			mask &= ~bhs;
> +		if ((oldmask | mask) & preempts_irq)
> +			mask |= oldmask & bhs;
> +	}
> +
>  	return mask ?: RCUTORTURE_RDR_RCU;
>  }
>  
> -- 
> 2.33.0
> 
