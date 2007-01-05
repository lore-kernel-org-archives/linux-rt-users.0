From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Fri, 05 Jan 2007 09:48:02 +0100
Message-ID: <1167986882.23138.52.camel@localhost.localdomain>
References: <459CE84F.8000009@imc-berlin.de>
	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>
	 <1167917257.23138.17.camel@localhost.localdomain>
	 <459D16D1.4040306@imc-berlin.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:40068 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030374AbXAEImg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Jan 2007 03:42:36 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
In-Reply-To: <459D16D1.4040306@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-01-04 at 16:01 +0100, Steven Scholz wrote:
> > cyclictest does not need any extra functionality. You only need a new
> > glibc if you want to use priority inheritance mutexes.
> 
> So IIUC the cyclictest should run and give results even on kernels with no
> real time, preempt, lowlatency support at all?

Right.

> Just tried it on a plain 2.6.19. posix timer version still hangs ...

That's caused by user space breakage. Looking at the strace you sent:

[pid   932] getpid()                    = 932
[pid   932] rt_sigprocmask(SIG_SETMASK, [ALRM RTMIN], NULL, 8) = 0
[pid   932] gettid()                    = 932
[pid   932] rt_sigprocmask(SIG_BLOCK, [ALRM], NULL, 8) = 0
[pid   932] sched_setscheduler(0, SCHED_FIFO, { 80 }) = 0
[pid   932] clock_gettime(CLOCK_MONOTONIC, {325, 223507890}) = 0
[pid   932] rt_sigaction(SIGALRM, {0xb7ed72c0, ~[], 0}, NULL, 8) = 0
[pid   932] rt_sigprocmask(SIG_BLOCK, NULL, [ALRM RTMIN], 8) = 0
[pid   932] rt_sigsuspend(~[ALRM RT_1] <unfinished ...>
[pid   930] <... nanosleep resumed> NULL) = 0

There is neither a call of timer_create() nor of timer_settime(). So the
posix timer is not setup, which results in the endless wait for the
signal.

This looks like a serious problem with your cross compiler / glibc
setup. Can you compile cyclictest on one of your desktop machines and
link it statically ?

	tglx
