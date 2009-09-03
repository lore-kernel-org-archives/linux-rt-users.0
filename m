From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] fec: don't enable irqs in hard irq context
Date: Wed, 02 Sep 2009 23:17:09 -0700 (PDT)
Message-ID: <20090902.231709.224187980.davem@davemloft.net>
References: <1251882856-23549-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1251882856-23549-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<4A9F1870.7070408@snapgear.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: u.kleine-koenig@pengutronix.de, linux-rt-users@vger.kernel.org,
	ben@decadent.org.uk, kaber@trash.net, s.hauer@pengutronix.de,
	Matt.Waddel@freescale.com, netdev@vger.kernel.org,
	tim01@vlsi.informatik.tu-darmstadt.de
To: gerg@snapgear.com
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4A9F1870.7070408@snapgear.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

=46rom: Greg Ungerer <gerg@snapgear.com>
Date: Thu, 03 Sep 2009 11:14:24 +1000

> Hi Uwe,
>=20
> Uwe Kleine-K=F6nig wrote:
>> fec_enet_mii, fec_enet_rx and fec_enet_tx are both only called by
>> fec_enet_interrupt in interrupt context.  So they must not use
>> spin_lock_irq/spin_unlock_irq.
>> This fixes:
>> 	WARNING: at kernel/lockdep.c:2140
>> 	trace_hardirqs_on_caller+0x130/0x194()
>> 	...
>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>> Cc: Greg Ungerer <gerg@uclinux.org>
>=20
> Looks good.
>=20
> Acked-by: Greg Ungerer <gerg@uclinux.org>

Applied to net-next-2.6
