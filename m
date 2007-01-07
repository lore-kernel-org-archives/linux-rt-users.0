From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Sun, 07 Jan 2007 15:55:19 +0100
Message-ID: <45A109D7.8090109@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>	 <1167917257.23138.17.camel@localhost.localdomain>	 <459D16D1.4040306@imc-berlin.de>	 <1167986882.23138.52.camel@localhost.localdomain>	 <45A0ECBB.1040107@imc-berlin.de>	 <1168179704.22701.86.camel@localhost.localdomain>	 <45A105F7.6010502@imc-berlin.de> <1168181575.22701.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2343 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932560AbXAGOzZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Jan 2007 09:55:25 -0500
To: tglx@linutronix.de
In-Reply-To: <1168181575.22701.95.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> Steven,
> 
> On Sun, 2007-01-07 at 15:38 +0100, Steven Scholz wrote:
>>  strace ./cyclictest -t 1 -p 80 -i 10000 -l 10 -v 2> cyclictest.txt
> 
> You need to run "strace -f ...." otherwise you don't get the thread
> strace.

Ok. My fault. Sorry. Of course now the trace contains

[pid 20910] timer_create(CLOCK_MONOTONIC, {(nil), 14, SIGEV_THREAD_ID,
{20910}}, {(nil)}) = 0
[pid 20910] timer_settime(0, TIMER_ABSTIME, {it_interval={0, 10000000},
it_value={3908778, 132879754}}, NULL) = 0
[pid 20910] timer_delete(0)             = 0

>>> The timer_* functions are in librt.
>> Then why does the static linking not work?
> 
> Are the static libs available ?
Ah. Maybe not. Which would that be? libpthread.a, librt.a, libc.a?

Steven
