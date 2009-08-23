From: Remy Bohmer <linux@bohmer.net>
Subject: System lockup with 2.6.26.8-rt16 on ARM9
Date: Sun, 23 Aug 2009 16:44:54 +0200
Message-ID: <3efb10970908230744l4cfaf2el61abce6229796194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:34665 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933515AbZHWOoy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Aug 2009 10:44:54 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Thomas,

We are running into a bug on a ARM926 processor with 2.6.26.8-rt16
where the system stops scheduling any thread while the hard-irq
handlers keep on running (and waking up tasks with wake_up_process())
What happens is that the system is idle and is continuously polling on
need_resched() in the cpu_idle() routine (arch/arm/kernel/process.c)
But, need_resched() keeps on returning false, so the system stays in
the idle loop and __schedule is never called.

While debugging this we noticed/tried several things already:
* default_idle() wakes up properly when an interrupt occurs.
* Interrupt handling keeps on running, but no interrupt threads are
scheduled either.
* Triggering a different interrupt source sometimes get the system out
of the lockup condition.
* removing the loop with need_resched() to force the system to call
__schedule() after waking up from default_idle() has no effect, the
scheduler does not schedule any threads that are clearly runnable. See
logging below.
* preempt_schedule_irq() is not called after an irq during the lockup.
Probably it is because the check on preempt_count!=0 in __irq_svc (in
arch/arm/kernel/entry-armv.S).
* We have excluded any relation with any user application by adding
root_delay=<1-month-in-seconds> to the kernel commandline.
* We stripped down the kernel as much as possible, excluding almost
all drivers, including removing the networking layer. (but with
networking and a ping flood it seems easier to reproduce)
* Problem exists with NO_HZ, HRT as well as without it.

Is this problem already known, and is there maybe/hopefully already a
fix for it?
Or do you have any other good suggestion for debugging/tracing this?

void cpu_idle(void)
{
        local_fiq_enable();

        /* endless idle loop with no priority at all */
        while (1) {
                void (*idle)(void) = pm_idle;

#ifdef CONFIG_HOTPLUG_CPU
                if (cpu_is_offline(smp_processor_id())) {
                        leds_event(led_idle_start);
                        cpu_die();
                }
#endif

                if (!idle)
                        idle = default_idle;
                leds_event(led_idle_start);
                tick_nohz_stop_sched_tick(1);
--> System keeps looping in this need_resched() loop.
                while (!need_resched())
                        idle();
                leds_event(led_idle_end);
                tick_nohz_restart_sched_tick();
                local_irq_disable();
                __preempt_enable_no_resched();
--> Even calling this (after removing the above 'while
(!need_resched())') has no effect.
                __schedule();
                preempt_disable();
                local_irq_enable();
        }
}


We call 'print_cpu()' when a lockup occurs. We call it directly from a
hard-irq handler.
(canary_check is a kernel thread that is part of our debugging code.
It is a thread that is directly scheduled via wake_up_process() from
the system timer irq. We check from the hard-irq handler if this
thread is being scheduled, if not the system is locked up and we dump
this logging)

[ 8931.475755]
[ 8931.475769] cpu#0
[ 8931.479186]   .nr_running                    : 3
[ 8931.483809]   .load                          : 532566
[ 8931.488862]   .nr_switches                   : 37438443
[ 8931.494089]   .nr_load_updates               : 860943
[ 8931.499142]   .nr_uninterruptible            : 1
[ 8931.503761]   .jiffies                       : 830943
[ 8931.508816]   .next_balance                  : 0.000000
[ 8931.514043]   .curr->pid                     : 0
[ 8931.518664]   .clock                         : 8931475.737362
[ 8931.524411]   .cpu_load[0]                   : 532566
[ 8931.529464]   .cpu_load[1]                   : 532420
[ 8931.534516]   .cpu_load[2]                   : 516298
[ 8931.539569]   .cpu_load[3]                   : 433653
[ 8931.544621]   .cpu_load[4]                   : 310689
[ 8931.549674]   .rt.rt_nr_running              : 3
[ 8931.554293]   .rt.rt_nr_uninterruptible      : 4294967293
[ 8931.559694]
[ 8931.559703] cfs_rq[0]:
[ 8931.563548]   .exec_clock                    : 0.000000
[ 8931.568778]   .MIN_vruntime                  : 0.000001
[ 8931.574007]   .min_vruntime                  : 1254.953603
[ 8931.579496]   .max_vruntime                  : 0.000001
[ 8931.584724]   .spread                        : 0.000000
[ 8931.589952]   .spread0                       : 0.000000
[ 8931.595178]   .nr_running                    : 0
[ 8931.599796]   .load                          : 0
[ 8931.604414]   .nr_spread_over                : 0
[ 8931.609048]
[ 8931.609056] runnable tasks:
[ 8931.609067]             task   PID         tree-key  switches  prio
    exec-runtime         sum-exec        sum-sleep
[ 8931.609094] ----------------------------------------------------------------------------------------------------------
[ 8931.634702]     sirq-timer/0     5         6.652438   1003780    59
              0               0               0.000000
0.000000               0.000000
[ 8931.649795]     canary_check    33        78.141669    860433     0
              0               0               0.000000
0.000000               0.000000
[ 8931.664887]           IRQ-57   243       832.211283  13874273    59
              0               0               0.000000
0.000000               0.000000
[ 8931.764591]


Kind regards,

Remy
