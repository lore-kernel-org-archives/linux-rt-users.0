From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 2.6.31.4-rt14
Date: Wed, 4 Nov 2009 09:38:11 +0100
Message-ID: <20091104083811.GA23889@pengutronix.de>
References: <alpine.LFD.2.00.0908182140340.3361@localhost.localdomain> <alpine.LFD.2.00.0908192344500.3361@localhost.localdomain> <alpine.LFD.2.00.0908212319370.1769@localhost.localdomain> <alpine.LFD.2.00.0908261910460.2888@localhost.localdomain> <alpine.LFD.2.00.0908282326460.19335@localhost.localdomain> <alpine.LFD.2.00.0909152257590.8957@localhost.localdomain> <alpine.LFD.2.00.0909190027400.2889@localhost.localdomain> <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain> <alpine.LFD.2.00.0910141115020.9428@localhost.localdomain> <1257300790.25489.16.camel@localhost.localdomain>
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
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Mark Knecht <markknecht@gmail.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754511AbZKDIiW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1257300790.25489.16.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Nov 04, 2009 at 02:13:10AM +0000, Fernando Lopez-Lezcano wrote:
> On Wed, 2009-10-14 at 12:02 +0200, Thomas Gleixner wrote:
> > We are pleased to announce the next update to our new preempt-rt
> > series.
> >=20
> >    - Forward to 2.6.31.4
>=20
> Could some guru rebase to 2.6.31.5 please?
> I get two failed chunks in kernel/futex.c
tip/rt/2.6.31 [1] is at v2.6.31.5-rt16 (but untagged).  You might get
kernel/futex.c from there.  I assume -rt16 isn't released yet as there
is no tag.

Best regards
Uwe

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.git;a=
=3Dshortlog;h=3Drefs/heads/rt/2.6.31

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
