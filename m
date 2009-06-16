From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 21:54:19 +0000 (UTC)
Message-ID: <loom.20090616T215133-122@post.gmane.org>
References: <loom.20090615T222836-377@post.gmane.org> <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org> <20090616182734.GD13048@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:45359 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761457AbZFPVy3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 17:54:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MGgbu-00088n-KF
	for linux-rt-users@vger.kernel.org; Tue, 16 Jun 2009 21:54:30 +0000
Received: from adsl-69-105-99-200.dsl.irvnca.pacbell.net ([69.105.99.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2009 21:54:30 +0000
Received: from mcs by adsl-69-105-99-200.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2009 21:54:30 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Uwe Kleine-K=C3=B6nig <u.kleine-koenig <at> pengutronix.de> writes:
> > IRQ thread, then use sys_sched_setscheduler(pid,...) to change its =
priority.
> > I'll try that out in the morning.
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
=20
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
