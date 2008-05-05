From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Preempt-RT patch for 2.6.25
Date: Mon, 05 May 2008 09:19:36 -0700
Message-ID: <1210004376.17132.14.camel@localhost.localdomain>
References: <3efb10970805021102n4d87f55eue723786281b06fcb@mail.gmail.com>
	 <1209753250.25628.34.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>
	 <1209754467.25628.42.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0805021502040.10615@gandalf.stny.rr.com>
	 <1210003265.17132.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0805051210410.23084@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	Remy Bohmer <linux@bohmer.net>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jonathan@jonmasters.org>,
	Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:34984 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbYEEQTi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 May 2008 12:19:38 -0400
In-Reply-To: <Pine.LNX.4.58.0805051210410.23084@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-05-05 at 12:11 -0400, Steven Rostedt wrote:
> On Mon, 5 May 2008, Daniel Walker wrote:
> >
> > Download my tree .. It boots in my testing, and it's on 2.6.25 .. If it
> > doesn't boot for you, just bisect down to the offending patch.. While I
> > forward ported 2.6.24.4-rt4 to 2.6.25 I bisected several times finding
> > errors (which reduced debugging time considerably.).
> >
> 
> Daniel,
> 
> Thanks, but the bugs were caused by some of my backporting of other
> updates (percpu and ftrace). I have them fixed, but I'm also looking at
> rearranging the patch queue as well to get things ready for mainline.

You should review my tree, it is several steps closer to mainline that
the -rt version your working on. I did a lot of patch break-ups
(required for bisection, and makes for a cleaner tree) and re-arranging
patches. 

Bisection is also required for mainline integration ..

Daniel

