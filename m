From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4.4-rt2] fix
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
Date: Wed, 20 Jan 2016 12:07:30 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601201158280.3575@nanos>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com> <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com> <20160118172522.GB12309@linutronix.de> <20160118184247.GQ3367@piout.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160118184247.GQ3367@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 18 Jan 2016, Alexandre Belloni wrote:
> On 18/01/2016 at 18:25:22 +0100, Sebastian Andrzej Siewior wrote :
> > * Alexandre Belloni | 2016-01-17 03:23:14 [+0100]:
> > 
> > >index 80d74c4adcbe..43b50634d640 100644
> > >--- a/drivers/clocksource/timer-atmel-pit.c
> > >+++ b/drivers/clocksource/timer-atmel-pit.c
> > >@@ -96,11 +96,44 @@ static int pit_clkevt_shutdown(struct clock_event_device *dev)
> > > 
> > > 	/* disable irq, leaving the clocksource active */
> > > 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITEN);
> > >-	free_irq(atmel_pit_irq, data);
> > >+	if (!clockevent_state_detached(dev))
> > >+		free_irq(data->irq, data);
> > 
> > I did it in the meantime without clockevent_state_detached(). From what
> > it looks, it first sets the state and then invokes
> > pit_clkevt_shutdown(). Any particular reason for this?
> > 
> 
> Yeah, I forgot to mention that. Freeing the irq unconditionally
> results in:

Well freeing the irq from that context in RT only works because its called
before SYSTEM_STATE=RUNNING. So no, this was wrong forever.

The issue we are dealing with is that the timer interrupt is shared with the
uart. So the timer has IRQ_NO_THREAD set and the uart interrupt gets force
threaded. So that results in a failure to request the interrupt for the
UART. That's not RT specific, that already happens in mainline if you add
'threadirqs' to the command line.

So until the DT folks come to senses and we get that dummy demux chip done, I
came up with the following - completely untested - solution.

The downside of this is, that the timer will be delayed until the uart thread
returns, but with the replacement clockevent in place on RT that's a non
issue. For mainline it's obviously better than what we have now.

Thanks,

	tglx

8<---------------

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -61,6 +61,10 @@
  *                interrupt handler after suspending interrupts. For system
  *                wakeup devices users need to implement wakeup detection in
  *                their interrupt handlers.
+ * IRQF_COND_ONESHOT - If the IRQ is shared between a NO_THREAD user and a
+ *		regular interrupt, force the ONESHOT flag on the NO_THREAD user
+ *		when threaded irqs are enforced. Workaround for silly ATMEL
+ *		SoCs which share the timer and the UART interrupt
  * IRQF_NO_SOFTIRQ_CALL - Do not process softirqs in the irq thread context (RT)
  */
 #define IRQF_SHARED		0x00000080
@@ -75,7 +79,8 @@
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
-#define IRQF_NO_SOFTIRQ_CALL	0x00080000
+#define IRQF_COND_ONESHOT	0x00080000
+#define IRQF_NO_SOFTIRQ_CALL	0x00100000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1208,6 +1208,14 @@ static int
 	new->irq = irq;
 
 	/*
+	 * Workaround for silly ATMEL SoCs with shared timer and uart
+	 * interrupt.
+	 */
+	if (force_irqthreads && (new->flags & IRQF_COND_ONESHOT) &&
+	    (new->flags & IRQF_NO_THREAD))
+		new->flags |= IRQF_ONESHOT;
+
+	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
 	 */
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -208,7 +208,7 @@ static void __init at91sam926x_pit_commo
 
 	/* Set up irq handler */
 	ret = request_irq(data->irq, at91sam926x_pit_interrupt,
-			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
+			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL| IRQF_COND_ONESHOT,
 			  "at91_tick", data);
 	if (ret)
 		panic(pr_fmt("Unable to setup IRQ\n"));
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -216,7 +216,7 @@ static void __init atmel_st_timer_init(s
 
 	/* Make IRQs happen for the system timer */
 	ret = request_irq(irq, at91rm9200_timer_interrupt,
-			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
+			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL | IRQF_COND_ONESHOT,
 			  "at91_tick", regmap_st);
 	if (ret)
 		panic(pr_fmt("Unable to setup IRQ\n"));
