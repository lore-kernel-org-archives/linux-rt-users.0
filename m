From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: imx25: maximum latency increased on some tests
Date: Thu, 9 Aug 2012 09:21:43 -0700
Message-ID: <F0013F69-60D4-4B6F-88DC-AF6ECB851A40@thebigcorporation.com>
References: <5023901E.5090009@evidence.eu.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org,
	Alessandro Biasci <a.biasci@evidence.eu.com>
To: Claudio Scordino <claudio@evidence.eu.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34219 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab2HIQVu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Aug 2012 12:21:50 -0400
Received: by pbbrr13 with SMTP id rr13so1126850pbb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Aug 2012 09:21:50 -0700 (PDT)
In-Reply-To: <5023901E.5090009@evidence.eu.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Aug 9, 2012, at 3:25 AM, Claudio Scordino <claudio@evidence.eu.com> wrote:
> 
> 
> PI_STRESS:
> 
> Finally, the pi_stress (priority-inheritance code paths for POSIX mutexes) sometimes fails with preempt_rt on the SCHED_FIFO policy (this behavior did not occurred without preempt_rt, even if it is still possible):
> 
>    $ pi_stress --duration 100 --groups=2
>    Starting PI Stress Test
>    Number of thread groups: 2
>    Duration of test run: 100 seconds
>    Number of inversions per group: unlimited
>    Test threads using scheduler policy: SCHED_FIFO
>            Admin thread priority:  4
>    2 groups of 3 threads will be created
>            High thread priority:   3
>            Med  thread priority:   2
>            Low thread priority:    1
>    Current Inversions: 2531
>    ERROR: WATCHDOG triggered: group 0 is deadlocked!
>    ERROR: reporter stopping due to watchdog event
>    Stopping test
>    Terminated


This possibly related to the test implementation.

In the past there were similar issues in LTP, where a supervisor thread is polling for a signal our completion of another thread that never arrives because the supervisor thread is hogging the CPU (FIFO thread ) and either the other threads never run, or the signal is not being delivered.

In RT it is correct behavior that a CPU-bound thread should preempt other threads and signals.

IIRC there are several ways to correct this, by also raising the prio of softirqd, or by fixing the implementation of the test.

If you could provide a link to the test source, this would be helpful.

First and foremost however, do follow Carsten's recommendation about setting the prio appropriately high.

Thanks

Sven