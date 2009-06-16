From: "Peter Morreale" <PMorreale@novell.com>
Subject: Re: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 16:13:39 -0600
Message-ID: <4A37E0D3020000D90003727E@sinclair.provo.novell.com>
References: <4A37E0CE020000D90003727B@sinclair.provo.novell.com>
 <4A37E0D3020000D90003727E@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: <mcs@astro.caltech.edu>, <u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:43576 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbZFPWdn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 18:33:43 -0400
In-Reply-To: <4A37E0D3020000D90003727E@sinclair.provo.novell.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry for the top post. On BB. Network is down. :-(

Why not have the driver ioctl return the pid of the IRQ thread?  That w=
ay the driver stays 'clean' and the app is free to manipulate the prio =
as it sees fit. =20

Just a thought...

-PWM=20
-----Original Message-----
=46rom: Martin Shepherd <mcs@astro.caltech.edu>
To:  <u.kleine-koenig@pengutronix.de>
Cc:  <linux-rt-users@vger.kernel.org>

Sent: 6/16/2009 3:25:18 PM
Subject: Re: Setting the priority of an IRQ thread


On Tue, 16 Jun 2009, Uwe Kleine-K=F6nig wrote:
>> IRQ thread, then use sys_sched_setscheduler(pid,...) to change its p=
riority.
>> I'll try that out in the morning.
> I wouldn't recommend calling sys_sched_setscheduler from kernel space=
=2E
> That's the userspace API and you need to pass a __user pointer as thi=
rd
> argument.

Good point, although my ioctl() will be passing the scheduling
parameters from user-space. So the need for a __user pointer for this
would not be a problem. Alternatively one could call task_setprio(),
instead of sys_sched_setscheduler(), and omit the then reduntant step
of figuring out the PID of the task.

> The right way is to do this change from userspace.

Which is what I am trying to do.  I want the application thread that
uses my driver to be able to set the priority of its interrupt to
equal the priority of the calling thread.  The problem with calling
sched_setscheduler directly from user-space, is figuring out the PID
of the IRQ thread. First of all, I have multiple boards of the same
type, such that looking in /proc/interrupts won't tell me which IRQ is
being used by a given board. So I would have to implement an ioctl()
anyway, just to query the IRQ from the device driver. Secondly, the
PID of the corresponding IRQ thread changes each time that
request_irq() is called, and then later freed. So searching for the
IRQ thread couldn't be done by a wrapper script around the program.

It seems much more friendly and efficient for my driver to provide
applications with an ioctl that tells it to set the priority of its
IRQ thread.

Note that none of this would be necessary if the IRQ thread of a
device automatically inherited the priority of the highest priority
realtime thread that has requested (and not yet free'd) its IRQ. Not
doing so, leads to a form of priority inversion.

Thanks,

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
