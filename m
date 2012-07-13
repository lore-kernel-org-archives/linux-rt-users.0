From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM.. and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Fri, 13 Jul 2012 12:14:45 +0200
Message-ID: <1342174485.7380.103.camel@marge.simpson.net>
References: <1342072060.7338.102.camel@marge.simpson.net>
	 <1342082648.7338.171.camel@marge.simpson.net>
	 <1342086792.7707.9.camel@marge.simpson.net>
	 <alpine.LFD.2.02.1207121310420.32033@ionos>
	 <1342094233.7707.12.camel@marge.simpson.net>
	 <alpine.LFD.2.02.1207121514240.32033@ionos>
	 <1342161072.7380.65.camel@marge.simpson.net>
	 <alpine.LFD.2.02.1207131142440.32033@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1207131142440.32033@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2012-07-13 at 11:52 +0200, Thomas Gleixner wrote: 
> On Fri, 13 Jul 2012, Mike Galbraith wrote:
> > On Thu, 2012-07-12 at 15:31 +0200, Thomas Gleixner wrote: 
> > > Bingo, that makes it more likely that this is caused by copying w/o
> > > initializing the lock and then freeing the original structure.
> > > 
> > > A quick check for memcpy finds that __btrfs_close_devices() does a
> > > memcpy of btrfs_device structs w/o initializing the lock in the new
> > > copy, but I have no idea whether that's the place we are looking for.
> > 
> > Thanks a bunch Thomas.  I doubt I would have ever figured out that lala
> > land resulted from _copying_ a lock.  That's one I won't be forgetting
> > any time soon.  Box not only survived a few thousand xfstests 006 runs,
> > dbench seemed disinterested in deadlocking virgin 3.0-rt.
> 
> Cute. It think that the lock copying caused the deadlock problem as
> the list pointed to the wrong place, so we might have ended up with
> following down the wrong chain when walking the list as long as the
> original struct was not freed. That beast is freed under RCU so there
> could be a rcu read side critical section fiddling with the old lock
> and cause utter confusion.

Virgin 3.0-rt appears to really be solid.  But then it doesn't have
pesky rwlocks.

> /me goes and writes a nastigram^W proper changelog
> 
> > btrfs still locks up in my enterprise kernel, so I suppose I had better
> > plug your fix into 3.4-rt and see what happens, and go beat hell out of
> > virgin 3.0-rt again to be sure box really really survives dbench.
> 
> A test against 3.4-rt sans enterprise mess might be nice as well.

Enterprise is 3.0-stable with um 555 btrfs patches (oh dear).

Virgin 3.4-rt and 3.2-rt deadlock gripe.  Enterprise doesn't gripe, but
deadlocks, so I have another adventure in my future even if I figure out
wth to do about rwlocks.

-Mike
