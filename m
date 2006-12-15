From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 07/10] [ARM] clockevent driver for arm/netx
Date: Fri, 15 Dec 2006 23:37:05 +0100
Message-ID: <20061215224328.103209000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51230 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030310AbWLOXII (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:08:08 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=clockevents-driver-for-arm-netx.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Luotao Fu <lfu@pengutronix.de>

Add a clockevent driver for netx systems.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/arm/mach-netx/time.c
===================================================================
--- arch/arm/mach-netx/time.c.orig
+++ arch/arm/mach-netx/time.c
@@ -21,27 +21,28 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/mach/time.h>
 #include <asm/arch/netx-regs.h>
 
+static int __init netx_clockevent_init(void);
+static struct clock_event_device clockevent_netx;
+
 /*
  * IRQ handler for the timer
  */
 static irqreturn_t
 netx_timer_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
-
-	timer_tick();
-
-	write_sequnlock(&xtime_lock);
-
 	/* acknowledge interrupt */
 	writel(COUNTER_BIT(0), NETX_GPIO_IRQ);
 
+	if (clockevent_netx.event_handler)
+		clockevent_netx.event_handler();
+
 	return IRQ_HANDLED;
 }
 
@@ -99,8 +100,54 @@ static void __init netx_timer_init(void)
 	clocksource_netx.mult =
 		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_netx.shift);
 	clocksource_register(&clocksource_netx);
+
+	netx_clockevent_init();
 }
 
 struct sys_timer netx_timer = {
 	.init		= netx_timer_init,
 };
+
+static u32 clockevent_mode = 0;
+
+static void netx_set_next_event(unsigned long evt,
+				  struct clock_event_device *unused)
+{
+	u32 rst;
+
+	writel(0, NETX_GPIO_COUNTER_CTRL(0));
+	writel(0, NETX_GPIO_COUNTER_CURRENT(0));
+	writel(evt, NETX_GPIO_COUNTER_MAX(0));
+
+	rst = (clockevent_mode == CLOCK_EVT_PERIODIC) ? 0 : 1<<5;
+
+	writel( rst | NETX_GPIO_COUNTER_CTRL_RUN | NETX_GPIO_COUNTER_CTRL_IRQ_EN ,
+		NETX_GPIO_COUNTER_CTRL(0));
+}
+
+static void netx_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	clockevent_mode = mode;
+}
+
+static struct clock_event_device clockevent_netx = {
+	.name		= "netx_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
+	.shift		= 20,
+	.set_mode	= netx_set_mode,
+	.set_next_event	= netx_set_next_event,
+};
+
+static int __init netx_clockevent_init(void)
+{
+	clockevent_netx.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
+					clockevent_netx.shift);
+	clockevent_netx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_netx);
+	clockevent_netx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_netx);
+	register_local_clockevent(&clockevent_netx);
+
+	return 0;
+}

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
