From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 2.6.31.4-rt14
Date: Thu, 05 Nov 2009 11:44:04 -0800
Message-ID: <1257450244.4549.19.camel@localhost.localdomain>
References: <alpine.LFD.2.00.0908182140340.3361@localhost.localdomain>
	 <alpine.LFD.2.00.0908192344500.3361@localhost.localdomain>
	 <alpine.LFD.2.00.0908212319370.1769@localhost.localdomain>
	 <alpine.LFD.2.00.0908261910460.2888@localhost.localdomain>
	 <alpine.LFD.2.00.0908282326460.19335@localhost.localdomain>
	 <alpine.LFD.2.00.0909152257590.8957@localhost.localdomain>
	 <alpine.LFD.2.00.0909190027400.2889@localhost.localdomain>
	 <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain>
	 <alpine.LFD.2.00.0910141115020.9428@localhost.localdomain>
	 <1257300790.25489.16.camel@localhost.localdomain>
	 <20091104083811.GA23889@pengutronix.de>
	 <1257449624.4549.16.camel@localhost.localdomain>
	 <alpine.LFD.2.00.0911052040370.12138@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nando@ccrma.Stanford.EDU,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
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
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.Stanford.EDU ([171.67.219.82]:60991 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758814AbZKETow (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Nov 2009 14:44:52 -0500
In-Reply-To: <alpine.LFD.2.00.0911052040370.12138@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-11-05 at 20:41 +0100, Thomas Gleixner wrote:
> On Thu, 5 Nov 2009, Fernando Lopez-Lezcano wrote:
>=20
> > On Wed, 2009-11-04 at 09:38 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Nov 04, 2009 at 02:13:10AM +0000, Fernando Lopez-Lezcano =
wrote:
> > > > On Wed, 2009-10-14 at 12:02 +0200, Thomas Gleixner wrote:
> > > > > We are pleased to announce the next update to our new preempt=
-rt
> > > > > series.
> > > > >=20
> > > > >    - Forward to 2.6.31.4
> > > >=20
> > > > Could some guru rebase to 2.6.31.5 please?
> > > > I get two failed chunks in kernel/futex.c
> > >
> > > tip/rt/2.6.31 [1] is at v2.6.31.5-rt16 (but untagged).  You might=
 get
> > > kernel/futex.c from there.  I assume -rt16 isn't released yet as =
there
> > > is no tag.
> > >=20
> > > Best regards
> > > Uwe
> > >=20
> > > [1] http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip=
=2Egit;a=3Dshortlog;h=3Drefs/heads/rt/2.6.31
> >=20
> > Thanks! I managed to get a package done for it and I'm running it, =
so
> > far so good.=20
> >=20
> > Do you know why it has not been officially released yet? Anything I
> > should watch out for?
>=20
> Simply because I did not come around as I'm swamped with my mail back=
log. :(

Great! Thanks for the heads up....
-- Fernando


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
