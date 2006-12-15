From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 04/10] [ARM] 4012/1: Clocksource for pxa
Date: Fri, 15 Dec 2006 23:37:02 +0100
Message-ID: <20061215224326.338722000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51289 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030379AbWLOXMx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:12:53 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=clocksource-driver-for-arm-pxa2xx.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

commit c80204e5d67d1452ac0b761d980f1651dc2c66dc
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue Dec 12 09:21:50 2006 +0100

    [ARM] 4012/1: Clocksource for pxa
    
Add a clocksource driver for pxa2xx systems
    
Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Nicolas Pitre <nico@cam.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Index: linux-2.6.19-rt15/arch/arm/mach-pxa/time.c
===================================================================
--- linux-2.6.19-rt15.orig/arch/arm/mach-pxa/time.c
+++ linux-2.6.19-rt15/arch/arm/mach-pxa/time.c
@@ -18,6 +18,7 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -48,27 +49,6 @@ static int pxa_set_rtc(void)
 	return 0;
 }
 
-/* IRQs are disabled before entering here from do_gettimeofday() */
-static unsigned long pxa_gettimeoffset (void)
-{
-	long ticks_to_match, elapsed, usec;
-
-	/* Get ticks before next timer match */
-	ticks_to_match = OSMR0 - OSCR;
-
-	/* We need elapsed ticks since last match */
-	elapsed = LATCH - ticks_to_match;
-
-	/* don't get fooled by the workaround in pxa_timer_interrupt() */
-	if (elapsed <= 0)
-		return 0;
-
-	/* Now convert them to usec */
-	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
-
-	return usec;
-}
-
 #ifdef CONFIG_NO_IDLE_HZ
 static unsigned long initial_match;
 static int match_posponed;
@@ -121,6 +101,20 @@ static struct irqaction pxa_timer_irq = 
 	.handler	= pxa_timer_interrupt,
 };
 
+cycle_t pxa_get_cycles(void)
+{
+	return OSCR;
+}
+
+static struct clocksource clocksource_pxa = {
+	.name           = "pxa_timer",
+	.rating         = 200,
+	.read           = pxa_get_cycles,
+	.mask           = CLOCKSOURCE_MASK(32),
+	.shift          = 20,
+	.is_continuous  = 1,
+};
+
 static void __init pxa_timer_init(void)
 {
 	struct timespec tv;
@@ -138,6 +132,13 @@ static void __init pxa_timer_init(void)
 	setup_irq(IRQ_OST0, &pxa_timer_irq);
 	OIER = OIER_E0;		/* enable match on timer 0 to cause interrupts */
 	OSCR = 0;		/* initialize free-running timer */
+
+	/* on PXA OSCR runs continiously and is not written to, so we can use it
+	 * as clock source directly.
+	 */
+	clocksource_pxa.mult =
+		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_pxa.shift);
+	clocksource_register(&clocksource_pxa);
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -210,7 +211,6 @@ struct sys_timer pxa_timer = {
 	.init		= pxa_timer_init,
 	.suspend	= pxa_timer_suspend,
 	.resume		= pxa_timer_resume,
-	.offset		= pxa_gettimeoffset,
 #ifdef CONFIG_NO_IDLE_HZ
 	.dyn_tick	= &pxa_dyn_tick,
 #endif

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
