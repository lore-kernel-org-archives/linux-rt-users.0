From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Tue, 28 May 2013 08:53:37 +0200
Message-ID: <20130528065336.GI11166@pengutronix.de>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
 <CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
 <20130503160546.GF8230@linutronix.de>
 <CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
 <519B57A7.1010901@linutronix.de>
 <CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
 <20130527080248.GE11166@pengutronix.de>
 <CAFSh4Uw2+d_mOoY0b63JODwjXnq=H0oZia1XMEDW6KXV87NR5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tom Cook <tom.k.cook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58369 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932984Ab3E1Gxk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 May 2013 02:53:40 -0400
Content-Disposition: inline
In-Reply-To: <CAFSh4Uw2+d_mOoY0b63JODwjXnq=H0oZia1XMEDW6KXV87NR5Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, May 27, 2013 at 10:23:53PM +0100, Tom Cook wrote:
> On Mon, May 27, 2013 at 9:02 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> [snip]
> > What are you using fiqs for? AFAIK they are not well supported in
> > mainline Linux even.
>=20
> You're well on the way to plumbing the depths of my ignorance.  This
> is just me applying the RT patches to the raspberrypi linux tree.  Th=
e
> nearest I can figure out an answer to your question is this, in
> arch/arm/kernel/fiqasm.S, in __set_fiq_regs:
>=20
> @@@@@@@@@@@@@@@ hack: enable the fiq here to keep usb driver happy
>         and     r1, #~PSR_F_BIT
> @@@@@@@@@@@@@@@ endhack: (need to find better place for this to happe=
n)
IIRC the usb driver is vital for the raspberry pi, but can you try to
unbind the driver before enabling whatever breaks for you?

Something like:

	cd /sys/bus/platform/drivers/dwc_otg

in this directory are probably >=3D1 symlinks on devices. Do

	echo $devicename > unbind

for each of them where devicename is the name of the symlinks.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
