From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 01/10] [ARM] add missing includes
Date: Fri, 15 Dec 2006 23:36:59 +0100
Message-ID: <20061215224324.536081000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51232 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030363AbWLOXIQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:08:16 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=patch-2.6.19-rt15-fixes.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Luotao Fu <lfu@pengutronix.de>

Adds some header files which are currently missing.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>

Index: kernel/hrtimer.c
===================================================================
--- kernel/hrtimer.c.orig
+++ kernel/hrtimer.c
@@ -39,6 +39,7 @@
 #include <linux/notifier.h>
 #include <linux/syscalls.h>
 #include <linux/kallsyms.h>
+#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
 #include <linux/profile.h>
Index: include/asm-arm/atomic.h
===================================================================
--- include/asm-arm/atomic.h.orig
+++ include/asm-arm/atomic.h
@@ -177,6 +177,8 @@ static inline void atomic_clear_mask(uns
  * Atomic compare and exchange.
  */
 #define __HAVE_ARCH_CMPXCHG	1
+#include <linux/irqflags.h>
+#include <linux/kernel.h>
 
 extern unsigned long wrong_size_cmpxchg(volatile void *ptr);
 

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
