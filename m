From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 18:08:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0906171644341.921@goblin.caltech.edu>
References: <loom.20090615T222836-377@post.gmane.org>
 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org>
 <20090616182734.GD13048@pengutronix.de> <loom.20090616T215133-122@post.gmane.org>
 <alpine.LFD.2.00.0906170706220.2800@localhost.localdomain>
 <Pine.LNX.4.64.0906162232100.21049@goblin.caltech.edu>
 <alpine.LFD.2.00.0906171058330.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:58500 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbZFRBIn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 21:08:43 -0400
In-Reply-To: <alpine.LFD.2.00.0906171058330.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 17 Jun 2009, Thomas Gleixner wrote:
> Errm, and how does udev figure out which device node to create for
> which device ?
>
> /sys/devices/pci0000:00/0000:00:1d.7/usb1/dev

Thanks for the hint. I wasn't aware of the need to call
device_create() etc in my driver, and had been creating device files
by hand.  Having now remedied this omission, I have taken the
opportunity to add an irq attribute file under each of my device
entries in sysfs. Next I would like to add an attribute that indicates
the corresponding thread PID. To do that, I need a kernel function
that can be called to determine the IRQ thread ID.

I have just written and tested the following function for doing this:

#ifdef CONFIG_PREEMPT_HARDIRQS

pid_t get_irq_thread_pid(unsigned int irq, struct pid_namespace *ns)
{
         struct irq_desc *desc = irq_to_desc(irq);
         pid_t pid = 0;

         if(desc) {
                 unsigned long flags;
                 spin_lock_irqsave(&desc->lock, flags);
                 if(desc->thread)
                         pid = task_pid_nr_ns(desc->thread, ns);
                 spin_unlock_irqrestore(&desc->lock, flags);
         }
         return pid;
}

EXPORT_SYMBOL(get_irq_thread_pid);

#endif

This would most frequently be called like:

   pid = get_irq_thread_pid(irq, current->nsproxy->pid_ns);
   if(pid) {
     ...
   }

Would this function be acceptible for inclusion in the preempt-rt
kernel, or do you have something else in mind?

Martin
