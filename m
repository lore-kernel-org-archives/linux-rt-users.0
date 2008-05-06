From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Preempt-RT patch for 2.6.25
Date: Tue, 6 May 2008 03:54:45 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0805060334220.3318@apollo.tec.linutronix.de>
References: <3efb10970805021102n4d87f55eue723786281b06fcb@mail.gmail.com>  <1209753250.25628.34.camel@dd.thebigcorporation.com>  <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>  <1209754467.25628.42.camel@dd.thebigcorporation.com>
 <Pine.LNX.4.58.0805021502040.10615@gandalf.stny.rr.com>  <1210003265.17132.6.camel@localhost.localdomain>  <Pine.LNX.4.58.0805051210410.23084@gandalf.stny.rr.com>  <1210004376.17132.14.camel@localhost.localdomain>  <Pine.LNX.4.58.0805051240520.25250@gandalf.stny.rr.com>
  <1210007084.17132.32.camel@localhost.localdomain>  <Pine.LNX.4.58.0805051426010.25250@gandalf.stny.rr.com>  <1210013938.17132.55.camel@localhost.localdomain>  <alpine.LFD.1.10.0805052107270.3318@apollo.tec.linutronix.de>
 <1210025532.17132.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	Remy Bohmer <linux@bohmer.net>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Jon Masters <jonathan@jonmasters.org>,
	Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:41128 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbYEFB5W (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 May 2008 21:57:22 -0400
In-Reply-To: <1210025532.17132.82.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 5 May 2008, Daniel Walker wrote:
> On Mon, 2008-05-05 at 23:01 +0200, Thomas Gleixner wrote:
> > We have been there before. kernel development does not follow the "we
> > want _now_" principle at all. Have you ever tried to yell at Linus "we
> > want XYZ _now_" ? If you decide to try it, please keep me on CC - I
> > want to enjoy the show.
> 
> Kernel development is "What is available now?" not what is avaiable in
> the future.
> 
> If you want to reject code you better have a reason other than "We're
> going to make some new code for that (some time in the future) sorry."

You miss the point. We reject code which breaks existing functionality.
 
> I'd like to hear Linus come out and say, "Sorry Thomas we can't include
> your HRT cause we're getting a newer HRT in three years, so sorry about
> that."

Good point. HRT is mainline and it went through 300+ patch queues
release cycles until the last bits got finaly merged.

I appreciate your competent input how to do mainline development on
large scale projects. In hindsight I regret that I did not hire you as
my personal "get HRT merged" assistant. That would have saved me a lot
of trouble and time.

Thanks,
	
	tglx
