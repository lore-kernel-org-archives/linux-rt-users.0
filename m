From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH RT] Fix RT balancing tasks pulling
Date: Tue, 31 Jul 2007 17:18:03 -0700
Message-ID: <1185927483.4191.6.camel@josh-work.beaverton.ibm.com>
References: <20070724154202.224f12e8@frecb000686.frec.bull.fr>
	 <1185832234.3334.35.camel@josh-work.beaverton.ibm.com>
	 <20070731134824.6ec78447@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60182 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761830AbXHAARi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 20:17:38 -0400
In-Reply-To: <20070731134824.6ec78447@frecb000686.frec.bull.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-07-31 at 13:48 +0200, S=C3=A9bastien Dugu=C3=A9 wrote:
> On Mon, 30 Jul 2007 14:50:34 -0700 Josh Triplett <josht@linux.vnet.ib=
m.com> wrote:
> > On Tue, 2007-07-24 at 15:42 +0200, S=C3=A9bastien Dugu=C3=A9 wrote:
> > >   this one-liner fixes a bug in balance_rt_tasks() which sometime=
s manifests by
> > > having a lower prio task being scheduled while a higher prio task=
 is sitting
> > > waiting on another runqueue.
> > >=20
> > >   This is pretty hard to reproduce on low cpu count machines, for=
 example, I
> > > had to have sched_football run in a loop for ~38h before it faile=
d on a dual HT
> > > Xeon box.
> >=20
> > Very impressive find, and this does seem to improve things in some
> > cases.
> >=20
> > However, with 2.6.22.1-rt8, which includes this patch, I still mana=
ged
> > to get some failures after a few hours on an 8-way (quad dual-core)=
 box.
> > Preliminary results so far:
> >     420 Final ball position: 0
> >       2 Final ball position: 1
> >=20
>=20
>   Darn, I thought it was it :(
>=20
>   I had a ~60h run on my box with the very same kernel without a sing=
le
> failure.

I think you really need a box with more processors to reproduce these
problems in a reasonable timeframe.  Happy to test any patches you have
to fix RT balancing; please let me know.

>   Do you have any other user RT load running when those failures pop =
up?

Other than sched_football, I had sshd, bash, and GNU screen,
theoretically all 100% idle (no input to read and no output to display)=
=2E

- Josh Triplett
