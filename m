From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 03/10] [ARM] 4013/1: clocksource driver for netx
Date: Fri, 15 Dec 2006 23:37:01 +0100
Message-ID: <20061215224325.753537000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51285 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030375AbWLOXLz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:11:55 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=clocksource-driver-for-arm-netx.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

commit 1a815aed1e03c73fcd0390109c7da9c69dc97490
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue Dec 12 09:23:45 2006 +0100

    [ARM] 4013/1: clocksource driver for netx
    
Add a clocksource driver for netx systems
    
Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Index: linux-2.6.19-rt15/arch/arm/mach-netx/time.c
===================================================================
--- linux-2.6.19-rt15.orig/arch/arm/mach-netx/time.c
+++ linux-2.6.19-rt15/arch/arm/mach-netx/time.c
@@ -19,6 +19,8 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clocksource.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -26,15 +28,6 @@
 #include <asm/arch/netx-regs.h>
 
 /*
- * Returns number of us since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-static unsigned long netx_gettimeoffset(void)
-{
-	return readl(NETX_GPIO_COUNTER_CURRENT(0)) / 100;
-}
-
-/*
  * IRQ handler for the timer
  */
 static irqreturn_t
@@ -43,6 +36,7 @@ netx_timer_interrupt(int irq, void *dev_
 	write_seqlock(&xtime_lock);
 
 	timer_tick();
+
 	write_sequnlock(&xtime_lock);
 
 	/* acknowledge interrupt */
@@ -51,13 +45,26 @@ netx_timer_interrupt(int irq, void *dev_
 	return IRQ_HANDLED;
 }
 
-
 static struct irqaction netx_timer_irq = {
 	.name           = "NetX Timer Tick",
 	.flags          = IRQF_DISABLED | IRQF_TIMER,
 	.handler        = netx_timer_interrupt,
 };
 
+cycle_t netx_get_cycles(void)
+{
+	return readl(NETX_GPIO_COUNTER_CURRENT(1));
+}
+
+static struct clocksource clocksource_netx = {
+	.name 		= "netx_timer",
+	.rating		= 200,
+	.read		= netx_get_cycles,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift 		= 20,
+	.is_continuous 	= 1,
+};
+
 /*
  * Set up timer interrupt
  */
@@ -80,9 +87,20 @@ static void __init netx_timer_init(void)
 		NETX_GPIO_COUNTER_CTRL(0));
 
 	setup_irq(NETX_IRQ_TIMER0, &netx_timer_irq);
+
+	/* Setup timer one for clocksource */
+        writel(0, NETX_GPIO_COUNTER_CTRL(1));
+        writel(0, NETX_GPIO_COUNTER_CURRENT(1));
+        writel(0xFFFFFFFF, NETX_GPIO_COUNTER_MAX(1));
+
+        writel(NETX_GPIO_COUNTER_CTRL_RUN,
+                NETX_GPIO_COUNTER_CTRL(1));
+
+	clocksource_netx.mult =
+		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_netx.shift);
+	clocksource_register(&clocksource_netx);
 }
 
 struct sys_timer netx_timer = {
-	.init           = netx_timer_init,
-	.offset         = netx_gettimeoffset,
+	.init		= netx_timer_init,
 };

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
