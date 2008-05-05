From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Preempt-RT patch for 2.6.25
Date: Mon, 05 May 2008 09:01:05 -0700
Message-ID: <1210003265.17132.6.camel@localhost.localdomain>
References: <3efb10970805021102n4d87f55eue723786281b06fcb@mail.gmail.com>
	 <1209753250.25628.34.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>
	 <1209754467.25628.42.camel@dd.thebigcorporation.com>
	 <Pine.LNX.4.58.0805021502040.10615@gandalf.stny.rr.com>
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
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758451AbYEEQBW@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0805021502040.10615@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


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

Download my tree .. It boots in my testing, and it's on 2.6.25 .. If it
doesn't boot for you, just bisect down to the offending patch.. While I
forward ported 2.6.24.4-rt4 to 2.6.25 I bisected several times finding
errors (which reduced debugging time considerably.).

Daniel
