From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 06/10] [ARM] clockevent driver for arm/imx
Date: Fri, 15 Dec 2006 23:37:04 +0100
Message-ID: <20061215224327.489301000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51287 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030378AbWLOXL7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:11:59 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=clockevents-driver-for-arm-imx.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Add a clockevent driver for i.MX systems.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/arm/mach-imx/time.c
===================================================================
--- arch/arm/mach-imx/time.c.orig
+++ arch/arm/mach-imx/time.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -25,6 +26,9 @@
 /* Use timer 1 as system timer */
 #define TIMER_BASE IMX_TIM1_BASE
 
+static int __init imx_clockevent_init(void);
+static struct clock_event_device clockevent_imx;
+enum clock_event_mode clockevent_mode = 0;
 static unsigned long evt_diff;
 
 /*
@@ -42,9 +46,12 @@ imx_timer_interrupt(int irq, void *dev_i
 	if (tstat & TSTAT_COMP) {
 		do {
 
-			write_seqlock(&xtime_lock);
-			timer_tick();
-			write_sequnlock(&xtime_lock);
+			if (clockevent_imx.event_handler)
+				clockevent_imx.event_handler();
+
+			if (clockevent_mode != CLOCK_EVT_PERIODIC)
+				break;
+
 			IMX_TCMP(TIMER_BASE) += evt_diff;
 
 		} while (unlikely((int32_t)(IMX_TCMP(TIMER_BASE)
@@ -104,6 +111,9 @@ static void __init imx_timer_init(void)
 	imx_timer_hardware_init();
 	imx_clocksource_init();
 
+	evt_diff = LATCH;
+ 	imx_clockevent_init();
+
 	/*
 	 * Make irqs happen for the system timer
 	 */
@@ -113,3 +123,37 @@ static void __init imx_timer_init(void)
 struct sys_timer imx_timer = {
 	.init		= imx_timer_init,
 };
+
+static void imx_set_next_event(unsigned long evt,
+				  struct clock_event_device *unused)
+{
+	evt_diff = evt;
+	IMX_TCMP(IMX_TIM1_BASE) = IMX_TCN(IMX_TIM1_BASE) + evt;
+}
+
+static void imx_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	clockevent_mode = mode;
+}
+
+static struct clock_event_device clockevent_imx = {
+	.name		= "imx_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
+	.shift		= 32,
+	.set_mode	= imx_set_mode,
+	.set_next_event	= imx_set_next_event,
+};
+
+static int __init imx_clockevent_init(void)
+{
+	clockevent_imx.mult = div_sc(imx_get_perclk1(), NSEC_PER_SEC,
+					clockevent_imx.shift);
+	clockevent_imx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_imx);
+	clockevent_imx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_imx);
+	register_local_clockevent(&clockevent_imx);
+
+	return 0;
+}

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
