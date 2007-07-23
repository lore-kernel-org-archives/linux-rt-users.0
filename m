From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Mon, 23 Jul 2007 11:53:57 +0200
Message-ID: <20070723095357.GA886@elte.hu>
References: <469600F7.3060603@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:59087 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbXGWJyI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 05:54:08 -0400
Content-Disposition: inline
In-Reply-To: <469600F7.3060603@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* John Sigler <linux.kernel@free.fr> wrote:

> Here's a /proc/latency_trace dump. What is there to understand?
> 
> # cat /proc/latency_trace
> preemption latency trace v1.1.5 on 2.6.20.7-rt8
> --------------------------------------------------------------------
>  latency: 26 us, #2/2, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
>     -----------------
>     | task: softirq-timer/0-4 (uid:0 nice:0 policy:1 rt_prio:50)
>     -----------------
> 
>                  _------=> CPU#
>                 / _-----=> irqs-off
>                | / _----=> need-resched
>                || / _---=> hardirq/softirq
>                ||| / _--=> preempt-depth
>                |||| /
>                |||||     delay
>    cmd     pid ||||| time  |   caller
>       \   /    |||||   \   |   /
>    <...>-4     0D..1   26us : trace_stop_sched_switched 
> (__sched_text_start)

could you try:

 http://redhat.com/~mingo/latency-tracing-patches/trace-it.c

and run it like this:

 ./trace-it 1 > trace.txt

does it produce lots of trace entries? If not then 
CONFIG_FUNCTION_TRACING is not enabled. Once you see lots of output in 
the file, the tracer is up and running and you can start tracing the 
latency in your app.

your above wakeup-tracing output suggests that your app is probably not 
delayed by scheduling latencies, but by some other, higher-level 
latencies.

To track it down, use the method that trace-it.c uses to start/stop 
tracing, i.e. put the prctl(0,1); / prctl(0,0); calls into your app to 
start/stop tracing and the kernel will do the rest once you've set 
/proc/sys/kernel/preempt_max_latency back to 0: /proc/latency_trace will 
always contain the longest latency that your app triggered, of the 
critical path you programmed into it.

also check the cyclictest source of how to do app-driven latency 
tracing. (And please post any latency traces to this list, we might be 
able to pinpoint the source of the latencies.)

	Ingo
