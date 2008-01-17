From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: 2.6.24-rc8-rt1
Date: Thu, 17 Jan 2008 22:11:49 +0100
Message-ID: <20080117211149.GQ27137@pengutronix.de>
References: <1200544050.318.18.camel@localhost.localdomain> <478F2A46.5070506@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:58793 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754204AbYAQVMQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jan 2008 16:12:16 -0500
Content-Disposition: inline
In-Reply-To: <478F2A46.5070506@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 17, 2008 at 11:13:26AM +0100, Wolfgang Grandegger wrote:
>   # ./cyclictest -n -p80 -i1000 -b400
>
> [...]
>
> Well, I'm not sure if this is the correct way to do it. Is there some
> doc on how to use the latency tracer and interpret the results?

Could you put in this kind of log information inline next time? It makes
it easier to review.

Let's see ...

> preemption latency trace v1.1.5 on 2.6.24-rc8-rt1
> --------------------------------------------------------------------
>  latency: 39733427 us, #65536/1202801, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
>     -----------------
>     | task: cyclictest-914 (uid:0 nice:0 policy:1 rt_prio:80)
>     -----------------

Ok, so cyclictest-914 triggered the tracer. No big surprise at -t 1 :-)

> cyclicte-914   0D..1   40us+: enqueue_hrtimer+0x50/0x1a0 (   89 5aa9862 c3a6dea8)

cyclictest-914 goes to sleep for next period. We expect it to wake up
again at 40 us + 1000 us = 1040 us.

>       ls-1032  0DNh2  999us+: __trace_start_sched_wakeup+0x154/0x18c <cyclicte-914> (19 -1)
>       ls-1032  0DNh2 1001us+: try_to_wake_up+0x194/0x1b4 <cyclicte-914> (180 0)
>       ls-1032  0DNh. 1008us+: clockevents_program_event+0x84/0x1c0 (   89 5ad6bbf 18e8e)
> cyclicte-914   0D..2 1033us+: __schedule+0x21c/0x444 <ls-1032> (0 180)
> cyclicte-914   0D..1 1071us+: enqueue_hrtimer+0x50/0x1a0 (   89 5b9daa2 c3a6dea8)

Looks good, it happened. Next wakeup at about 1071 us + 1000 us = 2071
us.

> cyclicte-914   0D..2 2031us+: __schedule+0x21c/0x444 <IRQ-129-682> (150 180)
> cyclicte-914   0D..1 2072us+: enqueue_hrtimer+0x50/0x1a0 (   89 5c91ce2 c3a6dea8)

Bingo. Let's get a cup of coffee in the meantime ...

> cyclicte-914   0D..1 1905066us+: enqueue_hrtimer+0x50/0x1a0 (   91 66210 c3a6dea8)

Expected arival at 1905066 us + 1000 us = 1906066 us.

>       ls-1048  0DNh3 1906017us+: __trace_start_sched_wakeup+0x154/0x18c <cyclicte-914> (19 -1)
>       ls-1048  0DNh3 1906021us : __trace_start_sched_wakeup+0x154/0x18c <cyclicte-914> (19 -1)
>       ls-1048  0DNh3 1906023us+: try_to_wake_up+0x194/0x1b4 <cyclicte-914> (180 0)

It's trying hard to wake up ...

>       ls-1048  0DNh1 1906028us!: clockevents_program_event+0x84/0x1c0 (   91 391676 367eff)
>       ls-1048  0DNh2 1906274us+: activate_task+0x60/0xa4 <IRQ-193-681> (150 6)

Between these it should have happened.

>       ls-1048  0DNh2 1906285us+: __trace_start_sched_wakeup+0x154/0x18c <IRQ-193-681> (49 -1)
>       ls-1048  0DNh2 1906293us+: __trace_start_sched_wakeup+0x154/0x18c <IRQ-193-681> (49 -1)
>       ls-1048  0DNh2 1906295us+: try_to_wake_up+0x194/0x1b4 <IRQ-193-681> (150 0)
> cyclicte-914   0D..2 1906332us : __schedule+0x21c/0x444 <ls-1048> (0 180)

What is this IRQ-193-681? Can you post your /proc/interrupts and the
output of

	ps axHo user,pid,%cpu,%mem,nice,rtprio,policy,tty,stat,start_time,bsdtime,args

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
