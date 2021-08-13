Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C39C4320A
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Aug 2021 18:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19DF60F91
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Aug 2021 18:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhHMStq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:49:46 -0400
Received: from foss.arm.com ([217.140.110.172]:56640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233213AbhHMStR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Aug 2021 14:49:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB77D6E;
        Fri, 13 Aug 2021 11:48:49 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC95E3F40C;
        Fri, 13 Aug 2021 11:48:46 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
In-Reply-To: <20210813002045.GZ4126399@paulmck-ThinkPad-P17-Gen-1>
References: <20210811201354.1976839-1-valentin.schneider@arm.com> <20210811201354.1976839-4-valentin.schneider@arm.com> <20210813002045.GZ4126399@paulmck-ThinkPad-P17-Gen-1>
Date:   Fri, 13 Aug 2021 19:48:41 +0100
Message-ID: <87v9496v06.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 12/08/21 17:20, Paul E. McKenney wrote:
> On Wed, Aug 11, 2021 at 09:13:53PM +0100, Valentin Schneider wrote:
>> rcu_core() preemptability considerations
>> ========================================
>> 
>> As pointed out by Paul [2], keeping rcu_check_quiescent_state() preemptible
>> (which is the case under CONFIG_PREEMPT_RT) requires some consideration.
>> 
>> note_gp_changes() itself runs with irqs off, and enters
>> __note_gp_changes() with rnp->lock held (raw_spinlock), thus is safe vs
>> preemption.
>> 
>> rdp->core_needs_qs *could* change after being read by the RCU core
>> kthread if it then gets preempted. Consider, with
>> CONFIG_RCU_STRICT_GRACE_PERIOD:
>> 
>>   rcuc/x                                   task_foo
>> 
>>     rcu_check_quiescent_state()
>>     `\
>>       rdp->core_needs_qs == true
>> 			     <PREEMPT>
>> 					   rcu_read_unlock()
>> 					   `\
>> 					     rcu_preempt_deferred_qs_irqrestore()
>> 					     `\
>> 					       rcu_report_qs_rdp()
>> 					       `\
>> 						 rdp->core_needs_qs := false;
>> 
>> This would let rcuc/x's rcu_check_quiescent_state() proceed further down to
>> rcu_report_qs_rdp(), but if task_foo's earlier rcu_report_qs_rdp()
>> invocation would have cleared the rdp grpmask from the rnp mask, so
>> rcuc/x's invocation would simply bail.
>> 
>> Since rcu_report_qs_rdp() can be safely invoked, even if rdp->core_needs_qs
>> changed, it appears safe to keep rcu_check_quiescent_state() preemptible.
>
> Another concern...
>
> During the preemption of rcu_check_quiescent_state() someone might report
> a quiescent state on behalf of CPU x (perhaps due to its having recently
> been idle) and then the RCU grace-period kthread might start running on
> CPU x, where it might initialize a new grace period in rcu_gp_init().
> It can then invoke __note_gp_changes(), also on CPU x.
>

(this is me "writing out loud" to make sure I can follow)

I take it the preemption of rcuc/x itself would count as a quiescent state,
if the current grace period started before rcuc/x's rcu_read_lock()
(rcuc/x would end up in ->blkd_tasks but wouldn't affect ->gp_tasks).

Then if we get something to run rcu_report_qs_rnp() with a mask spanning
CPU x - I think the GP kthread doing quiescent state forcing might fit the
bill - we'll let the GP kthread initialize a new GP.

> If preempted as shown above just after checking >core_needs_qs, the
> ->cpu_no_qs.b.norm field will be set by the grace-period kthread, which
> will cause the rcu_check_quiescent_state() function's subsequent check
> of ->cpu_no_qs.b.norm to take an early exit.  So OK here.
>

Right

> On the other hand, if preempted just after the rcu_check_quiescent_state()
> function's check of ->cpu_no_qs.b.norm, the later invocation of
> rcu_report_qs_rdp() should take an early exit due to ->gp_seq mismatch.
> So OK here.
>

If, as described in your scenario above, the GP kthread has preempted
rcuc/x, initialized a new GP and has run __note_gp_changes() (on CPU x),
then wouldn't the rdp->gp_seq and rnp->gp_seq match when rcuc/x gets to run
again?

And because we would've then had a context switch between the GP kthread
and rcuc/x, we would've noted a quiescent state for CPU x, which would let
rcuc/x's rcu_report_qs_rdp() continue - or have I erred on the way there?

> However, this should be added to the commit log.  Might be a big commit
> log, but mass storage is cheap these days.  ;-)
>

No objections here!

> This needs a review of each and every manipulation of ->core_needs_qs
> and ->cpu_no_qs.b.norm.  For example, the preemptions will cause the
> scheduler to invoke RCU's context-switch hooks, which also mess with
> ->cpu_no_qs.b.norm.  I can get to that some time next week (or tomorrow,
> if things go better than expected), but it would be good for you (and
> others) to check as well.
>

I have some notes scribbled down regarding those that I need to go through
again, but that won't be before a week's time - I'll be away next week.

> Frederic should look this over, but I am taking a quick pass in the
> meantime.  Please see below.
>

Thanks!

>> @@ -210,6 +210,8 @@ struct rcu_data {
>>  	struct timer_list nocb_timer;	/* Enforce finite deferral. */
>>  	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
>>  
>> +	local_lock_t nocb_local_lock;
>
> Should this go near the beginning of the structure, given that code
> paths taking this lock tend to access ->cpu_no_qs, ->core_needs_qs,
> and so on?
>
> Given that it is used to protect core processing (not just offloaded
> callbacks), might ->core_local_lock be a better name?
>

It would still have to be in a #define CONFIG_RCU_NOCB_CPU region IMO, as
it only exists to protect access of the offloading state - hence the name,
but I'm not particularly attached to it.

> Please keep in mind that you can build kernels that offload callbacks
> but that still use softirq for RCU core processing.  And vice versa,
> that is, kernels that use rcuc kthreads but do not offload callbacks.
>

AFAICT the problem only stands if core processing becomes preemptible,
which is only the case under PREEMPT_RT (at least for now), and that implies
core processing done purely via kthreads.

>> +
>>  	/* The following fields are used by call_rcu, hence own cacheline. */
>>  	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
>>  	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
>> @@ -445,6 +447,8 @@ static void rcu_nocb_unlock(struct rcu_data *rdp);
>>  static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
>>  				       unsigned long flags);
>>  static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
>> +static void rcu_nocb_local_lock(struct rcu_data *rdp);
>> +static void rcu_nocb_local_unlock(struct rcu_data *rdp);
>>  #ifdef CONFIG_RCU_NOCB_CPU
>>  static void __init rcu_organize_nocb_kthreads(void);
>>  #define rcu_nocb_lock_irqsave(rdp, flags)				\
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 0ff5e4fb933e..11c4ff00afde 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -21,6 +21,17 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
>>  	return lockdep_is_held(&rdp->nocb_lock);
>>  }
>>  
>> +static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
>> +{
>> +	return lockdep_is_held(
>> +#ifdef CONFIG_PREEMPT_RT
>> +		&rdp->nocb_local_lock.lock
>> +#else
>> +		&rdp->nocb_local_lock
>> +#endif
>
> It would be good if this was abstracted.  Or is this the only place
> in the kernel that needs this #ifdef?  Maybe a lockdep_is_held_rt()
> or lockdep_is_held_local(), as the case may be?
>

It does look like the first/only place that tries to access a local_lock's
dep_map regardless of CONFIG_PREEMPT_RT. Looking at it some more, I'm not
sure if it's really useful: !PREEMPT_RT local_locks disable preemption, so
the preemption check in rcu_rdp_is_offloaded() will short circuit the
lockdep check when !PREEMPT_RT...

One thing I should perhaps point out - the local lock is only really needed
for PREEMPT_RT; for !PREEMPT_RT it will just disable preemption, and it's
only used in places that *already* disabled preemption (when !PREEMPT_RT).
I initially gated the lock under CONFIG_PREEMPT_RT, but changed that as I
found it reduced the ifdeffery.

>> +	);
>> +}
>> +
>>  static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>>  {
>>  	/* Race on early boot between thread creation and assignment */
>> @@ -38,7 +49,10 @@ static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
>>  {
>>  	return 0;
>>  }
>> -
>> +static inline int rcu_lockdep_is_held_nocb_local(struct rcu_data *rdp)
>> +{
>> +	return 0;
>
> This is backwards of normal lockdep practice, which defaults to locks
> always held.  And that will be what happens once lockdep has detected
> its first deadlock, correct?  At which point, this function and its
> earlier instance will be in conflict.
>
> Or is there some subtle reason why this conflict would be OK?
>

This follows the !CONFIG_RCU_NOCB definition of rcu_lockdep_is_held_nocb(),
which looked fine to me.

Actually with the way I wrote rcu_local_offload_access_safe(), we don't
even access that function when !CONFIG_RCU_NOCB...

>> +}
>>  static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>>  {
>>  	return false;
>> @@ -46,23 +60,44 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>>  
>>  #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
>>  
>> +/*
>> + * Is a local read of the rdp's offloaded state safe and stable?
>> + * See rcu_nocb_local_lock() & family.
>> + */
>> +static inline bool rcu_local_offload_access_safe(struct rcu_data *rdp)
>> +{
>> +	if (!preemptible())
>> +		return true;
>> +
>> +	if (!migratable()) {
>> +		if (!IS_ENABLED(CONFIG_RCU_NOCB))
>
> Do we also need to consult the use_softirq module parameter that controls
> whether or not there are rcuc kthreads?
>
> Actually, if !IS_ENABLED(CONFIG_RCU_NOCB) then rcu_rdp_is_offloaded()
> can simply return false without bothering with the RCU_LOCKDEP_WARN().
> Might be worth getting that out of the way of the RCU_LOCKDEP_WARN()
> condition.  ;-)
>

I _assumed_ the check was there even for !CONFIG_RCU_NOCB to provide a wider
test coverage of the calling conditions.

If that RCU_LOCKDEP_WARN() becomes conditionnal on CONFIG_RCU_NOCB then
yes, we could clean that up.

>> +			return true;
>> +
>> +		return rcu_lockdep_is_held_nocb_local(rdp);
>> +	}
>> +
>> +	return false;
>> +}
>> +
