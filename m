From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: RT, what to do about up/down_read_non_owner()
Date: Mon, 6 Jun 2016 20:24:46 +0100
Message-ID: <20160606192446.GE14480@ZenIV.linux.org.uk>
References: <1465109869.4263.23.camel@gmail.com>
 <c3b6168e-dde1-fb3b-36e6-5ff4c75e7355@linutronix.de>
 <1465204028.11062.3.camel@gmail.com>
 <1465206604.6397.18.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38636 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbcFFTY4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2016 15:24:56 -0400
Content-Disposition: inline
In-Reply-To: <1465206604.6397.18.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 06, 2016 at 11:50:04AM +0200, Mike Galbraith wrote:
> (CCs Al, who knows, maybe he'll make them go *poof*)
> 
> > > > In v4.7, Al added those buggers to NFS.  BCACHE is disabled in RT
> > > > because of same.. but that's a somewhat suboptimal solution for
> > > > something as widely used as NFS.
> > > > 
> > > > Suggestions?  I reverted the offending commit to get 4.7-rt up and
> > > > running, but that's not gonna fly long term.
> > > 
> > > This API should be avoided according to the comment and completions
> > > should be used. I am for removal of those. Were the locking people okay
> > > with this change in the first place or did this just sneak in?
> > 
> > It just snuck in.  Al reworked sillyunlink, whacking the wait_event()
> > stuff that was there, using annoying $subject instead.

It's more than just wait_event() crap being killed (and crap it certainly
was).  The situation is pretty much the same as with bcache; we don't want
readers to stick around until the initiated action has been completed.

What exactly is RT problem, just to be sure to avoid reproducing exact same
issue in the replacement?
