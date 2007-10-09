From: John Sigler <linux.kernel@free.fr>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 09 Oct 2007 11:28:29 +0200
Message-ID: <470B49BD.4070506@free.fr>
References: <470B44A1.7080007@free.fr> <1191921343.13628.0.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-acpi@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:44250 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbXJIJ2b (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 05:28:31 -0400
In-Reply-To: <1191921343.13628.0.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Alessio Igor Bogani wrote:

> On Tue, 2007-10-09 at 11:06 +0200, John Sigler wrote:
> [...] 
>> I enabled high resolution timer support and disabled ACPI support.
> [...]
> 
> http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00375.html

There are other clock sources on my system.
The timestamp counter is reliable (as far as I can tell).
The LAPIC timer is reliable.
(I've just disabled the PM timer.)

# cat /sys/devices/system/clocksource/clocksource0/available_clocksource
tsc pit jiffies

# cat /sys/devices/system/clocksource/clocksource0/current_clocksource
tsc

# cat /proc/timer_list
Timer List Version: v0.3
HRTIMER_MAX_CLOCK_BASES: 2
now at 3787164271418 nsecs

cpu: 0
  clock 0:
   .index:      0
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_real
   .offset:     0 nsecs
active timers:
  clock 1:
   .index:      1
   .resolution: 10000000 nsecs
   .get_time:   ktime_get
   .offset:     0 nsecs
active timers:
  #0: <cf22bec0>, it_real_fn, S:01
  # expires at 3789432883979 nsecs [in 2268612561 nsecs]
   .expires_next   : 9223372036854775807 nsecs
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
jiffies: 348693


Tick Device: mode:     0
Clock Event Device: pit
  max_delta_ns:   27461866
  min_delta_ns:   12571
  mult:           5124677
  shift:          32
  mode:           1
  next_event:     0 nsecs
  set_next_event: pit_next_event
  set_mode:       init_pit_timer
  event_handler:  clockevents_handle_noop
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000


Tick Device: mode:     0
Clock Event Device: lapic
  max_delta_ns:   1006581321
  min_delta_ns:   1799
  mult:           35793226
  shift:          32
  mode:           2
  next_event:     0 nsecs
  set_next_event: lapic_next_event
  set_mode:       lapic_timer_setup
  event_handler:  tick_handle_periodic

Regards.
