From: Stanislav Meduna <stano@meduna.org>
Subject: Re: timerfd read does not return - some traces
Date: Fri, 10 May 2013 14:42:45 +0200
Message-ID: <518CEB45.9080705@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <517B8D91.4010700@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:34715 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab3EJMm5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 May 2013 08:42:57 -0400
In-Reply-To: <517B8D91.4010700@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 27.04.2013 10:34, Stanislav Meduna wrote:

> For the record, the problem seems to be the issue that the
> http://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.4-rt&id=52cecaa
> fixed in v3.4.38-rt52 (tracing: Fix free of probe entry by calling
> call_rcu_sched()).

Hm.. it was not fixed, it just moved the timings so that it is
even less reproducible. I am now back at 3.4.25-rt37, with slightly
buggy application - due to a bad ioctl it tries to repeatedly
load some module that it does not find. This seems to push the
timings so that the problem does manifest sometimes.

Unfortunately I am unable to reproduce the problem with
function tracing enabled :( I will try to enable/disable
single interesting functions - any tips for what is
the most interesting?

I have uploaded the trace.dat captured by
  trace-cmd start -b 64000 -e irq -e sched -e syscalls -e timer
and an excerpt from it in textual form at
http://www.meduna.org/tmp/trace.timerfdhang.tar.gz

I would greatly appreciate it if someone could take a look.


The threads:

 659  - the thread running a 5 ms timerfd loop, RR, priority 45
   3  - ksoftirqd, FF, 37
1276  - a thread trying to do a non-blocking TCP connect. If it
        fails, it does getsockopt for error, setsockopt
        (the buggy one) and closes the socket. RR, 25
1271  - a thread doing the "real" work. It waits at the futex
        that is woken from the timerfd thread. RR, 25
 653  - a thread periodically (each ms) reading some device that
        does not exist at this platform (returns EBADF) and
        sleeps. RR, 25

The interrupts run at FF, 50.


The functionality:

49762.922986 the timerfd thread exits the read()
             successfully for the last time

49762.923028 it is back in the read

49762.927836 the HRTIMER for the next iteration is raised and
49762.927872 starts processing. After some PI juggling
49762.927934 arms it for the new interval, i.e. the hrtimer_restart
             in timerfd.c was reached

49762.927944 the thread with the socket is priority inherit. As far
             as I can tell the two do not share any userspace lock
             that is held at the moment, so this has to be some
             kernel one.
             Anyway, a network interrupt comes in and after handling
             the thread obviously finishes the lock and returns
             the priority

49762.928029 the timerfd thread gets the CPU, does not giveit back,
but the end of the syscall is not reached in a sane time. It eventually
is, this time after more than 2 seconds (I've seen 200 ms to 4 s);
however this is not captured as I stopped the tracing at the RT
throttler activation.

This is a 32-bit uniprocessor, so there can be neither races between
CPUs nor 64-bit atomic access problems.

I already tried:
- fixing the bug that caused the module request
- moving ksoftirqd priority above the timerfd thread
- enable/disable highres timers
- different machines - a Geode based one (needs tsc=reliable
  for the hrtimers) and a Celeron M based one (hpet=force needed)
- removing loadable modules and anything debug-related from the kernel
  config
- running with lockdep (unable to reproduce, so no reliable data)
- changing a suspicious (for me at least) code in e100_watchdog
  to use raw spin lock


Thanks
-- 
                                                 Stano

