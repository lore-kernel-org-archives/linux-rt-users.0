From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 20:12:20 +0200
Message-ID: <200709172012.21102.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51340 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044AbXIQSM0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 14:12:26 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

When the kernel is oopsing no realtime guarantees are needed anymore and sleeping
here is unsafe; e.g. in case the crash site had interrupts disabled.

- Convert die_lock to a raw spinlock
- Really disable interrupts

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.23-rc4-rt1/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.23-rc4-rt1.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.23-rc4-rt1/arch/x86_64/kernel/traps.c
@@ -467,7 +467,7 @@ void out_of_line_bug(void)
 EXPORT_SYMBOL(out_of_line_bug);
 #endif
 
-static DEFINE_SPINLOCK(die_lock);
+static __raw_spinlock_t die_lock = __RAW_SPIN_LOCK_UNLOCKED;
 static int die_owner = -1;
 static unsigned int die_nest_count;
 
@@ -479,13 +479,13 @@ unsigned __kprobes long oops_begin(void)
 	oops_enter();
 
 	/* racy, but better than risking deadlock. */
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	cpu = smp_processor_id();
-	if (!spin_trylock(&die_lock)) { 
+	if (!__raw_spin_trylock(&die_lock)) { 
 		if (cpu == die_owner) 
 			/* nested oops. should stop eventually */;
 		else
-			spin_lock(&die_lock);
+			__raw_spin_lock(&die_lock);
 	}
 	die_nest_count++;
 	die_owner = cpu;
@@ -499,12 +499,10 @@ void __kprobes oops_end(unsigned long fl
 	die_owner = -1;
 	bust_spinlocks(0);
 	die_nest_count--;
-	if (die_nest_count)
-		/* We still own the lock */
-		local_irq_restore(flags);
-	else
+	if (!die_nest_count)
 		/* Nest count reaches zero, release the lock. */
-		spin_unlock_irqrestore(&die_lock, flags);
+		__raw_spin_unlock(&die_lock);
+	raw_local_irq_restore(flags);
 	if (panic_on_oops)
 		panic("Fatal exception");
 	oops_exit();
