Return-Path: <SRS0=RNtb=7C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5EC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1877C2070A
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589991849;
	bh=5E16tIAp8xQG71YS0BbGpK4xyAiCK1wiPDEQlUT8K5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UMAeuv6wAFSXpjNzRdweGxboqrlEdlLHoaeECgZeppF8N/zm8+4XKa6OPj+qF1aZc
	 uO0Dq0irI5wvdJs/vW8i0hLGZQMArcP3FeIDl5imCdsAuH9MY9QlP+rEFFg17m5wlD
	 kbZkEPX74hG9+FmfCyg8vk6//b3RYbfB3h3jVmsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgETQYG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 May 2020 12:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETQYF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 May 2020 12:24:05 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5160B20709;
        Wed, 20 May 2020 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589991844;
        bh=5E16tIAp8xQG71YS0BbGpK4xyAiCK1wiPDEQlUT8K5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2NRIVGEoxaaE8OcK5W2zDxtbj5cgaNID8SH/DVwwi5x0Cg50Y9aRfx9570J71zTe
         PqAF6v8pMMFan5BEBSpieyh/8VuHgB0RRHMuADOSFRbucJvv5fxboalxq24oOh2fYZ
         tf4Gun3C8il8YQ1eKwa1XDc9HlyjOr08y7wJXiRM=
Date:   Wed, 20 May 2020 18:24:02 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200520162400.GA8800@lenoir>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520140402.358880-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Juri,

On Wed, May 20, 2020 at 04:04:02PM +0200, Juri Lelli wrote:
> After tasks enter or leave a runqueue (wakeup/block) SCHED full_nohz
> dependency is checked (via sched_update_tick_dependency()). In case tick
> can be stopped on a CPU (see sched_can_stop_tick() for details), SCHED
> dependency for such CPU is cleared. However, this new information is not
> used right away to actually stop the tick.
> 
> In CONFIG_PREEMPT systems booted with threadirqs option, sched clock
> tick is serviced by an actual task (ksoftirqd corresponding to the CPU
> where tick timer fired).

I must confess I haven't tested threaded IRQs but I was
pretty sure that the timer tick is always serviced on hardirq.

Now the timer list callbacks are executed on softirqs. So if the
tick itself, executed on hardirq, sees pending timers, it raise
the softirq which wakes up ksoftirqd on forced irq thread mode
while calling irq_exit(). Then tick_nohz_irq_exit() sees ksoftirqd
and the current task on the runqueue, which together can indeed prevent
from turning off the tick. But then the root cause is pending timer
list callbacks.

> So, in case a CPU was running a single task,
> servicing the timer involves exiting full nozh mode. Problem at this
> point is that we might lose chances to enter back into full nozh mode,
> since info about ksoftirqd thread going back to sleep is not used (as
> mentioned above).

It should enter into nohz_full mode in the next tick, which is usually
a reasonable delay. If you need guarantee that the tick is stopped before
resuming userspace, you need a stronger machinery such as the task isolation
patchset.

Let's have a look at the trace below:

> ksoftirqd/19-125   [019]   170.700754: softirq_entry:        vec=1 [action=TIMER]
> ksoftirqd/19-125   [019]   170.700755: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/19-125   [019]   170.700756: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/19-125   [019]   170.700757: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/19-125   [019]   170.700759: sched_switch:         ksoftirqd/19:125 [120] S ==> sysjitter:2459 [120]
>    sysjitter-2459  [019]   170.701740: local_timer_entry:    vector=236
>    sysjitter-2459  [019]   170.701742: softirq_raise:        vec=1 [action=TIMER]

See here the tick sees pending timer callbacks so it raises the timer softirq.

>    sysjitter-2459  [019]   170.701743: softirq_raise:        vec=7 [action=SCHED]

Oh and the scheduler tick activates the scheduler softirq as well.

>    sysjitter-2459  [019]   170.701744: local_timer_exit:     vector=236
>    sysjitter-2459  [019]   170.701747: sched_wakeup:         ksoftirqd/19:125 [120] success=1 CPU:019
>    sysjitter-2459  [019]   170.701748: tick_stop:            success=0 dependency=SCHED
>    sysjitter-2459  [019]   170.701749: irq_work_entry:       vector=246
>    sysjitter-2459  [019]   170.701750: irq_work_exit:        vector=246
>    sysjitter-2459  [019]   170.701751: tick_stop:            success=0 dependency=SCHED
>    sysjitter-2459  [019]   170.701753: sched_switch:         sysjitter:2459 [120] R ==> ksoftirqd/19:125 [120]
> ksoftirqd/19-125   [019]   170.701754: softirq_entry:        vec=1 [action=TIMER]
> ksoftirqd/19-125   [019]   170.701756: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/19-125   [019]   170.701756: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/19-125   [019]   170.701758: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/19-125   [019]   170.701759: sched_switch:         ksoftirqd/19:125 [120] S ==> sysjitter:2459 [120]
>    sysjitter-2459  [019]   170.702740: local_timer_entry:    vector=236
>    sysjitter-2459  [019]   170.702742: softirq_raise:        vec=1 [action=TIMER]

A new tick but we still have pending timer callback so we'll need to wakeup ksoftirqd
again.

I think you should trace timers and check which one is concerned here.

Thanks.
