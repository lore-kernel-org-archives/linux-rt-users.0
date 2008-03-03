From: "Bosko Radivojevic" <bosko.radivojevic@gmail.com>
Subject: Re: High resolution timers on AT91SAM926x
Date: Mon, 3 Mar 2008 11:26:58 +0100
Message-ID: <d6c8ef150803030226m75f68bffvfa20feba9133b247@mail.gmail.com>
References: <200803011457.40857.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: "David Brownell" <david-b@pacbell.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:33540 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584AbYCCK1B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Mar 2008 05:27:01 -0500
Received: by wx-out-0506.google.com with SMTP id h31so6261265wxd.4
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Mar 2008 02:26:59 -0800 (PST)
In-Reply-To: <200803011457.40857.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David,

thank you for the reply. But, I'm getting pretty strange behavior.
I've applied all your patches to 2.6.23.11-rt14 (with official at91
patch for 2.6.23) kernel without any major rejects. Here is a snippet
from the .config:

CONFIG_GENERIC_GPIO=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_AT91_TIMER_HZ=1000
# CONFIG_NO_HZ is not set
CONFIG_HZ=1000

===========================================

$ cat /proc/timer_list
Timer List Version: v0.3
HRTIMER_MAX_CLOCK_BASES: 2
now at 3782337012585 nsecs

cpu: 0
 clock 0:
  .index:      0
  .resolution: 999961 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 1:
  .index:      1
  .resolution: 999961 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c3b2de90>, it_real_fn, S:01
 # expires at 4807555046495 nsecs [in 1025218033910 nsecs]
  .expires_next   : 2147483646999999999 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nohz_mode      : 0
  .idle_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 0 nsecs
  .idle_sleeptime : 0 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 3482489


Tick Device: mode:     0
Clock Event Device: pit
 max_delta_ns:   0
 min_delta_ns:   0
 mult:           26663156
 shift:          32
 mode:           2
 next_event:     0 nsecs
 set_next_event: __init_begin
 set_mode:       pit_clkevt_mode
 event_handler:  tick_handle_periodic

Also, I wrote a small example to test the behaviour (sleeping 1ms):

#define period 500000
#define onesecond 1000000000

 mlockall();
 sp.sched_priority = 90;
 printf ("setscheduler = %d\n", sched_setscheduler (0, SCHED_FIFO, &sp));
 printf ("setparam = %d\n", sched_setparam (0, &sp));

 while (++loop < 30000) {
   clock_gettime (CLOCK_MONOTONIC, &ts);
   if (ts.tv_nsec + period > onesecond) {
     ts2.tv_sec = ts.tv_sec + 1;
     ts2.tv_nsec = (ts.tv_nsec + period) - onesecond;
   } else {
     ts2.tv_sec = ts.tv_sec;
     ts2.tv_nsec = ts.tv_nsec + period;
   }
   clock_nanosleep (CLOCK_MONOTONIC, TIMER_ABSTIME, &ts2, 0);
   clock_gettime (CLOCK_MONOTONIC, &ts3);
   diff = ((ts3.tv_sec - ts.tv_sec)*onesecond+ts3.tv_nsec) - ts.tv_nsec;
   if (!min && !max)
     min = max = diff;
   if (diff > max)
     max = diff;
   if (diff < min)
     min = diff;
   printf ("%ld %ld\n", min, max);
 }

I'm getting this as a result:
1890872 2924656

So, the minimal difference is almost a 2ms, maximum 3ms. I ran this
test for a long period, without any load on the system (except
printing out results through network). Alsto, I'm wondering why
minimal latency is 1890872, it is less then twice 999961 (timer
resolution).

What I am doing wrong? Is there a way to sleep 1ms? I tried to adjust
(/3, /5, etc) pit_cycle in pit_init but all I got was to lock the
system ;)

Thanks!

On Sat, Mar 1, 2008 at 11:57 PM, David Brownell <david-b@pacbell.net> wrote:
> > Is there a way to enable high resolution timers on AT91SAM926x?
>
>  Update PIT to support the clocksource/clockevent framework:
>   http://marc.info/?l=linux-arm-kernel&m=119940724711435&w=2
>
>  Declare timer/counter block platform devices:
>   http://marc.info/?l=linux-arm-kernel&m=120302318811110&w=2
>
>  Use timer/counter blocks for better clocksource and clockevents:
>   http://marc.info/?l=linux-kernel&m=120373043520279&w=2
>   http://marc.info/?l=linux-kernel&m=120373063320487&w=2
>
>  The focus in that last patch is on NO_HZ support -- so the
>  clockevents run at 32 KiHz (about 31 usec precision for HRT)
>  to allow overall HZ to run below 1 where practical.   If you
>  need even higher precision, you could update that clockevent
>  code to use a different base clock.
>
>  Those last two patches are in some MM tree, and Haavard has
>  some updates to then (which don't much affect functionality).
>
>  I understand the upcoming 2.6.24-at91 patch will include the
>  first two patches.
>
>  - Dave
>
