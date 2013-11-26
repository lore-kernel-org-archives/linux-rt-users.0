From: Stefan Roese <stefan.roese@gmail.com>
Subject: cyclictest better values with system load than without (OMAP3530
 target)
Date: Tue, 26 Nov 2013 10:21:34 +0100
Message-ID: <5294681E.10406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:55718 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab3KZJVi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Nov 2013 04:21:38 -0500
Received: from [10.0.0.152] (pD9FF8EF0.dip0.t-ipconnect.de [217.255.142.240])
	by smtp.strato.de (RZmta 32.16 DYNA|AUTH)
	with ESMTPA id J059depAQ9LZq3m for <linux-rt-users@vger.kernel.org>;
	Tue, 26 Nov 2013 10:21:35 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

I'm running cylictest on a OMAP3530 target board and am a bit
astonished about the results. Especially that the latency values
are better on a system with system load (hackbench) than on one
without system load. Here the values I get:

With system load (hackbench):
-----------------------------
# ./cyclictest -l 10000 -i 1000 -n -p 80 -q
# /dev/cpu_dma_latency set to 0us
T: 0 ( 1853) P:80 I:1000 C:  10000 Min:     36 Act:  156 Avg:  154 Max:
    244

Idle system:
------------
# ./cyclictest -l 10000 -i 1000 -n -p 80 -q
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2332) P:80 I:1000 C:  10000 Min:     81 Act:  530 Avg:  484 Max:
    602


Some details to my test/system setup:
- Linux v3.8.13
- preempt-rt patch 3.8.13-rt14
- HW: TI OMAP3530 CM_T35 board
- Latest cyclictest from rt-tests git repository


I might have misconfigured the system. So here some extracts from
my .config:

...
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
...
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_IDLE is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
...
CONFIG_PREEMPT_RT_FULL=y
...

With CONFIG_NO_HZ disabled I get slightly better results:

With system load (hackbench):
-----------------------------
# ./cyclictest -l 10000 -i 1000 -n -p 80 -q
# /dev/cpu_dma_latency set to 0us
T: 0 ( 1840) P:80 I:1000 C:  10000 Min:     30 Act:  153 Avg:  154 Max:
    238

Idle system:
-------------
# ./cyclictest -l 10000 -i 1000 -n -p 80 -q
# /dev/cpu_dma_latency set to 0us
T: 0 ( 1371) P:80 I:1000 C:  10000 Min:     40 Act:  465 Avg:  435 Max:
    502


Any ideas/explanations are really appreciated.

Thanks,
Stefan
