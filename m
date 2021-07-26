Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E366DC432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA74600EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 13:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhGZNAZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:00:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233719AbhGZM7G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jul 2021 08:59:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE6B139F;
        Mon, 26 Jul 2021 06:39:34 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3CF33F70D;
        Mon, 26 Jul 2021 06:39:32 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, stable@kernel.org,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT 5/8] sched: Fix affine_move_task() self-concurrency
In-Reply-To: <20210725050349.GA983@bug>
References: <20210709215953.122804544@goodmis.org> <20210709220018.003428207@goodmis.org> <20210725050349.GA983@bug>
Date:   Mon, 26 Jul 2021 14:39:27 +0100
Message-ID: <87zgu9kxdc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 25/07/21 07:03, Pavel Machek wrote:
> Hi!
>
>> 5.10.47-rt46-rc1 stable review patch.
>> If anyone has any objections, please let me know.
>>
>> Add set_affinity_pending::stop_pending, to indicate if a stopper is in
>> progress.
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 9cbe12d8c5bd..20588a59300d 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1900,6 +1900,7 @@ struct migration_arg {
>>
>>  struct set_affinity_pending {
>>      refcount_t		refs;
>> +	unsigned int		stop_pending;
>>      struct completion	done;
>>      struct cpu_stop_work	stop_work;
>>      struct migration_arg	arg;
>
> For better readability, this should be bool, AFAICT.
>

It's intentionally declared as an int. sizeof(_Bool) is Implementation
Defined, so you can't sanely reason about struct layout.

There's been quite a few threads about this already, a quick search on lore
gave me:

https://lore.kernel.org/lkml/20180411081502.GJ4082@hirez.programming.kicks-ass.net/
