From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4.4-rt2] fix
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
Date: Mon, 18 Jan 2016 21:24:28 +0100
Message-ID: <569D49FC.2050500@linutronix.de>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118172522.GB12309@linutronix.de> <20160118184247.GQ3367@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160118184247.GQ3367@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/18/2016 07:42 PM, Alexandre Belloni wrote:
> On 18/01/2016 at 18:25:22 +0100, Sebastian Andrzej Siewior wrote :
>> * Alexandre Belloni | 2016-01-17 03:23:14 [+0100]:
>>
>>> index 80d74c4adcbe..43b50634d640 100644
>>> --- a/drivers/clocksource/timer-atmel-pit.c
>>> +++ b/drivers/clocksource/timer-atmel-pit.c
>>> @@ -96,11 +96,44 @@ static int pit_clkevt_shutdown(struct clock_eve=
nt_device *dev)
>>>
>>> 	/* disable irq, leaving the clocksource active */
>>> 	pit_write(data->base, AT91_PIT_MR, (data->cycle - 1) | AT91_PIT_PI=
TEN);
>>> -	free_irq(atmel_pit_irq, data);
>>> +	if (!clockevent_state_detached(dev))
>>> +		free_irq(data->irq, data);
>>
>> I did it in the meantime without clockevent_state_detached(). From w=
hat
>> it looks, it first sets the state and then invokes
>> pit_clkevt_shutdown(). Any particular reason for this?
>>
>=20
> Yeah, I forgot to mention that. Freeing the irq unconditionally
> results in:
=E2=80=A6

>=20
>=20
> My understanding is that clockevents_exchange_device() changes the st=
ate
> from detached to shutdown and so at that point the IRQ has never been
> requested.

I see. So we get shutdown called twice while set_periodic was only
called once. In that case I would suggest to have internal bookkeeping
instead of relying on current core's behavior when it is time free the
irq.

>=20

Sebastian
