Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A570DC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 19:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FEE6023D
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 19:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhG1TeY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:34:24 -0400
Received: from foss.arm.com ([217.140.110.172]:35262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhG1TeX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 15:34:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B3401FB;
        Wed, 28 Jul 2021 12:34:21 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA463F66F;
        Wed, 28 Jul 2021 12:34:18 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/3] rcu/nocb: Check for migratability rather than pure preemptability
In-Reply-To: <20210727230814.GC283787@lothringen>
References: <20210721115118.729943-1-valentin.schneider@arm.com> <20210721115118.729943-3-valentin.schneider@arm.com> <20210727230814.GC283787@lothringen>
Date:   Wed, 28 Jul 2021 20:34:14 +0100
Message-ID: <87pmv2kzbd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 28/07/21 01:08, Frederic Weisbecker wrote:
> On Wed, Jul 21, 2021 at 12:51:17PM +0100, Valentin Schneider wrote:
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  kernel/rcu/tree_plugin.h | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index ad0156b86937..6c3c4100da83 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -70,8 +70,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>>              !(lockdep_is_held(&rcu_state.barrier_mutex) ||
>>                (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>>                rcu_lockdep_is_held_nocb(rdp) ||
>> -		  (rdp == this_cpu_ptr(&rcu_data) &&
>> -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
>> +		  (rdp == this_cpu_ptr(&rcu_data) && is_pcpu_safe()) ||
>
> I fear that won't work. We really need any caller of rcu_rdp_is_offloaded()
> on the local rdp to have preemption disabled and not just migration disabled,
> because we must protect against concurrent offloaded state changes.
>
> The offloaded state is changed by a workqueue that executes on the target rdp.
>
> Here is a practical example where it matters:
>
>            CPU 0
>            -----
>            // =======> task rcuc running
>            rcu_core {
>              rcu_nocb_lock_irqsave(rdp, flags) {
>                    if (!rcu_segcblist_is_offloaded(rdp->cblist)) {
>                      // is not offloaded right now, so it's going
>                        // to just disable IRQs. Oh no wait:
>            // preemption
>            // ========> workqueue running
>            rcu_nocb_rdp_offload();
>            // ========> task rcuc resume
>                      local_irq_disable();
>                    }
>                }
>              ....
>                      rcu_nocb_unlock_irqrestore(rdp, flags) {
>                    if (rcu_segcblist_is_offloaded(rdp->cblist)) {
>                        // is offloaded right now so:
>                        raw_spin_unlock_irqrestore(rdp, flags);
>
> And that will explode because that's an impaired unlock on nocb_lock.

Harumph, that doesn't look good, thanks for pointing this out.

AFAICT PREEMPT_RT doesn't actually require to disable softirqs here (since
it forces RCU callbacks on the RCU kthreads), but disabled softirqs seem to
be a requirement for much of the underlying functions and even some of the
callbacks (delayed_put_task_struct() ~> vfree() pays close attention to
in_interrupt() for instance).

Now, if the offloaded state was (properly) protected by a local_lock, do
you reckon we could then keep preemption enabled?

From a naive outsider PoV, rdp->nocb_lock looks like a decent candidate,
but it's a *raw* spinlock (I can't tell right now whether changing this is
a horrible idea or not), and then there's

81c0b3d724f4 ("rcu/nocb: Avoid ->nocb_lock capture by corresponding CPU")

on top...
