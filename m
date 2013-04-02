From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [ANNOUNCE] 3.6.11.1-rt32
Date: Tue, 02 Apr 2013 03:37:15 +0200
Message-ID: <515A364B.7070100@osadl.org>
References: <1364527527.10629.10.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364527527.10629.10.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven,

> I'm pleased to announce the 3.6.11.1-rt32 stable release.
Thank you.

Your patch-3.6.11.1 additionally needs=20
23d3b8bfb8eb20e7d96afa09991e6a5ed1c83164 (net: qdisc busylock needs=20
lockdep annotations) to avoid the compile error
drivers/net/ppp/ppp_generic.c: In function =E2=80=98ppp_dev_init=E2=80=99=
:
drivers/net/ppp/ppp_generic.c:1027:5: error: =E2=80=98struct net_device=
=E2=80=99 has no=20
member named =E2=80=98qdisc_tx_busylock=E2=80=99

And since you apparently decided to backport=20
303c07db487be59ae9fda10600ea65ca11c21497 (ppp: set qdisc_tx_busylock to=
=20
avoid LOCKDEP splat), you probably should also backport the related=20
changes in bonding and team:
- 49ee49202b4ac4be95d05e4bf24a9ac8b54c5528 (bonding: set=20
qdisc_tx_busylock to avoid LOCKDEP splat)
- b3c581d5d7130fc7f2eab9ab14c8de8882b42380 (team: set qdisc_tx_busylock=
=20
to avoid LOCKDEP splat)

	-Carsten.
