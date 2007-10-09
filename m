From: Dragan Noveski <perodog@gmx.net>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 09 Oct 2007 17:59:43 +0200
Message-ID: <470BA56F.9090509@gmx.net>
References: <470B44A1.7080007@free.fr> <1191921343.13628.0.camel@godzilla.tecnorama.it> <470B49BD.4070506@free.fr> <alpine.LFD.0.9999.0710091131400.25146@localhost.localdomain> <470B5971.40601@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754649AbXJIQA1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 12:00:27 -0400
In-Reply-To: <470B5971.40601@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

John Sigler wrote:
> Thomas Gleixner wrote:
>> On Tue, 9 Oct 2007, John Sigler wrote:
>>> Alessio Igor Bogani wrote:
>>>> On Tue, 2007-10-09 at 11:06 +0200, John Sigler wrote:
>>>>
>>>>> I enabled high resolution timer support and disabled ACPI support.
>>>>
>>>> http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00375.html 
>>>>
>>>
>>> There are other clock sources on my system.
>>> The timestamp counter is reliable (as far as I can tell).
>>
>> See previous mail.
>>
>>> The LAPIC timer is reliable.
>>
>> LAPIC timer is a clock event device, not a clock source. It can be
>> used to program the next event, but not to read the time.
>>
>>> (I've just disabled the PM timer.)
>>
>> Yup, which in turn disables highres.
>
> OK. I have two more questions.
>
> Can the kernel verify the correctness of the TSC with the PIT?
>
> When I enable the ACPI PM timer, the kernel tells me:
>
> * The chipset may have PM-Timer Bug. Due to workarounds for a bug,
> * this clock source is slow. If you are sure your timer does not have
> * this bug, please use "acpi_pm_good" to disable the workaround
>
> How can I tell whether my PM timer has this bug or not?
> (Specific revision? Test app?)
>
> Regards.
>
hallo, i am using the 2.6.22.1-rt9 kernel too, and it runs pretty good 
for me, but following this thread i got very unsure, if the hrtimer is 
being used here.
please, i would really appreciate if someone of you could make a 
'diagnosis' of the issue.

murija2:/home/nowhiskey# cat 
/sys/devices/system/clocksource/clocksource0/available_clocksource
tsc hpet acpi_pm pit jiffies
murija2:/home/nowhiskey# cat 
/sys/devices/system/clocksource/clocksource0/                     
available_clocksource  current_clocksource   
murija2:/home/nowhiskey# cat 
/sys/devices/system/clocksource/clocksource0/current_clocksource
tsc
murija2:/home/nowhiskey# cat /proc/timer_list
Timer List Version: v0.3
HRTIMER_MAX_CLOCK_BASES: 2
now at 279500939467 nsecs

cpu: 0
 clock 0:
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1191944919927389648 nsecs
active timers:
 clock 1:
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <d7697f04>, tick_sched_timer, S:01
 # expires at 279501000000 nsecs [in 60533 nsecs]
 #1: <d7697f04>, it_real_fn, S:01
 # expires at 279519610937 nsecs [in 18671470 nsecs]
 #2: <d7697f04>, hrtimer_wakeup, S:01
 # expires at 279911555013 nsecs [in 410615546 nsecs]
 #3: <d7697f04>, hrtimer_wakeup, S:01
 # expires at 285349267955 nsecs [in 5848328488 nsecs]
 #4: <d7697f04>, it_real_fn, S:01
 # expires at 292823897860 nsecs [in 13322958393 nsecs]
 #5: <d7697f04>, hrtimer_wakeup, S:01
 # expires at 307102248124 nsecs [in 27601308657 nsecs]
 #6: <d7697f04>, hrtimer_wakeup, S:01
 # expires at 307167956204 nsecs [in 27667016737 nsecs]
  .expires_next   : 279501000000 nsecs
  .hres_active    : 1
  .nr_events      : 43411
  .nohz_mode      : 2
  .idle_tick      : 279482000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294946777
  .idle_calls     : 33246
  .idle_sleeps    : 27192
  .idle_entrytime : 279481048513 nsecs
  .idle_sleeptime : 248235489890 nsecs
  .last_jiffies   : 4294946777
  .next_jiffies   : 4294946817
  .idle_expires   : 279521000000 nsecs
jiffies: 4294946796


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
Clock Event Device: hpet
 max_delta_ns:   2147483647
 min_delta_ns:   3352
 mult:           61496110
 shift:          32
 mode:           3
 next_event:     279502000000 nsecs
 set_next_event: hpet_legacy_next_event
 set_mode:       hpet_legacy_set_mode
 event_handler:  hrtimer_interrupt
