From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Fri, 27 Jun 2014 20:07:54 +0200
Message-ID: <1403892474.5830.41.camel@marge.simpson.net>
References: <CANGgnMbHckBQdKGN_N5Q6qEKc9n1CenxvMpeXog1NbSdL8UrTw@mail.gmail.com>
	 <CANGgnMYDXerOUDOO9-RHMJKadKACA2KBGskZwoP-1ZwAhDEfVA@mail.gmail.com>
	 <CAFLxGvxfBt7OvW=a2Kz08GLHSEiiOZsN-vB19CXnQiwqFxqMsA@mail.gmail.com>
	 <CANGgnMYVoP-Z0Bv-VDEkJnvfa7Fi4-zY2F4A0PhMewGvwo3VVw@mail.gmail.com>
	 <alpine.DEB.2.10.1406270027300.5170@nanos>
	 <CANGgnMa+qtgJ3wwg_h5Rynw5vEvZpQZ6PvaUfXNQ8+Y3Yu5U0g@mail.gmail.com>
	 <1403873856.5827.56.camel@marge.simpson.net>
	 <20140627100157.6b0143a5@gandalf.local.home>
	 <1403890493.5830.33.camel@marge.simpson.net>
	 <20140627135415.7246e87e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Austin Schuh <austin@peloton-tech.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140627135415.7246e87e@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-06-27 at 13:54 -0400, Steven Rostedt wrote: 
> On Fri, 27 Jun 2014 19:34:53 +0200
> Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> 
> > On Fri, 2014-06-27 at 10:01 -0400, Steven Rostedt wrote:
> > 
> > > This seems like a lot of hacks.
> > 
> > It is exactly that, lacking proper pooper-scooper, show rt kernel how to
> > not step in it.
> > 
> > > I'm wondering if it would work if we
> > > just have the rt_spin_lock_slowlock not call schedule(), but call
> > > __schedule() directly. I mean it would keep with the mainline paradigm
> > > as spinlocks don't sleep there, and one going to sleep in the -rt
> > > kernel is similar to it being preempted by a very long NMI.
> > 
> > Problem being that we do sleep there, do need wakeup.  I have a hack
> > that turns them back into spinning locks, but it.. works too :)
> 
> Why do we need the wakeup? the owner of the lock should wake it up
> shouldn't it?

True, but that can take ages.

-Mike 
