From: Stanislav Meduna <stano@meduna.org>
Subject: loading pages to memory causes high latency
Date: Fri, 26 Oct 2012 20:00:47 +0200
Message-ID: <508ACFCF.8040001@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:53864 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965545Ab2JZSBH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Oct 2012 14:01:07 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1TRoDE-0000gn-Kk
	for linux-rt-users@vger.kernel.org; Fri, 26 Oct 2012 20:01:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I have an application that absolutely has to meet a 100 ms deadline.
All threads of the application are SCHED_RR ones with priority
that is higher than any other userspace process in the system and
also than the irq handler of the PATA controller.

The command

 sync ; echo 3 > /proc/sys/vm/drop_caches ; cat /var/log/* > /dev/null

which is around 6 MB of data needed to fetch from a CF card:

- immediately causes [sched_delayed] sched: RT throttling activated,
  even if there is _no_ RT application started yet. That means
  that it is probably the irq task itself that is triggering it,
  penalizing all other good-behaving RT tasks

# ps -eLo pid,class,rtprio,comm  | egrep 'RR|FF'
    3 FF       1 ksoftirqd/0
    6 FF      99 posixcputmr/0
   27 FF      22 irq/14-pata_cs5
   32 FF      50 irq/15-ehci_hcd
   33 FF      50 irq/15-ohci_hcd
   34 FF      50 irq/8-rtc0
  417 FF      50 irq/5-eth0
  438 FF      50 irq/15-eth1


- causes the process to block for a time that is much longer
  than I am comfortable with.

The command
  echo 1000000 > /proc/sys/kernel/sched_rt_runtime_us
fixes the problem but is not really something I want
to enable when developing a real-time capable system
that will be running in remote locations. With 980000
I still get negligible latencies. With 970000 I get 4 ms.
With 960000 I get 15 ms latencies. So it is indeed
the throttling that is firing here.

Data with the application running and sched_rt_runtime_us
at 960000:

# head -3 /sys/kernel/debug/tracing/latency_hist/wakeup/CPU0
#Minimum latency: 13 microseconds
#Average latency: 25 microseconds
#Maximum latency: 24011 microseconds

# cat /sys/kernel/debug/tracing/latency_hist/wakeup/max_latency-CPU0
605 25 24011 (0) myApp <- 0 -21 swapper 2802.650022

# cat /sys/kernel/debug/tracing/trace

#
# wakeup_rt latency trace v1.1.5 on 3.4.15-rt24+
# --------------------------------------------------------------------
# latency: 24011 us, #4/4, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: myApp-605 (uid:0 nice:0 policy:2 rt_prio:25)
#    -----------------
#
#                  _------=> CPU#
#                 / _-----=> irqs-off
#                | / _----=> need-resched
#                || / _---=> hardirq/softirq
#                ||| / _--=> preempt-depth
#                |||| / _--=> migrate-disable
#                ||||| /     delay
#  cmd     pid   |||||| time  |   caller
#     \   /      |||||  \   |   /
irq/14-p-27      0d.h3.    1us+:     27: 95:R   + [000]   605: 74:S myApp
irq/14-p-27      0d.h3.    3us!: try_to_wake_up <-wake_up_process
  <idle>-0       0d..3. 24007us+: __schedule <-preempt_schedule
  <idle>-0       0d..3. 24010us :      0:120:R ==> [000]   605: 74:R myApp

The cyclictest or sigwaittest record similar highest numbers.
Setting all of the irq threads to the lower priority does
not matter.

Is this the expected behaviour? Does this point to a problem
in kernel or more likely to a problem in the PATA driver?
The 'd' does not seem right, does it?

Other latencies than wakeup seem to be fine

# head -3 latency_hist/irqsoff/CPU0
#Minimum latency: 0 microseconds
#Average latency: 1 microseconds
#Maximum latency: 77 microseconds

# head -3 latency_hist/preemptirqsoff/CPU0
#Minimum latency: 0 microseconds
#Average latency: 2 microseconds
#Maximum latency: 115 microseconds

#  head -3 latency_hist/preemptoff/CPU0
#Minimum latency: 3 microseconds
#Average latency: 21 microseconds
#Maximum latency: 105 microseconds


Note: I do not have high-precision timers; my board's ACPI
is not recognized and all of the MFGPT  timers on the CS5536
are probably taken by the BIOS. current_clocksource is TSC.
Could this matter?


Geode LX 500 MHz
256 MB RAM, 205 MB free
3.4.15-rt24 + tglx's tiny RCU fix from a week ago
PREEMPT_FULL
e100 network driver
CS5536 companion device which does the PATA (CONFIG_PATA_CS5536)
the CF CARD is detected and used as PIO4
mlockall() for the application
no swap configured

Thanks
-- 
                               Stano
