From: Stanislav Meduna <stano@meduna.org>
Subject: Highres timers broken on i.mx28 for CONFIG_HZ_PERIODIC
Date: Tue, 11 Nov 2014 01:55:37 +0100
Message-ID: <54615E89.7020902@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

something between 3.12.19(-rt30) and 3.12.31(-rt45) broke
hrtimers on (at least) i.MX28 for CONFIG_HZ_PERIODIC.
Switching to CONFIG_NO_HZ_IDLE restores them.

Is this the expected behaviour or a regression?


The difference in the /proc/timer_list is the
Tick Device: mode:     0 (new) or 1 (old)

# cat /proc/timer_list

Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 3551448891259 nsecs

cpu: 0
 clock 0:
  .base:       c03694e0
  .index:      0
  .resolution: 4000000 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
...
 clock 1:
  .base:       c0369520
  .index:      1
  .resolution: 4000000 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       c0369560
  .index:      2
  .resolution: 4000000 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c03695a0
  .index:      3
  .resolution: 4000000 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 0
  .last_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 0 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 0 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 812862

Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: mxs_timrot
 max_delta_ns:   178956969028
 min_delta_ns:   1000
 mult:           51539608
 shift:          31
 mode:           3
 next_event:     3551452000000 nsecs
 set_next_event: timrotv2_set_next_event
 set_mode:       mxs_set_mode
 event_handler:  tick_handle_periodic
 retries:        0


In the 3.2.19 it was
Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 280235727915168 nsecs

cpu: 0
 clock 0:
  .base:       c03654c0
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
...
 clock 1:
  .base:       c0365500
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1415385038639056250 nsecs
active timers:
 clock 2:
  .base:       c0365540
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       c0365580
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     1415385038639056250 nsecs
active timers:
  .expires_next   : 280235730396263 nsecs
  .hres_active    : 1
  .nr_events      : 207916570
  .nr_retries     : 2164032
  .nr_hangs       : 7
  .max_hang_time  : 107499 nsecs
  .nohz_mode      : 0
  .last_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 0 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 0 nsecs
  .iowait_sleeptime: 0 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 69983932

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: mxs_timrot
 max_delta_ns:   178956969028
 min_delta_ns:   1000
 mult:           51539608
 shift:          31
 mode:           3
 next_event:     280235730396263 nsecs
 set_next_event: timrotv2_set_next_event
 set_mode:       mxs_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0


Thanks
-- 
                                 Stano
