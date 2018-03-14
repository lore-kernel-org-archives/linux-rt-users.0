Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:52122 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeCNTzZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Mar 2018 15:55:25 -0400
Date: Wed, 14 Mar 2018 20:55:24 +0100
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: inconsistent lock state on v4.14.20-rt17
Message-ID: <20180314195523.5ndigtyecugodzmg@linutronix.de>
References: <1520350053.1744.6.camel@ginzinger.com>
 <20180306182154.nkia5hl4r3r2ncru@linutronix.de>
 <1520411200.1744.11.camel@ginzinger.com>
 <20180308155741.vbdqprs6stx5zu4q@linutronix.de>
 <1520530739.1744.18.camel@ginzinger.com>
 <20180308180025.zdhu3zl24zfkb3qz@linutronix.de>
 <1520588836.1921.2.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1520588836.1921.2.camel@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-03-09 09:47:16 [+0000], Roosen Henri wrote:
> > maybe #0 and #1 are idle but #2 and #3 should make progress. #2 looks
> > like a warning, do you know where it is from or is this everything
> > you
> > get? Unless the warning comes from an atomic context you should see
> > something on the UART.
> 
> #2 and #3 were not making progress, they kept on spinning at the
> arch_spin_lock().

It looks like those two are different locks. So someone should own it
(and be running) and unlock once done.

> > > Some things I found out by testing on v4.9:
> > > - minimum test to reproduce problem "while true; do hackbench -g
> > > 100 -l
> > > 1000; done &"
> > > - reproducible with "hackbench -T" (threads)
> > > - reproducible only on iMX6Q, not (yet) on iMX6S, iMX6D
> > > - NOT reproducible with "hackbench -p" (pipes)

|Running in process mode with 100 groups using 40 file descriptors each (== 4000 tasks)
|Each sender will pass 1000 messages of 100 bytes
|Time: 552.224
|Running in process mode with 100 groups using 40 file descriptors each (== 4000 tasks)
|Each sender will pass 1000 messages of 100 bytes
|Signal 2 caught, longjmp'ing out!
|longjmp'ed out, reaping children
|sending SIGTERM to all child processes
|signaling 4000 worker threads to terminate
|^C^CTime: 476.063
|~# uptime
| 19:50:19 up 6 days,  4:11,  1 user,  load average: 0.01, 0.01, 0.10

This survived 6 days. It was challenging to cancel hackbench because it
was running via ssh in a screen session and I was loosing my network
connection due to inactivity…

> Thanks,
> Henri

Sebastian
