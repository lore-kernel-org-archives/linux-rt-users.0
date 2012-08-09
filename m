From: Claudio Scordino <claudio@evidence.eu.com>
Subject: imx25: maximum latency increased on some tests
Date: Thu, 09 Aug 2012 12:25:34 +0200
Message-ID: <5023901E.5090009@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alessandro Biasci <a.biasci@evidence.eu.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bishop.asidev.net ([95.141.38.214]:56004 "EHLO
	bishop.asidev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757869Ab2HIKdL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Aug 2012 06:33:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by bishop.asidev.net (Postfix) with ESMTP id 35E04C10B4
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Aug 2012 12:25:39 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear all.

We have an embedded board based on Freescale imx25 (ARM9 at 400 MHz) 
with 64MB RAM and Linux 2.6.31 provided by Freescale.

We have ported PREEMPT_RT-21 and made some measurements using the 
rt-tests suite (cloned from the official repo at 
git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git).

Summing up, our reference software is

	Architecture: imx25
	Kernel: 2.6.31 provided by Freescale
	Preempt_Rt patch: rt21
	TestSuite: rt-tests V0.84


The cyclictest showed a reduction of the maximum latency, as we were 
expecting.

However, the other tests showed a maximum latency higher than without 
the patch (which is supposed to reduce the maximum latency).

Please, find below the results that we have obtained.

We know that this version of preempt_rt is outdated. However, we can't 
figure out how the maximum latency can be higher.

Do you have any idea about the possible reason of this behavior ?

Many thanks,

	Claudio and Alessandro



SIGNALTEST:

Without preempt_rt:

     $ signaltest -l 10000 -t 4
     0.40 0.92 0.58 1/35 2199
     T: 0 ( 2196) P: 0 C:  10000 Min:    157 Act:  184 Avg:  219 Max: 
  1246

With preempt_rt:

     $ signaltest -l 10000 -t 4
     0.03 2.87 6.53 3/62 2684
     T: 0 ( 2681) P: 0 C:  10000 Min:    215 Act:  260 Avg:  384 Max: 
  2038


SIGWAITTEST:

Without preempt_rt:

     $ sigwaittest -l 10000 -t 2
     #0: ID2201, P0, CPU0, I1000; #1: ID2202, P0, CPU0, Cycles 10000
     #2: ID2203, P0, CPU0, I1500; #3: ID2204, P0, CPU0, Cycles 7019
     #1 -> #0, Min   40, Cur   58, Avg   71, Max 1191
     #3 -> #2, Min   42, Cur   61, Avg   69, Max  954

With preempt_rt:

     $ sigwaittest -l 10000 -t 2
     #0: ID2687, P0, CPU0, I1000; #1: ID2688, P0, CPU0, Cycles 10000
     #2: ID2689, P0, CPU0, I1500; #3: ID2690, P0, CPU0, Cycles 7007
     #1 -> #0, Min   51, Cur   63, Avg  105, Max 1379
     #3 -> #2, Min   57, Cur   63, Avg  105, Max 2081



SVSEMATEST:

Without preempt_rt:

     $ svsematest -l 10000 -t 2
     #0: ID2206, P0, CPU0, I1000; #1: ID2207, P0, CPU0, Cycles 10000
     #2: ID2208, P0, CPU0, I1500; #3: ID2209, P0, CPU0, Cycles 7094
     #1 -> #0, Min   17, Cur   34, Avg   37, Max  940
     #3 -> #2, Min   18, Cur   32, Avg   34, Max  809

With preempt_rt:

     $ svsematest -l 10000 -t 2
     #0: ID2703, P0, CPU0, I1000; #1: ID2704, P0, CPU0, Cycles 10000
     #2: ID2705, P0, CPU0, I1500; #3: ID2706, P0, CPU0, Cycles 6858
     #1 -> #0, Min   29, Cur   47, Avg   65, Max 1423
     #3 -> #2, Min   30, Cur   91, Avg   83, Max 1314



PI_STRESS:

Finally, the pi_stress (priority-inheritance code paths for POSIX 
mutexes) sometimes fails with preempt_rt on the SCHED_FIFO policy (this 
behavior did not occurred without preempt_rt, even if it is still possible):

     $ pi_stress --duration 100 --groups=2
     Starting PI Stress Test
     Number of thread groups: 2
     Duration of test run: 100 seconds
     Number of inversions per group: unlimited
     Test threads using scheduler policy: SCHED_FIFO
             Admin thread priority:  4
     2 groups of 3 threads will be created
             High thread priority:   3
             Med  thread priority:   2
             Low thread priority:    1
     Current Inversions: 2531
     ERROR: WATCHDOG triggered: group 0 is deadlocked!
     ERROR: reporter stopping due to watchdog event
     Stopping test
     Terminated


