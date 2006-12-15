From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 09/10] [ARM] clockevent driver for arm/ep93xx
Date: Fri, 15 Dec 2006 23:37:07 +0100
Message-ID: <20061215224329.323692000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51301 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030388AbWLOXPZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:15:25 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=clockevents-driver-for-arm-ep93xx.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Luotao Fu <lfu@pengutronix.de>

Add a clockevent driver for ep93xx systems.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/arm/mach-ep93xx/core.c
===================================================================
--- arch/arm/mach-ep93xx/core.c.orig
+++ arch/arm/mach-ep93xx/core.c
@@ -33,6 +33,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -51,6 +52,8 @@
 
 #include <asm/hardware/vic.h>
 
+static int __init ep93xx_clockevent_init(void);
+static struct clock_event_device clockevent_ep93xx;
 
 /*************************************************************************
  * Static I/O mappings that are needed for all EP93xx platforms
@@ -99,18 +102,15 @@ void __init ep93xx_map_io(void)
 
 static int ep93xx_timer_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
-
 	__raw_writel(1, EP93XX_TIMER1_CLEAR);
 	while ((signed long)
 		(__raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time)
 						>= TIMER4_TICKS_PER_JIFFY) {
 		last_jiffy_time += TIMER4_TICKS_PER_JIFFY;
-		timer_tick();
+		if (clockevent_ep93xx.event_handler)
+			clockevent_ep93xx.event_handler(regs);
 	}
 
-	write_sequnlock(&xtime_lock);
-
 	return IRQ_HANDLED;
 }
 
@@ -128,6 +128,8 @@ static void __init ep93xx_timer_init(voi
 	__raw_writel(0xc8, EP93XX_TIMER1_CONTROL);
 
 	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
+
+	ep93xx_clockevent_init();
 }
 
 /* timer4 is a 40 Bit timer, separated in a 32bit and a 8 bit register, EP93XX_TIMER4_VALUE_LOW
@@ -491,3 +493,41 @@ void __init ep93xx_init_devices(void)
 	platform_device_register(&ep93xx_rtc_device);
 	platform_device_register(&ep93xx_ohci_device);
 }
+
+static enum clock_event_mode clockevent_mode = CLOCK_EVT_PERIODIC;
+
+static void ep93xx_set_next_event(unsigned long evt,
+                                  struct clock_event_device *unused)
+{
+        u32 mode = (clockevent_mode == CLOCK_EVT_ONESHOT) ?
+                0 : EP93XX_TC123_PERIODIC;
+	__raw_writel(evt, EP93XX_TIMER1_LOAD);
+	__raw_writel( mode | EP93XX_TC123_ENABLE | EP93XX_TC123_SEL_508KHZ, EP93XX_TIMER1_CONTROL);
+}
+
+static void ep93xx_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	clockevent_mode = mode;
+}
+
+static struct clock_event_device clockevent_ep93xx = {
+	.name           = "ep93xx timer1",
+	.capabilities   = CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
+	.shift          = 32,
+	.set_mode       = ep93xx_set_mode,
+	.set_next_event = ep93xx_set_next_event,
+};
+
+static int __init ep93xx_clockevent_init(void)
+{
+	clockevent_ep93xx.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
+					clockevent_ep93xx.shift);
+	clockevent_ep93xx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_ep93xx);
+	clockevent_ep93xx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_ep93xx);
+	register_local_clockevent(&clockevent_ep93xx);
+
+	return 0;
+}
Index: include/asm-arm/arch-ep93xx/ep93xx-regs.h
===================================================================
--- include/asm-arm/arch-ep93xx/ep93xx-regs.h.orig
+++ include/asm-arm/arch-ep93xx/ep93xx-regs.h
@@ -67,6 +67,12 @@
 #define EP93XX_TIMER3_CONTROL		EP93XX_TIMER_REG(0x88)
 #define EP93XX_TIMER3_CLEAR		EP93XX_TIMER_REG(0x8c)
 
+#define EP93XX_TC_CLEAR			0x00000001
+#define EP93XX_TC123_ENABLE		0x00000080
+#define EP93XX_TC123_PERIODIC		0x00000040
+#define EP93XX_TC123_SEL_508KHZ		0x00000008
+#define EP93XX_TC4_ENABLE		0x00000100
+
 #define EP93XX_I2S_BASE			(EP93XX_APB_VIRT_BASE + 0x00020000)
 
 #define EP93XX_SECURITY_BASE		(EP93XX_APB_VIRT_BASE + 0x00030000)

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
