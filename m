From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.6.5-rt10
Date: Fri, 5 Aug 2016 18:54:16 +0200
Message-ID: <20160805165416.GC21312@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39319 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbcHEQyU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Aug 2016 12:54:20 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT folks!

I'm pleased to announce the v4.6.5-rt10 patch set. 

Changes since v4.6.5-rt9:

  - Added missing cpu_light_get() in the scsi fcoe driver. Patch by Mike
    Galbraith.

  - Under a special a condition (a preempted TLB flush in do_exit()) it
    was possible on x86-UP to enter endless pagefaults. The pagefaults
    stopped after a context switch.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.6.5-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/incr/patch-4.6.5-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.6.5-rt10

The RT patch against 4.6.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patch-4.6.5-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patches-4.6.5-rt10.tar.xz

Sebastian

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 1fde8d580a5b..b202084a7c35 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -135,7 +135,14 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
 
 static inline void __native_flush_tlb(void)
 {
+	/*
+	 * if current->mm == NULL then we borrow a mm which may change during a
+	 * task switch and therefore we must not be preempted while we write CR3
+	 * back.
+	 */
+	preempt_disable();
 	native_write_cr3(native_read_cr3());
+	preempt_enable();
 }
 
 static inline void __native_flush_tlb_global_irq_disabled(void)
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 3d232657218d..908056efbaf8 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1814,7 +1814,7 @@ static void fcoe_recv_frame(struct sk_buff *skb)
 	 */
 	hp = (struct fcoe_hdr *) skb_network_header(skb);
 
-	stats = per_cpu_ptr(lport->stats, get_cpu());
+	stats = per_cpu_ptr(lport->stats, get_cpu_light());
 	if (unlikely(FC_FCOE_DECAPS_VER(hp) != FC_FCOE_VER)) {
 		if (stats->ErrorFrames < 5)
 			printk(KERN_WARNING "fcoe: FCoE version "
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a4..d79dde624aaa 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
