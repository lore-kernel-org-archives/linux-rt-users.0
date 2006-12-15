From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 08/10] [ARM] clockevent driver for arm/pxa2xx
Date: Fri, 15 Dec 2006 23:37:06 +0100
Message-ID: <20061215224328.706830000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51238 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753533AbWLOXJl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:09:41 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=clockevents-driver-for-arm-pxa.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Luotao Fu <lfu@pengutronix.de>

Add a clockevent driver for pxa systems.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/arm/mach-pxa/time.c
===================================================================
--- arch/arm/mach-pxa/time.c.orig
+++ arch/arm/mach-pxa/time.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -30,6 +31,11 @@
 #include <asm/arch/pxa-regs.h>
 
 
+static int __init pxa_clockevent_init(void);
+static struct clock_event_device clockevent_pxa;
+static enum clock_event_mode evt_diff;
+static u32 clockevent_mode = 0;
+
 static inline unsigned long pxa_get_rtc_time(void)
 {
 	return RCNR;
@@ -59,8 +65,6 @@ pxa_timer_interrupt(int irq, void *dev_i
 {
 	int next_match;
 
-	write_seqlock(&xtime_lock);
-
 #ifdef CONFIG_NO_IDLE_HZ
 	if (match_posponed) {
 		match_posponed = 0;
@@ -85,13 +89,16 @@ pxa_timer_interrupt(int irq, void *dev_i
 	 * exactly one tick period which should be a pretty rare event.
 	 */
 	do {
-		timer_tick();
+		if (clockevent_pxa.event_handler)
+			clockevent_pxa.event_handler();
 		OSSR = OSSR_M0;  /* Clear match on timer 0 */
+
+		if (clockevent_mode != CLOCK_EVT_PERIODIC)
+			break;
+
 		next_match = (OSMR0 += LATCH);
 	} while( (signed long)(next_match - OSCR) <= 8 );
 
-	write_sequnlock(&xtime_lock);
-
 	return IRQ_HANDLED;
 }
 
@@ -139,6 +146,9 @@ static void __init pxa_timer_init(void)
 	clocksource_pxa.mult =
 		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_pxa.shift);
 	clocksource_register(&clocksource_pxa);
+
+	evt_diff = LATCH;
+	pxa_clockevent_init();
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -215,3 +225,37 @@ struct sys_timer pxa_timer = {
 	.dyn_tick	= &pxa_dyn_tick,
 #endif
 };
+
+static void pxa_set_next_event(unsigned long evt,
+				  struct clock_event_device *unused)
+{
+	OSMR0 = OSCR + evt;
+	evt_diff = evt;
+}
+
+static void pxa_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	clockevent_mode = mode;
+}
+
+static struct clock_event_device clockevent_pxa = {
+	.name		= "pxa_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
+	.shift		= 32,
+	.set_mode	= pxa_set_mode,
+	.set_next_event	= pxa_set_next_event,
+};
+
+static int __init pxa_clockevent_init(void)
+{
+	clockevent_pxa.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
+					clockevent_pxa.shift);
+	clockevent_pxa.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_pxa);
+	clockevent_pxa.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_pxa);
+	register_local_clockevent(&clockevent_pxa);
+
+	return 0;
+}

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
