From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH V2 1/1] Clocksource: Add sched_clock to Atmel TCB clocksource
Date: Tue, 02 Jun 2015 23:46:18 +0200
Message-ID: <20150602215215.577791619@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:55685 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbbFBVwh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 17:52:37 -0400
Content-Disposition: inline; filename=drivers-clocksource-tcb-register-sched-clock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The default sched_clock provides a maximum resolution of 1 ms which
normally is not sufficient to investigate scheduling related
irregularities - more so, if a low-latency or even a real-time kernel is
used. Therefore, register the Atmel TCB clocksource that provides a
resolution of 63 ns as sched_clock.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 drivers/clocksource/tcb_clksrc.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

Index: linux/drivers/clocksource/tcb_clksrc.c
===================================================================
--- linux.orig/drivers/clocksource/tcb_clksrc.c
+++ linux/drivers/clocksource/tcb_clksrc.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/atmel_tc.h>
+#include <linux/sched_clock.h>
 
 
 /*
@@ -41,6 +42,14 @@
 
 static void __iomem *tcaddr;
 
+static struct clocksource clksrc = {
+	.name           = "tcb_clksrc",
+	.rating         = 200,
+	.read           = tc_get_cycles,
+	.mask           = CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 static cycle_t tc_get_cycles(struct clocksource *cs)
 {
 	unsigned long	flags;
@@ -61,13 +70,10 @@ static cycle_t tc_get_cycles32(struct cl
 	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
-static struct clocksource clksrc = {
-	.name           = "tcb_clksrc",
-	.rating         = 200,
-	.read           = tc_get_cycles,
-	.mask           = CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
+static u64 sched_clock_get_cycles(void)
+{
+	return (u64) do_sched_clock_get_cycles(NULL);
+}
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
@@ -273,6 +279,7 @@ static int __init tcb_clksrc_init(void)
 	int clk32k_divisor_idx = -1;
 	int i;
 	int ret;
+	unsigned long flags;
 
 	tc = atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
 	if (!tc) {
@@ -339,6 +346,10 @@ static int __init tcb_clksrc_init(void)
 	if (ret)
 		goto err_disable_t1;
 
+	local_irq_save(flags);
+	sched_clock_register(sched_clock_get_cycles, 32, divided_rate);
+	local_irq_restore(flags);
+
 	/* channel 2:  periodic and oneshot timer support */
 	ret = setup_clkevents(tc, clk32k_divisor_idx);
 	if (ret)

