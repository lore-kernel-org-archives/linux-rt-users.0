From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 4.4-rt2] fix arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
Date: Sun, 17 Jan 2016 03:23:14 +0100
Message-ID: <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: bigeasy@linutronix.de, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch breaks the
build, fix that.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-pit.c | 68 +++++++++++++++++------------------
 drivers/clocksource/timer-atmel-st.c  |  8 ++---
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index 80d74c4adcbe..43b50634d640 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -96,11 +96,44 @@ static int pit_clkevt_shutdown(struct clock_event_device *dev)
 
 	/* disable irq, leaving the clocksource active */
 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITEN);
-	free_irq(atmel_pit_irq, data);
+	if (!clockevent_state_detached(dev))
+		free_irq(data->irq, data);
 	return 0;
 }
 
 /*
+ * IRQ handler for the timer.
+ */
+static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
+{
+	struct pit_data *data = dev_id;
+
+	/*
+	 * irqs should be disabled here, but as the irq is shared they are only
+	 * guaranteed to be off if the timer irq is registered first.
+	 */
+	WARN_ON_ONCE(!irqs_disabled());
+
+	/* The PIT interrupt may be disabled, and is shared */
+	if (clockevent_state_periodic(&data->clkevt) &&
+	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
+		unsigned nr_ticks;
+
+		/* Get number of ticks performed before irq, and ack it */
+		nr_ticks = PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
+		do {
+			data->cnt += data->cycle;
+			data->clkevt.event_handler(&data->clkevt);
+			nr_ticks--;
+		} while (nr_ticks);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/*
  * Clockevent device:  interrupts every 1/HZ (== pit_cycles * MCK/16)
  */
 static int pit_clkevt_set_periodic(struct clock_event_device *dev)
@@ -151,45 +184,12 @@ static void at91sam926x_pit_resume(struct clock_event_device *cedev)
 }
 
 /*
- * IRQ handler for the timer.
- */
-static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
-{
-	struct pit_data *data = dev_id;
-
-	/*
-	 * irqs should be disabled here, but as the irq is shared they are only
-	 * guaranteed to be off if the timer irq is registered first.
-	 */
-	WARN_ON_ONCE(!irqs_disabled());
-
-	/* The PIT interrupt may be disabled, and is shared */
-	if (clockevent_state_periodic(&data->clkevt) &&
-	    (pit_read(data->base, AT91_PIT_SR) & AT91_PIT_PITS)) {
-		unsigned nr_ticks;
-
-		/* Get number of ticks performed before irq, and ack it */
-		nr_ticks = PIT_PICNT(pit_read(data->base, AT91_PIT_PIVR));
-		do {
-			data->cnt += data->cycle;
-			data->clkevt.event_handler(&data->clkevt);
-			nr_ticks--;
-		} while (nr_ticks);
-
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-
-/*
  * Set up both clocksource and clockevent support.
  */
 static void __init at91sam926x_pit_common_init(struct pit_data *data)
 {
 	unsigned long	pit_rate;
 	unsigned	bits;
-	int		ret;
 
 	/*
 	 * Use our actual MCK to figure out how many MCK/16 ticks per
diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index ea37afc26e1b..11ce404d0791 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -150,7 +150,7 @@ static int clkevt32k_set_oneshot(struct clock_event_device *dev)
 
 static int clkevt32k_set_periodic(struct clock_event_device *dev)
 {
-	int irq;
+	int ret;
 
 	clkdev32k_disable_and_flush_irq();
 
@@ -229,15 +229,15 @@ static void __init atmel_st_timer_init(struct device_node *node)
 	regmap_read(regmap_st, AT91_ST_SR, &val);
 
 	/* Get the interrupts property */
-	irq  = irq_of_parse_and_map(node, 0);
-	if (!irq)
+	atmel_st_irq  = irq_of_parse_and_map(node, 0);
+	if (!atmel_st_irq)
 		panic(pr_fmt("Unable to get IRQ from DT\n"));
 
 	sclk = of_clk_get(node, 0);
 	if (IS_ERR(sclk))
 		panic(pr_fmt("Unable to get slow clock\n"));
 
-	clk_prepare_enable(sclk);
+	ret = clk_prepare_enable(sclk);
 	if (ret)
 		panic(pr_fmt("Could not enable slow clock\n"));
 
-- 
2.5.0
