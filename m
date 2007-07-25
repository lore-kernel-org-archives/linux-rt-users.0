From: Joe Korty <joe.korty@ccur.com>
Subject: [PATCH 1/3] mitigate-resched-interrupt-floods
Date: Wed, 25 Jul 2007 16:58:14 -0400
Message-ID: <20070725205814.GA9021@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, sdietrich@novell.com,
	linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from users.ccur.com ([66.10.65.2]:37156 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751633AbXGYVQx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 17:16:53 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Mitigate rescheduling interrupt floods.

Background: preempt-rt sends a resched interrupt to all
other cpus whenever some realtime task gets preempted.
This is to give that task a chance to continue running
on some other cpu.  Unfortunately this can cause 'resched
interrupt floods' when there are large numbers of realtime
tasks on the system that are continually being preempted.

This patch reduces such interrupts by noting that it is
not necessary to send rescheduling interrupts to every cpu
in the system, just to those cpus in the affinity mask of
the task to be migrated.

This works well in the real world, as traditionally
realtime tasks are carefully targeted to specific cpus or
sets of cpus, meaning users often give such tasks reduced
affinity masks.

Signed-off-by: Joe Korty <joe.korty@ccur.com>

Index: 2.6.22.1-rt8/arch/i386/kernel/smp.c
===================================================================
--- 2.6.22.1-rt8.orig/arch/i386/kernel/smp.c	2007-07-25 13:24:57.000000000 -0400
+++ 2.6.22.1-rt8/arch/i386/kernel/smp.c	2007-07-25 16:23:21.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/cache.h>
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/module.h>
 
 #include <asm/mtrr.h>
@@ -483,6 +484,14 @@
 	send_IPI_allbutself(RESCHEDULE_VECTOR);
 }
 
+void smp_send_reschedule_allbutself_cpumask(cpumask_t mask)
+{
+	cpu_clear(smp_processor_id(), mask);
+	cpus_and(mask, mask, cpu_online_map);
+	if (!cpus_empty(mask))
+		send_IPI_mask(mask, RESCHEDULE_VECTOR);
+}
+
 /*
  * Structure and data for smp_call_function(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
Index: 2.6.22.1-rt8/arch/x86_64/kernel/smp.c
===================================================================
--- 2.6.22.1-rt8.orig/arch/x86_64/kernel/smp.c	2007-07-25 13:24:57.000000000 -0400
+++ 2.6.22.1-rt8/arch/x86_64/kernel/smp.c	2007-07-25 16:23:21.000000000 -0400
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
+#include <linux/cpumask.h>
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
 #include <linux/interrupt.h>
@@ -304,6 +305,14 @@
 	send_IPI_allbutself(RESCHEDULE_VECTOR);
 }
 
+void smp_send_reschedule_allbutself_cpumask(cpumask_t mask)
+{
+	cpu_clear(smp_processor_id(), mask);
+	cpus_and(mask, mask, cpu_online_map);
+	if (!cpus_empty(mask))
+		send_IPI_mask(mask, RESCHEDULE_VECTOR);
+}
+
 /*
  * Structure and data for smp_call_function(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
Index: 2.6.22.1-rt8/include/linux/smp.h
===================================================================
--- 2.6.22.1-rt8.orig/include/linux/smp.h	2007-07-25 13:24:57.000000000 -0400
+++ 2.6.22.1-rt8/include/linux/smp.h	2007-07-25 13:49:07.000000000 -0400
@@ -43,6 +43,14 @@
  */
 extern void smp_send_reschedule_allbutself(void);
 
+#ifdef HAVE_RESCHEDULE_ALLBUTSELF_CPUMASK
+extern void smp_send_reschedule_allbutself_cpumask(cpumask_t);
+#else
+static inline void smp_send_reschedule_allbutself_cpumask(cpumask_t mask) {
+	smp_send_reschedule_allbutself();
+}
+#endif
+
 
 /*
  * Prepare machine for booting other CPUs.
@@ -108,6 +116,7 @@
 	})
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_allbutself(void) { }
+static inline void smp_send_reschedule_allbutself_cpumask(cpumask_t) { }
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)
 static inline int smp_call_function_single(int cpuid, void (*func) (void *info),
Index: 2.6.22.1-rt8/kernel/sched.c
===================================================================
--- 2.6.22.1-rt8.orig/kernel/sched.c	2007-07-25 13:24:58.000000000 -0400
+++ 2.6.22.1-rt8/kernel/sched.c	2007-07-25 13:41:39.000000000 -0400
@@ -1858,7 +1858,7 @@
 			 * nevertheless, maybe one of them can take
 			 * this task:
 			 */
-			smp_send_reschedule_allbutself();
+			smp_send_reschedule_allbutself_cpumask(p->cpus_allowed);
 
 		schedstat_inc(this_rq, rto_wakeup);
 	}
@@ -2116,7 +2116,7 @@
 	 */
 	if (unlikely(rt_task(current) && prev->se.on_rq && rt_task(prev))) {
 		schedstat_inc(rq, rto_schedule);
-		smp_send_reschedule_allbutself();
+		smp_send_reschedule_allbutself_cpumask(current->cpus_allowed);
 	}
 #endif
 	prev_state = prev->state;
Index: 2.6.22.1-rt8/include/asm-i386/smp.h
===================================================================
--- 2.6.22.1-rt8.orig/include/asm-i386/smp.h	2007-07-08 19:32:17.000000000 -0400
+++ 2.6.22.1-rt8/include/asm-i386/smp.h	2007-07-25 13:52:13.000000000 -0400
@@ -174,4 +174,6 @@
 #endif
 #endif
 
+#define HAVE_RESCHEDULE_ALLBUTSELF_CPUMASK 1
+
 #endif
Index: 2.6.22.1-rt8/include/asm-x86_64/smp.h
===================================================================
--- 2.6.22.1-rt8.orig/include/asm-x86_64/smp.h	2007-07-08 19:32:17.000000000 -0400
+++ 2.6.22.1-rt8/include/asm-x86_64/smp.h	2007-07-25 13:53:05.000000000 -0400
@@ -113,5 +113,8 @@
 #else
 #define cpu_physical_id(cpu)		boot_cpu_id
 #endif /* !CONFIG_SMP */
+
+#define HAVE_RESCHEDULE_ALLBUTSELF_CPUMASK 1
+
 #endif
 
