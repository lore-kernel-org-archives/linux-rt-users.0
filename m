From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [BUG nohz]: wrong user and system time accounting
Date: Thu, 23 Mar 2017 16:55:12 -0400
Message-ID: <20170323165512.60945ac6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: riel@redhat.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: fweisbec@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbdCWUzP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Mar 2017 16:55:15 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


When there are two or more tasks executing in user-space and
taking 100% of a nohz_full CPU, top reports 70% system time
and 30% user time utilization. Sometimes I'm even able to get
100% system time and 0% user time.

This was reproduced with latest Linus tree (093b995), but I
don't believe it's a regression (at least not a recent one)
as I can reproduce it with older kernels. Also, I have
CONFIG_IRQ_TIME_ACCOUNTING=y and haven't tried to reproduce
without it yet.

Below you'll find the steps to reproduce and some initial
analysis.

Steps to reproduce
------------------

1. Set up a CPU for nohz_full with isolcpus= nohz_full=

2. Pin two tasks that hog the CPU 100% of the time to that CPU

3. Run top -d1 and check system time

NOTE: When there's only one task hogging a nohz_full CPU, top
      shows 100% user-time, as expected

Initial analysis
----------------

When tracing vtime accounting functions and the user-space/kernel
transitions when the issue is taking place, I see several of the
following:

hog-10552 [015]  1132.711104: function:             enter_from_user_mode <-- apic_timer_interrupt
hog-10552 [015]  1132.711105: function:             __context_tracking_exit <-- enter_from_user_mode
hog-10552 [015]  1132.711105: bprint:               __context_tracking_exit.part.4: new state=1 cur state=1 active=1
hog-10552 [015]  1132.711105: function:             vtime_account_user <-- __context_tracking_exit.part.4
hog-10552 [015]  1132.711105: function:             smp_apic_timer_interrupt <-- apic_timer_interrupt
hog-10552 [015]  1132.711106: function:             irq_enter <-- smp_apic_timer_interrupt
hog-10552 [015]  1132.711106: function:             tick_sched_timer <-- __hrtimer_run_queues
hog-10552 [015]  1132.711108: function:             irq_exit <-- smp_apic_timer_interrupt
hog-10552 [015]  1132.711108: function:             __context_tracking_enter <-- prepare_exit_to_usermode
hog-10552 [015]  1132.711108: bprint:               __context_tracking_enter.part.2: new state=1 cur state=0 active=1
hog-10552 [015]  1132.711109: function:             vtime_user_enter <-- __context_tracking_enter.part.2
hog-10552 [015]  1132.711109: function:             __vtime_account_system <-- vtime_user_enter
hog-10552 [015]  1132.711109: function:             account_system_time <-- __vtime_account_system

On entering the kernel due to a timer interrupt, vtime_account_user()
skips user-time accounting. Then later on when returning to user-space,
vtime_user_enter() is probably accounting the whole time (ie. user-space
plus kernel-space) to system time.

Now, when does vtime_account_user() skips accounting? Well, when the
time delta is less then one jiffie. This would imply that vtime_account_user()
is being called less than one jiffie since the last accounting, but I haven't
confirmed any of this yet.
