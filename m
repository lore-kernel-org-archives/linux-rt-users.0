From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [ANNOUNCE] v4.4.4-rt11
Date: Fri, 11 Mar 2016 18:14:46 +0100
Message-ID: <20160311171446.GB3815@breakpoint.cc>
References: <20160309135142.GF10517@linutronix.de>
 <nbq16a$7li$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Jean-Denis Girard <jd.girard@sysnux.pf>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:46681 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932643AbcCKROu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Mar 2016 12:14:50 -0500
Content-Disposition: inline
In-Reply-To: <nbq16a$7li$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-03-09 10:31:06 [-1000], Jean-Denis Girard wrote:
> Hi,
Hi,

please don't cut people from TO and CC.

> Le 09/03/2016 03:51, Sebastian Andrzej Siewior a =C3=A9crit :
> > - AT91 got a little better. A larger patch series by Boris Brezillo=
n has
> >   been merged. That means SAMA5 boots now. There is one warning lef=
t
> >   about invoking free_irq() twice. I would be glad about some feedb=
ack
> >   from pre-SAMA5 SoC. Those which share UART and timer interrupt. I=
t
> >   seems that that one I have here does not do this anymore.
> >=20
> > - A patch on top the AT91 series to avoid two warning while switchi=
ng
> >   from period to oneshow mode.
>=20
> I got this warning when booting my arietta G25:
>=20
> clocksource: pit: mask: 0xfffffff max_cycles: 0xfffffff, max_idle_ns:
> 14334453866 ns
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1541 __free_irq+0xb0/0x=
2b0()
> Trying to free already-free IRQ 16

=E2=80=A6
> Nevertheless it does boot, and seems to work fine.
This looks promising. Can you check if IRQ 16 is used by another
peripherals? While we need get rid fo the warning I am curious if it
works on boards which chare the timer with UART or something.

> Thanks,

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
