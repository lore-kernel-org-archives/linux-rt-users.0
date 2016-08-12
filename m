From: Jens Koehler <jenskxxx@googlemail.com>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Fri, 12 Aug 2016 11:47:31 +0200
Message-ID: <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de> <20160808164505.GA13707@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35534 "EHLO
	mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbcHLJrd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Aug 2016 05:47:33 -0400
Received: by mail-ua0-f169.google.com with SMTP id n59so33918063uan.2
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Aug 2016 02:47:32 -0700 (PDT)
In-Reply-To: <20160808164505.GA13707@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Sebastian,

We upgraded the kernel according your recommendation to v3.14.73-rt78
(in rt77 was a bug - https://lwn.net/Articles/694711/) and applied
also suggested patch.

During test we noticed the *hrtimer: interrupt took xxxx ns* message
and got following log.

>          <idle>-0     [000] d..h2.. 45070.884077: hrtimer_interrupt: entry: 45069158989509
>          <idle>-0     [000] d..h2.. 45070.884079: hrtimer_cancel: hrtimer=f717fab8
>          <idle>-0     [000] d..h1.. 45070.884082: hrtimer_expire_entry: hrtimer=f717fab8 function=hrtimer_wakeup now=45069158989509
>          <idle>-0     [000] d..h2.. 45070.884084: sched_waking: comm=mlmodbus pid=824 prio=120 target_cpu=000
>          <idle>-0     [000] dN.h3.. 45070.884088: sched_wakeup: comm=mlmodbus pid=824 prio=120 target_cpu=000
>          <idle>-0     [000] dN.h1.. 45070.884089: hrtimer_expire_exit: hrtimer=f717fab8
>          <idle>-0     [000] dN.h2.. 45070.884093: hrtimer_cancel: hrtimer=c1653500
>          <idle>-0     [000] dN.h1.. 45070.884095: hrtimer_expire_entry: hrtimer=c1653500 function=tick_sched_timer now=45069159007328
>          <idle>-0     [000] dN.h2.. 45070.884105: sched_waking: comm=rcuc/0 pid=14 prio=98 target_cpu=000
>          <idle>-0     [000] dN.h3.. 45070.884108: sched_wakeup: comm=rcuc/0 pid=14 prio=98 target_cpu=000
>          <idle>-0     [000] dN.h1.. 45070.884111: hrtimer_expire_exit: hrtimer=c1653500
>          <idle>-0     [000] dN.h2.. 45070.884113: hrtimer_start: hrtimer=c1653500 function=tick_sched_timer expires=45069160000000 softexpires=45069160000000
>          <idle>-0     [000] dN.h2.. 45070.884116: hrtimer_cancel: hrtimer=e7923f08
>          <idle>-0     [000] dN.h1.. 45070.884118: hrtimer_expire_entry: hrtimer=e7923f08 function=hrtimer_wakeup now=45069159031133
>          <idle>-0     [000] dN.h2.. 45070.884120: sched_waking: comm=PreemptTestApp pid=813 prio=19 target_cpu=000
>          <idle>-0     [000] dN.h3.. 45070.884122: sched_wakeup: comm=PreempTestApp pid=813 prio=19 target_cpu=000
>          <idle>-0     [000] dN.h1.. 45070.884124: hrtimer_expire_exit: hrtimer=e7923f08
>          <idle>-0     [000] dN.h1.. 45070.884137: hrtimer_interrupt: time took: 51718

What could be reason that the timer looped 3 times through the code
before leaving it?

Jens




On Mon, Aug 8, 2016 at 6:45 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Sebastian Andrzej Siewior | 2016-07-01 12:49:26 [+0200]:
>
> tried your testcase and it didn't trigger in KVM. To get more
> informations out of this I prepared a patch to assist you.
>
>>> [137482.258011] hrtimer: interrupt took 9434 ns
>
> For some reason you looped 3 times through the timer code. If you enable
> `timer' events then you should see the "entry" point of the hrtimer irq
> followed by hrtimer_expire_entry + hrtimer_expire_exit. Once you run
> into that case you can look up your trace and examine which hrtimers
> were involved and which took so long.
>
>>> [178458.961966] NOHZ: local_softirq_pending 102
>>> [178458.967583] NOHZ: local_softirq_pending 102
>>> [178458.973295] NOHZ: local_softirq_pending 102
>>> [178458.980249] NOHZ: local_softirq_pending 102
>>> [178458.984994] NOHZ: local_softirq_pending 102
>>> [178458.990582] NOHZ: local_softirq_pending 102
>>> [178458.996292] NOHZ: local_softirq_pending 102
>>> [178459.000348] [sched_delayed] sched: RT throttling activated
>
> For those I would recommend the `sched' events. It should show you the
> task switches before the NOHZ warning. It might give you a hint why the
> scheduler picks the swapper/idle task rather than a task to process
> sofitrqis.
> Also one thing that comes to mind after I was testing it today: If you
> trigger the "RT throttling" then you might see the NOHZ warning. The
> timer-softirq might want to run as a softirq thread with RT priority
> which won't be scheduled due to the throttling.
>
> One more thing: Your config was from an earlier v3.14 kernel. I
> recommend using a later v3.14.73-rt77 (if v3.14 is a must). The later
> version has the timers softirq split out of the general softirq thread.
> That means the "general" softirq thread which does napi won't run at RT
> prio which means it will be excluded from the "RT throttling". We had
> also some reports regarding oom, RCU stalls on small/slow CPUs which are
> hit with a lot of network traffic (like a ping flood).
>
>>> Jens
>
> diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
> --- a/kernel/hrtimer.c
> +++ b/kernel/hrtimer.c
> @@ -1543,6 +1543,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
>
>         raw_spin_lock(&cpu_base->lock);
>         entry_time = now = hrtimer_update_base(cpu_base);
> +       trace_printk("entry: %llu\n", now.tv64);
>  retry:
>         expires_next.tv64 = KTIME_MAX;
>         /*
> @@ -1666,6 +1667,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
>         tick_program_event(expires_next, 1);
>         printk_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
>                     ktime_to_ns(delta));
> +       trace_printk("time took: %llu\n", delta.tv64);
> +       tracing_off();
>  out:
>         if (raise)
>                 raise_softirq_irqoff(HRTIMER_SOFTIRQ);
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -110,6 +110,7 @@ void softirq_check_pending_idle(void)
>         if (rate_limit >= 10)
>                 return;
>
> +       trace_printk("check\n");
>         warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
>         for (i = 0; i < NR_SOFTIRQS; i++) {
>                 struct task_struct *tsk = sr->runner[i];
> @@ -134,6 +135,8 @@ void softirq_check_pending_idle(void)
>         if (warnpending) {
>                 printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
>                        warnpending);
> +               trace_printk("NOHZ: %02x\n", warnpending);
> +               tracing_off();
>                 rate_limit++;
>         }
>  }
> --
> 2.8.1
>
>
> Sebastian
