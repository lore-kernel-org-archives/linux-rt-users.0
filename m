From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 20:27:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0906162009280.9500@goblin.caltech.edu>
References: <loom.20090615T222836-377@post.gmane.org>
 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org>
 <20090616182734.GD13048@pengutronix.de> <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:47480 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764617AbZFQD3D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 23:29:03 -0400
In-Reply-To: <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 17 Jun 2009, Thomas Gleixner wrote:
> The irq/softirq threads call sys_sched_setscheduler() already to
> change their priorities.
>
> The right way to do this is to have an interface
> set_irq_thread_prio(irq, prio)

I just wrote such a function, and it appears to work. I couldn't get
it to work with sys_sched_setscheduler(), since this returned -EFAULT,
indicating that it didn't like the provenance of the sched_param
argument. I thus instead used the non-syscall variant,
sched_setscheduler(), protecting the target task structure from
deletion by bracketing the code with calls to
read_lock(&tasklist_lock), and read_unlock(&tasklist_lock). Hopefully
that is the right lock to take. The implemenation, which I added to
kernel/irq/manage.c, is as follows:

#ifdef CONFIG_PREEMPT_HARDIRQS

int set_irq_thread_prio(unsigned int irq, int prio)
{
         struct irq_desc *desc = irq_to_desc(irq);
         struct sched_param param = { 0, };
         int status;

         param.sched_priority = prio;

         if(desc) {
                 read_lock(&tasklist_lock);
                 if(desc->thread)
                         status = sched_setscheduler(desc->thread, SCHED_FIFO,
                                                     &param);
                 else
                         status = -ENODEV;
                 read_unlock(&tasklist_lock);
         } else {
                 status = -ENODEV;
         }
         return status;
}

EXPORT_SYMBOL(set_irq_thread_prio);

#endif

I also put the corresponding function prototype in
include/linux/irq.h. I called this from my device-driver, and ran my
test program with it a few times, and it worked fine.

Should I submit this as a patch as-is, or is there anything
problematic that I should fix first?

Thanks,

Martin
