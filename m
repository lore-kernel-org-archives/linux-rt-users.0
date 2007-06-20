From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] have x86_64 nmi watchdog also count irq 0
Date: Wed, 20 Jun 2007 14:51:03 -0400
Message-ID: <1182365463.15228.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:43558 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764376AbXFTSwN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jun 2007 14:52:13 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I was getting false reports about NMI lockups on CPU 3.  For some reason
CPU 0,1 and 2 where using apic timer, and CPU 3 was using the irq 0
timer.

This patch makes the NMI watchdog count both the apic timer and the irq0
timer.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6-rt-test/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6-rt-test.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6-rt-test/arch/x86_64/kernel/nmi.c
@@ -938,7 +938,7 @@ int notrace __kprobes nmi_watchdog_tick(
 		touched = 1;
 	}
 
-	sum = read_pda(apic_timer_irqs);
+	sum = read_pda(apic_timer_irqs) + kstat_cpu(cpu).irqs[0];
 
 	if (__get_cpu_var(nmi_touch)) {
 		__get_cpu_var(nmi_touch) = 0;
