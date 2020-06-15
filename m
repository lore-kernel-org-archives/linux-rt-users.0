Return-Path: <SRS0=YDde=74=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4DAC433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Jun 2020 21:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F612078E
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Jun 2020 21:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592255270;
	bh=gcLqdMHBmpb70W2w0706bkJG11nt+9jdXNiIszD6y1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mIm3gZzzBBneUKaHMNLUt9XzULqPAfmezStWkNj2nVDWALaTITmlWPl09K/fQV8Zf
	 kS/YuQCRY9/cLx4pOYJLjp6Y2Umk8n4Zzk7U2/LmYCvTPUTarLzAVC3XPpNmdP2RXP
	 5vtP3JhGS1yJGs3Vmz4JSqfG7GOB2PCQnRDOUwtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgFOVHt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOVHr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Jun 2020 17:07:47 -0400
Received: from localhost (lfbn-ncy-1-150-120.w83-194.abo.wanadoo.fr [83.194.232.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FFCE20739;
        Mon, 15 Jun 2020 21:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592255266;
        bh=gcLqdMHBmpb70W2w0706bkJG11nt+9jdXNiIszD6y1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vg/RKp+xE+7tSJwAY8owtsM8G5IHDRN+wd7OOjQozHNyosc2y+skoq23hizo7CF77
         Uz2XDvQyHkAAlmCAbJSyX/017k2WORbh/7XQYowo3qx1D6MIqNk2XQ5NF6UEEuP1JW
         im99Kdsq3KATcssxDBdJRDcG9VMn8bdkbToxgzZI=
Date:   Mon, 15 Jun 2020 23:07:44 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200615210743.GA21371@lenoir>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521170020.GQ10078@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, May 21, 2020 at 07:00:20PM +0200, Juri Lelli wrote:
> ksoftirqd/3-26    [003]    99.942485: timer_expire_entry:   timer=0xffffffffa55a9d20 function=clocksource_watchdog now=4294759328 baseclk=4294759328
> ksoftirqd/3-26    [003]    99.942489: timer_start:          timer=0xffffffffa55a9d20 function=clocksource_watchdog expires=4294759822 [timeout=494] cpu=4 idx=114 flags=D|P|I
> ksoftirqd/3-26    [003]    99.942491: timer_expire_exit:    timer=0xffffffffa55a9d20
>   sysjitter-2377  [004]    99.942491: call_function_single_entry: vector=251
>   sysjitter-2377  [004]    99.942492: call_function_single_exit: vector=251
> ksoftirqd/3-26    [003]    99.942493: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/3-26    [003]    99.942494: softirq_entry:        vec=7 [action=SCHED]
>   sysjitter-2377  [004]    99.942494: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92630457385 softexpires=92630457385
> ---
> 
> So, my understanding is that clock gets reactivated on CPU 4 to run
> clocksource watchdog (indeed if I use tsc=nowatchdog this above doesn't
> happen, but the potential issue is still there I guess).

CPU 4 is being disturbed by an IPI. It's possibly caused by RCU, there
is a pending fix that I need to refresh and repost but you may
want to give it a try: https://lore.kernel.org/lkml/20200515003429.4317-1-frederic@kernel.org/

> 
> ---
>   sysjitter-2377  [004]   100.438455: local_timer_entry:    vector=236
>   sysjitter-2377  [004]   100.438456: hrtimer_cancel:       hrtimer=0xffff92e9df91fd20
>   sysjitter-2377  [004]   100.438458: hrtimer_expire_entry: hrtimer=0xffff92e9df91fd20 now=92630461337 function=tick_sched_timer/0x0
>   sysjitter-2377  [004]   100.438460: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => update_process_times (ffffffffa3768f9d)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
>   sysjitter-2377  [004]   100.438461: softirq_raise:        vec=1 [action=TIMER]
>   sysjitter-2377  [004]   100.438464: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => trigger_load_balance (ffffffffa371cb9c)
> => update_process_times (ffffffffa3768fc7)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
>   sysjitter-2377  [004]   100.438465: softirq_raise:        vec=7 [action=SCHED]
> ---
> 
> Tick fires, the two softirq_raise (which you wondered about) seems to
> come from
> 
>  1. update_process_times::run_local_timers (TIMER_SOFTIRQ)
>  2. update_process_times::scheduler_tick::trigger_load_balance (SCHED_SOFTIRQ)

Well, the places raising the softirqs are always the same. Now how the timer
internals can decide to raise the TIMER_SOFTIRQ when there is no callback
expired is more mysterious.

> 
> ---
>   sysjitter-2377  [004]   100.438468: hrtimer_expire_exit:  hrtimer=0xffff92e9df91fd20
>   sysjitter-2377  [004]   100.438470: local_timer_exit:     vector=236
>   sysjitter-2377  [004]   100.438473: sched_wakeup:         ksoftirqd/4:31 [120] success=1 CPU:004
>   sysjitter-2377  [004]   100.438474: tick_stop:            success=0 dependency=SCHED
>   sysjitter-2377  [004]   100.438476: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92630512937 softexpires=92630512937
>   sysjitter-2377  [004]   100.438484: irq_work_entry:       vector=246
>   sysjitter-2377  [004]   100.438491: irq_work_exit:        vector=246
>   sysjitter-2377  [004]   100.438492: tick_stop:            success=0 dependency=SCHED
>   sysjitter-2377  [004]   100.438495: sched_switch:         sysjitter:2377 [120] R ==> ksoftirqd/4:31 [120]
> ksoftirqd/4-31    [004]   100.438497: softirq_entry:        vec=1 [action=TIMER]
> ksoftirqd/4-31    [004]   100.438499: timer_cancel:         timer=0xffffffffa55a9d20
> ksoftirqd/4-31    [004]   100.438501: timer_expire_entry:   timer=0xffffffffa55a9d20 function=clocksource_watchdog now=4294759824 baseclk=4294759824
> ksoftirqd/4-31    [004]   100.438504: timer_start:          timer=0xffffffffa55a9d20 function=clocksource_watchdog expires=4294760322 [timeout=498] cpu=5 idx=113 flags=D|P|I
> ---
> 
> Queueing clocksource watchdog on CPU5.
> 
> ---
> ksoftirqd/4-31    [004]   100.438506: timer_expire_exit:    timer=0xffffffffa55a9d20
> ksoftirqd/4-31    [004]   100.438507: local_timer_entry:    vector=236
> ---
> 
> Back to back timer?

It looks like the tick has been reprogrammed very early indeed.

> 
> ---
> ksoftirqd/4-31    [004]   100.438509: hrtimer_cancel:       hrtimer=0xffff92e9df91fd20
> ksoftirqd/4-31    [004]   100.438511: hrtimer_expire_entry: hrtimer=0xffff92e9df91fd20 now=92630515022 function=tick_sched_timer/0x0
> ksoftirqd/4-31    [004]   100.438515: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => rcu_sched_clock_irq (ffffffffa375af4a)
> => update_process_times (ffffffffa3768fa4)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
> => filter_pred_32 (ffffffffa37f3357)
> => filter_match_preds (ffffffffa37f3510)
> => trace_event_buffer_commit (ffffffffa37dc7eb)
> => trace_event_raw_event_softirq (ffffffffa36dab77)
> => __do_softirq (ffffffffa420025a)
> => run_ksoftirqd (ffffffffa36dadc6)
> => smpboot_thread_fn (ffffffffa36ffdb8)
> => kthread (ffffffffa36f9fb7)
> => ret_from_fork (ffffffffa4000215)
> ksoftirqd/4-31    [004]   100.438516: softirq_raise:        vec=9 [action=RCU]
> ksoftirqd/4-31    [004]   100.438520: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => trigger_load_balance (ffffffffa371cb9c)
> => update_process_times (ffffffffa3768fc7)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
> => filter_pred_32 (ffffffffa37f3357)
> => filter_match_preds (ffffffffa37f3510)
> => trace_event_buffer_commit (ffffffffa37dc7eb)
> => trace_event_raw_event_softirq (ffffffffa36dab77)
> => __do_softirq (ffffffffa420025a)
> => run_ksoftirqd (ffffffffa36dadc6)
> => smpboot_thread_fn (ffffffffa36ffdb8)
> => kthread (ffffffffa36f9fb7)
> => ret_from_fork (ffffffffa4000215)
> ksoftirqd/4-31    [004]   100.438520: softirq_raise:        vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438521: hrtimer_expire_exit:  hrtimer=0xffff92e9df91fd20
> ksoftirqd/4-31    [004]   100.438523: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92631512937 softexpires=92631512937
> ksoftirqd/4-31    [004]   100.438525: local_timer_exit:     vector=236
> ksoftirqd/4-31    [004]   100.438527: tick_stop:            success=0 dependency=SCHED
> ---
> 
> At this point (I think) ksoftirqd is already going to sleep, so only
> sysjitter will be eventually executing on CPU4, but tick_stop check
> still sees nr_running == 2.

As long at it hasn't been dequeued from the runqueue, tick_stop sees nr_running == 2.

> 
> ---
> ksoftirqd/4-31    [004]   100.438530: softirq_exit:         vec=1 [action=TIMER]

Was there a corresponding softirq_enter? With timers expiring inside?

> ksoftirqd/4-31    [004]   100.438531: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438533: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438534: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438535: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438536: softirq_entry:        vec=9 [action=RCU]
> ksoftirqd/4-31    [004]   100.438537: softirq_exit:         vec=9 [action=RCU]
> ksoftirqd/4-31    [004]   100.438540: sched_switch:         ksoftirqd/4:31 [120] S ==> sysjitter:2377 [120]
> ---
> 
> And tick again fires below.
> 
> ---
>   sysjitter-2377  [004]   100.439509: local_timer_entry:    vector=236
>   sysjitter-2377  [004]   100.439511: hrtimer_cancel:       hrtimer=0xffff92e9df91fd20
>   sysjitter-2377  [004]   100.439512: hrtimer_expire_entry: hrtimer=0xffff92e9df91fd20 now=92631515408 function=tick_sched_timer/0x0

Right that's expected behaviour.

>   sysjitter-2377  [004]   100.439518: softirq_raise:        vec=7 [action=SCHED]
>   sysjitter-2377  [004]   100.439520: hrtimer_expire_exit:  hrtimer=0xffff92e9df91fd20
>   sysjitter-2377  [004]   100.439521: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92632512937 softexpires=92632512937
>   sysjitter-2377  [004]   100.439522: local_timer_exit:     vector=236
>   sysjitter-2377  [004]   100.439525: sched_wakeup:         ksoftirqd/4:31 [120] success=1 CPU:004
>   sysjitter-2377  [004]   100.439527: tick_stop:            success=0 dependency=SCHED
>   sysjitter-2377  [004]   100.439529: irq_work_entry:       vector=246
>   sysjitter-2377  [004]   100.439531: irq_work_exit:        vector=246
>   sysjitter-2377  [004]   100.439532: tick_stop:            success=0 dependency=SCHED
>   sysjitter-2377  [004]   100.439534: sched_switch:         sysjitter:2377 [120] R ==> ksoftirqd/4:31 [120]
> ksoftirqd/4-31    [004]   100.439536: softirq_entry:        vec=1 [action=TIMER]
> ksoftirqd/4-31    [004]   100.439537: softirq_exit:         vec=1 [action=TIMER]

The empty timer softirq again.

> ksoftirqd/4-31    [004]   100.439538: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.439540: softirq_exit:         vec=7 [action=SCHED]

I'm also wondering if it's expected to see the sched softirq repeating so often.

> ksoftirqd/4-31    [004]   100.439541: sched_switch:         ksoftirqd/4:31 [120] S ==> sysjitter:2377 [120]
> ---
> 
> History seems to repeat itself until ~2s later (this is one of the
> pathological runs) when an ipi fires on CPU4 and SCHED dependecy is seen
> as cleared (as only sysjitter thread was is running at that point).
> 
> Does this make sense and help in any way? Suggestions for debugging this
> further? :-)

Let's see if I can reproduce it first. If not I'll need to bother you further :)

Thanks!
