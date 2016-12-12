From: =?UTF-8?Q?Zsitvai_P=C3=A9ter?= <pervuj.pjotr@gmail.com>
Subject: Cyclictest latencies and deadlocks
Date: Mon, 12 Dec 2016 13:08:22 +0100
Message-ID: <CADMEAP7A7ACq3rVD-5WFufY=xjWHpTEm9PZ-E=S4qr=n=PLgsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35554 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbcLLMIY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Dec 2016 07:08:24 -0500
Received: by mail-wm0-f43.google.com with SMTP id a197so58428397wmd.0
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Dec 2016 04:08:23 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT users,

I've been trying to install the 4.4.32-rt43 kernel but am having
trouble confirming it's working properly.
For the config the only thing I changed was the Preemption Model to
"Fully Preemptible Kernel (RT) (PREEMPT_RT_FULL)" while making sure
high resolution timer support was on, the rest is from an earlier
Ubuntu installation.
It patched and compiled without any issues and was installed simply using make.

To test it I used cyclictest from
https://rt.wiki.kernel.org/index.php/Cyclictest to measure the maximum
latency under 100% load (the load was generated using the pi
calculator from the same bundle).
However the latency not only didn't improve but the stress test also
frequently exited due to deadlocks.

The hardware is:

    Intel(R) Xeon(R) CPU E5-2420 0 @ 1.90GHz
    64GB RAM

And finally an example of pi_stress deadlocking:

    $ ./pi_stress --duration=240 --groups=24
    Starting PI Stress Test
    Number of thread groups: 24
    Duration of test run: 240 seconds
    Number of inversions per group: unlimited
        Admin thread SCHED_FIFO priority 4
    24 groups of 3 threads will be created
        High thread SCHED_FIFO priority 3
        Med thread SCHED_FIFO priority 2
        Low thread SCHED_FIFO priority 1
    Current Inversions: 842971
    WATCHDOG triggered: group 13 is deadlocked!
    reporter stopping due to watchdog event
    Stopping test

If anyone has any insight into what I could be doing wrong I'd greatly
appreciate it.

Regards,
Peter Zsitvai
