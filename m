Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20933C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 15:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB686145A
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 15:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhEGPUP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 11:20:15 -0400
Received: from foss.arm.com ([217.140.110.172]:33882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhEGPUM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 11:20:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D3B611B3;
        Fri,  7 May 2021 08:19:11 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0E63F73B;
        Fri,  7 May 2021 08:19:09 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Scott Wood <swood@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/3] sched/fair: Call newidle_balance() from balance_callback on PREEMPT_RT
In-Reply-To: <CAKfTPtBrGF72Zf37vPS6r4wy_jKagznBbiqKWpPyMEB_u4wo1g@mail.gmail.com>
References: <20210428232821.2506201-1-swood@redhat.com> <20210428232821.2506201-2-swood@redhat.com> <CAKfTPtBrGF72Zf37vPS6r4wy_jKagznBbiqKWpPyMEB_u4wo1g@mail.gmail.com>
Date:   Fri, 07 May 2021 16:19:07 +0100
Message-ID: <87v97uinbo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 05/05/21 14:13, Vincent Guittot wrote:
> On Thu, 29 Apr 2021 at 01:28, Scott Wood <swood@redhat.com> wrote:
>>
>> This is required in order to be able to enable interrupts in the next
>> patch.  This is limited to PREEMPT_RT to avoid adding potentially
>> measurable overhead to the non-RT case (requiring a double switch when
>> pulling a task onto a newly idle cpu).
>
> IIUC, only the newidle_balance is a problem and not the idle load
> balance that runs softirq. In this case, why not skipping
> newidle_balance entirely in case of preempt_rt and kick an idle load
> balance instead as you switch to idle thread context anyway
>

So if I follow you, that would be along the lines of having PREEMPT_RT turn
newidle_balance() into:

        rq->idle_balance = CPU_IDLE;
        rq->next_balance = jiffies;
        trigger_load_balance(rq);

which I'm thinking isn't too crazy.
