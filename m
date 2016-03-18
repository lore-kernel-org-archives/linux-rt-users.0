From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] clockevents/drivers/timer-atmel-pit: fix double free_irq
Date: Fri, 18 Mar 2016 09:20:03 +0100
Message-ID: <56EBBA33.9080809@atmel.com>
References: <1458245383-9859-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	<bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458245383-9859-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Le 17/03/2016 21:09, Alexandre Belloni a =E9crit :
> clockevents_exchange_device() changes the state from detached to shut=
down
> and so at that point the IRQ has not yet been requested.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>=20
> Hi Sebastian,
>=20
> This patch fixes the last warning for preempt-rt on at91. It applies =
on
> v4.4.4-rt11. Note that the whome PIT/TCB mess will be fixed in anothe=
r way in
> the mainline as we are reworking the tcb driver to avoid using the pi=
t when
> booting.

Yes, it's the plan!

Thanks Alexandre. Bye.

>=20
>  drivers/clocksource/timer-atmel-pit.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksou=
rce/timer-atmel-pit.c
> index a7abdb6638cd..7a40f7e88468 100644
> --- a/drivers/clocksource/timer-atmel-pit.c
> +++ b/drivers/clocksource/timer-atmel-pit.c
> @@ -46,6 +46,7 @@ struct pit_data {
>  	u32		cycle;
>  	u32		cnt;
>  	unsigned int	irq;
> +	bool		irq_requested;
>  	struct clk	*mck;
>  };
> =20
> @@ -96,7 +97,10 @@ static int pit_clkevt_shutdown(struct clock_event_=
device *dev)
> =20
>  	/* disable irq, leaving the clocksource active */
>  	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PIT=
EN);
> -	free_irq(data->irq, data);
> +	if (data->irq_requested) {
> +		free_irq(data->irq, data);
> +		data->irq_requested =3D false;
> +	}
>  	return 0;
>  }
> =20
> @@ -115,6 +119,8 @@ static int pit_clkevt_set_periodic(struct clock_e=
vent_device *dev)
>  	if (ret)
>  		panic(pr_fmt("Unable to setup IRQ\n"));
> =20
> +	data->irq_requested =3D true;
> +
>  	/* update clocksource counter */
>  	data->cnt +=3D data->cycle * PIT_PICNT(pit_read(data->base, AT91_PI=
T_PIVR));
>  	pit_write(data->base, AT91_PIT_MR,
>=20


--=20
Nicolas Ferre
