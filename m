Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB67C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E060922CE3
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 16:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfHUQTi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:19:38 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42909 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfHUQTi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 12:19:38 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8ADD8240008;
        Wed, 21 Aug 2019 16:19:35 +0000 (UTC)
Date:   Wed, 21 Aug 2019 18:19:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Alexander Dahl <ada@thorsis.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190821161934.GE27031@piout.net>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
 <20190820154418.GM3545@piout.net>
 <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
 <20190821142110.GC27031@piout.net>
 <20190821144230.knlyrnxz62d75hcb@linutronix.de>
 <20190821145837.GD27031@piout.net>
 <20190821151529.42rwd5lkzknv7ti2@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821151529.42rwd5lkzknv7ti2@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/08/2019 17:15:30+0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-21 16:58:37 [+0200], Alexandre Belloni wrote:
> > On 21/08/2019 16:42:30+0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-08-21 16:21:10 [+0200], Alexandre Belloni wrote:
> > > > I'm not sure it is worth it as the issue is introduced by
> > > > clocksource-tclib-allow-higher-clockrates.patch. Shouldn't we fix it
> > > > directly?
> > > 
> > > you want to get rid of CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK and use
> > > the highest possible frequency by default? 
> > > 
> > 
> > No, I meant the issue fixed by clocksource-tclib-add-proper-depend.patch
> > is introduced by clocksource-tclib-allow-higher-clockrates.patch so I
> > would think fixing clocksource-tclib-allow-higher-clockrates.patch is
> > preferable than having a separate patch.
> > 
> > But maybe you meant you wanted a patch to fix
> > clocksource-tclib-allow-higher-clockrates.patch
> 
> got it. So clocksource-tclib-allow-higher-clockrates.patch becomes:
> 
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -424,11 +424,18 @@ config ATMEL_ST
>  
>  config ATMEL_TCB_CLKSRC
>  	bool "Atmel TC Block timer driver" if COMPILE_TEST
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && ATMEL_TCLIB

Nope, this dependency is not necessary, please find the patch attached.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment;
	filename="0001-clocksource-TCLIB-Allow-higher-clock-rates-for-clock.patch"
Content-Transfer-Encoding: 8bit

From c74e8f0fe04117ab53a38bbc0304d05525f9f0de Mon Sep 17 00:00:00 2001
From: Benedikt Spranger <b.spranger@linutronix.de>
Date: Mon, 8 Mar 2010 18:57:04 +0100
Subject: [PATCH] clocksource: TCLIB: Allow higher clock rates for clock events
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As default the TCLIB uses the 32KiHz base clock rate for clock events.
Add a compile time selection to allow higher clock resulution.

(fixed up by Sami Pietikäinen <Sami.Pietikainen@wapice.com>)

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/Kconfig           |  7 +++++
 drivers/clocksource/timer-atmel-tcb.c | 40 +++++++++++++++------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3300739edce4..2927b673caa6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -429,6 +429,13 @@ config ATMEL_TCB_CLKSRC
 	help
 	  Support for Timer Counter Blocks on Atmel SoCs.
 
+config ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
+	bool "TC Block use 32 KiHz clock"
+	depends on ATMEL_TCB_CLKSRC
+	default y
+	help
+	  Select this to use 32 KiHz base clock rate as TC block clock.
+
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 8bc83c346bad..1a5abc178b65 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -27,8 +27,7 @@
  *     this 32 bit free-running counter. the second channel is not used.
  *
  *   - The third channel may be used to provide a 16-bit clockevent
- *     source, used in either periodic or oneshot mode.  This runs
- *     at 32 KiHZ, and can handle delays of up to two seconds.
+ *     source, used in either periodic or oneshot mode.
  *
  * REVISIT behavior during system suspend states... we should disable
  * all clocks and save the power.  Easily done for clockevent devices,
@@ -131,6 +130,7 @@ struct tc_clkevt_device {
 	struct clock_event_device	clkevt;
 	struct clk			*clk;
 	bool				clk_enabled;
+	u32				freq;
 	void __iomem			*regs;
 };
 
@@ -139,13 +139,6 @@ static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
 	return container_of(clkevt, struct tc_clkevt_device, clkevt);
 }
 
-/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
- * because using one of the divided clocks would usually mean the
- * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
- *
- * A divided clock could be good for high resolution timers, since
- * 30.5 usec resolution can seem "low".
- */
 static u32 timer_clock;
 
 static void tc_clk_disable(struct clock_event_device *d)
@@ -195,7 +188,7 @@ static int tc_set_oneshot(struct clock_event_device *d)
 
 	tc_clk_enable(d);
 
-	/* slow clock, count up to RC, then irq and stop */
+	/* count up to RC, then irq and stop */
 	writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
 		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
 	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
@@ -217,10 +210,10 @@ static int tc_set_periodic(struct clock_event_device *d)
 	 */
 	tc_clk_enable(d);
 
-	/* slow clock, count up to RC, then irq and restart */
+	/* count up to RC, then irq and restart */
 	writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
 		     regs + ATMEL_TC_REG(2, CMR));
-	writel((32768 + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
+	writel((tcd->freq + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
 
 	/* Enable clock and interrupts on RC compare */
 	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
@@ -246,7 +239,11 @@ static struct tc_clkevt_device clkevt = {
 		.features		= CLOCK_EVT_FEAT_PERIODIC |
 					  CLOCK_EVT_FEAT_ONESHOT,
 		/* Should be lower than at91rm9200's system timer */
+#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
 		.rating			= 125,
+#else
+		.rating			= 200,
+#endif
 		.set_next_event		= tc_next_event,
 		.set_state_shutdown	= tc_shutdown_clk_off,
 		.set_state_periodic	= tc_set_periodic,
@@ -268,8 +265,11 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	return IRQ_NONE;
 }
 
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
+static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
+
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
+	unsigned divisor = atmel_tcb_divisors[divisor_idx];
 	int ret;
 	struct clk *t2_clk = tc->clk[2];
 	int irq = tc->irq[2];
@@ -290,7 +290,11 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 	clkevt.regs = tc->regs;
 	clkevt.clk = t2_clk;
 
-	timer_clock = clk32k_divisor_idx;
+	timer_clock = divisor_idx;
+	if (!divisor)
+		clkevt.freq = 32768;
+	else
+		clkevt.freq = clk_get_rate(t2_clk) / divisor;
 
 	clkevt.clkevt.cpumask = cpumask_of(0);
 
@@ -301,7 +305,7 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 		return ret;
 	}
 
-	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+	clockevents_config_and_register(&clkevt.clkevt, clkevt.freq, 1, 0xffff);
 
 	return ret;
 }
@@ -358,8 +362,6 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
-
 static const struct of_device_id atmel_tcb_of_match[] = {
 	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
 	{ .compatible = "atmel,at91sam9x5-tcb", .data = (void *)32, },
@@ -477,7 +479,11 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		goto err_disable_t1;
 
 	/* channel 2:  periodic and oneshot timer support */
+#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
 	ret = setup_clkevents(&tc, clk32k_divisor_idx);
+#else
+	ret = setup_clkevents(&tc, best_divisor_idx);
+#endif
 	if (ret)
 		goto err_unregister_clksrc;
 
-- 
2.21.0


--ZPt4rx8FFjLCG7dd--
