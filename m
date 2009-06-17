From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 19:27:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0906161907010.9500@goblin.caltech.edu>
References: <loom.20090615T222836-377@post.gmane.org>
 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>  <loom.20090616T074347-549@post.gmane.org>
  <20090616182734.GD13048@pengutronix.de>  <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
 <49b7c2350906161812t14784817o4ce71daae9c472cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-rt-users@vger.kernel.org
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:44590 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZFQC1u (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 22:27:50 -0400
In-Reply-To: <49b7c2350906161812t14784817o4ce71daae9c472cc@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 17 Jun 2009, GeunSik Lim wrote:
>...
> You means that we have to utilize wrapper function using
> sys_sched_setscheduler() function for PID setting of IRQ thread. It's right?

I may be wrong, but from looking through the kernel code, it appears
as though sys_sched_setscheduler() is used in places where the target
thread could spontaneously dissapear, whereas its non-syscall variant,
sched_setscheduler(), is only used when it is clear that the
underlying thread can't dissapear, such as during the creation of a
new thread. I think that this must be because sys_sched_setscheduler()
takes a pid argument, which remains valid even if the underlying
thread dissapears, whereas sched_setscheduler() takes a raw
task_struct argument, which doesn't provide such guarantees.

I don't personally understand why the copy_from_user() call in the
do_sched_setscheduler() part of sys_sched_setscheduler() doesn't get
upset by being handed an argument from the kernel stack, instead of a
user pointer, but as Thomas says, sys_sched_setscheduler() is called
from a few places in the kernel, and apparently it works.

Note that my attempt to do this from my device-driver didn't work out,
because it turns out that irq_to_desc() isn't exported. So my driver
can't use this to find the IRQ thread. I'm currently having a quick go
at hacking the kernel to provide the set_irq_thread_prio(irq, prio)
function that Thomas suggested, but I haven't fiddled with the kernel
before. So it remains to be seen whether this works :-).

Martin
