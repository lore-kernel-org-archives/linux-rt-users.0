From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC][PATCH 0/3] update to cpupri algorithm
Date: Sat, 30 Jul 2011 10:16:36 +0200
Message-ID: <1312013796.8752.63.camel@marge.simson.net>
References: <20110729151340.419467771@goodmis.org>
	 <1311963874.2314.15.camel@marge.simson.net>
	 <1312009931.8752.53.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:39548 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750875Ab1G3IQl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Jul 2011 04:16:41 -0400
In-Reply-To: <1312009931.8752.53.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-07-30 at 09:12 +0200, Mike Galbraith wrote:
> y profile looks much better, but jitter proggy using posix-timers on 56
> cores warms up a spot you know all about.  Lucky me, I know where fixes
> for that bugger live.

JiitterChasing::TheEnd() doesn't exist does it?  Aw poo.

30999      0.05%  [k] lock_timer
31000             |
31001             --- do_schedule_next_timer
31002                 dequeue_signal
31003                |
31004                |--87.94%-- sys_rt_sigtimedwait
31005                |          system_call_fastpath
31006                |          |
31007                |          |--20.24%-- 0x7f0935011f27
31008                |          |          do_sigwait

# dso: [kernel.kallsyms]
# Events: 118K cycles
#
# Overhead                               Symbol
# ........  ...................................
#
    22.82%  [k] _raw_spin_lock_irqsave
            |          
            |--32.46%-- rt_mutex_trylock
            |          tty_write_lock
            |          tty_write
            |          vfs_write
            |          sys_write
            |          system_call_fastpath
            |          |          
            |          |--4.38%-- 0x7f46672a30f0
            |          |          __GI___libc_write
...
            |          
            |--32.20%-- rt_mutex_slowlock
            |          tty_write_lock
            |          tty_write
            |          vfs_write
            |          sys_write
            |          system_call_fastpath
            |          |          
            |          |--4.71%-- 0x7f46672a30f0
            |          |          __GI___libc_write
...
            |--25.36%-- rcu_sched_qs
            |          __schedule
            |          |          
            |          |--52.52%-- preempt_schedule
            |          |          try_to_wake_up
            |          |          signal_wake_up
            |          |          send_sigqueue
            |          |          posix_timer_event
            |          |          posix_timer_fn
            |          |          run_hrtimer_softirq
            |          |          run_ksoftirqd
            |          |          kthread
            |          |          kernel_thread_helper
            |          |          
            |           --47.48%-- schedule
            |                     rt_spin_lock_slowlock
            |                     lock_timer
            |                     do_schedule_next_timer
            |                     dequeue_signal
            |                     |          
            |                     |--63.61%-- sys_rt_sigtimedwait
            |                     |          system_call_fastpath
            |                     |          |          
            |                     |          |--9.26%-- 0x7f3c840acf27
            |                     |          |          do_sigwait
...
            |                     |          |          do_sigwait
            |                     |           --5.58%-- [...]
            |                     |          
            |                      --36.39%-- get_signal_to_deliver
            |                                do_signal
            |                                do_notify_resume
            |                                int_signal
            |                                |          
            |                                |--6.17%-- 0x7f1dd90610f0
            |                                |          __GI___libc_write
...
            |          
            |--6.54%-- rt_mutex_slowunlock
            |          tty_write_unlock
            |          tty_write
            |          vfs_write
            |          sys_write
            |          system_call_fastpath
            |          |          
            |          |--6.06%-- 0x7f11267610f0
            |          |          __GI___libc_write



