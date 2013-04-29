From: Stanislav Meduna <stano@meduna.org>
Subject: What exactly does "hrtimer: interrupt took 7142 ns" mean?
Date: Mon, 29 Apr 2013 09:28:19 +0200
Message-ID: <517E2113.9080806@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:35341 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab3D2H23 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Apr 2013 03:28:29 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1UWiVb-0006tR-Ve
	for linux-rt-users@vger.kernel.org; Mon, 29 Apr 2013 09:28:26 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

what exactly does "hrtimer: interrupt took xxxx ns" tell
me and should I worry? /proc/timer_list shows 18 of these
in 3,5 days and the longest was 10291 ns. The nr_retries
is also pretty high.

>From looking at the code it seems this warning triggers
if a hrtimer interrupt finds more than 3 expired timers
where it has to call their callbacks etc.

Now 7 us is not a long time - the interrupts can surely
be off for longer time etc. Is this normal or is this
something to worry about?

Unfortunately I do not have any machine right now where
the hrtimers work out of the box - one is a Geode LX
system where I have to specify tsc=reliable and the other
one is Celeron M with ICH4 that needs hpet=force.


Timer List Version: v0.6
HRTIMER_MAX_CLOCK_BASES: 3
now at 295909989229679 nsecs

cpu: 0
 clock 0:
  .base:       c04d7f28
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
... 29 of them ...
 clock 1:
  .base:       c04d7f60
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1366924234282954552 nsecs
active timers:
 clock 2:
  .base:       c04d7f98
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
  .expires_next   : 295909989612611 nsecs
  .hres_active    : 1
  .nr_events      : 726912344
  .nr_retries     : 4016215
  .nr_hangs       : 18
  .max_hang_time  : 10291 nsecs
  .nohz_mode      : 0
  .idle_tick      : 0 nsecs
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
jiffies: 295609989

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: hpet
 max_delta_ns:   149983013276
 min_delta_ns:   13409
 mult:           61496111
 shift:          32
 mode:           3
 next_event:     295909989612611 nsecs
 set_next_event: hpet_legacy_next_event
 set_mode:       hpet_legacy_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

Thanks
-- 
                                         Stano
