From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 14:25:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0906161315040.9500@goblin.caltech.edu>
References: <loom.20090615T222836-377@post.gmane.org>
 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org>
 <20090616182734.GD13048@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-679278142-671219039-1245187518=:9500"
Cc: linux-rt-users@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:62727 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZFPWBZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 18:01:25 -0400
In-Reply-To: <20090616182734.GD13048@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---679278142-671219039-1245187518=:9500
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Tue, 16 Jun 2009, Uwe Kleine-K=F6nig wrote:
>> IRQ thread, then use sys_sched_setscheduler(pid,...) to change its prior=
ity.
>> I'll try that out in the morning.
> I wouldn't recommend calling sys_sched_setscheduler from kernel space.
> That's the userspace API and you need to pass a __user pointer as third
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
---679278142-671219039-1245187518=:9500--
