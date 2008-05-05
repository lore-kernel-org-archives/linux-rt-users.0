From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Preempt-RT patch for 2.6.25
Date: Mon, 05 May 2008 09:31:13 -0700
Message-ID: <1210005073.17132.16.camel@localhost.localdomain>
References: <3efb10970805021102n4d87f55eue723786281b06fcb@mail.gmail.com>
	 <1209753250.25628.34.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>
	 <1210004250.17132.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0805051220590.25250@gandalf.stny.rr.com>
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
Received: from gateway-1237.mvista.com ([63.81.120.158]:40726 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbYEEQbS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 May 2008 12:31:18 -0400
In-Reply-To: <Pine.LNX.4.58.0805051220590.25250@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-05-05 at 12:21 -0400, Steven Rostedt wrote:
> On Mon, 5 May 2008, Daniel Walker wrote:
> > You really want bisection first. The reason is that you don't want ever
> > growing patches, you want smaller and smaller patches. For instance the
> > rt-mutex-core.patch is way too large, you wouldn't want to fold my
> > PICK_FUNCTION changes into that patch since that would just make
> > rt-mutex-core larger ..
> >
> 
> Yeah, I already did that ;-)

You already folded my PICK_FUNCTION changes? That's why I mentioned it.

Daniel

