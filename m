Return-Path: <SRS0=B5od=6O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4858C8300A
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 10:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50C32082E
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 10:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgD3KOM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:14:12 -0400
Received: from foss.arm.com ([217.140.110.172]:51880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgD3KOL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Apr 2020 06:14:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B9A61063;
        Thu, 30 Apr 2020 03:14:11 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188DE3F68F;
        Thu, 30 Apr 2020 03:14:09 -0700 (PDT)
References: <20200428050242.17717-1-swood@redhat.com> <jhjzhatdgxh.mognet@arm.com> <CAKfTPtDktpTB7d6qhmcX0HtryezzFygk4kOC22Qf=OM77QpLYg@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Scott Wood <swood@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] newidle_balance() latency mitigation
In-reply-to: <CAKfTPtDktpTB7d6qhmcX0HtryezzFygk4kOC22Qf=OM77QpLYg@mail.gmail.com>
Date:   Thu, 30 Apr 2020 11:14:05 +0100
Message-ID: <jhjy2qdcmc2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 30/04/20 08:44, Vincent Guittot wrote:
> On Thu, 30 Apr 2020 at 01:13, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>>
>> On 28/04/20 06:02, Scott Wood wrote:
>> > These patches mitigate latency caused by newidle_balance() on large
>> > systems, by enabling interrupts when the lock is dropped, and exiting
>> > early at various points if an RT task is runnable on the current CPU.
>> >
>> > When applied to an RT kernel on a 72-core machine (2 threads per core), I
>> > saw significant reductions in latency as reported by rteval -- from
>> > over 500us to around 160us with hyperthreading disabled, and from
>> > over 1400us to around 380us with hyperthreading enabled.
>> >
>> > This isn't the first time something like this has been tried:
>> > https://lore.kernel.org/lkml/20121222003019.433916240@goodmis.org/
>> > That attempt ended up being reverted:
>> > https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/
>> >
>> > The problem in that case was the failure to keep BH disabled, and the
>> > difficulty of fixing that when called from the post_schedule() hook.
>> > This patchset uses finish_task_switch() to call newidle_balance(), which
>> > enters in non-atomic context so we have full control over what we disable
>> > and when.
>> >
>> > There was a note at the end about wanting further discussion on the matter --
>> > does anyone remember if that ever happened and what the conclusion was?
>> > Are there any other issues with enabling interrupts here and/or moving
>> > the newidle_balance() call?
>> >
>>
>> Random thought that just occurred to me; in the grand scheme of things,
>> with something in the same spirit as task-stealing (i.e. don't bother with
>> a full fledged balance at newidle, just pick one spare task somewhere),
>> none of this would be required.
>
> newly idle load balance already stops after picking 1 task

Mph, I had already forgotten your changes there. Is that really always the
case for newidle? In e.g. the busiest->group_type == group_fully_busy case,
I think we can pull more than one task.

> Now if your proposal is to pick one random task on one random cpu, I'm
> clearly not sure that's a good idea
>

IIRC Steve's implementation was to "simply" pull one task from any CPU
within the LLC domain that had > 1 runnable tasks. I quite like this since
picking any one task is almost always better than switching to the idle
task, but it wasn't a complete newidle_balance() replacement just yet.

>
>>
>> Sadly I don't think anyone has been looking at it any recently.
