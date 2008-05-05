From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Preempt-RT patch for 2.6.25
Date: Mon, 05 May 2008 09:17:30 -0700
Message-ID: <1210004250.17132.12.camel@localhost.localdomain>
References: <3efb10970805021102n4d87f55eue723786281b06fcb@mail.gmail.com>
	 <1209753250.25628.34.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>
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
Received: from gateway-1237.mvista.com ([63.81.120.158]:33443 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbYEEQRc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 May 2008 12:17:32 -0400
In-Reply-To: <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 2008-05-02 at 14:45 -0400, Steven Rostedt wrote:
> On Fri, 2 May 2008, Sven-Thorsten Dietrich wrote:
> >
> >
> > His bi-sectability changes are pretty key, and I would like to see those
> > reviewed and incorporated, even if they apply only to x86.
> 
> They would be nice, but I'm also in the process of moving patches around
> to have the next mainline enhancement up front.

Not sure what that has to do with bisect changes?

> >
> > The RT patch queue generally is a mess today.
> > Lots of stuff needs to be folded down into the core patches.
> 
> I'm starting to fold patches together too.

You really want bisection first. The reason is that you don't want ever
growing patches, you want smaller and smaller patches. For instance the
rt-mutex-core.patch is way too large, you wouldn't want to fold my
PICK_FUNCTION changes into that patch since that would just make
rt-mutex-core larger ..


Daniel

