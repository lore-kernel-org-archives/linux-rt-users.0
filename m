From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Priorities of IRQ handlers
Date: Wed, 28 Nov 2007 13:38:19 -0800
Message-ID: <1196285899.12577.6.camel@sx.thebigcorporation.com>
References: <474AE6C7.4090204@free.fr>
	 <Pine.LNX.4.58.0711271125130.16899@gandalf.stny.rr.com>
	 <474D4B76.8080001@free.fr>  <474D7748.8@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: John Sigler <linux.kernel@free.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: "K.R. Foley" <kr@cybsft.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:59248
	"EHLO QMTA10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756851AbXK1VpY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 16:45:24 -0500
In-Reply-To: <474D7748.8@cybsft.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-11-28 at 08:12 -0600, K.R. Foley wrote:
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
> 
> > 

Keep in mind that if you are on a shared IRQ line, you will be boosting
the priority of other interrupts as well.

Sven
