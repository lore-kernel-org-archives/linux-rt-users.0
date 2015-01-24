From: Josh Cartwright <joshc@ni.com>
Subject: 3.14-rt ARM performance regression?
Date: Fri, 23 Jan 2015 20:03:41 -0600
Message-ID: <20150124020341.GA2861@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:46576 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750836AbbAXCDx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Jan 2015 21:03:53 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey folks-

We've recently undertaken an upgrade of our kernel from 3.2-rt to
3.14-rt, and have run into a performance regression on our ARM boards.
We're still in the process of trying to isolate what we can, but
hopefully someone's already run into this and has a solution or might
have some useful debugging ideas.

The first test we did was to run cyclictest[1] for comparison:

   3.2.35-rt52
   # Total: 312028761 312028761 624057522
   # Min Latencies: 00010 00011
   # Avg Latencies: 00018 00020
   # Max Latencies: 00062 00066 00066
   # Histogram Overflows: 00000 00000 00000

   3.14.25-rt22
   # Total: 304735655 304735657 609471312
   # Min Latencies: 00013 00013
   # Avg Latencies: 00023 00024
   # Max Latencies: 00086 00083 00086
   # Histogram Overflows: 00000 00000 00000

As you can see, we're seeing a 30%-40% degradation not just max latencies, but
also the minimum/maximum latencies.  The above numbers are with the system
under a network throughput load (iperf), but changing the load seems to have
little impact (and in fact, we see a general slowdown even when otherwise
idle).

The ARM SoC used for testing is the dual core Xilinx Zynq.

We've observed no such degradation on our x86 boards.

Many things have changed in the ARM-world between these releases, but
unfortunately bisection is difficult for us, however, we were able to
give 3.10-rt a try, and 3.10-rt shows the same performance degradation.

We suspected something was up with time accounting, as since 3.2, Zynq gained a
clock driver, and shifted to using the arm_global_timer driver as it's
clocksource.  We've compared register dumps of the clocks, cache, and timers
between kernels, and the hardware appears to be configured the same.  It also
seems that the runtimes of identical code paths appear to run slower in
3.14-rt, as observed by the function tracer and the local ftrace clock; we're
looking to better characterize this.

We did, however, construct a test to validate via an external clock that
clock_nanosleep() was sleeping for as long as it says it was by toggling a
GPIO, sleeping for a small period of time, and toggling again, and validating
via a scope that the duration matched.

The toolchain is the same for both kernels (gcc 4.7.2).

We also brought up 3.14-rt on a BeagleBone Black (also ARM) and compared it's
performance to a 3.8-rt build (bringing up 3.2-rt would require a bit more
effort).  We observed a ~30% degradation on this platform as well.

If anyone has any ideas, please let us know!  Otherwise, we'll follow up with
anything else we discover.

Thanks!
  Josh

1: cyclictest -H 500 -m -S -i 237 -p 98
