From: John Sigler <linux.kernel@free.fr>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 16:35:03 +0200
Message-ID: <46A75F97.8000103@free.fr>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu>	 <46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu>	 <46A5B8E3.4060004@free.fr> <46A74A58.1070704@free.fr>	 <20070725130536.GA12334@elte.hu> <46A74E05.50504@free.fr>	 <20070725133835.GA17616@elte.hu>  <46A758B5.9070602@free.fr> <1185372808.23485.2.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:41022 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbXGYOfG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 10:35:06 -0400
In-Reply-To: <1185372808.23485.2.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Alessio Igor Bogani wrote:

> John Sigler wrote:
> 
>> # cat /proc/interrupts
>>             CPU0
>>    0:         37    XT-PIC-XT        timer
> 
> Just curious: Can you post the output of the "cat /proc/timer_list" ?

Kernel command line: [...] lpj=12667000 lapic nmi_watchdog=0 idle=halt

Kernel configuration:
http://linux.kernel.free.fr/latency/config-2.6.20.7-rt8-adlink-latency

# cat /proc/timer_list
Timer List Version: v0.3
HRTIMER_MAX_CLOCK_BASES: 2
now at 3759145433320 nsecs

cpu: 0
  clock 0:
   .index:      0
   .resolution: 1 nsecs
   .get_time:   ktime_get_real
   .offset:     1185370134437814624 nsecs
active timers:
  clock 1:
   .index:      1
   .resolution: 1 nsecs
   .get_time:   ktime_get
   .offset:     0 nsecs
active timers:
  #0: <cf795e74>, tick_sched_timer, S:01
  # expires at 3759150000000 nsecs [in 4566680 nsecs]
  #1: <cf795e74>, it_real_fn, S:01
  # expires at 5027741374801 nsecs [in 1268595941481 nsecs]
   .expires_next   : 3759150000000 nsecs
   .hres_active    : 1
   .nr_events      : 375503
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
jiffies: 345914


Tick Device: mode:     1
Clock Event Device: pit
  max_delta_ns:   27461866
  min_delta_ns:   12571
  mult:           5124677
  shift:          32
  mode:           3
  next_event:     9223372036854775807 nsecs
  set_next_event: pit_next_event
  set_mode:       init_pit_timer
  event_handler:  tick_handle_oneshot_broadcast
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000


Tick Device: mode:     1
Clock Event Device: lapic
  max_delta_ns:   1006582530
  min_delta_ns:   1799
  mult:           35793183
  shift:          32
  mode:           3
  next_event:     3759150000000 nsecs
  set_next_event: lapic_next_event
  set_mode:       lapic_timer_setup
  event_handler:  hrtimer_interrupt
