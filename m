From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 07:21:47 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906170706220.2800@localhost.localdomain>
References: <loom.20090615T222836-377@post.gmane.org> <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org> <20090616182734.GD13048@pengutronix.de> <loom.20090616T215133-122@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Martin Shepherd <mcs@astro.caltech.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:55196 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbZFQFV6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 01:21:58 -0400
In-Reply-To: <loom.20090616T215133-122@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 16 Jun 2009, Martin Shepherd wrote:
> Which is what I am trying to do.  I want the application thread that
> uses my driver to be able to set the priority of its interrupt to
> equal the priority of the calling thread.  The problem with calling
> sched_setscheduler directly from user-space, is figuring out the PID
> of the IRQ thread. First of all, I have multiple boards of the same
> type, such that looking in /proc/interrupts won't tell me which IRQ is
> being used by a given board. So I would have to implement an ioctl()
> anyway, just to query the IRQ from the device driver. Secondly, the
> PID of the corresponding IRQ thread changes each time that
> request_irq() is called, and then later freed. So searching for the
> IRQ thread couldn't be done by a wrapper script around the program.
>
> It seems much more friendly and efficient for my driver to provide
> applications with an ioctl that tells it to set the priority of its
> IRQ thread.

Wrong. That information is already available in sysfs and there is no
reason to use an ioctl for that. ioctls are neither friendly nor
efficient.

The only missing information is the thread id, which needs to
exposed. This is completely independent of a single driver and needs
to be implemented in a generic way.

> Note that none of this would be necessary if the IRQ thread of a
> device automatically inherited the priority of the highest priority
> realtime thread that has requested (and not yet free'd) its IRQ. Not
> doing so, leads to a form of priority inversion.

Eek. That's even more wrong. Why should the priority of a user task
influence the priority of a device driver irq thread ? That's a
question of policy and policies are set from user space. The kernel
merily provides the interfaces.

Also your claim that it leads to a form of priority inversion is not
necessarily true. I can see what you mean, but there are cases where
the high prio thread just wants an async notification from a driver
that something has changed. It maybe or maybe not required that this
information comes in with high prio. Again that's a question of policy
and needs to be decided by the system designer.

Also why do you claim that the user task requests/frees the drivers
irq ? That depends on the driver, i.e. if it is implemented to request
the irq on open(), and can not be generalized.

Thanks,

	tglx
