From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 4.4-rt2] fix
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
Date: Mon, 18 Jan 2016 19:42:47 +0100
Message-ID: <20160118184247.GQ3367@piout.net>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118172522.GB12309@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160118172522.GB12309@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 18/01/2016 at 18:25:22 +0100, Sebastian Andrzej Siewior wrote :
> * Alexandre Belloni | 2016-01-17 03:23:14 [+0100]:
>=20
> >index 80d74c4adcbe..43b50634d640 100644
> >--- a/drivers/clocksource/timer-atmel-pit.c
> >+++ b/drivers/clocksource/timer-atmel-pit.c
> >@@ -96,11 +96,44 @@ static int pit_clkevt_shutdown(struct clock_even=
t_device *dev)
> >=20
> > 	/* disable irq, leaving the clocksource active */
> > 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PI=
TEN);
> >-	free_irq(atmel_pit_irq, data);
> >+	if (!clockevent_state_detached(dev))
> >+		free_irq(data->irq, data);
>=20
> I did it in the meantime without clockevent_state_detached(). From wh=
at
> it looks, it first sets the state and then invokes
> pit_clkevt_shutdown(). Any particular reason for this?
>=20

Yeah, I forgot to mention that. Freeing the irq unconditionally
results in:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1541
__free_irq+0xb4/0x2c8()
Trying to free already-free IRQ 16
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.0-rt2+ #31
Hardware name: Atmel SAMA5
[<c0016344>] (unwind_backtrace) from [<c0012d7c>] (show_stack+0x10/0x14=
)
[<c0012d7c>] (show_stack) from [<c021639c>] (dump_stack+0x80/0x94)
[<c021639c>] (dump_stack) from [<c001f528>] (warn_slowpath_common+0x80/=
0xb0)
[<c001f528>] (warn_slowpath_common) from [<c001f588>] (warn_slowpath_fm=
t+0x30/0x40)
[<c001f588>] (warn_slowpath_fmt) from [<c00615e0>] (__free_irq+0xb4/0x2=
c8)
[<c00615e0>] (__free_irq) from [<c0061878>] (free_irq+0x3c/0x70)
[<c0061878>] (free_irq) from [<c0391ba8>] (pit_clkevt_shutdown+0x24/0x2=
c)
[<c0391ba8>] (pit_clkevt_shutdown) from [<c007d9a0>] (clockevents_switc=
h_state+0x60/0x130)
[<c007d9a0>] (clockevents_switch_state) from [<c007dda4>] (clockevents_=
exchange_device+0x78/0x8c)
[<c007dda4>] (clockevents_exchange_device) from [<c007e628>] (tick_chec=
k_new_device+0x90/0xd0)
[<c007e628>] (tick_check_new_device) from [<c007d488>] (clockevents_reg=
ister_device+0x54/0x10c)
[<c007d488>] (clockevents_register_device) from [<c07073bc>] (clocksour=
ce_probe+0x4c/0x90)
[<c07073bc>] (clocksource_probe) from [<c06eab58>] (start_kernel+0x278/=
0x3a4)
[<c06eab58>] (start_kernel) from [<2000807c>] (0x2000807c)
---[ end trace 0000000000000001 ]---


My understanding is that clockevents_exchange_device() changes the stat=
e
from detached to shutdown and so at that point the IRQ has never been
requested.


> > 	return 0;
> > }
> >=20
> > /*
> >+ * IRQ handler for the timer.
> >+ */
> >+static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
>=20
> this is just here to avoid to forward declaration.
> =E2=80=A6

Indeed.

> >diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksou=
rce/timer-atmel-st.c
> >index ea37afc26e1b..11ce404d0791 100644
> >--- a/drivers/clocksource/timer-atmel-st.c
> >+++ b/drivers/clocksource/timer-atmel-st.c
> >@@ -229,15 +229,15 @@ static void __init atmel_st_timer_init(struct =
device_node *node)
> > 	regmap_read(regmap_st, AT91_ST_SR, &val);
> >=20
> > 	/* Get the interrupts property */
> >-	irq  =3D irq_of_parse_and_map(node, 0);
> >-	if (!irq)
> >+	atmel_st_irq  =3D irq_of_parse_and_map(node, 0);
> >+	if (!atmel_st_irq)
> > 		panic(pr_fmt("Unable to get IRQ from DT\n"));
> >=20
> > 	sclk =3D of_clk_get(node, 0);
> > 	if (IS_ERR(sclk))
> > 		panic(pr_fmt("Unable to get slow clock\n"));
> >=20
> >-	clk_prepare_enable(sclk);
> >+	ret =3D clk_prepare_enable(sclk);
> this piece applies to upstream v4.4.
>=20

Yeah, I'll submit it.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
