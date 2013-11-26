From: Dmitry Lysenko <dvl36.ripe.nick@gmail.com>
Subject: Re: cyclictest better values with system load than without (OMAP3530 target)
Date: Tue, 26 Nov 2013 16:21:34 +0200
Message-ID: <CAMjaK3Ay7yeDN_kbJ+oQFnD0GCwy-67zP9SrvazofCqbwUCWtw@mail.gmail.com>
References: <5294681E.10406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Stefan Roese <stefan.roese@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:64353 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887Ab3KZOVf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Nov 2013 09:21:35 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so8030023pbc.6
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Nov 2013 06:21:35 -0800 (PST)
In-Reply-To: <5294681E.10406@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

On Marvell Kirkwood at 1.2Ghz and 3.2.51-rt72 kernel I have slightly
better results:

--- with hackbench:

root@debian:~/rt-tests# ./cyclictest -l 10000 -i 1000 -n -p 80 -q
T: 0 (10268) P:80 I:1000 C:  10000 Min:     16 Act:   29 Avg:   29 Max:      46

--- w/o hackbench:

root@debian:~/rt-tests# ./cyclictest -l 10000 -i 1000 -n -p 80 -q
T: 0 (12686) P:80 I:1000 C:  10000 Min:      5 Act:    6 Avg:    6 Max:      22

-- .config:
CONFIG_TICK_ONESHOT=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

# CONFIG_CPU_IDLE is not set

Try to play with:

# CONFIG_PM_RUNTIME is not set
# CONFIG_ARM_CPU_SUSPEND is not set

Best wishes,
 Dmitry.

2013/11/26 Stefan Roese <stefan.roese@gmail.com>
>
> Hi!
>
> I'm running cylictest on a OMAP3530 target board and am a bit
> astonished about the results. Especially that the latency values
> are better on a system with system load (hackbench) than on one
> without system load. Here the values I get:
>
> With system load (hackbench):
> -----------------------------
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1853) P:80 I:1000 C:  10000 Min:     36 Act:  156 Avg:  154 Max:
>     244
>
> Idle system:
> ------------
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2332) P:80 I:1000 C:  10000 Min:     81 Act:  530 Avg:  484 Max:
>     602
>
>
> Some details to my test/system setup:
> - Linux v3.8.13
> - preempt-rt patch 3.8.13-rt14
> - HW: TI OMAP3530 CM_T35 board
> - Latest cyclictest from rt-tests git repository
>
>
> I might have misconfigured the system. So here some extracts from
> my .config:
>
> ...
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> ...
> # CONFIG_CPU_FREQ is not set
> # CONFIG_CPU_IDLE is not set
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> ...
> CONFIG_PREEMPT_RT_FULL=y
> ...
>
> With CONFIG_NO_HZ disabled I get slightly better results:
>
> With system load (hackbench):
> -----------------------------
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1840) P:80 I:1000 C:  10000 Min:     30 Act:  153 Avg:  154 Max:
>     238
>
> Idle system:
> -------------
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1371) P:80 I:1000 C:  10000 Min:     40 Act:  465 Avg:  435 Max:
>     502
>
>
> Any ideas/explanations are really appreciated.
>
> Thanks,
> Stefan
