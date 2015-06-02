From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH V2 RESEND  1/1] Clocksource: Add sched_clock to Atmel
 TCB clocksource
Date: Wed, 03 Jun 2015 00:08:05 +0200
Message-ID: <556E2945.4090800@osadl.org>
References: <20150602215215.577791619@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:55706 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbbFBWIW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 18:08:22 -0400
In-Reply-To: <20150602215215.577791619@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Sorry, picked wrong patch]

The default sched_clock provides a maximum resolution of 1 ms which
normally is not sufficient to investigate scheduling related
irregularities - more so, if a low-latency or even a real-time kernel is
used. Therefore, register the Atmel TCB clocksource that provides a
resolution of 63 ns as sched_clock.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
  drivers/clocksource/tcb_clksrc.c |   11 +++++++++++
  1 file changed, 11 insertions(+)

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
@@ -69,6 +70,11 @@ static struct clocksource clksrc = {
  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
  };

+static u64 sched_clock_get_cycles(void)
+{
+	return (u64) clksrc.read(NULL);
+}
+
  #ifdef CONFIG_GENERIC_CLOCKEVENTS

  struct tc_clkevt_device {
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
