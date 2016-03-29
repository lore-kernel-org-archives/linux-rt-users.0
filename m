From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] clockevents/drivers/timer-atmel-pit: fix double free_irq
Date: Tue, 29 Mar 2016 15:34:54 +0200
Message-ID: <56FA847E.9080704@atmel.com>
References: <1458245383-9859-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160329133206.GA13334@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329133206.GA13334@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Le 29/03/2016 15:32, Sebastian Andrzej Siewior a =C3=A9crit :
> * Alexandre Belloni | 2016-03-17 21:09:43 [+0100]:
>=20
>> Hi Sebastian,
> Hi Alexandre,
>=20
>> This patch fixes the last warning for preempt-rt on at91. It applies=
 on
>> v4.4.4-rt11. Note that the whome PIT/TCB mess will be fixed in anoth=
er way in
>> the mainline as we are reworking the tcb driver to avoid using the p=
it when
>> booting.
>=20
> oh, okay. I just sent the "arm: at91: do not disable/enable clocks in=
 a
> row" patch as you asked me a while ago. It applied cleanly against th=
e
> next tree of today.

Sure, we can still take it now. We will certainly embed it in a future
TC rework.

Thanks.


> So I will apply this to get rid of the warning. And if you manage not=
 to
> use the PIT during boot then we won't have the free_irq() mess which =
is
> good.
>=20
> Sebastian
>=20


--=20
Nicolas Ferre
