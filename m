From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4.4-rt2] fix
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
Date: Mon, 18 Jan 2016 18:25:22 +0100
Message-ID: <20160118172522.GB12309@linutronix.de>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47760 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113AbcARRZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 12:25:26 -0500
Content-Disposition: inline
In-Reply-To: <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Alexandre Belloni | 2016-01-17 03:23:14 [+0100]:

>index 80d74c4adcbe..43b50634d640 100644
>--- a/drivers/clocksource/timer-atmel-pit.c
>+++ b/drivers/clocksource/timer-atmel-pit.c
>@@ -96,11 +96,44 @@ static int pit_clkevt_shutdown(struct clock_event_=
device *dev)
>=20
> 	/* disable irq, leaving the clocksource active */
> 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PITE=
N);
>-	free_irq(atmel_pit_irq, data);
>+	if (!clockevent_state_detached(dev))
>+		free_irq(data->irq, data);

I did it in the meantime without clockevent_state_detached(). From what
it looks, it first sets the state and then invokes
pit_clkevt_shutdown(). Any particular reason for this?

> 	return 0;
> }
>=20
> /*
>+ * IRQ handler for the timer.
>+ */
>+static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)

this is just here to avoid to forward declaration.
=E2=80=A6
>diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksourc=
e/timer-atmel-st.c
>index ea37afc26e1b..11ce404d0791 100644
>--- a/drivers/clocksource/timer-atmel-st.c
>+++ b/drivers/clocksource/timer-atmel-st.c
>@@ -229,15 +229,15 @@ static void __init atmel_st_timer_init(struct de=
vice_node *node)
> 	regmap_read(regmap_st, AT91_ST_SR, &val);
>=20
> 	/* Get the interrupts property */
>-	irq  =3D irq_of_parse_and_map(node, 0);
>-	if (!irq)
>+	atmel_st_irq  =3D irq_of_parse_and_map(node, 0);
>+	if (!atmel_st_irq)
> 		panic(pr_fmt("Unable to get IRQ from DT\n"));
>=20
> 	sclk =3D of_clk_get(node, 0);
> 	if (IS_ERR(sclk))
> 		panic(pr_fmt("Unable to get slow clock\n"));
>=20
>-	clk_prepare_enable(sclk);
>+	ret =3D clk_prepare_enable(sclk);
this piece applies to upstream v4.4.

> 	if (ret)
> 		panic(pr_fmt("Could not enable slow clock\n"));
>=20

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
