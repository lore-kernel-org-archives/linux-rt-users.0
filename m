From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2.6.23-rc2-rt2] misc. compile fixes for UP builds
Date: Thu, 16 Aug 2007 16:39:31 -0700
Message-ID: <20070816233931.552072046@mvista.com>
Cc: RT-Users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:37510 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754519AbXHPXjs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Aug 2007 19:39:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 include/linux/percpu_list.h |    2 +-
 include/linux/smp.h         |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: dev/include/linux/percpu_list.h
===================================================================
--- dev.orig/include/linux/percpu_list.h
+++ dev/include/linux/percpu_list.h
@@ -84,7 +84,7 @@ void percpu_list_fold(struct percpu_list
 
 struct percpu_list {
 	struct lock_list_head list;
-}
+};
 
 static inline
 void percpu_list_init(struct percpu_list *pcl)
Index: dev/include/linux/smp.h
===================================================================
--- dev.orig/include/linux/smp.h
+++ dev/include/linux/smp.h
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
--
