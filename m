From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: nmi_watchdog in latest 22 and 23-rc -rt series
Date: Fri, 14 Sep 2007 22:31:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709142229330.25727@gandalf.stny.rr.com>
References: <46E699F80200008100010574@sinclair.provo.novell.com>
 <46E6AC710200006C00018332@sinclair.provo.novell.com>
 <46E6AC710200006C00018332@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dwalker@mvista.com, linux-rt-users@vger.kernel.org
To: David Bahi <dbahi@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:38328 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760281AbXIOCbq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Sep 2007 22:31:46 -0400
In-Reply-To: <46E6AC710200006C00018332@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>
> > >   For x86-64, the needed APIC is always compiled in, and the NMI
> > >   watchdog is always enabled with I/O-APIC mode (nmi_watchdog=1).
> > >   Currently, local APIC mode (nmi_watchdog=2) does not work on x86-64.
> > >
> > > Is this no longer true?  My experience with nmi_watchdog=2 and this LTP
> > > openposix sched_yeild 1-1.test is that this test hardlocks the host and
> > > that no watchdog is triggered with this setting.
> >
> > It looks like it should work .. I'd be surprised if it didn't work.. You
> > can check if it's ticking in /proc/interrupts under NMI (it stops when
> > the system is idle tho)
>
> well... i've got counts - but like i said earlier it doesn't catch the
> LOCKUP when the LTP test hardlocks the host.
>

I haven't had much luck with nmi_watchdog=2 on x86_64. Usually I get a
few, but they seem to stop coming in at a regular basis.

nmi_watchdog=1 usually slams my system with nmis (1000HZ). But I haven't
had lockups. I'll look into this when I get a chance. (please CC me, so I
remember ;-) Wont be till earliest Monday.

-- Steve
