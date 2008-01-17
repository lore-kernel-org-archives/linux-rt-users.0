From: "Mark Knecht" <markknecht@gmail.com>
Subject: Would like to run better stress test.
Date: Thu, 17 Jan 2008 15:53:19 -0800
Message-ID: <5bdc1c8b0801171553g4f19b844gb29cff10d905a3b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:30264 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961AbYAQXxV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jan 2008 18:53:21 -0500
Received: by nz-out-0506.google.com with SMTP id s18so688180nze.1
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Jan 2008 15:53:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
   I'd like to learn how to take better test data on the real-time
kernel. I think that I've correctly correctly enabled everything
that's called for on this page:


lightning rt-tests # dmesg | grep Ingo
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
lightning rt-tests #

lightning linux # cat .config | grep CONFIG_PREEMPT_RT
CONFIG_PREEMPT_RT=y
lightning linux # cat .config | grep CONFIG_WAKEUP_TIMING
CONFIG_WAKEUP_TIMING=y
lightning linux # cat .config | grep CONFIG_LATENCY_TRACE
CONFIG_LATENCY_TRACE=y
lightning linux # cat .config | grep CONFIG_CRITICAL_PREEMPT_TIMING
CONFIG_CRITICAL_PREEMPT_TIMING=y
lightning linux # cat .config | grep CONFIG_CRITICAL_IRQSOFF_TIMING
CONFIG_CRITICAL_IRQSOFF_TIMING=y
lightning linux #


If I run cyclictest from the command like I get results like this with
no load on the machine:

lightning rt-tests # ./cyclictest -p 80 -t 5 -n -l 50000
1.46 0.67 0.43 5/115 6770

T: 0 ( 6744) P:80 I:1000 C:  50000 Min:      3 Act:    8 Avg:    6 Max:      25
T: 1 ( 6745) P:79 I:1500 C:  33340 Min:      3 Act:    7 Avg:    5 Max:      18
T: 2 ( 6746) P:78 I:2000 C:  25005 Min:      3 Act:   10 Avg:    5 Max:      14
T: 3 ( 6747) P:77 I:2500 C:  20004 Min:      3 Act:   10 Avg:    5 Max:      17
T: 4 ( 6748) P:76 I:3000 C:  16670 Min:      3 Act:    7 Avg:    4 Max:      14
lightning rt-tests #

What now? How do I put a good load on the machine?

I found source code for hackbench but no instructions for someone at
my level to build it. I tried pi_stress but it hung my machine.

Open to any simple ways to give better info.

Thanks,
Mark
