From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] [RFC] RT: Optionally allow IRQF_NODELAY on serial
 console
Date: Mon, 8 Oct 2007 10:10:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710081005320.4846@gandalf.stny.rr.com>
References: <20071005153517.24349.62653.stgit@ghaskins-t60p.haskins.net>
 <alpine.LRH.0.999.0710051831000.10191@www.tglx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:58621 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbXJHOLV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 10:11:21 -0400
In-Reply-To: <alpine.LRH.0.999.0710051831000.10191@www.tglx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 5 Oct 2007, Thomas Gleixner wrote:

> On Fri, 5 Oct 2007, Gregory Haskins wrote:
> > This series may help debugging certain circumstances where the serial
> > console is unreponsive (e.g. RT51+ spinner, or scheduler problem).  It changes
> > the serial8250 driver to use IRQF_NODELAY so that interrupts execute in irq
> > context instead of a kthread.
> >
> > It works pretty well on this end, though it is admitted not fully baked.  For
> > instance, a few paths in sysrq can still call into non-raw spinlocks
> > (sched_debug_show, for instance) which will cause subsequent errors.  Also,
> > if you use KDB, be sure to convert the kdb_printf_lock to raw as well.  I may
> > send a KDB related patch seperately.
> >
> > I am sending this out now in case it is helpful to someone.
>
> The simple non-patch solution is to up the priority of the serial
> console irq to maximum. That's usually sufficient to catch runnaway tasks
> etc. It does not interfere with the system in normal operation as long as
> you do not hit keys in your minicom.
>
> I doubt that your patch has a chance to survive lockdep and anything which
> is not a sysrq.

This issue has hit me enough times where I've played with a few other
ideas. I just haven't had the time to finish them. The main problem is if
the system locks up somewhere we have a lock held that keeps us from
scheduling. Once that happens in -rt, we are as good as dead. Since you
can't get much info out without a JTAG or some other mechanism.

One thought I had was to create a small handler that could read the serial
and place data into a buffer. This handler would be a IRQ_NODELAY, and it
would wake up a serial thread to handle the data just like it would for
normal serial output. But the serial thread would just read from the
buffer instead of the serial itself.  In the case of a sysrq key coming
in, the IRQ_NODELAY handler would handle it.

Just a thought. Maybe someday I can get time to play more with this idea,
or someone else can come up with one.  But to convert the entire handler
into nodelay is a bit extreme.

-- Steve
