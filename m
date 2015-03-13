From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 26/27] lockdep: selftest: fix warnings due to missing PREEMPT_RT
 conditionals
Date: Fri, 13 Mar 2015 11:18:07 -0400
Message-ID: <20150313151759.461885617@goodmis.org>
References: <20150313151741.132137234@goodmis.org>
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
Content-Disposition: inline; filename=0026-lockdep-selftest-fix-warnings-due-to-missing-PREEMPT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.4.106-rt132-rc1 stable review patch.
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
index 23b856400e5c..3508e2c80465 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -569,6 +569,8 @@ GENERATE_TESTCASE(init_held_rsem)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_hard_rlock)
 
@@ -584,9 +586,12 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe1_soft_rlock)
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
@@ -619,6 +624,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #undef E1
 #undef E2
 
+#endif
+
 /*
  * Enabling irqs with an irq-safe lock held:
  */
@@ -642,6 +649,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2A_rlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_hard_rlock)
 
@@ -657,6 +666,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 
@@ -688,6 +699,8 @@ GENERATE_PERMUTATIONS_2_EVENTS(irqsafe2B_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_hard_rlock)
 
@@ -703,6 +716,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_rlock)
 #include "locking-selftest-wlock-softirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 
+#endif
+
 #undef E1
 #undef E2
 #undef E3
@@ -736,6 +751,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe3_soft_wlock)
 #include "locking-selftest-spin-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_spin)
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 #include "locking-selftest-rlock-hardirq.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_hard_rlock)
 
@@ -751,10 +768,14 @@ GENERATE_PERMUTATIONS_3_EVENTS(irqsafe4_soft_rlock)
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
@@ -817,6 +838,10 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #undef E2
 #undef E3
 
+#endif
+
+#ifndef CONFIG_PREEMPT_RT_FULL
+
 /*
  * read-lock / write-lock recursion that is actually safe.
  */
@@ -855,6 +880,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 #undef E2
 #undef E3
 
+#endif
+
 /*
  * read-lock / write-lock recursion that is unsafe.
  */
-- 
2.1.4
