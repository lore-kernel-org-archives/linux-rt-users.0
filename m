From: Matthias Meier <matthias.j.meier@gmx.net>
Subject: Long max latencies on Wandbaord / Freescale i.MX6
Date: Sat, 26 Sep 2015 11:38:02 +0200
Message-ID: <5606677A.1020705@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:56247 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbbIZJiG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 26 Sep 2015 05:38:06 -0400
Received: from localhost.localdomain ([213.188.224.136]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0LbR3e-1aPWrY3XkQ-00kvpl for
 <linux-rt-users@vger.kernel.org>; Sat, 26 Sep 2015 11:38:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

using cyclictest I measure long max latencies of >10ms on a Wandboard 
dual (Freescale i.MX6 dual Cortex-A9 SoC).

The latency problem happens with diffent scenarios:
- without or with rt-patch  (4.1.7-rt8 w. CONFIG_PREEMPT_RT_FULL)
- different Kernels (3.17, 4.1, 4.2 w. CONFIG_PREEMPT__LL)
- different CPU governors including 'performance'
- independant of CPU load
- even with no other userspace processes but init, the login sh and 
cyclictest (I use a minimal builroot rfs).
- independant of cyclictest prio

Using the same buildroot rfs on a A20 SoC (bananapro) with 4.1.7-rt8 
shows acceptable rt-latencies of ~ 200us.

Ftracing 'irqsoff' on the rt-patched 4.1 kernel shows always long 
latency after 'raw_spin_lock_irq' (see log below).

Do you think it is a driver which stalls or hrtimer not working 
correctly on this SoC or someting else?
If it is a driver, how could I find out which it is?

Thanks
Matthias

------------------------------------------

Test log with 4.1.7-rt8 kernel and no additional load:

# cyclictest --smp -p98 -m
# /dev/cpu_dma_latency sepolicy: fifo: loadavg: 3.66 3.87 3.61 4/87 580
WARN: Running on unknown kernel version...YMMV
T: 0 (  572) P:98 I:1000 C:1225776 Min:     52 Act:  317 Avg:  393 
Max:    6161
T: 1 (  573) P:98 I:1500 C: 816449 Min:     64 Act:  143 Avg:  381 
Max:    4567


# cat trace
# tracer: irqsoff
#
# irqsoff latency trace v1.1.5 on 4.1.7-rt8-wb+
# --------------------------------------------------------------------
# latency: 4062 us, #7/7, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:2)
#    -----------------
#    | task: cyclictest-338 (uid:0 nice:0 policy:1 rt_prio:95)
#    -----------------
#  => started at: _raw_spin_lock_irq
#  => ended at:   _raw_spin_unlock_irq
#
#
#                   _--------=> CPU#
#                  / _-------=> irqs-off
#                 | / _------=> need-resched
#                 || / _-----=> need-resched_lazy
#                 ||| / _----=> hardirq/softirq
#                 |||| / _---=> preempt-depth
#                 ||||| / _--=> preempt-lazy-depth
#                 |||||| / _-=> migrate-disable
#                 ||||||| /     delay
#  cmd     pid    |||||||| time  |   caller
#     \   /      ||||||||  \   |   /
       sh-156     0dn..111    1us#: trace_hardirqs_off <-_raw_spin_lock_irq
cyclicte-338     0d...3.. 4052us : finish_task_switch <-__schedule
cyclicte-338     0d...3.. 4057us : _raw_spin_unlock_irq <-finish_task_switch
cyclicte-338     0d...3.. 4059us : do_raw_spin_unlock <-_raw_spin_unlock_irq
cyclicte-338     0d...2.. 4061us : trace_hardirqs_on <-_raw_spin_unlock_irq
cyclicte-338     0d...2.. 4066us+: time_hardirqs_on <-_raw_spin_unlock_irq
cyclicte-338     0d...2.. 4080us : <stack trace>
  => trace_hardirqs_on
  => _raw_spin_unlock_irq
  => finish_task_switch
  => __schedule
  => schedule
  => do_nanosleep
  => __hrtimer_nanosleep
  => hrtimer_nanosleep
  => common_nsleep
  => SyS_clock_nanosleep
  => ret_fast_syscall
#

