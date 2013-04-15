From: Stanislav Meduna <stano@meduna.org>
Subject: Re: hrtimer: interrupt took 6742 ns, then RT throttling and hung
 machine for nearly 2 seconds
Date: Mon, 15 Apr 2013 13:54:01 +0200
Message-ID: <516BEA59.4050303@meduna.org>
References: <516BDE52.90200@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:35728 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab3DOLyK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Apr 2013 07:54:10 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1URhz3-0005G3-BM
	for linux-rt-users@vger.kernel.org; Mon, 15 Apr 2013 13:54:07 +0200
In-Reply-To: <516BDE52.90200@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 15.04.2013 13:02, Stanislav Meduna wrote:

> Apr 15 10:14:57 lnx kernel: [56281.700293] hrtimer: interrupt took 6742 ns

The /proc/timer_list follows. What worries me a bit are the retries -
they are slowly rising (~1 / sec for nr_retries) even if the machine
is basically idle. Is it normal?

The rise only happens if our application is running, but it is
basically the only thing in system that is actively using
the hrtimers, so this does not really say much. Tweaking
the priority of ksoftirqd has no effect.


Timer List Version: v0.6
HRTIMER_MAX_CLOCK_BASES: 3
now at 342575389945882 nsecs

cpu: 0
 clock 0:
  .base:       c04d7f68
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: tick_cpu_sched, tick_sched_timer, S:01
 # expires at 342575390000000-342575390000000 nsecs [in 54118 to 54118
nsecs]
 #1: <cd9bb680>, timerfd_tmrproc, S:01
 # expires at 342575390284003-342575390284003 nsecs [in 338121 to 338121
nsecs]
 #2: <cc6cff48>, hrtimer_wakeup, S:01
 # expires at 342575390421978-342575390421978 nsecs [in 476096 to 476096
nsecs]
... 16 more hrtimer_wakeup follow ...

 clock 1:
  .base:       c04d7fa0
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1365682957275692841 nsecs
active timers:
 clock 2:
  .base:       c04d7fd8
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
  .expires_next   : 342575390284003 nsecs
  .hres_active    : 1
  .nr_events      : 556415337
  .nr_retries     : 1124752
  .nr_hangs       : 1
  .max_hang_time  : 6742 nsecs
  .nohz_mode      : 2
  .idle_tick      : 342575389000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 342275388
  .idle_calls     : 514502119
  .idle_sleeps    : 510841382
  .idle_entrytime : 342575388177611 nsecs
  .idle_waketime  : 342575388177611 nsecs
  .idle_exittime  : 342575388184375 nsecs
  .idle_sleeptime : 301580528758450 nsecs
  .iowait_sleeptime: 21756268924 nsecs
  .last_jiffies   : 342275388
  .next_jiffies   : 342275421
  .idle_expires   : 342575421000000 nsecs
jiffies: 342275390


Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: hpet
 max_delta_ns:   149983013276
 min_delta_ns:   13409
 mult:           61496111
 shift:          32
 mode:           3
 next_event:     342575390284003 nsecs
 set_next_event: hpet_legacy_next_event
 set_mode:       hpet_legacy_set_mode
 event_handler:  hrtimer_interrupt
 retries:        9359


Regards
-- 
                                      Stano

