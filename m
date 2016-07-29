From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Timer tick not disabled with NO_HZ_FULL
Date: Fri, 29 Jul 2016 16:56:15 -0400
Message-ID: <CAC6yHM4kTvXiJwsyFqmi3p_4U8a54wwUJz9QFHAGsO+aM6G6Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35692 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbcG2U4R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2016 16:56:17 -0400
Received: by mail-oi0-f68.google.com with SMTP id w143so8649030oiw.2
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Jul 2016 13:56:17 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It seems that the timer tick occurs with a PREEMPT_RT kernel even if configured
with NO_HZ_FULL. On a real-time system where some cores are configured with
isolcpu, the tick increases the execution jitter.

# tracer: nop
#
# entries-in-buffer/entries-written: 20219/20219   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            |/  _-----=> need-resched_lazy
#                            || / _---=> hardirq/softirq
#                            ||| / _--=> preempt-depth
#                            |||| /_--=> preempt-lazy-depth
#                            |||||  _-=> migrate-disable
#                            ||||| /    delay
#           TASK-PID   CPU#  ||||||    TIMESTAMP  FUNCTION
#              | |       |   ||||||       |         |
          <idle>-0     [002] d..h2..    41.314675:
hrtimer_expire_entry: hrtimer=ffff88013fc8f860
function=tick_sched_timer now=41136043338
          <idle>-0     [002] d..h2..    41.318675:
hrtimer_expire_entry: hrtimer=ffff88013fc8f860
function=tick_sched_timer now=41140043943
          <idle>-0     [002] d..h2..    41.322675:
hrtimer_expire_entry: hrtimer=ffff88013fc8f860
function=tick_sched_timer now=41144043138

I think the issue comes from commit 8aede461ab35 in kernel/time/timer.c:

    u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
    {
    [...]
    #ifdef CONFIG_PREEMPT_RT_FULL

        /*
        * On PREEMPT_RT we cannot sleep here. As a result we can't take
        * the base lock to check when the next timer is pending and so
        * we assume the next jiffy.
        */
        return basem + TICK_NSEC;
    #endif
    [...]

This commit is quite old, maybe a solution exists to the problem of base timer
locking. Would it be possible for instance to use RCU instead here to support
NO_HZ_FULL with a PREEMPT_RT kernel?

Thanks,

Francis
