From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] Use raw spinlocks in NMI print sequencing.
Date: Tue, 19 Jun 2007 16:11:34 -0400
Message-ID: <1182283894.15228.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:40301 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761233AbXFSUMM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jun 2007 16:12:12 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Currently NMI uses spinlocks to serialize the prints. We need these to
be raw spinlocks for PREEMPT_RT

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.21-rt9/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.21-rt9.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.21-rt9/arch/x86_64/kernel/nmi.c
@@ -949,7 +949,7 @@ int __kprobes nmi_watchdog_tick(struct p
 	}
 
 	if (cpu_isset(cpu, backtrace_mask)) {
-		static DEFINE_SPINLOCK(lock);	/* Serialise the printks */
+		static DEFINE_RAW_SPINLOCK(lock);	/* Serialise the printks */
 
 		spin_lock(&lock);
 		printk("NMI backtrace for cpu %d\n", cpu);
