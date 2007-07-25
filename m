From: Joe Korty <joe.korty@ccur.com>
Subject: [PATCH 3/3] proc-interrupts-add-names
Date: Wed, 25 Jul 2007 16:58:19 -0400
Message-ID: <20070725205819.GA9042@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, sdietrich@novell.com,
	linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from users.ccur.com ([66.10.65.2]:37156 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756483AbXGYVQ6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 17:16:58 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Describe all /proc/interrupt vectors.

Append a short description to those /proc/interrupts
vectors which don't have such.

This affects only special vectors such as the cross
processor interrupt.  Device vectors, such as eth0,
already have descriptive names.

Signed-off-by: Joe Korty <joe.korty@ccur.com>

Index: 2.6.22.1-rt8/arch/i386/kernel/irq.c
===================================================================
--- 2.6.22.1-rt8.orig/arch/i386/kernel/irq.c	2007-07-25 16:23:12.000000000 -0400
+++ 2.6.22.1-rt8/arch/i386/kernel/irq.c	2007-07-25 16:23:17.000000000 -0400
@@ -303,13 +303,13 @@
 		seq_printf(p, "NMI: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", nmi_count(j));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Non-maskable interrupts\n");
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				per_cpu(irq_stat,j).apic_timer_irqs);
-		seq_putc(p, '\n');
+		seq_printf(p, "  Local interrupts\n");
 #endif
 #ifdef CONFIG_SMP
 #ifdef RESCHEDULE_VECTOR
@@ -317,7 +317,7 @@
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				atomic_read(&per_cpu(irq_resched_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Rescheduling interrupts\n");
 #endif
 #endif
 #ifdef CONFIG_SMP
@@ -326,7 +326,7 @@
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				atomic_read(&per_cpu(irq_call_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  function call interrupts\n");
 #endif
 #endif
 #ifdef CONFIG_SMP
@@ -335,7 +335,7 @@
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				atomic_read(&per_cpu(irq_tlb_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  TLB shootdowns\n");
 #endif
 #endif
 #ifdef THERMAL_APIC_VECTOR
@@ -343,28 +343,28 @@
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				atomic_read(&per_cpu(irq_thermal_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Thermal event interrupts\n");
 #endif
 #ifdef SPURIOUS_APIC_VECTOR
 		seq_printf(p, "SPU: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				atomic_read(&per_cpu(irq_spur_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Spurious interrupts\n");
 #endif
 #ifdef ERROR_APIC_VECTOR
 		seq_printf(p, "ERR: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				atomic_read(&per_cpu(irq_err_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Error interrupts\n");
 #endif
 #if defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
 		seq_printf(p, "MIS: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				atomic_read(&per_cpu(irq_mis_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  APIC errata fixups\n");
 #endif
 	}
 	return 0;
Index: 2.6.22.1-rt8/arch/x86_64/kernel/irq.c
===================================================================
--- 2.6.22.1-rt8.orig/arch/x86_64/kernel/irq.c	2007-07-25 16:23:12.000000000 -0400
+++ 2.6.22.1-rt8/arch/x86_64/kernel/irq.c	2007-07-25 16:23:17.000000000 -0400
@@ -99,17 +99,17 @@
 		seq_printf(p, "NMI: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", cpu_pda(j)->__nmi_count);
-		seq_putc(p, '\n');
+		seq_printf(p, "  Non-maskable interrupts\n");
 		seq_printf(p, "LOC: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", cpu_pda(j)->apic_timer_irqs);
-		seq_putc(p, '\n');
+		seq_printf(p, "  Local interrupts\n");
 #ifdef CONFIG_SMP
 #ifdef RESCHEDULE_VECTOR
 		seq_printf(p, "RES: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", atomic_read(&per_cpu(irq_resched_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Rescheduling interrupts\n");
 #endif
 #endif
 #ifdef CONFIG_SMP
@@ -117,7 +117,7 @@
 		seq_printf(p, "CAL: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", atomic_read(&per_cpu(irq_call_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  function call interrupts\n");
 #endif
 #endif
 #ifdef CONFIG_SMP
@@ -125,39 +125,39 @@
 		seq_printf(p, "TLB: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", atomic_read(&per_cpu(irq_tlb_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  TLB shootdowns\n");
 #endif
 #endif
 #ifdef THERMAL_APIC_VECTOR
 		seq_printf(p, "TRM: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", atomic_read(&per_cpu(irq_thermal_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Thermal event interrupts\n");
 #endif
 #ifdef THRESHOLD_APIC_VECTOR
 		seq_printf(p, "THR: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", atomic_read(&per_cpu(irq_threshold_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Threshold APIC interrupts\n");
 #endif
 #ifdef SPURIOUS_APIC_VECTOR
 		seq_printf(p, "SPU: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", atomic_read(&per_cpu(irq_spur_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Spurious interrupts\n");
 #endif
 #ifdef ERROR_APIC_VECTOR
 		seq_printf(p, "ERR: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", atomic_read(&per_cpu(irq_err_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  Error interrupts\n");
 #endif
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
 		seq_printf(p, "MIS: ");
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", atomic_read(&per_cpu(irq_mis_counts, j)));
-		seq_putc(p, '\n');
+		seq_printf(p, "  APIC errata fixups\n");
 #endif
 #endif
 	}
