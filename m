From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Possible bug in 23rt3 preempt-irqs-core.patch
Date: Thu, 25 Oct 2007 16:48:53 -0400
Message-ID: <20071025204853.GB12268@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [209.5.119.169] ([209.5.119.169]:30719 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751221AbXJYU7P (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 16:59:15 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I was looking over the patches in preempt-irqs-core.patch in the broken
out 23rt3 series and came across this chunk:

-----------
@@ -325,6 +349,11 @@ int setup_irq(unsigned int irq, struct i
        if (!shared) {
                irq_chip_set_defaults(desc->chip);
 
+       /*
+        * Propagate any possible IRQF_NODELAY flag into IRQ_NODELAY:
+        */
+       recalculate_desc_flags(desc);
+
 #if defined(CONFIG_IRQ_PER_CPU)
                if (new->flags & IRQF_PERCPU)
                        desc->status |= IRQ_PER_CPU;
-----------

Note the recalculate is actually contained within the "if (!shared)"
even though at a casual glance the indentation suggests otherwise.

Looking at older versions of the broken out patches leads me to believe
the if clause should be after the recalculate.  I've attached a patch to
do just that, but if you'd rather I just respin the preempt-irqs-core.patch
then I could just as easily do that as well.

Thanks,
Paul.


--- linux-2.6.23-rt3/kernel/irq/manage.c~
+++ linux-2.6.23-rt3/kernel/irq/manage.c
@@ -354,14 +354,14 @@
 	if (new->flags & IRQF_NOBALANCING)
 		desc->status |= IRQ_NO_BALANCING;
 
-	if (!shared) {
-		irq_chip_set_defaults(desc->chip);
-
 	/*
 	 * Propagate any possible IRQF_NODELAY flag into IRQ_NODELAY:
 	 */
 	recalculate_desc_flags(desc);
 
+	if (!shared) {
+		irq_chip_set_defaults(desc->chip);
+
 #if defined(CONFIG_IRQ_PER_CPU)
 		if (new->flags & IRQF_PERCPU)
 			desc->status |= IRQ_PER_CPU;
