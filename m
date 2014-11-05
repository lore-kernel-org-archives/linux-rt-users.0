From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.14.23-rt20
Date: Wed, 5 Nov 2014 17:07:10 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1411051703440.4245@nanos>
References: <20141031170326.1491a63f@gandalf.local.home> <1414913427.5380.110.camel@marge.simpson.net> <CADLDEKvFvw7Aa98tVtM3z5JV8oocKqAdV4PqOMoZH2mXZ6x2jg@mail.gmail.com> <20141105092707.7c9bb1ae@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Juerg Haefliger <juergh@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141105092707.7c9bb1ae@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 5 Nov 2014, Steven Rostedt wrote:
> On Wed, 5 Nov 2014 14:50:41 +0100
> Juerg Haefliger <juergh@gmail.com> wrote:
> 
> > On Sun, Nov 2, 2014 at 8:30 AM, Mike Galbraith <umgwanakikbuti@gmail.com>
> > wrote:
> > >
> > > On Fri, 2014-10-31 at 17:03 -0400, Steven Rostedt wrote:
> > > > Dear RT Folks,
> > > >
> > > > I'm pleased to announce the 3.14.23-rt20 stable release.
> > > >
> > > > This is the first 3.14-rt release in the stable-rt series. Normally I
> > > > wait till the next development release is out before I pull in a new
> > > > one. That is, I would pull in 3.14-rt when 3.16-rt or later was
> > > > released. But because development is now moving at a "hobbyist rate"
> > > > (read http://lwn.net/Articles/617140/ for details)
> > > > and 3.14-rt is no longer being developed against, I figured it was
> > > time
> > > > to put it under the "stable-rt" umbrella.
> > >
> > > I piddled about with it yesterday, found that you can't change cpufreq
> > > governor IFF the tree is configured as rt, but works fine as voluntary
> > > preempt.
> > 
> > The problem seems to be this patch: https://lkml.org/lkml/2014/4/8/584
> > 
> > The cpufreq code does nested down_read_trylocks and only the first one
> > succeeds:
> > 
> > drivers/cpufreq/cpufreq.c:
> > store
> >   down_read_trylock(cpufreq_rwsem)  <- succeeds
> >   store_scaling_governor
> >     cpufreq_get_policy
> >       cpufreq_cpu_get
> >         down_read_trylock(cpufreq_rwsem)  <-- fails
> > 
> > Reverting the above patch 'fixes' the problem. I don't understand Steven's
> > commit comment that readers of rwsem are not allowed to nest in mainline
> > since this works just fine in mainline.
> 
> When we allow multiple readers, this will be allowed. But even in
> mainline, if a writer were to come in and block between those two
> down_read_trylocks(), the second trylock would fail.
> 
> PREEMPT_RT just has that fail all the time as we only allow an rwsem to
> be held by a single reader.

Errm. The reader holds the sem already. So that's a recursive read
lock which should always succeed. And rt_read_trylock() has that
implemented.

Thanks,

	tglx
