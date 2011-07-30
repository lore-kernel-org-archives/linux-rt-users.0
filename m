From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC][PATCH 0/3] update to cpupri algorithm
Date: Sat, 30 Jul 2011 09:12:11 +0200
Message-ID: <1312009931.8752.53.camel@marge.simson.net>
References: <20110729151340.419467771@goodmis.org>
	 <1311963874.2314.15.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:51349 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752715Ab1G3HMP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Jul 2011 03:12:15 -0400
In-Reply-To: <1311963874.2314.15.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-07-29 at 20:24 +0200, Mike Galbraith wrote:
> On Fri, 2011-07-29 at 11:13 -0400, Steven Rostedt wrote:
> > Hi Mike,
> > 
> > Could you try this patch set out. Add the first patch and then
> > run your tests. The first patch only adds benchmarking, and does not
> > modify the scheduler algorithm.
> > 
> > Do this:
> > 
> > 1. apply first patch, build and boot
> > 2. # mount -t debugfs nodev /sys/kernel/debug
> > 3. # echo 0 > /sys/kernel/debug/cpupri; ./runtest; cat /sys/kernel/debug/cpupri > output
> > 
> > The output will give you the contention of the vector locks in the
> > cpupri algorithm.
> > 
> > Then apply the second patch and do the same thing.
> > 
> > Then apply the third patch and do the same thing.
> > 
> > After that, could you send me the results of the output file for all
> > three runs?  The final patch should probably be the best overall
> > results.
> 
> Wow.
> 
> CPU:    Name    Count   Max     Min     Average Total
> ----    ----    -----   ---     ---     ------- -----
> cpu 60: loop    0       0       0       0       0
>         vec     5410840 277.954 0.084   0.782   4232895.727
> cpu 61: loop    0       0       0       0       0
>         vec     4915648 188.399 0.084   0.570   2803220.301
> cpu 62: loop    0       0       0       0       0
>         vec     5356076 276.417 0.085   0.786   4214544.548
> cpu 63: loop    0       0       0       0       0
>         vec     4891837 170.531 0.085   0.799   3910948.833

BTW, that's a _lot_ more usecs than I'm looking for.  Neither cyclictest
not jitter test proggy's main thread hit that for some reason, must be
worker threads getting nailed or something.

Your patches did improve jitter (of course), but +-30 usecs with a ~full
box isn't achievable yet (oh darn).  Cyclictest shows max latency well
within the goal, but jitter still goes over.

My profile looks much better, but jitter proggy using posix-timers on 56
cores warms up a spot you know all about.  Lucky me, I know where fixes
for that bugger live.

With your fixes, looks like 3.0.0-rtN should be much better on hefty HW.

    1 # dso: [kernel.kallsyms]
    2 # Events: 272K cycles
    3 #
    4 # Overhead                             Symbol
    5 # ........  .................................
    6 #
    7     11.58%  [k] cpupri_set
    8             |
    9             |--71.03%-- dequeue_rt_stack
   10             |          dequeue_task_rt
   11             |          dequeue_task
   12             |          |
   13             |          |--99.98%-- deactivate_task
   14             |          |          __schedule
   15             |          |          schedule
   16             |          |          |
   17             |          |          |--35.07%-- run_ksoftirqd
   18             |          |          |          kthread
   19             |          |          |          kernel_thread_helper
   20             |          |          |
   21             |          |          |--32.23%-- sys_semtimedop
   22             |          |          |          system_call_fastpath
   23             |          |          |          |
   24             |          |          |          |--2.96%-- 0x7fe09af86e37
   25             |          |          |          |          __semop
...
  713      9.67%  [k] _raw_spin_lock_irqsave
  714             |
  715             |--61.75%-- rt_spin_lock_slowlock
  716             |          |
  717             |          |--97.54%-- lock_timer  (Hi idr_lock, you haven't met Eric yet.  Clever fellow, you'll like him)
  718             |          |          do_schedule_next_timer
  719             |          |          dequeue_signal
  720             |          |          sys_rt_sigtimedwait
  721             |          |          system_call_fastpath
  722             |          |          |
  723             |          |          |--6.42%-- 0x7fb4c2ebbf27
  724             |          |          |          do_sigwait


