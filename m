From: Nathan Sullivan <nathan.sullivan@ni.com>
Subject: Re: [PATCH] genirq: Handle force threading of irqs with primary and
 thread handler
Date: Mon, 21 Sep 2015 10:04:33 -0500
Message-ID: <20150921150433.GA3460@nathan3500-linux-VM>
References: <alpine.DEB.2.11.1509211101190.5606@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, msmucr@gmail.com,
	bigeasy@linutronix.de
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:51761 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757067AbbIUPEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 11:04:43 -0400
In-Reply-To: <alpine.DEB.2.11.1509211101190.5606@nanos>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 21, 2015 at 11:04:31AM +0200, Thomas Gleixner wrote:
> Force threading of interrupts does not deal with interrupts which are
> requested with a primary and a threaded handler. The current policy i=
s
> to leave them alone and let the primary handler run in interrupt
> context, but we set the ONESHOT flag for those interrupts as well.
>=20
> Kohji Okuno debugged a problem with the SDHCI driver where the
> interrupt thread waits for a hardware interrupt to trigger, which can=
t
> work well because the hardware interrupt is masked due to the ONESHOT
> flag being set. He proposed to set the ONESHOT flag only if the
> interrupt does not provide a thread handler.
>=20
> Though that does not work either because these interrupts can be
> shared. So the other interrupt would rightfully get the ONESHOT flag
> set and therefor the same situation would happen again.
>=20
> To deal with this proper, we need to force thread the primary handler
> of such interrupts as well. That means that the primary interrupt
> handler is treated as any other primary interrupt handler which is no=
t
> marked IRQF_NO_THREAD. The threaded handler becomes a separate thread
> so the SDHCI flow logic can be handled gracefully.
>=20
> The same issue was reported against 4.1-rt.
>=20
> Reported-by: Kohji Okuno <okuno.kohji@jp.panasonic.com>
> Reported-By: Michal =C5=A0mucr <msmucr@gmail.com>
> Reported-by: Nathan Sullivan <nathan.sullivan@ni.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>=20
> This requires to revert commit: d04ea10ba1ea 'mmc: sdhci: don't provi=
de
> hard irq handler'
>=20

Tested on an Intel Bay Trail system with ath6kl SDIO wireless, works fi=
ne.

Tested-by: Nathan Sullivan <nathan.sullivan@ni.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
