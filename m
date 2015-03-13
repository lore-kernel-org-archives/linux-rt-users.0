From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 24/25] lockdep: selftest: fix warnings due to missing PREEMPT_RT
 conditionals
Date: Fri, 13 Mar 2015 11:18:49 -0400
Message-ID: <20150313151838.856970012@goodmis.org>
References: <20150313151825.583263173@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>,
	Josh Cartwright <josh.cartwright@ni.com>,
	Xander Huff <xander.huff@ni.com>,
	Gratian Crisan <gratian.crisan@ni.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0024-lockdep-selftest-fix-warnings-due-to-missing-PREEMPT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.68-rt99-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Josh Cartwright <josh.cartwright@ni.com>

"lockdep: Selftest: Only do hardirq context test for raw spinlock"
disabled the execution of certain tests with PREEMPT_RT_FULL, but did
not prevent the tests from still being defined.  This leads to warnings
like:

  ./linux/lib/locking-selftest.c:574:1: warning: 'irqsafe1_hard_rlock_12' defined but not used [-Wunused-function]
  ./linux/lib/locking-selftest.c:574:1: warning: 'irqsafe1_hard_rlock_21' defined but not used [-Wunused-function]
  ./linux/lib/locking-selftest.c:577:1: warning: 'irqsafe1_hard_wlock_12' defined but not used [-Wunused-function]
  ./linux/lib/locking-selftest.c:577:1: warning: 'irqsafe1_hard_wlock_21' defined but not used [-Wunused-function]
  ./linux/lib/locking-selftest.c:580:1: warning: 'irqsafe1_soft_spin_12' defined but not used [-Wunused-function]
  ...

Fixed by wrapping the test definitions in #ifndef CONFIG_PREEMPT_RT_FULL
conditionals.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
Signed-off-by: Xander Huff <xander.huff@ni.com>
Acked-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 lib/locking-selftest.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 507a22fab738..51e558f5c93d 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -570,6 +570,8 @@ GENERATE_TESTCASE(init_held_rsem)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_rlock)
 
@@ -585,9 +587,12 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 /*
  * Enabling hardirqs with a softirq-safe lock held:
  */
@@ -620,6 +625,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #undef E1
 #undef E2
 
+#endif
+
 /*
  * Enabling irqs with an irq-safe lock held:
  */
@@ -643,6 +650,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_rlock)
 
@@ -658,6 +667,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 
@@ -689,6 +700,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_rlock)
 
@@ -704,6 +717,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 #undef E3
@@ -737,6 +752,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_rlock)
 
@@ -752,10 +769,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 #undef E3
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 /*
  * read-lock / write-lock irq inversion.
  *
@@ -818,6 +839,10 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #undef E2
 #undef E3
 
+#endif
+
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 /*
  * read-lock / write-lock recursion that is actually safe.
  */
@@ -856,6 +881,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 #undef E2
 #undef E3
 
+#endif
+
 /*
  * read-lock / write-lock recursion that is unsafe.
  */
-- 
2.1.4
