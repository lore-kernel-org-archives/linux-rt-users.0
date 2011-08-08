From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Mitigation of license for the symbol __rt_mutex_init and more
Date: Mon, 8 Aug 2011 08:30:06 +0200
Message-ID: <20110808063006.GU31521@pengutronix.de>
References: <CABg52H=D6vGam6W-0EqFFuSVh8LA5ouaYHv0wknVYzY0G0hh6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Andrey Gursky <andrey.gursky@e-mail.ua>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43518 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1HHGaJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Aug 2011 02:30:09 -0400
Content-Disposition: inline
In-Reply-To: <CABg52H=D6vGam6W-0EqFFuSVh8LA5ouaYHv0wknVYzY0G0hh6w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 08, 2011 at 01:10:22AM +0200, Andrey Gursky wrote:
> Hi!
>=20
> Since coming of the linux-3.0-rt patch I've decided to try to switch
> to that kernel, especially the goal of the RT_PREEMPT claims to make =
a
> desktop kernel become a realtime one. Thanks to all rt-developers for
> this opportunity!
>=20
> I'm testing it on 3 platforms:
> 1) notebook Core2Duo T7250,
> 2) old Pentium 4 3.2 GHz with an old passive ISDN hisax-card,
> 3) even older AthlonXP 2.8 GHz with TV-tuner.
>=20
> The first desktop problem is:
> the symbol __rt_mutex_init is exported as GPL-only. This make the
> usage of proprietary nvidia driver impossible, while the normal
> __mutex_init is not only GPL. Could you change the license also for
> the rt_mutex_init (...and maybe few more if they being linked with
> nvidia/ati(?) driver just as with the vanilla "desktop" kernel)?
>=20
> The next issue is more complicated. On the P4 (platform 2) I use an
> ISDN-hisax modem card and per-second internet account. After a timeou=
t
> the connection is being hung up. In firefox I have a lot of tabs. Som=
e
> web pages are "active". They try to call back on their own. While thi=
s
> is happening my gnome freezes sometimes. SysRq-R helps sometimes to
> switch back to the console. But the gdm doesn't start anymore. Is thi=
s
> a relevant issue for the rt-project? What'd be the first place to loo=
k
> at to debug this behavior?
enable PROVE_LOCKING and see if that claims to find something. You migh=
t
have to setup netconsole for that to work.

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
