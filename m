Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A119BC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 10:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C82C60FC3
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 10:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhHDKSa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:18:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237538AbhHDKS2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 06:18:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87DC913A1;
        Wed,  4 Aug 2021 03:18:15 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C6A3F66F;
        Wed,  4 Aug 2021 03:18:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] rcutorture: Nudge ksoftirqd priority for RCU boost testing
In-Reply-To: <20210803234231.GW4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210803225437.3612591-1-valentin.schneider@arm.com> <20210803225437.3612591-3-valentin.schneider@arm.com> <20210803234231.GW4397@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 04 Aug 2021 11:18:11 +0100
Message-ID: <87tuk5a4yk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 03/08/21 16:42, Paul E. McKenney wrote:
> On Tue, Aug 03, 2021 at 11:54:37PM +0100, Valentin Schneider wrote:
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index 680f66b65f14..3dd5fa75f469 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -948,12 +948,26 @@ static int rcu_torture_boost(void *arg)
>>      unsigned long endtime;
>>      unsigned long oldstarttime;
>>      struct rcu_boost_inflight rbi = { .inflight = 0 };
>> +	struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
>>
>>      VERBOSE_TOROUT_STRING("rcu_torture_boost started");
>>
>>      /* Set real-time priority. */
>>      sched_set_fifo_low(current);
>>
>> +	/*
>> +	 * Boost testing requires TIMER_SOFTIRQ to run at a higher priority
>> +	 * than the CPU-hogging torture kthreads, otherwise said threads
>> +	 * will never let timer expiry for the RCU GP kthread happen, which will
>> +	 * prevent any boosting.
>> +	 */
>> +	if (current->normal_prio < ksoftirqd->normal_prio) {
>
> Would it make sense to add IS_ENABLED(CONFIG_PREEMPT_RT) to the above
> condition?
>

Hm so v5.13-rt1 has this commit:

  5e59fba573e6 ("rcutorture: Fix testing of RCU priority boosting")

which gates RCU boost torture testing under CONFIG_PREEMPT_RT. Now, AFAICT
the TIMER_SOFTIRQ priority problem is there regardless of
CONFIG_PREEMPT_RT, so this patch would (should?) make sense even on
!CONFIG_PREEMPT_RT.

>                                                       Thanx, Paul
>
>> +		struct sched_param sp = { .sched_priority = 2 };
>> +
>> +		pr_alert("%s(): Adjusting %s priority\n", __func__, ksoftirqd->comm);
>> +		sched_setscheduler_nocheck(ksoftirqd, SCHED_FIFO, &sp);
>> +	}
>> +
>>      init_rcu_head_on_stack(&rbi.rcu);
>>      /* Each pass through the following loop does one boost-test cycle. */
>>      do {
>> --
>> 2.25.1
>>
