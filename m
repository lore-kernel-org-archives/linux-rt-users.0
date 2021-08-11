Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F1C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C7B60FE6
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 17:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhHKSAP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:00:15 -0400
Received: from foss.arm.com ([217.140.110.172]:55588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhHKSAO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Aug 2021 14:00:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D346106F;
        Wed, 11 Aug 2021 10:59:50 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FE7B3F40C;
        Wed, 11 Aug 2021 10:59:49 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] cpu_pm: Make notifier chain use a raw spinlock
In-Reply-To: <20210811135240.7zyywd47lpttuuj4@linutronix.de>
References: <20210811131405.1731576-1-valentin.schneider@arm.com> <20210811135240.7zyywd47lpttuuj4@linutronix.de>
Date:   Wed, 11 Aug 2021 18:59:43 +0100
Message-ID: <87bl63981c.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/08/21 15:52, Sebastian Andrzej Siewior wrote:
> On 2021-08-11 14:14:05 [+0100], Valentin Schneider wrote:
>> Booting a recent PREEMPT_RT kernel (v5.14-rc5-rt8 with the previous version
>> of this fix reverted) on my arm4 Juno leads to the idle task blocking on a
>> sleeping spinlock down some notifier path:
>> 
>> [    5.163034] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[...]
>> [    5.163294] __secondary_switched (arch/arm64/kernel/head.S:661)
>
> I would shrink that part above. The important part is that the CPU-idle
> code runs with disabled interrupts. Then cpu_pm_notify_robust() invokes
> the notifier which requires to acquire the spinlock_t. On PREEMPT_RT the
> spinlock_t becomes a sleeping spinlock and must not be acquired with
> disabled interrupts.

Noted, I'll pluck the warning out.

>> +/*
>> + * atomic_notifiers use a regular spinlock, but notifications for this chain
>> + * will be issued by the idle task which cannot block.
>
> Maybe + a few details and make it more explicit
>
>  * atomic_notifiers use a spinlock_t, but notifications for this chain
>  * will be issued by the idle task with disabled interrupts which cannot
>  * block on PREEMPT_RT.
>
> ?
>

More generally I'd say the idle task is never preemptible (as in
preempt_count > 0 at all times), so any notification issued by the idle
task itself cannot block. The fact those are also issued in an IRQ-off
region just further cements that.

> …
>> @@ -33,10 +45,13 @@ static int cpu_pm_notify(enum cpu_pm_event event)
>>  
>>  static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event event_down)
>>  {
>> +	unsigned long flags;
>>  	int ret;
>>  
>>  	rcu_irq_enter_irqson();
>> -	ret = atomic_notifier_call_chain_robust(&cpu_pm_notifier_chain, event_up, event_down, NULL);
>
> could we get rid of atomic_notifier_call_chain_robust() now that we have
> zero users?
>

No objections from my end, I'll add that in v3 and see if anyone complains.

>> +	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
>> +	ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
>> +	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
>>  	rcu_irq_exit_irqson();
>>  
>>  	return notifier_to_errno(ret);
>
> Sebastian
