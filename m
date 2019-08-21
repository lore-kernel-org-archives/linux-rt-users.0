Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4073DC3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 15:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16331216F4
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 15:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfHUPPg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:15:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55966 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfHUPPf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 11:15:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0SKg-0007vO-3d; Wed, 21 Aug 2019 17:15:30 +0200
Date:   Wed, 21 Aug 2019 17:15:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexander Dahl <ada@thorsis.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190821151529.42rwd5lkzknv7ti2@linutronix.de>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
 <20190820154418.GM3545@piout.net>
 <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
 <20190821142110.GC27031@piout.net>
 <20190821144230.knlyrnxz62d75hcb@linutronix.de>
 <20190821145837.GD27031@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821145837.GD27031@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-21 16:58:37 [+0200], Alexandre Belloni wrote:
> On 21/08/2019 16:42:30+0200, Sebastian Andrzej Siewior wrote:
> > On 2019-08-21 16:21:10 [+0200], Alexandre Belloni wrote:
> > > I'm not sure it is worth it as the issue is introduced by
> > > clocksource-tclib-allow-higher-clockrates.patch. Shouldn't we fix it
> > > directly?
> > 
> > you want to get rid of CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK and use
> > the highest possible frequency by default? 
> > 
> 
> No, I meant the issue fixed by clocksource-tclib-add-proper-depend.patch
> is introduced by clocksource-tclib-allow-higher-clockrates.patch so I
> would think fixing clocksource-tclib-allow-higher-clockrates.patch is
> preferable than having a separate patch.
> 
> But maybe you meant you wanted a patch to fix
> clocksource-tclib-allow-higher-clockrates.patch

got it. So clocksource-tclib-allow-higher-clockrates.patch becomes:

--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -424,11 +424,18 @@ config ATMEL_ST
 
 config ATMEL_TCB_CLKSRC
 	bool "Atmel TC Block timer driver" if COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && ATMEL_TCLIB
 	select TIMER_OF if OF
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
 
@@ -139,13 +139,6 @@ static struct tc_clkevt_device *to_tc_cl
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
@@ -195,7 +188,7 @@ static int tc_set_oneshot(struct clock_e
 
 	tc_clk_enable(d);
 
-	/* slow clock, count up to RC, then irq and stop */
+	/* count up to RC, then irq and stop */
 	writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
 		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
 	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
@@ -217,10 +210,10 @@ static int tc_set_periodic(struct clock_
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
@@ -246,7 +239,11 @@ static struct tc_clkevt_device clkevt =
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
@@ -268,8 +265,9 @@ static irqreturn_t ch2_irq(int irq, void
 	return IRQ_NONE;
 }
 
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
+	unsigned divisor = atmel_tc_divisors[divisor_idx];
 	int ret;
 	struct clk *t2_clk = tc->clk[2];
 	int irq = tc->irq[2];
@@ -290,7 +288,11 @@ static int __init setup_clkevents(struct
 	clkevt.regs = tc->regs;
 	clkevt.clk = t2_clk;
 
-	timer_clock = clk32k_divisor_idx;
+	timer_clock = divisor_idx;
+	if (!divisor)
+		clkevt.freq = 32768;
+	else
+		clkevt.freq = clk_get_rate(t2_clk) / divisor;
 
 	clkevt.clkevt.cpumask = cpumask_of(0);
 
@@ -301,7 +303,7 @@ static int __init setup_clkevents(struct
 		return ret;
 	}
 
-	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+	clockevents_config_and_register(&clkevt.clkevt, clkevt.freq, 1, 0xffff);
 
 	return ret;
 }
@@ -477,7 +479,11 @@ static int __init tcb_clksrc_init(struct
 		goto err_disable_t1;
 
 	/* channel 2:  periodic and oneshot timer support */
+#ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
 	ret = setup_clkevents(&tc, clk32k_divisor_idx);
+#else
+	ret = setup_clkevents(&tc, best_divisor_idx);
+#endif
 	if (ret)
 		goto err_unregister_clksrc;
 


> 
> Hopefully, one day we will have a solution for that upstream (i.e. being
> able to configure the clocksource and clockevent resolutions).

Hopefully.

Sebastian
