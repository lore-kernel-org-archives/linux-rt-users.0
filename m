From: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [PATCH RT] Fix RT balancing tasks pulling
Date: Tue, 31 Jul 2007 13:48:24 +0200
Message-ID: <20070731134824.6ec78447@frecb000686.frec.bull.fr>
References: <20070724154202.224f12e8@frecb000686.frec.bull.fr>
	<1185832234.3334.35.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>
To: Josh Triplett <josht@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:46621 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbXGaLvJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 07:51:09 -0400
In-Reply-To: <1185832234.3334.35.camel@josh-work.beaverton.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


  Hi Josh,

On Mon, 30 Jul 2007 14:50:34 -0700 Josh Triplett <josht@linux.vnet.ibm.=
com> wrote:

> On Tue, 2007-07-24 at 15:42 +0200, S=C3=A9bastien Dugu=C3=A9 wrote:
> >   this one-liner fixes a bug in balance_rt_tasks() which sometimes =
manifests by
> > having a lower prio task being scheduled while a higher prio task i=
s sitting
> > waiting on another runqueue.
> >=20
> >   This is pretty hard to reproduce on low cpu count machines, for e=
xample, I
> > had to have sched_football run in a loop for ~38h before it failed =
on a dual HT
> > Xeon box.
>=20
> Very impressive find, and this does seem to improve things in some
> cases.
>=20
> However, with 2.6.22.1-rt8, which includes this patch, I still manage=
d
> to get some failures after a few hours on an 8-way (quad dual-core) b=
ox.
> Preliminary results so far:
>     420 Final ball position: 0
>       2 Final ball position: 1
>=20

  Darn, I thought it was it :(

  I had a ~60h run on my box with the very same kernel without a single
failure.

  Do you have any other user RT load running when those failures pop up=
?

  Anyway, back to scheduler code dissection now.

  S=C3=A9bastien.
