From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] fix non SMP compile smp stubs
Date: Wed, 08 Aug 2007 15:01:07 -0400
Message-ID: <1186599667.29097.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58030 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763744AbXHHTBs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Aug 2007 15:01:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo,

Some compile errors in the smp stubs are fixed here:

I added the cpumask.h file so that it knows the cpumask_t type. I could
have just converted it to a macro do { } while(0), but I like having the
type check a NULL inline gives.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.23-rc2-rt2/include/linux/smp.h
===================================================================
--- linux-2.6.23-rc2-rt2.orig/include/linux/smp.h
+++ linux-2.6.23-rc2-rt2/include/linux/smp.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/cpumask.h>
 
 extern void cpu_idle(void);
 
@@ -116,7 +117,7 @@ static inline int up_smp_call_function(v
 	})
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_allbutself(void) { }
-static inline void smp_send_reschedule_allbutself_cpumask(cpumask_t) { }
+static inline void smp_send_reschedule_allbutself_cpumask(cpumask_t mask) { }
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)
 #define smp_call_function_single(cpuid, func, info, retry, wait) \
