From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Wed, 25 Jan 2017 14:40:17 +0100
Message-ID: <20170125134016.ffj6xpissz4iy7ph@linutronix.de>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
 <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
 <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
 <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45841 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdAYNkT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2017 08:40:19 -0500
Content-Disposition: inline
In-Reply-To: <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-01-25 12:55:30 [+0000], Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Sebastian,
Hi Mathias,

> > > > The kernel version 4.1.37-rt43 is working fine, the kernel versions
> > > > 4.4.39-rt50 and
> > > 4.8.11-rt7 show the same strange behavior as 4.9.0-rt1.
> > > > Something on the way between 4.1.37-rt43 and 4.4.39-rt50 seems to
> > > > cause the
> > > trouble.
> > >
> > > can you check if one of the earlier v4.4-RT releases (maybe start with
> > > -rt2 or -rt1) also shows this behaviour?
> > > If not, would you have a testcase?
> > I tested with 4.4.0-rt2.
> > Here this issue occurs very rarely. I ran the gdb for about 30 times, and here I got
> > one hit.
> > With the other kernel versions I got the issue in 20-40% of the cases.
> > 
> > I will try out the other 4.4.0 releases...
> 
> I ran more tests. The kernel 4.4.1-rt4 is working fairly fine (only about one hit every 30 runs)
> but the kernel 4.4.1-rt5 is causing the issue very often.

and 4.1.37-rt43 shows not SIGSTOPS in 100 runs?
The reason I asked for testing early 4.4 kernel was to bisect the
failure if we had a version which did not show the failure.
Now we got from rarely hitting the problem to more often. Going through
the history of rt4…rt5 shows only fixes. One thing is fixing
lazy-preempt and another migrate-disable. And I believe one problem was
that we did not utilize more than one CPU under certain circumstances.
So if you bisect between those two it might be that the fix uncovers a
bug or showing more reliably.
But in the end, I have no idea where the extra SIGSTOPs signals are
from.

Sebastian
