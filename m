From: Tim Sander <tim@krieglstein.org>
Subject: Re: i.MX28 milliseconds latencies, interrupts disabled in arch_cpu_idle?
Date: Fri, 18 Apr 2014 18:09 +0200
Message-ID: <9645151.cbKImklAq0@hydra>
References: <53503BD8.8000506@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:45168
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869AbaDRQSb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Apr 2014 12:18:31 -0400
In-Reply-To: <53503BD8.8000506@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Stanislav
> Linux nxt 3.12.15-rt25+ #83 PREEMPT RT Thu Apr 17 20:54:00 CEST 2014
> armv5tejl GNU/Linux
> 
> 
> # tracer: irqsoff
> #
> # irqsoff latency trace v1.1.5 on 3.12.15-rt25+
> # --------------------------------------------------------------------
> # latency: 2224 us, #6/6, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
> #    -----------------
> #    | task: swapper-0 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  => started at: rcu_idle_enter
> #  => ended at:   arch_cpu_idle
> #
> #
> #                   _--------=> CPU#
> #                  / _-------=> irqs-off
> #                 | / _------=> need-resched
> #                 || / _-----=> need-resched_lazy
> #                 ||| / _----=> hardirq/softirq
> #                 |||| / _---=> preempt-depth
> #                 ||||| / _--=> preempt-lazy-depth
> #                 |||||| / _-=> migrate-disable
> #                 ||||||| /     delay
> #  cmd     pid    |||||||| time  |   caller
> #     \   /      ||||||||  \   |   /
>   <idle>-0       0d...1..    2us+: rcu_idle_enter
>   <idle>-0       0d...2..   11us+: T.796 <-rcu_idle_enter
>   <idle>-0       0d...2..   17us!: arch_cpu_idle <-cpu_startup_entry
>   <idle>-0       0d...1.. 2219us+: arch_cpu_idle
>   <idle>-0       0d...1.. 2234us+: trace_hardirqs_on <-arch_cpu_idle
>   <idle>-0       0d...1.. 2303us : <stack trace>
>  => arch_cpu_idle
>  => cpu_startup_entry
>  => start_kernel
> 
> Why are interrupts disabled here (and are they really disabled)?
> 
> $ egrep "IDLE|SMP|HZ" .config
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_GENERIC_IDLE_POLL_SETUP=y
> CONFIG_HZ_FIXED=0
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_200 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_500 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> # CONFIG_CPU_IDLE is not set
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> 
> Configuring
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> does not help
> 
> Maybe it is just some tracing infrastructure interference - the effect
> of enabling the tracing is huge on this platform for some reason.
> Just enabling the irqsoff tracing makes the machine unsuitable
> for any serious load.
Are you sure that this is not the cpu idle latency? I patched out the idle 
mechanism on i.mx35 since waking up took much to long for RT usage.
The CPU is running a little hotter then, but after all the thermal envelop 
always has to to cope with maximum load, so i guess this should do no harm 
besides more energy churn.

Best regards
Tim

