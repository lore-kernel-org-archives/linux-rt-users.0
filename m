From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Sun, 07 Jan 2007 13:38:10 +0100
Message-ID: <45A0E9B2.40203@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>	 <1167917257.23138.17.camel@localhost.localdomain>	 <459D16D1.4040306@imc-berlin.de> <1167986882.23138.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2067 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbXAGMiR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Jan 2007 07:38:17 -0500
To: tglx@linutronix.de
In-Reply-To: <1167986882.23138.52.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

>> Just tried it on a plain 2.6.19. posix timer version still hangs ...
> 
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

Ah. Thanks for that hint!

> This looks like a serious problem with your cross compiler / glibc
> setup. Can you compile cyclictest on one of your desktop machines and
> link it statically ?

gcc -Wall -O2  -lpthread -lrt cyclictest.c -o cyclictest -static

results in

/tmp/ccIsApGI.o: In function `main':
cyclictest.c:(.text+0x4a2): undefined reference to `pthread_create'
cyclictest.c:(.text+0x6d9): undefined reference to `pthread_kill'
cyclictest.c:(.text+0x6f0): undefined reference to `pthread_join'
/tmp/ccIsApGI.o: In function `timerthread':
cyclictest.c:(.text+0x839): undefined reference to `clock_gettime'
cyclictest.c:(.text+0x881): undefined reference to `timer_settime'
cyclictest.c:(.text+0x90c): undefined reference to `clock_gettime'
cyclictest.c:(.text+0xa7b): undefined reference to `clock_gettime'
cyclictest.c:(.text+0xa8c): undefined reference to `clock_nanosleep'
cyclictest.c:(.text+0xb08): undefined reference to `timer_delete'
cyclictest.c:(.text+0xb79): undefined reference to `clock_gettime'
cyclictest.c:(.text+0xbd8): undefined reference to `clock_nanosleep'
cyclictest.c:(.text+0xc37): undefined reference to `timer_create'
collect2: ld returned 1 exit status

???

Shouldn't pthread_* be in libpthread?

Steven
