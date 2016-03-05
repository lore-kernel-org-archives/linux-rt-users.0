From: Joel Fernandes <joelaf@lab126.com>
Subject: Re: why does this irqsoff tracer output show interrupts disabled
 between irq to softirq transition?
Date: Fri, 4 Mar 2016 23:19:05 -0800
Message-ID: <56DA8869.9000305@lab126.com>
References: <56D67C37.10207@lab126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:53634 "EHLO
	smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbcCEHTr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 5 Mar 2016 02:19:47 -0500
Received: from ex10-hub-7002.ant.amazon.com (pdx1-ws-svc-lb16-vlan3.amazon.com [10.239.138.214])
	by email-inbound-relay-64014.pdx4.amazon.com (8.14.7/8.14.7) with ESMTP id u257Jcjm019938
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Sat, 5 Mar 2016 07:19:44 GMT
In-Reply-To: <56D67C37.10207@lab126.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/01/16 21:37, Joel Fernandes wrote:
> Hi,
>
> I am using the irqsoff tracer on a (slightly old) kernel and I am seeing something like this.
> As you can see, after servicing the hrtimer_interrupt, and calling irq_exit(), a softirq runs.
>
> But the softirq (which happens to be run_timer_softirq) is being called with interrupts
> disabled, - but from my understanding, interrupts are to remain enabled during softirq
> operation (unless ofcourse a spinlock is shared between a softirq and an irq handler and
> someone calls spinlock_irq_save).
>
> So considering this, does the below makes sense?  Thanks for any insight!
>
>
>   mmcqd/0-1435    0d.h1  182us : preempt_count_add <-_raw_spin_lock
>   mmcqd/0-1435    0d.h2  182us : enqueue_hrtimer <-__run_hrtimer
>   mmcqd/0-1435    0d.h2  183us : _raw_spin_unlock <-hrtimer_interrupt
>   mmcqd/0-1435    0d.h2  183us : preempt_count_sub <-_raw_spin_unlock
>   mmcqd/0-1435    0d.h1  184us : tick_program_event <-hrtimer_interrupt
>   mmcqd/0-1435    0d.h1  184us : clockevents_program_event <-tick_program_event
>   mmcqd/0-1435    0d.h1  184us : ktime_get <-clockevents_program_event
>   mmcqd/0-1435    0d.h1  185us : lapic_next_deadline <-clockevents_program_event
>   mmcqd/0-1435    0d.h1  186us : irq_exit <-smp_apic_timer_interrupt
>   mmcqd/0-1435    0d.h1  186us : irqtime_account_irq <-irq_exit
>   mmcqd/0-1435    0d.h1  187us : preempt_count_sub <-irq_exit
>   mmcqd/0-1435    0d..1  187us : __do_softirq <-irq_exit
>   mmcqd/0-1435    0d..1  188us : msecs_to_jiffies <-__do_softirq
>   mmcqd/0-1435    0d..1  188us : irqtime_account_irq <-__do_softirq
>   mmcqd/0-1435    0d..1  188us : __local_bh_disable_ip <-__do_softirq
>   mmcqd/0-1435    0d.s1  190us : preempt_count_add <-_raw_spin_lock_irq
>   mmcqd/0-1435    0d.s2  191us+: _raw_spin_unlock_irq <-run_timer_softirq
>   mmcqd/0-1435    0d.s1  194us : preempt_count_add <-_raw_read_lock_irqsave
>   mmcqd/0-1435    0d.s2  195us+: _raw_read_unlock_irqrestore <-cpufreq_cpu_get
>   mmcqd/0-1435    0d.s1  201us : preempt_count_add <-_raw_spin_lock_irqsave
>   mmcqd/0-1435    0d.s2  202us : _raw_spin_unlock_irqrestore <-cpufreq_stats_update
>   mmcqd/0-1435    0d.s1  203us : preempt_count_add <-_raw_spin_lock_irqsave
>   mmcqd/0-1435    0d.s2  203us+: _raw_spin_unlock_irqrestore <-cpufreq_stat_notifier_trans
>   mmcqd/0-1435    0d.s1  205us : preempt_count_add <-_raw_spin_lock_irqsave
>   mmcqd/0-1435    0d.s2  205us : detach_if_pending <-mod_timer_pinned
>   mmcqd/0-1435    0d.s2  206us : internal_add_timer <-mod_timer_pinned
>   mmcqd/0-1435    0d.s2  207us : __internal_add_timer <-internal_add_timer

Sorry about the noise. I believe I was using 'preemptirqsoff' tracer and in this path 
preemption was off (preempt count was non zero), so even if the interrupts were reenabled 
before the softirq, the tracer would continue to trace.

I guess the 'd' is a bit misleading in the trace I provided above, because it didn't show the 
'd' go away in the softirq path, but I suppose no function was traced after the interrupts 
re-enabled before the softirq and then a spinlock_irq was called in the softirq path so the 'd' 
continue to persist.

Thanks,

Joel
