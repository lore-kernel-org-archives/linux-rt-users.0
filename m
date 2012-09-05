From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: [PATCH RFC] irq: Honor /proc/irq core affinity when an IRQ thread
 is created
Date: Wed, 5 Sep 2012 15:28:07 -0500
Message-ID: <CAFQPvXdrxEpD-LSnsZGE-s7JVHWJz5qOP=ZPiwB+UC5nXAm5Dw@mail.gmail.com>
References: <CAFQPvXe0siyupbZvnEVFQi-nog4qObGejX9HxgxeVgOphJoyTA@mail.gmail.com>
	<alpine.LFD.2.02.1209041738200.2754@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59024 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759404Ab2IEU2H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2012 16:28:07 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so600013dad.19
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Sep 2012 13:28:07 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1209041738200.2754@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Sep 4, 2012 at 10:43 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 27 Aug 2012, Sankara Muthukrishnan wrote:
>
> > Hi everyone,
> >
> > I would like to get some feedback from the RT community before
> > submitting to the mainline.
> >
> > Currently, by writing to /proc/irq/../smp_affinity file, core affinity
> > of already running IRQ threads can be modified. However, after writing
> > to the /proc file, an IRQ thread that gets created later does not
> > inherit the affinity specified in the file. This happens because the
> > irq action is registered in irq description only after setup_affinity
> > function is called. This patch addresses this problem by calling
> > setup_affinity function after the irq action is updated in the irq
> > description structure. It looks like the existing behavior (without
> > this patch) is inconsistent because in the case of multiple action
> > handlers for an irq, the IRQ thread associated with the new action
> > handler that is being registered does not inherit the core affinity
> > from the /proc file, however, the IRQ threads of the existing action
> > handlers do inherit the affinity.
>
> I understand the problem, but the proposed patch is not going to solve
> it. setup_affinity() is just called in the !shared case, which is the
> first action which is set up. So that works for the first irq, but not
> for later ones.
>
> Does the following patch fix the problem for both shared and non
> shared interrupts ?

Thanks Thomas. Your suggestion works for non-shared. I do not have
devices sharing interrupts on my board to quickly verify. However, I
hacked a kernel module to simulate shared irq's and the kernel source
(to set the affinity before waiting for interrupts in the irq thread)
and verified that it works for "shared interrupts" also.

However, I was wondering whether we are relaxing some checks that
setup_affinity does (like checking for flags such as
IRQD_NO_BALANCING) by setting the flag IRQTF_AFFINITY after creating
the kernel thread directly as you suggested. May be, it does not have
practical implications. But, I was wondering whether it is a good idea
to go through all the checks as the checks are done when someone
writes to /proc/irq/.../smp_affinity file for consistency. Is the
following patch a bad idea (basically call setup_affinity for both
shared and non-shared interrupts)? This also works in my testing. I am
curious why "setup_affinity" was called only under "if (!shared)" case
in the released kernel.

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 87dc0539cebb26bd7122e1f2a608be7325ade437..05c64c5fc2be5c2db34e74e5a5f4d3c6f9c74bca
100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1083,9 +1083,6 @@ __setup_irq(unsigned int irq, struct irq_desc
*desc, struct irqaction *new)
         if (new->flags & IRQF_NO_SOFTIRQ_CALL)
             irq_settings_set_no_softirq_call(desc);

-        /* Set default affinity mask once everything is setup */
-        setup_affinity(irq, desc, mask);
-
     } else if (new->flags & IRQF_TRIGGER_MASK) {
         unsigned int nmsk = new->flags & IRQF_TRIGGER_MASK;
         unsigned int omsk = irq_settings_get_trigger_mask(desc);
@@ -1099,6 +1096,17 @@ __setup_irq(unsigned int irq, struct irq_desc
*desc, struct irqaction *new)
     new->irq = irq;
     *old_ptr = new;

+    /* Set default affinity mask once everything is setup.
+    setup_affinity(irq, desc, mask);

     /* Reset broken irq detection when installing new handler */
     desc->irq_count = 0;
     desc->irqs_unhandled = 0;



>
> Thanks,
>
>         tglx
> ---
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 4c69326..a16ff28 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -936,6 +936,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>                  */
>                 get_task_struct(t);
>                 new->thread = t;
> +               set_bit(IRQTF_AFFINITY, &new->thread_flags);
>         }
>
>         if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
