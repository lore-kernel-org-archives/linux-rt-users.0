From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: Priorities of IRQ handlers
Date: Wed, 28 Nov 2007 13:02:01 -0200
Message-ID: <20071128150201.GE25255@ghostprotocols.net>
References: <474AE6C7.4090204@free.fr> <Pine.LNX.4.58.0711271125130.16899@gandalf.stny.rr.com> <474D4B76.8080001@free.fr> <474D7748.8@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Sigler <linux.kernel@free.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: "K.R. Foley" <kr@cybsft.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:25704 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbXK1PFc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 10:05:32 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1252913wra
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Nov 2007 07:05:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <474D7748.8@cybsft.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Wed, Nov 28, 2007 at 08:12:24AM -0600, K.R. Foley escreveu:
> John Sigler wrote:
> > Hello Steven,
> > 
> > Steven Rostedt wrote:
> > 
> >> John Sigler wrote:
> >>
> >>> I need to change the priorities of several soft and hard IRQ handlers.
> >>>
> >>> Namely,
> >>>
> >>> o reduce the prio of "softirq-timer" handler to 10
> >>>
> >>> o reduce the prio of IRQ14 and IRQ15 handlers to 20
> >>>    (my flash drives do not support DMA BTW...)
> >>>
> >>> o boost the prio of my I/O boards' IRQ handlers to 60
> >>>    (there can be 1 or 2 boards, the driver is a kernel module
> >>>     which is loaded after the system has booted.)
> >>>
> >>> I've written a short program that calls
> >>>    sched_setscheduler(pid, SCHED_FIFO, &param);
> >>> with the appropriate pid, which I look up using ps -ef
> >>
> >> Look for the program "chrt". It does this for you. This program is
> >> available in all major distributions of Linux.
> > 
> > Thanks for the tip.
> > 
> > For the record, I found schedutils on Robert Love's page:
> > 
> > http://rlove.org/
> > http://rlove.org/misc/schedutils-1.5.0.tar.gz
> > 
> > However, I had already solved that part of the problem with a
> > program of my own.
> > 
> > My real problem is: the IRQ handlers for the I/O boards are
> > only instantiated when the kernel module is inserted. How do
> > I /reliably/ determine their pid?
> 
> What about something like:
> chrt -f -p 99 `/sbin/pidof 'IRQ 8'`

If he knows that IRQ 8 is associated with his device, that is ok,
but how to map device -> IRQ in the first place?
 
> > 
> > e.g. on one system, the IRQ handler for my I/O board is IRQ5
> > with pid 745. On another system, it's IRQ20 with pid 808.
> > On a third system they're IRQ20 and IRQ21 with pid 239 and 240.

See?

Perhaps he could use a kernel command line where he would tell that
for the string used in request_irq the kthread priority should be N.

IIRC there was somebody trying to write a patch to support this at some
point in this list...

- Arnaldo
