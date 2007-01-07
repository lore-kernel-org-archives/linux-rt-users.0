From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Sun, 07 Jan 2007 15:21:43 +0100
Message-ID: <1168179704.22701.86.camel@localhost.localdomain>
References: <459CE84F.8000009@imc-berlin.de>
	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>
	 <1167917257.23138.17.camel@localhost.localdomain>
	 <459D16D1.4040306@imc-berlin.de>
	 <1167986882.23138.52.camel@localhost.localdomain>
	 <45A0ECBB.1040107@imc-berlin.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:52101 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932545AbXAGOQI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Jan 2007 09:16:08 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
In-Reply-To: <45A0ECBB.1040107@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven,

On Sun, 2007-01-07 at 13:51 +0100, Steven Scholz wrote:
> > There is neither a call of timer_create() nor of timer_settime(). So the
> > posix timer is not setup, which results in the endless wait for the
> > signal.
> 
> cyclictest runs fine on my SuSE 10.0 host system. But: there are *no* calls
> to any timer_* function!!!

Did you check that with strace ?

> Has it to with using TLS?

No.

> :~/Projekte/Latency/cyclictest> ldd ./cyclictest
>         linux-gate.so.1 =>  (0xffffe000)
>         libpthread.so.0 => /lib/tls/libpthread.so.0 (0x4003a000)
>         librt.so.1 => /lib/tls/librt.so.1 (0x4004c000)
>         libc.so.6 => /lib/tls/libc.so.6 (0x40055000)
>         /lib/ld-linux.so.2 (0x40000000)

The timer_* functions are in librt.

	tglx
