From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Mon, 08 Jan 2007 11:10:16 +0100
Message-ID: <45A21888.8060702@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>	 <1167917257.23138.17.camel@localhost.localdomain>	 <459D16D1.4040306@imc-berlin.de> <1167986882.23138.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:3291 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161203AbXAHKKW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jan 2007 05:10:22 -0500
To: tglx@linutronix.de
In-Reply-To: <1167986882.23138.52.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

> This looks like a serious problem with your cross compiler / glibc
> setup. Can you compile cyclictest on one of your desktop machines and
> link it statically ?

As I wrote I have problems linking it statically!

 gcc -Wall -O2  -lpthread -lrt cyclictest.c -o cyclictest -static

results in

/tmp/cc30ryGd.o: In function `main':
cyclictest.c:(.text+0x4a2): undefined reference to `pthread_create'
cyclictest.c:(.text+0x6d9): undefined reference to `pthread_kill'
cyclictest.c:(.text+0x6f0): undefined reference to `pthread_join'
/tmp/cc30ryGd.o: In function `timerthread':
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

while

 gcc -Wall -O2 cyclictest.c -o cyclictest -lrt -lpthread -static

compiles and links fine!

Any idea why the order matters?

--
Steven
