From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RT] Lockdep warning on boot with 2.6.31-rc5-rt1.1
Date: Fri, 7 Aug 2009 17:30:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908071725510.8084-100000@netrider.rowland.org>
References: <1249663785.32113.754.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"greg@kroah.com" <greg@kroah.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kay Sievers <kay.sievers@vrfy.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756303AbZHGVaq@vger.kernel.org>
In-Reply-To: <1249663785.32113.754.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 7 Aug 2009, Peter Zijlstra wrote:

> On Fri, 2009-08-07 at 12:45 -0400, Alan Stern wrote:
> > On Fri, 7 Aug 2009, Peter Zijlstra wrote:
> 
> > > The other proposal was creating a fixed list of classes and register
> > > each device at a class corresponding to its depth in the tree. I can't
> > > remember what was wrong with that, but I seem to have been persuaded
> > > that that was hard too.
> > 
> > It probably would work for the most part.  However a possible scenario
> > involves first locking a parent and then locking all its children.  (I
> > don't know if this ever happens anywhere, but it might.)  This can't
> > cause a deadlock but it would run into trouble with depth-based
> > classes.
> 
> If you know which parent is locked, we can solve that with
> mutex_lock_nest_lock() [ doesn't currently exist, but is analogous to
> spin_lock_nest_lock() ] and together with
> http://lkml.org/lkml/2009/7/23/222 that would allow you to lock up to
> 2048 children.

Not only do I know not which parent is locked, I don't even know if 
this ever happens anywhere at all!  My point was purely theoretical.

> Would something like that work?

Perhaps -- I don't understand what spin_lock_nest_lock() is supposed to
do.

Alan Stern
