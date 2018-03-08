Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:39370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933700AbeCHSA0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Mar 2018 13:00:26 -0500
Date: Thu, 8 Mar 2018 19:00:25 +0100
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: inconsistent lock state on v4.14.20-rt17
Message-ID: <20180308180025.zdhu3zl24zfkb3qz@linutronix.de>
References: <1520350053.1744.6.camel@ginzinger.com>
 <20180306182154.nkia5hl4r3r2ncru@linutronix.de>
 <1520411200.1744.11.camel@ginzinger.com>
 <20180308155741.vbdqprs6stx5zu4q@linutronix.de>
 <1520530739.1744.18.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1520530739.1744.18.camel@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-03-08 17:38:59 [+0000], Roosen Henri wrote:
> > Is the backtrace, that you receive from lockdep, always the same or
> > is
> > it different sometimes?
> 
> It is different each time. So my gut feeling tells me it might be a
> memory corruption of some kind.. maybe caused by a use after free or
> so..

CONFIG_SLUB_DEBUG_ON should (or could) catch this.

> I restarted the target yesterday evening and this morning it was frozen
> without any trace on the terminal. Attaching a JTAG showed different
> call-stacks than yesterday; Core #2 (trying to print the info to the
> terminal) and #3 were spinning on a spin-lock, don't understand what
> core #0 and #1 were doing.

maybe #0 and #1 are idle but #2 and #3 should make progress. #2 looks
like a warning, do you know where it is from or is this everything you
get? Unless the warning comes from an atomic context you should see
something on the UART.

> Most of the times the call-stacks start at SyS_write() or SyS_read()
> from hackbench.
but what you posted was lockdep complaining about RQ lock.

> Some things I found out by testing on v4.9:
> - minimum test to reproduce problem "while true; do hackbench -g 100 -l
> 1000; done &"
> - reproducible with "hackbench -T" (threads)
> - reproducible only on iMX6Q, not (yet) on iMX6S, iMX6D
> - NOT reproducible with "hackbench -p" (pipes)
interesting.

> As that might be pointing towards the streaming unix socketpair
> hackbench is using from multiple forked processes, I had a look at
> net/unix/af_unix.c and wondered why unix_stream_sendmsg() doesn't
> increase the reference count on the "other" socket the same as
> unix_dgram_sendmsg() does. I don't see a reason why "other" is handled
> differently in both functions, so it smells fishy to me. But I'm not
> familiar with the net-code, so maybe you could review if the diff below
> would make sense:

Commit 830a1e5c212f ("[AF_UNIX]: Remove superfluous reference counting
in unix_stream_sendmsg") claims that this is not required. But if your
patch makes a difference then…

> Thanks,
> Henri

Sebastian
