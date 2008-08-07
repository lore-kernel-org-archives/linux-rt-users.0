From: "Christian Volk" <linux.kernel@cvolk.de>
Subject: Preempt-RT with Linux 2.6.20 for Arch ppc
Date: Thu, 7 Aug 2008 09:12:34 +0200 (MEST)
Message-ID: <200808070712.m777CYTK008184@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from em-p00-ob.rzone.de ([81.169.146.224]:46918 "EHLO
	em-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbYHGH2e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Aug 2008 03:28:34 -0400
Received: from post.webmailer.de (hat.store [192.168.40.68])
	by bjorn-em-01.store (RZmta 16.42) with ESMTP id a04f4dk76FIxVi
	for <linux-rt-users@vger.kernel.org>;
	Thu, 7 Aug 2008 09:28:32 +0200 (MEST)
	(envelope-from: <linux.kernel@cvolk.de>)
Received: (from httpd@localhost)
	by post.webmailer.de (8.13.7/8.13.6) id m777CYTK008184
	for linux-rt-users@vger.kernel.org; Thu, 7 Aug 2008 09:12:34 +0200 (MEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

actually I try to get the preempt patch running with kernel 2.6.20 for arch ppc.
I got the Kernel running right now, but I don't know if I did the right changes.
Maybe someone can take a look and give me some hints, if I'm wrong.
The Changes I Made(diff against the preempt_rt patched kernel):
in irqflags.h:
----------------------------------------------

--- /home/develop/Download/linux-2.6.20/include/linux/irqflags.h        2008-08-06 08:55:07.000000000 +0200
+++ /mnt/cc_views/linux-basis/build/linux-base-system/smb_preempt/linux-2.6.20/include/linux/irqflags.h 2008-08-06 15:56:22.000000000 +0200
@@ -62,37 +62,7 @@
                trace_hardirqs_off();           \
        } while (0)

-#define local_irq_restore(flags)                               \
-       do {                                                    \
-               BUILD_CHECK_IRQ_FLAGS(flags);                   \
-               if (raw_irqs_disabled_flags(flags)) {           \
-                       raw_local_irq_restore(flags);           \
-                       trace_hardirqs_off();                   \
-               } else {                                        \
-                       trace_hardirqs_on();                    \
-                       raw_local_irq_restore(flags);           \
-               }                                               \
-       } while (0)
-#else /* !CONFIG_TRACE_IRQFLAGS_SUPPORT */
-/*
- * The local_irq_*() APIs are equal to the raw_local_irq*()
- * if !TRACE_IRQFLAGS.
- */
-# define raw_local_irq_disable()       local_irq_disable()
-# define raw_local_irq_enable()                local_irq_enable()
-# define raw_local_irq_save(flags)             \
-       do {                                    \
-               BUILD_CHECK_IRQ_FLAGS(flags);   \
-               local_irq_save(flags);          \
-       } while (0)
-# define raw_local_irq_restore(flags)          \
-       do {                                    \
-               BUILD_CHECK_IRQ_FLAGS(flags);   \
-               local_irq_restore(flags);       \
-       } while (0)
-#endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */

-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 #define safe_halt()                                            \
        do {                                                    \
                trace_hardirqs_on();                            \
@@ -118,6 +88,41 @@
        BUILD_CHECK_IRQ_FLAGS(flags);   \
        raw_irqs_disabled_flags(flags); \
 })
-#endif         /* CONFIG_X86 */
+
+#else /* !CONFIG_TRACE_IRQFLAGS_SUPPORT */
+/*
+ * The local_irq_*() APIs are equal to the raw_local_irq*()
+ * if !TRACE_IRQFLAGS.
+ */
+#define local_irq_disable()            raw_local_irq_disable()
+#define local_irq_enable()             raw_local_irq_enable()
+
+#define local_irq_save(flags)          \
+       do {                                    \
+               BUILD_CHECK_IRQ_FLAGS(flags);   \
+               raw_local_irq_save(flags);              \
+       } while (0)
+
+#define local_save_flags(flags)                        \
+       do {                                    \
+               BUILD_CHECK_IRQ_FLAGS(flags);   \
+               raw_local_save_flags(flags);    \
+       } while (0)
+
+#define local_irq_restore(flags)               \
+       do {                                    \
+               BUILD_CHECK_IRQ_FLAGS(flags);   \
+               raw_local_irq_restore(flags);   \
+       } while (0)
+
+#define irqs_disabled()                                                \
+({                                                             \
+       unsigned long flags;                                    \
+                                                               \
+       raw_local_save_flags(flags);                            \
+       raw_irqs_disabled_flags(flags);                         \
+})
+
+#endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */

 #endif


What Im wondering about is that only the names Changed form "local_....." to "raw_local..." and then some new defines are created where the "local_..." stuff calls the "raw_local_..." stuff. Is this the correct behaviour??
  
Thanks in advance,

Christian


