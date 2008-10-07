From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PF_HARDIRQ used in preempt-realtime-core.patch
Date: Tue, 7 Oct 2008 10:54:37 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0810071053490.19491@gandalf.stny.rr.com>
References: <20081006194928.GA14183@windriver.com>  <1223324413.17348.47.camel@sven.thebigcorporation.com>  <48EA7F19.90908@windriver.com> <1223328168.17348.77.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1829534103-1223391277=:19491"
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:53910 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbYJGOyk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Oct 2008 10:54:40 -0400
In-Reply-To: <1223328168.17348.77.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1829534103-1223391277=:19491
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Mon, 6 Oct 2008, Sven-Thorsten Dietrich wrote:

> On Mon, 2008-10-06 at 17:11 -0400, Paul Gortmaker wrote:
>=20
> >=20
> > Thanks for the feedback, it helps me to know that I wasn't completely
> > off base with my original thoughts of how to do something that might
> > be useful in the end.
> >=20
>=20
> =EF=BB=BFI've pulled your patches into the preliminary openSUSE 11.1 RT K=
ernel
> so far.
>=20
> =EF=BB=BFI have to admit, a couple of the build fixes I did late night ha=
ve not
> been pushed back; I'll sort through it asap, and I think Greg will have
> some patches for you to add as well.
>=20
> It was my understanding that Thomas wanted to break into several git
> trees that had the different RT "features" broken out into several
> branches, and that makes sense to me.

I will finally have some time this week to start working on this.
I may be peeking at the this git tree too. But first I just want
to break everything out.

-- Steve

--8323328-1829534103-1223391277=:19491--
