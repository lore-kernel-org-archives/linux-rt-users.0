From: Mike Galbraith <efault@gmx.de>
Subject: Q6600 + low frequency periodic timer + CPU_IDLE = much jitter
Date: Thu, 29 Jul 2010 11:05:20 +0200
Message-ID: <1280394320.9599.48.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:38909 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755110Ab0G2JFO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jul 2010 05:05:14 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

It's looking like my Q6600 is kinda slow at switching gears, and I'd
just like to verify that it is the hardware, not something odd going on
in cpuidle territory.

If I boot idle=poll and set scaling_governor to performance, the CPU is
running full bore (2.4GHz) per both cpufreq and turbostat, and jitter is
~10 usecs (~5 usecs on non-rt kernel)

If I boot processor.max_cstate=1 instead, to have _some_ power saving,
set the governor to performance and measure, I notice that while cpufreq
swears my CPU is locked in at 2.4GHz, turbostat says cpufreq is lying to
me, that my CPUs _are_ changing frequency, bouncing around a bit.

If I switch to powersave, there is no frequency shifting, and little
jitter.  Switch to performance and there's much jitter, until I add a
cpu hog, then CPU goes to full throttle, and jitter goes away.

This large jitter differential does not happen on a L5520 box, or a few
others I've tested with much nicer CPUs than mine, which leads me to
suspect that my Q6600's oldish two speed gearbox has straight cut gears
and no synchros, it's double-clutching, and that takes a while ;-)

Kernel: v2.6.33.6-rt26-17-g911d28c processor.max_cstate=1
Box: Q6600

cset shield --cpu 1-3 -k on

marge:/root/tmp # ./periodic_timer -p40 -c3 -f60 -t1 -s -T -F2392.594 -C1000              
Pinned to CPU3 priority: 40 timer freq: 60 Hz tolerance: 1 usecs, stats interval: 1000 samples
                         measurement clock; TSC @2392.594MHz

period: 16666.67 usecs          min: 16552.33 max: 16772.62 mean: 16667.12 stddev:   5.72
        585 > 1 usec errors     min: -105.95 max: 114.34 mean:  -0.48 stddev:  28.12

period: 16666.67 usecs          min: 16549.42 max: 16783.26 mean: 16667.13 stddev:   6.30
        589 > 1 usec errors     min: -116.59 max: 117.25 mean:  -0.51 stddev:  36.58

start SCHED_OTHER cpu hog on CPU3 (or even better boot idle=poll)

period: 16666.67 usecs          min: 16662.84 max: 16676.36 mean: 16667.10 stddev:   0.37
        15 > 1 usec errors      min:  -9.69 max:   3.83 mean:  -0.93 stddev:   3.75

period: 16666.67 usecs          min: 16663.89 max: 16674.49 mean: 16667.10 stddev:   0.30
        11 > 1 usec errors      min:  -7.82 max:   2.78 mean:  -1.02 stddev:   3.40




