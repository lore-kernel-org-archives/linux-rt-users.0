From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: ARM 920T build problems for patch-2.6.19-rt1 - the second try
Date: Fri, 15 Dec 2006 21:53:45 +0100
Message-ID: <200612152153.45910.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:59295 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964866AbWLOVZw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 16:25:52 -0500
Content-Disposition: inline
To: linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Ingo and Thomas,

I have tried 2.6.19-rt14 patches on our PiMX1 ARM board.
I have been able to fix some build problems and run the kernel.
I have added support for high resolution time sources and
time events for i.MX platform.

As I have reported some week ago, there is required next
change to compile RT kernel for ARM (at least for <ARMv6).

Index: linux-2.6.19-rt/include/asm-arm/atomic.h
===================================================================
--- linux-2.6.19-rt.orig/include/asm-arm/atomic.h
+++ linux-2.6.19-rt/include/asm-arm/atomic.h
@@ -188,10 +188,10 @@ static inline unsigned long __cmpxchg(vo
 	volatile unsigned long *p = ptr;
 
 	if (size == 4) {
-		local_irq_save(flags);
+		raw_local_irq_save(flags);
 		if ((prev = *p) == old)
 			*p = new;
-		local_irq_restore(flags);
+		raw_local_irq_restore(flags);
 		return(prev);
 	} else
 		return wrong_size_cmpxchg(ptr);
===================================================================

Even with this patch there are some missing symbols during link stage:
  warp_check_clock_was_changed
  usecs_to_cycles

The next changes allowed me to build ARM kernel with included
high resolution timers for our board.

Index: linux-2.6.19-rt/kernel/hrtimer.c
===================================================================
--- linux-2.6.19-rt.orig/kernel/hrtimer.c
+++ linux-2.6.19-rt/kernel/hrtimer.c
@@ -33,6 +33,7 @@
 
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
 #include <linux/hrtimer.h>
Index: linux-2.6.19-rt/arch/arm/Kconfig
===================================================================
--- linux-2.6.19-rt.orig/arch/arm/Kconfig
+++ linux-2.6.19-rt/arch/arm/Kconfig
@@ -19,7 +19,11 @@ config ARM
 
 config GENERIC_TIME
 	bool
-	default n
+	default y
+
+config GENERIC_CLOCKEVENTS
+	bool
+	default y
 
 config MMU
 	bool
@@ -203,6 +207,7 @@ config ARCH_H720X
 
 config ARCH_IMX
 	bool "IMX"
+	select GENERIC_TIME
 	help
 	  Support for Motorola's i.MX family of processors (MX1, MXL).
 
@@ -489,6 +494,8 @@ config LOCAL_TIMERS
 
 source kernel/Kconfig.preempt
 
+source kernel/time/Kconfig
+
 config NO_IDLE_HZ
 	bool "Dynamic tick timer"
 	help
===================================================================

The kernel has been able to boot and mount NFS volume.
I have run cyclic test from it.

Cyclic test shows maximal latencies under 400 usec
for 200 MHz clock ARM920T MX1 processor on PiMX1 board
which is quite good for board, which has been build mainly
for low consumption with only 16-bit wide SDRAM.
But I have not tortured board too much during test yet.
There has been some Ethernet communication and dhrystone
test running in parallel.

Is it possible to include the first part of the patch
into RT patches to allow build for ARM.

Is it possible to provide right solution of Kbuild options
for ARM?

Can I send somewhere my i.MX high resolution time events
patch or should I wait for high resolution timers acceptance
and iclusion in vanilla?
i.MX time source patch is already included in vanilla
2.6.20-rc1 through Russell's patch queue.

I have yet another patch for Elan SC520 high resolution
time source, it usable even with vanilla kernel.
Where should be this patch sent to be included
in vanilla?

Thanks for nice work and best wishes

		                  Pavel

--
                Pavel Pisa
        e-mail: pisa@cmp.felk.cvut.cz
        www:    http://cmp.felk.cvut.cz/~pisa
        work:   http://www.pikron.com
