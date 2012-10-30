From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Fix crypto api init for 3.6.4-rt10
Date: Tue, 30 Oct 2012 21:35:35 +0100
Message-ID: <20121030203535.GY639@pengutronix.de>
References: <50844D01.9090805@gmail.com>
 <5084551E.5040304@ursulin.net>
 <508ED985.5060301@ursulin.net>
 <508EDD6E.7030908@gmail.com>
 <508EE395.9010709@ursulin.net>
 <508EEAF2.4090506@ursulin.net>
 <20121030094001.GV639@pengutronix.de>
 <508FA405.2050509@redhat.com>
 <508FF1D6.3030900@redhat.com>
 <alpine.LFD.2.02.1210301856390.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Milan Broz <mbroz@redhat.com>, Tvrtko Ursulin <tvrtko@ursulin.net>,
	linux-rt-users@vger.kernel.org, dm-crypt@saout.de,
	linux-kernel@vger.kernel.org, okozina@redhat.com
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58184 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934472Ab2J3Ufq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2012 16:35:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1210301856390.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Tue, Oct 30, 2012 at 06:57:37PM +0100, Thomas Gleixner wrote:
> On Tue, 30 Oct 2012, Milan Broz wrote:
>=20
> > Fix crypto api for 3.6.4-rt10 (broken only in realtime patchset)
> >=20
> > In peterz-srcu-crypto-chain.patch the blocking notifier is changed
> > to srcu notifier and added initialization to module init fucntion.
> >=20
> > Later, in crypto-make-core-static-and-init-scru-early.patch, is tha=
t
> > initialization added also to core_initcall().
> >=20
> > This patch removes crypto_chain init from algapi initialization,
> > because this function is called later and already initialized
> > cryptomgr notifier is lost.
>=20
> Grrr. So I forgot top zap the one Peter added. Stupid me.
> =20
> > This cause a failure in initialization of larval algorithms,
> > like e.g. cbc(aes).
>=20
> Thanks for spotting!
This patch fixes booting my laptop. But now it hangs after login.

thanks
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
