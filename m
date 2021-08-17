Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42021C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 15:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC2E60FD7
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 15:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhHQPgw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 11:36:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhHQPgu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Aug 2021 11:36:50 -0400
Date:   Tue, 17 Aug 2021 17:36:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629214575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbCgA2enmhNewVF4yvWuDdNewPyqFXG/EN/DoydyHAw=;
        b=ZIF+gIl7Dqcdkh2AlPk/szyV/ljbbc6P5Zc33T7O2L6wxyj6K6f854zQlzp0Lhf62aneeq
        vRSSzd0iwyRqCs0CRo2WY8JiTqhxp0mWtlqQ3G9WvAh6ePzkFK8NtkWq3eeGVNzLckdcPg
        z0/6ghGXlJq3b96KlS6XqAyV6RkITu6va/pithfpxk+trF65V0DqfByIjuKj6K1bd4AGZz
        WSXlUdRS7kV5Oq2+uyHJwVBQ7QTMXrI+syd9lRMMFHiFlN7vsMYeN3KrDzNaNlEV8DYbth
        ZvtwyEaeEbKCyQgIXMn37RzIdareNM40OxmnY0OtYR1jKq9FIcK7SrpYwkLgDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629214575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbCgA2enmhNewVF4yvWuDdNewPyqFXG/EN/DoydyHAw=;
        b=gen8UXdF1J1gIaJN2QWJWg0rbkFVNLTMc89v0qICwoAifOaOi0xqfF6KLlF51fIczw7pc+
        4Ch9KaHOJxAa7BBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [PATCH v3 3/4] rcu/nocb: Protect NOCB state via local_lock()
 under PREEMPT_RT
Message-ID: <20210817153613.l5f66czar6pajexo@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210811201354.1976839-4-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-11 21:13:53 [+0100], Valentin Schneider wrote:
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 0ff5e4fb933e..11c4ff00afde 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -21,6 +21,17 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
>  	return lockdep_is_held(&rdp->nocb_lock);
>  }
>  
> +static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
> +{
> +	return lockdep_is_held(
> +#ifdef CONFIG_PREEMPT_RT
> +		&rdp->nocb_local_lock.lock
> +#else
> +		&rdp->nocb_local_lock
> +#endif
> +	);
> +}

Now that I see it and Paul asked for it, please just use !RT version.
	return lockdep_is_held(&rdp->nocb_local_lock);

and RT will work, too.

>  static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>  {
>  	/* Race on early boot between thread creation and assignment */
> @@ -1629,6 +1664,22 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
>  	}
>  }
>  
> +/*
> + * The invocation of rcu_core() within the RCU core kthreads remains preemptible
> + * under PREEMPT_RT, thus the offload state of a CPU could change while
> + * said kthreads are preempted. Prevent this from happening by protecting the
> + * offload state with a local_lock().
> + */
> +static void rcu_nocb_local_lock(struct rcu_data *rdp)
> +{
> +	local_lock(&rcu_data.nocb_local_lock);
> +}
> +
> +static void rcu_nocb_local_unlock(struct rcu_data *rdp)
> +{
> +	local_unlock(&rcu_data.nocb_local_lock);
> +}
> +
Do you need to pass rdp given that it is not used?

>  /* Lockdep check that ->cblist may be safely accessed. */
>  static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
>  {

Sebastian
