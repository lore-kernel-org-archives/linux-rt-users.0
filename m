From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Issue (NOT RELATED TO RT-PATCH) with clock_gettime / clock_nanosleep
 APIs with high resolution timer on panda board
Date: Thu, 1 Sep 2011 21:33:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109012121580.2723@ionos>
References: <CAFQPvXfaisNL9YN+pUp_cYCRp4YZFCEPt33ZUAZ-Sa6VieAing@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-71868405-1314905611=:2723"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55134 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087Ab1IATdd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Sep 2011 15:33:33 -0400
In-Reply-To: <CAFQPvXfaisNL9YN+pUp_cYCRp4YZFCEPt33ZUAZ-Sa6VieAing@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-71868405-1314905611=:2723
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 29 Aug 2011, Sankara Muthukrishnan wrote:
> On panda baord, I ran the v0.74 of cyclictest
> (git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git)
> to measure the latency (./cyclictest -l4000000000 -m -S -p99 -i70 -h60

 -i 70 ??? That's a 70us interval. Pretty damned close to what that CPU
 can handle. :)

> -q -n). These arguments make the test to use TIMER_ABSTIME for
> clock_nanosleep and CPU affinity (using sched_setaffinity) for the 2
> threads to be set to each CPU.  It is expected to see large latencies
> without the RT patch. However, when I ran the tests overnight, I
> observed maximum latency of 4294967103 us (weird but it is close to
> unsigned int max). So, I instrumented the test to print some
> additional information and exit as soon as it finds such a weird
> latency. I was also trying to stress ethernet/network/interrupts of
> the system with SFTP but I think (not very sure) I could reproduce the
> issue without that. clock_nanosleep was called to sleep until
> 27608:739311172 (sec:nsec), but after clock_nanosleep returned,
> clock_gettime returned the time as 27608:739117429 (sec:nsec) which is
> roughly 193 usec earlier than the value passed to clock_nanosleep and
> that is the bug. I ran the test with just one thread ( remove "-S" and
> add "-t1 -a1 -n" ) and saw the weird latency of 4294967294 usec.

That looks like a problem in the clocksource. i.e. time is going
backward or having weird momentary jumps. You could verify that by
running one ore more tight loops which do

	clock_gettime(CLOCK_MONOTONIC, &prev);
	while (1) {
	      clock_gettime(CLOCK_MONOTONIC, &curr);
	      if (curr < prev) /* Use a proper compare function for timespec! */
	      	       printf(.....);
	      prev = curr;
	}

If that triggers on RT or on a vanilla kernel, then the problem is
definitely somewhere in the timekeeping/clocksource area.

Thanks,

	tglx
--8323328-71868405-1314905611=:2723--
