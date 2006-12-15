From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 05/10] [ARM] clocksource driver for ep93xx
Date: Fri, 15 Dec 2006 23:37:03 +0100
Message-ID: <20061215224326.947861000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51286 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030376AbWLOXL4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:11:56 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=clocksource-driver-for-arm-ep93xx.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Luotao Fu <lfu@pengutronix.de>

Add a clocksource driver for ep93xx systems.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: linux-2.6.19-rt15/arch/arm/mach-ep93xx/core.c
===================================================================
--- linux-2.6.19-rt15.orig/arch/arm/mach-ep93xx/core.c
+++ linux-2.6.19-rt15/arch/arm/mach-ep93xx/core.c
@@ -32,6 +32,7 @@
 #include <linux/termios.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
+#include <linux/clocksource.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -93,7 +94,6 @@ void __init ep93xx_map_io(void)
  * to use this timer for something else.  We also use timer 4 for keeping
  * track of lost jiffies.
  */
-static unsigned int last_jiffy_time;
 
 #define TIMER4_TICKS_PER_JIFFY		((CLOCK_TICK_RATE + (HZ/2)) / HZ)
 
@@ -127,28 +127,42 @@ static void __init ep93xx_timer_init(voi
 	__raw_writel((508469 / HZ) - 1, EP93XX_TIMER1_LOAD);
 	__raw_writel(0xc8, EP93XX_TIMER1_CONTROL);
 
-	/* Enable lost jiffy timer.  */
-	__raw_writel(0x100, EP93XX_TIMER4_VALUE_HIGH);
-
 	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
 }
 
-static unsigned long ep93xx_gettimeoffset(void)
+/* timer4 is a 40 Bit timer, separated in a 32bit and a 8 bit register, EP93XX_TIMER4_VALUE_LOW
+ * stores 32 bit word. The controlregister is in EP93XX_TIMER4_VALUE_HIGH
+ */
+
+cycle_t ep93xx_get_cycles(void)
 {
-	int offset;
+	return __raw_readl(EP93XX_TIMER4_VALUE_LOW);
+}
 
-	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
+static struct clocksource clocksource_ep93xx = {
+	.name           = "ep93xx timer2",
+	.rating         = 200,
+	.read           = ep93xx_get_cycles,
+	.mask           = 0xFFFFFFFF,
+	.shift          = 20,
+	.is_continuous  = 1,
+};
 
-	/* Calculate (1000000 / 983040) * offset.  */
-	return offset + (53 * offset / 3072);
+static void __init ep93xx_clocksource_init(void)
+{
+	/* Reset time-stamp counter */
+	__raw_writel(0x100, EP93XX_TIMER4_VALUE_HIGH);
+
+	clocksource_ep93xx.mult =
+		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_ep93xx.shift);
+	clocksource_register(&clocksource_ep93xx);
 }
 
 struct sys_timer ep93xx_timer = {
-	.init		= ep93xx_timer_init,
-	.offset		= ep93xx_gettimeoffset,
+	.init			= ep93xx_timer_init,
+	.clocksource_init	= ep93xx_clocksource_init,
 };
 
-
 /*************************************************************************
  * GPIO handling for EP93xx
  *************************************************************************/
@@ -456,7 +470,6 @@ static struct platform_device ep93xx_ohc
 	.resource	= ep93xx_ohci_resources,
 };
 
-
 void __init ep93xx_init_devices(void)
 {
 	unsigned int v;

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
