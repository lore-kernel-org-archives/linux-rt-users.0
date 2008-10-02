From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH/RFC] init_hardirqs shouldn't call start_irq_thread
Date: Wed, 1 Oct 2008 23:01:22 -0400
Message-ID: <20081002030121.GB5012@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [128.224.252.2] ([128.224.252.2]:48508 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751764AbYJBDBY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Oct 2008 23:01:24 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This might be interesting to anyone who has seen sporadic boot failures
with the RT patches (of any version).  I was trying to solve such a
problem earlier this week and eventually came up with this.

I found that in the 2.6.27-rcN patchset, that we could end up with
the timer IRQ threaded, even though it was explicitly IRQF_NODELAY.
[As an interesting side note, with an SMP configuration, the boot
would suprisingly be OK with the timer IRQ as threaded...]

Looking at the 2.6.26.5 patchset, I see nothing different there which
would indicate the problem is 2.6.27 specific.  I've not been able to
re-create the problem on 2.6.26.5; however I did test that the same
fix below applies to the 2.6.26.5-rt9 and doesn't obviously break
anything.

Paul.

----------

commit e33ed4611eb24fc267ef8326572d488588f37959
Author: Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Wed Oct 1 19:30:52 2008 -0700

    There are two ways that start_irq_thread() can be called; either
    as a part of setup_irq() for flags !IRQF_NODELAY, or as a blanket
    walk over NR_IRQS for status !IRQ_NODELAY from init_hardirqs().
    The printk timestamps will confirm that either may get there 1st.
    
    The problem is that if the latter gets there 1st, the IRQF_NODELAY
    may not have propagated from flags to an IRQ_NODELAY in status, and
    you end up with an IRQ-0 thread for the timer IRQ, even though it
    should be IRQF_NODELAY and have no IRQ-0 thread.  The threaded IRQ-0
    eventually blows up when tick_periodic() does the following:
    
            update_process_times(user_mode(get_irq_regs()));
    
    and this results in a trace that looks like the attached.  I've
    simply stubbed out the seemingly needless init_hardirqs() to be
    just a barrier so it checks on proper ordering and now the boot time
    failures are gone.
    
    [    0.062407] BUG: unable to handle kernel NULL pointer dereference at 00000030
    [    0.062990] IP: [<c0230385>] tick_periodic+0x63/0x79
    [    0.062990] *pde = 00000000
    [    0.062990] Oops: 0000 [#1] PREEMPT
    [    0.062990]
    [    0.062990] Pid: 3, comm: IRQ-0 Not tainted (2.6.27-rc8-26rt9 #3)
    [    0.062990] EIP: 0060:[<c0230385>] EFLAGS: 00010246 CPU: 0
    [    0.062990] EIP is at tick_periodic+0x63/0x79
    [    0.062990] Call Trace:
    [    0.062990]  [<c02303b3>] ? tick_handle_periodic+0x18/0x5d
    [    0.062990]  [<c0205525>] ? timer_interrupt+0x19/0x20
    [    0.062990]  [<c0238b3d>] ? handle_IRQ_event+0x45/0xb6
    [    0.062990]  [<c0239386>] ? do_irqd+0x0/0x270
    [    0.062990]  [<c0238f6d>] ? thread_simple_irq+0x5a/0x93
    
    Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4d1ffd1..ae0c6a8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -902,9 +902,11 @@ static int ok_to_create_irq_threads;
 
 static int start_irq_thread(int irq, struct irq_desc *desc)
 {
-	if (desc->thread || !ok_to_create_irq_threads)
+	if (desc->thread)
 		return 0;
 
+	BUG_ON(!ok_to_create_irq_threads);
+
 	desc->thread = kthread_create(do_irqd, desc, "IRQ-%d", irq);
 	if (!desc->thread) {
 		printk(KERN_ERR "irqd: could not create IRQ thread %d!\n", irq);
@@ -924,15 +926,7 @@ static int start_irq_thread(int irq, struct irq_desc *desc)
 
 void __init init_hardirqs(void)
 {
-	int i;
 	ok_to_create_irq_threads = 1;
-
-	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
