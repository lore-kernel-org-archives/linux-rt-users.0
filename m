From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Why in 3.14 patch some things do not have compared with 3.2?
Date: Wed, 17 Sep 2014 17:08:16 +0400
Message-ID: <541987C0.7030201@pavlinux.ru>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:46655 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755613AbaIQNIh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Sep 2014 09:08:37 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Subj?


--- arch/x86/kernel/dumpstack_64.c 2014-03-08 12:54:32.968951000 +0400
+++ arch/x86/kernel/dumpstack_64.c 2012-03-22 00:09:30.000000000 +0400
@@ -21,10 +21,14 @@
                 (N_EXCEPTION_STACKS + DEBUG_STKSZ/EXCEPTION_STKSZ - 2)

  static char x86_stack_ids[][8] = {
+#if DEBUG_STACK > 0
                 [ DEBUG_STACK-1                 ]       = "#DB",
+#endif
                 [ NMI_STACK-1                   ]       = "NMI",
                 [ DOUBLEFAULT_STACK-1           ]       = "#DF",
+#if STACKFAULT_STACK > 0
                 [ STACKFAULT_STACK-1            ]       = "#SS",
+#endif
                 [ MCE_STACK-1                   ]       = "#MC",
  #if DEBUG_STKSZ > EXCEPTION_STKSZ
                 [ N_EXCEPTION_STACKS ...
--- arch/x86/kernel/cpu/common.c 2014-03-08 12:54:32.968951000 +0400
+++ arch/x86/kernel/cpu/common.c 2012-08-15 07:06:04.000000000 +0400
@@ -1051,7 +1051,9 @@
   */
  static const unsigned int exception_stack_sizes[N_EXCEPTION_STACKS] = {
           [0 ... N_EXCEPTION_STACKS - 1]        = EXCEPTION_STKSZ,
+#if DEBUG_STACK > 0
           [DEBUG_STACK - 1]                     = DEBUG_STKSZ
+#endif
  };

  static DEFINE_PER_CPU_PAGE_ALIGNED(char, exception_stacks
--- arch/x86/include/asm/page_64_types.h 2014-03-08 12:54:32.967951000 +0400
+++ arch/x86/include/asm/page_64_types.h 2012-03-22 00:09:30.000000000 +0400
@@ -14,12 +14,21 @@
  #define IRQ_STACK_ORDER 2
  #define IRQ_STACK_SIZE (PAGE_SIZE << IRQ_STACK_ORDER)

-#define STACKFAULT_STACK 1
-#define DOUBLEFAULT_STACK 2
-#define NMI_STACK 3
-#define DEBUG_STACK 4
-#define MCE_STACK 5
-#define N_EXCEPTION_STACKS 5  /* hw limit: 7 */
+#ifdef CONFIG_PREEMPT_RT_FULL
+# define STACKFAULT_STACK 0
+# define DOUBLEFAULT_STACK 1
+# define NMI_STACK 2
+# define DEBUG_STACK 0
+# define MCE_STACK 3
+# define N_EXCEPTION_STACKS 3  /* hw limit: 7 */
+#else
+# define STACKFAULT_STACK 1
+# define DOUBLEFAULT_STACK 2
+# define NMI_STACK 3
+# define DEBUG_STACK 4
+# define MCE_STACK 5
+# define N_EXCEPTION_STACKS 5  /* hw limit: 7 */
+#endif

  #define PUD_PAGE_SIZE          (_AC(1, UL) << PUD_SHIFT)
  #define PUD_PAGE_MASK          (~(PUD_PAGE_SIZE-1))


-- 

                                                          Pavel.
