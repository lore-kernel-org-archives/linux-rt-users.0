From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.6.3-rt6
Date: Tue, 23 Oct 2012 23:06:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210232301160.2756@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

I'm pleased to announce the 3.6.3-rt6 release. rt6 is just an update
to 3.6.3. The not announced 3.6.2-rt5 is an intermediate release with
a single change.

Changes since 3.6.2-rt4:

	* Make the early printk changes work (hopefully) everywhere

The new patch queue also contains a non code change (according to
Pauls) which adds a missing subject line to a powerpc patch.

The delta patch against 3.6.2-rt4 is appended below and can be found
here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/incr/patch-3.6.2-rt4-rt5.patch.xz

The RT patch against 3.6.3 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.3-rt6.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patches-3.6.3-rt6.tar.xz

Enjoy,

	tglx

---------->
Index: linux-stable/arch/mips/kernel/early_printk.c
===================================================================
--- linux-stable.orig/arch/mips/kernel/early_printk.c
+++ linux-stable/arch/mips/kernel/early_printk.c
@@ -8,6 +8,7 @@
  *   written by Ralf Baechle (ralf@linux-mips.org)
  */
 #include <linux/console.h>
+#include <linux/printk.h>
 #include <linux/init.h>
 
 #include <asm/setup.h>
Index: linux-stable/arch/tile/kernel/early_printk.c
===================================================================
--- linux-stable.orig/arch/tile/kernel/early_printk.c
+++ linux-stable/arch/tile/kernel/early_printk.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/irqflags.h>
+#include <linux/printk.h>
 #include <asm/setup.h>
 #include <hv/hypervisor.h>
 
Index: linux-stable/include/linux/printk.h
===================================================================
--- linux-stable.orig/include/linux/printk.h
+++ linux-stable/include/linux/printk.h
@@ -98,6 +98,7 @@ int no_printk(const char *fmt, ...)
 #ifdef CONFIG_EARLY_PRINTK
 extern asmlinkage __printf(1, 2)
 void early_printk(const char *fmt, ...);
+void early_vprintk(const char *fmt, va_list ap);
 extern void printk_kill(void);
 #else
 static inline __printf(1, 2) __cold
Index: linux-stable/kernel/printk.c
===================================================================
--- linux-stable.orig/kernel/printk.c
+++ linux-stable/kernel/printk.c
@@ -1228,7 +1228,7 @@ SYSCALL_DEFINE3(syslog, int, type, char 
 #ifdef CONFIG_EARLY_PRINTK
 struct console *early_console;
 
-static void early_vprintk(const char *fmt, va_list ap)
+void early_vprintk(const char *fmt, va_list ap)
 {
 	if (early_console) {
 		char buf[512];
Index: linux-stable/localversion-rt
===================================================================
--- linux-stable.orig/localversion-rt
+++ linux-stable/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
