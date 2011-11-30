From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Wed, 30 Nov 2011 17:10:17 -0500
Message-ID: <1322691017.24563.9.camel@frodo>
References: <4ECCE979.5080109@cedwards.geek.nz>
	 <1322056363.20742.45.camel@frodo>  <4ECD7DCC.3000505@ripples.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Chris Edwards <cedwards@ripples.dyndns.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:34815 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab1K3WKU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 17:10:20 -0500
In-Reply-To: <4ECD7DCC.3000505@ripples.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-11-24 at 12:12 +1300, Chris Edwards wrote:
> On 24/11/11 02:52, Steven Rostedt wrote:
> > On Thu, 2011-11-24 at 01:39 +1300, Chris Edwards wrote:
> >> Hi all,
> >>
> >> Problem:
> >> IRQ-related "nobody cared" kernel call traces not long after bootup on
> >> Linux 3.0.10-rt27.  I thought I'd try a -rt kernel to see if it would
> >> resolve the audio drop-outs on my new Firewire audio interface.
> > I wonder if this is another bad irq chipset. Does it go away if you boot
> > with noapic in the kernel command line?
> >
> 
> Thanks for the quick reply, Steven.  Booting with "noapic" does seem to 
> avoid the problem with IRQs 17 and 18, and the Firewire audio now works, 
> but the "nobody cared" error now appears for IRQ 7:

A couple of things:

Could you also try mainline, with "threadirqs" on the command line and
see if it gives you the same issue. It should also tell you if it is a
chipset problem or not. Try v3.0, and then v3.2.

Could you also apply the below patch to 3.0-rt. Thomas pointed me to the
following commits. The patch below is a back port of them.

 commit 52553ddff
 commit c75d720f

Oh, and remove the noapic from the command line when you do all of this.

Thanks,

-- Steve

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index e57f1b3..d09e0f5 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -84,7 +84,9 @@ static int try_one_irq(int irq, struct irq_desc *desc, bool force)
 	 */
 	action = desc->action;
 	if (!action || !(action->flags & IRQF_SHARED) ||
-	    (action->flags & __IRQF_TIMER) || !action->next)
+	    (action->flags & __IRQF_TIMER) ||
+	    (action->handler(irq, action->dev_id) == IRQ_HANDLED) ||
+	    !action->next)
 		goto out;
 
 	/* Already running on another processor */
@@ -115,7 +117,7 @@ static int misrouted_irq(int irq)
 	struct irq_desc *desc;
 	int i, ok = 0;
 
-	if (atomic_inc_return(&irq_poll_active) == 1)
+	if (atomic_inc_return(&irq_poll_active) != 1)
 		goto out;
 
 	irq_poll_cpu = smp_processor_id();


