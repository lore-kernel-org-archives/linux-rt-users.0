From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 3/3 - take two ] fix get_monotonic_cycles for latency
 tracer
Date: Sat, 25 Aug 2007 21:26:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708252121310.26667@gandalf.stny.rr.com>
References: <1187978236.2941.19.camel@localhost.localdomain>
 <1187982149.4574.1.camel@localhost.localdomain> <y0modgv50vl.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
To: "Frank Ch. Eigler" <fche@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934838AbXHZB1t@vger.kernel.org>
In-Reply-To: <y0modgv50vl.fsf@ton.toronto.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sat, 25 Aug 2007, Frank Ch. Eigler wrote:

>
> Steven Rostedt <rostedt@goodmis.org> writes:
>
> > [...]
> > +		 * [...] We don't need to grab
> > +		 * any locks, we just keep trying until get all the
> > +		 * calculations together in one state.
> > +		 *
> > +		 * In fact, we __cant__ grab any locks. This
> > +		 * function is called from the latency_tracer which can
> > +		 * be called anywhere. To grab any locks (including
> > +		 * seq_locks) we risk putting ourselves into a deadlock.
>
> Perhaps you could add a comment about why the loop, which appears
> potentially infinite as written, avoids livelock.  (It looks rather
> like a seqlock read loop.)
>

I guess I need to rewrite that comment. It shouldn't appear infinitely
looping, since it is basically: do { x=A; func() } while (x != A); which
to me seems that while is most likely to fail unless something touches A.

But yes, it _is_ basically a seq lock, but its on what we are working
with.  And we don't even need any memory barriers that a seq lock might
do, since it is very obvious to gcc that the function call can modify the
variables that we are testing.

But do you still think that looks inifinte?  If so, I'll reword it.

-- Steve
