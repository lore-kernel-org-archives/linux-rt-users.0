Return-Path: <SRS0=YHoI=WX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB498C3A5A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B8320656
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 10:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfH0Kzr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:55:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43285 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfH0Kzq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Aug 2019 06:55:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i2Z8Y-0002mO-FC; Tue, 27 Aug 2019 12:55:42 +0200
Date:   Tue, 27 Aug 2019 12:55:42 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2.10-rt5
Message-ID: <20190827105542.qxvtteirkh55i5ly@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2.10-rt5 patch set. 

Changes since v5.2.10-rt4:

  - Take care of compile issue within the timer-atmel-tcb driver on
    AT91. Reported by Alexander Dahl, patched by Alexandre Belloni.

  - Fixes to the hrtimer code to finally avoiding warnings while
    canceling a running hrtimer in IRQ context. Patches by Julien Grall.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

The delta patch against v5.2.10-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2.10-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2.10-rt5

The RT patch against v5.2.10 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.10-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2.10-rt5.tar.xz

Sebastian

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 36f8c58386e20..2927b673caa62 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -424,7 +424,7 @@ config ATMEL_ST
 
 config ATMEL_TCB_CLKSRC
 	bool "Atmel TC Block timer driver" if COMPILE_TEST
-	depends on HAS_IOMEM && ATMEL_TCLIB
+	depends on HAS_IOMEM
 	select TIMER_OF if OF
 	help
 	  Support for Timer Counter Blocks on Atmel SoCs.
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 05b5272f5d7e9..1a5abc178b655 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -265,9 +265,11 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	return IRQ_NONE;
 }
 
+static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
+
 static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
-	unsigned divisor = atmel_tc_divisors[divisor_idx];
+	unsigned divisor = atmel_tcb_divisors[divisor_idx];
 	int ret;
 	struct clk *t2_clk = tc->clk[2];
 	int irq = tc->irq[2];
@@ -360,8 +362,6 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
-
 static const struct of_device_id atmel_tcb_of_match[] = {
 	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
 	{ .compatible = "atmel,at91sam9x5-tcb", .data = (void *)32, },
@@ -482,7 +482,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 #ifdef CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK
 	ret = setup_clkevents(&tc, clk32k_divisor_idx);
 #else
-	ret = setup_clkevents(tc, best_divisor_idx);
+	ret = setup_clkevents(&tc, best_divisor_idx);
 #endif
 	if (ret)
 		goto err_unregister_clksrc;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7d7db88021311..5eb45a868de9a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -932,9 +932,9 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
 
 void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
-	struct hrtimer_clock_base *base = timer->base;
+	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (base && base->cpu_base) {
+	if (timer->is_soft && base != &migration_base) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
