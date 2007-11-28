From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: rt mutex priority boost
Date: Wed, 28 Nov 2007 16:26:51 -0700
Message-ID: <1196292411.4078.253.camel@hermosa.morrealenet>
References: <1196257876.4078.195.camel@hermosa.morrealenet>
	 <Pine.LNX.4.58.0711281642170.2846@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:58232 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681AbXK1XcL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 18:32:11 -0500
In-Reply-To: <Pine.LNX.4.58.0711281642170.2846@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-11-28 at 16:49 -0500, Steven Rostedt wrote:
> On Wed, 28 Nov 2007, Peter W. Morreale wrote:
> 
> > Steve,
> 
> Hi Peter,
> 
> I don't always read mailing lists every day, so if you want a quicker
> response from me, it's best to CC me.
> 

Will do.  didn't want to flood your mailbox, if that was the case... :-)

..
> 
> As was explained by Luis(sp? my fonts dont display that "i" part) you can
> be boosted multiple times and unboosted once.
> 
> >
> > My expectation would be that all three counters would be more or less
> > the same.  Further, that we would only boost non-RT tasks in contention
> > with an RT task.  Is that a wrong assumption?  The code seems to imply
> > that we boost anyone.
> 
> Yes, we boost everyone!
> 
> IIRC, Ingo, Thomas, myself et al had a discussion about this. I think it
> came down to boosting non-rt tasks would help normal scheduling as well.
> That is, boosting lower tasks to help higher non-rt tasks can increase
> reaction times for nice desktop user experiences.
> 


Hummm... see below...

> 
> Well, make does do a lot af IO and syscalls. Accessing the hard drive.
> This in turn will kick off interrupts and softirqs. Which will all contend
> for spinlocks, and since they are all working together, expect a lot of
> contention.
> 
> -- Steve
> 

It does, and that was the point.  

Switching gears here a little bit...

The real problem I see is under a moderate 'dbench' load (No laughing,
you want VFS contention, use dbench :-) I can easily bump the cs/s
(context-switch/sec) rate to 380k/s.   

This on a ramfs (no disk involved) partition.  The bad part is that
top(1) reports 50-60% idle CPU time.  Which implies that 2 of my 4
x86_64 intels are spinning while there is work to do.  

As an early experiment, I converted the dcache, inode, and vfsmount
spins to raw, and performance jumped by 4x.  (I realized later that
dbench does alot of record locking and was still hammered by the BKL,
otherwise I suspect it would have been significantly greater...)  This
also reduced the cs/s rate to below 100k/s (from the high of ~380k/s)

It seems clear that a single point of contention (e.g: the dcache lock
in the above workload) greatly impacts the throughput of the hardware
platform.  There are similar points of contention with dev->_xmit_lock,
and queue_lock in the networking stack.   

Obviously, this is an issue for real-world apps.  Those pesky thingies
think they need data from various sources to do stuff.  That was humor. 

At the risk of being chastised, is (or has) this any discussion on this
been taking place?  

Thx,
-PWM






> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
