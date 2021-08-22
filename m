Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA339C4320A
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 18:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC846125F
	for <linux-rt-users@archiver.kernel.org>; Sun, 22 Aug 2021 18:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhHVSQV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 22 Aug 2021 14:16:21 -0400
Received: from foss.arm.com ([217.140.110.172]:45830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhHVSQT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 22 Aug 2021 14:16:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7C731042;
        Sun, 22 Aug 2021 11:15:37 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3FF3F5A1;
        Sun, 22 Aug 2021 11:15:34 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Subject: Re: [PATCH v3 3/4] rcu/nocb: Protect NOCB state via local_lock() under PREEMPT_RT
In-Reply-To: <20210817153613.l5f66czar6pajexo@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com> <20210811201354.1976839-4-valentin.schneider@arm.com> <20210817153613.l5f66czar6pajexo@linutronix.de>
Date:   Sun, 22 Aug 2021 19:15:32 +0100
Message-ID: <87bl5p73cr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 17/08/21 17:36, Sebastian Andrzej Siewior wrote:
>> +static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
>> +{
>> +	return lockdep_is_held(
>> +#ifdef CONFIG_PREEMPT_RT
>> +		&rdp->nocb_local_lock.lock
>> +#else
>> +		&rdp->nocb_local_lock
>> +#endif
>> +	);
>> +}
>
> Now that I see it and Paul asked for it, please just use !RT version.
>       return lockdep_is_held(&rdp->nocb_local_lock);
>
> and RT will work, too.
>

The above was required due to the (previous) definition of local_lock_t:

  typedef struct {
          spinlock_t		lock;
  } local_lock_t;

On -rt11 I see this is now:

  typedef spinlock_t local_lock_t;

which indeed means the iffdefery can (actually it *has* to) go.

>>  static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>>  {
>>      /* Race on early boot between thread creation and assignment */
>> @@ -1629,6 +1664,22 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
>>      }
>>  }
>>
>> +/*
>> + * The invocation of rcu_core() within the RCU core kthreads remains preemptible
>> + * under PREEMPT_RT, thus the offload state of a CPU could change while
>> + * said kthreads are preempted. Prevent this from happening by protecting the
>> + * offload state with a local_lock().
>> + */
>> +static void rcu_nocb_local_lock(struct rcu_data *rdp)
>> +{
>> +	local_lock(&rcu_data.nocb_local_lock);
>> +}
>> +
>> +static void rcu_nocb_local_unlock(struct rcu_data *rdp)
>> +{
>> +	local_unlock(&rcu_data.nocb_local_lock);
>> +}
>> +
> Do you need to pass rdp given that it is not used?
>

Not anymore, you're right.

>>  /* Lockdep check that ->cblist may be safely accessed. */
>>  static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
>>  {
>
> Sebastian
