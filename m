From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.14.23-rt20
Date: Wed, 5 Nov 2014 17:48:22 -0500
Message-ID: <20141105174822.491e1eff@gandalf.local.home>
References: <20141031170326.1491a63f@gandalf.local.home>
	<1414913427.5380.110.camel@marge.simpson.net>
	<CADLDEKvFvw7Aa98tVtM3z5JV8oocKqAdV4PqOMoZH2mXZ6x2jg@mail.gmail.com>
	<20141105092707.7c9bb1ae@gandalf.local.home>
	<alpine.DEB.2.11.1411051703440.4245@nanos>
	<alpine.DEB.2.11.1411052314150.24960@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Juerg Haefliger <juergh@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1411052314150.24960@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 5 Nov 2014 23:29:32 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > > When we allow multiple readers, this will be allowed. But even in
> > > mainline, if a writer were to come in and block between those two
> > > down_read_trylocks(), the second trylock would fail.
> > > 
> > > PREEMPT_RT just has that fail all the time as we only allow an rwsem to
> > > be held by a single reader.
> > 
> > Errm. The reader holds the sem already. So that's a recursive read
> > lock which should always succeed. And rt_read_trylock() has that
> > implemented.
> 
> Bah. That's the rwlock path. Untested patch below should fix the issue.

This is basically a revert of my patch that removed rwsems as being
recursive, because they are not recursive in mainline.

If you have the following:

	down_read(&A);

				down_write(&A);

	down_read(&A);

in mainline, you will have a deadlock. With this change, it will not
deadlock on -rt.

This is probably why that cpu governor code uses down_read_trylock()
otherwise, it would have suffered from possible deadlock scenarios.

But, for a quick solution, just use this patch. I'll start working on
the multi rwsem readers again, and then I'll have to revert this to do
that. But when we have multi readers again, we wont need to have this
hack.

-- Steve
