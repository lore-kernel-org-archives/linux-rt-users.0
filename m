Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F166EC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 10:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D525060D07
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 10:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhG2Kvn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 06:51:43 -0400
Received: from foss.arm.com ([217.140.110.172]:44790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234000AbhG2Kvn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jul 2021 06:51:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1196E6D;
        Thu, 29 Jul 2021 03:51:40 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 476353F66F;
        Thu, 29 Jul 2021 03:51:37 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/3] rcu/nocb: Check for migratability rather than pure preemptability
In-Reply-To: <20210729010445.GO4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210721115118.729943-1-valentin.schneider@arm.com> <20210721115118.729943-3-valentin.schneider@arm.com> <20210727230814.GC283787@lothringen> <87pmv2kzbd.mognet@arm.com> <20210728220137.GD293265@lothringen> <20210729010445.GO4397@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 29 Jul 2021 11:51:32 +0100
Message-ID: <87mtq5l7ez.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 28/07/21 18:04, Paul E. McKenney wrote:
> On Thu, Jul 29, 2021 at 12:01:37AM +0200, Frederic Weisbecker wrote:
>> On Wed, Jul 28, 2021 at 08:34:14PM +0100, Valentin Schneider wrote:
>> > Now, if the offloaded state was (properly) protected by a local_lock, do
>> > you reckon we could then keep preemption enabled?
>>
>> I guess we could take such a local lock on the update side
>> (rcu_nocb_rdp_offload) and then take it on rcuc kthread/softirqs
>> and maybe other places.
>>
>> But we must make sure that rcu_core() is preempt-safe from a general perspective
>> in the first place. From a quick glance I can't find obvious issues...yet.
>>
>> Paul maybe you can see something?
>
> Let's see...
>
> o	Extra context switches in rcu_core() mean extra quiescent
>       states.  It therefore might be necessary to wrap rcu_core()
>       in an rcu_read_lock() / rcu_read_unlock() pair, because
>       otherwise an RCU grace period won't wait for rcu_core().
>
>       Actually, better have local_bh_disable() imply
>       rcu_read_lock() and local_bh_enable() imply rcu_read_unlock().
>       But I would hope that this already happened.

It does look like it.

>
> o	The rcu_preempt_deferred_qs() check should still be fine,
>       unless there is a raw_bh_disable() in -rt.
>
> o	The set_tsk_need_resched() and set_preempt_need_resched()
>       might preempt immediately.  I cannot think of a problem
>       with that, but careful testing is clearly in order.
>
> o	The values checked by rcu_check_quiescent_state() could now
>       change while this function is running.	I don't immediately
>       see a problematic sequence of events, but here be dragons.
>       I therefore suggest disabling preemption across this function.
>       Or if that is impossible, taking a very careful look at the
>       proposed expansion of the state space of this function.
>
> o	I don't see any new races in the grace-period/callback check.
>       New callbacks can appear in interrupt handlers, after all.
>
> o	The rcu_check_gp_start_stall() function looks similarly
>       unproblematic.
>
> o	Callback invocation can now be preempted, but then again it
>       recently started being concurrent, so this should be no
>       added risk over offloading/de-offloading.
>
> o	I don't see any problem with do_nocb_deferred_wakeup().
>
> o	The CONFIG_RCU_STRICT_GRACE_PERIOD check should not be
>       impacted.
>
> So some adjustments might be needed, but I don't see a need for
> major surgery.
>
> This of course might be a failure of imagination on my part, so it
> wouldn't hurt to double-check my observations.
>

I'll go poke around, thank you both!
