From: Gratian Crisan <gratian.crisan@ni.com>
Subject: Re: 3.14-rt ARM performance regression?
Date: Mon, 26 Jan 2015 16:28:41 -0600
Message-ID: <OFEDF92BBB.7C284992-ON86257DD9.00772BF2-86257DD9.007B7A04@ni.com>
References: <20150124020341.GA2861@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Cartwright <joshc@ni.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:58934 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753818AbbAZW2y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Jan 2015 17:28:54 -0500
In-Reply-To: <20150124020341.GA2861@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To add to Josh's post I have posted some of the data captured during the 
investigation at: https://github.com/gratian/tests

More details available in-line below.

linux-rt-users-owner@vger.kernel.org wrote on 01/23/2015 08:03:41 PM:
> Subject: 3.14-rt ARM performance regression?
> 
> Hey folks-
> 
> We've recently undertaken an upgrade of our kernel from 3.2-rt to
> 3.14-rt, and have run into a performance regression on our ARM boards.
> We're still in the process of trying to isolate what we can, but
> hopefully someone's already run into this and has a solution or might
> have some useful debugging ideas.
> 
<snip>
> We suspected something was up with time accounting, as since 3.2, 
> Zynq gained a
> clock driver, and shifted to using the arm_global_timer driver as it's
> clocksource.  We've compared register dumps of the clocks, cache, and 
timers
> between kernels, and the hardware appears to be configured the same.

The register dumps from the 3.2-rt and 3.14-rt kernel runs are available 
at: https://github.com/gratian/tests/tree/master/register-dumps
In order to make sense of it you will need the Xilinx, Zynq-7000 technical 
reference manual available at: 
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

> It also
> seems that the runtimes of identical code paths appear to run slower in
> 3.14-rt, as observed by the function tracer and the local ftrace clock; 
we're
> looking to better characterize this.
> 
> We did, however, construct a test to validate via an external clock that
> clock_nanosleep() was sleeping for as long as it says it was by toggling 
a
> GPIO, sleeping for a small period of time, and toggling again, and 
validating
> via a scope that the duration matched.

Test and results available at: 
https://github.com/gratian/tests/tree/master/clock-validation
 
> The toolchain is the same for both kernels (gcc 4.7.2).
> 
> We also brought up 3.14-rt on a BeagleBone Black (also ARM) and compared 
it's
> performance to a 3.8-rt build (bringing up 3.2-rt would require a bit 
more
> effort).  We observed a ~30% degradation on this platform as well.
> 
> If anyone has any ideas, please let us know!  Otherwise, we'll follow up 
with
> anything else we discover.
> 

One of the investigation paths we took is profiling hrtimer_interrupt().

In order to provide a load a simple timer stress test was used: 
https://github.com/gratian/tests/blob/master/timer-stress/timer-stress.c
that in essence starts a large number of non-RT threads that are doing 
clock_nanosleep() calls with a random interval of up to 1ms.

Plotting the CPU cycle counts for hrtimer_interrupt() in 3.14-rt vs. 
3.2-rt appears to show a slowdown of ~12us.
See screenshots under: 
https://github.com/gratian/tests/tree/master/hrtimer_interrupt-profiling

Digging deeper the worst offender when the max is reached seems to be one 
of the callbacks invoked from hrtimer_interrupt.
More specifically the code path seems to be 
hrtimer_interrupt()->tick_sched_timer()->tick_sched_handle()->update_process_times().
I am still profiling this code path trying to pinpoint the source of the 
3.14-rt slowdown in update_process_times().

Ideas/suggestions welcomed.

Thanks,
        Gratian

