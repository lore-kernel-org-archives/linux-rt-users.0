From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 02/10] [ARM] 3991/1: i.MX/MX1 high resolution time source
Date: Fri, 15 Dec 2006 23:37:00 +0100
Message-ID: <20061215224325.112546000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51231 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030362AbWLOXIN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:08:13 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=clocksource-driver-for-arm-imx.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Pavel Pisa <ppisa@pikron.com>

commit 86987d5bf4db7850a8dfb073c6a3506d4e0d2bcc
Author: Pavel Pisa <ppisa@pikron.com>
Date:   Wed Dec 6 17:19:44 2006 +0100

    [ARM] 3991/1: i.MX/MX1 high resolution time source
    
Enhanced resolution for time measurement functions.
    
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Index: linux-2.6.19-rt15/arch/arm/mach-imx/time.c
===================================================================
--- linux-2.6.19-rt15.orig/arch/arm/mach-imx/time.c
+++ linux-2.6.19-rt15/arch/arm/mach-imx/time.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/time.h>
+#include <linux/clocksource.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -24,33 +25,7 @@
 /* Use timer 1 as system timer */
 #define TIMER_BASE IMX_TIM1_BASE
 
-/*
- * Returns number of us since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-static unsigned long imx_gettimeoffset(void)
-{
-	unsigned long ticks;
-
-	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
-	ticks = IMX_TCN(TIMER_BASE);
-
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 */
-	if (IMX_TSTAT(TIMER_BASE) & TSTAT_COMP)
-		ticks += LATCH;
-
-	/*
-	 * Convert the ticks to usecs
-	 */
-	return (1000000 / CLK32) * ticks;
-}
+static unsigned long evt_diff;
 
 /*
  * IRQ handler for the timer
@@ -58,14 +33,23 @@ static unsigned long imx_gettimeoffset(v
 static irqreturn_t
 imx_timer_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
+	uint32_t tstat;
 
 	/* clear the interrupt */
-	if (IMX_TSTAT(TIMER_BASE))
-		IMX_TSTAT(TIMER_BASE) = 0;
+	tstat = IMX_TSTAT(TIMER_BASE);
+	IMX_TSTAT(TIMER_BASE) = 0;
+
+	if (tstat & TSTAT_COMP) {
+		do {
 
-	timer_tick();
-	write_sequnlock(&xtime_lock);
+			write_seqlock(&xtime_lock);
+			timer_tick();
+			write_sequnlock(&xtime_lock);
+			IMX_TCMP(TIMER_BASE) += evt_diff;
+
+		} while (unlikely((int32_t)(IMX_TCMP(TIMER_BASE)
+					- IMX_TCN(TIMER_BASE)) < 0));
+	}
 
 	return IRQ_HANDLED;
 }
@@ -77,9 +61,9 @@ static struct irqaction imx_timer_irq = 
 };
 
 /*
- * Set up timer interrupt, and return the current time in seconds.
+ * Set up timer hardware into expected mode and state.
  */
-static void __init imx_timer_init(void)
+static void __init imx_timer_hardware_init(void)
 {
 	/*
 	 * Initialise to a known state (all timers off, and timing reset)
@@ -87,7 +71,38 @@ static void __init imx_timer_init(void)
 	IMX_TCTL(TIMER_BASE) = 0;
 	IMX_TPRER(TIMER_BASE) = 0;
 	IMX_TCMP(TIMER_BASE) = LATCH - 1;
-	IMX_TCTL(TIMER_BASE) = TCTL_CLK_32 | TCTL_IRQEN | TCTL_TEN;
+
+	IMX_TCTL(TIMER_BASE) = TCTL_FRR | TCTL_CLK_PCLK1 | TCTL_IRQEN | TCTL_TEN;
+	evt_diff = LATCH;
+}
+
+cycle_t imx_get_cycles(void)
+{
+	return IMX_TCN(TIMER_BASE);
+}
+
+static struct clocksource clocksource_imx = {
+	.name 		= "imx_timer1",
+	.rating		= 200,
+	.read		= imx_get_cycles,
+	.mask		= 0xFFFFFFFF,
+	.shift 		= 20,
+	.is_continuous 	= 1,
+};
+
+static int __init imx_clocksource_init(void)
+{
+	clocksource_imx.mult =
+		clocksource_hz2mult(imx_get_perclk1(), clocksource_imx.shift);
+	clocksource_register(&clocksource_imx);
+
+	return 0;
+}
+
+static void __init imx_timer_init(void)
+{
+	imx_timer_hardware_init();
+	imx_clocksource_init();
 
 	/*
 	 * Make irqs happen for the system timer
@@ -97,5 +112,4 @@ static void __init imx_timer_init(void)
 
 struct sys_timer imx_timer = {
 	.init		= imx_timer_init,
-	.offset		= imx_gettimeoffset,
 };
Index: linux-2.6.19-rt15/include/asm-arm/arch-imx/timex.h
===================================================================
--- linux-2.6.19-rt15.orig/include/asm-arm/arch-imx/timex.h
+++ linux-2.6.19-rt15/include/asm-arm/arch-imx/timex.h
@@ -21,7 +21,6 @@
 #ifndef __ASM_ARCH_TIMEX_H
 #define __ASM_ARCH_TIMEX_H
 
-#include <asm/hardware.h>
-#define CLOCK_TICK_RATE		(CLK32)
+#define CLOCK_TICK_RATE		(16000000)
 
 #endif

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
