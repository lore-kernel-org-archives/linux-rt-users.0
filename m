From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC] irq: Honor /proc/irq core affinity when an IRQ thread
 is created
Date: Tue, 4 Sep 2012 17:43:37 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1209041738200.2754@ionos>
References: <CAFQPvXe0siyupbZvnEVFQi-nog4qObGejX9HxgxeVgOphJoyTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52406 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab2IDPnj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Sep 2012 11:43:39 -0400
In-Reply-To: <CAFQPvXe0siyupbZvnEVFQi-nog4qObGejX9HxgxeVgOphJoyTA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 27 Aug 2012, Sankara Muthukrishnan wrote:

> Hi everyone,
> 
> I would like to get some feedback from the RT community before
> submitting to the mainline.
> 
> Currently, by writing to /proc/irq/../smp_affinity file, core affinity
> of already running IRQ threads can be modified. However, after writing
> to the /proc file, an IRQ thread that gets created later does not
> inherit the affinity specified in the file. This happens because the
> irq action is registered in irq description only after setup_affinity
> function is called. This patch addresses this problem by calling
> setup_affinity function after the irq action is updated in the irq
> description structure. It looks like the existing behavior (without
> this patch) is inconsistent because in the case of multiple action
> handlers for an irq, the IRQ thread associated with the new action
> handler that is being registered does not inherit the core affinity
> from the /proc file, however, the IRQ threads of the existing action
> handlers do inherit the affinity.

I understand the problem, but the proposed patch is not going to solve
it. setup_affinity() is just called in the !shared case, which is the
first action which is set up. So that works for the first irq, but not
for later ones.

Does the following patch fix the problem for both shared and non
shared interrupts ?
 
Thanks,

	tglx
---
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4c69326..a16ff28 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -936,6 +936,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 */
 		get_task_struct(t);
 		new->thread = t;
+		set_bit(IRQTF_AFFINITY, &new->thread_flags);
 	}
 
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
