Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0509AC56202
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Nov 2020 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1562463F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Nov 2020 11:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgKQL30 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:29:26 -0500
Received: from foss.arm.com ([217.140.110.172]:54760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbgKQL3Z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Nov 2020 06:29:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E467FD6E;
        Tue, 17 Nov 2020 03:29:24 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEFF23F718;
        Tue, 17 Nov 2020 03:29:23 -0800 (PST)
References: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name> <jhj3619y63v.mognet@arm.com> <20201117110620.GG3121378@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: WARNING at kernel/sched/core.c:2013 migration_cpu_stop+0x2e3/0x330
In-reply-to: <20201117110620.GG3121378@hirez.programming.kicks-ass.net>
Date:   Tue, 17 Nov 2020 11:29:18 +0000
Message-ID: <jhjwnykw7ap.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 17/11/20 11:06, Peter Zijlstra wrote:
> On Mon, Nov 16, 2020 at 10:00:14AM +0000, Valentin Schneider wrote:
>> 
>> On 15/11/20 22:32, Oleksandr Natalenko wrote:
>> > Hi.
>> >
>> > I'm running v5.10-rc3-rt7 for some time, and I came across this splat in 
>> > dmesg:
>> >
>> > ```
>> > [118769.951010] ------------[ cut here ]------------
>> > [118769.951013] WARNING: CPU: 19 PID: 146 at kernel/sched/core.c:2013 
>> 
>> Err, I didn't pick up on this back then, but isn't that check bogus? If the
>> task is enqueued elsewhere, it's valid for it not to be affined
>> 'here'. Also that is_migration_disabled() check within is_cpu_allowed()
>> makes me think this isn't the best thing to call on a remote task.
>> 
>> ---
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 1218f3ce1713..47d5b677585f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2010,7 +2010,7 @@ static int migration_cpu_stop(void *data)
>>  		 * valid again. Nothing to do.
>>  		 */
>>  		if (!pending) {
>> -			WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
>> +			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr));
>
> Ho humm.. bit of a mess that. I'm trying to figure out if we need that
> is_per_cpu_kthread() test here or not.
>
> I suppose not, what we want here is to ensure the CPU is in cpus_mask
> and not care about the whole hotplug mess.
>

That was my thought as well. On top of that, is_cpu_allowed(p) does a
p->migration_disabled read, which isn't so great in the remote case.

> Would it makes sense to replace both instances in migration_cpu_stop()
> with:
>
> 	WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), p->cpus_mask));
>
> ?

I guess so; I was trying to see if we could factorize this, but stopped
mid-swing as I'm really wary of shuffling too much of this code (even with
the help of TLA+; well, maybe *because* of it).
