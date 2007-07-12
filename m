From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22
	available
Date: Thu, 12 Jul 2007 15:09:58 +0200
Message-ID: <20070712130958.GB17494@elte.hu>
References: <4695E5BB0200005A0002763E@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pwil3058@bigpond.net.au, jim.houston@ccur.com, joe.korty@ccur.com,
	rostedt@goodmis.org, tglx@linutronix.de, dwalker@mvista.com,
	David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	williams@redhat.com, abogani@texware.it,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:48472 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759011AbXGLNLG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 09:11:06 -0400
Content-Disposition: inline
In-Reply-To: <4695E5BB0200005A0002763E@mcclure.wal.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Gregory Haskins <ghaskins@novell.com> wrote:

> On Thu, 2007-07-12 at 14:07 +0200, Ingo Molnar wrote:
> > * Gregory Haskins <ghaskins@novell.com> wrote:
> > 
> > > Hi Ingo, Thomas, and the greater linux-rt community,
> > >   
> > > 	I just wanted to let you guys know that our team has a port of 
> > > the 21.5-rt20 patch for the 2.6.22 kernel available. [...]
> > 
> > great! We had the upstream -rt port to .22 in the works too, it was just 
> > held up by the hpet breakage - which Thomas managed to fix earlier 
> > today. I've released the 2.6.22.1-rt1 patch to the usual place:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> 
> Thats awesome, Ingo!  Thanks!  Could you publish a broken out version 
> as well?  We found it extremely valuable to be able to bisect this 
> beast while working on the 21-22 port.

we are working on something in this area :) Stay tuned ...

	Ingo
