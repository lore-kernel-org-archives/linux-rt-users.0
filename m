From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Preempt-RT patch for 2.6.25
Date: Fri, 02 May 2008 12:14:25 -0700
Message-ID: <1209755665.25628.50.camel@dd.thebigcorporation.com>
References: <3efb10970805021102n4d87f55eue723786281b06fcb@mail.gmail.com>
	 <1209753250.25628.34.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>
	 <1209754467.25628.42.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0805021502040.10615@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Remy Bohmer <linux@bohmer.net>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jonathan@jonmasters.org>,
	Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:62189 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYEBTPA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2008 15:15:00 -0400
Received: by wa-out-1112.google.com with SMTP id j37so452167waf.23
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2008 12:15:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0805021502040.10615@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 2008-05-02 at 15:02 -0400, Steven Rostedt wrote:
> On Fri, 2 May 2008, Sven-Thorsten Dietrich wrote:
> >
> > On Fri, 2008-05-02 at 14:45 -0400, Steven Rostedt wrote:
> > > On Fri, 2 May 2008, Sven-Thorsten Dietrich wrote:
> >
> > >
> > > As for 2.6.25-rt1, I'm currently working on it. I have the patch queue
> > > ready, but it has some major bugs that I'm stil working out. I did a bit
> > > of clean up in the per-cpu portion as well as some of the mutex code. Now
> > > I need to debug all those changes.
> >
> > Pls post what you have asap, we will all help you debug it.
> 
> You'll have something today. I like to have a kernel that at least boots
> ;-)

Hey that's true for Linux always. Its more fun that way :)

Lets definitely try and make it more bisectable:

I'll be pulling this into OpenSUSE 11 ASAP, so whatever I find I'll send
over!

Thanks !

Sven

