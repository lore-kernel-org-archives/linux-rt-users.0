From: Chris Mason <chris.mason@fusionio.com>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM..  and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Mon, 16 Jul 2012 12:35:39 -0400
Message-ID: <20120716163539.GH25961@shiny.int.fusionio.com>
References: <1342072060.7338.102.camel@marge.simpson.net>
 <20120713125043.GH30128@shiny>
 <1342260883.7368.30.camel@marge.simpson.net>
 <20120715175612.GF25961@shiny.int.fusionio.com>
 <1342404140.7659.27.camel@marge.simpson.net>
 <1342454547.5410.3.camel@gandalf.stny.rr.com>
 <1342455968.7659.93.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Chris L. Mason" <clmason@fusionio.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1342455968.7659.93.camel@marge.simpson.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jul 16, 2012 at 10:26:08AM -0600, Mike Galbraith wrote:
> On Mon, 2012-07-16 at 12:02 -0400, Steven Rostedt wrote: 
> > On Mon, 2012-07-16 at 04:02 +0200, Mike Galbraith wrote:
> > 
> > > > Great, thanks!  I got stuck in bug land on Friday.  You mentioned
> > > > performance problems earlier on Saturday, did this improve performance?
> > > 
> > > Yeah, the read_trylock() seems to improve throughput.  That's not
> > > heavily tested, but it certainly looks like it does.  No idea why.
> > 
> > Ouch, you just turned the rt_read_lock() into a spin lock. If a higher
> > priority process preempted a lower priority process that holds the same
> > lock, it will deadlock.
> 
> Hm, how, it's doing cpu_chill()?
> 
> > I'm not sure why you would get a performance benefit from this, as the
> > mutex used is an adaptive one (failure to acquire the lock will only
> > sleep if preempted or if the owner is not running).
> 
> I'm not attached to it, can whack it in a heartbeat.. especially so it
> the thing can deadlock.  I've seen enough of those of late.
> 
> > We should look at why this performs better (if it really does).
> 
> Not sure it really does, there's variance, but it looked like it did.
> 

I'd use a benchmark that is more consistent than dbench for this.  I
love dbench for generating load (and the occasional deadlock) but it
tends to steer you in the wrong direction on performance.

-chris

