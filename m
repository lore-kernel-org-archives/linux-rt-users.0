From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Sun, 07 Jan 2007 13:51:07 +0100
Message-ID: <45A0ECBB.1040107@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>	 <1167917257.23138.17.camel@localhost.localdomain>	 <459D16D1.4040306@imc-berlin.de> <1167986882.23138.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2085 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbXAGMvM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Jan 2007 07:51:12 -0500
To: tglx@linutronix.de
In-Reply-To: <1167986882.23138.52.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

> That's caused by user space breakage. Looking at the strace you sent:
> 
> [pid   932] getpid()                    = 932
> [pid   932] rt_sigprocmask(SIG_SETMASK, [ALRM RTMIN], NULL, 8) = 0
> [pid   932] gettid()                    = 932
> [pid   932] rt_sigprocmask(SIG_BLOCK, [ALRM], NULL, 8) = 0
> [pid   932] sched_setscheduler(0, SCHED_FIFO, { 80 }) = 0
> [pid   932] clock_gettime(CLOCK_MONOTONIC, {325, 223507890}) = 0
> [pid   932] rt_sigaction(SIGALRM, {0xb7ed72c0, ~[], 0}, NULL, 8) = 0
> [pid   932] rt_sigprocmask(SIG_BLOCK, NULL, [ALRM RTMIN], 8) = 0
> [pid   932] rt_sigsuspend(~[ALRM RT_1] <unfinished ...>
> [pid   930] <... nanosleep resumed> NULL) = 0
> 
> There is neither a call of timer_create() nor of timer_settime(). So the
> posix timer is not setup, which results in the endless wait for the
> signal.

cyclictest runs fine on my SuSE 10.0 host system. But: there are *no* calls
to any timer_* function!!!
Has it to with using TLS?

:~/Projekte/Latency/cyclictest> ldd ./cyclictest
        linux-gate.so.1 =>  (0xffffe000)
        libpthread.so.0 => /lib/tls/libpthread.so.0 (0x4003a000)
        librt.so.1 => /lib/tls/librt.so.1 (0x4004c000)
        libc.so.6 => /lib/tls/libc.so.6 (0x40055000)
        /lib/ld-linux.so.2 (0x40000000)

Steven
