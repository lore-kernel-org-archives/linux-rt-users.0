From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [Announce] 2.6.29-rc8-rt3
Date: Tue, 24 Mar 2009 22:07:15 +0100
Message-ID: <20090324210715.GA10130@pengutronix.de>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain> <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain> <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain> <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain> <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain> <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain> <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain> <alpine.LFD.2.00.0903231723090.29264@localhost.localdomain> <20090324110431.GA6058@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51623 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbZCXVHW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Mar 2009 17:07:22 -0400
Content-Disposition: inline
In-Reply-To: <20090324110431.GA6058@nowhere>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> >     http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.2=
9-rc8.tar.bz2
> >     http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29=
-rc8-rt3.bz2
>=20
>=20
> Hi,
>=20
> It doesn't seem to be available (404).
> But I can see a 2.6.29-rc8-rt4.bz2 downloadable.
>=20
> Thanks.
This is a channel log from #linux-rt

19:57 < clark|w> tglx, just how small was the -rt3 window (which I hit =
btw)?
19:58 < tglx> you mean how long -rt3 was up on the web ?
19:58 < clark|w> yeah
19:58 < tglx> half an hour or so
19:59 < clark|w> because I got it, built/booted it (64-bit) and was run=
ning it=20
                 up til thismorning when I saw that you'd released -rt4=
 :)
19:59 < tglx> 64bit was fine
19:59 < tglx> I fixed a 32bit PAE bug in -rt2 and when I pushed out -rt=
3 I did=20
              not notice that half of the fix was lost
20:00 < tglx> so I zapped it and pushed out rt4
20:00 < clark|w> cool
20:00 < clark|w> good think I'm 64bit clean :)
20:00 < tglx> but I was too tired to send out another mail

Just FYI
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
