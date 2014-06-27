From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Fri, 27 Jun 2014 21:11:52 +0200
Message-ID: <1403896312.5830.77.camel@marge.simpson.net>
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
	 <1403892474.5830.41.camel@marge.simpson.net>
	 <20140627141903.16817c28@gandalf.local.home>
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
In-Reply-To: <20140627141903.16817c28@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-06-27 at 14:19 -0400, Steven Rostedt wrote: 
> On Fri, 27 Jun 2014 20:07:54 +0200
> Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
>  
> > > Why do we need the wakeup? the owner of the lock should wake it up
> > > shouldn't it?
> > 
> > True, but that can take ages.
> 
> Can it? If the workqueue is of some higher priority, it should boost
> the process that owns the lock. Otherwise it just waits like anything
> else does.

No, not like everything else, preempt a lock holder.  IO that starts
moving upon context switch in a stock kernel can rot for ages in rt when
an IO packing task bumps into lock held by preempted task.  When there's
a prio delta on a lock, sure, PI kicks in to help a high prio task.. but
there is no PI help for high priority task waiting on IO stuck behind a
low prio task plug.

(you're taking workqueue, I'm talking IO, but the two meet in things
like raid too. you can't prioritize workqueues, and PI doesn't really
have a lot to do with the general issue of things happening or not
happening at context switch time, and consequences thereof)

> I much rather keep the paradigm of the mainline kernel than to add a
> bunch of hacks that can cause more unforeseen side effects that may
> cause other issues.

The paradigm of mainline is to start IO on context switch, reason for
that is IO deadlock prevention.  We need to follow paradigm somehow.
That somehow really wants to be a tad prettier and more guaranteed than
my somehow :)

-Mike
