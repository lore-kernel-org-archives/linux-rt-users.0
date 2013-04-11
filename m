From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.6.11.1-rt32
Date: Thu, 11 Apr 2013 13:50:45 -0400
Message-ID: <1365702645.9609.41.camel@gandalf.local.home>
References: <1364527527.10629.10.camel@gandalf.local.home>
	 <515A364B.7070100@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <515A364B.7070100@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-04-02 at 03:37 +0200, Carsten Emde wrote:
> Steven,
>=20
> > I'm pleased to announce the 3.6.11.1-rt32 stable release.
> Thank you.
>=20
> Your patch-3.6.11.1 additionally needs=20
> 23d3b8bfb8eb20e7d96afa09991e6a5ed1c83164 (net: qdisc busylock needs=20
> lockdep annotations) to avoid the compile error
> drivers/net/ppp/ppp_generic.c: In function =E2=80=98ppp_dev_init=E2=80=
=99:
> drivers/net/ppp/ppp_generic.c:1027:5: error: =E2=80=98struct net_devi=
ce=E2=80=99 has no=20
> member named =E2=80=98qdisc_tx_busylock=E2=80=99

Hmm, I was able to do a full 3.6.11.1 allmodconfig without this (see
below). But I'll add it anyway.

>=20
> And since you apparently decided to backport=20
> 303c07db487be59ae9fda10600ea65ca11c21497 (ppp: set qdisc_tx_busylock =
to=20
> avoid LOCKDEP splat), you probably should also backport the related=20

Oh, I added this by mistake, and I believe this is what caused the abov=
e
compile problem. I reverted this as the first patch for .2, and I
compiled 3.6.11.1 with this revert on an allmodconfig.

-- Steve


> changes in bonding and team:
> - 49ee49202b4ac4be95d05e4bf24a9ac8b54c5528 (bonding: set=20
> qdisc_tx_busylock to avoid LOCKDEP splat)
> - b3c581d5d7130fc7f2eab9ab14c8de8882b42380 (team: set qdisc_tx_busylo=
ck=20
> to avoid LOCKDEP splat)
>=20
> 	-Carsten.
