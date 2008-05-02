From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Preempt-RT patch for 2.6.25
Date: Fri, 2 May 2008 15:02:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805021502040.10615@gandalf.stny.rr.com>
References: <3efb10970805021102n4d87f55eue723786281b06fcb@mail.gmail.com>
 <1209753250.25628.34.camel@dd.thebigcorporation.com>
 <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>
 <1209754467.25628.42.camel@dd.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Remy Bohmer <linux@bohmer.net>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jonathan@jonmasters.org>,
	Ingo Molnar <mingo@elte.hu>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:43236 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936227AbYEBTCg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2008 15:02:36 -0400
In-Reply-To: <1209754467.25628.42.camel@dd.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 2 May 2008, Sven-Thorsten Dietrich wrote:
>
> On Fri, 2008-05-02 at 14:45 -0400, Steven Rostedt wrote:
> > On Fri, 2 May 2008, Sven-Thorsten Dietrich wrote:
>
> >
> > As for 2.6.25-rt1, I'm currently working on it. I have the patch queue
> > ready, but it has some major bugs that I'm stil working out. I did a bit
> > of clean up in the per-cpu portion as well as some of the mutex code. Now
> > I need to debug all those changes.
>
> Pls post what you have asap, we will all help you debug it.

You'll have something today. I like to have a kernel that at least boots
;-)

-- Steve

