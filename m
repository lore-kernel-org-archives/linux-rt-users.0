From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: Re: profile_tick not called anymore?
Date: Mon, 26 Mar 2007 16:28:40 +0200
Message-ID: <20070326162840.28b2422e@frecb000686.frec.bull.fr>
References: <20070326155759.5dc54703@frecb000686.frec.bull.fr>
	<20070326140751.GB6797@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:45158 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbXCZObn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Mar 2007 10:31:43 -0400
In-Reply-To: <20070326140751.GB6797@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 26 Mar 2007 16:07:51 +0200 Ingo Molnar <mingo@elte.hu> wrote:

>=20
> * S=E9bastien Dugu=E9 <sebastien.dugue@bull.net> wrote:
>=20
> >   I see that the calls to profile_tick() have been commented out in=
=20
> > the different timer handlers. Why is this so?
> >=20
> >   The only remaining place calling profile_tick() (well, in fact=20
> > __profile_tick()) is the NMI watchdog ticker, but I don't enable it=
 on=20
> > my box.
>=20
> i'm using nmi_watchdog=3D2 to do profiling - if it's NMI-driven then =
the=20
> readprofile results are alot more informative.
>=20

  Thanks Ingo,

  but then I have to explicitly enable it.

  Are there any drawbacks to uncommenting those calls to profile_tick()=
 in
tick_periodic(), tick_nohz_handler() and tick_sched_timer()?

  The reason I ask is that systemtap scripts using the profile probe do=
n't
work on an RT kernel unless nmi_watchdog is set.

  Thanks,

  S=E9bastien.
