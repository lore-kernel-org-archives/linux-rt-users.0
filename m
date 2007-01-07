From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Sun, 07 Jan 2007 15:52:55 +0100
Message-ID: <1168181575.22701.95.camel@localhost.localdomain>
References: <459CE84F.8000009@imc-berlin.de>
	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>
	 <1167917257.23138.17.camel@localhost.localdomain>
	 <459D16D1.4040306@imc-berlin.de>
	 <1167986882.23138.52.camel@localhost.localdomain>
	 <45A0ECBB.1040107@imc-berlin.de>
	 <1168179704.22701.86.camel@localhost.localdomain>
	 <45A105F7.6010502@imc-berlin.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:50957 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932558AbXAGOrS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Jan 2007 09:47:18 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
In-Reply-To: <45A105F7.6010502@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven,

On Sun, 2007-01-07 at 15:38 +0100, Steven Scholz wrote:
>  strace ./cyclictest -t 1 -p 80 -i 10000 -l 10 -v 2> cyclictest.txt

You need to run "strace -f ...." otherwise you don't get the thread
strace.

> >> Has it to with using TLS?
> > No.
> IIUC TLS is only usefull for SMP systems?

Thread Local Storage is used to store per thread local information. This
is needed as the threads of a process share the same address space. NPTL
needs TLS support.
 
> > The timer_* functions are in librt.
> Then why does the static linking not work?

Are the static libs available ?

	tglx
